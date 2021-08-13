Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412833EB29A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhHMI1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:27:51 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59159 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhHMI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:27:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 9533E3200684;
        Fri, 13 Aug 2021 04:27:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 Aug 2021 04:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8M6QiS
        qUqkkhsG2fye10j0VPBHnr6Q9W3LxpNNepWUE=; b=tuCJsOY6u4IrAIsIE1BD9M
        CztzCCGXT9wjIx0shE8DznOHg7ed+Oab6QGTZNZO9V6lz8MrSeLLHujMF5f0enzE
        GOP8XYgu3ba/xyBnAgo2ZrldNKGKZv98nNNlIQXDKrUXRrE7Ob25luBIaiL8zjPM
        +zdXZ/KZ8Hn7E8Cc3Gi/g0+Za0puF3iBm1f+M8YcKfOB/3TEhs62f8dcb9emqZ2n
        buD/6SJlBw8thL7SzJ3m/x7TF3GZJfcR3pqwlMhxnA+9rxvCsHcQWYohQO3Et6F1
        UyXRXHT6G9Utm3xrpwuQEUJ1Bw+IUtUOQ0W0mbxHNSBtUcV+JjOIN3hgOl7g///Q
        ==
X-ME-Sender: <xms:6SwWYZ2bH-3RmRLn7q7Z_ui3s8j992RIkmx--I-r4KvL_Nj77RvNXg>
    <xme:6SwWYQFs9j696QPUox2li7DlrWD7Iq2DxZhtNh8VVWgRjKWh_mZbb_PukOfpAzz9l
    0oxPwIqN6OBZLLIsTs>
X-ME-Received: <xmr:6SwWYZ46QZpBJ8C_wXkKPHaG6H9Ju_8WCegY9oCMO7U3wPtJApJi5znzR-z4u7IRpA-M6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:6SwWYW1V-5pdpjke_VK_TXG1-wADMkG67-wdg7lgERQ6iFWbvv6kTg>
    <xmx:6SwWYcERg05Jj8fFG8gqYtPShMZ4mX480gQ5VmoHbgOOt4pZIGO3RQ>
    <xmx:6SwWYX-RlGzFdaAdQ5-PV9Cl3OZbm-WqCOfyFL12q7gU-bgKIAgErw>
    <xmx:6iwWYWPBjDtyCKaWikzFckNpq6XbXI7hoJmCopRvOg6fYP6tzOoucg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Aug 2021 04:27:18 -0400 (EDT)
Date:   Fri, 13 Aug 2021 20:27:04 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Message-Id: <4HRRXQ.EDZWS3NOU3J32@ljones.dev>
In-Reply-To: <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
References: <20210813024201.9518-1-luke@ljones.dev>
        <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
        <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
        <R1ORXQ.WGLIPS8I54X63@ljones.dev>
        <5b503320-c1a3-2653-b269-ba8d40568edf@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 13 2021 at 09:40:25 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/13/21 9:13 AM, Luke Jones wrote:
>> 
>> 
>>  On Fri, Aug 13 2021 at 09:03:04 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi,
>>> 
>>>  On 8/13/21 7:27 AM, Luke Jones wrote:
>>>>   I'm unsure of how to update the existing code for fn+f5 (next 
>>>> thermal profile) used by laptops like the TUF series that have 
>>>> keyboard over i2c. I was thinking of the following:
>>>> 
>>>>   static int throttle_thermal_policy_switch_next(struct asus_wmi 
>>>> *asus)
>>>>   {
>>>>   struct platform_profile_handler *handler = 
>>>> &asus->platform_profile_handler; // added
>>>>   u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>> 
>>>>   if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>>    new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>> 
>>>>   // asus->throttle_thermal_policy_mode = new_mode;
>>>>   // return throttle_thermal_policy_write(asus);
>>>>   return handler->profile_set(&asus->platform_profile_handler, 
>>>> new_mode); // added
>>>>   }
>>>> 
>>>>   * two lines added, two commented
>>> 
>>>  I was going to say it is best to just send a key-press event to 
>>> userspace
>>>  (we can define a new EV_KEY_.... code for this) and then let 
>>> userspace
>>>  handle things. But I see that this is currently already handled by 
>>> the kernel,
>>>  so that is not really an option.
>>> 
>>>>   I'm not able to test this though, and there are very few active 
>>>> people in my discord with TUF/i2c laptops to ask for testing also.
>>>> 
>>>>   My concern here is to get the platform_profile correctly 
>>>> updated. Simply updating asus->throttle_thermal_policy_mode isn't 
>>>> going to achieve what we'll want.
>>> 
>>>  Right, there is no need to go through handler->profile_set() you 
>>> have defined
>>>  profile_set yourself after all and it does not do anything 
>>> different then the
>>>  old code you are replacing here.
>>> 
>>>  The trick is to call platform_profile_notify() after 
>>> throttle_thermal_policy_write()
>>>  this will let userspace, e.g. power-profiles-daemon know that the 
>>> profile has
>>>  been changed and it will re-read it then, resulting in a call to
>>>  handler->profile_get()
>>> 
>>>  So the new throttle_thermal_policy_switch_next() would look like 
>>> this:
>>> 
>>>  static int throttle_thermal_policy_switch_next(struct asus_wmi 
>>> *asus)
>>>  {
>>>          u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>>>      int err; // new
>>> 
>>>          if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>>                  new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>> 
>>>          asus->throttle_thermal_policy_mode = new_mode;
>>> 
>>>          err = throttle_thermal_policy_write(asus); // changed
>>>      if (err == 0)                              // new
>>>          platform_profile_notify();         // new
>>> 
>>>      return err;                                // new
>>>  }
>>> 
>>>  As you can see the only new thing here is the
>>>  platform_profile_notify() call on a successful write,
>>>  which is such a small change that I'm not overly worried about
>>>  not being able to test this.
>>> 
>>>  I hope this helps.
>>> 
>>>  Regards,
>>> 
>>>  Hans
> 
> <snip>
> 
>>  Hi Hans,
>> 
>>  Very helpful, thanks. I'd completely failed to notice 
>> platform_profile_notify in the platform_profile.h :| I've now put 
>> that in throttle_thermal_policy_write() just after sysfs_notify().
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
> 
> 2. Once we have an answer to 1. we need to documented the
> expected behavior in Documentation/ABI/testing/sysfs-platform_profile
> 
> 3. If we go for doing a notify on any change, then we need
> to update the existing drivers to do this.
> 
> Regards,
> 
> Hans

My thinking for it was ensuring that a process that wrote to 
/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy would force 
an update across all. I think perhaps I should move the notify to 
throttle_thermal_policy_store() instead which only activates when the 
path is written.

Cheers,
Luke.


