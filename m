Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A484347F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhCXRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhCXRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:36:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D77C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:36:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u5so34260958ejn.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iOz5xjpkg1zerz9McIquqk+AEx0Qp1kL5yo6CeVgMos=;
        b=d8B1svA87XwgY6JS/P1AJZxIwVGsshVBLqHktF+1W4Ii49qqv7hd5BRvkAQ0yUhoBW
         Xf7K3UfQts2wuc+Nm8v9otEk9ISmGHurm2Z3+rzT6BYWYM5WzEJcwUAnbXMJKL2L/Bg6
         cMi8ii0FmQ62tHvLDEjA2jqDoPonnOdpDq8XGi0oVx9Co0G8GiT6ZO9tMchtAnlp4EBn
         y4n5SeP65yB0Dm6NudchJ7SQBdiLSJwUR8+OYk6vqU03x9ne4tNIlC56lPyHHsPDoDsF
         VdwV6dRUhC6G5clA5LT8Uq2DbjwaAMLX8JmtbJimYDx0Z4SrCa6YjxUnyab8c31BITbB
         Z2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iOz5xjpkg1zerz9McIquqk+AEx0Qp1kL5yo6CeVgMos=;
        b=f7MuRO/FC9qcgnUqyml4jBIPJ5Xe0Q225GesVSndjWgUa9bpVGca89p7LrBrJtKHRJ
         +vQW9VCxXsxRtGl6/kFI85O8e0fazjoPsIfksdP/bUp5Od+qCNRyDGAeiY9iNM0SqP/F
         SV5OJmb2cVsNDBd1Fl8nSWDjeKgLjEKi5ulVsA1aIxUh0zVukZHYfizAKxyPRdToHtj5
         rnHxdEeUbU3AfFAJxrkJCqwI7Q8nXIHdmzgQ73zCBCNcnqM6XlVErsKV/I/1Yv2iLGxl
         wnsMWg7hCarwiQ1zv9oNntV0j9bYnzeytxAYwV9zELHYDhJxrEGlenV1yg8F8v15Fied
         NiBw==
X-Gm-Message-State: AOAM530f3yENBbf/9KRMkR16s0RAERk0x/1zOJXrojowy+k0CGTVaLrr
        nrUVnbyg5RU/qMzzcKeVQLhUeU1gwEcijQ==
X-Google-Smtp-Source: ABdhPJylry5drzNQCj2y25PDINfTfNjrQEukAB2D/29zjjaDFZeCMDBy8oz/6NNk2uMoFY6jRnU/kA==
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr4958611ejc.510.1616607377316;
        Wed, 24 Mar 2021 10:36:17 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id e8sm1451401edq.77.2021.03.24.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:36:16 -0700 (PDT)
Date:   Wed, 24 Mar 2021 17:36:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324173614.GR2916463@dell>
References: <20210324170834.20605-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324170834.20605-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> Allow interrupts to be MSI if supported by hardware.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v4: rebased on clean for-mfd-next branch (Lee)
>  drivers/mfd/intel_quark_i2c_gpio.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
