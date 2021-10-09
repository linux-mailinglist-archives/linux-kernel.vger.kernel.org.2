Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E4427B1E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJIPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhJIPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:10:02 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54350C061762
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 08:08:05 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w11so9958208ilv.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V8ZPGN8dFZYvB35oNzfuCgsdZK/Ecy5xahKkUs1Mzy8=;
        b=O4HKCURj/UsA/Fzosi+ovQBRH4f/vGkT7qxs10+M0IBiuBKhldD9VSgteTGH4VIlP6
         uI1K5VQVL/ktE9M9BMamrhZpDXz85CHZI7X8jgmg/Hc9kPqb2d8TgVZFLUaDVSp80cZ2
         jczYX2C0LoAMu6eYCbHDQc8LvgeP1S9BnM7WVAQJkBADrTV2/41bTIZzPr7j4lmxm2j3
         JsFJlcUYZDBcg1jLD9p9yuCimSt6hWmbWAfhPwkZcKnXog5mA6kTynEP59sLkQMr9/qi
         F34V906hEt2q/GZ/E8rLIECGJu4KZHg04jl+RigZ7JwSjlB0dsKjv6fwKSDGP5mzsRXx
         FwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8ZPGN8dFZYvB35oNzfuCgsdZK/Ecy5xahKkUs1Mzy8=;
        b=2DkyXnLMQYHPFtOgIe9SkCJpMFj65sPpfWlEgxfFRgK9t5o6arXi0eLxUQAjpGdaIk
         1z43LIrDxBSIXf/RiV7nvJr/1pFkkYRnh6O0IbkZ5U+DtAtEfhSD5DKvq7xCtaoABp9+
         3zYPawa5JuBfuIOwUGbEpniJoE3F3+dqdhUZBGGNav7b0MG5uJ/DfkkdQhYRDF/+GcbQ
         OaySDbJVF2mgUg0W+O5R58Tq2eY0WlsBu9hVgpoQgLQwlhPGsYyD9cR6oWlHuN/3UaGx
         9S917c8xe6fQLSD5NRK0ORURhBYOcWQLdET2gmB1eav/4vYFPbUYKaYfg7njNUkJ6H5n
         WYkQ==
X-Gm-Message-State: AOAM530rTT/g3CzfBUCcrFzyGmXRWOYtKIQ626OQv06JGwoFSdQRrH+N
        eAx+t7CZVpDDAlx+hCME7RSw9oqmkvaDyw==
X-Google-Smtp-Source: ABdhPJzFLTvqcUHSW7vsS79+zABEnU/Em+/Xv+KvK/SJp/pGOeWk+O2YvgNyfBAJdnWLUQUAC+WvIg==
X-Received: by 2002:a05:6e02:d8c:: with SMTP id i12mr11207399ilj.190.1633792084780;
        Sat, 09 Oct 2021 08:08:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i5sm1244743ilj.49.2021.10.09.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:08:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7B3DD27C0054;
        Sat,  9 Oct 2021 11:08:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 09 Oct 2021 11:08:00 -0400
X-ME-Sender: <xms:ULBhYV9ek2r2TJf_oMM3EYujcJbpI7UahrBYQjl5B8K6mFyqVyAHoA>
    <xme:ULBhYZukEnFLMq--FIpH4yN8GtrPo8DuasI3XNCKBGLu7XJugLbSwQluQpf79hGHK
    x9AZ5T7uv2gWCgvRg>
X-ME-Received: <xmr:ULBhYTCwFwUdyoKKSlR1NUU6LzRe5LCXOMs1lVf8Pp_EuBg95cnCcV5aXJVVeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ULBhYZeQhMQV7EusCwOHkCXxUBGITiS2Ur8U_Ssh8QKO7KSyJlJV-g>
    <xmx:ULBhYaP-0D885CbbYzJQpVuzLrqCWPHnM6CqqkWBEIBQxIY4mV9T2w>
    <xmx:ULBhYbl57Ymh34YFDv7mhBk8U6aMvmoT0xKVh6FMT3pYjy8fAC3deQ>
    <xmx:ULBhYWAZoURT_B8Bn4wjvO7WnE0Y-FHp33TOAD28fW_8ONR-fVOU6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 11:07:59 -0400 (EDT)
Date:   Sat, 9 Oct 2021 23:06:47 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC 2/2] workqueue: Fix work re-entrance when requeue to a
 different workqueue
Message-ID: <YWGwB5npXJOjrgsJ@boqun-archlinux>
References: <20211008100454.2802393-1-boqun.feng@gmail.com>
 <20211008100454.2802393-3-boqun.feng@gmail.com>
 <CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com>
 <YWEK1iNVXcJmDQVP@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWEK1iNVXcJmDQVP@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 11:21:58AM +0800, Boqun Feng wrote:
[...]
> > "Re-entrance" is defined as:
> >   work function has not been changed
> >   wq has not been changed
> >   the item has not been reinitiated.
> >   (To reduce the check complication, the workqueue subsystem often
> > considers it "Re-entrance" if the condition is changed and has changed
> > back. But the wq users should not depend on this behavior and should avoid
> > it)
> > 
> 
> Thanks for clarifiction, could you also update the documentation to
> avoid future confusion? Thanks!
> 

I come up with the following, will send a proper patch tomorrow. Looking
forwards to your and others' suggestions.

Regards,
Boqun

--------->8
diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 541d31de8926..3b22ed137662 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -216,10 +216,6 @@ resources, scheduled and executed.

   This flag is meaningless for unbound wq.

-Note that the flag ``WQ_NON_REENTRANT`` no longer exists as all
-workqueues are now non-reentrant - any work item is guaranteed to be
-executed by at most one worker system-wide at any given time.
-

 ``max_active``
 --------------
@@ -391,6 +387,23 @@ the stack trace of the offending worker thread. ::
 The work item's function should be trivially visible in the stack
 trace.

+Non-reentrance Conditions
+=========================
+
+Workqueue guarantees that a work item cannot be re-entrant if the following
+conditions hold after a work item gets queued:
+
+        1. The work function hasn't been changed.
+        2. No one queues the work item to another workqueue.
+        3. The work item hasn't been reinitiated.
+
+In other words, if the above conditions hold, the work item is guaranteed to be
+executed by at most one worker system-wide at any given time.
+
+Note that requeuing the work item (to the same queue) in the self function
+doesn't break these conditions, so it's safe to do. Otherwise, caution is
+required when breaking the conditions inside a work function.
+

 Kernel Inline Documentations Reference
 ======================================

