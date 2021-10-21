Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EF4360AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJULsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhJULrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D765C061762
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:45:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y16-20020a05600c17d000b0030db7a51ee2so7091029wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F+qAS+mhY6yRfCRNETby0UpQHRseEdMMofPhAfH7ev8=;
        b=Pwk6viT49X+syXYKYWNK1KKREh4DtPRMQG9EV30yd3vyA1O15WFi1wpeTMAgll/opz
         RksxPNrDeGpjN+Z8omHmyNG4ZJ/4x8Pf/ivMm0XE79c4wx5mrUx/eVnF6oy0qEnZlJ25
         cracL6jn0GfyUSc+FuNl0eS10ghCBuT6SYGJOUT+htgcVoe3lxDnDP2d/Zt9lwuyUaW2
         SyqzDus3GPjQqyBcuhXWPeTo/S27vmJ96BmDLj24OM0DEdYJX5tLR9OPDmDxgyxq7NPf
         jhr/Nd6kA18TacC6uQ4iatMS6OmFX81aOxCB9yaRes+aqic1o3AXv8fPBk+Hqiz2qc4K
         RAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F+qAS+mhY6yRfCRNETby0UpQHRseEdMMofPhAfH7ev8=;
        b=4NxZ5CfiPr+Ygg2HlR0Plo203pdSWnMqNXXzcIU7JoqrF4IEjLek0S0jZKeA50KwYW
         H9rj9bw7AQtkt0sInDZPmOcvpGvfSbT/+3wpDmQEWBM+lnCir7ro+5KMSjYj3HiI3AZb
         3xE4sUHijHS2kjWaYWDYrdAu6C/8OmMqOQAbV7BrUIfbiehsMol8ihArRJlsqek6pPsn
         +w89mKNJRsUMxRhlf11cX+ICmlJCMg9jwzBW+HfKBi/7pOCqRW9jBVjcVVs7C3mg3EAu
         OSzbfgiuXAN2Eh2K0rOB1+ZTE7jta9lFSaIVbBDZ64IKlZXiLFSqVE7S2pBGOApuKs8G
         R4hg==
X-Gm-Message-State: AOAM531T/ge/c58U5YapmLHEBRn6rtGPsr/KG1qkX1gvqOmzfUBmg2mi
        lw6C5Mq1v029oFPTUR9VZVW6+A==
X-Google-Smtp-Source: ABdhPJz7QOQP57aRGeoLHQetlmKk3gOhEUiZirCaK9m0eg6DgYnQhpdyWktuOyZPjcs78zytWDh0Cg==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr5889196wmq.54.1634816735665;
        Thu, 21 Oct 2021 04:45:35 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id o6sm6735697wri.49.2021.10.21.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:45:35 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:45:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: qcom-spmi-pmic: Add missing PMICs supported
 by socinfo
Message-ID: <YXFS3Y1Q0QtqR93b@google.com>
References: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
 <20211017161218.2378176-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211017161218.2378176-4-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021, Bjorn Andersson wrote:

> The Qualcomm socinfo driver has eight more PMICs described, add these to
> the SPMI PMIC driver as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Rebased on top of sorting of entries
> 
>  drivers/mfd/qcom-spmi-pmic.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
