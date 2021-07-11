Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4F3C3AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhGKFZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:25:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82481C0613DD;
        Sat, 10 Jul 2021 22:22:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j199so12955856pfd.7;
        Sat, 10 Jul 2021 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BK/4WU3GBFs/AezFO+adsAQBSfHNPz3jea6eZYOYCV0=;
        b=aaZZ6G7WyxGsbXr/hkPwSt/e4rCg3qu7dJwG7RaAEuoQ8nT69oLTEdg9ShpsuM/ZlQ
         W5m5y9nlq+MrqN7Pthfh6lMhjAZLpzzTV0mcapIycXPU+mVP4o7Q4uW2bG5QoEJmUpwM
         P5vC2SPqlcQadlgJ/Nt6YEqgZMwpiicI+CfKBCJOrpCUWwIUP+h14XCNXRxR/YWFU3cD
         8o+4s9zRA1cJ/ZSCZ0f3ZBPs0qa2lz54HQyYu5Oead3YRqOa0AB4ITyLe3ywTYJBARG/
         RIKIaMZg1gc2LKDOY4LrEQ+5X/GiP8C1IGRVwYToz2HXtABvmDRyMGE/mHvoZS9fJftv
         2uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BK/4WU3GBFs/AezFO+adsAQBSfHNPz3jea6eZYOYCV0=;
        b=PqV4pIEKaKisUPGBPiRb+1u2VXLR1zhzOpn2vRPCXg4U/h+Gvt3BjAqPqeXbIemSYf
         TdjfKOM/6mjEWagSP1EdvowzUF7jX9SkxsXgWm57g95+SXcHcclot86zTDIKTpRsICzp
         v2cAHlUv1YVuDlNPOCYac8IJSJosIgqplO2Dg7ykuZU/1qpchoX4BVwcxsVbLjZvyyhL
         73Jr7I0uikVnrPHeqe12nPXKXSyrskjAF/MQTQUIic5CgpaHaDnazKn9Qoc0gIsPao84
         ZbqOs6CGWgNa2rDw3Xc8/78RDEHQbvPH0sG4+93kZJ6WhjnEmX5UgtaYe5Ic2gnoKa56
         ga9A==
X-Gm-Message-State: AOAM5337FTtKHQEpJHJvnTtnQ24PLitMR/aJXemsoXwebHrI2VufoCB7
        VV1d4jW8T2NEm9HtChvI+0E=
X-Google-Smtp-Source: ABdhPJzo7wfN70TYuqCqvFuNZ81jgFX1XnridM4He4othQLsZ6OVjMSqMdcennKW1HgrILwQqY6UbQ==
X-Received: by 2002:a63:450e:: with SMTP id s14mr37600136pga.312.1625980973763;
        Sat, 10 Jul 2021 22:22:53 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id l20sm16780941pjq.24.2021.07.10.22.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 22:22:53 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 09E66902A99;
        Sun, 11 Jul 2021 05:22:51 +0000 (GMT)
Date:   Sun, 11 Jul 2021 05:22:50 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210711052250.09828831@gmail.com>
In-Reply-To: <f9113bf9-ab00-d0b1-cbc2-f4107b93e727@infradead.org>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
        <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
        <20210710160813.GA3560663@roeck-us.net>
        <20210711025502.347af8ff@gmail.com>
        <20210711044419.7b1c00f8@gmail.com>
        <f9113bf9-ab00-d0b1-cbc2-f4107b93e727@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 10 Jul 2021 21:58:33 -0700, Randy Dunlap <rdunlap@infradead.org> wrote:
> > Beyond what you suggested this also gets rid of:
> > - seems reasonable:
> >    - linux/delay.h
> >    - linux/init.h
> >    - linux/slab.h
> > - looks suspicious to me:
> >    - linux/err.h, which means the error constants are indirectly
> >      imported. Removing it feels brittle.
> >    - linux/kernel.h, although to my surprise a lot of c files do not
> >      include it.
> > 
> > By default I'll drop the former and keep the latter in the
> > next version, please let me know if another combination is preferred.
> >   
> 
> Hi,
> 
> Please use Rule #1 from Documentation/process/submit-checklist.rst:
> 
> 1) If you use a facility then #include the file that defines/declares
>     that facility.  Don't depend on other header files pulling in ones
>     that you use.
> 
> so if Enumbers (error numbers) are used, then #include the header file
> for that.

My mail was poorly phrased, sorry.
I meant that I intend to drop the includes from the "seems reasonable"
group, and to keep those from the "looks suspicious" group.

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
