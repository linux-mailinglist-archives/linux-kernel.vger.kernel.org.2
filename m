Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68663AB058
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFQJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFQJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:54:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B80C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:52:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o3so6031138wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cFwCQ8jUzVcqwNmbSuUnriVBVuZxeCFs/UoupLmubI8=;
        b=XxKQgXLNJzh7Tr3GpBP2pQ+TiRnX4kmS/MFch1+8EJwGCxumz08pcTlbDwFDulJwKT
         euZzfg6MHav3OPnGW+uCKmqB5I/Q1l9hWBtzGacrodThetdorXucyhl9ERo07mPxrWI4
         hr59cwIo6yNbOd74gbjcg52x3nCc3n0z2PRjMUPVTxCcQxq7I74253Ymogstt+oWELrO
         pjxXSFLJ6B9W7uSvL6KIQqAUYgv8KF+Ab8iGbuhmCR7ElXe8nH85e0XeoWHeNCaoAn7e
         oiNxESkPXNOtNkFJuKe9DkBB4JXhoYzvlsYfoNdUtnDh/5mWZdepLvP/5ZC0UC6aEMc0
         SKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cFwCQ8jUzVcqwNmbSuUnriVBVuZxeCFs/UoupLmubI8=;
        b=bHmM+KMEjjFceJttwUSatreUJvdQkyu0+wBKHW/G1t6DAWi6F4wy49mRX8J1lM3bji
         PW4pb6PwYiFDAkL0JBV0XolTRjeYUNl+HZolLW/D/Ofw2GXAPziv/H9ROZaB8SmUhHRl
         HZjH2jQEKVYBiFZdYHwatMREGyO/ImQavqfKP+bjMVfknQJ30hbiMP/Kxi0l/88gN/1D
         3MJHDhWOxcpmXKOHBT+TlbEsMFPObRlqMlVJ5SrqO21BZf1f4mz0Zgv2VIUEgC/SidAs
         LIMEcT2CbyOzIKbNQwzD+L9nCvXM+WGbejvtR3icoo7vBz44PEXXi/ov707E/GSUeEcK
         cfgw==
X-Gm-Message-State: AOAM530V6F5FD9OZqjC5ndToklQ17xqllhztI2r2Wt/oS7llSSpWOhhb
        75DtldUXuLfnWfR5eLtqowBAdGze/Gt05A==
X-Google-Smtp-Source: ABdhPJxmnEY2UOpjdIp1+AepGIkbAU/BDCL+RhC0yTSa2aLLyAk4/hXLw3x6hSHhIqC3uxYZOn4/kw==
X-Received: by 2002:adf:d209:: with SMTP id j9mr4523631wrh.328.1623923545439;
        Thu, 17 Jun 2021 02:52:25 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id l23sm2251743wmc.5.2021.06.17.02.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:52:24 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 09/16] char: agp: backend: Demote some non-conformant
 kernel-doc headers
Message-ID: <YMsbVykDtF+Cz9mG@dell>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <20210520121347.3467794-10-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520121347.3467794-10-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/char/agp/backend.c:68: warning: Function parameter or member 'pdev' not described in 'agp_backend_acquire'
>  drivers/char/agp/backend.c:93: warning: Function parameter or member 'bridge' not described in 'agp_backend_release'
> 
> Cc: David Airlie <airlied@linux.ie>

David, are you planning on taking these 'agp' patches please?

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/char/agp/backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
> index 004a3ce8ba72d..c901c719fba89 100644
> --- a/drivers/char/agp/backend.c
> +++ b/drivers/char/agp/backend.c
> @@ -60,7 +60,7 @@ EXPORT_SYMBOL(agp_bridge);
>  EXPORT_SYMBOL(agp_bridges);
>  EXPORT_SYMBOL(agp_find_bridge);
>  
> -/**
> +/*
>   *	agp_backend_acquire  -  attempt to acquire an agp backend.
>   *
>   */
> @@ -81,7 +81,7 @@ struct agp_bridge_data *agp_backend_acquire(struct pci_dev *pdev)
>  EXPORT_SYMBOL(agp_backend_acquire);
>  
>  
> -/**
> +/*
>   *	agp_backend_release  -  release the lock on the agp backend.
>   *
>   *	The caller must insure that the graphics aperture translation table

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
