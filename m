Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA963EB1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhHMHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239573AbhHMHk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628840429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXEfPRzNWd5RXj0Z8Y3rqxIsKUmpWVUoNiXS+NF/iPs=;
        b=Vuo8XYo7yRpF6jq7AnBAQ2s8PJgeiXma8AFa9FaZB1pxCSVhSX2XteAJYDPpaSKdveRPnl
        AASnmOiIxGZIi/UZ81hGDxPPr3DSpAnDJ2+ovevjjYt+kTZxbthPiN5a4uZ4rrzZPKiSYH
        HGtvNPTB9488n73qoC4tINN7dsE0yqw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-EV5sOM5SNmuQLBuPBX7Ejg-1; Fri, 13 Aug 2021 03:40:28 -0400
X-MC-Unique: EV5sOM5SNmuQLBuPBX7Ejg-1
Received: by mail-ej1-f71.google.com with SMTP id e1-20020a170906c001b02905b53c2f6542so2658516ejz.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wXEfPRzNWd5RXj0Z8Y3rqxIsKUmpWVUoNiXS+NF/iPs=;
        b=A8rtRPxnxgGocictXiMkDErfD/CynyeKrpCyH4udNjXFcM5dkAYgkfsCPYpESMjPRl
         wXdNj4gjoFsuYMDA9q41ziL5uAXuHDJR+buBWAo33i0nqp4upEa74KHX2EoH8hE7+Otg
         CkJzvUCU9K56omjGcEdlCnpbSyzJgb+QxyoBQZPC9Nyma15TEiwyuJmkV795ySgbNhhu
         hR2PghO/O973jxwxYKdx1dG2vOK46vBXJp/sM/6+uYqqKSr7yBEBOBGIuwjoOZyzl+oR
         7TPWB8MA2+3umCYeFq/ajMKZ4l6/gitPwwh8MjITfQ+MG+ZTbYvBLEHDMAmCqZrj6gBN
         +JOg==
X-Gm-Message-State: AOAM531OH1DRhohWkUNI1a+1vk5C500s7GLZBmRfmpL3zIUhuFnsDEmj
        JoxQWHcSYS5RUerHrVLrAe0pG4TlDl88P8WEhHRBKBNUwHyjY8cwUJZmmoy/AfP8xYELbTHRmPM
        DpniwWj4nP9Oyc+zUcvjURwo3
X-Received: by 2002:aa7:db47:: with SMTP id n7mr1419375edt.15.1628840427258;
        Fri, 13 Aug 2021 00:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy86kWxaBeskfaokouXmjV1/C/nnkBiktQGEm/xnDqmgPiNff4L2dqRf90ebHsEOF3jWQKLYA==
X-Received: by 2002:aa7:db47:: with SMTP id n7mr1419359edt.15.1628840427046;
        Fri, 13 Aug 2021 00:40:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ko11sm265848ejc.54.2021.08.13.00.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:40:26 -0700 (PDT)
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210813024201.9518-1-luke@ljones.dev>
 <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
 <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
 <R1ORXQ.WGLIPS8I54X63@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
Date:   Fri, 13 Aug 2021 09:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <R1ORXQ.WGLIPS8I54X63@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/21 9:13 AM, Luke Jones wrote:
> 
> 
> On Fri, Aug 13 2021 at 09:03:04 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 8/13/21 7:27 AM, Luke Jones wrote:
>>>  I'm unsure of how to update the existing code for fn+f5 (next thermal profile) used by laptops like the TUF series that have keyboard over i2c. I was thinking of the following:
>>>
>>>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>>>  {
>>>  struct platform_profile_handler *handler = &asus->platform_profile_handler; // added
>>>  u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>
>>>  if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>   new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>
>>>  // asus->throttle_thermal_policy_mode = new_mode;
>>>  // return throttle_thermal_policy_write(asus);
>>>  return handler->profile_set(&asus->platform_profile_handler, new_mode); // added
>>>  }
>>>
>>>  * two lines added, two commented
>>
>> I was going to say it is best to just send a key-press event to userspace
>> (we can define a new EV_KEY_.... code for this) and then let userspace
>> handle things. But I see that this is currently already handled by the kernel,
>> so that is not really an option.
>>
>>>  I'm not able to test this though, and there are very few active people in my discord with TUF/i2c laptops to ask for testing also.
>>>
>>>  My concern here is to get the platform_profile correctly updated. Simply updating asus->throttle_thermal_policy_mode isn't going to achieve what we'll want.
>>
>> Right, there is no need to go through handler->profile_set() you have defined
>> profile_set yourself after all and it does not do anything different then the
>> old code you are replacing here.
>>
>> The trick is to call platform_profile_notify() after throttle_thermal_policy_write()
>> this will let userspace, e.g. power-profiles-daemon know that the profile has
>> been changed and it will re-read it then, resulting in a call to
>> handler->profile_get()
>>
>> So the new throttle_thermal_policy_switch_next() would look like this:
>>
>> static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>> {
>>         u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>     int err; // new
>>
>>         if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>                 new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>
>>         asus->throttle_thermal_policy_mode = new_mode;
>>
>>         err = throttle_thermal_policy_write(asus); // changed
>>     if (err == 0)                              // new
>>         platform_profile_notify();         // new
>>
>>     return err;                                // new
>> }
>>
>> As you can see the only new thing here is the
>> platform_profile_notify() call on a successful write,
>> which is such a small change that I'm not overly worried about
>> not being able to test this.
>>
>> I hope this helps.
>>
>> Regards,
>>
>> Hans

<snip>

> Hi Hans,
> 
> Very helpful, thanks. I'd completely failed to notice platform_profile_notify in the platform_profile.h :| I've now put that in throttle_thermal_policy_write() just after sysfs_notify().

That means that the notify will also happen when the setting is
changed through handler->profile_set() this is not necessarily
a bad thing since there could be multiple user-space
processes accessing the profile and then others will be
notified when one of the processes makes a change.

But ATM the other drivers which use platform_profile_notify()
only do this when the profile is changed from outside of
userspace. Specifically by a hotkey handled directly by the
embedded-controller, this in kernel turbo-key handling is
very similar to that.

So if you add the platform_profile_notify() to 
throttle_thermal_policy_write() then asus-wmi will behave
differently from the other existing implementations.

So I think we need to do a couple of things here:

1. Decided what notify behavior is the correct behavior.
Bastien, since power-profiles-daemon is the main consumer,
what behavior do you want / expect?  If we make the assumption
that there will only be 1 userspace process accessing the
profile settings (e.g. p-p-d) then the current behavior
of e.g. thinkpad_acpi to only do the notify (send POLLPRI)
when the profile is changed by a source outside userspace
seems to make sense. OTOH as I mentioned above if we
assume there might be multiple userspace processes touching
the profile (it could even be an echo from a shell) then
it makes more sense to do the notify on all changes so that
p-p-d's notion of the active profile is always correct.

Thinking more about this always doing the notify seems
like the right thing to do to me.

2. Once we have an answer to 1. we need to documented the
expected behavior in Documentation/ABI/testing/sysfs-platform_profile

3. If we go for doing a notify on any change, then we need
to update the existing drivers to do this.

Regards,

Hans


