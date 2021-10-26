Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EB43A9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhJZBiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhJZBiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:38:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+8di00+Tplg8eRJpLLNj0aaGgJcmrPNm4/bOBU/fBh4=; b=MZkVxrFIbgtxGDx2ehqwHCqMfA
        p5JCYrIfEqMQ83vkTJyVX+AcWTc6j0lgPDaAPYKTdND02ubnmxCidxMHtCyuNxIemxoDIPelZMHec
        IkfEP3LP6rToSk2pgmKz9cdhRzv4nAnuEpXQcNjkAIvxRJKGLhCPKF1DZCnPEd0WdLFYQBeb+FhTn
        ibk+9LAjgpOv+NJlT0SFmr+c3xUWm3bkZVOm2SeiyKzLYdu+2iykA1hBM4FIwFCOEGgD5BWFb5q1b
        zeYsqg2SxFtCKf1IpUDTcM5A6BJmya+YK0ocJ/3tFDhMGbrmgErK1KB3E3pX241cov4rFG7NT9T6s
        IQtB/FEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfBM6-00GYwf-9v; Tue, 26 Oct 2021 01:34:30 +0000
Date:   Tue, 26 Oct 2021 02:34:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <YXdbHlyX+ngOUdPk@casper.infradead.org>
References: <20211025181634.3889666-1-willy@infradead.org>
 <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org>
 <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
 <202110251438.1762406A5@keescook>
 <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:37:01PM -0700, Linus Torvalds wrote:
> For example, traditionally, on x86, with atomic counting there are
> three special situations: negative, 0 and positive. So if you use the
> traditional x86 counting atomics (just add/sub/inc/dec, no xadd) then
> there are situations where you can get more information about the
> result in %eflags if you don't use zero as the initial value, but -1.
> 
> Because then you can do "inc", and if ZF is set, you know you were the
> _first_ person to increment it. And when you use "dec", and SF is set
> afterwards, you know you are the _last_ person to decrement it.
> 
> That was useful when things like "xadd" weren't available, and cmpxchg
> loops are expensive. So we used to have counters where -1 was that
> "zero point". Very similar to your "1 is the zero point".
> 
> But was it _logical_? No. It was an implementation trick. I think
> we've removed all those cases because it was so subtle and confusing
> (but maybe we still have it somewhere - I did not check).

We still do it for page->_mapcount; it's biased to -1 so that both
"the page has exactly one mapping" and "the page has no mapping" are
cheaply checkable conditions.

But, as you say, that's invisible to the users.  page_mapcount() is
return atomic_read(&page->_mapcount) + 1;
