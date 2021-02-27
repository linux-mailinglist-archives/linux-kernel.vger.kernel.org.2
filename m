Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645FA326D91
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhB0PXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 10:23:00 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36163 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhB0PW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 10:22:56 -0500
Received: by mail-wm1-f41.google.com with SMTP id k66so10293742wmf.1;
        Sat, 27 Feb 2021 07:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQ0jQvljWC1Cpofq8w2gxQ4jTmtNN1UrFwscqKNWRJo=;
        b=JYXpEzzMP66EBBrhgCjRTUGXIghnpb5GML5QWWhVcyhsAm4BzCIdelNn8Te4yM878L
         yxu8L0VPP/HDxgH/t/NLKtqNxD57HFKmKhGDF6tacVtSiSmQ9q7CsWYhtiXAl7tfPH3v
         zIUcnQehzz20W8WmC2+v6Qdtw2T4MzD08xqc7frHARbbCJfSUVMMEI9Io+d6xN0GwS37
         rsv5QaZrhFvZLvMjeUjRsS+BUU9tF5/eQcMjfwaLNl5lJn2sCONJo+fhWhSt3563aosm
         Si91x9OmepKumd3oSCPJIO1KyEuMef3A1ckGTAUFoFEpn7jUsoWOcE62GpOaICapAGjS
         UYSA==
X-Gm-Message-State: AOAM530FEY5N2K6POF5UMAiCBPJ90p+SCoFN/U5tpTZjAA3Q4B9Ynn6Q
        AJT3FaTZ6aZm6NDTz0vTJvk=
X-Google-Smtp-Source: ABdhPJz1royC3N/Npfp8qAexo7Zogmu/5x/Bitfxp9RnmEh6JsEIKkYDIkvX4T+GH8oGJrYxE+KWwg==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr7628407wmq.72.1614439333112;
        Sat, 27 Feb 2021 07:22:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 18sm1923343wmj.21.2021.02.27.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 07:22:12 -0800 (PST)
Date:   Sat, 27 Feb 2021 16:22:10 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini EDIMM2.2 Starter Kit
Message-ID: <20210227152210.aivgw7f5gvb2vuju@kozik-lap>
References: <20210225192404.262453-1-jagan@amarulasolutions.com>
 <20210225192404.262453-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225192404.262453-5-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:54:03AM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
> Board from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Evaluation board for
> creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v4:
> - collect ack's
> Changes for v3:
> - fix dt-bindings
> Changes for v2:
> - update commit message
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
