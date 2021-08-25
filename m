Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF73F7DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhHYVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHYVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:25:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B54C061757;
        Wed, 25 Aug 2021 14:24:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so1444570wrr.9;
        Wed, 25 Aug 2021 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2sGWR37RpWkVIrNIn8nFzaxQVOPNItrLQpM9jzyZoQc=;
        b=fupr9PHleMydFaN8AE06xZXgkXKB1sz2OOf8hPhSPUvhawCDm4avojgMyk8uj0un9q
         2tBcZns8K4ky9Ah6ztabE4tMG2O7PTOc1VcynFsnvVRW5LlufWYQg2uzRvuki3m/oe52
         RTM/B0PmPgVhtoADTnjnDRPWPWYFv7PHaOOSQdsElqfVo9RCTvTZF5NHczmBcX3d8qFr
         dBoaPQV5ZNWkcnimk5Qu8E8NxVorKNorNM5cRZH53EOu1gIannZgIEKmPxaQBuaFPzzO
         Hil23F4iS9kXUEiVQNQpJUcXvmuFDK+fnfX58mmQlNZVWmFurvtQh+oLnlkF8SNp5SEC
         TWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2sGWR37RpWkVIrNIn8nFzaxQVOPNItrLQpM9jzyZoQc=;
        b=hoxMlV2Bz99I3bdFjGA7SisTCuz053mV4ZI1xjeLGJosKqth4qwQ32kQbQo13c/VN0
         DJpzvcQnMghANazzNTLYT9FbEclzOLEvKv+sj1ltr3Mc8pPFXxfoV7treiU0U4SvVyhh
         c0EZM5LdFNGvpG4ZikUZuO/WkgRNrfY4smmjvt5Yc5ssPJK+0qVyQY3bWKSjkEn6uojN
         kAPxq6vwy4GALgHWrH00LSqFJ4X8krFsfoY5j9YedqmrYJYbEiyvPW4svhNjtX7AIFVR
         BfPNOMhuSL8o/LZUPuk8/yWTNsOCpqE8On6Vifdd06AcpGBM9fgODapEB3BU1zOqVvlf
         avCw==
X-Gm-Message-State: AOAM532Z52EfXD7TMuFxG7upcUxjudnuI/ZLZYBB8uOr/mx2WU9ac9TH
        iW3TvzPF4o9evWdRm+DSVwQ=
X-Google-Smtp-Source: ABdhPJwfGmkhLg6YyYcfNQwNGlWylrZhfwOU2cSAWAU6gWSSpU7kBJJjoIioPnm7QlVuGRSj3sOEmg==
X-Received: by 2002:a5d:4bca:: with SMTP id l10mr162360wrt.187.1629926680446;
        Wed, 25 Aug 2021 14:24:40 -0700 (PDT)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k16sm1037902wrx.87.2021.08.25.14.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 14:24:40 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
 <20210825152735.GJ5186@sirena.org.uk>
 <YSZk5tyAxZoosXS3@pendragon.ideasonboard.com>
 <a5421695-803a-52fd-ea2e-edd9ef548892@redhat.com>
 <YSaq1R6kp6tYeRAJ@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <a71a448f-3782-93f1-fb1d-0334db8df5a8@gmail.com>
Date:   Wed, 25 Aug 2021 22:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSaq1R6kp6tYeRAJ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2021 21:40, Laurent Pinchart wrote:
> Hi Hans,
> 
> On Wed, Aug 25, 2021 at 10:25:23PM +0200, Hans de Goede wrote:
>> On 8/25/21 5:42 PM, Laurent Pinchart wrote:
>>> On Wed, Aug 25, 2021 at 04:27:35PM +0100, Mark Brown wrote:
>>>> On Wed, Aug 25, 2021 at 04:48:15PM +0200, Hans de Goede wrote:
>>>>
>>>>> Daniel, I believe that what Mark wants here is something similar to what
>>>>> we already do for the 5v boost converter regulator in the TI bq24190 charger
>>>>> chip used on some Cherry Trail devices.
>>>>
>>>> Yeah, that or something like a generalized version of it which lets a
>>>> separate quirk file like they seem to have register the data to insert -
>>>> I'd be happy enough with the simple thing too given that it's not
>>>> visible to anything, or with DMI quirks in the regulator driver too for
>>>> that matter if it's just one or two platforms but there do seem to be
>>>> rather a lot of these platforms which need quirks.
>>>
>>> Let's also remember that we have to handle not just regulators, but also
>>> GPIOs and clocks. And I'm pretty sure there will be more. We could have
>>> a mechanism specific to the tps68470 driver to pass platform data from
>>> the board file to the driver, and replicate that mechanism in different
>>> drivers (for other regulators, clocks and GPIOs), but I really would
>>> like to avoid splitting the DMI-conditioned platform data in those
>>> drivers directly. I'd like to store all the init data for a given
>>> platform in a single "board" file.
>>
>> I agree, but so far all the handling for clks/gpios for IPU3 (+ IPU4 (*))
>> laptops is done in the drivers/platform/x86/intel/int3472 code and the
>> passing of platform_data with regulator init-data would also happen in
>> the mfd-cell instantiation code living there. IOW if we just go with
>> that then we will already have everything in one place. At least
>> for the IPU3 case.
> 
> If the GPIOs are also hooked up to the TPS68470 and not to GPIOs of the
> SoC, then I suppose that would be fine in this case.

The GPIOs that we're translating into clks / mapping to the sensors in
the INT3472 code are SOC GPIOs actually...this is the first bit of code
that relates to a physical TPS68470.
> 
> Do you have any plan to work on IPU4 support ? ;-)
> 
>> *) IPU4 also used the INT3472 ACPI devices and what we have for discrete
>> IO devices seems to match.
> 
