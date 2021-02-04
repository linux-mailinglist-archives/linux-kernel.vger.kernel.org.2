Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02930F1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhBDLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhBDLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612436874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0qMZgLk1sSCSpTWGZWJXmQjxOZwSFIzc7qTwzAZp/c=;
        b=M1gN+HH0ADlNQGaRWSW9Oo4EkAdAcHwC1OcCi46mnm2sQaFPsWloHjV0fPSPEDNicFV+qE
        ZaTVLbY8RqItfnoF4mGF7vJBnYf6iDthDnjeG7T6eFuc9fq/EBEPCiZzA7NkB4tTAVWLHL
        dofQp+0oYLA1LgEPP1FvUgdf7HAJ+tM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-x5QHIVgYMsuIlzwMkD0crg-1; Thu, 04 Feb 2021 06:07:52 -0500
X-MC-Unique: x5QHIVgYMsuIlzwMkD0crg-1
Received: by mail-ej1-f70.google.com with SMTP id le12so2376708ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0qMZgLk1sSCSpTWGZWJXmQjxOZwSFIzc7qTwzAZp/c=;
        b=FjpvfuO/ediTy0POUsgkQVJhrAasbpl2QoMI+Ky4heddm3Pa0doYPjD7XyV6WWVJcz
         sK+qpfmmfxYDacCl2DnNq6pF41Ae6mllZrsIW4Vak7e4qeM5UtWPuKrbENiJ4XBK1mQL
         LW/mf6UPdL2gRNdoYYicW3WPqQ61dpL+kZdLaqE75FZ/GGr0WH0Z3ydvl35JP7vaZd3X
         3rQxhe2PILn3+4z2n5v4/4weD94AAUGBA+cDK+093/Dl9sLnUwTFwK9RrGZFAVvAJSKe
         pJhQ2YmnX8MXhvyertCkGgD3EUZgE+gxcSVevrSlDnSEm9iTgVF1S1503JR/o1fp6Yrh
         dgJQ==
X-Gm-Message-State: AOAM5300MCU2CUx638NvI6b8TOyaq5k8T6wrDy6ZsvzFdzRCOyB2DNK3
        3ofcPfZwQlH9lB4VXsl4/Ffl39rTFClyi1XFAjiSyn49m8FogQUUf6mlzideu/N+/xKoNKLdAVe
        8LzIUG800PuI9/tw4nfeAaHxL
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr6190085edt.221.1612436871272;
        Thu, 04 Feb 2021 03:07:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDjpwt9knKChEkepFHLIybOBA0LsguChVehWT2nwhAjMnlRd6l8zMhzwjJJQwocZib7ICOeQ==
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr6190065edt.221.1612436871071;
        Thu, 04 Feb 2021 03:07:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id o4sm2289469edw.78.2021.02.04.03.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:07:50 -0800 (PST)
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
Date:   Thu, 4 Feb 2021 12:07:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204105748.GD2789116@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/21 11:57 AM, Lee Jones wrote:
> On Thu, 04 Feb 2021, Hans de Goede wrote:
> 
>> Hi all,
>>
>> On 1/20/21 10:49 PM, Hans de Goede wrote:
>>> Hi All,
>>>
>>> Here is v4 of my series to add support for Intel Bay Trail based devices
>>> which use a WM5102 codec for audio output/input.
>>>
>>> This was developed and tested on a Lenovo Yoga Tablet 1051L.
>>>
>>> The MFD and ASoC parts do not have any build-time dependencies
>>> on each other. But the follow-up jack-detect series does have
>>> patches depending on each-other and on this series. So IMHO it
>>> would be best if this entire series would be merged through the
>>> MFD tree to make merging the follow-up series easier.
>>>
>>> Mark, if that is ok with you (and you are happy with the ASoC
>>> changes) can you please Ack this ?
>>
>> I believe that this series and the follow-up:
>>
>> "[PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support"
>>
>> series are both ready for merging. All patches have Reviewed-by and/or
>> Acked-by tags now.
> 
> I don't think they do.  You're missing ASoC and Extcon Acks.

Right, what I meant is that the patches have been reviewed by other
stake-holders, including the follow-up series being tested by the cirrus
codec folks (thank you Charles).

But yes the actual subsys maintainers have not acked these yet;
and I'm aware that you will need those for merging this through
the MFD tree.

Note that this series only requires Mark ack, the follow-up
also touches extcon code, this one is purely MFD + ASoC patches.

> Not sure why *this* set fell through the cracks though.  However, it's
> now on my to-review list.
> 
> If I can work fast enough, maybe this series can get into 5.12, but
> the follow-up still needs reviews.
> 
> It might be best to collect the *-bys you do have and [RESEND].

Ok, will do.

>> I guess it is too late for 5.12, but it would be nice to at least formulate
>> a plan for getting this merged after 5.12-rc1 is out. Given the
>> interdependencies I still believe that it is best to merge all the patches
>> through the mfd tree and then have Lee provide an immutable branch for the
>> other subsystems to merge.
> 
> Yes, that's fine.
> 
>> Mark and extcon-maintainers (for the follow-up series) may we have your ack
>> for merging these through the MFD tree ?
> 
> Ah, you noticed that too!

Ack :)

Regards,

Hans

