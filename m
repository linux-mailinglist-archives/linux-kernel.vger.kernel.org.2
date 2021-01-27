Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78730545A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhA0HTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:19:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11599 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317501AbhA0AnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:43:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQPsr3HGvz1605l;
        Wed, 27 Jan 2021 08:41:04 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 08:42:07 +0800
Message-ID: <6010B6DE.4060202@hisilicon.com>
Date:   Wed, 27 Jan 2021 08:42:06 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
References: <20201208124641.1787-1-thunder.leizhen@huawei.com> <20201208124641.1787-3-thunder.leizhen@huawei.com> <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
In-Reply-To: <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

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

Thanks for the comment!
The reset driver will look for "hisilicon" firstly and fall back to "hisi".
And the DTS is shipped with the driver together.
So I think there is no compatible issue here.
Please let me know if missed anything. Thanks!

Best Regards,
Wei

> 
> The binding file in this case would need to list the old name as deprecated,
> though I'm not sure how that would work without causing a warning about
> the unknown vendor prefix.
> 
>         Arnd
> .
> 
