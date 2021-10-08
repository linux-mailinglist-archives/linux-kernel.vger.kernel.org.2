Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B155E4272D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbhJHVI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:08:25 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549EC061570;
        Fri,  8 Oct 2021 14:06:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t4so13548738oie.5;
        Fri, 08 Oct 2021 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPmTBexJ6pfCTZz94LBqYt7PnBRueakfJWUtT0QCH4g=;
        b=aqfjG35zBT9iRNrfwWJnVrHed+sCfYP+Crgbl8yVAlcoR4a3jzPvEc8OZBKG632LbP
         Qc1/F5rLQjR20yK7/ptQGGhW/Iez4YJB7R4yvGQ2QJo8e5SU21Tf/vxXd+QTITpUnl+E
         VVJUx9z3Beu83RjguktHGWNDfD8RycX8hlsh58FX78qDyg+YjYjXdsqnKpLyZzgIb2FN
         usj2PxmkuVzwpCauHmwkm+nyKoMdLtW1aRlFgOxoyGwSfBjyNtHivPZa81tBHIb+QiO3
         +1AMan6ap0M9/0Dli6HQlB5ee7j1Wrhdtjj1uoh1Gq1P5iZ6CMbLGmFmwAbRnZ/zojxd
         6SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qPmTBexJ6pfCTZz94LBqYt7PnBRueakfJWUtT0QCH4g=;
        b=CA9NUol/BYzJD0VESBCM8M8kUZzIAExvL636yr2VjDnnbOHPKTDF9eOSZiZzKZJNAO
         XniEpPDMpMBITFnYYdePrqFrGMxyVraKHx9Vg2ZYtGAFNngQgLEfth3GOY9QU80/jOsj
         FuUF8mzOgRLyiqsz9bVdIj5VanKYcOuxLXwyzw9Yd63CkK8VfrCMlwHIHjGgrjFMkfuN
         R2GsLG8p5+ChVe62wNPQPjdwG4n4t2dos/nukrZ1ghXBZBExXdteOMwD+dZkaV2SgpRW
         bhrHDjZ/HBe9LwZg0H25Jz/rUpJkr1O0dvr2CSY/aSOS05QEmUiA+nGZROvbGB2z44bp
         dQNw==
X-Gm-Message-State: AOAM530K1R6bpfLAS+5KKUL4xgJUQ7W2N3cE61M40l3dffoHZE+VdWtU
        I7IGHsgdmO340SOiETs0ur4=
X-Google-Smtp-Source: ABdhPJwX80AfO8/LZudx3BdT413rflaUSp+dkWAMwpRi9u92TuRSovmr2n3E8/gpJDaqitET4wdffQ==
X-Received: by 2002:a05:6808:13c3:: with SMTP id d3mr9250250oiw.83.1633727189365;
        Fri, 08 Oct 2021 14:06:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm114112oii.0.2021.10.08.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:06:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 14:06:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
Message-ID: <20211008210627.GA3473720@roeck-us.net>
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
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

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
