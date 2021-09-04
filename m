Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F5400ACE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbhIDKVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbhIDKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:21:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCEC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 03:20:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w7so1198921ilj.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zMOftv/83ksuRT5Xktk1zpfmTyaENLJu2cQlWbtiaDE=;
        b=WCde3TKv0IvIfOj6O2lcr8r01dg5QeOy+4Aahgbxjh/2+yz8dZ4ViFInjybw+YuVK0
         zqlfIYy6jES9ALb1pEZq3yFSZ/kTSdFc1xD4c+QatsqqlA/i2OzjKKZN9P8dFy2ArtcM
         1/ik/LPomN4uGmq05W8BnC7OZ7GCH6qOq2SVBqGu28tLdpMAP5SMT3+wjEIGfxIUX0ww
         ucm191w4yet5JmiLM1MWILFdRZS6+7b9LJoDrzQDhRWICjBqgOOj0qtvMlSB6NST6q5Z
         +WW7gNcVLlafblF+pzwmttJdOQK28Pdanp30PWQgEBwozBFIMxHCKUjTJAPmP+RwJcZp
         6oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMOftv/83ksuRT5Xktk1zpfmTyaENLJu2cQlWbtiaDE=;
        b=bL5SeWjdGSYgc7OrdIssdZ63VQNRW2kNi/QLtziYbj1sobU0+QrxmS2Bz3DAPB2GjU
         lf8213o8/1aok1cgoSp/Lo/093F+ok2AqDXYcJsehUEylUE0kMnFp84r9KYnIMy1udNO
         YJC8hJYxRJBJhENodISqPEJo1IcUVDXTAIernFkjy7Q5cGp/yVfjlr40ihc4yBJTU+26
         QMc3hJX7lutB8R4xtM9yiMckAIjX72qGcwqKh9JKF/i6J5945RdokdrQQlgGZakH+5IO
         BGTDz1er9wWyRTjCWZFojgGqN4+7auopqetYsMx2dHUDWMCfi/4L1JY69K7a9ebkGrvL
         SVCA==
X-Gm-Message-State: AOAM530Wzsnaaz4oZ00HEYzDoo1+YZAeMEsRSrXgrPukDsiItPUm8i5o
        EivWsw5osNEZdTM5GcJY24seAuDPYDI/Ur7n
X-Google-Smtp-Source: ABdhPJwfq77gRt1TzlnwaIQfHh9pOqvU39yAekZbnQNYVapnJ0xjOb65tRRkJniXqoUYjyy5NYLjvQ==
X-Received: by 2002:a92:1306:: with SMTP id 6mr2100663ilt.183.1630750847167;
        Sat, 04 Sep 2021 03:20:47 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v5sm1209324iln.42.2021.09.04.03.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 03:20:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 10C4927C0054;
        Sat,  4 Sep 2021 06:20:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 04 Sep 2021 06:20:46 -0400
X-ME-Sender: <xms:fEgzYd1-UipINy422xtNw-K4bbLVOUXeDlAifRrtbu-7JnJMaql_Pw>
    <xme:fEgzYUGuzATRW8HzcIoMVJsH1QSFA4YAHW3OOPMjOJV14oVJ3dViHv4EWXs5e4z0h
    KzCqn95lDniVQdVgg>
X-ME-Received: <xmr:fEgzYd7vAOnQokExv2MCSkwUvtpt4Dhh76pI5njCEE4cRlCZT_GnWS2sUd_MUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fEgzYa0Bc_Y67g2w-FLCSvW2a1KbpdxpNFCCviIGLuucqRg448a2bw>
    <xmx:fEgzYQHpOBA754w5ygDY_KOIkWn7OnPoZ5LV0l4YhaZVv_5fRG9gqQ>
    <xmx:fEgzYb-3ZDW8HJ-LQcBJo7rfgo9pt0jn9-FxYBruEwXhuQ8cgZ4vJQ>
    <xmx:fUgzYT84JHmL6pZqraDjprGPfUjY27j76zAsOb2icrdyiCZvEBYWC7biq54>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Sep 2021 06:20:44 -0400 (EDT)
Date:   Sat, 4 Sep 2021 18:19:27 +0800
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
Message-ID: <YTNIL81163O/3gea@boqun-archlinux>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
 <YTI2UjKy+C7LeIf+@boqun-archlinux>
 <20210904101429.GB4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904101429.GB4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 12:14:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 03, 2021 at 10:50:58PM +0800, Boqun Feng wrote:
> > > 	 * ordering, either is strong enough to provide ACQUIRE order
> > > 	 * for the above load of @readers.
> > > 	 */
> > > 	rwbase_set_and_save_current_state(state);
> > > 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > > 
> > > 	while (readers) {
> > > 		...
> > > 		readers = atomic_read(&rwb->readers);
> > 
> > The above should be _acquire(), right? Pairs with the last reader
> > exiting the critical section and dec ->readers to 0. If so, it
> > undermines the necessity of the restructure?
> 
> This is the one that's followed by set_current_state(), no?

You're right. I was missing that ;-/

Regards,
Boqun

> 
