Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01873C3730
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGJW5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 18:57:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F1C0613DD;
        Sat, 10 Jul 2021 15:54:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v5so18164056wrt.3;
        Sat, 10 Jul 2021 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hfAs0NB8K81duOX2SFWx8kJuMaiG2JXE4976BwXisyI=;
        b=rCvZak+zDQau4uxBiJF9Uag0LP0T+8Qsml3cp90dYfE6Dq9mEbxP2cArs/TnLRUAf2
         FgpZOBmHj7UrIQgTfFjncGsscKL/auRasftPEE108HcZ/WCoYEE7B2g8JxslVH6b2mlL
         7QOoJFTH6iNxgFmWtHoKWFRMC2CMNorXJ6ARcWIkJehphBAto2Wp7fC4nVGrWg2PUrB6
         UazftaX5A+1mqCmwBs/jkMNX/WXzqUkbb1gIS6ytyYMI8Ig5XfN2piQElGnhRI5NvLwb
         bdGQaZLWMI01gJI/fqi3gybuJKsLp0OI4OJUlmZlEV1uttuRQMUmI+TJFd/SQ9Ke7amC
         iyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hfAs0NB8K81duOX2SFWx8kJuMaiG2JXE4976BwXisyI=;
        b=U6VTUb9q1s3e3vd/hMlaKWxSiH3j81FCbwms99NclwgFYIJeNiaBKmkWOXL/xZS1Ul
         NFKhPXPg2FTK46n4Cqw/Nxag/NoezIt3zUmdyjQtu2VKrJPZ73W8wNNZBJUSw9R4dyW7
         GOlRlT1H+x9+HZon+/pR7DRvOzFQjVFh4uj1WFxK+nPFGrOQG0WPNL5M80sPx/w3x6vm
         yDciEhp4PgbXCQ41Rit+uiSNR+P5V6CK5r1f2/jJS36XOaF+DAPyg5gsHiz2f438sULI
         A9RBtFb3XvA2hyi5Y0YgffVerGrmvJEdiGe1yK+0rawb+1yz07R448IdGNvRA6WPm0Pu
         rxbw==
X-Gm-Message-State: AOAM533LZ85JV60didsNWXMlmY0LFLRNbjHNun43eYDXKwW3fbQkIJDo
        msgIivKPkp9FyUpoYtZVeQ8=
X-Google-Smtp-Source: ABdhPJyaGSy5aXxPnCC8aWZmLiPcP+F85flI1MxCkQHn39XYFizrROEN1pbpjwaHtu2Qwj9xBBNnKg==
X-Received: by 2002:a05:6000:1b8c:: with SMTP id r12mr41038164wru.427.1625957667148;
        Sat, 10 Jul 2021 15:54:27 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id 3sm393279wrb.63.2021.07.10.15.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 15:54:26 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.shevchenko@gmail.com, kieran.bingham@ideasonboard.com
References: <20210708224226.457224-1-djrscally@gmail.com>
 <YOofAUshZQBPsBR0@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <4381a32a-e6ca-a456-887d-6b343182aed4@gmail.com>
Date:   Sat, 10 Jul 2021 23:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOofAUshZQBPsBR0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On 10/07/2021 23:28, Laurent Pinchart wrote:
> Hi Dan,
>
> On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:
>> Hello all
>>
>> See previous series for some background context [1]
>>
>> Some x86 laptops with ACPI tables designed for Windows have a TPS68470
>> PMIC providing regulators and clocks to camera modules. The DSDT tables for
>> those cameras lack any power control methods, declaring only a
>> dependency on the ACPI device representing the TPS68470. This leaves the
>> regulator framework with no means of determining appropriate voltages for the
>> regulators provided by the PMIC, or of determining which regulators relate to
>> which of the sensor's requested supplies. 
>>
>> This series is a prototype of an emulation of the device tree regulator
>> initialisation and lookup functions, using software nodes. Software nodes
>> relating to each regulator are registered as children of the TPS68470's ACPI
>> firmware node. Those regulators have properties describing their constraints
>> (for example "regulator-min-microvolt"). Similarly, software nodes are
>> registered and assigned as secondary to the Camera's firmware node - these
>> software nodes have reference properties named after the supply in the same
>> way as device tree's phandles, for example "avdd-supply", and linking to the
>> software node assigned to the appropriate regulator. We can then use those
>> constraints to specify the appropriate voltages and the references to allow the
>> camera drivers to look up the correct regulator device. 
>>
>> Although not included in this series, I would plan to use a similar method for
>> linking the clocks provided by the TPS68470 to the sensor so that it can be
>> discovered too.
>>
>> I'm posting this to see if people agree it's a good approach for tackling the 
>> problem; I may be overthinking this and there's a much easier way that I should
>> be looking at instead. It will have knock-ons in the cio2-bridge code [2], as
>> that is adding software nodes to the same sensors to connect them to the media
>> graph. Similarly, is the board file an acceptable solution, or should we just
>> define the configuration for these devices (there's three orf our laptop models
>> in scope) in int3472-tps68470 instead?
> I may have missed something, but if you load the SGo2 board file, won't
> it create the regulator software nodes if it finds an INT3472,
> regardless of whether the device is an SGo2 ? If you happen to do so on
> a machine that requires different voltages, that sounds dangerous.


Ah, yes - hadn't thought of that. If a driver registered regulators with
those names, it would try to apply those voltages during registration.
Good point.

> Given that INT3472 models the virtual "Intel Skylake and Kabylake camera
> PMIC", I think moving device-specific information to the int3472 driver
> may make sense. I'm unsure what option is best though, having all the
> data (regulators, clocks, but also data currently stored in the
> cio2-bridge driver) in a single file (or a single file per machine) is
> tempting.


It is tempting, particularly because (assuming we do end up using this
approach) setting the references to the supplies in a board file like
this complicated the cio2-bridge code quite a bit, since it then needs
to extend the properties array against an already-existing software node
rather than registering a new one. But then, I don't particularly want
to handle that aspect of the problem in two separate places.

>> [1] https://lore.kernel.org/lkml/20210603224007.120560-1-djrscally@gmail.com/
>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/media/pci/intel/ipu3/cio2-bridge.c#L166
>>
>>
>> Daniel Scally (2):
>>   regulator: Add support for software node connections
>>   platform/surface: Add Surface Go 2 board file
>>
>>  MAINTAINERS                                |   6 +
>>  drivers/platform/surface/Kconfig           |  10 ++
>>  drivers/platform/surface/Makefile          |   1 +
>>  drivers/platform/surface/surface_go_2.c    | 135 +++++++++++++++++++++
>>  drivers/regulator/Kconfig                  |   6 +
>>  drivers/regulator/Makefile                 |   1 +
>>  drivers/regulator/core.c                   |  23 ++++
>>  drivers/regulator/swnode_regulator.c       | 111 +++++++++++++++++
>>  include/linux/regulator/swnode_regulator.h |  33 +++++
>>  9 files changed, 326 insertions(+)
>>  create mode 100644 drivers/platform/surface/surface_go_2.c
>>  create mode 100644 drivers/regulator/swnode_regulator.c
>>  create mode 100644 include/linux/regulator/swnode_regulator.h
