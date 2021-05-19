Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B295388A94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhESJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239351AbhESJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621416241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIoBknTXh1WMu4eSAgzvXeVCZEhBwjTopIqK+d4Jpps=;
        b=T5cuTmC3jEWYWoBWTQ5nJmI/H3Beb9aLDQOpFbVjKRarDvdKWbOjwYTfhQGCIY2pf4kJ7y
        2p3wSWzMtB5JfSHyyZ8D2yoX8o3M2/Kq7A9tAEwhEprvYl2jWVd70nw5jVEQqVDvYU1HCS
        8MwL+3zh8YKULLFltpUgNuERxFMOe4E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-etbG2yDKMQe80boL63gN1w-1; Wed, 19 May 2021 05:24:00 -0400
X-MC-Unique: etbG2yDKMQe80boL63gN1w-1
Received: by mail-ej1-f72.google.com with SMTP id i23-20020a17090685d7b02903d089ab83fcso3448153ejy.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIoBknTXh1WMu4eSAgzvXeVCZEhBwjTopIqK+d4Jpps=;
        b=d6rMluT6NqALkRIY2z42LCvocOPC7lBCWgcHDYMb8Hl2gsfmmSx/UnjavxbpM7gijY
         g9qXrrEOyDFX1AX0dJvLP3w12vec3gkklvfmwfMfD1X31xDpmgByA/EYd9FSpjjW4OBz
         zRWg2DCpnqmzCSIrj+S+3NbzpY617ZGyrlyfxzwFBhOdj2pYKBMydJTUXWke2nJy87Yk
         Eg3uyq/Q8iw0d9s77TxO0fRg+byA7/uJ3rMvSsu6bmzQ4MkoKxS1iZbg/WGfnqm7bjy9
         iY+i7M+GSqzM5Q20VHqEzLeQ0O4WtYdDVoD8W6RRYYPSqcXAYfbJVWy5/zlsOmNqbFHy
         bEPA==
X-Gm-Message-State: AOAM530J+UIsDHHQBG0K7sPi87Dy3L/m94EWzfGdX+qlXYrz2TSqsBHS
        7AUxYmHPVUg5x0q9r9A27SaZDxaVZlbhOQKWuzyzF3oBraqImW/NVSl6L62Es+OE+035zv01nqS
        rGvRFmwFMgFeM/KB+RqEqi0B5FH1nQjpOsXwhjizxp41wibw/OIcCHVS4xyPpoWwOWNDAYSdk4R
        Z4
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr5086856edt.12.1621416239031;
        Wed, 19 May 2021 02:23:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVNXLkxsb8qHNdf8QEVjrdCKpbmjMhPcWsWQGEtcpQnp5If5uZ8LoU/I59npKJBjcQiq5jRQ==
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr5086835edt.12.1621416238833;
        Wed, 19 May 2021 02:23:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t19sm6484935eds.4.2021.05.19.02.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 02:23:58 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios 300
 RGB keyboard backlight
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jafar Akhondali <jafar.akhoondali@gmail.com>, jlee@suse.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAMW3L+24ZGowtpURUbjoCoA+eZMF0wDae1izxS+HM2uz1L9Rig@mail.gmail.com>
 <9e455325-d9d6-557d-e9a5-779f59e2af4c@redhat.com> <20210519085429.GA2025@bug>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e933a326-830c-4df8-eeb0-f8e48a4b9627@redhat.com>
Date:   Wed, 19 May 2021 11:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519085429.GA2025@bug>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 5/19/21 10:54 AM, Pavel Machek wrote:
> Hi!
> 
>>> From e65b0ddbf559aa3ca8a7998404e7e67e64b705e9 Mon Sep 17 00:00:00 2001
>>> From: JafarAkhondali <jafar.akhoondali@gmail.com>
>>> Date: Fri, 14 May 2021 08:26:47 +0430
>>> Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios
>>> 300 rgb keyboard backlight
>>>
>>> The Acer helios 300 provides gaming functions WMI that is available in
>>> Windows, however this was not implemented in Linux. The process of finding
>>> the related method was done by decompiling PredatorSense(official Acer
>>> gaming functions software for Predator series) and decompiling WQ
>>> buffers. This patch provides a gaming interface which will then expose a
>>> character device named "acer-gkbbl". This character device accepts 16
>>> bytes long config, which is specific for the backlight method. The
>>> meaning of each bytes ordered by bit position is as follows:
>>>
>>> Bit 0 -> Backlight modes:
>>> 1: Breath
>>> 2: Neon
>>> 3: Wave
>>> 4: Shifting
>>> 5: Zoom
>>> Bit 1 -> Animation Speed: from 1 to 9 ( 1 is slowest, 9 is fastest)
>>> Bit 2 -> Brightness from 0 to 100 ( 0 is no backlight, 100 is brightest)
>>> Bit 3 -> Unknown. Wave effect uses 8, other modes must use 0
>>> Bit 4 -> Animation Direction:
>>> 1: Right-to-Left
>>> 2: Left-to-Right
>>> Bit 5 -> Red Color Selection
>>> Bit 6 -> Green Color Selection
>>> Bit 7 -> Blue Color Selection
>>> Bit 8 -> Currently unknown, or not used in known model
>>> Bit 9 -> Currently unknown, or not used in known model
>>> Bit 10 -> Currently unknown, or not used in known model
>>> Bit 11 -> Currently unknown, or not used in known model
>>> Bit 12 -> Currently unknown, or not used in known model
>>> Bit 13 -> Currently unknown, or not used in known model
>>> Bit 14 -> Currently unknown, or not used in known model
>>> Bit 15 -> Currently unknown, or not used in known model
>>>
>>> Filling this config is out of scope for the kernel module, and this module
>>> only acts as an interface.
>>>
>>> Currently, I'm not sure with the method for communicating with user-space,
>>> but since leds.h subsystem wouldn't fit for complex actions such as this
>>> complex config, I couldn't find any better method than char dev.
>>
>> Thank you for your patch, given that there is no existing kernel
>> interface which is a good match for the features exported by this
>> keyboard I'm fine with just having a raw interface where userspace
>> writes GAMING_KBBL_CONFIG_LEN bytes as you suggest.
> 
> Keyboard backlight goes through LED interface (so please cc the mailing list) and
> no, passing raw bytes to hardware is not an acceptable interface.
> 
>> But lets not use a classdev + chardev for this please, you can
>> just add a binary write-only sysfs-atrribute under the wmi-dev for
>> this with a name like (for example) gaming_kbd_backlight_config
>> and then userspace can write to that without needing a class + char
>> dev just for this single write.
> 
> NAK. We have existing interfaces for this.

I don't think we have existing interfaces for things like wave / zoom /
neon effects.  I guess this could use the new CONFIG_LEDS_CLASS_MULTICOLOR
API to set the color + overall brightness, combined with a custom sysfs attribute
under the led_classdev's device's dir for selecting the things for which there
is no standard API ?

Regards,

Hans

