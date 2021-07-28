Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31BD3D9195
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhG1POH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhG1POF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:14:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C007C061757;
        Wed, 28 Jul 2021 08:14:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x14so3674203edr.12;
        Wed, 28 Jul 2021 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cv7Srx2vdGC8p5AayhAc1x36FU3CBrODDMXJnHccCXs=;
        b=BAQ14WaPG7i/wSxrFcSXycBXooHnTQa/gjTJk02yB44V6O6ikoHTL053m5pYmog1Ya
         cBfejhMflBDCitSugOOkpmERUovXnaJfDEssgqOYkqyJ8Lz+zGDLY5FKw+hsUn6WKFJ6
         fusYJYoqBlju4c/Ap8bHxgPWhetKX/E+ALuYAnYzQWPt/0gdW8bD/TJWBnGgSegxpcak
         4sT3omFomFhIBffRspi/Ll4NWtN0XM2n6rkk5vwkf4wfdymBUrZjIC3zzVT0PqphCp7B
         bSCuFMPzT/Qy7chhMcIdWz5akLZwLI87MKwhXXazCMRs2EnWS+MttTqlv6bUkLsYqWSq
         FaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cv7Srx2vdGC8p5AayhAc1x36FU3CBrODDMXJnHccCXs=;
        b=Frpg0ZJrnaRd/oQn4Mu/ncQm7Ngqafgaft9ZotC2b19NKKwGcxdWmUZIiamZ9kra1q
         c5WL6uCNlBw7dGeK1ZiVWAZHb9tJjSYFKeHZBzNgpfWZldJzzskD7n7T/CqSTVY8FJ5q
         uTAcLNV/gQze1TwaRtNfVj7Q+ohMUr8wJkwv0nzdCvZF2NIMHsQBocqsVQoOPQBXrWMD
         PRy1Bs90qAwedNEcHiqbCbCVyDmfOcSWq3+Qv9+AJyY+sCN6XqcqlmHyVzT0CX7lCn1/
         sCxatHyyaiP70Oqu2Frt6rdEt4bLv2d8eDTjiJQ+XXfBykUlXLriphH5WovavuKiqqgO
         i7Ww==
X-Gm-Message-State: AOAM531ijeXh1Kuv31dLx/Z0mu3EHIR/sVSt+MzFIBiEAe1O4jaKwDYH
        XnPPalphxg3a8M5HxQ2IYf+lId2iVZ8=
X-Google-Smtp-Source: ABdhPJzOKrXYtXnhEPbZymJ13hNwMm1ajsOCyGGeskMiqviw4wWP2s/b6Ev4HpY4ZUWrcb7xKFZP2w==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr359969edj.73.1627485242029;
        Wed, 28 Jul 2021 08:14:02 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b13sm20385ede.49.2021.07.28.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 08:14:01 -0700 (PDT)
Subject: Re: [RFC PATCH 2/9] dt-bindings: phy: phy-rockchip-inno-usb2: add
 rk3568 documentation
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20210728122606.697619-1-pgwipeout@gmail.com>
 <20210728122606.697619-3-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c7ea6f09-bed0-15d2-1124-44cf98898538@gmail.com>
Date:   Wed, 28 Jul 2021 17:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728122606.697619-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Some comments. Have a look if it's useful.

On 7/28/21 2:25 PM, Peter Geis wrote:
> The rk3568 usb2phy node is a standalone node with a single muxed
> interrupt.
> Add documentation for it to phy-rockchip-inno-usb2.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml   | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> index 5bebd86bf8b6..f16fea5cad1c 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> @@ -18,6 +18,7 @@ properties:
>        - rockchip,rk3328-usb2phy
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
> +      - rockchip,rk3568-usb2phy
>        - rockchip,rv1108-usb2phy
>  
>    reg:
> @@ -50,6 +51,9 @@ properties:
>      description:
>        Phandle to the extcon device providing the cable state for the otg phy.
>  

> +  interrupts:

> +    description: Muxed interrupt for both ports

My spelling checker suggest: Mixed. Don't know what's correct...

> +

For rk3568 only.
Could you test/use something like this?

if:
  properties:
    compatible:
      contains:
        const: rockchip,rk3568-usb2phy

then:
  properties:
    interrupts:
      maxItems: 1

  required:
       - interrupts

>    rockchip,usbgrf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -78,8 +82,6 @@ properties:
>  

>      required:
>        - "#phy-cells"
> -      - interrupts
> -      - interrupt-names

These are still required for other Rockchip SoCs.
Could you test/use something like this?

      if:
        properties:
          compatible:
            contains:
              const: rockchip,rk3568-usb2phy

      else:
        required:
          - interrupts
          - interrupt-names

>  
>    otg-port:
>      type: object
> @@ -109,8 +111,6 @@ properties:
>  

>      required:
>        - "#phy-cells"
> -      - interrupts
> -      - interrupt-names

dito

>  
>  required:
>    - compatible
> 
