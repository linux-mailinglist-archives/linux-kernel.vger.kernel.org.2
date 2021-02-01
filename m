Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3805230A92B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhBAN5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBAN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:57:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:56:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so16704452wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hNt79SEwyevHlCnNpQqVrGlo2a3i4FGi8Hmj5UsB0YU=;
        b=M3PnKpu5bp1bl2yYEhhr4sCnuaO9FGuJbLvEBWPW0WULJh3Cpkm8GLVAU6DYeu8dRy
         pP1rj3IK0ON+NY7DRc8z82F+pbzd4oDCGZ4CY34AHOaHtMsmT3H+Kfu/PATcu2F/rS8n
         fWdTB3af7hfwLCuQKmuYr6QEKdfcDNFKdP6rss0uFJmcz3Xkh7xWaW74LQb60V9xNghq
         le+gHWovZEXM+0zOU7iXpxSh0XQzzeG8QtPWGAyntBAbLKDqt/nouH6NYzMuys4bPzS7
         85D6QOHH6SbpRMF9pJ4bnPkEvSnP0JfZ/CmETeTm7cmKrcSKysdtSKYsGh/tV6MiBaYl
         QCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hNt79SEwyevHlCnNpQqVrGlo2a3i4FGi8Hmj5UsB0YU=;
        b=cUDAXge/DP6XAi3VvY7XZ6YA3j47uRGH5k4MFX5jRQVqXVvecJwotHZI766hbaqLbK
         48HuOrEm+MqGscrH0pi5LecxS6tgvjnDwFrUe/TGMIJtGOmaWCVkcO94jQKsLeb1ThlD
         HPeF2m7bMAHMFQaNx1IEjmv8ZuUhS5tpsIyS3pwkQydfLAOmByToo8KVK02JpyjJCACC
         KnOEAcdvG4AEPqWfHKUJAl36e9FhE2EmR2POxZ+RvILe+6hlkPP91ef2MmgYHf2A4dbH
         SBjA3XbGYeR6MhaYOIfc18unIiD2yEKr3p2LEQuWw9qoGjp0ag6UE2pNJQsyd9OSmq0C
         C0iQ==
X-Gm-Message-State: AOAM530GfRE0MJkF01/3LtlYGwD/dmyTHbQF6sl1ttbeyFnG0iX5lm0+
        mvlo0jqtH+dMjLteqJ7c7FP36n2DSCkE3/34
X-Google-Smtp-Source: ABdhPJymaH4S/uzykkYB60csZ4w9HpANZ6MSS095a8XKFeEWTFyVP/MB4qAPITf+EkWkOBiUVCMXLg==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr17708926wrw.206.1612187795297;
        Mon, 01 Feb 2021 05:56:35 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u14sm20527162wml.19.2021.02.01.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 05:56:34 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:56:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        IDE-ML <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
Message-ID: <20210201135633.GV4774@dell>
References: <20210128180239.548512-1-lee.jones@linaro.org>
 <20210128180239.548512-2-lee.jones@linaro.org>
 <20210128181903.GA2099675@infradead.org>
 <20210128182713.GM4774@dell>
 <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021, Arnd Bergmann wrote:

> On Thu, Jan 28, 2021 at 7:32 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 28 Jan 2021, Christoph Hellwig wrote:
> >
> > > On Thu, Jan 28, 2021 at 06:02:20PM +0000, Lee Jones wrote:
> > > > Some ATA drivers use the SCSI host template, a series of interwoven
> > > > macros, to aid with initialisation.  Some of these macros conflict,
> > > > resulting in the over-writing of previously set values.
> > >
> > > Please just disable this warning globally.  This is a sensible
> > > patter and we should not sprinkle per-file options for something
> > > that fundamental.
> >
> > Will do.  Just as soon as I've figured out how. :)
> 
> I have a local patch series doing it like this

Can I leave this in your capable hands then?

I'll drop all my fixes for this if it can be replaced with just one.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5f550eb27f81..4e4cc14a289e 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1390,6 +1390,8 @@ extern struct device_attribute *ata_common_sdev_attrs[];
>   * edge driver's module reference, otherwise the driver can be unloaded
>   * even if the scsi_device is being accessed.
>   */
> +__diag_ignore(GCC, 8, "-Woverride-init", "intentional override")
> +__diag_ignore(CLANG, 9, "-Winitializer-overrides", "intentional override")
>  #define __ATA_BASE_SHT(drv_name)                               \
>         .module                 = THIS_MODULE,                  \
>         .name                   = drv_name,                     \
> 
> I think this also requires a preparation patch to extend __diag_ignore to
> additional compiler versions, not sure if that was already merged.
> 
>          Arnd

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
