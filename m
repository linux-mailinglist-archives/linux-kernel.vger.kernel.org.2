Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21865424780
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhJFTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:51:52 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:44690 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJFTvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:51:50 -0400
Received: by mail-ot1-f43.google.com with SMTP id o27-20020a9d411b000000b005453f95356cso3631091ote.11;
        Wed, 06 Oct 2021 12:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QURG1YE04DgnXgRCyRnVrI2DoODcIxUVnwws0FRNV+I=;
        b=rKQNVYpINbgxtwuJhxy4f0C9T57zRqqizoUNaV+QSYySdG84nWvGAb04sRwTImr3hj
         4VOiEjstSTHg0fPP7jZTohPDvHMWPijHm+SM4SOOrThQwYDOu3XwTkviwqPFXWT3+GIq
         5c7VCgn9iSanFfSX//fBRjEqQNggDYbtbaMYIR7oBZeSJApFvQlHrB59+iMSpzWSq4Qh
         awkW0jLNkCCH7XeX0itMb1wLw2E5OZzAc6Ay/VH9FWxYCEjqvVirgZGBJNwFQfWWRAOI
         XLb/vc8UJYR+x4oyNoEXzYJYzbt4z/+hAlhQzL/ReMoXuKqClGlSk+NM0G18DzSAcFT8
         4s4w==
X-Gm-Message-State: AOAM530NJ4uLYKO8gRgveHrk0BEAxQW8T3173kpn1INzyUwtHl2ouB4k
        UyPaWUl22tP4yVeiC2s3zZn7Bhjppg==
X-Google-Smtp-Source: ABdhPJwF8X4Z3koy6hAnPDxxJv3ycNQJxe7qIj+sHmmvSPb08ew15a5fxX4TEtlxD0r6rNDQ6s0W0w==
X-Received: by 2002:a9d:3783:: with SMTP id x3mr143321otb.16.1633549797894;
        Wed, 06 Oct 2021 12:49:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v16sm4164439oiv.23.2021.10.06.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:49:57 -0700 (PDT)
Received: (nullmailer pid 2563184 invoked by uid 1000);
        Wed, 06 Oct 2021 19:49:56 -0000
Date:   Wed, 6 Oct 2021 14:49:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: uniphier: Add clock binding
 for SoC-glue
Message-ID: <YV395BTH/gqcuDJH@robh.at.kernel.org>
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:09:14PM +0900, Kunihiko Hayashi wrote:
> Update binding document for clocks implemented in SoC-glue.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/clock/socionext,uniphier-clock.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> index ee8d16a8019e..05a9d1f89756 100644
> --- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> @@ -46,6 +46,9 @@ properties:
>            - socionext,uniphier-ld20-peri-clock
>            - socionext,uniphier-pxs3-peri-clock
>            - socionext,uniphier-nx1-peri-clock
> +      - description: SoC-glue clock
> +        enum:
> +          - socionext,uniphier-pro4-sg-clock
>  
>    "#clock-cells":
>      const: 1
> @@ -95,3 +98,16 @@ examples:
>  
>          // other nodes ...
>      };
> +
> +  - |
> +    soc-glue@5f800000 {
> +        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
> +        reg = <0x5f800000 0x2000>;
> +
> +        clock {
> +            compatible = "socionext,uniphier-pro4-sg-clock";
> +            #clock-cells = <1>;
> +        };
> +
> +        // other nodes ...
> +    };

What's the value of this 2nd example? It's just a different compatible 
string.

> -- 
> 2.7.4
> 
> 
