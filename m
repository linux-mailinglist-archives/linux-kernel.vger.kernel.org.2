Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1865B308372
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhA2B4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:56:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11471 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA2B4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:56:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRgPT6BHQzjDFw;
        Fri, 29 Jan 2021 09:54:21 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 09:55:11 +0800
Message-ID: <60136AFF.5080204@hisilicon.com>
Date:   Fri, 29 Jan 2021 09:55:11 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
References: <20201208124641.1787-1-thunder.leizhen@huawei.com> <20201208124641.1787-3-thunder.leizhen@huawei.com> <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com> <6010B6DE.4060202@hisilicon.com> <CAK8P3a31po51NtRhuMsruy2nbqhjguyGP8ZcXwPAwwEiGtLBkg@mail.gmail.com> <60135EBA.5040803@hisilicon.com>
In-Reply-To: <60135EBA.5040803@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2021/1/29 9:02, Wei Xu wrote:
> Hi Arnd,
> 
> On 2021/1/28 22:08, Arnd Bergmann wrote:
>> On Wed, Jan 27, 2021 at 1:42 AM Wei Xu <xuwei5@hisilicon.com> wrote:
>>> On 2021/1/27 6:23, Arnd Bergmann wrote:
>>>> On Tue, Dec 8, 2020 at 1:46 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>
>>>>> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
>>>>> stated in "vendor-prefixes.yaml".
>>>>>
>>>>> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
>>>>> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> Cc: Chen Feng <puck.chen@hisilicon.com>
>>>>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>
>>>> I see this change in the pull request I got, but I'm a bit worried about the
>>>> incompatible binding change. Wouldn't the correct path forward be to
>>>> list both the correct and the incorrect properties, both in the dts file
>>>> and in the driver that interprets the properties?
>>>
>>> Thanks for the comment!
>>> The reset driver will look for "hisilicon" firstly and fall back to "hisi".
>>> And the DTS is shipped with the driver together.
>>> So I think there is no compatible issue here.
>>> Please let me know if missed anything. Thanks!
>>
>> There are three things that can go wrong here, and this is only addressing
>> one of them:
> 
> Thanks for the detailed explanation! 
> 
>>
>> 1. Updating the kernel on a machine with a dtb provided by the firmware
>>   is a problem if the new driver can not handle the old properties. This
>>   is correctly handled by the driver's fallback as soon as both trees
>>   are merged.
> 
> Agreed and the driver has been merged into the v5.11-rc1.

Sorry, I made a mistake. It has been merged into linux-next *not* the v5.11-rc1.

> 
>>
>> 2. Updating the dtb while running an older kernel is now broken since
>>   the driver can no longer read the property. This is less critical, but
>>   it does seem easy enough to work around here by leaving both
>>   properties in place.
> 
> Yes, it is.
> But if leaving both in place, the dtbs_check will report following warning again:
> 	'hisi,rst-syscon' does not match any of the regexes
> 
> That is why leizhen changed the dtb.
> Do you think it is OK to assume no one will use the new dtb with an older kernel?
> 
>>
>> 3. Bisecting through the git history across an incompatible change
>>   means you can run into broken commits. We try hard to avoid that
>>   if we are aware of a problem in advance. In this case it could be
>>   avoided by only merging the incompatible DT change in a following
>>   merge window after the driver change, or (better) by making it
>>   a backward-compatible change the same way as addressing 2.
> 
> Yes, agreed.
> And The DT change pull request is sent after the driver has been merged into v5.11-rc1.

I can drop this patch and revert what I have changed in Mauro's following patch:
	"arm64: dts: hisilicon: hi3670.dtsi: add iomcu_rst"

Then resend the pull request. And pick up this patch after the next merge window.
Do you think is it OK?
Thanks!

Best Regards,
Wei

> 
> Really appreciate the detail you went to!
> 
> Best Regards,
> Wei
> 
>>
>>          Arnd
>> .
>>
