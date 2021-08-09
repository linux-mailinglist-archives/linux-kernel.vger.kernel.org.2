Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24573E4EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhHIVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:50:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44045 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232193AbhHIVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:50:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D4635C013B;
        Mon,  9 Aug 2021 17:49:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 09 Aug 2021 17:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+rKdu4
        WA7E0qMs0UBJN/O7W8KbcjkYI2M+0E8imLbP8=; b=ElLQXUj18BLVLiwOofrfWN
        McE/YuQRS6I8MSRVcCgJWF7WkTD0EUc1MkBXB0mXm1a9KvGZkqy6UXJ9nxOu1wuV
        X9ihBnpv5u/qR6Q6+f8dQ9P7IgQehEJDhmhB870vpjldfreVVhTEWQbSV9zzGLkR
        g+Jyt7lFdn/2kfo0qmPy9JmBfWYoeuLfoHKgyhwe+6CJttRIhZHbzcIPH99BJAvI
        Pr3KIavYIy35DXZOCnjFQfWyITdpDFL5q29vzM9hTmcY4apjZowmK9h78P34YOQm
        ZsAZ1tcr6ZjbEweBsmu6+zjLqBf7NLBjLoD3eJ2yNLpjsT8DqGm7NcGB31lkk3aA
        ==
X-ME-Sender: <xms:-qIRYeMeATc4nG0KTdF2kVj1BTEepCtoLPqL6fW9t70mh5sfRH7odg>
    <xme:-qIRYc80dAhr9c81f99Cn_rBNJ2PK0tc2bXY3OhK7QS4m8dAsFN2SHLqQxxP8iBgz
    nJqVbe7XFjOVrmw9oA>
X-ME-Received: <xmr:-qIRYVTOICkLjDXur0uJIJMGZuEpVsVWjPNZFGz0EkwcN2AG_KXG5BvkFVsJ-PD1PiF-cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:-qIRYeu9qk5liYIR5ko5j3ndNBp9lz6ODEFuN487y0FQzoH0hapqaw>
    <xmx:-qIRYWfDOwBtsxKhQzoRYZBbuSYHkkB46TfZVVxCPVGulkd0KhvlIg>
    <xmx:-qIRYS1Z28DK0ABj-HIFvgCxW_D0KVvBnyu7a0B4I1TkOoHFkce2xQ>
    <xmx:-6IRYXo2vxndLj0avSiLXL6XZysodFiWQC_i09bOLHYT39A1-H9uCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 17:49:42 -0400 (EDT)
Date:   Tue, 10 Aug 2021 09:49:27 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel
 overdrive
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mgross@linux.intel.com,
        pobrn@protonmail.com, corentin.chary@gmail.com
Message-Id: <FYDLXQ.TA0Y98DS5UW4@ljones.dev>
In-Reply-To: <aec7b518-0979-7b7e-f776-a2ebb0fc19fc@redhat.com>
References: <20210807023656.25020-1-luke@ljones.dev>
        <aec7b518-0979-7b7e-f776-a2ebb0fc19fc@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 9 2021 at 11:18:38 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> On 8/7/21 4:36 AM, Luke D. Jones wrote:
>>  This patch series adds support for some functions that are found on 
>> newer
>>  ASUS gaming laptops:
>> 
>>  - Panel overdrive: Some laptops can drive the LCD matrix slightly 
>> faster
>>    to eliminate or reduce ghosting artifacts
>> 
>>  - dGPU disable: ASUS added a function in ACPI to disable or enable 
>> the dGPU
>>    which removes it from the PCI bus. Presumably this was to help 
>> prevent
>>    Windows apps from using the dGPU when the user didn't want them 
>> to but
>>    because of how it works it also means that when rebooted to Linux 
>> the dGPU
>>    no-longer exits. This patch enables a user to echo 0/1 to a WMI 
>> path to
>>    re-enable it (or disable, but the drivers *must* be unloaded 
>> first).
>> 
>>  - eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an 
>> optional
>>    eGPU. This patch enables the user to echo 0/1 to a WMI path to 
>> enable or
>>    disable the eGPU. In ACPI this also appears to remove the dGPU 
>> from the
>>    PCI bus.
>> 
>>  All of the above patches have been tested over the course of a few 
>> months.
>>  There is a small possibility of user error perhaps, where the user 
>> tries to
>>  enable or disable the dGPU/eGPU while drivers are loaded which 
>> would cause
>>  a system hang, but it is expected that almost all users would be 
>> using the
>>  `asusctl` daemon and dbus methods to manage the above which then 
>> eliminates
>>  these issues.
> 
> Thank you for the new version, all 3 patches look good to me, but I 
> miss
> a changelog in this cover-letter.
> 
> Specifically I'm wondering what happened to the following,
> which you wrote about in the v1 patch-set thread:
> 
> """
> Proper enable of the dGPU again as far as my testing goes works such 
> that:
> 1. call the ACPI method
> 2. rescan PCI bus to ensure the device is powered
> 3. call the ACPI method again to save the setting
> 
> But it appears that recent work in-kernel for many things AMD related 
> has broken this for us...
> """

Apologies, I've been a bit too busy to remember some things.

The changes are mostly to satisfy review. The dGPU patch has removed the
dual call to the ACPI method, it was not working as expected. I will 
revisit
this when 5.14 kernel is released.

I'll be sure to remember the changelog next time I submit a patch, 
sorry.

Regards,
Luke.

> 
> ?
> 
> Regards,
> 
> Hans
> 
> 
> 
>> 
>>  Luke D. Jones (3):
>>    asus-wmi: Add panel overdrive functionality
>>    asus-wmi: Add dgpu disable method
>>    asus-wmi: Add egpu enable method
>> 
>>   drivers/platform/x86/asus-wmi.c            | 289 
>> +++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |   7 +
>>   2 files changed, 296 insertions(+)
>> 
>>  --
>>  2.31.1
>> 
> 


