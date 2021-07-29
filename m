Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964493DAE15
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhG2VT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 17:19:28 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:41913 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2VT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 17:19:26 -0400
Received: by mail-il1-f181.google.com with SMTP id j18so4289039ile.8;
        Thu, 29 Jul 2021 14:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZxbXjNJPmaats8JOtBxvMyMGEAJyQ7EcVf9p6TLrxag=;
        b=g0SUhrF5y2a2g1o57zSypx89kbCwfPqmIz51yG6kNsKix2L5+c9KVIzpWTwwkjAlkz
         BTjo4g1df4uvZ37UvjlOaB+mh5IgI3x9bvJyxUy9Rh7sbtWzv/dQTj6+WuuyhG177eFZ
         qcfFBq6NQ3Lp7eaYgrV9aFr23BYErTEJ87PYYeRJYVvW/mg+GJYF7UNHvSwX6Du5U40s
         yay8Ne+WQ3mICwFgviZUEdVkKtfDYp/nTtlmg7jCR0APnuAov/cdRO88LdPrxyjwi3OU
         GvStGgT3Q/QarP8GoquzIaJOTh1TyxuALp7J1azVNU5tdqI/r+zoNTel6LKHCSNoxiBa
         HSSg==
X-Gm-Message-State: AOAM533r88G79ZhMo/URaxmjllhTwJ/kal6TxqlfQD2UWB0mouSMDHr/
        ayFn+Y19uBSVXG5WSC5J/A==
X-Google-Smtp-Source: ABdhPJzjT567vzS1PYSB5pmxP78UKspCQnniQ22XMj0Plnn7kuFWQumJFbUxQ0hMW2RE7PV8HnvM8A==
X-Received: by 2002:a92:905:: with SMTP id y5mr5074091ilg.222.1627593561701;
        Thu, 29 Jul 2021 14:19:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h1sm2813888ioz.22.2021.07.29.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:19:21 -0700 (PDT)
Received: (nullmailer pid 909346 invoked by uid 1000);
        Thu, 29 Jul 2021 21:19:19 -0000
Date:   Thu, 29 Jul 2021 15:19:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: add "syscon-smc" YAML description
Message-ID: <YQMbV3elkU0yp92D@robh.at.kernel.org>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
 <20210723135239.388325-4-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723135239.388325-4-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 03:52:39PM +0200, Clément Léger wrote:
> This patch adds documentation for the "syscon-smc" compatible which describes
> a syscon using a SMC regmap instead of a MMIO one. This allows accessing system
> controllers that are set as secure by using SMC handled by the secure monitor.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  .../devicetree/bindings/mfd/syscon-smc.yaml   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon-smc.yaml b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> new file mode 100644
> index 000000000000..6ce1392c5e7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/syscon-smc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: System Controller Registers R/W via SMC Device Tree Bindings
> +
> +description: |
> +  System controller SMC node represents a register region containing a set
> +  of miscellaneous registers accessed through a secure monitor.
> +  The typical use-case is the same as the syscon one but when running with a
> +  secure monitor.
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - items:
> +          - enum:
> +              - atmel,sama5d2-sfr
> +
> +          - const: syscon-smc

I regret having 'syscon' as a compatible, so nak on a 2nd flavor of it. 
It's only purpose is a hint to Linux to automagically create a regmap for 
you.

All you need is the specific compatible, atmel,sama5d2-sfr, and you can 
imply the rest of this from it. That's assuming the conclusion is a 
register read/write interface on SMC is a good idea, but I don't think 
it is.

Rob
