Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E2400300
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349914AbhICQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:13:47 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46753 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhICQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:13:46 -0400
Received: by mail-oi1-f180.google.com with SMTP id w144so6940333oie.13;
        Fri, 03 Sep 2021 09:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvgYFsx7JkvAvbs4I+EYjfllF89MEhjbKB8Qj4RbTIk=;
        b=WWnMvhugHdhs/uRJNfcV9AFCcbHp/btX7ddvfYFawR9fM0fMrFVFh78KGnPms38ZAi
         M4SYE6DaDwJoNExB1hH366Ttf80a1xeBwVl5KFyWCFL6A0GyeEDjiRLOcrCPlyJ4K4QW
         OUoIaSOKXCvNGwOgBJdqRdQGYPI3xTUZffag5ylaRaT4IV0L78DQDiezlgxRqvzn7Ikg
         fLLOpqjpDFBChg+HvAOPvqwY8IG5ZmvPN269xzJL7B7RK9hnoX1uH5TZXDbP62rK6y4Z
         ZHAYVxbGlCgnFc0phHtwTvIbiY9xrgi1rarjqyyK86SkZF8zfrFlnDFLGbeTfZvKVMMi
         pGeA==
X-Gm-Message-State: AOAM530d6S6N9FYXp12GzxJkQ7jc+fc7oqg2vH05dTYxrGllf18mdz0a
        /SdQ2aLa3LUXrHmMjQIb0Q==
X-Google-Smtp-Source: ABdhPJxRYNJlQgvYYbFWW07WdoSyaiCENii55qZiH/55LM5bKtIGHB1L/hmPsjClxd+sbONrGhMPWQ==
X-Received: by 2002:aca:c2c6:: with SMTP id s189mr6917016oif.123.1630685565736;
        Fri, 03 Sep 2021 09:12:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g62sm1090059oif.14.2021.09.03.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:12:45 -0700 (PDT)
Received: (nullmailer pid 3032881 invoked by uid 1000);
        Fri, 03 Sep 2021 16:12:44 -0000
Date:   Fri, 3 Sep 2021 11:12:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, lokeshvutla@ti.com
Subject: Re: [PATCH 03/14] dt-bindings: phy: cadence-sierra: Add binding to
 specify SSC mode
Message-ID: <YTJJfJE4kFLt059y@robh.at.kernel.org>
References: <20210903050054.25627-1-sjakhade@cadence.com>
 <20210903050054.25627-4-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903050054.25627-4-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 07:00:43AM +0200, Swapnil Jakhade wrote:
> Add binding to specify Spread Spectrum Clocking mode used.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml      | 9 +++++++++
>  include/dt-bindings/phy/phy-cadence.h                    | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> index e71b32c9c0d1..a9e227d8b076 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> @@ -113,6 +113,15 @@ patternProperties:
>          minimum: 1
>          maximum: 16
>  
> +      cdns,ssc-mode:
> +        description:
> +          Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
> +          EXTERNAL_SSC or INTERNAL_SSC.
> +          Refer include/dt-bindings/phy/phy-cadence.h for the constants to be used.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        default: 1
> +
>      required:
>        - reg
>        - resets
> diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
> index 4652bcb86265..0122c6067b17 100644
> --- a/include/dt-bindings/phy/phy-cadence.h
> +++ b/include/dt-bindings/phy/phy-cadence.h
> @@ -17,4 +17,8 @@
>  #define CDNS_SIERRA_PLL_CMNLC		0
>  #define CDNS_SIERRA_PLL_CMNLC1		1
>  
> +#define SIERRA_SERDES_NO_SSC		0
> +#define SIERRA_SERDES_EXTERNAL_SSC	1
> +#define SIERRA_SERDES_INTERNAL_SSC	2

Don't we already have defines for this property from the Torrent phy?

> +
>  #endif /* _DT_BINDINGS_CADENCE_SERDES_H */
> -- 
> 2.26.1
> 
> 
