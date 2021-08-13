Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087F23EB2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbhHMIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:30:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8015 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbhHMIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:30:34 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GmGvD22lWzYnm4;
        Fri, 13 Aug 2021 16:29:44 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 13 Aug 2021 16:30:01 +0800
Message-ID: <61162D89.2070901@hisilicon.com>
Date:   Fri, 13 Aug 2021 16:30:01 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH] arm64: dts: HiSilicon: hi3660: address a PCI warning
References: <934f397d227ea589a16c89f1ee9c6f199c662093.1628666047.git.mchehab+huawei@kernel.org>
In-Reply-To: <934f397d227ea589a16c89f1ee9c6f199c662093.1628666047.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/8/11 15:14, Mauro Carvalho Chehab wrote:
> When the driver is registered, it produces a warning when
> registering the PCI bridge:
> 
> 	[    5.363450] pci_bus 0000:00: root bus resource [bus 00-01]
> 	[    5.396998] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-01] (conflicts with (null) [bus 00-01])
> 	[    5.284831] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> 
> The reason is that the bus-range is wrong. Address it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f1ec87c05842..cf2079590ad8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1002,7 +1002,7 @@ pcie@f4000000 {
>  			      <0x0 0xf3f20000 0x0 0x40000>,
>  			      <0x0 0xf5000000 0x0 0x2000>;
>  			reg-names = "dbi", "apb", "phy", "config";
> -			bus-range = <0x0  0x1>;
> +			bus-range = <0x0  0xff>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> 
