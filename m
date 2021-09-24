Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF524169D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhIXCJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbhIXCJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:09:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC867C061574;
        Thu, 23 Sep 2021 19:07:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so5497214otb.1;
        Thu, 23 Sep 2021 19:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=noF3Obp7Gdug+AA00JXgSCgFtHXSce9gfOllVZMtQz8=;
        b=pv2ZVlQjbL6JHtBWH0+F8CDBw/NV8qkx94+XvBuwcK6sOCZmebzNsWbhklcyjerbCV
         UAnq9KZ/kBo5WHXlku8qsbmmCOU/D+hmWH1ADa+C2iEoTDHzTLFGC60bb13yZ0rI6/fo
         Ougp1U+NFMSE9pMUe/9o829bo0/wXPnitBUPtHzkmzKK0Db5n5IDFe5PXsnyCFsHtEK7
         B4jMRa/jhoj0ENB1V4xImH83bs2iKMxbWUAtiU/ir5P7QtF+LCHOJ5k+SwXYva1gTDme
         FWK/mUzMhMPlMHmX5C/K2KgBdWnkgSM7fY9kEoeMRWDAsn469+5hUv7ymdIlbtZS2vlm
         T9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=noF3Obp7Gdug+AA00JXgSCgFtHXSce9gfOllVZMtQz8=;
        b=welMj1PWXhFs8UdJjYLhFXQ0LS278niFSq6BhWmPbeYracSh5reP2ULoIITysZuAhq
         pYamFrFFYTPyBDYtv6LOO4zW1qyVv0vnljN/FuzzPyXO6nYbe2j1PZjLoqytnJxcojaG
         SIQ9Zi+4y9l9zf7AKJSbBYNCR4SR0GdbttMWqspqdGLvb17lNWetl6na+vGfIwdaYyg4
         NGCwXE+5C0rPLciwAyT41ZPwk7Gp6ZIogEvqaa3OnPLSuI0bugRK5TwgvWTdJfjjoVmX
         WXrMikuN9y2DKjW8XJsfATt0SFOJ6hlVIsejJF38WptS+/POov1g8k+efas1X74qyep5
         k3Cw==
X-Gm-Message-State: AOAM531v28+ODPF04VRyFFkgOlFMdQKbaQiz3hpxvGnBIB4+l2xCVVhZ
        vlZkPcvlB01xBLh/F6rTgaYCnipAAUg=
X-Google-Smtp-Source: ABdhPJzvGYtBJdsSP/4nlZJu4sB0ucvsb4M6re2QWWywb4V2YBukNhtbXdko/w0va+aNkXi3/zaMBg==
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr1750836otf.144.1632449253194;
        Thu, 23 Sep 2021 19:07:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i19sm1977864ooe.44.2021.09.23.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:07:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:07:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: hwmon: hih6130: move to trivial devices
Message-ID: <20210924020731.GA3032089@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:21:12PM +0200, Krzysztof Kozlowski wrote:
> The hih6130 bindings are trivial, so it can be integrated into trivial
> devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, per Rob's feedback (.txt -> .yaml conversion).

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/hih6130.txt  | 12 ------------
>  .../devicetree/bindings/trivial-devices.yaml         |  2 ++
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hih6130.txt b/Documentation/devicetree/bindings/hwmon/hih6130.txt
> deleted file mode 100644
> index 2c43837af4c2..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/hih6130.txt
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -Honeywell Humidicon HIH-6130 humidity/temperature sensor
> ---------------------------------------------------------
> -
> -Requires node properties:
> -- compatible : "honeywell,hi6130"
> -- reg : the I2C address of the device. This is 0x27.
> -
> -Example:
> -	hih6130@27 {
> -		compatible = "honeywell,hih6130";
> -		reg = <0x27>;
> -	};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index b1bad299ec66..c9333fb81fdf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -111,6 +111,8 @@ properties:
>            - mps,mp2888
>              # Monolithic Power Systems Inc. multi-phase controller mp2975
>            - mps,mp2975
> +            # Honeywell Humidicon HIH-6130 humidity/temperature sensor
> +          - honeywell,hi6130
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38064 Voltage Regulator
