Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F373F1A46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhHSNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239990AbhHSNWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:22:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9114D6108F;
        Thu, 19 Aug 2021 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629379298;
        bh=PkpTsJt7pyHtfJ1gyD/LaaCvVbcW8fH7saHC271sUdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/38zcOUspTE5hna0KVWPiy+4K78IMj5xykRT/ye+MXCFMBLZFpcpXBwcdVdYa95t
         gzYXVxDeWhs6TETU/f/vP45/hIAnMJ+a9ycHKtaWDPnYSC9bRglvRe0GSSedLWLdql
         IZljRIZZwwWMjNtvvcusfzYXQavc9QDj0rEVUsMq81iJsyyLPxgNuzWPG+5LqKh4Of
         3/LclWqgwqVF2mRG+1x8IToAjb6ZDsdy6RWe7sda/TvbY1dlC3Dy2suBH1khLr5gnu
         VA37+pOzMxIsDtjfM0xRDRAf+OO1+AAcToLsT5lOa/MQW/LiD3IXQqUokg9U+DbSyg
         Bfu2u8skPTYtg==
Date:   Thu, 19 Aug 2021 14:21:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
        bp@alien8.de
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <20210819132131.GA15779@willie-the-truck>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Peter and Boris]

Sorry for not responding sooner; I looked at this and couldn't see a way
to improve it at first, but then I had an idea the other day.

On Tue, Jul 20, 2021 at 04:01:27PM -0700, Andrew Morton wrote:
> On Mon, 19 Jul 2021 11:23:35 +0800 Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
> 
> > refcount_t type and corresponding API can protect refcounters from
> > accidental underflow and overflow and further use-after-free situations.
> 
> Grumble.
> 
> For x86_64 defconfig this takes rmap.o text size from 13226 bytes to
> 13622.
> 
> For x86_64 allmodconfig this takes rmap.o text size from 66576 bytes to
> 67858.
> 
> I didn't check which config option is making the bloat so much worse,
> but this really is quite bad.  We bust a gut to make savings which are
> 1% the size of this!  Is the refcount_t really so much better than a
> bare atomic_t that this impact is justified?

I think so: the saturation semantics have been shown to mitigate attacks
that rely on over/underflow so it's a good security feature. On top of
that, the memory ordering is what you'd expect so you don't have to worry
about adding (or missing) the necessary barriers -- there's more info about
that in Documentation/core-api/refcount-vs-atomic.rst.

> Can someone pleeeeeeze take a look at what is happening here and put
> the refcount code on a very serious diet?

I suppose the sanitisers might contribute a fair bit to the cmpxchg() loops
in the allmodconfig case, but looking at how defconfig affects mm/rmap.o the
*big* difference there seems to be due to the dec_and_test() operation:

atomic_dec_and_test() looks like:

	lock decl (%rdi)
	sete   %al
	retq

whereas refcount_dec_and_test() looks like:

	push   %r12
	mov    $0xffffffff,%eax
	lock xadd %eax,(%rdi)
	cmp    $0x1,%eax
	je     97d
	xor    %r12d,%r12d
	test   %eax,%eax
	jle    989
	mov    %r12d,%eax
	pop    %r12
	retq
	mov    $0x1,%r12d
	mov    %r12d,%eax
	pop    %r12
	retq
	mov    $0x3,%esi
	callq  993
	mov    %r12d,%eax
	pop    %r12
	retq

which is a monster by comparison!

This is because refcount_dec_and_test() wraps __refcount_sub_and_test(),
which is necessary so that we can look at the old value:

  (1) If it was equal to 1, then ensure we have acquire semantics and
      return true.

  (2) If it was < 0 or the new value written is < 0, then saturate (UAF)

However, talking to Peter and Boris, we may be able to achieve the same
thing by looking at the flags after a DECL instruction:

  * We can implement (1) by checking if we hit zero (ZF=1)
  * We can implement (2) by checking if the new value is < 0 (SF=1).
    We then need to catch the case where the old value was < 0 but the
    new value is 0. I think this is (SF=0 && OF=1).

So maybe the second check is actually SF != OF? I could benefit from some
x86 expertise here, but hopefully you get the idea.

We could do something similar for refcount_dec() and refcount_inc(),
although commit a435b9a14356 ("locking/refcount: Provide __refcount API
to obtain the old value") add versions which return the old value,
which we can't reconstruct from the flags. Since nobody is using these
variants, I suggest we remove them.

The other thing we could do is to inline the saturation logic and allow
the WARN_ONCE() to be disabled with a Kconfig option, but I'm not sure
that the gain is really worth it considering that you lose the useful
diagnostic (and silent saturation is likely to be very confusing if it
manifests as a crash somewhere else).

Thoughts?

Will
