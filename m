Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD76460BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376595AbhK2AzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:55:01 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42812 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359483AbhK2AxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:53:00 -0500
Received: by mail-ot1-f53.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so23161374otv.9;
        Sun, 28 Nov 2021 16:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8ZqX9pdD5j9hMjlb9uRLwYcYiuTb59uMcwdnKLd2ek=;
        b=7HL3TWV/+QoPhUTSFMaqwrM19k2jH5tbotPGSSNrsk3980A9qKnLmL/Xw8S3aWD3Z4
         hTuj+Qo0a53mPmeBR7ipuvodBwu0KIakHM2UjcI4x61dnLpOJ/GX95/XACoa0IKiySH7
         duuPMe/dH4kCFVzS1kngqr99GYSQSHaR4sPAWr87nOJddG52iVvF33eghFBj7Bs+bzUH
         oymec6KtAbcTd2Skw6vKONtZqoW0PLPlXwF7Be96dM1q4E0iGEsRFR0j8evf9HuC1HdR
         QHgDM69iYEsZtl8L9ERTOC/xApEprD5wnGARIBF6p4UzZv1O+fIrfm2aG9E/UEcGGsts
         Dj6w==
X-Gm-Message-State: AOAM533DliNv0j/UmhsK3u87T4/TpJMGc0QwggAHEpmYLkAWqLxcmy5n
        lxT/oD2Wy6kUC31aTQj689pWLhFNaA==
X-Google-Smtp-Source: ABdhPJyjqPH7UBKpykD8d18qiJcvLvxSEq/mvU/9YMfqA5CMrRn74XFf74Rvyi/5rV7jhF6ws7wvYA==
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr40781466ott.62.1638146983129;
        Sun, 28 Nov 2021 16:49:43 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id d11sm2397699otu.36.2021.11.28.16.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:49:42 -0800 (PST)
Received: (nullmailer pid 2918224 invoked by uid 1000);
        Mon, 29 Nov 2021 00:49:39 -0000
Date:   Sun, 28 Nov 2021 18:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V3 2/3] dt-bindings: da9121: Add DA914x binding info
Message-ID: <YaQjo9KCFnPi+Qk/@robh.at.kernel.org>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <32e300765a1e3889d804e81efa393d4a6fee93e2.1637709844.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e300765a1e3889d804e81efa393d4a6fee93e2.1637709844.git.Adam.Ward.opensource@diasemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:27:57PM +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

Both of these need a commit message.

> ---
>  .../bindings/regulator/dlg,da9121.yaml        | 75 +++++++++++--------
>  1 file changed, 44 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> index 0aee5fcd6093..24ace6e1e5ec 100644
> --- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> +++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> @@ -17,27 +17,39 @@ description: |
>    Dialog Semiconductor DA9130 Single-channel 10A double-phase buck converter
>    Dialog Semiconductor DA9131 Double-channel  5A single-phase buck converter
>    Dialog Semiconductor DA9132 Double-channel  3A single-phase buck converter
> -
> -  Current limits
> -
> -  This is PER PHASE, and the current limit setting in the devices reflect
> -  that with a maximum 10A limit. Allowing for transients at/near double
> -  the rated current, this translates across the device range to per
> -  channel figures as so...
> -
> -                               | DA9121    DA9122     DA9220    DA9217
> -                               | /DA9130   /DA9131    /DA9132
> -    -------------------------------------------------------------------
> -    Output current / channel   | 10000000   5000000   3000000   6000000
> -    Output current / phase     |  5000000   5000000   3000000   3000000
> -    -------------------------------------------------------------------
> -    Min regulator-min-microvolt|   300000    300000    300000    300000
> -    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000
> -    Device hardware default    |  1000000   1000000   1000000   1000000
> -    -------------------------------------------------------------------
> -    Min regulator-min-microamp |  7000000   3500000   3500000   7000000
> -    Max regulator-max-microamp | 20000000  10000000   6000000  12000000
> -    Device hardware default    | 15000000   7500000   5500000  11000000
> +  Dialog Semiconductor DA9141 Single-channel 40A   quad-phase buck converter
> +  Dialog Semiconductor DA9142 Single-channel 20A double-phase buck converter
> +
> +  Device parameter ranges
> +
> +  The current limits can be set to at/near double the rated current per channel
> +  to allow for transient peaks.
> +  Current limit changes when the output is enabled are not supported, as a
> +  precaution against undefined behaviour.
> +
> +  |----------------------------------------------|
> +  |               | range & reset default value  |
> +  | Device        |------------------------------|
> +  |               | microvolt    | microamp      |
> +  |----------------------------------------------|
> +  | DA9121/DA9130 | Min:  300000 | Min:  7000000 |
> +  |               | Max: 1900000 | Max: 20000000 |
> +  |----------------------------------------------|
> +  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
> +  |               | Max: 1900000 | Max: 10000000 |
> +  |----------------------------------------------|
> +  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
> +  |               | Max: 1900000 | Max:  6000000 |
> +  |----------------------------------------------|
> +  | DA9217        | Min:  300000 | Min:  7000000 |
> +  |               | Max: 1900000 | Max: 12000000 |
> +  |----------------------------------------------|
> +  | DA9141        | Min:  300000 | Min: 26000000 |
> +  |               | Max: 1300000 | Max: 78000000 |
> +  |----------------------------------------------|
> +  | DA9142        | Min:  300000 | Min: 13000000 |
> +  |               | Max: 1300000 | Max: 39000000 |
> +  |----------------------------------------------|
>  
>  properties:
>    $nodename:
> @@ -51,6 +63,8 @@ properties:
>        - dlg,da9130
>        - dlg,da9131
>        - dlg,da9132
> +      - dlg,da9141
> +      - dlg,da9142
>  
>    reg:
>      maxItems: 1
> @@ -69,26 +83,24 @@ properties:
>  
>    regulators:
>      type: object
> -    $ref: regulator.yaml#
>      description: |
> -      This node defines the settings for the BUCK. The content of the
> -      sub-node is defined by the standard binding for regulators; see regulator.yaml.
> -      The DA9121 regulator is bound using their names listed below
> -      buck1 - BUCK1
> -      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
> +      List of regulators provided by the device
>  
>      patternProperties:
>        "^buck([1-2])$":
>          type: object
>          $ref: regulator.yaml#
> +        description: |
> +          Properties for a single BUCK regulator
>  
>          properties:
> -          regulator-mode:
> -            maxItems: 1
> -            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
> +          regulator-name:
> +            pattern: "^BUCK([1-2])$"
> +            description: |
> +              BUCK2 present in DA9122, DA9220, DA9131, DA9132 only
>  
>            regulator-initial-mode:
> -            maxItems: 1
> +            enum: [ 0, 1, 2, 3 ]
>              description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
>  
>            enable-gpios:
> @@ -97,6 +109,7 @@ properties:
>  
>            dlg,ripple-cancel:
>              $ref: "/schemas/types.yaml#/definitions/uint32"
> +            enum: [ 0, 1, 2, 3 ]
>              description: |
>                Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
>                Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
> -- 
> 2.25.1
> 
> 
