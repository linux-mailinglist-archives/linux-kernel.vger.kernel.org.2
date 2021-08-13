Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F63EB3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhHMKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239018AbhHMKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628849124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itGECD/NeEf0euRkK98TaWC9SHx56I0GWHOyhepZPxA=;
        b=NdqRnAoO9oOzar/rW475ubkdCv5XtYh+E5DjqO62a/5GfiEU3ltgD15hG2x2kNFckorXLe
        F6ubT6WBD10Ez66G2uP2fZrO1RpG6isZ7MUl/AFc2J6pBk7fPUMJZO73DUAlsAyAUCY4tw
        ++9OK5ck4OGGQ7wGlmhVWzoqNGhPXWc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-wqUMVWdmNo-1YjJTxGLl8w-1; Fri, 13 Aug 2021 06:05:23 -0400
X-MC-Unique: wqUMVWdmNo-1YjJTxGLl8w-1
Received: by mail-ed1-f69.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso4610764edh.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=itGECD/NeEf0euRkK98TaWC9SHx56I0GWHOyhepZPxA=;
        b=M8+zf0bvs+4AwXVBLXZtQTo/epLu/MyOYi1iSX+lKcsKN+fGC2007lgo42n/9yUEcy
         lK1XJgafxBtE+pqbM636O5xjpM3mXIb0K4a616N2x86r/icYZjULZll55LHxY9MxHwls
         U9MEG2Q3PObTFJDmDvJin4MFGKgqhlYTcbCsReqkyM/EmXDuLP9uO+GrIgDptj8bBRhU
         9yAE3gX5ah7bdRj6022pTMkGHJ+kO++XHvJxOb+UvF9bwW+LuRpqIiixJAGQs+fV6bCS
         xA+1iixqquQVRz1r6E/ZE46tUQV6oHfwsjqFLeWstdQBmvG9lgfLgKtWxYfIDMx+cDTq
         MC7w==
X-Gm-Message-State: AOAM532NfQWCjXga1OBDvcwahqkNLOJxt5ypi3Mr05M1hXkK14+xyU7S
        f8+SsQ+mUrkS6dNS63lQmao7VEwXbNfD+cHgH8swewygEGpyrxPV0t0cQ9D/+2NOKbsAuedRtCE
        dqdCf1xMsdFVHla6oF2FP7M8S
X-Received: by 2002:a05:6402:89a:: with SMTP id e26mr2083041edy.196.1628849122229;
        Fri, 13 Aug 2021 03:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwszAYTjLBP3JqNxLsyrfzhTz9uDYz6rXThQ+D2/CjMKTz6XWrI5g9wFyOUAwlWxIZq/Z2Piw==
X-Received: by 2002:a05:6402:89a:: with SMTP id e26mr2083017edy.196.1628849121969;
        Fri, 13 Aug 2021 03:05:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q14sm650691edr.0.2021.08.13.03.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 03:05:21 -0700 (PDT)
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210813024201.9518-1-luke@ljones.dev>
 <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
 <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
 <R1ORXQ.WGLIPS8I54X63@ljones.dev>
 <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
 <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
 <AYURXQ.K273M0JTASMR@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7704cc48-ed27-3e94-2eed-d4c37b2a1fa5@redhat.com>
Date:   Fri, 13 Aug 2021 12:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AYURXQ.K273M0JTASMR@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/21 11:42 AM, Luke Jones wrote:
> I'll try to follow along here...
> 
> On Fri, Aug 13 2021 at 10:44:07 +0200, Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>>>  That means that the notify will also happen when the setting is
>>>  changed through handler->profile_set() this is not necessarily
>>>  a bad thing since there could be multiple user-space
>>>  processes accessing the profile and then others will be
>>>  notified when one of the processes makes a change.
>>>
>>>  But ATM the other drivers which use platform_profile_notify()
>>>  only do this when the profile is changed from outside of
>>>  userspace. Specifically by a hotkey handled directly by the
>>>  embedded-controller, this in kernel turbo-key handling is
>>>  very similar to that.
>>>
>>>  So if you add the platform_profile_notify() to
>>>  throttle_thermal_policy_write() then asus-wmi will behave
>>>  differently from the other existing implementations.
>>>
>>>  So I think we need to do a couple of things here:
>>>
>>>  1. Decided what notify behavior is the correct behavior.
>>>  Bastien, since power-profiles-daemon is the main consumer,
>>>  what behavior do you want / expect?  If we make the assumption
>>>  that there will only be 1 userspace process accessing the
>>>  profile settings (e.g. p-p-d) then the current behavior
>>>  of e.g. thinkpad_acpi to only do the notify (send POLLPRI)
>>>  when the profile is changed by a source outside userspace
>>>  seems to make sense. OTOH as I mentioned above if we
>>>  assume there might be multiple userspace processes touching
>>>  the profile (it could even be an echo from a shell) then
>>>  it makes more sense to do the notify on all changes so that
>>>  p-p-d's notion of the active profile is always correct.
>>>
>>>  Thinking more about this always doing the notify seems
>>>  like the right thing to do to me.
>>
>> Ok, so I was just thinking that this does not sound right to me,
>> since I did try echo-ing values to the profile while having the
>> GNOME control-panel open and I was pretty sure that it did
>> then actually update. So I just checked again and it does.
>>
>> The thinkpad_acpi driver does not call platform_profile_notify()
>> on a write. But it does when receiving an event from the EC
>> that the profile has changed, which I guess is also fired on
>> a write from userspace.
>>
>> But that notify pm an event is only done if the profile
>> read from the EC on the event is different then the last written
>> value. So this should not work, yet somehow it does work...
>>
>> I even added a printk to thinkpad_acpi.c and it is indeed
>> NOT calling platform_profile_notify() when I echo a new
>> value to /sys/firmware/acpi/platform_profile.
> 
> Okay I see. Yes I tested this before submission. The issue here for the ASUS laptops is that /sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy is still accessible and writeable. If this is written to then the platform_profile becomes out of sync with it. So the option here is:
> 
> 1. notify platform_profile, or
> 2. remove the sysfs for throttle_thermal_policy
> 
> Thinking about it I would prefer option 2 so we do not end up with two paths for duplicate functionality. As far as I know asusctl is the only (very) widely distributed and used tool for these laptops that uses the existing throttle_thermal_policy sysfs path, so it is very easy to sync asusctl with the changes made here.

2. is something which we may do in a year or so, we have a strict
no breaking userspace policy in the kernel; so people should be
able to drop in a new kernel without updating asusctl and things
should keep working. Which means that we are stuck with the
/sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy
file for at least a year.

So we need to 1, call platform_profily_notify on writes
to /sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy
and on changes because of the hotkey, while not calling it
from the profile_set callback.

>> Ah I just checked the p-p-d code and it is using GFileMonitor
>> rather then watching for POLLPRI  / G_IO_PRI. I guess that
>> GFileMonitor is using inotify or some such and that catches
>> writes by other userspace processes, as well as the POLLPRI
>> notifies it seems, interesting.
>>
>> Note that inotify does not really work on sysfs files, since
>> they are not real files and their contents is generated by the
>> kernel on the fly when read , so it can change at any time.
>> But I guess it does catch writes by other processes so it works
>> in this case.
>>
>> This does advocate for always doing the notify since normally
>> userspace processes who want to check for sysfs changes should
>> do so by doing a (e)poll checking for POLLPRI  / G_IO_PRI and
>> in that scenario p-p-d would currently not see changes done
>> through echo-ing a new value to /sys/firmware/acpi/platform_profile.
>>
>> So long story short, Luke I believe that your decision to call
>> platform_profile_notify() on every write is correct.
> 
> Just to be super clear:
> The notify is on write to /sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy as described above.
> Not to /sys/firmware/acpi/platform_profile

Ah I see, yes I agree platform_profile_notify() should be called
from the store handler for /sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy.

Basically it should be called for _all_ changes not done through
the profile_set callback.

Regards,

Hans

