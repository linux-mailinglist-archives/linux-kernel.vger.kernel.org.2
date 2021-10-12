Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B545A42A79A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhJLOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbhJLOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:48:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DA0C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:46:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t2so67746218wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RbIVq/UEdcc303XkmHmHl8p3Hwos0Z4AAzrjzZdBALI=;
        b=DU9GCSdjmbQDH4t2pDu84NBnFqarQaZSsu55xSBMjG9CuOeHu0S+r8gzFr7IuIvQnc
         sz3qWc0KiqJMIf1/O5UHJF/ZQyT9FSyiPvDTjThe/lPMMoVWQP94D7a3eb/Ed6O/gOzC
         qCrXwhx587iVKnxlmWxcYurRTQBfv8gZ/WC6qJX3EbBGc89eXNQfHo+VdRJSfGq2WyLT
         3DwUq/WNRTHFdnECHj5IphjGV/RrwTkdZ8tXxbTUmOiRf7EwEQGO5NBS8Gy6TCK6o7VC
         x/ND7fepNo8yjbelB1nDSrrx2+h3Zg5625L4ntpq//PcOSzpmeJ8Ym8ZKe+6SpxYGJzm
         NSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RbIVq/UEdcc303XkmHmHl8p3Hwos0Z4AAzrjzZdBALI=;
        b=zCTQhailhEcoBGN8ddJQzVjLXzyJdX3yGwqEitvVDY9qDdgRKDDkoYv0lP663CNxYb
         OGb9P0XleUYGbJPq38L64N6R/GOSZcYYgM3wpoiFsPZRzsXmYsIKwLddIb80Vb2B9xN0
         U+6zHGpUPyhEXR8txw6vgnplyEKtOowB69lIEu0BISLuYuOleyBnGeIN8qUDH91fOCFO
         Q08hj8IJQsJVbS2H7ufalPk4HZQb0U0rxRVcoYeVD84umGQxqXngMaLrCNBRxDrfBgC9
         O3WSnETu5Up4gn7zkC56bOMS+8vw3WFMSpr1+bgwXJdnIgXrRBXPNHoBmwwmgXFtW6kl
         rCZw==
X-Gm-Message-State: AOAM533wKuLIliRMmWnLzZ9n+47sw17WVNlRR9tMtJLTEbsUs/ltkM/y
        eGx8kZb+0gdg7QJ259/egPBurg==
X-Google-Smtp-Source: ABdhPJxncDBh31Ae/0zMNyUymugMmwtXjQ3mNw2WOuxjxw1IkmIyhIycZL34TQNU5ljpM7BBpBo+Cw==
X-Received: by 2002:adf:bd8a:: with SMTP id l10mr32155651wrh.159.1634050006604;
        Tue, 12 Oct 2021 07:46:46 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id d24sm2570330wmb.35.2021.10.12.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 07:46:46 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:46:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: qcom-spmi-pmic: Document eight more PMICs to
 binding
Message-ID: <YWWfkyoV0rF4C4PP@google.com>
References: <20211005024812.2038249-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005024812.2038249-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2021, Bjorn Andersson wrote:

> Update the binding with eitght more SPMI PMIC compatibles found in the

Spell check.

> PMIC info list in the Qualcomm socinfo driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> index 5ef79bf3d035..1d2b5f067556 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> @@ -29,6 +29,8 @@ Required properties:
>                     "qcom,pm8916",
>                     "qcom,pm8004",
>                     "qcom,pm8909",
> +                   "qcom,pm8028",
> +                   "qcom,pm8901",
>                     "qcom,pm8950",
>                     "qcom,pmi8950",
>                     "qcom,pm8998",
> @@ -38,6 +40,12 @@ Required properties:
>                     "qcom,pmk8350",
>                     "qcom,pm7325",
>                     "qcom,pmr735a",
> +                   "qcom,pm8150",
> +                   "qcom,pm8150l",
> +                   "qcom,pm8150b",
> +                   "qcom,pmk8002",
> +                   "qcom,pm8150c",
> +                   "qcom,smb2351",
>                     or generalized "qcom,spmi-pmic".
>  - reg:             Specifies the SPMI USID slave address for this device.
>                     For more information see:

Is there any reason why these can't be in lexicographical order?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
