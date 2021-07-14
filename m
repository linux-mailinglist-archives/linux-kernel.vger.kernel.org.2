Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62F3C7BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhGNC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhGNC25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E5286128E;
        Wed, 14 Jul 2021 02:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626229566;
        bh=q2PdHzCqATXUeZKM6+hoIoacmyqDU3erh9Knqgw1Bxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao9asw/isP/z/8L9nkkDnoU92da01q6wzhxtGgOK0YyEdTkGYG+sdVA3d0ouizAwZ
         VaskwPKGgxp5S9iAaTEvZcyj2Ioje51itTyqrMf4m6tYnBmXqy0IBMvP8lP9lC/zh+
         HHDkeyzPsxeSWo0XnPuMxxH4P4Ex9L0jeKjlOAMoJtO10YgvMyAiXQqkAOY/1/lxOm
         jgIfA46oKuoPEeRI2LsEyJgwC3zy0Zi1T+OpZP/AlInEXck2EKFDLxj6iqFCXl9wef
         OW9mjf2ThvRTBS4c0oAPCCBMdOuo3KQ4TNGkg51dKcCxBv3xvZzfx4ykWgaQtMG2a5
         EH+gJ9Z0U6skw==
Date:   Wed, 14 Jul 2021 10:26:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kernel@dh-electronics.com
Subject: Re: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Message-ID: <20210714022601.GB31370@dragon>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:30:01PM +0200, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: robh+dt@kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: kernel@dh-electronics.com
> To: devicetree@vger.kernel.org
> ---
> V2: Remove line with fsl,imx6s on the DRC02 Board
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++

In the future, please have this bindings patch included in the series
that actually uses it.

Shawn

>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index fce2a8670b49..3c4ff79a3be7 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -407,6 +407,12 @@ properties:
>            - const: dfi,fs700e-m60
>            - const: fsl,imx6dl
>  
> +      - description: i.MX6DL DHCOM PicoITX Board
> +        items:
> +          - const: dh,imx6dl-dhcom-picoitx
> +          - const: dh,imx6dl-dhcom-som
> +          - const: fsl,imx6dl
> +
>        - description: i.MX6DL Gateworks Ventana Boards
>          items:
>            - enum:
> @@ -458,6 +464,12 @@ properties:
>            - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
>            - const: fsl,imx6dl
>  
> +      - description: i.MX6S DHCOM DRC02 Board
> +        items:
> +          - const: dh,imx6s-dhcom-drc02
> +          - const: dh,imx6s-dhcom-som
> +          - const: fsl,imx6dl
> +
>        - description: i.MX6SL based Boards
>          items:
>            - enum:
> -- 
> 2.11.0
> 
