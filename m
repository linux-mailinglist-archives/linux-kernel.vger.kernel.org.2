Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CA40328B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbhIHCS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbhIHCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:18:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B606C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 19:17:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l10so705647ilh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/IWD3lWqW7tmqbqU75hG73Bk2K0WFfHswfg8FlrHrKs=;
        b=aRywNGsz1D5A5EQCd5dUY6KTH/NjucGkz/bThRPkUpc21zAxA3wkr+t1y1in97qv1k
         4qjF9i5D/Ik559COUXRjheIpveh7ca7K+vNZBfUmxBpDCB8Cb2r8sfWFFoGzaIewuzdQ
         kAbiG/nenGMKQSgdHX9peYBr3TYBo2CozOdmg+KEK2b5rxV8T58QWld4MNeC/fvCuMhZ
         TEICtnQERFaBQt9Vfab6YZVFoVQSHr1m42p2BU1QCdtuMmwtF95sX4kryerYeFK42xSi
         NMuuuDYVDWKb7STNK723isP6sJ99USU16Sv/WApUMdTWuwrzWhc52rPRlSIyk1XoN2jR
         Gw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/IWD3lWqW7tmqbqU75hG73Bk2K0WFfHswfg8FlrHrKs=;
        b=JFnhTWU/xWtclzTb3nojYrDqtWHttwuOk03Tgc4lvoxaOo4WUf048mwd6Jm8YrJw1h
         SreWMk1LcgBuKzOACmqHbvN33Rfy18BFvEklcCKVAarrjaVRPod2wd2200gqweyL36u1
         Albqd5v/YIuc+LkPurDgypFV9Us1Of1NCiB+69QcCY8pgjX6vqJpdNZH6u1TQyHFjwY2
         AAcWPjqmIRGxTerX00Q71yMH/T1fAiLFerXDI/E1t7DRm/9udxOYNZolWuqcIPlgXHYU
         6TSA6PGMtdPFKd81WRWk/ujnk4XIpDBTPgKoee6m7nXxRs0ipbnDum2/FKEtGwebO7Tw
         y0eg==
X-Gm-Message-State: AOAM533eOxLxu9l6+7rSXho+czSWV1iQgDP+2XltGaWXXTZQS5SNJ0D8
        TILSwA3z3V2AWhJ9QfdjdDw=
X-Google-Smtp-Source: ABdhPJwTcSU8v+IGyKTgJLPCuX9DDd79BxO2Zus3jcyRBygcvgzSppfNCqcR2JM8668xAj1epnqHcg==
X-Received: by 2002:a05:6e02:10c2:: with SMTP id s2mr1119683ilj.148.1631067468616;
        Tue, 07 Sep 2021 19:17:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g13sm425340ile.68.2021.09.07.19.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:17:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8EB9227C0054;
        Tue,  7 Sep 2021 22:17:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Sep 2021 22:17:47 -0400
X-ME-Sender: <xms:Sx04YUE3hRlPNzpqI6mU2myQnErzB103JbkytV78PLjHG1OTPBwUPQ>
    <xme:Sx04YdUIPyNXY-luKEV5eFaQ7cfD8Mlh32KXb1RoPWVYXV0PO1pihfChvx6PCi8MH
    PKSJ34a5rVGkObUlg>
X-ME-Received: <xmr:Sx04YeJ4gnWuF5riBJw0gz96vAZyiMT9UY29LJI75D3dCN8PpY7VlRZzxjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvvdekhfeltedujeeuheevtdefueefheehfeeukedthedufeffleetueej
    vdejueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Sx04YWHwY_JVlXAm9x7YB_4sLgtfX147nLXMRMTKIlKSomPBm5pHhA>
    <xmx:Sx04YaVDNPJIKjDoAxMHflLu2jx88VjLlcXg0HdjwYIIgFpnMuQq7A>
    <xmx:Sx04YZOnCQjO_2PrU9WOVEbABgiE_rwUqRVRnEMtRjxEq-rTEZAUwg>
    <xmx:Sx04YcLuIprrmak3nQIzlxR6hwU-VJRa_RJykPz_sEPRXgWfyULulQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 22:17:46 -0400 (EDT)
Date:   Wed, 8 Sep 2021 10:16:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] lockdep: Let lock_is_held_type() detect recursive
 read as read
Message-ID: <YTgc8xXuVlpOhoUT@boqun-archlinux>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
 <20210903084001.lblecrvz4esl4mrr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210903084001.lblecrvz4esl4mrr@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:40:01AM +0200, Sebastian Andrzej Siewior wrote:
> lock_is_held_type(, 1) detects acquired read locks. It only recognized
> locks acquired with lock_acquire_shared(). Read locks acquired with
> lock_acquire_shared_recursive() are not recognized because a `2' is
> stored as the read value.
> 
> Rework the check to additionally recognise lock's read value one and two
> as a read held lock.
> 
> Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>   - simplify the read check to !!read as suggested by Waiman Long.
> 
>  kernel/locking/lockdep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_
>  		struct held_lock *hlock = curr->held_locks + i;
>  
>  		if (match_held_lock(hlock, lock)) {
> -			if (read == -1 || hlock->read == read)
> +			if (read == -1 || hlock->read == !!read)

I think this should be:

	!!hlock->read == read

With that,

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  				return LOCK_STATE_HELD;
>  
>  			return LOCK_STATE_NOT_HELD;
