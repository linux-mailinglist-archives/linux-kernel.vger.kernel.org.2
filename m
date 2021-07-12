Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578313C59A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbhGLJGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357564AbhGLIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:17:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14383C05BD1A;
        Mon, 12 Jul 2021 01:13:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so14445331wrw.5;
        Mon, 12 Jul 2021 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gEW2I9s2+ajZXfRkmBqAsnkDquHOdtAkhp+k4q/Aqb0=;
        b=qyLxvTzi8AlkkKDheupXQsCjsTnlOiSLnhJlV/QNryDTxPsNZSrUMGRisS3PsX5CyT
         ezDbXebX/ghNr2qMQuBB0opvRZWI59lRVjt8GVlu1aSNmKGPtANerYSuOSC1f30KkvMO
         Bc3MVfJ6U0Y26j96bB/VGF60kwtlEmS8szOtH5SWWsEJQC0unkwDqtIS+2vmwLfZcFaK
         sM9UZ/9Hmn6l+K43twnDD1J9pLiAfBKUP3vgckcKmOdPOKsgHsMmYwvEyecl5Gcd4Pmc
         lny36/3X8RdQ2B6UWIGfU66sBlwUFsS7d4MPFnm40lhmkaunjHlvsYUfYAEjnr04thJH
         9DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gEW2I9s2+ajZXfRkmBqAsnkDquHOdtAkhp+k4q/Aqb0=;
        b=WlO79XOP8hjHVor7ma0h3YcxdyiM5Ie9g+W+Swpub5zMvvQ68xZR9RWJ4A1DNHcoS7
         sYQOte7r2T2U8JlmH5r6PVQ00DfQGjFyIXiRUGNXAs71wcbrWGWewKBRFwTd3AiNp6FY
         y6SOf0kEzXY+mk1cHhqN1LVTA/3TvOpwX7ceQcxK/8+4YhCBjsnbLu6Xz+/wTw6qVxKB
         v7PUX6Q8A5yV3hsAEFbMCSyAjJ8tamkIyeTRE59z/r0KZwWYMX7Edx+pmHNGwCIvydyJ
         FNdnPgEYrzThTNAK9NXzQ72vCwKyLSmWInN4NsYxLm3M/PGwvGGaYiK3FoCYQ9iuJgWC
         21Fg==
X-Gm-Message-State: AOAM530g949LZ+J1eEHD2yQPEcQ8sJ5scBlPURxE1qJRqArP1St3EThl
        72JMOBG69ZLSCHo98LEDno0=
X-Google-Smtp-Source: ABdhPJwn31VOrL46/k4EKcVttzMmyFyK5ySZSC4dW82D80R5X8dYDjEojSSrti1RcNW128579TuEJw==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr53166341wrv.75.1626077582670;
        Mon, 12 Jul 2021 01:13:02 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id f15sm5282157wmj.15.2021.07.12.01.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 01:13:02 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.shevchenko@gmail.com, kieran.bingham@ideasonboard.com
References: <20210708224226.457224-1-djrscally@gmail.com>
 <YOofAUshZQBPsBR0@pendragon.ideasonboard.com>
 <4381a32a-e6ca-a456-887d-6b343182aed4@gmail.com>
 <YOsimBVS/mElfiA7@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <1944291d-1486-fe7f-376b-fe3250ee6b7d@gmail.com>
Date:   Mon, 12 Jul 2021 09:13:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOsimBVS/mElfiA7@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On 11/07/2021 17:55, Laurent Pinchart wrote:
> Hi Dan,
>
> On Sat, Jul 10, 2021 at 11:54:26PM +0100, Daniel Scally wrote:
>> On 10/07/2021 23:28, Laurent Pinchart wrote:
>>> On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:
>>>> Hello all
>>>>
>>>> See previous series for some background context [1]
>>>>
>>>> Some x86 laptops with ACPI tables designed for Windows have a TPS68470
>>>> PMIC providing regulators and clocks to camera modules. The DSDT tables for
>>>> those cameras lack any power control methods, declaring only a
>>>> dependency on the ACPI device representing the TPS68470. This leaves the
>>>> regulator framework with no means of determining appropriate voltages for the
>>>> regulators provided by the PMIC, or of determining which regulators relate to
>>>> which of the sensor's requested supplies. 
>>>>
>>>> This series is a prototype of an emulation of the device tree regulator
>>>> initialisation and lookup functions, using software nodes. Software nodes
>>>> relating to each regulator are registered as children of the TPS68470's ACPI
>>>> firmware node. Those regulators have properties describing their constraints
>>>> (for example "regulator-min-microvolt"). Similarly, software nodes are
>>>> registered and assigned as secondary to the Camera's firmware node - these
>>>> software nodes have reference properties named after the supply in the same
>>>> way as device tree's phandles, for example "avdd-supply", and linking to the
>>>> software node assigned to the appropriate regulator. We can then use those
>>>> constraints to specify the appropriate voltages and the references to allow the
>>>> camera drivers to look up the correct regulator device. 
>>>>
>>>> Although not included in this series, I would plan to use a similar method for
>>>> linking the clocks provided by the TPS68470 to the sensor so that it can be
>>>> discovered too.
>>>>
>>>> I'm posting this to see if people agree it's a good approach for tackling the 
>>>> problem; I may be overthinking this and there's a much easier way that I should
>>>> be looking at instead. It will have knock-ons in the cio2-bridge code [2], as
>>>> that is adding software nodes to the same sensors to connect them to the media
>>>> graph. Similarly, is the board file an acceptable solution, or should we just
>>>> define the configuration for these devices (there's three orf our laptop models
>>>> in scope) in int3472-tps68470 instead?
>>> I may have missed something, but if you load the SGo2 board file, won't
>>> it create the regulator software nodes if it finds an INT3472,
>>> regardless of whether the device is an SGo2 ? If you happen to do so on
>>> a machine that requires different voltages, that sounds dangerous.
>> Ah, yes - hadn't thought of that. If a driver registered regulators with
>> those names, it would try to apply those voltages during registration.
>> Good point.
>>
>>> Given that INT3472 models the virtual "Intel Skylake and Kabylake camera
>>> PMIC", I think moving device-specific information to the int3472 driver
>>> may make sense. I'm unsure what option is best though, having all the
>>> data (regulators, clocks, but also data currently stored in the
>>> cio2-bridge driver) in a single file (or a single file per machine) is
>>> tempting.
>> It is tempting, particularly because (assuming we do end up using this
>> approach) setting the references to the supplies in a board file like
>> this complicated the cio2-bridge code quite a bit, since it then needs
>> to extend the properties array against an already-existing software node
>> rather than registering a new one. But then, I don't particularly want
>> to handle that aspect of the problem in two separate places.
> If technically feasible, gathering all the data in a single place would
> be my preference. Whether that should take the form of software nodes in
> all cases, or be modelled as custom data that the int3472 driver would
> interpret to create the regulators and clocks is a different (but
> related) question.


I'll have to think on that one then; the problem there is that the
cio2-bridge is just given ACPI HIDs for the sensors as "ok to parse
this", and of course the INT347A that is being dealt with here should
already be supported on most Surface platforms via the intel-skl-int3472
stuff, so once the ov8865 edits are (posted and) accepted and that
driver is supported my plan would be to add it into the bridge. So we'd
need a way to exclude Go2 from that if we wanted to define all the
software nodes parts in a single board file instead.

>
> The very important part is to ensure that the correct board data will be
> used, as otherwise we could damage the hardware.


Not sure how this is usually guarded against; we could do a DMI match at
the start of the init function to confirm it's running on a Go2 and exit
if not?

>
>>>> [1] https://lore.kernel.org/lkml/20210603224007.120560-1-djrscally@gmail.com/
>>>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L166
>>>>
>>>>
>>>> Daniel Scally (2):
>>>>   regulator: Add support for software node connections
>>>>   platform/surface: Add Surface Go 2 board file
>>>>
>>>>  MAINTAINERS                                |   6 +
>>>>  drivers/platform/surface/Kconfig           |  10 ++
>>>>  drivers/platform/surface/Makefile          |   1 +
>>>>  drivers/platform/surface/surface_go_2.c    | 135 +++++++++++++++++++++
>>>>  drivers/regulator/Kconfig                  |   6 +
>>>>  drivers/regulator/Makefile                 |   1 +
>>>>  drivers/regulator/core.c                   |  23 ++++
>>>>  drivers/regulator/swnode_regulator.c       | 111 +++++++++++++++++
>>>>  include/linux/regulator/swnode_regulator.h |  33 +++++
>>>>  9 files changed, 326 insertions(+)
>>>>  create mode 100644 drivers/platform/surface/surface_go_2.c
>>>>  create mode 100644 drivers/regulator/swnode_regulator.c
>>>>  create mode 100644 include/linux/regulator/swnode_regulator.h
