Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C433E403A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhIHNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhIHNaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:14 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A130C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:07 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x5so2314243ill.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UZon1PexiuAqnoGAx/YovVm5FTCLjCK9W9VSCqfLDoc=;
        b=Bz156U5Bge4agLazjVmoP4E7f0eI/M0VhXa6DRSuun2bR7xGB3mu0c1nDxpjkcTT+/
         sqRXKRIsYkbuv7QNJvAnZkoFZrvC++NFVq3xIiUsOinDETvggmwCFF2TmdywVVcVg23s
         Gl6/3Y2Rp+wsrRDj3oVLnaj9QJya1/yBNI7RIYpidd0EqVHINJ9buEl9++vDMAJO5FGO
         oG+mzqJEWEMXQ1jevV9m0Gbzt+UGfRE0BjTepjANSqcqYWfETvm7kmocwOwT0Z+LB3dC
         b8A8V5X2avxsX45x824lbIEcGweJ+77ai2ovHucltw+Hr598+1xH3O/0q/VYwvMEAdYC
         NQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZon1PexiuAqnoGAx/YovVm5FTCLjCK9W9VSCqfLDoc=;
        b=F1gpob/LOHXThbj4YcB61752V5GgNATqXdEbmg2IpM9cqj8dtBNP5OeqFUSgG+Z64g
         X71eOeVxSVBRrKXCrMV5ZF8vcrC0vcJadi87/7xbRyBchGMrsGbjFLbqfeYK92jrIqLi
         4iIa1jLe8xiuudCO2Ngabk+sjGMZMbAjG2r465yvern3UvY+HBwZcRDe0M/magfMv2/0
         96EZEvZahtUynZQuEslz0GmKIUR07H4sH3u1VN45Tsa0+maW+zzbne7KE8G1O75/ZQ0T
         Oije+gEkdgLPnTKkG0aWHS4YNbSZ73zCu0Tz0k3QjTLtnTc/WuN3WQWkzogmrhGwWbjN
         Cocg==
X-Gm-Message-State: AOAM530GEAtsuEwAyE1AslepHKSUYlZLTlHLjI9XwqHmdU++cj/9A7F/
        J8+7eK1chZsyp8m1k+acWo8=
X-Google-Smtp-Source: ABdhPJyiTdK1f2NXTp10PhVbJfkFE5atXpkQiwRwkhFkxGBpEYkOZzIXPmHH8OXHp3P9bOqZgD5RXg==
X-Received: by 2002:a92:cb4b:: with SMTP id f11mr2923245ilq.189.1631107746416;
        Wed, 08 Sep 2021 06:29:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z16sm1126874ile.72.2021.09.08.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:29:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id EA32B27C0054;
        Wed,  8 Sep 2021 09:29:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Sep 2021 09:29:04 -0400
X-ME-Sender: <xms:n7o4YUJdphQk0kNygx7EgTVkY5OjpAxZTmf2PHnGZUI7K1tDqpKixg>
    <xme:n7o4YUIdbb833382rjfujz1BTJQ9_aG5O8QM2AqdwNmwm6T-1GVzK_YvggBoDsBJG
    9k240yTvTQKlMtlYw>
X-ME-Received: <xmr:n7o4YUsZ97UVtbF45taTINNDVAJTp7oVPJ_aLCUmXXeX9Df1hqI3FA0-ltM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:n7o4YRaT9hrZmcSYPKFvmdQGTPoF2Wzwso74Vyaw-aP7AIoRz-YePA>
    <xmx:n7o4YbYoruvim9x_kS1fgUVmmfMk9stifl0YGU1oZlax6wNSzjpwhQ>
    <xmx:n7o4YdB1aa67byj59hBhRGtzm9nrbiX96k39zcac4QW_pub-TU10jQ>
    <xmx:oLo4YZCciLxZiGmIz0WzCLZ_4LeLF5Q6dAiQnCEMz5d6zb0cj2W4UXCxDQc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 09:29:03 -0400 (EDT)
Date:   Wed, 8 Sep 2021 21:27:35 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <YTi6R1SqNeX8mDfd@boqun-archlinux>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 01:51:24PM +0200, Peter Zijlstra wrote:
[...]
> @@ -201,23 +207,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  	unsigned long flags;
> +	int readers;
>  
>  	/* Take the rtmutex as a first step */
>  	if (rwbase_rtmutex_lock_state(rtm, state))
>  		return -EINTR;
>  
>  	/* Force readers into slow path */
> -	atomic_sub(READER_BIAS, &rwb->readers);
> +	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
>  
> -	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  	/*
>  	 * set_current_state() for rw_semaphore
>  	 * current_save_and_set_rtlock_wait_state() for rwlock
>  	 */
>  	rwbase_set_and_save_current_state(state);
> +	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  
> -	/* Block until all readers have left the critical section. */
> -	for (; atomic_read(&rwb->readers);) {
> +	/*
> +	 * Block until all readers have left the critical section.
> +	 *
> +	 * In the case of !readers, the above implies TSO ordering
> +	 * at the very least and hence provides ACQUIRE vs the earlier
> +	 * atomic_sub_return_relaxed().
> +	 */
> +	while (readers) {
>  		/* Optimized out for rwlocks */
>  		if (rwbase_signal_pending_state(state, current)) {
>  			__set_current_state(TASK_RUNNING);
> @@ -230,8 +243,12 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		 * Schedule and wait for the readers to leave the critical
>  		 * section. The last reader leaving it wakes the waiter.
>  		 */
> -		if (atomic_read(&rwb->readers) != 0)
> +		readers = atomic_read(&rwb->readers);
> +		if (readers != 0)
>  			rwbase_schedule();
> +		/*
> +		 * Implies smp_mb() and provides ACQUIRE for the !readers case.
> +		 */

->readers may get changed to non-zero here, because ->wait_lock is not
held by the writer, and there could be readers in slow-path running.
We need to re-read ->readers after holding ->wait_lock. Otherwise, we
may use an old value of ->readers, and grab a write lock while there
still exists readers.

Regards,
Boqun

>  		set_current_state(state);
>  		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  	}
[...]
