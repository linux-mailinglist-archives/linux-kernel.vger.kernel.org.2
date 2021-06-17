Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA43AB025
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhFQJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhFQJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:51:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26392C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:49:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso5922912wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zNblqi4A16LusZtsw5tFWE5wJ+Hx1eY3p82HyQ7W+G8=;
        b=glYcl9SsQNX6C3tl3kYxCGsPvo71wD6vvbCx8fvAR2wvspxEtl6nK57/a12RyE/0bl
         ZUFsekhoUuOv3arOuyv9PXZQatEXXbrBUn4s/ZMhAD9YPN8HShqFoCr90Bl7BTKZp6L3
         uzHWRcxtOcaHLSX1ESUKm+WDTt5YmwV7faFPc5FCOVq3icRfoX0sYNDai99cQ0q9wK5L
         4fAwooEENsAk33BsXWMXKZqHc+Zm5iRIwy44PZtKf7qvJtyjybUoOuzdigSEN9NYl72k
         g67KoUMVvQ1H9blX4TJSo5bxG58TmOy0PGJ2INmLY1wwHSF6wOEH+vfjBBGEvMOLhzyL
         Msxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zNblqi4A16LusZtsw5tFWE5wJ+Hx1eY3p82HyQ7W+G8=;
        b=b0n1+1D+46PuHPQFI6QkI8GMzaeapFYXzrn7DHz39iOPG+0un9D6AqkgvT1zVC42W5
         gekjNM8Hgl26P8BoXqQFogjc5HX4Gn/KVZsLn2SVPdiVTivYDbr67Qc9M0egQS0nD25X
         puJB269TXI/jSMGxg0DboMY6X/KBa+zzrBxWQAfTA70vZvETrLwv1HU6ZFbAu0DIaYin
         MMxHqyIUN6CcbrdXeIOpFFGfom0uIh/gh+M58v0Q1reNhRZKQ/fq71YcM2z6DtNz023K
         +RhyB5jnJUy4pPCfiwmdZ9gVRkoNrwpHnRUSBRQYgEHB9Ailw7oXA9hByDtW0B6rdBI0
         pcsw==
X-Gm-Message-State: AOAM533V2nGhALSNgRgfRE4qMqRxw0qedrIgKRDC8XQpoUPSHNW0L49s
        S3jmm83jqj5LYx5fKrvvoCPe/w==
X-Google-Smtp-Source: ABdhPJx+BmYtjuPGsIRJoQaUOlMSPBRFI+GChRWobaAhxmRhLOeFtbKO7Cq/SzOReBJYL6b7gnsCrQ==
X-Received: by 2002:a05:600c:3b11:: with SMTP id m17mr4126241wms.150.1623923342777;
        Thu, 17 Jun 2021 02:49:02 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id c7sm4928349wrs.23.2021.06.17.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:49:02 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:49:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        German Rivera <German.Rivera@freescale.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stuart Yoder <stuyoder@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] Rid W=1 warnings from Bus
Message-ID: <YMsajH2uxw4RHPeF@dell>
References: <20210526081038.544942-1-lee.jones@linaro.org>
 <74eb170b-348b-1bba-432c-52c9541b05fe@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74eb170b-348b-1bba-432c-52c9541b05fe@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Laurentiu Tudor wrote:

> Hi Lee,
> 
> On 5/26/2021 11:10 AM, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (10):
> >   bus: fsl-mc: mc-io: Supply function names for 'fsl_create_mc_io()' and
> >     'fsl_destroy_mc_io()'
> >   bus: fsl-mc: mc-sys: Supply missing function names in kernel-doc
> >     headers
> >   bus: fsl-mc: fsl-mc-bus: Demote a bunch of non-conformant kernel-doc
> >     headers and help others
> >   bus: fsl-mc: dprc: Fix a couple of misspelling and formatting issues
> >   bus: fsl-mc: dprc-driver: Fix some missing/incorrect function
> >     parameter descriptions
> >   bus: fsl-mc: fsl-mc-allocator: Fix misspelling of 'new_mc_adev' and
> >     demote non-kernel-doc headers
> >   bus: qcom-ebi2: Fix incorrect documentation for '{slow,fast}_cfg'
> >   bus: fsl-mc-msi: Fix a little doc-rot pertaining to 'np' to 'fwnode'
> >     conversion
> >   bus: ti-sysc: Correct misdocumentation of 'sysc_ioremap()'
> >   bus: fsl-mc: mc-io: Correct misdocumentation of 'dpmcp_dev' param
> > 
> >  drivers/bus/fsl-mc/dprc-driver.c      |  8 +++++---
> >  drivers/bus/fsl-mc/dprc.c             |  4 ++--
> >  drivers/bus/fsl-mc/fsl-mc-allocator.c | 10 +++++-----
> >  drivers/bus/fsl-mc/fsl-mc-bus.c       | 19 ++++++++++---------
> >  drivers/bus/fsl-mc/fsl-mc-msi.c       |  2 +-
> >  drivers/bus/fsl-mc/mc-io.c            |  6 +++---
> >  drivers/bus/fsl-mc/mc-sys.c           | 19 ++++++++++---------
> 
> Thanks for this. For drivers/bus/fsl-mc/*:
> 
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Any idea who will take the 'fsl-mc' patches please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
