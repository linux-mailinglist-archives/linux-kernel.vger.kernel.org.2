Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB442C4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJMPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhJMPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:36:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B4C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:34:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f5so2645277pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqZTBfg3/QOuM5T2ZYO9ec8lSodF69mZtRRrLvQ5Gfg=;
        b=bwlGOxIr7XIuC25JE0sXW96+DAR4tBZkoc4cTzBClGIvv/CT0jHFDTCoJ8EoTdwa4u
         5AWys82W0ENXsXAxlng2zjJpvSftLKHB9qGJWmmHYDulwIQRzH//WJPcN3mfPelAhdZK
         AJIb3iaIsOIBPS2YL/IWt6kSS9r6nHqMp0Fw3BeaRUoyYzAjHzkTf7zcTRoS2wkh7YAy
         lyW/1ykD4bjw0yTjtS+ykWQ+7PJc43SGk6Q9gqhcQXJMi2ZF4OCDgP4C952qRUgmxy9J
         U52FLQElZCFUvGGrCvFOL3iwTSPkx6q9O1+a7m2E/avbpYSo7ww1vZ2kzjZMb12SkcuI
         yhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqZTBfg3/QOuM5T2ZYO9ec8lSodF69mZtRRrLvQ5Gfg=;
        b=K3g3n5qJ2/C3BvizNV+10vIC4s/XxfVDLP6hzHwYraDc3dUQ3c9EkLPopyeD6gHmBH
         ustxzizWXFjsaYcKN4vroOn1phO+iUTyAFQDbSjDiHexa3t7NgV4B355hhAu8ZApnZdv
         2POhEJxGMP4hec8VazkDJ1n6BYuGYaOdwvBl809JFU6z/hlP2hcPkAGfgfVxnUwcGehU
         Zg98dfCrTqRCLr8NwLu1fv5sly2GbxeZZlC59pW+TsqF7w/exGWQHqp8KRIyGvhlrSaA
         fXugSQgkywLS03nMrEnZTdxsBmTOT3BLB14Yk0DO1Y2iscIH2M4ZZcKLaRDGv5KDfGyc
         24nQ==
X-Gm-Message-State: AOAM533/NMWPn3sDwMTfIV3DiBVUTwf9+SVDJyEoHknXWRbh7BO5IM6M
        uCXwYjQjj80f6pqhhQdMLaCorA==
X-Google-Smtp-Source: ABdhPJyPXPZb1/+CaHCnBr8Ol7WULnfQkgqWGf4T4Nr8NuvNfEd/PW9dkr0l7RbAfIRcQU2v2AWLDw==
X-Received: by 2002:aa7:9287:0:b0:44c:767e:4e71 with SMTP id j7-20020aa79287000000b0044c767e4e71mr46146pfa.76.1634139255958;
        Wed, 13 Oct 2021 08:34:15 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j4sm15968517pfu.94.2021.10.13.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:34:15 -0700 (PDT)
Date:   Wed, 13 Oct 2021 09:34:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: Correct the comment style of
 copyright
Message-ID: <20211013153413.GA4135908@p14s>
References: <1634092749-3707-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634092749-3707-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:39:09AM +0800, Shengjiu Wang wrote:
> Change '//' on copyright line to C style comments.
> 
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
> Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 63749cfcf22f..6f306fbd3448 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -// Copyright 2021 NXP
> +/* Copyright 2021 NXP */
> 

I have applied your patch.

Thanks,
Mathieu

>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/arm-smccc.h>
> -- 
> 2.17.1
> 
