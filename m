Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3B436091
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhJULro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJULrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9306C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:45:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g141so351323wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=owpULBMgb/o8W8Jj/XFDSTD94XSBfwHWWJu1e1uw3tA=;
        b=H2cELnypzD0Rp+TToSUjL0RPhteHXb7suFNso9RvMEtpe+0xldeq/lfyRe9nMO6S+q
         Tizacz76S6G0aZCu084DYZiRJ9kcWDokUr7WSTLX7VhNnAQ8xynccV1jEa7SOy+gw3Ex
         YAx9vh4Gqbreq/uW0bZor2bUAz1JZ3S6PRD5BRsyqeZh36WIDGHcsopDSo6CwSPcRUgc
         LCqigOANv/KHG5ig++u9ajQiv2yFRLw+0tCQbaXHsTOcbpbJd3nzud2RNQyj/HFl7haD
         0bT1l/A8w564GQEKqc7vcpi6hjVl04Z75rDtqT9uWNqP6rDuOj6O9vRoM+Ngx3UVcJRC
         9uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=owpULBMgb/o8W8Jj/XFDSTD94XSBfwHWWJu1e1uw3tA=;
        b=cfPaK1X4znuCgmmkrvfS3GysfIZcV7EP9zNngfSCEUFLreswfAFAqkswLucryuc3ZZ
         /8NUwPr1YZLYIYLAS9k9DJvJM5X9YvJqudVKgukRVh+xLzQScvGpNWM7Ggm9x34unKK3
         lPuhlU7/8OmmSAzOUnzc1FkDm6mWDnOzRy8wGAZJDxASVlswRJyLIFV3Vy8RT9yn5PQR
         +zlbJYvhgks8XlYT55xEtMe0CA2eF2kEhMVyLeeA9QITTBl2HMt206taOOk9p9PfvTlh
         fkyMmSgH9/+lSiNiSPCy+Nl+2fltu224pNzihABPw8MJo0uIf1FxWMAwaEEj67G3jbPj
         Z+Rw==
X-Gm-Message-State: AOAM532FOdQMN+5FOninwlDsAEwljuImApSU4mg+Px0+5H2zanzNeNIg
        BX/7pwFQjHSDmS+1Xxdz4V60rQ==
X-Google-Smtp-Source: ABdhPJwDORk+sA/o+SuCvqs+xZT+ZhRzur5pLydG2pK3EW9E1c++e7AJ3bCNaPdQhjBhqJK4a8zoeg==
X-Received: by 2002:a05:600c:4999:: with SMTP id h25mr6246328wmp.140.1634816716515;
        Thu, 21 Oct 2021 04:45:16 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id r5sm7453016wmh.28.2021.10.21.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:45:16 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:45:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mfd: qcom-spmi-pmic: Document ten more PMICs in
 the binding
Message-ID: <YXFSypuLcHTJZoPp@google.com>
References: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
 <20211017161218.2378176-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211017161218.2378176-3-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021, Bjorn Andersson wrote:

> Update the binding with eight more SPMI PMIC compatibles found in the
> PMIC info list in the Qualcomm socinfo driver and add the two PM660
> related PMICs supported by the SPMI PMIC driver but are missing from the
> document.
> 
> Then remove the duplicate entry for pma8084.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Rebased on top of sorting of entries
> - Added the two PM660 related PMICs from the binding
> - Dropped he duplicate pma8084 that showed up in the sort
> 
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.txt        | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
