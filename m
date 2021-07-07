Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992053BF274
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGGXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGGXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:31:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41629C061574;
        Wed,  7 Jul 2021 16:28:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x16so1075427plg.3;
        Wed, 07 Jul 2021 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM5H6fyINSDFacMdYk8kIhTXfRZuAA/gZfzFCYQO+8Y=;
        b=n2MHAFhscsuVT78FRjyvPt0jystbtkn9sJyDhsWuokZSPx5cQDHb+p9j4odzZ/9igM
         KH+xZ3AaMa1Yu56K5YEnHUJ1OtFajyXXw7MIF582dkGbg9ibVsqLHINyVLe5FM8SnYRV
         TpGED6KGEjtywqM6YJ98DrqSTotSGx2/H61oqFuAZVGpE058FQR0+5zmKt1FD7vi3SnU
         4hPCtD2wc7WArzO1lTLR5HbRqn880C7vb2chCBWhRsg+uENu6Bn4Ktp+auMJFrDLuqfy
         jw3ETfk1Hb7jNjuQ38AVVzvFSuIj2sHwpEX4VEuhaDM4kDswOkLO9VndT9bP8Pmk61gi
         CORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM5H6fyINSDFacMdYk8kIhTXfRZuAA/gZfzFCYQO+8Y=;
        b=XmHGL0Xdcr/abu1QE06gfB18a6t9icPk58GxBv+5o6EXf2FzNP/E7qQbl0f2KYsi2t
         07OBJpWbJBd9u3oY2vx+gTDZa5Pk2PmVpIgqLiZP8oftl4lpFKZWWZljiL+/Yv8yhyPu
         ogccIbkRseTTUG8Kkdtj4tz4Fg89dQuiyEeWpCcMrCaPPs9xuXc4wg9jVp83VJ97c+U4
         pAXgP4UquVW6vASPKTuKXfliIMEGdFAhl4DkRExzsg3GNWGCgklTq3z43pKMAcjioSZn
         rl/3AVhNcrQ9cGCF+r4fL7EZkeBPF70XL2aQZtrfab8JFo+boyFcpl04OS7W83XbxclI
         Fzdg==
X-Gm-Message-State: AOAM531tTe7tycOKxWDwtUUQronvUQwvl9Eq6/ORCsOBJn69P+1XC0mz
        qxV/JiBJm2lQvxUMIvsjsOo=
X-Google-Smtp-Source: ABdhPJxohleEUoJwOits39wAFuZ5Dq3D2n3/z/fpcC1LdAonYJqMLG6QpyV9j4vLhVZxRHu0QtJzqQ==
X-Received: by 2002:a17:902:768c:b029:128:b109:d0d8 with SMTP id m12-20020a170902768cb0290128b109d0d8mr23356204pll.19.1625700524677;
        Wed, 07 Jul 2021 16:28:44 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id j2sm285648pfj.168.2021.07.07.16.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 16:28:39 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id C5388900853;
        Wed,  7 Jul 2021 23:28:37 +0000 (GMT)
Date:   Wed, 7 Jul 2021 23:28:34 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210707232834.5c8f2ace@gmail.com>
In-Reply-To: <20210707005800.GA2221519@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
        <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
        <20210706174201.GC943349@roeck-us.net>
        <20210707002045.571694b2@gmail.com>
        <20210707005800.GA2221519@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 17:58:00 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 07, 2021 at 12:20:45AM +0000, Vincent Pelletier wrote:
> > On Tue, 6 Jul 2021 10:42:01 -0700, Guenter Roeck <linux@roeck-us.net> wrote:  
> > > > +	/* set trim temperature offset to value read at startup */
> > > > +	hwmon->tjunc_offset = (signed char)hwmon->da9063->t_offset;    
> > > 
> > > Can you explain why this is read in and passed from the mfd driver
> > > and not here ?  
> > 
> > I cannot, at least not with something other than "this is how I found
> > the code", which I realise is not satisfactory.
> > I've been holding back on changes as I felt constrained by preserving
> > the original author's name on the changes (both Author and
> > Signed-off-by), but this split was indeed bothering me.
> >   
> Sorry, that is not a good argument. On the contrary, if I have to assume
> that the code has non-technical constraints, I am inclined to just reject
> it for that very reason.

These constraints are self-imposed and authorship-motivated: I do not
want to steal credit, and I do not know where the "why did you remove
my name from this ?" threshold is.

So if I am unsure whether a slightly surprising (to my untrained eyes)
but not broken piece of code is actually usual or should be changed, I
erred on the status-quo side in order to make a good-faith effort at
preserving the original author's name on the change.

So in turn, your suggestion to change the Signed-off-by into an
Originally-from removed these constraints.

Is this formulation clearer ?
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
