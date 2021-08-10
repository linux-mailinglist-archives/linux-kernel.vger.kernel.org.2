Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7B53E548B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhHJHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231705AbhHJHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628581577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pet61wCaKM+lsHkOSnoMFXnGFsigaqQV7vnnC0iAqlg=;
        b=ixdU4KNeTYwMBjamQ7vzW75Ihdir1O1lHWi0vspqhfPU9uunRht+Mfmqfmqu/HA1eZoWiN
        DYEOChTQDUCbAsiXMFxamGnwiYg5wY8Xdij35q/Q2zjEmkmXUB1YYzrDJTh48ZIDwaD6nU
        kMS0ZSdjKBDgmXRH4PrlC9WkQ0IX2EE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446--MSCTiMJO26dY1s9lAy5sg-1; Tue, 10 Aug 2021 03:46:16 -0400
X-MC-Unique: -MSCTiMJO26dY1s9lAy5sg-1
Received: by mail-ej1-f71.google.com with SMTP id gg35-20020a17090689a3b0290580ff45a075so5247891ejc.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pet61wCaKM+lsHkOSnoMFXnGFsigaqQV7vnnC0iAqlg=;
        b=Tb65JjP+sOKrBdpCl40c1G/Eec/Hfm26l6GcLXflJCssJsjeV57BaMbwCOT/ZbXm+/
         iIeRoo1mrdauMoPA7mXqVL/E5W6HG3c2zgn03D/lkqEy0UaCMPY6OTTnsWDlZl6Sh22A
         3LYmu5iNWbHmwc+fY9zLdH/qMHyyLOdD9hXN7+7u44dvLuzIufoMlqrosW7Qw1ENyv23
         nfnn36dBYLXPvTMvMgDTVbNA/0aiXQ2vNWLyhYrjuEKI93oRzEo1vIqfz+jfNNBuVtKe
         0I0TOGB4AK/cf1s8MD3PAxwudGra6Te8PdRFuZ+Aqzx+sZSSCv8N6wOgd8HqlYrl2XHi
         NsKw==
X-Gm-Message-State: AOAM531GqRzGUgeOMHGM84+qtg/nFsxZcQENZlvQpla3zB5KfFOsHvFU
        fi2mBz4vV/KzGjX/3mJMnTSLTbSZ3uRPUaXiqI/dyIZtVEhJMXRTWTUN6g/d0oYaidMBW+wFl9q
        YlGUG1Te5omIeVcwOHA7G+N8g
X-Received: by 2002:a17:906:f910:: with SMTP id lc16mr13700149ejb.478.1628581574872;
        Tue, 10 Aug 2021 00:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx54Wk3W3eCyLne4AIxttvR15u3VbfD+qRW+hB9OMtgfCKRAtY9kWCsPEViOmfyLqTGXN97OA==
X-Received: by 2002:a17:906:f910:: with SMTP id lc16mr13700136ejb.478.1628581574693;
        Tue, 10 Aug 2021 00:46:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g9sm9241632edl.52.2021.08.10.00.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 00:46:14 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel
 overdrive
To:     Luke Jones <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, mgross@linux.intel.com,
        pobrn@protonmail.com, corentin.chary@gmail.com
References: <20210807023656.25020-1-luke@ljones.dev>
 <aec7b518-0979-7b7e-f776-a2ebb0fc19fc@redhat.com>
 <FYDLXQ.TA0Y98DS5UW4@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <96aa39fd-119a-f79e-ee74-2db6d117fac3@redhat.com>
Date:   Tue, 10 Aug 2021 09:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <FYDLXQ.TA0Y98DS5UW4@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Added platform-driver-x86@vger.kernel.org to the Cc>

On 8/9/21 11:49 PM, Luke Jones wrote:
> 
> 
> On Mon, Aug 9 2021 at 11:18:38 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Luke,
>>
>> On 8/7/21 4:36 AM, Luke D. Jones wrote:
>>>  This patch series adds support for some functions that are found on newer
>>>  ASUS gaming laptops:
>>>
>>>  - Panel overdrive: Some laptops can drive the LCD matrix slightly faster
>>>    to eliminate or reduce ghosting artifacts
>>>
>>>  - dGPU disable: ASUS added a function in ACPI to disable or enable the dGPU
>>>    which removes it from the PCI bus. Presumably this was to help prevent
>>>    Windows apps from using the dGPU when the user didn't want them to but
>>>    because of how it works it also means that when rebooted to Linux the dGPU
>>>    no-longer exits. This patch enables a user to echo 0/1 to a WMI path to
>>>    re-enable it (or disable, but the drivers *must* be unloaded first).
>>>
>>>  - eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an optional
>>>    eGPU. This patch enables the user to echo 0/1 to a WMI path to enable or
>>>    disable the eGPU. In ACPI this also appears to remove the dGPU from the
>>>    PCI bus.
>>>
>>>  All of the above patches have been tested over the course of a few months.
>>>  There is a small possibility of user error perhaps, where the user tries to
>>>  enable or disable the dGPU/eGPU while drivers are loaded which would cause
>>>  a system hang, but it is expected that almost all users would be using the
>>>  `asusctl` daemon and dbus methods to manage the above which then eliminates
>>>  these issues.
>>
>> Thank you for the new version, all 3 patches look good to me, but I miss
>> a changelog in this cover-letter.
>>
>> Specifically I'm wondering what happened to the following,
>> which you wrote about in the v1 patch-set thread:
>>
>> """
>> Proper enable of the dGPU again as far as my testing goes works such that:
>> 1. call the ACPI method
>> 2. rescan PCI bus to ensure the device is powered
>> 3. call the ACPI method again to save the setting
>>
>> But it appears that recent work in-kernel for many things AMD related has broken this for us...
>> """
> 
> Apologies, I've been a bit too busy to remember some things.
> 
> The changes are mostly to satisfy review. The dGPU patch has removed the
> dual call to the ACPI method, it was not working as expected. I will revisit
> this when 5.14 kernel is released.

Ok, so from my pov these patches are ready for merging now, but since this
is still somewhat of an open question, I wonder if they are also ready
for merging from your pov, or if you want to fist sort this out ?

> I'll be sure to remember the changelog next time I submit a patch, sorry.

No problem.

Regards,

Hans



>>>  Luke D. Jones (3):
>>>    asus-wmi: Add panel overdrive functionality
>>>    asus-wmi: Add dgpu disable method
>>>    asus-wmi: Add egpu enable method
>>>
>>>   drivers/platform/x86/asus-wmi.c            | 289 +++++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h |   7 +
>>>   2 files changed, 296 insertions(+)
>>>
>>>  --
>>>  2.31.1
>>>
>>
> 
> 

