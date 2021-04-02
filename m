Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A180A352705
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhDBHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:44:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15467 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhDBHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:44:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBX7p0v6BzyN9j;
        Fri,  2 Apr 2021 15:42:14 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 15:44:11 +0800
Message-ID: <6066CB4A.4060504@hisilicon.com>
Date:   Fri, 2 Apr 2021 15:44:10 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Hao Fang <fanghao11@huawei.com>, <linux@armlinux.org.uk>
CC:     <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] ARM: hisi: use the correct HiSilicon copyright
References: <1617087100-20949-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617087100-20949-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao Fang,

On 2021/3/30 14:51, Hao Fang wrote:
> s/Hisilicon/HiSilicon/
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks!
Applied to the hisilicon arm32 SoC tree.

Best Regards,
Wei

> ---
>  arch/arm/mach-hisi/hisilicon.c | 4 ++--
>  arch/arm/mach-hisi/hotplug.c   | 2 +-
>  arch/arm/mach-hisi/platmcpm.c  | 2 +-
>  arch/arm/mach-hisi/platsmp.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
> index 07ea28b..b8d14b3 100644
> --- a/arch/arm/mach-hisi/hisilicon.c
> +++ b/arch/arm/mach-hisi/hisilicon.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * (Hisilicon's SoC based) flattened device tree enabled machine
> + * (HiSilicon's SoC based) flattened device tree enabled machine
>   *
> - * Copyright (c) 2012-2013 Hisilicon Ltd.
> + * Copyright (c) 2012-2013 HiSilicon Ltd.
>   * Copyright (c) 2012-2013 Linaro Ltd.
>   *
>   * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
> index 5c5f255..c517941 100644
> --- a/arch/arm/mach-hisi/hotplug.c
> +++ b/arch/arm/mach-hisi/hotplug.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>   */
>  
>  #include <linux/cpu.h>
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index f155e32..96a4840 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013-2014 Linaro Ltd.
> - * Copyright (c) 2013-2014 Hisilicon Limited.
> + * Copyright (c) 2013-2014 HiSilicon Limited.
>   */
>  #include <linux/init.h>
>  #include <linux/smp.h>
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index da7a09c..a56cc64 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>   * Based on arch/arm/mach-vexpress/platsmp.c, Copyright (C) 2002 ARM Ltd.
>   */
>  #include <linux/smp.h>
> 
