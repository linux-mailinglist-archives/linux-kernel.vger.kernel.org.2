Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1A31C101
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBORun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:50:43 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34529 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBORss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:48:48 -0500
Received: by mail-wr1-f47.google.com with SMTP id n4so6986710wrx.1;
        Mon, 15 Feb 2021 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBlt8hdnbwWrMTzBbUx3g2G//xWNymm1S1ZIj4DF+7s=;
        b=I6QpNdPk2y5lzQFiOMHkfdvIlMNobzaNc1jVw86MBcdLzzEgcXhcLEMtH0FT1qZDfs
         2bRpTHKR1sPebtCAOqH680u/NIDi4YHPC+OZPvfZTFVC125yKK26IdAsDAtyLDFo9gFZ
         F0/YXw24aEaEv+jDfaaKgXeegZ6SN71SR74/y3eUUstACINmihXjVUIEu02xzAQLDjYp
         qo35brL+JuSbKIvJ75irc1lRcqTA1L9bNkhHYzZtBwqj2YAN1VlDHmhD7OGZjo8gBDcf
         rmbQvJt1uQGvLBuHzmUneGVzS03n/qCqqtwEPE7g0QW7LkfVreYaPwLDmASTke3bmFlH
         2UkQ==
X-Gm-Message-State: AOAM532x/rvDalZyxU6J9Ze2Y/iZh7eLVsvS4PEargYpeDrBXuVWfYpe
        xGph0yVWcw29eNVa1tIc2Jo=
X-Google-Smtp-Source: ABdhPJx+KHSEChy4DVPIQ1LyHCjxJyXMIRlU9RF+1H1jXZX0zpJkXNxd3aSuklgB10SNpAht51Ev7Q==
X-Received: by 2002:a5d:460f:: with SMTP id t15mr19219757wrq.417.1613411285858;
        Mon, 15 Feb 2021 09:48:05 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 17sm52584wmf.32.2021.02.15.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:48:04 -0800 (PST)
Date:   Mon, 15 Feb 2021 18:48:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] dt-bindings: arm: apple: Add bindings for Apple
 ARM platforms
Message-ID: <20210215174803.5oalkkmotpc7d7vm@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:16:50PM +0900, Hector Martin wrote:
> This introduces bindings for all three 2020 Apple M1 devices:
> 
> * apple,j274 - Mac mini (M1, 2020)
> * apple,j293 - MacBook Pro (13-inch, M1, 2020)
> * apple,j313 - MacBook Air (M1, 2020)
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/arm/apple.yaml        | 36 +++++++++++++++++++
>  MAINTAINERS                                   | 10 ++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> new file mode 100644
> index 000000000000..e44d308d6bde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/apple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple ARM Machine Device Tree Bindings
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple ARM ("Apple Silicon") platforms should contain compatible strings
> +  in the following format:
> +
> +  - apple,j274 (board/device ID)
> +  - apple,m1 (SoC name)
> +  - apple,arm-platform (Apple Silicon)

This description is irrelevant because the rules come from schema below.
Maybe instead write few words about the platform? Or describe how to get
the board/device ID if it is not obvious?

Best regards,
Krzysztof
