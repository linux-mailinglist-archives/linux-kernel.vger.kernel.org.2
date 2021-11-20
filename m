Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903F845806D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhKTVQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhKTVQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:16:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CDEC061574;
        Sat, 20 Nov 2021 13:13:01 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id be32so29023011oib.11;
        Sat, 20 Nov 2021 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlJsgNuACVw3Jnj0FSXleu2cN6friNna4S6waxQmQE4=;
        b=Reoh7cM2vAO61iZKiRhZUHsEiueLdKvRCJb5J/ZqTQVO9wTKMDjYBqtlZ1rtLfsoPQ
         wtAEkrIFL0KMhQgp8vtKWWIZT+daFrk8AEUyPi/7m5AaRbArjylrA5mHSmZXVYPR+VIO
         IKKY+wxZ9sDdd2g7cXb30B6JnVCqjvU+2Kgk60JhT66ERtQqcJ9RNULlup39aBGjmICo
         0yNwYDjo4iDuxjkoM4CnCY7wJH/go6sqpoZvgHYZ0lJ0IR6YSOAQAoxdON4tpnIR/UTQ
         R6FMAPQa20Cxpe1W1vnPkfjK5utYqnDCSW2/J4FCvkHWcru9gWPMqdqdrXvsFxZ1JawQ
         /Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlJsgNuACVw3Jnj0FSXleu2cN6friNna4S6waxQmQE4=;
        b=a9DCj06SDdsFNt3HHyRPwOQt+QeLnX3fFRvJhahook2yhrpQQ1pjZbFmZGC3hoyG6c
         EKS95oJWALUHNgRs8qjJe74ocSYjuXbM47y4YT7JZ7HwZzaHmqGIqj2iDuRjbFYAA4ED
         ykIqlrwkdsQ8qBQZnaReXZlJX03Ob1JSf65MFX8Ahoov0PsiFYsfA6kaycZL+LmIoo9+
         4KjcYIh6xVNO3Lwt4Mfa3wntRnyDSEGfkC7rNz/ps+DqavvakpEYKdLNRzEmnbHaZ4e2
         uSNnazMeCy8NPnEB7vD0TSc1b54E9CxPTggGceiTK5y7PQ4vgM07PxPY9XY192ZJcqId
         Xvzg==
X-Gm-Message-State: AOAM533aUw69Zpp8nZFDF3qBpVl1j/VnypMxPlr+ae56clXRXx3RJKB2
        RByoF2XAnOFdYdh2dlw83bsJ6Yon1S4=
X-Google-Smtp-Source: ABdhPJzgPDdILFRucbKSZljypyrWmucjazf4X9+6ccvYASQf8MX634F5OeBtO0IZvd3OuC9Ou3HpvA==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr9576917oiw.117.1637442780173;
        Sat, 20 Nov 2021 13:13:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k12sm758816ots.77.2021.11.20.13.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 13:12:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: (sht4x) Add device tree match table and
 document it
To:     David Mosberger-Tang <davidm@egauge.net>,
        Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120204053.2299501-1-davidm@egauge.net>
 <20211120204053.2299501-2-davidm@egauge.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ebe1f6a-575f-2d34-7839-9055545e5e6b@roeck-us.net>
Date:   Sat, 20 Nov 2021 13:12:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211120204053.2299501-2-davidm@egauge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/21 12:40 PM, David Mosberger-Tang wrote:
> This patch enables automatic loading of the sht4x module via a device
> tree table entry.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>   .../bindings/hwmon/sensirion,sht4x.yaml       | 50 +++++++++++++++++++
>   drivers/hwmon/sht4x.c                         |  7 +++

This needs to be two separate patches, one the devicetree change and the other
the source code change. DT maintainers need to be copied on the devicetree
patch.

Also, please consider adding the device to trivial-devices.yaml instead since
there are no special bindings.

Thanks,
Guenter

>   2 files changed, 57 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> new file mode 100644
> index 000000000000..588c2e37b035
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht4x.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,sht4x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHT4x Humidity and Temperature Sensor IC
> +
> +maintainers:
> +  - Navin Sankar Velliangiri navin@linumiz.com
> +
> +description: |
> +  The SHT4x is a high-accuracy digital humidity and temperature sensor
> +  designed especially for battery-driven high-volume consumer
> +  electronics applications.  For further information refere to
> +  Documentation/hwmon/sht4x.rst
> +
> +  This binding document describes the binding for the hardware monitor
> +  portion of the driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sht4x
> +
> +  reg:
> +    const: 0x44
> +    description:
> +      The I2c base address of the SHT4x.  0x44 for all chip versions
> +      except for SHT41-BD1B, where it is 0x45.
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      clock-frequency = <400000>;
> +
> +      sht4x@44 {
> +        compatible = "sensirion,sht4x";
> +        reg = <0x44>;
> +      };
> +    };
> +...
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 3415d7a0e0fc..6e53d81e32d4 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, sht4x_id);
>   
> +static const struct of_device_id sht4x_of_match[] = {
> +	{ .compatible = "sensirion,sht4x" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sht4x_of_match);
> +
>   static struct i2c_driver sht4x_driver = {
>   	.driver = {
>   		.name = "sht4x",
> +		.of_match_table = sht4x_of_match
>   	},
>   	.probe		= sht4x_probe,
>   	.id_table	= sht4x_id,
> 

