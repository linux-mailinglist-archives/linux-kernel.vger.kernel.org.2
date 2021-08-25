Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DB3F7D94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhHYVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhHYVSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:18:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D8EC0613CF;
        Wed, 25 Aug 2021 14:17:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m2so465859wmm.0;
        Wed, 25 Aug 2021 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9/z/NF3N26zhWS/E+03iteB29Zu6AaL/L1WDa6dd7E=;
        b=BUJErb1H+V2lnEOxlnUvyg4oa+NFDWQfztZvow7+YRvEw3a5HcXurDXeFhtjXHGSHj
         srm9OvrPaQfttkT+hDP+C42nsm0kmECy4xaAxX07RpJzD8PGycZhwfXpauFv6bhIw28g
         tyjNENEph5oXgne5deb6sOQEFP0/IeGNwF/3m+/j8NSihuUPhJrjFHlFLOPx3unytP5x
         ezmjHLtZk90XbviHB+TPkY80ymXF+fAk7BNK0slRi6KAFqvOE2VX0Jfajxd+lehpmGHx
         NztY3rACj6e6KFsmSSt2fXaOQqh8VYtAEPb7HtBMSiKQN/zKQaiMLfuki/U/jZ98dh6P
         GIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9/z/NF3N26zhWS/E+03iteB29Zu6AaL/L1WDa6dd7E=;
        b=oEHpmVAkgqdfsagWvsIriii0x0y7//s+HWD2g76rCaDzKdwvgPD/N/oAPmOli+K3mO
         UTycmKhjVOBz+V8X6BiobwCViKySfnFSPRHUG9ywPVg1xlFOuGUJI6QPXbVJJfjxhibW
         XlTYneKgvkd8DMmP2oLie+zfS+Rl2FZzZ2rJgBBO8Ot3FDjfPPMb6EyvYZHhoHT3VQ2K
         1GCdcDegEzd+pHMGVZ+nWi4gqi3xc6iJ7xsPUq31sOOegWM+2CWRSEYQc3t9aK2T97Ct
         4aQVEXMcRDuHB/ny4GwVE4DLg7+6dhahMi020SltPHdNzKVFLVUFQkeonDwdbxaPs320
         Fvnw==
X-Gm-Message-State: AOAM532ElvxENIlVK+l3sWcJX76pn9Rw2PlKgvlCUjU3/MydHXsE/ndf
        mK6t38h4fVRoJlaYYT7DiNA=
X-Google-Smtp-Source: ABdhPJy7Ctfk/HC7p2IMDGm4xKFgeiglMiFMc6jXCrcFMccniRqopnXEH4z6zzibhK89ErZjVxWL1Q==
X-Received: by 2002:a05:600c:1c16:: with SMTP id j22mr400061wms.167.1629926274432;
        Wed, 25 Aug 2021 14:17:54 -0700 (PDT)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id z17sm1156192wrh.4.2021.08.25.14.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 14:17:54 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <b2cb553b-27ac-0552-4701-00f28a1a3a61@gmail.com>
Date:   Wed, 25 Aug 2021 22:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On 25/08/2021 15:48, Hans de Goede wrote:
> Hi all,
> 
> On 8/25/21 12:33 PM, Mark Brown wrote:
>> On Wed, Aug 25, 2021 at 12:06:18AM +0100, Daniel Scally wrote:
>>> In some situations regulator devices can be enumerated via either
>>> devicetree or ACPI and bound to regulator drivers but without any
>>> init data being provided in firmware. This leaves their consumers
>>> unable to acquire them via regulator_get().
>>>
>>> To fix the issue, add the ability to register a lookup table to a
>>> list within regulator core, which will allow board files to provide
>>> init data via matching against the regulator name and device name in
>>> the same fashion as the gpiod lookup table.
>>
>> This is the wrong level to do this I think, this is a generic problem
>> that affects all kinds of platform data so if we're not going to scatter
>> DMI quirks throughout the drivers like we currently do then we should
>> have a way for boards to just store generic platform data for a device
>> and then have that platform data joined up with the device later.  This
>> could for example also be used by all the laptop audio subsystems which
>> need DMI quirk tables in drivers for their components to figure out how
>> they're wired up and avoids the need to go through subsystems adding new
>> APIs.
> 
> Daniel, I believe that what Mark wants here is something similar to what
> we already do for the 5v boost converter regulator in the TI bq24190 charger
> chip used on some Cherry Trail devices.
> 
> There the entire i2c-client is instantiated by platform code here:
> drivers/i2c/busses/i2c-cht-wc.c
> 
> This attaches a struct bq24190_platform_data as platform data to
> the i2c-client, this struct contains a single 
> 
> const struct regulator_init_data *regulator_init_data
> 
> member which then gets consumed (if there is platform data set) by
> the regulator code in:
> 
> drivers/power/supply/bq24190_charger.c
> 
> For the tps68470 regulator code the platform_data then would need to
> have 3 const struct regulator_init_data * members one for each of the
> 3 regulators.
> 
> This platform_data could then be directly set (based on a DMI match table)
> from intel_skl_int3472_tps68470.c avoiding probe-ordering issues (1) with
> the lookup solution and will allow the code containing the DMI and
> regulator_init_data tables to be build as a module.
> 
> So all in all I think that this will be a better solution.

So assign an array of the init_data to the i2c-INT3472:nn device as
platform data before registering the MFD cells in
intel_skl_int3472_tps68470.c and parse that out when the regulators
register. OK - that's fine by me.

> 
> Regards,
> 
> Hans
> 
> 
> 1) You are forcing the DMI matching driver adding the lookups to be builtin
> but what if the tps68740-MFD + regulatorcode is also builtin, then there
> still is no guarantee the lookups will be added before the regulator drivers'
> probe function runs

Err, excellent point - I hadn't thought of that if I'm honest.

> 
> p.s.
> 
> I see that you mention something similar later in the thread referring to
> the tps65023-regulator driver. I did not check, but assuming that uses what
> I describe above; then yes the idea would be to do something similar for
> the tps68740-code, setting the platform_data when (just before) the MFD-cells
> are instantiated from intel_skl_int3472_tps68470.c

The tps65023-regulator driver parses init data out of platform data yes.
I think that that's fine, but personally I'd prefer that done in core.c
rather than in the regulator driver itself if possible.
