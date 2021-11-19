Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F41456E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhKSLZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:25:24 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:62593 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhKSLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:25:23 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ad7541a7;
        Fri, 19 Nov 2021 12:22:19 +0100 (CET)
Date:   Fri, 19 Nov 2021 12:22:19 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Janne Grunau <j@jannau.net>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211116215315.22528-2-j@jannau.net> (message from Janne Grunau
        on Tue, 16 Nov 2021 22:53:14 +0100)
Subject: Re: [PATCH 1/2] dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
References: <20211116215315.22528-1-j@jannau.net> <20211116215315.22528-2-j@jannau.net>
Message-ID: <d3cae91e2229c404@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Janne Grunau <j@jannau.net>
> Date: Tue, 16 Nov 2021 22:53:14 +0100
> 
> This introduces compatible strings for both 2021 Apple iMac M1 devices:
> 
> * apple,j456 - iMac (24-inch, 4x USB-C, M1, 2021)
> * apple,j457 - iMac (24-inch, 2x USB-C, M1, 2021)
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Minor nit below.  Maybe not even worth respinning this series for.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index 1e772c85206c..1416ed3a5623 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -12,12 +12,12 @@ maintainers:
>  description: |
>    ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
>  
> -  This currently includes devices based on the "M1" SoC, starting with the
> -  three Mac models released in late 2020:
> +  This currently includes devices based on the "M1" SoC:
>  
>    - Mac mini (M1, 2020)
>    - MacBook Pro (13-inch, M1, 2020)
>    - MacBook Air (M1, 2020)
> +  - iMac (24-inch 2021)

iMac (24-inch, M1, 2021)

>    The compatible property should follow this format:
>  
> @@ -56,6 +56,8 @@ properties:
>                - apple,j274 # Mac mini (M1, 2020)
>                - apple,j293 # MacBook Pro (13-inch, M1, 2020)
>                - apple,j313 # MacBook Air (M1, 2020)
> +              - apple,j456 # iMac (24-inch, 4x USB-C, M1, 2021)
> +              - apple,j457 # iMac (24-inch, 2x USB-C, M1, 2021)
>            - const: apple,t8103
>            - const: apple,arm-platform
>  
> -- 
> 2.33.1
> 
> 
