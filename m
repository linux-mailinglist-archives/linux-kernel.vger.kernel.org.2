Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364213F2A10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhHTKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237612AbhHTKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629454943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAVnxbpwbOVsn7HcIwVS0GBVlNC8DuXDYjaXIyiz7eU=;
        b=OeldEmhI2GFeKcsea2IROcyCXX/q2gBOBDrEBZsszsefy/FQ6S2hsj1j97UkzwQWt5jLqo
        3IcITcE90gKcMfMyIlZCjiRrQPoib5VHCNZof9SmCVih5Urgns8rckNQTOKNmL7fH30Qld
        koMi66kj42Ly5JaFZUmk2GoF5kcJGHY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-9yV6bT-oMuCBSvRt_FDMqg-1; Fri, 20 Aug 2021 06:22:22 -0400
X-MC-Unique: 9yV6bT-oMuCBSvRt_FDMqg-1
Received: by mail-ej1-f70.google.com with SMTP id u23-20020a1709064ad700b005bb12df6cb9so3496461ejt.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XAVnxbpwbOVsn7HcIwVS0GBVlNC8DuXDYjaXIyiz7eU=;
        b=s7E8xOJ/5EU2Znf5S2KaNFU4XKxu2aaRAHMJoCW63u8hITaqQOpbCVxsyMiR2Vnbw+
         AxVr6hSGdZx2KCJdzPnFbmMVMPzle1Ma51WaclUhjIIO1V3lStWTnOXsMcFkMScpxsiP
         AMCaMMzhQj3dJEqFsVWzUcUExT2OTVGx8z05Bvuym//PnWp2ePZYoflwDa/o5qBWRLzE
         F2oWXYl2jpghT+xCZMI2QYPZR79kC7JO1shCcznmjVQHr6BM5shaV7Z1HwA1OO+w255L
         ApuSzfPkKE8YyvaB3nFGkU7ARnDlLE6nt6t0RjJ5bLJkzi10Um5FBWVN17L6DoJ/mP6w
         l2AA==
X-Gm-Message-State: AOAM530R6oT43tOYc5BfBJFJ5n+ZfGGksgNVShDQ4WVyFd7qgI7Aq2ML
        BNKQx2iSAYPXsjcWvnBmHGm+3R+Bm0U4Nliuo1pvFp72owvPblubWmqTLHTusgcdXnTRffTkfk5
        pqWSVkcVWmRG9V6bbXh7tETcJ
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr20394282ejs.197.1629454941208;
        Fri, 20 Aug 2021 03:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7RRelI6kqeUXQCY2GjnmyAsk9Pf2DpRAQeCk3d0+VnvWxO5X7Nh8kvz9ZP8T0ZWAv4lEQ5w==
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr20394266ejs.197.1629454941023;
        Fri, 20 Aug 2021 03:22:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f12sm2630051ejz.99.2021.08.20.03.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 03:22:20 -0700 (PDT)
Subject: Re: [PATCH v4 00/21] platform/x86: Intel platform driver code
 movement
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
 <b152a497-9cbe-83fa-e04a-f5d2a5b875f3@redhat.com>
 <YR9/83LozDtedLKZ@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <35fcce39-dc82-a656-a3f5-0a39dee39cff@redhat.com>
Date:   Fri, 20 Aug 2021 12:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR9/83LozDtedLKZ@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/21 12:12 PM, Andy Shevchenko wrote:
> On Thu, Aug 19, 2021 at 08:46:14PM +0200, Hans de Goede wrote:
>> On 8/19/21 6:37 PM, Andy Shevchenko wrote:
>>> This is v4 of the Intel drivers move on in the source tree.
>>> v3 has been done by Kate:
>>> https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/
>>>
>>> I have taken the initial set from review-hans branch and removed Hans' SoB
>>> along with Link, while leaving others' tags.
>>>
>>> Changelog v4:
>>> - spelled fully the driver names in the commit messages
>>> - fixed SCU *.ko module names
>>
>> Actually I checked this during review and
>> CONFIG_INTEL_SCU_IPC, CONFIG_INTEL_SCU_PCI and CONFIG_INTEL_SCU_WDT
>> are booleans, iow if enabled they are always builtin so the
>> drivers/platform/x86/intel/scu/Makefile from v3 was correct.
>>
>> Since the v3 Makefile is more simple I prefer that version,
>> but if you prefer to keep the v4 version that is fine too.
> 
> I prefer mine, but we need to fix what kbuild bot complained about.

Right, so I've taken a look at that and I believe that
we need to change 2 things:

1. In drivers/platform/x86/intel/Makefile, use:

obj-$(CONFIG_INTEL_SCU_IPC)		+= scu/

Instead of:

obj-$(CONFIG_INTEL_SCU)			+= scu/

Since "config MFD_INTEL_PMC_BXT" from drivers/mfd/Kconfig
selects INTEL_SCU_IPC not INTEL_SCU. From a pdx86 pov thos
makes on difference since CONFIG_INTEL_SCU selects
INTEL_SCU_IPC too, so all pdx86 Kconfig options needing us to
dive into the scu subdir also end up selecting INTEL_SCU_IPC
(through INTEL_SC).

2. The "select INTEL_SCU_IPC" done by CONFIG_MFD_INTEL_PMC_BXT
only works if make will actually dive into the
drivers/platform/x86/intel subdir which requires
CONFIG_X86_PLATFORM_DRIVERS_INTEL to be set, so in the
"config MFD_INTEL_PMC_BXT" section of drivers/mfd/Kconfig

The following change should be made:

-	depends on X86_PLATFORM_DEVICES
+	depends on X86_PLATFORM_DRIVERS_INTEL

To ensure that we dive into the intel subdir of
drivers/platform/x86, note that X86_PLATFORM_DRIVERS_INTEL
depends on X86_PLATFORM_DEVICES (through being part of a
"if X86_PLATFORM_DEVICES" Kconfig section), so we can just
replace the depends on, rather then adding a new one.

With those 2 things changed that error should be gone.

This requires an ack from Lee to merge the drivers/mfd/Kconfig
change through pdx86, so as discussed I agree that it is best
to delay moving the scu bits till after 5.15-rc1 is out.

> 
>>> - dropped extra prefix in PMC files
>>> - dropped stray changes within the series
>>> - removed confusing comments in Makefile and Kconfig files
>>> - embedded a few of Kconfig improvements here and there (ordering, spelling)
>>> - split miscellaneous group
>>> - added a patch to fix kernel doc issue in SCU IPC code
>>
>> Thanks, I've not (re)reviewed things, but this all sounds good.
>>
>>> So, I have noticed the report about SCU and taking into account IPS
>>> header deferred move, I think those two should be excluded from the
>>> series and sent after rc1, it will also eliminate trampoline move for
>>> IPS header, since we may send one patch which includes DRM changes.
>>>
>>> Hans, what do you think?
>>
>> Fixing the SCU thing will require coordination with / an 
>> ack from the MFD maintainer (Lee) so yeah dropping that for
>> now and doing the SCU move next cycle is probably the best.
>>
>> Dropping the IPS move for now is fine with me too.
>>
>> Can you send a v5 with those 2 patches dropped ?> 
> Yes.

Great, thank you.

Regards,

Hans

