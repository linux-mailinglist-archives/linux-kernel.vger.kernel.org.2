Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79235406F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhIJQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhIJQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:14:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695AC05BD0E;
        Fri, 10 Sep 2021 09:10:11 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x10-20020a056830408a00b004f26cead745so2870324ott.10;
        Fri, 10 Sep 2021 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LGul5DeMrFaHTYFBL3XCXz0TP7xadBFIDKUwynCcxEg=;
        b=n8sjn/DotDTFK7+h8n3FAlQlL2Y6cKqfDrYqv5SQYFBu7GhrU8sAsTNrhf0oJQWu9K
         FIDX5NA0BR6nfbEicHeHUelMqur2bY75H0bb36XC6xB0rlGfTT+UeFRcXHHsmBv0xclK
         jsyJgng+6d9MV/lPjyFDUKxwXETFxJEjY71pqhtqkmC65s5YO7ik3haj3R9lbClkEUyJ
         A8w+vyWmLg10V3UCB4sUNWzchm6g0kMaB0jR2zWN8Igxf9NzptrIiuNMHqqLO6Ptq8i6
         u18JvY6KG0G16XhH5kwVOpGSMGXOKyRYYuJB1wFqfL5RqZqywdbQ0S7nlQ8i6cMDuGPw
         TSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LGul5DeMrFaHTYFBL3XCXz0TP7xadBFIDKUwynCcxEg=;
        b=MfU81OGPJVGlCOILcfIBYrW5bsUWkFwS2OPrwINDkIYf0I5GbkfL8VtD6wn5rOMf4h
         QMoltiQZqCSY7PlRThpKrbTB4TEAkehEjhwom0q567R18qicvkVJERcJ4x6GD21XyKio
         W04a+bodMa1R7U8KPSHPmkm5l3wLFNeMoHSc1r0cpk2h9LdwDHLI8DQdKFDqCtYaej6f
         h9+c9wdkKBbS4kgMTV5yBR8xKc87zuLPT4MunT3ngX2Bh7vkmtRHc+4XWfOLH0SUH96C
         7JGGEoL8XnzzKnIcDL3oe4docnawUlIEQTABmF1KssQ6+DT2gAfkMgsfl1vudtc2KljH
         Kb9Q==
X-Gm-Message-State: AOAM530LeYqzVJQEByJiT4UYjTDX2F8o9E4R9OOSaagxDC4FCg4ZM+di
        7A5N7BOjPF5jvlw2JBaoNFQ=
X-Google-Smtp-Source: ABdhPJxBmBVK+oRNN4XyfoS4H7WfimMvBTCNwtLSc1W1sw646xhSp4Ig1vLQUgn1UgyzGkllKMboNg==
X-Received: by 2002:a05:6830:130f:: with SMTP id p15mr5510388otq.109.1631290210345;
        Fri, 10 Sep 2021 09:10:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z7sm1341011oti.65.2021.09.10.09.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:10:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>
References: <20210910130337.2025426-1-osk@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
Date:   Fri, 10 Sep 2021 09:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210910130337.2025426-1-osk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 6:03 AM, Oskar Senft wrote:
> Document bindings for the Nuvoton NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>   .../bindings/hwmon/nuvoton,nct7802.yaml       | 66 +++++++++++++++++++
>   1 file changed, 66 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> new file mode 100644
> index 000000000000..bc4b69aeb116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT7802Y Hardware Monitoring IC
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
> +  5 remote temperature sensors with SMBus interface.
> +
> +  Datasheets:
> +    https://www.nuvoton.com/export/resource-files/Nuvoton_NCT7802Y_Datasheet_V12.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,rtd-modes:
> +    description: |
> +      Select modes for the three RTDs.
> +
At the very least, "RTD" should be defined. The datasheet doesn't say explicitly,
but I suspect it means "Remote Temperature Diode".

> +      The order is RTD1, RTD2, RTD3.
> +
> +      Valid values for RTD1 and RTD2 are:
> +        "closed",
> +        "current",
> +        "thermistor",
> +        "voltage"
> +
> +      Valid values for RTD3 are:
> +        "closed",
> +        "thermistor",
> +        "voltage"
> +    type: stringlist

I am not sure what "closed" means (the datasheet doesn't say), but I suspect it means
that the sensor is disabled (?). For the other modes, the translation to the standard
ABI is:

current -> 3 (thermal diode)
thermistor -> 4 (thermistor)
voltage -> 2 (3904 transistor)

That makes me wonder if it would be better to define generic thermal sensor
properties (possibly aligned with the ABI) instead of chip specific ones.
That would probably require sub-nodes to be able to express if a specific
sensor is enabled/disabled. Rob, any thoughts ?

Thanks,
Guenter

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7802@28 {
> +            compatible = "nuvoton,nct7802";
> +            reg = <0x28>;
> +            nuvoton,sensor-modes =
> +              /* RTD1 */ "thermistor",
> +              /* RTD2 */ "voltage",
> +              /* RTD3 */ "closed";
> +        };
> +    };
> 

