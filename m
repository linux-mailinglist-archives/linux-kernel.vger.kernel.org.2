Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04D306A63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhA1BbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:31:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11520 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1BbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:31:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DR2tz28RSzjFLZ;
        Thu, 28 Jan 2021 09:29:15 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 28 Jan 2021
 09:30:18 +0800
Subject: Re: [PATCH v5 0/4] ARM: Add support for Hisilicon Kunpeng L3 cache
 controller
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <036c026a-f6ec-e029-95b4-e715c93f2c21@huawei.com>
Date:   Thu, 28 Jan 2021 09:30:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210116032740.873-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell and Arnd:
  Do you have time to review it?


On 2021/1/16 11:27, Zhen Lei wrote:
> v4 --> v5:
> 1. Add SoC macro ARCH_KUNPENG50X, and the Kunpeng L3 cache controller only enabled
>    on that platform.
> 2. Require the compatible string of the Kunpeng L3 cache controller must have a
>    relevant name on a specific SoC. For example:
>    compatible = "hisilicon,kunpeng509-l3cache", "hisilicon,kunpeng-l3cache";
> 
> v3 --> v4:
> Rename the compatible string from "hisilicon,l3cache" to "hisilicon,kunpeng-l3cache".
> Then adjust the file name, configuration option name, and description accordingly.
> 
> v2 --> v3:
> Add Hisilicon L3 cache controller driver and its document. That's: patch 2-3.
> 
> v1 --> v2:
> Discard the middle-tier functions and do silent narrowing cast in the outcache
> hook functions. For example:
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
>  {
> +	unsigned long start = pa_start;
> +	unsigned long end = pa_end;
> 
> 
> v1:
> Do cast phys_addr_t to unsigned long by adding a middle-tier function.
> For example:
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void __l2c220_inv_range(unsigned long start, unsigned long end)
>  {
>  	...
>  }
> +static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
> +{
> +  __l2c220_inv_range(start, end);
> +}
> 
> 
> Zhen Lei (4):
>   ARM: LPAE: Use phys_addr_t instead of unsigned long in outercache
>     hooks
>   ARM: hisi: add support for Kunpeng50x SoC
>   dt-bindings: arm: hisilicon: Add binding for Kunpeng L3 cache
>     controller
>   ARM: Add support for Hisilicon Kunpeng L3 cache controller
> 
>  .../arm/hisilicon/kunpeng-l3cache.yaml        |  40 +++++
>  arch/arm/include/asm/outercache.h             |   6 +-
>  arch/arm/mach-hisi/Kconfig                    |   8 +
>  arch/arm/mm/Kconfig                           |  10 ++
>  arch/arm/mm/Makefile                          |   1 +
>  arch/arm/mm/cache-feroceon-l2.c               |  15 +-
>  arch/arm/mm/cache-kunpeng-l3.c                | 153 ++++++++++++++++++
>  arch/arm/mm/cache-kunpeng-l3.h                |  30 ++++
>  arch/arm/mm/cache-l2x0.c                      |  50 ++++--
>  arch/arm/mm/cache-tauros2.c                   |  15 +-
>  arch/arm/mm/cache-uniphier.c                  |   6 +-
>  arch/arm/mm/cache-xsc3l2.c                    |  12 +-
>  12 files changed, 317 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/kunpeng-l3cache.yaml
>  create mode 100644 arch/arm/mm/cache-kunpeng-l3.c
>  create mode 100644 arch/arm/mm/cache-kunpeng-l3.h
> 

