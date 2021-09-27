Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC12741A050
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhI0UoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:44:02 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40563 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbhI0UoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:44:00 -0400
Received: by mail-ot1-f45.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so26137547otq.7;
        Mon, 27 Sep 2021 13:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hji7akcvuO5eM1UUp+RrEAX7mi3AxOo6kOuq/SkIGuQ=;
        b=JeMnYMrTpBs6XYBGKqJr6ekop8eFGrOI7Skiwns8HDlyhA3YOuASc731tGlAdkSpB4
         YeODoTFImf2R2ogeTygv2t6B3TG2aKoZmBpnwcSNaxpUgJ2tEEEQfcRFKLRpLN8yUBiI
         4/uBQL9QHS0LboManTjFZyLRjxjsi+NAJbxJIKuFcxSE/mxRR6RqGf7XP+3ZTL5PrwLy
         2BUMQvIztSa/GoLxF1HQrz47zLvJ4kto+wos0/GXKSFJDN/hIaU8G/ACdC62yQm+kBlu
         xUMO4DvW0kwQlmpHEHLOiV5zEvuoSrkj8otq00Ka7bPeyzWOOiGr+3Fy/AUtev0zurO4
         OWNw==
X-Gm-Message-State: AOAM531hs5xhFSpzps/zBtHplkIK8wdNgyPj8wAjfIOVmXci7H8NSoS2
        tHMooo+DCC6xhrQSbUaTq8X9+CJbUw==
X-Google-Smtp-Source: ABdhPJwejblA5gyx9BZ3p1Qw0Qb7Xq1zwyrHnn9rcbAsouSYxs1UTT86dleyWiHW5RbZVxEMt93N0g==
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr1841811otq.122.1632775341311;
        Mon, 27 Sep 2021 13:42:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i23sm4079356oof.4.2021.09.27.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:42:20 -0700 (PDT)
Received: (nullmailer pid 3842138 invoked by uid 1000);
        Mon, 27 Sep 2021 20:42:19 -0000
Date:   Mon, 27 Sep 2021 15:42:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        a.fatoum@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2 1/6] dt-bindings: nvmem: add cell-type to nvmem cells
Message-ID: <YVIsq7JJ2A1NhB/w@robh.at.kernel.org>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
 <20210923110109.29785-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923110109.29785-2-qiangqing.zhang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:01:04PM +0800, Joakim Zhang wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Some of the nvmem providers encode data for certain type of nvmem cell,
> example mac-address is stored in ascii or with delimiter or in reverse order.
> 
> This is much specific to vendor, so having a cell-type would allow nvmem
> provider drivers to post-process this before using it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>  include/dt-bindings/nvmem/nvmem.h                  |  8 ++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/nvmem/nvmem.h
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2b6e92..8cf6c7e72b0a 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -60,6 +60,11 @@ patternProperties:
>              - minimum: 1
>                description:
>                  Size in bit within the address range specified by reg.
> +      cell-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maxItems: 1
> +        description:
> +          Type of nvmem, Use defines in dt-bindings/nvmem/nvmem.h.

I don't think magic numbers are the right approach here. Actually, I 
don't think we need any DT additions. 

Why not just have the consumer side just tell the nvmem provider what 
the data is and to translate it. The consumer side already has a name 
(e.g. mac-address) which defines what the data is and I think is pretty 
standard. If that name is standard, then you could pass it to the nvmem 
core. If not, define some kernel internal types to use.

Rob
