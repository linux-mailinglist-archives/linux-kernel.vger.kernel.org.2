Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA5389214
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354931AbhESO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347646AbhESO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:57:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C79C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:56:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so3620348wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TcnLMgk3EMo9jkH9TpEZzuKiB04bPbCebMcwHrbD+qg=;
        b=V+SdtypE4xlpNcukUIz7+rnbigJFfOWbTMO57yxPG7ZwijggmeShDYnwqZmmn56KxZ
         idYhyY742I/LYbfmVgqBm2hKUEzhVOhzAru6YtQ0DRnO2hWkI992SviytwV7DTSHB8Pp
         l5to2stUz2kFIVynuNcTQusV72v/brYjINEeRPg7HpyQB5GqJl72iyzyvRafD2ECViZf
         eyVJbGs/73jq4OTjuphwh7F4IPFLEnN3nOaoKeT+HnXRMfvhl8heKON+dMVgavWM6NX5
         AQp3zxzo8o9SJAI8tmlm4zzDfuUrCv8Dy006PFxiyjBD9tff3T8TYYdaWFlaja2/kwFs
         jooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TcnLMgk3EMo9jkH9TpEZzuKiB04bPbCebMcwHrbD+qg=;
        b=RkpN/D+//hvKAsjCEWLLaAN1Kh9LTEcx6hleCmTPo+srdMIop7YI/nqISNO9ey072l
         yecm5sCJ94SlM1ZNjQh7dZ4y4RypqKs2+X7DcSdQPLt7GCMlNUYY9I2nvuNdX/GUu92t
         iVPEIT4Eo6BwI+QuTlw9u1A7DALwGqbAQkGN2Ix1qsL8p4h8STopWdBcRfpl7P/m+rvG
         cRSG77P01H+vQrv5xienwKBR7N7GyscFtmnAlW2VawKdA5r5xmraPRRamWDpmNoyDW0G
         FbOfAxf0uzUucla76cgAqFhQBpA+xRvMGQ63NGJSeNEyxOPFEgJ28lYQ/TfEOXzNGGCY
         0JnQ==
X-Gm-Message-State: AOAM531hyNdXCjQgv0Aig4CpnFaD49JtNurKl5zhbjNMjj/mH0WIQXue
        zxuZ34XktuhEWQMKMxIu3Bo0bg==
X-Google-Smtp-Source: ABdhPJwWi8UfWY+BRIFIIJjxTyVXDEB86reqO42x2vcnTAmYtjeygpZmvCXKoTSMEvPTxFwYAC0MJw==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr12017892wml.81.1621436188766;
        Wed, 19 May 2021 07:56:28 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i1sm19318338wmb.46.2021.05.19.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:56:28 -0700 (PDT)
Date:   Wed, 19 May 2021 15:56:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v8 0/10] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20210519145626.GH2549456@dell>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Gene Chen wrote:

> This patch series merge different sub-device I2C read/write into one Regmap and
> fix coding style for well-organized.
> 
> Gene Chen (10)
>   mfd: mt6360: Rearrange include file
>   mfd: mt6360: Remove redundant brackets around raw numbers
>   mfd: mt6360: Indicate sub-dev compatible name by using
>   mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
>   mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
>   mfd: mt6360: Rename mt6360_pmu by mt6360
>   mfd: mt6360: Remove handle_post_irq callback function
>   mfd: mt6360: Fix flow which is used to check ic exist
>   mfd: mt6360: Merge header file into driver and remove unuse register define
>   mfd: mt6360: Merge different sub-devices I2C read/write

All applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
