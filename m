Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B440011D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbhICORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhICORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:17:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCECC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:16:22 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h29so5361614ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHBGodzqUQnBPvEI1YqR03qxQi9kX2bfYMigp+1FVYI=;
        b=NI0ioB4QSRNtd06thpSelbY/Q/kgAGzKpzo368k60CWX+1kmlyufBG2OjNkjGHUll5
         3Og41LIITW1OVnxoC12bDrsfSq/ZB8b7L6F3xCxUSh/7dSvPJNVp1zatb2JOuIj1zrLw
         vG4sPYCE3Fg1wj1cOw71lGkl3Oz1qnIE/iPGtvIO0ebVjP+/nl85jtlWGA5QMxJBkSjw
         t27I12W1WLFIPJkvfCntTyPOrwvopjChNUQz0mplov2Vh8vLEXK6y8CdEh5wSt94XEXc
         MHGCTVw8Ep1mRalg/XGyFKKzcRkmAJF/UX3mYuyx8RTpBbEv1QfKVWQa3Y+AXIisVp4q
         feNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHBGodzqUQnBPvEI1YqR03qxQi9kX2bfYMigp+1FVYI=;
        b=iy39kxZxVHHuzy5tkFPOBuvP/8HudWztvl3YcpBpPbw/9ghYJR9Kxe6FfjSYJaUcnD
         6Nb3ceUp+ou89TZtFLw4ahyUJi7Pup+jXtKVw2z4W43mgUGFaVMtQZ1LnpBv8L8rH1mj
         sTg+wjr2ZUZ1H9GyGxMbl1HOJuS4qPDiX1hRA1cEVpE7g/ZRkgwEraqD3xTntFmHB+K/
         qWlmjR6ANp/I7lphZJPqyTsVbg662hfD+Yfb86ugho/ALFawwIX8aGzmWMufZu+SehK/
         gdr+AyMp8lDUl5oKJ+m0ySdid/AyeaCvWmCnyjat59Zo/ERiV/VFcUtkG9rBVE9DWCN9
         nxFw==
X-Gm-Message-State: AOAM533EjmJ/T/nIYHXhDjXY/Gt5LGfRYa0e0Wxcb//vkG6pcfht3US0
        xsmnuI86MOyko8GV1QxkPSk=
X-Google-Smtp-Source: ABdhPJwYDFWa5jkVd73leBCAMaUhB7ueSpiXjHOF/N+PT0wbsrJDzUD7hanTB02uW8wvsyy+jriQpw==
X-Received: by 2002:a05:6e02:1c08:: with SMTP id l8mr2744568ilh.134.1630678581968;
        Fri, 03 Sep 2021 07:16:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x13sm2860529ilq.18.2021.09.03.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:16:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E93B027C0054;
        Fri,  3 Sep 2021 10:16:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 Sep 2021 10:16:19 -0400
X-ME-Sender: <xms:My4yYctxHEm-1VGPW7xZteVlrQQjfSd_0LT24AFZzBgKz5ZCqXYpjw>
    <xme:My4yYZfxcuisqtzU7rvr3BRACplBRgHpaOid-bMn8tSkiSCxu6qpZC_Zlo5fvrfCQ
    BaQQHSgdARgdI3hiw>
X-ME-Received: <xmr:My4yYXzfkt6A8BkkIMktsNvgoPl81TOMwLsNB7eKrHeWv_bkeAAJ7cTKZvg84A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:My4yYfP7hYwM50qJk5MSHdMzZQjpT87mDvB2pkJ0ERO_1iYsr6TfFA>
    <xmx:My4yYc9csG8ylvmkaB3pH_t6KdXSVjT3dvh7zX2F_hRTCRjvdhBWPw>
    <xmx:My4yYXUaNJOU3k0eD_tjwC5X6L8dDGLJIikPPgSUg2gRa5iraR8q-w>
    <xmx:My4yYczfhSSycmxlCdyQSNGI7dp40wsU4CbL0voxmpLDREQy72KNuQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 10:16:18 -0400 (EDT)
Date:   Fri, 3 Sep 2021 22:15:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: Let lock_is_held_type() detect recursive read
 as read
Message-ID: <YTIt6KIjz5gTbZif@boqun-archlinux>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <YS+twcAQ9uivowDS@boqun-archlinux>
 <20210903104557.rqss65jn4ozoptcj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903104557.rqss65jn4ozoptcj@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 12:45:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-02 00:43:45 [+0800], Boqun Feng wrote:
> > If a reader is recursive, then a pending writer doesn't block the
> > recursive reader, otherwise, a pending write blocks the reader. IOW, a
> > pending writer blocks non-recursive readers but not recursive readers.
> 
> Puh. So I would describe it as writer fair but maybe I'm not fluent in
> locking. But you don't mean recursive reader as in 
> 
>    T1			T2
>    read_lock(a);
> 			write_lock(a);
>    read_lock(a);
> 
> which results in a deadlock (but T1 recursively acquired the `a' lock). 
> 
> However, PREEMPT_RT's locking implementation always blocks further
> reader from entering locked section once a writer is pending so that
> would then ask for something like this:
> 

But the rwlock in PREEMPT_RT is writer unfair, isn't it? As per:

	https://lore.kernel.org/lkml/20210815211302.957920571@linutronix.de/

also in __rwbase_read_lock():

	/*
	 * Allow readers, as long as the writer has not completely
	 * acquired the semaphore for write.
	 */
	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
		atomic_inc(&rwb->readers);
		raw_spin_unlock_irq(&rtm->wait_lock);
		return 0;
	}

that means the readers of rwlock in PREEMPT_RT are always recursive,
right? Am I missing something subtle?

Regards,
Boqun

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5572,16 +5572,19 @@ static bool lockdep_nmi(void)
>  }
>  
>  /*
> - * read_lock() is recursive if:
> - * 1. We force lockdep think this way in selftests or
> - * 2. The implementation is not queued read/write lock or
> - * 3. The locker is at an in_interrupt() context.
> + * read_lock() is recursive if the implementation allows readers to enter the
> + * locked section even if a writer is pending. This is case if:
> + * - We force lockdep think this way in selftests
> + * - The implementation is queued read/write lock and the locker is in
> + *   in_interrupt() context.
> + * - Non queued read/write implementation allow it unconditionally.
> + * - PREEMPT_RT's implementation never allows it.
>   */
>  bool read_lock_is_recursive(void)
>  {
>  	return force_read_lock_recursive ||
> -	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
> -	       in_interrupt();
> +	       (IS_ENABLED(CONFIG_QUEUED_RWLOCKS) && in_interrupt()) ||
> +	       !IS_ENABLED(CONFIG_PREEMPT_RT);
>  }
>  EXPORT_SYMBOL_GPL(read_lock_is_recursive);
>  
> Sebastian
