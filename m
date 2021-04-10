Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A535AB66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhDJGkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJGkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 02:40:17 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A596CC061762;
        Fri,  9 Apr 2021 23:40:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so7831832otq.8;
        Fri, 09 Apr 2021 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igOZ6Kp3VA1wEOJ+TW8ALtZwZ+6wILNO7aMHAoDA9TU=;
        b=XOjemfYLhCB7IGRAG+El8JH/YRBMj9FEB78leEdGodz6pG4bNVZbAbjh4XHo2QPSmd
         /KiKjp0HacslNh0WqxQF+lORT2vogNLRiBgs44NqtBdS0bNuPFX6EB8rQp+pjUNfCnpL
         9TK2BQb21WymN6LdtaA7gK7SBIJFrSRp3z6OgOIYg9FlRhfkjCFyZI7d7JB5Zti/o+8T
         rrDOePqL3GF5rbTyeNbrSj6B5rHubOLADoQQCjOaOQNTU7XttHdJ4MAa/bldfR0NEc1B
         gIazW1xr9u74flzP1Y98d5hc39FrGorRkM0Yd+ToFbIFLFrN57JpzPI/0K5QDz0yveIg
         GN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=igOZ6Kp3VA1wEOJ+TW8ALtZwZ+6wILNO7aMHAoDA9TU=;
        b=YNByL2pfzPbek/BMULQC9Fxxul5ZHf/MF+PlEcpcJRG0ePkQ2C0o/OwBTSU3fJ5GmK
         5/XagL6mvZGEuZ8bWqvwwqjcWINuIm84/nPqWaXMxSyD+M1BcR3ceVUv7QJ1yt6DDtUW
         gNyBhIcCBbUn6Gv22qVWSmNCacjMxcKC0LrFM5Ch4CX/loOIgialLjbDL4SWbFJRVxGK
         Obd6MYZs9sWhKkvwJ/eZK5gSeBZFg5onEzBCpsMf0HHchcODtf7jbDr5Dwia88Fsu1//
         9gjpT30UeHJoWIfYI9ZiPdWA5AgJHnlP9V1JOGf0rRCAl16EJ4M9qkZV+sU3S3UJHzvj
         2Fqw==
X-Gm-Message-State: AOAM532Cuy4wwq7T4bVI84yrACQD6gNhhKxnQu+Wp/nEpOBas5B4/RW8
        XTm6BKig2Gr3D8tv1KXfz0E=
X-Google-Smtp-Source: ABdhPJyD0QssoC5XtGRNrRYzh0czHQH61qvNn31ac7PcY9I2az+jKWD9op0DCexA2opgjoaDS5rFhg==
X-Received: by 2002:a9d:6013:: with SMTP id h19mr15309639otj.72.1618036802508;
        Fri, 09 Apr 2021 23:40:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1sm945371oop.0.2021.04.09.23.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 23:40:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <20210408150821.GA205657@roeck-us.net>
 <245fe6eb-b188-ee50-bf75-8a16fe8f5d67@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d9e42e20-7044-f96a-9542-5aafec2a7a12@roeck-us.net>
Date:   Fri, 9 Apr 2021 23:40:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <245fe6eb-b188-ee50-bf75-8a16fe8f5d67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 9:07 AM, Hans de Goede wrote:
> Hi Guenter,
> 
> On 4/8/21 5:08 PM, Guenter Roeck wrote:
>> On Mon, Apr 05, 2021 at 10:48:10PM +0200, Thomas Weißschuh wrote:
>>> Changes since v1:
>>> * Incorporate feedback from Barnabás Pőcze
>>>   * Use a WMI driver instead of a platform driver
>>>   * Let the kernel manage the driver lifecycle
>>>   * Fix errno/ACPI error confusion
>>>   * Fix resource cleanup
>>>   * Document reason for integer casting
>>>
>>> Thank you Barnabás for your review, it is much appreciated.
>>>
>>> -- >8 --
>>>
>>> Tested with a X570 I Aorus Pro Wifi.
>>> The mainboard contains an ITE IT8688E chip for management.
>>> This chips is also handled by drivers/hwmon/i87.c but as it is also used
>>> by the firmware itself it needs an ACPI driver.
>>>
>>> Unfortunately not all sensor registers are handled by the firmware and even
>>> less are exposed via WMI.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>  drivers/platform/x86/Kconfig        |  11 +++
>>>  drivers/platform/x86/Makefile       |   1 +
>>>  drivers/platform/x86/gigabyte-wmi.c | 138 ++++++++++++++++++++++++++++
>>
>> Originally drivers/platform was supposed to be used for platform specific
>> code. Not that I have control over it, but I really dislike that more and
>> more hwmon drivers end up there.
>>
>> At least hwmon is in good company - I see drivers for various other subsystems
>> there as well. I just wonder if that is such a good idea. That entire directory
>> is bypassing subsystem maintainer reviews.
> 
> In case you are not aware I've recent(ish) taken over the drivers/platform/x86
> maintainership from Andy Shevchenko.
> 
> Yes it is a bit of an odd grab-bag it mostly deals with vendor specific
> ACPI / WMI interfaces which often more or less require using a single
> driver while offering multiple functionalities. These firmware interfaces
> do not really lend themselves to demultiplexing through something like
> MFD. These are mostly found on laptops where they deal with some or all of:
> 
> - Hotkeys for brightness adjust / wlan-on/off toggle, touchpad on/off toggle, etc.
>   (input subsystem stuff)
> - Mic. / Speaker mute LEDS (and other special LEDs) found on some laptops
>   (LED subsystem stuff)
> - Enabling/disabling radios
>   (rfkill stuff)
> - Controlling the DPTF performance profile
>   (ACPI stuff)
> - Various sensors, some hwmon, some IIO
> - Backlight control (drm/kms subsys)
> - Enabling/disabling of LCD-builtin privacy filters (requires KMS/DRM subsys integration, pending)
> - Fan control (hwmon subsys)
> 
> And often all of this in a single driver. This is all "stuff" for which
> there are no standard APIs shared between vendors, so it is a free for
> all and often it is all stuffed behind a single WMI or ACPI object,
> because that is how the vendor's drivers under Windows work.
> 
> It certainly is not my intention to bypass review by other subsystem
> maintainers and when there are significant questions I do try to always
> get other subsys maintainers involved. See e.g. this thread, but also the
> "[PATCH 1/3] thinkpad_acpi: add support for force_discharge" thread
> where I asked for input from sre for the power-supply aspects of that.
> 
> The WMI code was reworked a while back to make WMI be a bus and have
> individual WMI objects be devices on that bus. version 2 of this
> driver has been reworked to use this. Since this new driver is just a hwmon
> driver and as this is for a desktop I expect it will stay that way,
> I'm fine with moving this one over to drivers/hwmon if that has your
> preference.
> 
I thought about it, but I don't think it makes much sense since all other
WMI drivers are in drivers/platform.

> As for other cases then this driver, if you want to make sure you are at
> least Cc-ed on all hwmon related changes I'm fine with adding you as a
> reviewer to the pdx86 MAINTAINERS entry.
> 
I think I have a better idea: I'll add a regex pattern into the MAINTAINERS
entry for hardware monitoring drivers. This way we should get copied whenever
anyone adds a hardware monitoring driver into the tree.

Thanks,
Guenter
