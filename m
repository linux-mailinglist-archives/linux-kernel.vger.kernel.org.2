Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76973390C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCLPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhCLPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:07:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF86AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o14so1190530wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5jecNBLWO3Om52c7o+pFRseLbBzmDja9UePjfGhjtNI=;
        b=a/iuLFYLmN3dewGU/051O0Lz7KYzvCrpA5NhArFOew/YLQFx2jXFWvRFqO8WadwNc7
         EONeKQEG7lse3Udi3Cjbrmk1pYu1+BY/WUTJLVJBocHjL875D75LRwrfRWFtozbMNtkE
         uSZYbJkJEu8N6spYT+fSASxHydL62FkJ4EL1qF/RBlH5dPypvvq0tjlSTXkgTmNIUYln
         cBAuKNTVmMxCK08yMdPeiLHGT5eKkI3AgEFBCSBDh0+PPDF1tyDZgR3c+qarm3JEnPVw
         g/DFqUTk27D6UG0/PLIqyCLAuaeucAeiNwZDvvJtE68oMecAVYYxajRwOweBxv3Htfp5
         ecCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5jecNBLWO3Om52c7o+pFRseLbBzmDja9UePjfGhjtNI=;
        b=o/XCCsHjCca5Jb4b9ftZ3T18fG5NYBZQVbozBuGiLlPSr/ARefeR2H2DrAicOdz9or
         W/AviYdcJ50dc64HLktfI6DVSjvcUsmkCeQ98PYpG5hRh0zTlHFe49mygQh7ilgU6zV6
         qKkYgvuJ58joVFqROdsAOmXOTVZ7oYaOGBdVI1ZhQYeB1c29SNZeGBFcVWZ52jh8OfHm
         JHKJU7IjYgUmiilkMXzbQdZ/FHy6ReAyQdDGBnH4OCf05GcaL3vCFwI1DPKyVNigWNdI
         cGMRN0OiTrBb98EN+w5biA2HwIu6MkQOnC52sRihAxpppCQaFSttHBLBboO9NxQ+E5FO
         1TUg==
X-Gm-Message-State: AOAM533fJw5KeoiBwaZ2+itESqy2EROEy/Pr6tTX9FwVi9AieEowh6Ls
        WbOkUSxZK3jjnLENwPqZiUj9dQ==
X-Google-Smtp-Source: ABdhPJxRz7MLunbq/Nw/BO+kPWTCpbOXbZsL7p6mUEZaAWwrfZVbJ2VNo23xjl5Yj9MV2tloS/QWnA==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr14554191wri.373.1615561630438;
        Fri, 12 Mar 2021 07:07:10 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id a14sm8765760wrg.84.2021.03.12.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:07:09 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:07:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/10] of: device: Fix function name in header and demote
 kernel-doc abuse
Message-ID: <20210312150708.GU701493@dell>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
 <20210312110758.2220959-2-lee.jones@linaro.org>
 <CAL_JsqKfK2AHdcDKbAQqTiDHTMTH5RiChZGrVhtwj=hed6syNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKfK2AHdcDKbAQqTiDHTMTH5RiChZGrVhtwj=hed6syNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021, Rob Herring wrote:

> On Fri, Mar 12, 2021 at 4:08 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/of/device.c:72: warning: expecting prototype for of_dma_configure(). Prototype was for of_dma_configure_id() instead
> >  drivers/of/device.c:263: warning: Function parameter or member 'dev' not described in 'of_device_modalias'
> >  drivers/of/device.c:263: warning: Function parameter or member 'str' not described in 'of_device_modalias'
> >  drivers/of/device.c:263: warning: Function parameter or member 'len' not described in 'of_device_modalias'
> >  drivers/of/device.c:280: warning: Function parameter or member 'dev' not described in 'of_device_uevent'
> >  drivers/of/device.c:280: warning: Function parameter or member 'env' not described in 'of_device_uevent'
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/of/device.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 6cb86de404f1c..64ee363abde24 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -53,7 +53,7 @@ int of_device_add(struct platform_device *ofdev)
> >  }
> >
> >  /**
> > - * of_dma_configure - Setup DMA configuration
> > + * of_dma_configure_id - Setup DMA configuration
> >   * @dev:       Device to apply DMA configuration
> >   * @np:                Pointer to OF node having DMA configuration
> >   * @force_dma:  Whether device is to be set up by of_dma_configure() even if
> > @@ -256,7 +256,7 @@ int of_device_request_module(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(of_device_request_module);
> >
> > -/**
> > +/*
> 
> We should fix the kerneldoc on public functions. Demoting is fine on
> static or internal to the DT code.

This file is not referenced by Kernel-Doc.

  `git grep kernel-doc:: | grep drivers/of`

> >   * of_device_modalias - Fill buffer with newline terminated modalias string
> >   */
> >  ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
> > @@ -273,7 +273,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
> >  }
> >  EXPORT_SYMBOL_GPL(of_device_modalias);
> >
> > -/**
> > +/*
> >   * of_device_uevent - Display OF related uevent information
> >   */
> >  void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
