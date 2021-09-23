Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B31416752
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbhIWVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:18:32 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35785 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbhIWVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:18:30 -0400
Received: by mail-oi1-f177.google.com with SMTP id r26so11638399oij.2;
        Thu, 23 Sep 2021 14:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/f4AHHRdRW+3g3wdAbD0J9aL+Gks3wUXuaKQ0f0gkq4=;
        b=B970IXPsRwkJuGDkfIrBG6GAEP3mzV3hIL82B9NwStF6jE/mV8cYVkosr7YwzZNyaH
         SLUjO7oHdmPxVhJnEIEoxVdK1s30Ayt6ncN9yndn4XKi9cXWtgLWMMm635H9vAlOjucb
         hZPHRj+krznFIM/mmppxzi8MAB0gaK8a/jADHPpwfcBNDn+Ep7mXn8F2Ze2vG+KUsmzs
         L2valdUAfv4p9mKJk1Si77DwjOZFSE/HwKAo9+A0gzBDGPjPhYsOCmguSr9WtBVcKJMC
         eYPIM0THaQDOk4U658EgwdCCXtOXrkGZoz+Sge7ctJM+28aowlGixtc2Nr3hOLfU5sPw
         KNNQ==
X-Gm-Message-State: AOAM533Y8qqMTVwdpxzbT0CNC5e6thOkmR0Wff4AZdE11e/t24Oa44xX
        Zq93f2TS8W///1Bi4pzKID4syB8sQQ==
X-Google-Smtp-Source: ABdhPJyjnbGyXDuseomVN28gvlhD5ToYQGcGjQ65EvrEJWciUBhlPh21NfkUxDKaeRJKP2TtpqjPwA==
X-Received: by 2002:aca:e004:: with SMTP id x4mr5374784oig.155.1632431817998;
        Thu, 23 Sep 2021 14:16:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w1sm1570455ote.41.2021.09.23.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:16:57 -0700 (PDT)
Received: (nullmailer pid 3539187 invoked by uid 1000);
        Thu, 23 Sep 2021 21:16:56 -0000
Date:   Thu, 23 Sep 2021 16:16:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
Message-ID: <YUzuyG3e7sHlMHAJ@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:14PM +0200, Krzysztof Kozlowski wrote:
> Document bindings for NXP SE97B, a DDR memory module temperature sensor
> with integrated SPD and EEPROM via Atmel's AT24 interface.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> index a7bb4e3a1c46..0e49b3901161 100644
> --- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> @@ -10,6 +10,14 @@ maintainers:
>    - Jean Delvare <jdelvare@suse.com>
>    - Guenter Roeck <linux@roeck-us.net>
>  
> +select:
> +  properties:
> +    compatible:
> +      const: jedec,jc-42.4-temp
> +
> +  required:
> +    - compatible
> +

Is this supposed to be in the last patch? And why is it needed?

>  properties:
>    compatible:
>      oneOf:
> @@ -31,6 +39,7 @@ properties:
>                - microchip,mcp98244
>                - microchip,mcp9843
>                - nxp,se97
> +              - nxp,se97b
>                - nxp,se98
>                - onnn,cat6095
>                - onnn,cat34ts02
> -- 
> 2.30.2
> 
> 
