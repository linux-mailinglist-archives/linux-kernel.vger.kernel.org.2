Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE583F2E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhHTO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbhHTO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:27:23 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E144FC061575;
        Fri, 20 Aug 2021 07:26:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x10-20020a056830408a00b004f26cead745so14009127ott.10;
        Fri, 20 Aug 2021 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XbgFcWZTGZ4Mw5/yAsceqeHzdJQFpavhF8zlUtwnN/U=;
        b=c4Lsz9b+TELHfZqJ58UMFlIgzJZv0wCuSQhChT6sNZRYs9SNqOqAAiYwQk9i0ghuxJ
         OU0+PlDLRxps7k+LSnx1xXoyUOBzJbwah2KdIgHVYgPcxzVe3BuLYDqowQxXS3buN1MK
         fAMHa4lvxvNTV7fzKhODMMAPikK6KAES+OndE/9/PVgRtPb6f1tub/IIwpMCoHkc3QyX
         kAy8Yce5VdPdVQDrWPPpdw127Czvut96oCjKVcM+vfFeJlmdd0sVq3PdwhlyqelfDsPg
         ai12+QfWt6chCqK+x45YKFMLccUPJadD0Xbkxrq5ItzX1RZNGalogv8OIA6WrneHAJfO
         zB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbgFcWZTGZ4Mw5/yAsceqeHzdJQFpavhF8zlUtwnN/U=;
        b=U+5ZTtLEDzcR/TGLG7c/YyFhByp37mkkOr3W6nxPLO3NemxIaRy5dMQrK6VnKT+I26
         E8BDQwUTk7rUN1bA/hBIGK7KeLe1VkIHqY/go0tUBLv7z6yIza5seQqextyHck8FNf3S
         84I++yjtT+D7ID8FEGyL3GE/vWxOrXnMfm9nGLITQKqLBFfQYHKnYObOjNC+cdPzxVtY
         52yPHAGiP6ewXJkmoDMb/ihXgso24ZygyWNP0ri9h/FMrT1I/XcoMVUJQM2yheMTHn6o
         vvSzIqujPcHfTLxglh8EGHg4wjNxYQzCqKC0Fa2JbQghhkusD7nWmPaJHlmvYQb0aTBE
         PUCQ==
X-Gm-Message-State: AOAM531muMn5xAbhdvtHuJ+G1VkraEtQdYIyWqxmkfZ2rbpVKbuipp2m
        sdkL1TWR4e4jbbRs6IuXQDES7zO4mWw=
X-Google-Smtp-Source: ABdhPJzUnVGEaGUG0EazPsTIEWjz2rpuE18GFl9qQkI+3kjxuvEMCQVdmfWeHlg/Df9zNvUjnn/08A==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr2666362oiw.98.1629469605094;
        Fri, 20 Aug 2021 07:26:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o68sm1498323ota.33.2021.08.20.07.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:26:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: merge max1619 into trivial
 devices
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <441b28c9-a997-7143-825f-f272e399d60f@roeck-us.net>
Date:   Fri, 20 Aug 2021 07:26:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 11:25 AM, Krzysztof Kozlowski wrote:
> Ther Maxim max1619 bindings are trivial, so simply merge it into
> trivial-devices.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Do we have a general guideline on how to handle such trivial bindings ?
I normally leave it up to the driver author to decide one way or another.

Guenter

> ---
>   Documentation/devicetree/bindings/hwmon/max1619.txt  | 12 ------------
>   .../devicetree/bindings/trivial-devices.yaml         |  2 ++
>   2 files changed, 2 insertions(+), 12 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/hwmon/max1619.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/max1619.txt b/Documentation/devicetree/bindings/hwmon/max1619.txt
> deleted file mode 100644
> index c70dbbe1e56f..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/max1619.txt
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -Bindings for MAX1619 Temperature Sensor
> -
> -Required properties:
> -- compatible : "maxim,max1619"
> -- reg        : I2C address, one of 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, or
> -               0x4d, 0x4e
> -
> -Example:
> -	temp@4c {
> -		compatible = "maxim,max1619";
> -		reg = <0x4c>;
> -	};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index fb03febc6616..1e4b3464d734 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -147,6 +147,8 @@ properties:
>             - maxim,ds1803-100
>               # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>             - maxim,max1237
> +            # Temperature Sensor, I2C interface
> +          - maxim,max1619
>               # 10-bit 10 kOhm linear programable voltage divider
>             - maxim,max5481
>               # 10-bit 50 kOhm linear programable voltage divider
> 

