Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC243ECBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhHOXAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 19:00:52 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57785 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhHOXAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 19:00:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 3101432008FE;
        Sun, 15 Aug 2021 19:00:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 15 Aug 2021 19:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8iTDKu
        Ff6sIK5qkD+04LYSEIHov0bH0Yf7Smj73cGDo=; b=urQujKKqso9YornYGdsq6C
        hMcJS95tNpEOqYksQuKfLkauJNN0k4432D+hApYbs8asGc8OV9hAK+VdiLUdH0tF
        dmu0lFoEwSn46YZjifE1qRvsAvZw/EO3LlDlWpp9/0PdW+6aKsldR+1i3gh5uxxH
        shs6F6TBvLsUqQDI06CzqjF9RE/S0NLnFyCh5xcmO1TjAAMVB3Mk92fDA2B+cS52
        nnZVXNFSbIWIcyn8uR12OqiqAl+DHq+3bh7OzKcA5P1d3cR8cLKzK8qn8XU7yjSI
        NEZpzuZeDR7oITh3o61CgxBVbYXVt9hJun+buPvoy3xir0q0ziviZ/tDgY3GWj0A
        ==
X-ME-Sender: <xms:g5wZYdKZN8AJCclERsW4_6JTg7vITB5VvmENytFdNsudWNC4P6cgcg>
    <xme:g5wZYZJGbf0kim1j4COjwACv4GZaN0mJuNUybWWAO5nY0YyawSdSHZzPqG5z5iG4l
    VzONj4Qp1Kkks2B9l8>
X-ME-Received: <xmr:g5wZYVuQ5raiC1w4-fe0Q1pbs7mgXRIoHfdju-f6GehLaiP7KXCGiiiRQ07ZnLtUkdAL7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledtgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:g5wZYeakpEiLJpVzpe8t5yXJj627QSJvL7QiCgaY2kZqvX8fHAUWoA>
    <xmx:g5wZYUaejI6VhoLYNkrP9E-DQUDnhSlrrJoM-wdh0lwiNUrAfAztTg>
    <xmx:g5wZYSDkgCXv5KvGdYzU_ESSW-TeMa76lrRx_iztegpZGv_EhxNwPA>
    <xmx:g5wZYfwmOWoxWnC2bwsgsQbnAoRhVYJJPUWAcsPhkX4OjRELlOp9HQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Aug 2021 19:00:15 -0400 (EDT)
Date:   Mon, 16 Aug 2021 11:00:01 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 0/1] asus-wmi: add platform_profile support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <18LWXQ.AIB2DGCZUVMW@ljones.dev>
In-Reply-To: <a918bfe0-03c4-e7d3-8a99-efb1d11333e4@redhat.com>
References: <20210814043103.2535842-1-luke@ljones.dev>
        <THKTXQ.ELSNF0TA7RAV1@ljones.dev>
        <a918bfe0-03c4-e7d3-8a99-efb1d11333e4@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Aug 15 2021 at 15:48:49 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/14/21 9:51 AM, Luke Jones wrote:
>> 
>> 
>>  On Sat, Aug 14 2021 at 16:31:02 +1200, Luke D. Jones 
>> <luke@ljones.dev> wrote:
>>>  Changelog:
>>>  - V2
>>>    + Correctly unregister from platform_profile if
>>>      throttle_thermal_policy fails
>>>    + Do platform_profile_notify() in both 
>>> throttle_thermal_policy_store()
>>>      and in throttle_thermal_policy_switch_next()
>>>    + Remove unnecessary prep for possible fan-boost modes as this
>>>      doesn't match expected platform_profile behaviour
>>>  - V3
>>>    + Add missing declaration for err in
>>>      throttle_thermal_policy_switch_next
>>> 
>>>  Luke D. Jones (1):
>>>    asus-wmi: Add support for platform_profile
>>> 
>>>   drivers/platform/x86/asus-wmi.c | 139 
>>> +++++++++++++++++++++++++++++++-
>>>   1 file changed, 135 insertions(+), 4 deletions(-)
>>> 
>>>  --
>>>  2.31.1
>> 
>>  Hi,
>> 
>>  I teested the patch again and it appears that the 
>> platform_profile_notify() in both throttle_thermal_policy_store() 
>> and throttle_thermal_policy_switch_next() updates the 
>> /sys/firmware/acpi/platform_profile sysfs path fine, but userspace 
>> isn't updated?
>> 
>>  The way I'm checking is:
>>  1. echo 1 |sudo tee 
>> /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
>>  2. cat -p /sys/firmware/acpi/platform_profile
>>    - performance (updated correctly by platform_profile_notify)
>>  3. Check gnome-settings, not updated.
>> 
>>  Doing `echo "performance" |sudo tee 
>> /sys/firmware/acpi/platform_profile` updates both 
>> throttle_thermal_policy and userspace as expected. I'm wondering if 
>> I've missed something?
> 
> If you add a printk where you call platform_profile_notify() and you 
> see that
> happening, then you are likely seeing a userspace bug. Possibly your
> power-profile-daemon is simply a bit old and therefor does not support
> the combination of profiles which asus-wmi offers, IIRC it falls back 
> to
> using intel-pstate in that case.

It's possible that it's a userspace bug then. The power-profile-daemon 
I'm using is fresh from git (0.9+). To be clear updating via 
/sys/firmware/acpi/platform_profile works perfectly fine and 
power-profile-daemon updates etc. But if I do platform_profile_notify() 
then it doesn't seem to be updated. Nevertheless I will finalise the 
patch as it is and submit for merging and we can go from there.

> 
> You could try building the latest power-profile-daemon from git and 
> run
> it in verbose mode. If it sees the changes and the control-panel 
> applet is
> still not updating then I would not worry about that. The userspace 
> code
> is still somewhat new and I'm not sure which version your distro is
> running and how well it is keeping up with gnome-updates.
> 
> Regards,
> 
> Hans
> 


