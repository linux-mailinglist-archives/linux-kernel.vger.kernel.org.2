Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE73EB376
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhHMJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:42:55 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49143 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239028AbhHMJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:42:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 04D3A32005C1;
        Fri, 13 Aug 2021 05:42:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Aug 2021 05:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cAjEzb
        O7JafBmPbWI9PA8koqwqs0SnfAhTqtH/Mfu6c=; b=tuS35xch7WrtrfuR4WM6nR
        ungU5N58MmwO6Wp2Tg1IKYs/5S4oVzbJP+EZ+aTiQyzY3DXVKfNKe3LulKynuwxP
        EjkxwGIiZZVc7Q6QKMa99aphxSopq4m/HB/33baHV62Zrs2JIeCf2HrxsWKgb4La
        y4Xk+fnFXRh/t5jRHg8A7BI7x6qrlEfB7JEEFxQyVavGfV+URJoxoEYZg5diIVrZ
        qAYbLjxMFU4VrIJvKweeV7/xvawVO1VyZ51qtEpBGVFKBNOZFLjNcVpSY/rOVNXw
        k9wcHJKAk0xZoYaqDArZjhcAc62dqSI11ObYRbGzhDdNleOtLL88fg5Fynok4uOA
        ==
X-ME-Sender: <xms:gz4WYdmgO7YYbwm1uKDDRV9iZj41XEUiajshvQYXdPveauWuQqCxwA>
    <xme:gz4WYY2O6Ocoj-roewMhmBLnoKMWbd-jnuTS2ybCv1DSA9joKoz9uq7pw7YJBP3EP
    nKx2JO-YziQiMm7Uyg>
X-ME-Received: <xmr:gz4WYTq4c1VDztRJhjWvhkuvq1P4rHNz6KNca1qGb8x6neMETzsFocWMDcMK0BlHaj1SYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:gz4WYdn4JMAnEphI5askIzGzHlZrOLt_sK1gP5LHBnInfSD-xZ8ERw>
    <xmx:gz4WYb2uoNnhl7Gb1NRsvx-XrlKl3nVOy8ZAlM5vgrL-3FnewqkwKw>
    <xmx:gz4WYcvQioMNzsOYyek7JmFCSh8eDtppWaXQAerdZErZi5uclMg2Vg>
    <xmx:gz4WYU_mBpViJ-9xp4dasmKWjXjTRLFFZ2_DaaPBGO__EA_1l8V7hg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Aug 2021 05:42:23 -0400 (EDT)
Date:   Fri, 13 Aug 2021 21:42:10 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Message-Id: <AYURXQ.K273M0JTASMR@ljones.dev>
In-Reply-To: <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
References: <20210813024201.9518-1-luke@ljones.dev>
        <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
        <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
        <R1ORXQ.WGLIPS8I54X63@ljones.dev>
        <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
        <a4acaf03-b6b3-49f3-14e8-6766e9e24215@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try to follow along here...

On Fri, Aug 13 2021 at 10:44:07 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/13/21 9:40 AM, Hans de Goede wrote:
>>  Hi,
>> 
>>  On 8/13/21 9:13 AM, Luke Jones wrote:
>>> 
>>> 
>>>  On Fri, Aug 13 2021 at 09:03:04 +0200, Hans de Goede 
>>> <hdegoede@redhat.com> wrote:
>>>>  Hi,
>>>> 
>>>>  On 8/13/21 7:27 AM, Luke Jones wrote:
>>>>>   I'm unsure of how to update the existing code for fn+f5 (next 
>>>>> thermal profile) used by laptops like the TUF series that have 
>>>>> keyboard over i2c. I was thinking of the following:
>>>>> 
>>>>>   static int throttle_thermal_policy_switch_next(struct asus_wmi 
>>>>> *asus)
>>>>>   {
>>>>>   struct platform_profile_handler *handler = 
>>>>> &asus->platform_profile_handler; // added
>>>>>   u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>>> 
>>>>>   if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>>>    new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>>> 
>>>>>   // asus->throttle_thermal_policy_mode = new_mode;
>>>>>   // return throttle_thermal_policy_write(asus);
>>>>>   return handler->profile_set(&asus->platform_profile_handler, 
>>>>> new_mode); // added
>>>>>   }
>>>>> 
>>>>>   * two lines added, two commented
>>>> 
>>>>  I was going to say it is best to just send a key-press event to 
>>>> userspace
>>>>  (we can define a new EV_KEY_.... code for this) and then let 
>>>> userspace
>>>>  handle things. But I see that this is currently already handled 
>>>> by the kernel,
>>>>  so that is not really an option.
>>>> 
>>>>>   I'm not able to test this though, and there are very few active 
>>>>> people in my discord with TUF/i2c laptops to ask for testing also.
>>>>> 
>>>>>   My concern here is to get the platform_profile correctly 
>>>>> updated. Simply updating asus->throttle_thermal_policy_mode isn't 
>>>>> going to achieve what we'll want.
>>>> 
>>>>  Right, there is no need to go through handler->profile_set() you 
>>>> have defined
>>>>  profile_set yourself after all and it does not do anything 
>>>> different then the
>>>>  old code you are replacing here.
>>>> 
>>>>  The trick is to call platform_profile_notify() after 
>>>> throttle_thermal_policy_write()
>>>>  this will let userspace, e.g. power-profiles-daemon know that the 
>>>> profile has
>>>>  been changed and it will re-read it then, resulting in a call to
>>>>  handler->profile_get()
>>>> 
>>>>  So the new throttle_thermal_policy_switch_next() would look like 
>>>> this:
>>>> 
>>>>  static int throttle_thermal_policy_switch_next(struct asus_wmi 
>>>> *asus)
>>>>  {
>>>>          u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>>      int err; // new
>>>> 
>>>>          if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>>                  new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>> 
>>>>          asus->throttle_thermal_policy_mode = new_mode;
>>>> 
>>>>          err = throttle_thermal_policy_write(asus); // changed
>>>>      if (err == 0)                              // new
>>>>          platform_profile_notify();         // new
>>>> 
>>>>      return err;                                // new
>>>>  }
>>>> 
>>>>  As you can see the only new thing here is the
>>>>  platform_profile_notify() call on a successful write,
>>>>  which is such a small change that I'm not overly worried about
>>>>  not being able to test this.
>>>> 
>>>>  I hope this helps.
>>>> 
>>>>  Regards,
>>>> 
>>>>  Hans
>> 
>>  <snip>
>> 
>>>  Hi Hans,
>>> 
>>>  Very helpful, thanks. I'd completely failed to notice 
>>> platform_profile_notify in the platform_profile.h :| I've now put 
>>> that in throttle_thermal_policy_write() just after sysfs_notify().
>> 
>>  That means that the notify will also happen when the setting is
>>  changed through handler->profile_set() this is not necessarily
>>  a bad thing since there could be multiple user-space
>>  processes accessing the profile and then others will be
>>  notified when one of the processes makes a change.
>> 
>>  But ATM the other drivers which use platform_profile_notify()
>>  only do this when the profile is changed from outside of
>>  userspace. Specifically by a hotkey handled directly by the
>>  embedded-controller, this in kernel turbo-key handling is
>>  very similar to that.
>> 
>>  So if you add the platform_profile_notify() to
>>  throttle_thermal_policy_write() then asus-wmi will behave
>>  differently from the other existing implementations.
>> 
>>  So I think we need to do a couple of things here:
>> 
>>  1. Decided what notify behavior is the correct behavior.
>>  Bastien, since power-profiles-daemon is the main consumer,
>>  what behavior do you want / expect?  If we make the assumption
>>  that there will only be 1 userspace process accessing the
>>  profile settings (e.g. p-p-d) then the current behavior
>>  of e.g. thinkpad_acpi to only do the notify (send POLLPRI)
>>  when the profile is changed by a source outside userspace
>>  seems to make sense. OTOH as I mentioned above if we
>>  assume there might be multiple userspace processes touching
>>  the profile (it could even be an echo from a shell) then
>>  it makes more sense to do the notify on all changes so that
>>  p-p-d's notion of the active profile is always correct.
>> 
>>  Thinking more about this always doing the notify seems
>>  like the right thing to do to me.
> 
> Ok, so I was just thinking that this does not sound right to me,
> since I did try echo-ing values to the profile while having the
> GNOME control-panel open and I was pretty sure that it did
> then actually update. So I just checked again and it does.
> 
> The thinkpad_acpi driver does not call platform_profile_notify()
> on a write. But it does when receiving an event from the EC
> that the profile has changed, which I guess is also fired on
> a write from userspace.
> 
> But that notify pm an event is only done if the profile
> read from the EC on the event is different then the last written
> value. So this should not work, yet somehow it does work...
> 
> I even added a printk to thinkpad_acpi.c and it is indeed
> NOT calling platform_profile_notify() when I echo a new
> value to /sys/firmware/acpi/platform_profile.

Okay I see. Yes I tested this before submission. The issue here for the 
ASUS laptops is that 
/sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy is still 
accessible and writeable. If this is written to then the 
platform_profile becomes out of sync with it. So the option here is:

1. notify platform_profile, or
2. remove the sysfs for throttle_thermal_policy

Thinking about it I would prefer option 2 so we do not end up with two 
paths for duplicate functionality. As far as I know asusctl is the only 
(very) widely distributed and used tool for these laptops that uses the 
existing throttle_thermal_policy sysfs path, so it is very easy to sync 
asusctl with the changes made here.

> 
> Ah I just checked the p-p-d code and it is using GFileMonitor
> rather then watching for POLLPRI  / G_IO_PRI. I guess that
> GFileMonitor is using inotify or some such and that catches
> writes by other userspace processes, as well as the POLLPRI
> notifies it seems, interesting.
> 
> Note that inotify does not really work on sysfs files, since
> they are not real files and their contents is generated by the
> kernel on the fly when read , so it can change at any time.
> But I guess it does catch writes by other processes so it works
> in this case.
> 
> This does advocate for always doing the notify since normally
> userspace processes who want to check for sysfs changes should
> do so by doing a (e)poll checking for POLLPRI  / G_IO_PRI and
> in that scenario p-p-d would currently not see changes done
> through echo-ing a new value to /sys/firmware/acpi/platform_profile.
> 
> So long story short, Luke I believe that your decision to call
> platform_profile_notify() on every write is correct.

Just to be super clear:
The notify is on write to 
/sys/bus/platform/devices/asus-nb-wmi/throttle_thermal_policy as 
described above.
Not to /sys/firmware/acpi/platform_profile

Cheers,
Luke.

> 
> ###
> 
> This does mean that we still need to do:
> 
> 2. Once we have an answer to 1. we need to documented the
> expected behavior in Documentation/ABI/testing/sysfs-platform_profile
> 
> Does anyone feel up to writing a patch for this ?
> 
> 3. If we go for doing a notify on any change, then we need
> to update the existing drivers to do this.
> 
> I guess I should add this to my to-do list.
> 
> Regards,
> 
> Hans
> 


