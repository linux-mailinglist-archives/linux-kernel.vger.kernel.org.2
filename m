Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856093F0C77
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhHRUML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhHRUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629317488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLs6kjcvM8JscWCnRxRfzkFiQuDwgW1TjvaPNWOcLuE=;
        b=SpFC92UtAuhmphFzANigXy15M5/RDiIfIvzyHxWUuE9tpHnQl0lVDtYmg/ZdcavMJPo3iJ
        3eRB0ntmsNmu07UJaai5BghPfBkbWJKTGiiVcs5eTQ8ShafEB+oiWQ67csUToILBJAbwtk
        x/xXkmD3jkjm4vb4fpVXFV1a1oRTxbo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-byTFS5Z_OVqlrUcQ4BloMQ-1; Wed, 18 Aug 2021 16:11:27 -0400
X-MC-Unique: byTFS5Z_OVqlrUcQ4BloMQ-1
Received: by mail-ej1-f71.google.com with SMTP id gv53-20020a1709072bf500b005c0428ef7e7so1281523ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLs6kjcvM8JscWCnRxRfzkFiQuDwgW1TjvaPNWOcLuE=;
        b=KyJeVgl3Q9LJx/c+ZlJJWv4cyNAx9NRWzLZ04a8SHxScNpUMU8tss3Oh3g+9JOSfbq
         6XtrRixxckHczN/AYQ4NzCe6JpxlA0VmpNmVYTm3enQGy65xnaFTsbsx1IWKAtqw0RED
         P7LNj0j7O0qghnVO4GyZ9xXB5YGADVC8vjnfGo5c2EB+b/Nwd3EUe8WrLyJPV3FHobG4
         ULekoCzM99BzYK42LjfmSAYGaRCc8i6fxnPDtoBDx5Ud8sYGUADX9rY4Oh3xheyUyu71
         Dritrfiao6uyHMMVG7B6489ZnOQn0VWfNrLhEs70sMac0Wj+1NlRPpnK4It67E+lwLvq
         DKJg==
X-Gm-Message-State: AOAM532Bbic6Nj5OWbuWy2cs1lBdJghGdhH2rrceEf75Yw3q+aLQcaSm
        6PvjYDOJKDgSEwhNDBLO0EEgzsRzrhL869YsNCwLscEwlaqRPM0GrTep1yFfr1LpUwzJL6MpuJ/
        vhbsflaPBXzWuHYRq15iTLrD6
X-Received: by 2002:a17:906:f190:: with SMTP id gs16mr11713416ejb.439.1629317485833;
        Wed, 18 Aug 2021 13:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/BgGyHdAEnrW2mb49uKtrU4aN5u4gAYv/XRY8V8vSeIN6dDnAL66mGaOiytPd76Wjbjpzlg==
X-Received: by 2002:a17:906:f190:: with SMTP id gs16mr11713403ejb.439.1629317485685;
        Wed, 18 Aug 2021 13:11:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v1sm335171ejd.31.2021.08.18.13.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 13:11:25 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] asus-wmi: Add support for platform_profile
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
References: <20210818190731.19170-1-luke@ljones.dev>
 <20210818190731.19170-2-luke@ljones.dev>
 <tkJb_14m7EeHjs3G_DaqN0tMCLMA4qNheZDxfrsnGHoxFrsxOebsq46o8pXT-f7i2SgcZiFGk8FEy6BWVeT7xtTShgbyXqYNyeu58bayOS0=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <028ac156-6fac-487b-3e24-e9e92d6a0b4d@redhat.com>
Date:   Wed, 18 Aug 2021 22:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <tkJb_14m7EeHjs3G_DaqN0tMCLMA4qNheZDxfrsnGHoxFrsxOebsq46o8pXT-f7i2SgcZiFGk8FEy6BWVeT7xtTShgbyXqYNyeu58bayOS0=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 9:25 PM, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2021. augusztus 18., szerda 21:07 keltezéssel, Luke D. Jones írta:
>> Add initial support for platform_profile where the support is
>> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>
>> Because throttle_thermal_policy is used by platform_profile and is
>> writeable separately to platform_profile any userspace changes to
>> throttle_thermal_policy need to notify platform_profile.
>>
>> In future throttle_thermal_policy sysfs should be removed so that
>> only one method controls the laptop power profile.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/Kconfig    |   1 +
>>  drivers/platform/x86/asus-wmi.c | 130 +++++++++++++++++++++++++++++++-
>>  2 files changed, 127 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index d12db6c316ea..46dec48a36c1 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> [...]
>> +static int platform_profile_set(struct platform_profile_handler *pprof,
>> +				enum platform_profile_option profile)
>> +{
>> +	struct asus_wmi *asus;
>> +	int tp;
>> +
>> +	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>> +
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>> +		break;
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> +		break;
>> +	case PLATFORM_PROFILE_QUIET:
>> +		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	asus->throttle_thermal_policy_mode = tp;
>> +	return throttle_thermal_policy_write(asus);
> 
> Here the new mode will be stored even if activating it fails, no?

Yes I noticed this too. This is the same way how writing to
the throttle_thermal_policy sysfs file works, so this is consistent.

I know it is a bit weird, but normally the throttle_thermal_policy_write()
call never fails (throttle_thermal_policy_store does not check it at all).

And even if it fails, what does that mean we certainly did make the ACPI
call maybe the profile was actually changed but then some later ACPI code
setting up the return buffer failed ?  Or maybe the ACPI code did actually
never get around to forwarding the value to e.g. the EC ?

We basically don't know ...

IOW I think this is fine as is, it is a bit weird but it is consistent
with the existing callers of throttle_thermal_policy_write().

Regards,

Hans

