Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719303212DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhBVJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhBVJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:11:04 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A788C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:10:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i7so7042445wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F7jrUpzBO9ZQ9MHhBQ0zn1/FHacDR4Gte2WZnAPt3Ec=;
        b=g+jBAscd5RBgO+9Xj1Bxg3rvzU4/REW/h8W0fkKyz3nrmSRS3azT+g1bpiyX7ZbSSX
         AC8RSiOE9k7XIrVJKhYEdAHfvJuCI27gXnBPdHRTckJVcZH3hXkbFUGOY1cvh3ISjqkd
         EGCom/xFs5Em37gnp4iD/aBVZLUrFor3lRhrVb80WqDRf6GgZEkCsQ1XvoSPvOKzXz+V
         HIx3W4ZuD3dZ5XEpmuVAVylSsk6CYG2IcR3mT0eu7px0nJwDWS86sN4XguCk8ot0YU3f
         MGY6BA4wO5QFyXk9B0kG36RGIbb1AdqvrG79stwdS3AdP3u51BMQfsz6mJVNmugC5GmZ
         DB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F7jrUpzBO9ZQ9MHhBQ0zn1/FHacDR4Gte2WZnAPt3Ec=;
        b=HCeoiJXGngHZMrcqQeYK9x7lleH0ECI4lNzfjN8zkEnHqwUtGrDv7lZ7IAKjKjA1+N
         iw3zcl3KCngtttZ+jZ/sLDSO13+m+ztDO5Kl7kq1eHetX/pTCoiP1lck6ioOzeibuDp1
         8CigMPOHi9xm9ncyJr46Km+AJEwSGajQMdyDD78dHup8Stms5y5wJudbgaxPYg5MFq79
         VJv8SE/UTNxwhA4BXqZs0wlM/lsIvaN6oFEjUge2mHj0y0kO0w2vr16WMNht/T42hvCI
         HzXr8TJekXTguyAdfYRyuzprM9E5HGJUDqwPkF9UcB8HAAxOwKWTvSjr96+A/HEdS8Yt
         sU1w==
X-Gm-Message-State: AOAM533iUMdoSq7eiCUzRRR4q573wfwsPYZI4qr0dI5jSi4PZkSRmaPT
        B1eHhDEbTqG4yfOWaNKjPNdoEg==
X-Google-Smtp-Source: ABdhPJxEMk6S8xAXLAW9n+JVEs96/oBry9X4LcAHKq2CXrz14JPPdrb0jtfLDpTdRAAbTwEQFrqdzg==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr19068441wma.75.1613985022217;
        Mon, 22 Feb 2021 01:10:22 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id d15sm13470211wrb.43.2021.02.22.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:10:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:10:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>
Subject: Re: [PATCH v4] mfd: da9063: Support SMBus and I2C mode
Message-ID: <20210222091019.GC376568@dell>
References: <20210208152758.13093-1-mark.jonas@de.bosch.com>
 <PR3PR10MB41422B90076115ACCE07D2A5808E9@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
 <90bd35fa8c6f420fb1656c678c016509@de.bosch.com>
 <20210220110718.GA953@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210220110718.GA953@ninjato>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Feb 2021, Wolfram Sang wrote:

> 
> > Is the patch already on the way upstream?
> 
> Can't really speak for Lee here, but during the merge window patches are
> usually not applied. So, in something like 2 weeks, usually collecting
> for the next cycle begins. Looking at the CC list, I think you added all
> the relevant people, so it seems all good.

Wolfram is correct.  I'm not planning on taking patches again until
-rc1 is out.  Patch looks okay at first glance though.  A proper
review will be provided in due course.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
