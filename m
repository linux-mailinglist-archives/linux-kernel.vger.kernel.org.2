Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6F390FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEZEef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEZEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:34:32 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C5C061574;
        Tue, 25 May 2021 21:33:01 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so5792804ooq.8;
        Tue, 25 May 2021 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nn8BcbpNA/KPq/h6bXXdClanntH2w/Hd4Ms+7jYLu2I=;
        b=kzEJ3YgZDkC2Urij4KdyaJiciCjYej1wz4b9oR3I6B1mzCRjIdasTIhJ169Fw/5mMb
         vMghO8+SKNPsMGbWvEva4bgM78U5ftmOMDzZh0vf6ZN07WL4+9LtKcoF3yKlw79ckDOI
         AYgCKoOrRpynJKBhfpKKiVY8mdM2YIZA4jnBlUOerV20CgoO5CyEw08Xi/sKoRd5B8pu
         3Xoz4zHd/WFxM6ALUm5Ye9/+hOKFLuLRGyeEAHXkBDYNDcC3OvsgX7kyWy/06HVTZss1
         UBUw4X1fRw+DuUHJ3ffHg4C7nYNoxMxOjpSRo2CY0M+k5qjv42A6q2LK30Mz1VJ1InDv
         qy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nn8BcbpNA/KPq/h6bXXdClanntH2w/Hd4Ms+7jYLu2I=;
        b=KKBM1r4GoVvs7EyYZ/w6mVIPwrRVRAXHVIxg8pz0KvMyd02SixAnufsluO8XZ0L+2h
         ANnKcCghjz4ikVrtekvBvxpgGSvWSY84FZclm+DdUeOo+tImSf5kLsorQ5afBYi9sDMx
         PB/hynduPkXT4pzFYWlyK5Utz0ui+meJWYcGIH5O85ASLBc6bTfhMWhRKRY0x+o+v+Rg
         lINh94EaiMrXJtZhRsPa70LYZfcDt1TVH6UrlZf9LTA2qaJs0l3Cvebkz8+fIW/+AtkU
         S0FC/v5hETpA+P6H6msCJVDFVpoHP75TACLx4WvGJDFCu9nveoP/px5VDXiyd0q9EaWR
         nbpA==
X-Gm-Message-State: AOAM533ttUSQ+U9cX4XalluCcvg058/07LTQDO0IaeAjIyirveOkfGVs
        dCWbG7PQwA4W+ba7P9h1RlWM8KERlrM=
X-Google-Smtp-Source: ABdhPJwZlkledS9J6x55IXDQQtiVGhA7CkrmLxjKXW23dKqGqr6bIckKNI2ZqsusU1RimUBz0ohG4w==
X-Received: by 2002:a4a:d12d:: with SMTP id n13mr758224oor.6.1622003580128;
        Tue, 25 May 2021 21:33:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4sm4387236otl.21.2021.05.25.21.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 21:32:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 6/6] hwmon: (pmbus/pim4328) Add documentation for the
 pim4328 PMBus driver
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210524150246.90546-1-erik.rosen@metormote.com>
 <20210524150246.90546-7-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <949e42c8-01f7-d5e5-deaa-7ba3e3a6934a@roeck-us.net>
Date:   Tue, 25 May 2021 21:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524150246.90546-7-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 8:02 AM, Erik Rosen wrote:
> Add documentation and index link for pim4328 PMBus driver.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/pim4328.rst | 105 ++++++++++++++++++++++++++++++++
>   MAINTAINERS                     |   7 +++
>   3 files changed, 113 insertions(+)
>   create mode 100644 Documentation/hwmon/pim4328.rst
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 9ed60fa84cbe..719625f8f755 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -150,6 +150,7 @@ Hardware Monitoring Kernel Drivers
>      pc87360
>      pc87427
>      pcf8591
> +   pim4328
>      pm6764tr
>      pmbus
>      powr1220
> diff --git a/Documentation/hwmon/pim4328.rst b/Documentation/hwmon/pim4328.rst
> new file mode 100644
> index 000000000000..70c9e7a6882c
> --- /dev/null
> +++ b/Documentation/hwmon/pim4328.rst
> @@ -0,0 +1,105 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver pim4328
> +=====================
> +
> +Supported chips:
> +
> +  * Flex PIM4328
> +
> +    Prefix: 'pim4328', 'bmr455'
> +
> +    Addresses scanned: -
> +
> +    Datasheet:
> +
> +https://flexpowermodules.com/resources/fpm-techspec-pim4328
> +
> +  * Flex PIM4820
> +
> +    Prefixes: 'pim4820'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4820
> +
> +  * Flex PIM4006, PIM4106, PIM4206, PIM4306, PIM4406
> +
> +    Prefixes: 'pim4006', 'pim4106', 'pim4206', 'pim4306', 'pim4406'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4006
> +
> +Author: Erik Rosen <erik.rosen@metormote.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Flex PIM4328 and
> +compatible digital power interface modules.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
> +on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. All attributes are read-only.
> +
> +======================= ========================================================
> +in1_label		"vin"
> +in1_input		Measured input voltage.
> +in1_alarm		Input voltage alarm.
> +
> +in2_label		"vin.0"
> +in2_input		Measured input voltage on input A.
> +
> +			PIM4328 and PIM4X06
> +
> +in3_label		"vin.1"
> +in3_input		Measured input voltage on input B.
> +
> +			PIM4328 and PIM4X06
> +
> +in4_label		"vcap"
> +in4_input		Measured voltage on holdup capacitor.
> +
> +			PIM4328
> +
> +curr1_label		"iin.0"
> +curr1_input		Measured input current on input A.
> +
> +			PIM4X06
> +
> +curr2_label		"iin.1"
> +curr2_input		Measured input current on input B.
> +
> +			PIM4X06
> +
> +currX_label		"iout1"
> +currX_input		Measured output current.
> +currX_alarm		Output current alarm.
> +
> +			X is 1 for PIM4820, 3 otherwise.
> +
> +temp1_input		Measured temperature.
> +temp1_alarm		High temperature alarm.
> +======================= ========================================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..378a121d80f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14416,6 +14416,13 @@ K:	(?i)pidfd
>   K:	(?i)clone3
>   K:	\b(clone_args|kernel_clone_args)\b
>   
> +PIM4328 DRIVER
> +M:	Daniel Nilsson <daniel.nilsson@flex.com>

This will require an Ack from Daniel; you can not just nominate someone
else as maintainer.

> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/pim4328.rst
> +F:	drivers/hwmon/pmbus/pim4328.c
> +
>   PIN CONTROL SUBSYSTEM
>   M:	Linus Walleij <linus.walleij@linaro.org>
>   L:	linux-gpio@vger.kernel.org
> 

