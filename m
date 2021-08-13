Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3FE3EB2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhHMIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239249AbhHMIoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628844251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eJ/JzSNr7p/osvUMRmqvApwO0ywu1pRYsAMhxR8Ojs=;
        b=Lk+cHjfW78Jf6d8ufjPYwYGG9pxVh9D/ncJTsZnAqHTCLH6kxWxdMs9cC1XQBYHSYALVu6
        S6570tFkJUmHu6tY7//lqjV4OwqlRPqYjxYZ6VnqxkYPI4QXD+NR3JAdyA4w+puLWlj3yy
        Zn1aeR+lh4FlE5lnd1oHI7PKqQPtdW0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-IdXxcqgMN8ej98dLonAq7w-1; Fri, 13 Aug 2021 04:44:09 -0400
X-MC-Unique: IdXxcqgMN8ej98dLonAq7w-1
Received: by mail-ej1-f71.google.com with SMTP id ke4-20020a17090798e4b02905b869727055so2172126ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1eJ/JzSNr7p/osvUMRmqvApwO0ywu1pRYsAMhxR8Ojs=;
        b=XElN9qu2Ts/3nnVjD+qt8DqFx2oK2DM5YIovNnZQ+oXeAMy+WRxuFus0sb1523R9di
         x2JJ7rJ2p7gHFP6ZPVMCoz1Ejlt427YDVZ8V5liOc+wK6gKPQ7usFrC3LYfp5be5/nuk
         UA41fPA2jrGDVwRFe4LpAI1jg4tuxYQpMDp9DAYxRIUKZTTTTdyDBSdSaXlXY38CtBP+
         VEbhXdSzLNbe9CRHhLcS5W0yBxK+AIeqzn3tSxo4Dbbgwj8+s37y76410Pzpt3rr6lKK
         BasloevqHozq/6OvQZwUAbxdyrnS+FPSem5yYpit9/Uva8FOTPlZkkHiSaYWXAAiPOIV
         7OQQ==
X-Gm-Message-State: AOAM5300POBrCzuLOHg1XqQynSDY5dx/Mnih2YRKBvjyhtYFc+uvPN7l
        GmbVUgLF8ev5ftzTL/EpocsuR80sjTaFmTEWK51kUajaZkdxh+q/CiiJL8cpupW4pzN5q0X+gup
        4OfSymXbcI8ljBMa/1KXVOkpM
X-Received: by 2002:a05:6402:202d:: with SMTP id ay13mr1707383edb.249.1628844248527;
        Fri, 13 Aug 2021 01:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJkMxAy8grqWAT5WIYljadAzznsbISrVN9TnCW7yB9XYGftphHTCz5CtBv+pcxnqGROXbpEg==
X-Received: by 2002:a05:6402:202d:: with SMTP id ay13mr1707374edb.249.1628844248352;
        Fri, 13 Aug 2021 01:44:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o22sm549734edr.19.2021.08.13.01.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 01:44:08 -0700 (PDT)
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luke Jones <luke@ljones.dev>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210813024201.9518-1-luke@ljones.dev>
 <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
 <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
 <R1ORXQ.WGLIPS8I54X63@ljones.dev>
 <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
Message-ID: <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
Date:   Fri, 13 Aug 2021 10:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/21 9:40 AM, Hans de Goede wrote:
> Hi,
> 
> On 8/13/21 9:13 AM, Luke Jones wrote:
>>
>>
>> On Fri, Aug 13 2021 at 09:03:04 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 8/13/21 7:27 AM, Luke Jones wrote:
>>>>  I'm unsure of how to update the existing code for fn+f5 (next thermal profile) used by laptops like the TUF series that have keyboard over i2c. I was thinking of the following:
>>>>
>>>>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>>>>  {
>>>>  struct platform_profile_handler *handler = &asus->platform_profile_handler; // added
>>>>  u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>>
>>>>  if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>>   new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>>
>>>>  // asus->throttle_thermal_policy_mode = new_mode;
>>>>  // return throttle_thermal_policy_write(asus);
>>>>  return handler->profile_set(&asus->platform_profile_handler, new_mode); // added
>>>>  }
>>>>
>>>>  * two lines added, two commented
>>>
>>> I was going to say it is best to just send a key-press event to userspace
>>> (we can define a new EV_KEY_.... code for this) and then let userspace
>>> handle things. But I see that this is currently already handled by the kernel,
>>> so that is not really an option.
>>>
>>>>  I'm not able to test this though, and there are very few active people in my discord with TUF/i2c laptops to ask for testing also.
>>>>
>>>>  My concern here is to get the platform_profile correctly updated. Simply updating asus->throttle_thermal_policy_mode isn't going to achieve what we'll want.
>>>
>>> Right, there is no need to go through handler->profile_set() you have defined
>>> profile_set yourself after all and it does not do anything different then the
>>> old code you are replacing here.
>>>
>>> The trick is to call platform_profile_notify() after throttle_thermal_policy_write()
>>> this will let userspace, e.g. power-profiles-daemon know that the profile has
>>> been changed and it will re-read it then, resulting in a call to
>>> handler->profile_get()
>>>
>>> So the new throttle_thermal_policy_switch_next() would look like this:
>>>
>>> static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>>> {
>>>         u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>     int err; // new
>>>
>>>         if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>                 new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>
>>>         asus->throttle_thermal_policy_mode = new_mode;
>>>
>>>         err = throttle_thermal_policy_write(asus); // changed
>>>     if (err == 0)                              // new
>>>         platform_profile_notify();         // new
>>>
>>>     return err;                                // new
>>> }
>>>
>>> As you can see the only new thing here is the
>>> platform_profile_notify() call on a successful write,
>>> which is such a small change that I'm not overly worried about
>>> not being able to test this.
>>>
>>> I hope this helps.
>>>
>>> Regards,
>>>
>>> Hans
> 
> <snip>
> 
>> Hi Hans,
>>
>> Very helpful, thanks. I'd completely failed to notice platform_profile_notify in the platform_profile.h :| I've now put that in throttle_thermal_policy_write() just after sysfs_notify().
> 
> That means that the notify will also happen when the setting is
> changed through handler->profile_set() this is not necessarily
> a bad thing since there could be multiple user-space
> processes accessing the profile and then others will be
> notified when one of the processes makes a change.
> 
> But ATM the other drivers which use platform_profile_notify()
> only do this when the profile is changed from outside of
> userspace. Specifically by a hotkey handled directly by the
> embedded-controller, this in kernel turbo-key handling is
> very similar to that.
> 
> So if you add the platform_profile_notify() to 
> throttle_thermal_policy_write() then asus-wmi will behave
> differently from the other existing implementations.
> 
> So I think we need to do a couple of things here:
> 
> 1. Decided what notify behavior is the correct behavior.
> Bastien, since power-profiles-daemon is the main consumer,
> what behavior do you want / expect?  If we make the assumption
> that there will only be 1 userspace process accessing the
> profile settings (e.g. p-p-d) then the current behavior
> of e.g. thinkpad_acpi to only do the notify (send POLLPRI)
> when the profile is changed by a source outside userspace
> seems to make sense. OTOH as I mentioned above if we
> assume there might be multiple userspace processes touching
> the profile (it could even be an echo from a shell) then
> it makes more sense to do the notify on all changes so that
> p-p-d's notion of the active profile is always correct.
> 
> Thinking more about this always doing the notify seems
> like the right thing to do to me.

Ok, so I was just thinking that this does not sound right to me,
since I did try echo-ing values to the profile while having the
GNOME control-panel open and I was pretty sure that it did
then actually update. So I just checked again and it does.

The thinkpad_acpi driver does not call platform_profile_notify()
on a write. But it does when receiving an event from the EC
that the profile has changed, which I guess is also fired on
a write from userspace.

But that notify pm an event is only done if the profile
read from the EC on the event is different then the last written
value. So this should not work, yet somehow it does work...

I even added a printk to thinkpad_acpi.c and it is indeed
NOT calling platform_profile_notify() when I echo a new
value to /sys/firmware/acpi/platform_profile.

Ah I just checked the p-p-d code and it is using GFileMonitor
rather then watching for POLLPRI  / G_IO_PRI. I guess that
GFileMonitor is using inotify or some such and that catches
writes by other userspace processes, as well as the POLLPRI
notifies it seems, interesting.

Note that inotify does not really work on sysfs files, since
they are not real files and their contents is generated by the
kernel on the fly when read , so it can change at any time.
But I guess it does catch writes by other processes so it works
in this case.

This does advocate for always doing the notify since normally
userspace processes who want to check for sysfs changes should
do so by doing a (e)poll checking for POLLPRI  / G_IO_PRI and
in that scenario p-p-d would currently not see changes done
through echo-ing a new value to /sys/firmware/acpi/platform_profile.

So long story short, Luke I believe that your decision to call
platform_profile_notify() on every write is correct.

###

This does mean that we still need to do:

2. Once we have an answer to 1. we need to documented the
expected behavior in Documentation/ABI/testing/sysfs-platform_profile

Does anyone feel up to writing a patch for this ?

3. If we go for doing a notify on any change, then we need
to update the existing drivers to do this.

I guess I should add this to my to-do list.

Regards,

Hans

