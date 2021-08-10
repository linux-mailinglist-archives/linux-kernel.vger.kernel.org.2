Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16B63E8583
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhHJVhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:37:21 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57343 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234707AbhHJVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:37:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A68C5C0059;
        Tue, 10 Aug 2021 17:36:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 10 Aug 2021 17:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ddL+0p
        F27T6DBP6hHVxKcsd9AwtrqhNxecAILnXGEBg=; b=R5Gkz6+ipHDEX1S562ROvx
        od3n1E56TcfFbYnkyKnwM5Onze6VmGEUbde93xgkUxI7WSpAN69NvVvhjSl08UrQ
        BSlvg7gpzQ6PwAybKVC2baSdGEEbXZcu5EHPIClAX/4vDPupuJqTqAxT4f+M7UUv
        3FeTQb8jwqsTOb1JckPxeq/Oi0+uUdZyk9C8SFRn/+fGsZAMESDfZpqFyyfXwbX8
        8DiE4PVYqi8T/WwKi1Y7dNzyO3pUYWHp4sdf98cCeXDlwOUI6bjx3BP/ISi5Ldny
        5BTlYaiiAQPh5Z99Sq7daSP8g4/PXOdKV3LAFt5vuMXSEYFsNLxk+gOVNUoqRdvQ
        ==
X-ME-Sender: <xms:ePESYRCd6bS6Q-yQox-dJrv1kwpqi4sy8f8d2n26rhRQKXe8Pusmkw>
    <xme:ePESYfhbSt0tez612tQXZFLcgTP56Kn1ItP2HFDEY4gItNj5JVC4iNRJV6oCQVnGG
    4tF_4Jmlh27mxaoF1k>
X-ME-Received: <xmr:ePESYclQStfHgZ4aA4S1hGl33l72J36u34f8zidwbN9hP8vYFpgk8lUqM1tPPn0PIPJjuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdduieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ePESYbxnaHsx4YOMFBOUmOFD6HiHxaR5ww0XP0GVrJUJNPC5aSglcA>
    <xmx:ePESYWTXOj5duO9ncwqTSbHLZ3-JklN27gY3-jAZXEVhOKdizYOODA>
    <xmx:ePESYeYpqCUH3mnHGssbUZ1WeS5TuIYrDC4jgdyeDXWcwYFaM-f7bg>
    <xmx:efESYRftm4vOOMcRyMkd96ZnF35MNlEvO3zobPho58eI-J0ZqDInnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 17:36:51 -0400 (EDT)
Date:   Wed, 11 Aug 2021 09:36:37 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel
 overdrive
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mgross@linux.intel.com,
        pobrn@protonmail.com, corentin.chary@gmail.com
Message-Id: <118NXQ.7MQ0UL73DWEP1@ljones.dev>
In-Reply-To: <96aa39fd-119a-f79e-ee74-2db6d117fac3@redhat.com>
References: <20210807023656.25020-1-luke@ljones.dev>
        <aec7b518-0979-7b7e-f776-a2ebb0fc19fc@redhat.com>
        <FYDLXQ.TA0Y98DS5UW4@ljones.dev>
        <96aa39fd-119a-f79e-ee74-2db6d117fac3@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Aug 10 2021 at 09:46:13 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> <Added platform-driver-x86@vger.kernel.org to the Cc>
> 
> On 8/9/21 11:49 PM, Luke Jones wrote:
>> 
>> 
>>  On Mon, Aug 9 2021 at 11:18:38 +0200, Hans de Goede 
>> <hdegoede@redhat.com> wrote:
>>>  Hi Luke,
>>> 
>>>  On 8/7/21 4:36 AM, Luke D. Jones wrote:
>>>>   This patch series adds support for some functions that are found 
>>>> on newer
>>>>   ASUS gaming laptops:
>>>> 
>>>>   - Panel overdrive: Some laptops can drive the LCD matrix 
>>>> slightly faster
>>>>     to eliminate or reduce ghosting artifacts
>>>> 
>>>>   - dGPU disable: ASUS added a function in ACPI to disable or 
>>>> enable the dGPU
>>>>     which removes it from the PCI bus. Presumably this was to help 
>>>> prevent
>>>>     Windows apps from using the dGPU when the user didn't want 
>>>> them to but
>>>>     because of how it works it also means that when rebooted to 
>>>> Linux the dGPU
>>>>     no-longer exits. This patch enables a user to echo 0/1 to a 
>>>> WMI path to
>>>>     re-enable it (or disable, but the drivers *must* be unloaded 
>>>> first).
>>>> 
>>>>   - eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and 
>>>> an optional
>>>>     eGPU. This patch enables the user to echo 0/1 to a WMI path to 
>>>> enable or
>>>>     disable the eGPU. In ACPI this also appears to remove the dGPU 
>>>> from the
>>>>     PCI bus.
>>>> 
>>>>   All of the above patches have been tested over the course of a 
>>>> few months.
>>>>   There is a small possibility of user error perhaps, where the 
>>>> user tries to
>>>>   enable or disable the dGPU/eGPU while drivers are loaded which 
>>>> would cause
>>>>   a system hang, but it is expected that almost all users would be 
>>>> using the
>>>>   `asusctl` daemon and dbus methods to manage the above which then 
>>>> eliminates
>>>>   these issues.
>>> 
>>>  Thank you for the new version, all 3 patches look good to me, but 
>>> I miss
>>>  a changelog in this cover-letter.
>>> 
>>>  Specifically I'm wondering what happened to the following,
>>>  which you wrote about in the v1 patch-set thread:
>>> 
>>>  """
>>>  Proper enable of the dGPU again as far as my testing goes works 
>>> such that:
>>>  1. call the ACPI method
>>>  2. rescan PCI bus to ensure the device is powered
>>>  3. call the ACPI method again to save the setting
>>> 
>>>  But it appears that recent work in-kernel for many things AMD 
>>> related has broken this for us...
>>>  """
>> 
>>  Apologies, I've been a bit too busy to remember some things.
>> 
>>  The changes are mostly to satisfy review. The dGPU patch has 
>> removed the
>>  dual call to the ACPI method, it was not working as expected. I 
>> will revisit
>>  this when 5.14 kernel is released.
> 
> Ok, so from my pov these patches are ready for merging now, but since 
> this
> is still somewhat of an open question, I wonder if they are also ready
> for merging from your pov, or if you want to fist sort this out ?

I'm definitely okay with merging now. The dgpu patch can at least 
provide
us a hint for the user that the dGPU may have been disabled in Windows 
and
recommend that they use Windows + Armoury Crate to enable it again.

The eGPU patch itself appears to work well enough and relies on the dGPU
patch.

If we're both fine with the patches lets go ahead :)

Many thanks,
Luke.

> 
>>  I'll be sure to remember the changelog next time I submit a patch, 
>> sorry.
> 
> No problem.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>>>   Luke D. Jones (3):
>>>>     asus-wmi: Add panel overdrive functionality
>>>>     asus-wmi: Add dgpu disable method
>>>>     asus-wmi: Add egpu enable method
>>>> 
>>>>    drivers/platform/x86/asus-wmi.c            | 289 
>>>> +++++++++++++++++++++
>>>>    include/linux/platform_data/x86/asus-wmi.h |   7 +
>>>>    2 files changed, 296 insertions(+)
>>>> 
>>>>   --
>>>>   2.31.1
>>>> 
>>> 
>> 
>> 
> 


