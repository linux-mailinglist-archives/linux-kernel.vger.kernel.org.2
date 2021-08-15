Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB13EC95E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhHONtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 09:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhHONtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629035332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hx/UIiuUh617W/1GfnOF+5H3Dy3NKp+XR2g6bWmnt8=;
        b=hmus91AHiyehXNteeVgO3kr66oKAMBVGNaXIFg4iBo+Zz0seMMOOrdR6JyqQvbDa6Z8zWR
        84nhTLFLwmoJHHSVJeH8CMCoJJ2vsGDSWukz5eCyg5W59NLQsURkRRvTyjNtJPnpmK/dhL
        XjVK11DMuYua/UOH+/xbysfh5w6xc34=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-efo6JEmMMfmNmTzUVwdgZg-1; Sun, 15 Aug 2021 09:48:51 -0400
X-MC-Unique: efo6JEmMMfmNmTzUVwdgZg-1
Received: by mail-ed1-f71.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so7432626edt.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 06:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Hx/UIiuUh617W/1GfnOF+5H3Dy3NKp+XR2g6bWmnt8=;
        b=GCQspI2bYgIROoDfgABEnM7k4b5oSIseX50HxaQXtRItvCKe5ahBv2rHLK+wkGdnso
         X4M9UUWGvSXQ1pbmNqI4hgPgDXigaN6DaeADZ5EC67iX+BDI6Ngo2Sfvb/qR8IT00qKp
         4lMpqn4drDk+7A0/A4f9B11yQOO27MwRMISKuJpiWxYvTvPr8eLXxhcrwK/+eIAk2qgB
         ql48zqFL5E1Y7DkvyZgeBwp2lgcO06X53qFGpO4eOtuHuC4ufzbHT0xwwNUcwsuL+isO
         hwAA4YrgNI/pFEsxDH8/FyuTsqd2o3lbZTqYgAKQZ4/qbUpyDlit514UxHa0pf91/aIg
         pMBQ==
X-Gm-Message-State: AOAM532Bq6CKTfoNargE6pnCdKyXIkaW0mNwINjttu8s+qMlI6OQ+3qL
        fGXcjMQ2Hz3qFbY0wKNNK2z80AK56qLRIU9RkJ5q7ptlR/wGyOG4w7K3kQSKQ+OzGUFqHCwkrwO
        joLuG+d4veFsO5ps3KDBVAaxy
X-Received: by 2002:a17:906:6815:: with SMTP id k21mr11714381ejr.371.1629035329974;
        Sun, 15 Aug 2021 06:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzun1pcyE79xFc2qV+KaI4M0OFpJ0zv3uhfNlJ9jCvj+r+1MlAoX1jaLZOtPvaRcBCFuae1fQ==
X-Received: by 2002:a17:906:6815:: with SMTP id k21mr11714370ejr.371.1629035329810;
        Sun, 15 Aug 2021 06:48:49 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id qa34sm2676935ejc.120.2021.08.15.06.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 06:48:49 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] asus-wmi: add platform_profile support
To:     Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210814043103.2535842-1-luke@ljones.dev>
 <THKTXQ.ELSNF0TA7RAV1@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a918bfe0-03c4-e7d3-8a99-efb1d11333e4@redhat.com>
Date:   Sun, 15 Aug 2021 15:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <THKTXQ.ELSNF0TA7RAV1@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/21 9:51 AM, Luke Jones wrote:
> 
> 
> On Sat, Aug 14 2021 at 16:31:02 +1200, Luke D. Jones <luke@ljones.dev> wrote:
>> Changelog:
>> - V2
>>   + Correctly unregister from platform_profile if
>>     throttle_thermal_policy fails
>>   + Do platform_profile_notify() in both throttle_thermal_policy_store()
>>     and in throttle_thermal_policy_switch_next()
>>   + Remove unnecessary prep for possible fan-boost modes as this
>>     doesn't match expected platform_profile behaviour
>> - V3
>>   + Add missing declaration for err in
>>     throttle_thermal_policy_switch_next
>>
>> Luke D. Jones (1):
>>   asus-wmi: Add support for platform_profile
>>
>>  drivers/platform/x86/asus-wmi.c | 139 +++++++++++++++++++++++++++++++-
>>  1 file changed, 135 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.31.1
> 
> Hi,
> 
> I teested the patch again and it appears that the platform_profile_notify() in both throttle_thermal_policy_store() and throttle_thermal_policy_switch_next() updates the /sys/firmware/acpi/platform_profile sysfs path fine, but userspace isn't updated?
> 
> The way I'm checking is:
> 1. echo 1 |sudo tee /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
> 2. cat -p /sys/firmware/acpi/platform_profile
>   - performance (updated correctly by platform_profile_notify)
> 3. Check gnome-settings, not updated.
> 
> Doing `echo "performance" |sudo tee /sys/firmware/acpi/platform_profile` updates both throttle_thermal_policy and userspace as expected. I'm wondering if I've missed something?

If you add a printk where you call platform_profile_notify() and you see that
happening, then you are likely seeing a userspace bug. Possibly your
power-profile-daemon is simply a bit old and therefor does not support
the combination of profiles which asus-wmi offers, IIRC it falls back to
using intel-pstate in that case.

You could try building the latest power-profile-daemon from git and run
it in verbose mode. If it sees the changes and the control-panel applet is
still not updating then I would not worry about that. The userspace code
is still somewhat new and I'm not sure which version your distro is
running and how well it is keeping up with gnome-updates.

Regards,

Hans

