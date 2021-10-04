Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2132D42159D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhJDRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:55:59 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45745 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhJDRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:55:58 -0400
Received: by mail-ot1-f41.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso20429227otb.12;
        Mon, 04 Oct 2021 10:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5nlzijdbNHSPUzm3vepUm4dVX+hSV9BzHyUb+pUG5I=;
        b=aUtqC9ymC4KMvaOjpEzTGFo1LvKZpEhPqKfyee+VAe0/0476ALVQqLeBPRv+3ong98
         tGlWim7cEaH5zMWHjjOv46X0y5qoTuqxPu27DHUWbpyqpDA14OwPeEoqs+oO4np7xnL1
         6muMwka2gfctiOc3gXTfMgdrKFsFFBuvKEQy4gL1Qsh09zZ/L/72WfZkh9pTyml5XWmF
         WSLV87KVdWkyptKn5v/QVY2ZTofRvXKjcXYZzy3jrObIHoYr1Khmw9xqPuoGijmmsa7p
         9nehfPEHsLeIUgTls62ajUgzrFmAECGoT0u78FT3ykV58FyP6Vuq4q0fXScgtXI31ShA
         XPwg==
X-Gm-Message-State: AOAM530BxgfkWg4+c59duwV1dgFdpcVEZi78L+EyjGtdC6YjR2SsMtas
        Dr03EZa7o0AVjPA+oWvV5g==
X-Google-Smtp-Source: ABdhPJyRHkyTqdMM9U8stJ+jjUmHsCK0RfQkAN/rSAT7LNpcurCpnMqcWk5tmdkyIWsw5GHOrshjLw==
X-Received: by 2002:a05:6830:3184:: with SMTP id p4mr10857388ots.218.1633370048722;
        Mon, 04 Oct 2021 10:54:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j8sm2921797ooc.21.2021.10.04.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:54:08 -0700 (PDT)
Received: (nullmailer pid 1557532 invoked by uid 1000);
        Mon, 04 Oct 2021 17:54:07 -0000
Date:   Mon, 4 Oct 2021 12:54:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: arm: ti: am642/am654: Allow for SoC
 only compatibles
Message-ID: <YVs/v7g8wwLq/ujb@robh.at.kernel.org>
References: <20210925201430.11678-1-nm@ti.com>
 <20210925201430.11678-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925201430.11678-3-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 03:14:28PM -0500, Nishanth Menon wrote:
> Maintain consistency in K3 SoCs by allowing AM654 and AM642 platforms
> just state SoC compatibles without specific board specific compatibles
> aligned with what we have done for J721E/J7200 platforms as well.

This is the wrong direction IMO. Why do you want this other than 
alignment?

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Motivation to introduce in V2:
> * Retain consistency with both "soc only" and "board specific" as two
>   schemes we support across k3.
> 
> V1:  did'nt exist
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index cefb06424a4a..30c3f5c70014 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -20,12 +20,15 @@ properties:
>      oneOf:
>  
>        - description: K3 AM654 SoC
> -        items:
> -          - enum:
> -              - ti,am654-evm
> -              - siemens,iot2050-basic
> -              - siemens,iot2050-advanced
> +        oneOf:
>            - const: ti,am654
> +          - items:
> +              - enum:
> +                  - ti,am654-evm
> +                  - siemens,iot2050-basic
> +                  - siemens,iot2050-advanced
> +              - const: ti,am654
> +
>  
>        - description: K3 J721E SoC
>          oneOf:
> @@ -44,11 +47,13 @@ properties:
>                - const: ti,j7200
>  
>        - description: K3 AM642 SoC
> -        items:
> -          - enum:
> -              - ti,am642-evm
> -              - ti,am642-sk
> +        oneOf:
>            - const: ti,am642
> +          - items:
> +              - enum:
> +                  - ti,am642-evm
> +                  - ti,am642-sk
> +              - const: ti,am642
>  
>  additionalProperties: true
>  
> -- 
> 2.32.0
> 
> 
