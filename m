Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C543F1C83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhHSPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhHSPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5787EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vKpJrX+WIWY9oRj8Y9x18hpmhdn4wB2b3WzzcTX0gC0=; b=iRnWocda0X8g3D+NKPaswqcI3j
        WHn9NnZZ4CgorMeNqTGgkR39y1RLlpH6elLst6kb1Hb63uTM4WJCgMHpSiKssszjISMZLwPSl8FZp
        7X/7yTHNZIz8F5UJtxtiqV3eAIwt8BBQCuFshxRXSxWoKXCikVe6+sLM9US/Y0/T2aR0keQtK3cav
        K7XtIguJo/UwAQPO3dvSm4hCo/l+CARRf8Pgwm+s+KJqCY5AxMbCcKL1e/v6+Dg3Xe+z4ZiR+Q3Jq
        A4bO+zVI3W0fHz1z/UmbS+9eJggicY+FoVtmteGUtZbIfQRDZ8iG+iGANLfKuVTw1F30JazeNM0bj
        WPnqIjqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGjpV-005F79-5t; Thu, 19 Aug 2021 15:19:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 942043004B2;
        Thu, 19 Aug 2021 17:19:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B42820242605; Thu, 19 Aug 2021 17:19:38 +0200 (CEST)
Date:   Thu, 19 Aug 2021 17:19:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bp@alien8.de,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:06:45PM +0200, Peter Zijlstra wrote:
> > 
> >   * We can implement (1) by checking if we hit zero (ZF=1)
> >   * We can implement (2) by checking if the new value is < 0 (SF=1).
> >     We then need to catch the case where the old value was < 0 but the
> >     new value is 0. I think this is (SF=0 && OF=1).
> > 
> > So maybe the second check is actually SF != OF? I could benefit from some
> > x86 expertise here, but hopefully you get the idea.
> 
> Right, so the first condition is ZF=1, we hit zero.
> The second condition is SF=1, the result is negative.
> 
> I'm not sure we need OF, if we hit that condition we've already lost.
> But it's easy enough to add I suppose.

If we can skip the OF... we can do something like this:

static inline bool refcount_dec_and_test(refcount_t *r)
{
	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
			   "jz %l[cc_zero]\n\t"
			   "jns 1f\n\t"
			   "ud1 %[var], %%ebx\n\t"
			   "1:"
			   : : [var] "m" (r->refs.counter)
			   : "memory" : cc_zero);

	return false;

cc_zero:
	smp_acquire__after_ctrl_dep();
	return true;
}

where we encode the whole refcount_warn_saturate() thing into UD1. The
first argument is @r and the second argument the REFCOUNT_* thing
encoded in register space.

It would mean adding something 'clever' to the #UD handler that decodes
the trapping instruction and extracts these arguments, but this is the
smallest I could get it.
