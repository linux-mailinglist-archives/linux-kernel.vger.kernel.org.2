Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72EC3876E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbhERKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348645AbhERKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621334952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9o82/t1aU9A0RyJMcIxIuK9ctk3HZPsg/UH7WfdZC0=;
        b=Kqy/kJv8NwaUPbyFInS0p3MNt6uyqnfbVvcJpLogZtGLVgVxc8IIHsdiAgIHuFl0AG8DYM
        ah3jVfdGaZnsUpVbTWd2ewrnAs0RO2ipzDYoaSRbtUE1vwLVEm7h1qd/2VWjRK921/0y46
        l/mx21skmntfXUU4cf0GLmSeHmdmYzM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-0Q7d6OSRPySd7SI2thl4hA-1; Tue, 18 May 2021 06:49:11 -0400
X-MC-Unique: 0Q7d6OSRPySd7SI2thl4hA-1
Received: by mail-ed1-f69.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so5522033edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9o82/t1aU9A0RyJMcIxIuK9ctk3HZPsg/UH7WfdZC0=;
        b=lNxkOnoPJJED53UR4tKgJwGqkkFc06UyLkJyD5MhDXVhuQclmsMkkWyGYmi0l/QOEl
         VGbT+HuxLKBvxeijVd8J9AXPZBZ9Aa3Spnl+UC8sDUcRa7vVLh+8+UDa0beqtEk6JMx+
         u0g6II3wfQHcebbp9d6qSHKbg7920DE+tY6wc4ysa7H3sg/qKlbB1U6dIYqVoKFbyUj1
         oaYt5ubfOnESMgt5yPlmg/YfyoA46f1E2T11Xsbwb/Icle6nmxfk8BzRp4UQGsQXVoIH
         uCgoJg5AmmO72w4qn2MEAAMEsl4qff7EkveEoxfzRquFqfjTMTf9BRQEWTntx8m+JtC8
         34jA==
X-Gm-Message-State: AOAM532ENZGptYaHg4Y+neY07NYgzqamR90tetzUptmafZ2wDjufa0E+
        ee9LCNi3LCjVuxdCVGUQ67UGnG335zkTcqwPFTwSRMYoo3tgtgXcgSBBtt1BcxbDAzPyz+mZS6o
        TxrhGYGRPsr4DoaYrz+I+jF7u
X-Received: by 2002:a17:906:680d:: with SMTP id k13mr5386881ejr.371.1621334949954;
        Tue, 18 May 2021 03:49:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh1mcxlm43khVavmHz8Zmh3/+pHSIR9oAwFtuz2qwrtj+DWSf260PGu/51LsXVMMut+7eB4A==
X-Received: by 2002:a17:906:680d:: with SMTP id k13mr5386865ejr.371.1621334949787;
        Tue, 18 May 2021 03:49:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n13sm2080198ejk.97.2021.05.18.03.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:49:09 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        "pobrn@protonmail.com" <pobrn@protonmail.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mario.limonciello@outlook.com" <mario.limonciello@outlook.com>,
        Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20210412091919.27608-1-Perry_Yuan@Dell.com>
 <8176ceda-cdbf-b733-128d-0766eb6d180d@redhat.com>
 <SJ0PR19MB45288D5EFF2BD8B9926E40DD84589@SJ0PR19MB4528.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3657cfda-02d8-85b7-a9d2-257ded63e175@redhat.com>
Date:   Tue, 18 May 2021 12:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45288D5EFF2BD8B9926E40DD84589@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 5/6/21 11:48 AM, Yuan, Perry wrote:
> Hi Hans.
> I changed the driver in V8 as your comments.
> Just one Kconfig change , It will cause some built error .

<snip>

>>> diff --git a/drivers/platform/x86/dell/Kconfig
>>> b/drivers/platform/x86/dell/Kconfig
>>> index e0a55337f51a..05d124442b25 100644
>>> --- a/drivers/platform/x86/dell/Kconfig
>>> +++ b/drivers/platform/x86/dell/Kconfig
>>> @@ -204,4 +204,18 @@ config DELL_WMI_SYSMAN
>>>  	  To compile this driver as a module, choose M here: the module will
>>>  	  be called dell-wmi-sysman.
>>>
>>> +config DELL_PRIVACY
>>> +	tristate "Dell Hardware Privacy Support"
>>> +	depends on ACPI
>>> +	depends on ACPI_WMI
>>> +	depends on INPUT
>>> +	depends on DELL_LAPTOP
>>> +	depends on LEDS_TRIGGER_AUDIO
>>> +	select DELL_WMI
>>
>> DELL_WMI is not a helper library which can be selected, please use depends
>> on here.
>>
>> More in general I'm a bit worried about the dependencies being added to dell-
>> laptop.c and dell-wmi.c on the new dell-privacy-wmi.ko module.
>>
>> What if e.g. dell-laptop.c gets builtin while dell-privacy-wmi.c is a module.
>>
>> Then we have dell-laptop.c depending on the dell_privacy_present linker-
>> symbol, but that symbol is in a module, so the main vmlinuz binary will fail to
>> link due to that missing symbol.
>>
>> To fix this you need to add:
>>
>> 	depends on DELL_PRIVACY || DELL_PRIVACY = n
>>
>> To the Kconfig sections for both DELL_WMI and DELL_LAPTOP
> 
> If I add "depends on DELL_PRIVACY || DELL_PRIVACY = n" to both DELL_WMI and DELL_LAPTOP
> The compile will report error "recursive dependency detected"
> I do not think the dell-laptop will be builtin option as we know.
> 
> I am confused that why the symbol will be failed to link like that ?
> because the compiler can find the dell_privacy_present which is defined in one common header file.

The issue is that e.g the dell-laptop code may be builtin into the kernel
(so part of the vmlinuz file) while the dell-privacy code could be build
as a module (so as a dell-privacy.ko file) in this case building the vmlinuz
file will fail at the linking stage since the dell_privacy_present() symbol
is not part of vmlinuz where as the dell-laptop code which needs that
symbol is part of vmlinuz.

The reason why these circular dependency issues trigger is because the
dell-privacy.ko module actually does not depend (at a symbol level) on
dell-laptop / dell-wmi at all. It is the other way around dell-laptop
and dell-wmi use symbols from dell-privacy, where as dell-privacy can
be loaded into the kernel without dell-wmi / dell-laptop being loaded
just fine.

Now there is a functional dependency where dell-privacy does not do much
when it is not called form the event handler in dell-wmi, but this is not
a code-level dependency.

I've been thinking a bit about this and I've come to the following
conclusions:

1. dell-privacy should not depend on dell-laptop at all, the only reason
dell-laptop calls into dell-privacy is to not register a mic-mute LED if
dell-laptop is not build at all then it will also not register the mic-mute
LED, so the dependency of dell-privacy on dell-laptop can be dropped.

2. Building dell-privacy without also building dell-wmi is a different story
this will work fine, but the dell-privacy module will the mostly just sit 
there (it will provide the sysfs files) without really doing anything.

Also since dell-wmi will depend on dell-privacy when it is enabled,
dell-privacy will always need to be loaded when dell-wmi is loaded.

The dell-privacy code really is an extension to / plugin of the dell-wmi
code; and since the 2 always need to be loaded together anyways, it would
be better to put the code in a single kernel-module (less overhead loading
modules that way) and this also neatly solves the builtin vs module
dependency issue.

This way we can simply make DELL_PRIVACY a boolean option which controls if
privacy support gets added to the dell-wmi module or not, but since it is
now built into the same module (if enabled) we can never have the case where
one part is built into the kernel and the other into a .ko file.

I'm currently preparing a set of changes which implements this, because
this is sort of hard to describe with words and I hope that providing a
patch implemeting the suggested change make things a bit more clear.

I'll send another email when the changes are ready.

Regards,

Hans

