Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728E33219D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhBVOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhBVN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614000445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHONXLl3nmBLIKawFr0LZgdMPC27uJpiOMdfDbFyhfY=;
        b=jDUPWun0zkgyeUGkKM9t8hJDCwz5XBLeVdobZw2sh82QPu2FHRh5lzyVVHhU63Fx0mmlsu
        K+Xjr6NW5YQ/wXtvsb3LO1a7R9GIYTAsJx4HmxGuyBFgQTyhtmS63AeFeccx4JXW2Hvp/Z
        8ydMuWc99DB9GU/zXyaaQGAnMtcpXNY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-N53rjPECPHKkJShBdWh_0w-1; Mon, 22 Feb 2021 08:27:23 -0500
X-MC-Unique: N53rjPECPHKkJShBdWh_0w-1
Received: by mail-ej1-f72.google.com with SMTP id gg8so446108ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GHONXLl3nmBLIKawFr0LZgdMPC27uJpiOMdfDbFyhfY=;
        b=s8f768DC9hUN1oHBHpu8ph6kmTmFbzTa8/e1ubDH3jXpW1Z68YzJTR7E/of6NPlL4X
         Ah/0t5kxBmOsOb9waKOefpBgi5hhMvApHsfPlQOLlRPYHt84UUb43M4a07KJNY4jQDSZ
         G+F2ptRga4i4IlZm3VJ9BAANhZYkYo54IF893i4eQ8smi2skMreDLwsF7wKzkdSkFFi+
         ysYXmAstxJ/NFqGbUblTNGKH6YuEndlaSmKvds/z4jS2e8N8c3cLM64JkRGcSo0ZtuxJ
         OmSeACUjmsOmu7Ctrp3xCt2AzEpFfQ1aRPYUWL/v66GAm0Z3bBN4Hz5w1yxRgoHLgjAg
         hgrw==
X-Gm-Message-State: AOAM533CfG8CHiU+R0g/HSb5ySDTIt4Al187lidvAwSD3ZES7QhC0yDd
        Zf1YM7BKo9TK+N2SLGLW1vYL8m0Pb+Kk6/2Ftk3ZE7Otf3g1zVj8FKckS5hX6PQr1oetMJ7LSyV
        Z2Dy2Fy4iizWXrokDWTN2p1iw
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr13876274ejk.422.1614000441330;
        Mon, 22 Feb 2021 05:27:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu1h3Dz7m2ZikkRECC7W2E6glb8Lbl5nOkzxdhboC2u0NoKyWMJWb/ALk2JernkoP7zoBxbw==
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr13876248ejk.422.1614000441127;
        Mon, 22 Feb 2021 05:27:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y11sm10612929ejd.72.2021.02.22.05.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:27:20 -0800 (PST)
Subject: Re: [PATCH v3 5/6] platform/x86: Add intel_skl_int3472 driver
To:     Daniel Scally <djrscally@gmail.com>, tfiga@chromium.org,
        sakari.ailus@linux.intel.com, rajmohan.mani@intel.com,
        rjw@rjwysocki.net, lenb@kernel.org,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, wsa@kernel.org, lee.jones@linaro.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, robert.moore@intel.com,
        erik.kaneda@intel.com, me@fabwu.ch, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        devel@acpica.org
References: <20210222130735.1313443-1-djrscally@gmail.com>
 <20210222130735.1313443-6-djrscally@gmail.com>
 <04c106e3-fd95-c19d-115f-8acd07df4c0c@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f9620e2e-604e-01c9-0d72-3b415cf3fa88@redhat.com>
Date:   Mon, 22 Feb 2021 14:27:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <04c106e3-fd95-c19d-115f-8acd07df4c0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/22/21 2:19 PM, Daniel Scally wrote:
> Hi all
> 
> On 22/02/2021 13:07, Daniel Scally wrote:
>> diff --git a/drivers/platform/x86/intel-int3472/Kconfig b/drivers/platform/x86/intel-int3472/Kconfig
>> new file mode 100644
>> index 000000000000..b94622245c21
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel-int3472/Kconfig
>> @@ -0,0 +1,31 @@
>> +config INTEL_SKL_INT3472
>> +	tristate "Intel SkyLake ACPI INT3472 Driver"
>> +	depends on ACPI
>> +	depends on REGULATOR
>> +	depends on GPIOLIB
>> +	depends on COMMON_CLK && CLKDEV_LOOKUP
>> +	depends on I2C
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  This driver adds support for the INT3472 ACPI devices found on some
>> +	  Intel SkyLake devices.
>> +
>> +	  The INT3472 is an Intel camera power controller, a logical device
>> +	  found on some Skylake-based systems that can map to different
>> +	  hardware devices depending on the platform. On machines
>> +	  designed for Chrome OS, it maps to a TPS68470 camera PMIC. On
>> +	  machines designed for Windows, it maps to either a TP68470
>> +	  camera PMIC, a uP6641Q sensor PMIC, or a set of discrete GPIOs
>> +	  and power gates.
>> +
>> +	  If your device was designed for Chrome OS, this driver will provide
>> +	  an ACPI OpRegion, which must be available before any of the devices
>> +	  using it are probed. For this reason, you should select Y if your
>> +	  device was designed for ChromeOS. For the same reason the
>> +	  I2C_DESIGNWARE_PLATFORM option must be set to Y too.
>> +
>> +	  Say Y or M here if you have a SkyLake device designed for use
>> +	  with Windows or ChromeOS. Say N here if you are not sure.
>> +
>> +	  The module will be named "intel-skl-int3472"
> The Kconfig option for the existing tps68470 driver is a bool which
> depends on I2C_DESIGNWARE_PLATFORM=y, giving the following reason:
> 
> This option is a bool as it provides an ACPI operation
> region, which must be available before any of the devices
> using this are probed. This option also configures the
> designware-i2c driver to be built-in, for the same reason.
> 
> One problem I've faced is that that scenario only applies to some
> devices that this new driver can support, so hard-coding it as built in
> didn't make much sense. For that reason I opted to set it tristate, but
> of course that issue still exists for ChromeOS devices where the
> OpRegion will be registered. I opted for simply documenting that
> requirement, as is done in aaac4a2eadaa6: "mfd: axp20x-i2c: Document
> that this must be builtin on x86", but that's not entirely satisfactory.
> Possible alternatives might be setting "depends on
> I2C_DESIGNWARE_PLATFORM=y if CHROME_PLATFORMS" or something similar,
> though of course the User would still have to realise they need to
> build-in the INTEL_SKL_INT3472 Kconfig option too.
> 
> Feedback around this issue would be particularly welcome, as I'm not
> sure what the best approach might be.

This is a tricky area, I actually wrote the "mfd: axp20x-i2c: Document
that this must be builtin on x86" patch you refer to. At first I tried
to express the dependency in Kconfig language but things got too complex
and Kconfig sometimes became unhappy about circular deps (or something
like that).

The most important thing here is to make sure that the generic configs
shipped by distros get this right; and we can hope that people creating
those configs at least read the help text...

So all in all I believe that just documenting the requirement is fine.

The alternative would be to just change I2C_DESIGNWARE_PLATFORM (and the
core) to a bool, or at least make it not selectable as module when
X86 and ACPI are set... That would be a bit of a big hammer but might
not be the worst idea actually.

Regards,

Hans

