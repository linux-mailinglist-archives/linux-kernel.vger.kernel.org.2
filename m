Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01C403A32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbhIHNDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHNDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:03:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:01:56 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id x5so2217393ill.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/8klykk1WqWHtjbyPT4tpgjxueTqwuymObIzoS6SCg=;
        b=fF9sFYvHXa9jWd6h3LUTg/X3sxNOUa+xfDBQUMwrI++bUnZI9r0o6cBCa9nhAXocTL
         CvCiArFVl0FG4s2AMUgu3lisRxDo0gFRdE9oGk5eZBm6MREkWr9EAeNCaLhHQCQCKRmd
         +GitKyG1maCcV9LdNZiOx1g9wywbTKG0nt8Nj3LUJP/F99BRR+8xPenvc0hKhXm1UKM3
         B/WyfraZAH2r47lKJfIZ57DMeCTC9AhFMEUFkfwNJ1DrunasXIfi+3ETFteqPw4VUaes
         KoO2W78Z7jXL0S6bbGLqXgyFT60isoG+l0r8/SqQIuEaFUAX6x0cunrvSgmFOgRFu4N+
         tH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/8klykk1WqWHtjbyPT4tpgjxueTqwuymObIzoS6SCg=;
        b=k8JtGZqWfz+D7TJU0Lz+Mp59c0Au4nGSvSnO4PYBSJAYpxOxBv/wYOG8dw0hIf7z4z
         3qpFB903u4rn4NRtr0WZkQbBDOb/TvA4QpqkP53C5L63TPMIaVbQKiOvouHP5bMARE7m
         cMlTNm/AoOQEXsc6l5apQy5mFhfX4TztRDpJXZe5xqLOCFeP6OmrxLWKWKqc80O4HzMQ
         dajwH0MVZoJWsSt9sNKARbKuL4zujTMGUkYDs4P4GCFXF0mss86zqoQcZWKApKo/EfWr
         MqN3bBlXVimSUEnuge6xvMCX+vraZfMfsFf+mnHCLyMMgGeLYL/NObjtZH8vcnIujCbw
         mUWA==
X-Gm-Message-State: AOAM5304atJb/lU3uqeFjoj61UKmy3E3XAyB9LFNr04uVPhw2XvAa5js
        cLJCfNJyiH1u46FgnqgLBGg=
X-Google-Smtp-Source: ABdhPJx66hnvYGwbld9TDa25g5xl+JcgRTV0gffrg0L0/TdMzrZOdkG3fd4onTtXq/BhqRv7bjRGvw==
X-Received: by 2002:a92:d388:: with SMTP id o8mr2761299ilo.110.1631106115527;
        Wed, 08 Sep 2021 06:01:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j10sm1025661ilk.84.2021.09.08.06.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:01:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 172B827C0054;
        Wed,  8 Sep 2021 09:01:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Sep 2021 09:01:54 -0400
X-ME-Sender: <xms:P7Q4YdhPHiRML9Q_0RaRfalx2mtbiMzQjcpTC5_7b3YewkTFN6Hs_w>
    <xme:P7Q4YSArus-HFiiOFdsejxysa88-TUteS38tjrHdi_enaLya56Tv_iB56iFtOAHOR
    gLaNGFKnZCrZCzLUw>
X-ME-Received: <xmr:P7Q4YdF04y3ZWYGDq4x8PqhswKODYj1yTVAimKELvKoNGv0TjKOxqRo4DISM3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:P7Q4YSTvWxgq9WYYLKG9j5XhQ4DifPvQusGySGYJm8AsZprf0Tb1dA>
    <xmx:P7Q4YazucuFCLIw7rn1yHgTfl2gNzXC6ygkphB9A10WD2KI65MTFCQ>
    <xmx:P7Q4YY7D1O9wJi3WgWJ6NfpFs93FOS_XKtAyODYA-W5Ulljdjpifxw>
    <xmx:QbQ4Yc7VeqkYxUzWpT_DIUNAiiTdYnP8bA1EykiEfLFI2_Zew_lP3jxBjsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 09:01:51 -0400 (EDT)
Date:   Wed, 8 Sep 2021 21:00:22 +0800
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
Message-ID: <YTiz5i3Kxuhv4w4X@boqun-archlinux>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
 <YTipJJcjU57l7Mju@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTipJJcjU57l7Mju@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 02:14:28PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 08, 2021 at 01:51:24PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 01, 2021 at 11:06:27PM +0800, Boqun Feng wrote:
> > @@ -201,23 +207,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  {
> >  	struct rt_mutex_base *rtm = &rwb->rtmutex;
> >  	unsigned long flags;
> > +	int readers;
> >  
> >  	/* Take the rtmutex as a first step */
> >  	if (rwbase_rtmutex_lock_state(rtm, state))
> >  		return -EINTR;
> >  
> >  	/* Force readers into slow path */
> > -	atomic_sub(READER_BIAS, &rwb->readers);
> > +	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
> 
> Hurmph... the above really begs for something like
> 
> 	if (!readers)
> 		return 0;
> 


I don't think we can return early here, don't we need to set WRITER_BIAS
to grab the write lock? And we can only do that with ->wait_lock held,
otherwise we race with the slowpath of readers.

Regards,
Boqun

> But then we needs that _acquire() thing again :/
> 
