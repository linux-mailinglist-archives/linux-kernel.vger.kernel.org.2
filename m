Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D7414FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhIVSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhIVSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:25:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78160C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q11so9561721wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qudQ8Ujb+FGGFne2komMi8WzYnU4RAUakYphzaE96bY=;
        b=QE19C+Dn+djjyRETcEN5AJWmN2jiAIfzLEUIuQQY/Px8sg/b6JrRDIpeLsVL7SZySU
         iO9RT9c7ryW3H8X1lCEVqZ42SZmRKHVfRfTwxb6eYBJzwIn7Wlu4M1W/lY+RCCLLh8is
         tCydnZSVrzfDlDskSaEp12SQpMPhbOozXyEALDUosgCIVNQECv+AiAcB400sXGKLGC9Z
         Ic48EFSLuJswNy/TDQF3lf8B9vdFDc99EhP8AKFJXEjCTcwgwl/IQ72ULrPOKuQMCVWa
         syWFVvPAnVaYkWbwIHFg28cBBbLsldhZOo0j+ZkY9ZFYzyEO/KZQ+oiTKhGnFTpvUuuh
         xZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qudQ8Ujb+FGGFne2komMi8WzYnU4RAUakYphzaE96bY=;
        b=eUIMqTJeqwdezwoo4AZi991+vik1oGlUC9u+we6Tw+WiRtR7FwUB8szV/Merp51pGk
         5G30L0L6GAc85e9wV7bbEd42sgpp7X/OmEljLal24bG5z+OH3rgZDSwW42WDvDkKWvOp
         ww4jNKJ6krtwU3izxQwDsdz5nFPUGVTCwIxjF3iZzIkdl7/AW6o9UnZAUhMRnnQJC4zn
         cgtPQyVxduhGYkxsEcdUgMaBZdc8MrE5u5b/MRtPZeqQuWTRGyG4OXXoD+aNPCXLOKn+
         IBiEo1q8bxP5rx/15E9eKvwYL2LiKtKaxZZkzcVQczNgXmRQ+agSCp0f9tut6DQg4r3j
         CthA==
X-Gm-Message-State: AOAM531HrMa8qbJWPQaj/+VdE2UaHNXlMO0ODjE0lyQyYfhIVRMM7W9/
        300U4Ils6PHnd5BYR17VgJf01qNOYEahsQ==
X-Google-Smtp-Source: ABdhPJw4TehYfj0AHji3ZcZVkTH9ozQ7rIxgbzxflIgqNqqR7zdqfvGDg9Fnh/7ahdxcFFTu97PdaQ==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr488859wmb.158.1632335011076;
        Wed, 22 Sep 2021 11:23:31 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id 61sm3006299wrl.94.2021.09.22.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:23:30 -0700 (PDT)
Date:   Wed, 22 Sep 2021 19:23:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Add SPI device ID table
Message-ID: <YUt0oRV5u6+bd02T@google.com>
References: <20210922150812.27516-1-broonie@kernel.org>
 <20210922161614.GC4183@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210922161614.GC4183@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021, Mark Brown wrote:

> On Wed, Sep 22, 2021 at 04:08:12PM +0100, Mark Brown wrote:
> > Currently autoloading for SPI devices does not use the DT ID table, it uses
> > SPI modalises. Supporting OF modalises is going to be difficult if not
> > impractical, an attempt was made but has been reverted, so ensure that
> > module autoloading works for this driver by adding a SPI device ID table.
> 
> Hang on, there's a typo and I found a bunch more MFDs that need updates
> - I'll resend as part of a bigger series.

Fine.  Dropped.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
