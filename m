Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5616B341B43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCSLQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCSLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:16:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C91C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:16:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w18so10333514edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdsKsNk6KjsYln13Du/91TEjWMRGaXunklDZQnaOOxU=;
        b=YcGWoc6oqtmNavEmwG72fdzKBWMmLq1HpcVSpmivt0WkCpBxmJpgXegLuR4FlhW1li
         4Zw4ltE3kxepMljJDacWJ/dcAVgvgfKpzddZpz5VV6XnB35ubvn6OQ2U/sIw2eT4LZKm
         J2M3VSVWHv61QtL2G2LAT5HyRfGL4myfluKGfDJnYahpBWRmEZJmM2J7VQTwaokpH/1a
         tFv6UIFF2/zY1SEq7GthlMh11sCM58aoGHXr6a+TTUGJ73rfbORTOE4+BuDAlHj1WKrl
         cnQwbNNsXzdxyeoYn2N7Fg0slbsIfJL4UDvFk+StsYC54tknpfbU6xSrQKICMCJyIgfi
         f87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TdsKsNk6KjsYln13Du/91TEjWMRGaXunklDZQnaOOxU=;
        b=qUTyBrQvI1Z0YaSjfs/EEEHjLWWbFp8dTHzmakODahFqsW4BG4dkMXgC4T5S1bgYei
         cdVC3/rKyR4NNCLXuzPx/2C8cSseoklKf6aNAAbVozK53OtyQMEeDHU+iHmdt0j8nYgT
         Kmjv5KdIsQRWGdjqab5enqLLmBwmMhEVfykOta3MlUAc/Ufd/mG27kFzCUEYhyDG8aFP
         EA6YFv5N0mW1TDN9LOClRloP6E4oFWh4YFHpapLcxzHYoIV088rEhNyvyyooVl+vR8Pn
         p+EYRDIYDUISQYD2MtZ/R1E8isICSnm0OTO1W3Mwdp1oMyN47t32LiZCrmffAj9NNuro
         2mTQ==
X-Gm-Message-State: AOAM530t2YGTMM5krchSG97JJlRsOHkyQBIlswKa6ROWKtQ7FnwhvvQy
        J3EK8O9ZRMLab17rSB2a9uA=
X-Google-Smtp-Source: ABdhPJxtTpqecJIsiz7uzzs/vL+XDAphDqy5tLKAj60h5oJ4WPcOFro4kso3dAmsJJ05Qq/8JFaSrg==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr8820139edd.168.1616152591813;
        Fri, 19 Mar 2021 04:16:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id ha5sm3472039ejb.39.2021.03.19.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:16:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 19 Mar 2021 12:16:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH-tip 0/5] locking/locktorture: Fix locktorture ww_mutex
 test problems
Message-ID: <20210319111629.GB4029764@gmail.com>
References: <20210318172814.4400-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> This is a follow-up patch series for the previous patchset on fixing
> locktorture ww_mutex test problem [1]. The first 3 patches of that
> series were merged into tip. It turns out that the last one of the
> three wasn't quite right. So this patch series revert the last patch.
> 
> The rests of the patch series fix the ww_mutex testing problem in
> locktorture as well as removing the DEFINE_WW_MUTEX() macro from
> include/linux/ww_mutex.h.
> 
> [1] https://lore.kernel.org/lkml/20210316153119.13802-1-longman@redhat.com/
> 
> Waiman Long (5):
>   locking/ww_mutex: Revert "Treat ww_mutex_lock() like a trylock"
>   locking/locktorture: Fix false positive circular locking splat in
>     ww_mutex test
>   locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
>   locking/locktorture: Pass thread id to lock/unlock functions
>   locking/locktorture: locking/locktorture: Fix incorrect use of
>     ww_acquire_ctx in ww_mutex test

Applied, thanks Waiman.

I kept these two fixes in locking/urgent, for a v5.12 merge:

  bee645788e07: ("locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()")
  5de2055d31ea: ("locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling")

As this bug could affect actual ww_mutex users.

And queued up these four in locking/core, for a v5.13 merge:

  8c52cca04f97: ("locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test")
  aa3a5f31877e: ("locking/locktorture: Pass thread id to lock/unlock functions")
  5261ced47f8e: ("locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro")
  2ea55bbba23e: ("locking/locktorture: Fix false positive circular locking splat in ww_mutex test")

As these bugs are basically limited to a debugging facility.

( But we could also merge them into v5.12, if you think it's 
  justified. No strong opinions either way. )

Thanks,

	Ingo
