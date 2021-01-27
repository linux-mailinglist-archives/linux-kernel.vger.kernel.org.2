Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C730504B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhA0DzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:55:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11602 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392495AbhA0Bm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:42:56 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQQll5dQ6z1607q;
        Wed, 27 Jan 2021 09:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 27 Jan 2021
 09:21:54 +0800
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to
 hisilicon
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
 <20201208124641.1787-3-thunder.leizhen@huawei.com>
 <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <aaf6ec27-b2cb-6e29-3c73-36c5c34b34e4@huawei.com>
Date:   Wed, 27 Jan 2021 09:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/27 6:23, Arnd Bergmann wrote:
> On Tue, Dec 8, 2020 at 1:46 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
>> stated in "vendor-prefixes.yaml".
>>
>> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
>> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Cc: Chen Feng <puck.chen@hisilicon.com>
>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I see this change in the pull request I got, but I'm a bit worried about the
> incompatible binding change. Wouldn't the correct path forward be to
> list both the correct and the incorrect properties, both in the dts file
> and in the driver that interprets the properties?

Hi, Arnd:

This is one of the patch series. The other three patches have been applied by Philipp Zabel and are currently in linux-next.

https://lkml.org/lkml/2020/12/10/697

> 
> The binding file in this case would need to list the old name as deprecated,
> though I'm not sure how that would work without causing a warning about
> the unknown vendor prefix.
> 
>         Arnd
> 
> .
> 

