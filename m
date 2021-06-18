Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266143AC067
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhFRBF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:05:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7364 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhFRBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:05:56 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5gYr5JDdz6yDK;
        Fri, 18 Jun 2021 08:59:44 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:03:45 +0800
Message-ID: <60CBF0F1.7080302@hisilicon.com>
Date:   Fri, 18 Jun 2021 09:03:45 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Hao Fang <fanghao11@huawei.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] ARM: dts: hisilicon: use the correct HiSilicon copyright
References: <1621678917-15089-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1621678917-15089-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao Fang,

On 2021/5/22 18:21, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks!
Applied to the hisilicon arm32 dt tree.

Best Regards,
Wei


> ---
>  arch/arm/boot/dts/hi3620.dtsi        | 4 ++--
>  arch/arm/boot/dts/hip01-ca9x2.dts    | 4 ++--
>  arch/arm/boot/dts/hip01.dtsi         | 4 ++--
>  arch/arm/boot/dts/hip04.dtsi         | 4 ++--
>  arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 2 +-
>  arch/arm/boot/dts/hisi-x5hd2.dtsi    | 2 +-
>  arch/arm/boot/dts/sd5203.dts         | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> index 905900b..cf48ec1 100644
> --- a/arch/arm/boot/dts/hi3620.dtsi
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Hisilicon Ltd. Hi3620 SoC
> + * HiSilicon Ltd. Hi3620 SoC
>   *
> - * Copyright (C) 2012-2013 Hisilicon Ltd.
> + * Copyright (C) 2012-2013 HiSilicon Ltd.
>   * Copyright (C) 2012-2013 Linaro Ltd.
>   *
>   * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> diff --git a/arch/arm/boot/dts/hip01-ca9x2.dts b/arch/arm/boot/dts/hip01-ca9x2.dts
> index 0314763..f3faf24 100644
> --- a/arch/arm/boot/dts/hip01-ca9x2.dts
> +++ b/arch/arm/boot/dts/hip01-ca9x2.dts
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Hisilicon Ltd. HiP01 SoC
> + * HiSilicon Ltd. HiP01 SoC
>   *
> - * Copyright (C) 2014 Hisilicon Ltd.
> + * Copyright (C) 2014 HiSilicon Ltd.
>   * Copyright (C) 2014 Huawei Ltd.
>   *
>   * Author: Wang Long <long.wanglong@huawei.com>
> diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
> index 2a79636..e17f36b 100644
> --- a/arch/arm/boot/dts/hip01.dtsi
> +++ b/arch/arm/boot/dts/hip01.dtsi
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Hisilicon Ltd. HiP01 SoC
> + * HiSilicon Ltd. HiP01 SoC
>   *
> - * Copyright (c) 2014 Hisilicon Ltd.
> + * Copyright (c) 2014 HiSilicon Ltd.
>   * Copyright (c) 2014 Huawei Ltd.
>   *
>   * Author: Wang Long <long.wanglong@huawei.com>
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index bccf5ba..2424cc5 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Hisilicon Ltd. HiP04 SoC
> + * HiSilicon Ltd. HiP04 SoC
>   *
> - * Copyright (C) 2013-2014 Hisilicon Ltd.
> + * Copyright (C) 2013-2014 HiSilicon Ltd.
>   * Copyright (C) 2013-2014 Linaro Ltd.
>   *
>   * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> index 22b122d..7758c19 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> +++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013-2014 Linaro Ltd.
> - * Copyright (c) 2013-2014 Hisilicon Limited.
> + * Copyright (c) 2013-2014 HiSilicon Limited.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> index 9721138..dc991ba 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2013-2014 Linaro Ltd.
> - * Copyright (c) 2013-2014 Hisilicon Limited.
> + * Copyright (c) 2013-2014 HiSilicon Limited.
>   */
>  
>  #include <dt-bindings/clock/hix5hd2-clock.h>
> diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
> index 3cc9a23..a61a078 100644
> --- a/arch/arm/boot/dts/sd5203.dts
> +++ b/arch/arm/boot/dts/sd5203.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2020 Hisilicon Limited.
> + * Copyright (c) 2020 HiSilicon Limited.
>   *
>   * DTS file for Hisilicon SD5203 Board
>   */
> 
