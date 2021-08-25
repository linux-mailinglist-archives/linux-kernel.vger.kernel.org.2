Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35363F77AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbhHYOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhHYOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629902899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O84UPSzLyTlxpKY8kgA2dxz7W797Ma61Zj/oAUQaZog=;
        b=UraUkJOXm/+2eeZFAAKzwoqTRGpj45jR5Ur9VoJ6nLezFOuUXkUKLG6Lq8TaR9HlgAIKsf
        FegayT2i8gfe/BddLc8kf9p6s0MV0m7RfY12cfRE7bFZqj9+ShHQXpZLAyrwgs3WLKoaaO
        tGo8erm7BQv9JV3O7kg42nl1XPJOpk8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-5O5LTM-zMvOE2-i8iKGHkw-1; Wed, 25 Aug 2021 10:48:18 -0400
X-MC-Unique: 5O5LTM-zMvOE2-i8iKGHkw-1
Received: by mail-ed1-f69.google.com with SMTP id s8-20020a508dc8000000b003c19f7fe952so6948853edh.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O84UPSzLyTlxpKY8kgA2dxz7W797Ma61Zj/oAUQaZog=;
        b=b5njFawxbDR5BI2hRvqqXuuGjguq6aQO4xYcx/Qj7hW4TQE9E6LSYje2AzC2I2la35
         gW7hqxvsohsV2R+o0/YOqefYfpdb69O9GgtoNQORNV5DHUE1uAywAKwnNXZSyDsqIVv1
         K6xmHU6MXlEMlnrrZspQ5vkytpTKFb8MzpQm051aOtJbO77f49UsBfWfrStx7J9EIZP6
         QoTvIMIIicWyc4+cZ9sKjCeNsUKgKmiTerAAn5+fMLkyJKpLBSAIiKKY7xEkp/ws9hBh
         +E6xGuEVsKy2odmy9EEzA/veG6DYmtcLSJitCxEWU0+0SuDDv34NU+MbT8dhpGOV/xwf
         FCSg==
X-Gm-Message-State: AOAM531gZr9CfNKjZIJLkSpD1IFTU4EZ4mkZ+qxFJdORkWeh0FI0y33y
        M2tsVb46wUh1dYK31EGY6n/7xcLDI0LTrwKsx5i4BnTl246FvtH1mcKpDu84Rm2p9VaAYPKtPRg
        SQ1k/IwDNhmzcrsHIz0Fx60ey
X-Received: by 2002:a17:906:8257:: with SMTP id f23mr15284101ejx.509.1629902896651;
        Wed, 25 Aug 2021 07:48:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+YMXzP7rZDSk5lLyGAzNNAie8tuqLLPImw3zzrzt/HJXoa38SKWj/gfei0a8pgYgXHQrPg==
X-Received: by 2002:a17:906:8257:: with SMTP id f23mr15284081ejx.509.1629902896417;
        Wed, 25 Aug 2021 07:48:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i19sm108277edx.54.2021.08.25.07.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:48:15 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Mark Brown <broonie@kernel.org>,
        Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
Date:   Wed, 25 Aug 2021 16:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825103301.GC5186@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 8/25/21 12:33 PM, Mark Brown wrote:
> On Wed, Aug 25, 2021 at 12:06:18AM +0100, Daniel Scally wrote:
>> In some situations regulator devices can be enumerated via either
>> devicetree or ACPI and bound to regulator drivers but without any
>> init data being provided in firmware. This leaves their consumers
>> unable to acquire them via regulator_get().
>>
>> To fix the issue, add the ability to register a lookup table to a
>> list within regulator core, which will allow board files to provide
>> init data via matching against the regulator name and device name in
>> the same fashion as the gpiod lookup table.
> 
> This is the wrong level to do this I think, this is a generic problem
> that affects all kinds of platform data so if we're not going to scatter
> DMI quirks throughout the drivers like we currently do then we should
> have a way for boards to just store generic platform data for a device
> and then have that platform data joined up with the device later.  This
> could for example also be used by all the laptop audio subsystems which
> need DMI quirk tables in drivers for their components to figure out how
> they're wired up and avoids the need to go through subsystems adding new
> APIs.

Daniel, I believe that what Mark wants here is something similar to what
we already do for the 5v boost converter regulator in the TI bq24190 charger
chip used on some Cherry Trail devices.

There the entire i2c-client is instantiated by platform code here:
drivers/i2c/busses/i2c-cht-wc.c

This attaches a struct bq24190_platform_data as platform data to
the i2c-client, this struct contains a single 

const struct regulator_init_data *regulator_init_data

member which then gets consumed (if there is platform data set) by
the regulator code in:

drivers/power/supply/bq24190_charger.c

For the tps68470 regulator code the platform_data then would need to
have 3 const struct regulator_init_data * members one for each of the
3 regulators.

This platform_data could then be directly set (based on a DMI match table)
from intel_skl_int3472_tps68470.c avoiding probe-ordering issues (1) with
the lookup solution and will allow the code containing the DMI and
regulator_init_data tables to be build as a module.

So all in all I think that this will be a better solution.

Regards,

Hans


1) You are forcing the DMI matching driver adding the lookups to be builtin
but what if the tps68740-MFD + regulatorcode is also builtin, then there
still is no guarantee the lookups will be added before the regulator drivers'
probe function runs


p.s.

I see that you mention something similar later in the thread referring to
the tps65023-regulator driver. I did not check, but assuming that uses what
I describe above; then yes the idea would be to do something similar for
the tps68740-code, setting the platform_data when (just before) the MFD-cells
are instantiated from intel_skl_int3472_tps68470.c



