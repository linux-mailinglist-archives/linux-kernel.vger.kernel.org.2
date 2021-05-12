Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0674E37B843
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhELIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhELIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:46:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7573C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6myQBMYr+lV/pUSbf6VMLnG+VJOyuR3gQfNwK3mhNjA=; b=ABuHr/AK5DK/jQkP5+fbPmE04W
        t/npqePoFzVnpCLW6DC0hTDVvuIj8g4VKAnrTyy/yIY7AbD/0YDk5BLqtTj7QmzuqERLcK7WGmGZa
        QF1MRsHL/x7+1/4u7AHhPSUrlfnUy/2BlLQGpwuhXBv3ebyDWAxhSPxzw2b6/bfHkmbn48u5vS7s8
        Du+YGnwwiL58KSqUj30TZ00uFuUYdIPaoDa2/KA/0NCXdHwTM5Bqji0MrCWiWqEmrt2/XMW1OJyli
        XRgyzs7hOEhvCxvltBXcyDGB2xDdidFizuT+/oX1pp5pGEdJtxYEGiNnkm03kGwXFssSmLkHBVSgc
        xybavnhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgkUA-002LvO-W1; Wed, 12 May 2021 08:44:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DBE7300242;
        Wed, 12 May 2021 10:44:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFD0020829FA3; Wed, 12 May 2021 10:44:53 +0200 (CEST)
Date:   Wed, 12 May 2021 10:44:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de, tglx@linutronix.de,
        shung-hsi.yu@suse.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2] seqlock,lockdep: Only check for preemption_disabled
 in non-rt
Message-ID: <YJuVhR9C6pUmZBOs@hirez.programming.kicks-ass.net>
References: <20210507233951.78950-1-dave@stgolabs.net>
 <20210507234713.86097-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507234713.86097-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 04:47:13PM -0700, Davidlohr Bueso wrote:
> This silences the writer hitting this nonsensical warning on PREEMPT_RT.
> 
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> 
> v2: Resending because I had left out some small comments I had meant to add.
> 
>  include/linux/seqlock.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index f61e34fbaaea..2ce3e1efc9a9 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -268,7 +268,9 @@ static inline bool __seqprop_preemptible(const seqcount_t *s)
>  
>  static inline void __seqprop_assert(const seqcount_t *s)
>  {
> +#ifndef CONFIG_PREEMPT_RT
>  	lockdep_assert_preemption_disabled();
> +#endif
>  }
>  
>  #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> @@ -529,6 +531,8 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
>   * only if the seqcount write serialization lock is associated, and
>   * preemptible.  If readers can be invoked from hardirq or softirq
>   * context, interrupts or bottom halves must be respectively disabled.
> + * The PREEMPT_RT case relies on the reader serializing via LOCK+UNLOCK,
> + * so the context is preemptible.
>   */

I'm confused, and the Changelog is useless. The code you actually
changed is for seqcount_t, which doesn't have an associated LOCK. If
there is a lock, the code should be changed to use the appropriate
seqcount_LOCKNAME_t and the assertion will change into the one found in
__seqprop_##lockname##_assert(), namely:

  lockdep_assert_held(lockmember)


But as is, seqcount_t usage relies on being non-preemptible, even for
PREEMPT_RT, and this is a good thing. Please describe the site that goes
boom and explain things..
