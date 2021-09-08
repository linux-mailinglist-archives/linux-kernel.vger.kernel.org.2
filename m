Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F66F403A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbhIHNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhIHNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:11:32 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0172C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:10:23 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z2so2391805iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzJ9eKQ/myUbNaLBbfRbOXpOoTfzAwm+YkiwW5sHVTc=;
        b=lxAwaoqnnquOUKXRVvuA00G0Hnwt0byFDzuJtwPtJtPv10DvTDFKx6V33V3fi52JU5
         YHlldH0o2pZ036zai/nXhC+Vp2lYJWGOjqIydEpHoF7Ij1LVeOfYPSg6+S3Yh2e7p5zk
         SDBxnlyq/OfXJ2MsVgkSNIA8vg1HMGpa0qOSi1HEgpYjXyvmluR9qi6vp6nmSeEI4z2O
         T/xQ9SknUmKXmG3q+ksAij6f298J3kA1xtaT8rnJBg50JGxYptwVV7RaNx90E9WiW6zz
         xNoGIUzBSVr8xiGXo/wh/A7+9mucBRjcW2FGft9sSmgh24g1dY3n0QE7kr3ZP2MrYdIa
         z2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzJ9eKQ/myUbNaLBbfRbOXpOoTfzAwm+YkiwW5sHVTc=;
        b=2vO02sxoL/bqGtkgIaLT2maoFvnh/NGXKkx2rk3zGIMs3/xlJehuZ42aLI6D4iuH3O
         1sEdQtFctj1aF2RmGIckO/XY07tf2ngqxju/Ooe1XrIMaEwq8YuOooE/EAWIKjaF/mDm
         TqDZx/wJDKBDXCrioPZyHHRpFLyUpLv1xzVTeXHCnEDBhlNTHBNiSqVc1GnbxqMpmbK6
         sfEaumYCk2sJzDedaIw08NfBrhPWAvKKGwhk3jB2I4FwZz6tqtl7p0RzcpTbvbhlgopU
         GcqWyLb4Qy076wowA1PMkoPUZ++R703OS7dkkQ8UDwiZq02n246NZxRrYiS+HxN6sML3
         IQMg==
X-Gm-Message-State: AOAM533Bs1ifihugyza6LGLnOEIsNggrgTgKfpWEOxDZieXW9q8LjBdl
        DxLjEa2NLvlN+54xWbuGQVnc+tFvZhLLrw==
X-Google-Smtp-Source: ABdhPJyVODVJO1qsDyHRYJtb7HkI59Jvn7FRwKKeXp2I00Y7o4ahaCid0HohmfoB2clZ1+ZiHiYrfg==
X-Received: by 2002:a92:6802:: with SMTP id d2mr2763479ilc.40.1631106623354;
        Wed, 08 Sep 2021 06:10:23 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a17sm1096964ilp.75.2021.09.08.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:10:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id EA36C27C0054;
        Wed,  8 Sep 2021 09:10:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Sep 2021 09:10:21 -0400
X-ME-Sender: <xms:PbY4YRROMshxExv3iLaIBHf2b5rNbuln-gMi2YThEG459dOPhf0pQw>
    <xme:PbY4YaxS9wlAYzh_iRRd7HKSbkQNeIqy03SNpBr4LK3nosLq2ksnmI79119XBcz-F
    HWOVkASF-Ikx9AznQ>
X-ME-Received: <xmr:PbY4YW0ThciDVk9ToBzCr9RnsnId0kP4IyWZfWseIU8n0tlcJaSjfLRBaIK1JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PbY4YZCffKO5qmzXbCxO89YtfR-INrjWBZAON5Pds3RCIZpF_6R5tw>
    <xmx:PbY4YagUb8jyi8X85beEGtUDdIM9MN6-Wk_N3swMRjJ5CcPMtyqp9Q>
    <xmx:PbY4YdpXoV94SwdKUUX8l-XDU7ylVVVALipIux0FgqIkMM5949N_Dg>
    <xmx:PbY4YRoVBVgZtB4YT6OhsQWmKNZWCSgcUGldFlTSQDzbkpmtrQUtr5VXcCo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 09:10:20 -0400 (EDT)
Date:   Wed, 8 Sep 2021 21:08:52 +0800
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
Message-ID: <YTi15PNcExiJRZoa@boqun-archlinux>
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

rwbase_set_and_save_current_state() may eventually call
current_save_and_set_rtlock_wait_state(), which requires being called
with irq-off, while rwbase_write_lock() may be called with irq-on. I
guess we can change the raw_spin_lock() to raw_spin_lock_irqsave() in
current_save_and_set_rtlock_wait_state() to solve this.

Regards,
Boqun

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
[...]
