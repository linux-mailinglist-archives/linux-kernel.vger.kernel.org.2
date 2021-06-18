Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8003AC069
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhFRBGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:06:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7479 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhFRBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:06:21 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5gbY71flzZhlv;
        Fri, 18 Jun 2021 09:01:13 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:04:10 +0800
Message-ID: <60CBF10A.6020304@hisilicon.com>
Date:   Fri, 18 Jun 2021 09:04:10 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Hao Fang <fanghao11@huawei.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] arm64: dts: hisilicon: use the correct HiSilicon copyright
References: <1621678832-14924-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1621678832-14924-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao Fang,

On 2021/5/22 18:20, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts   | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts   | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts      | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi            | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi            | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi            | 2 +-
>  include/dt-bindings/pinctrl/hisi.h                  | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> index d607f2f..79a55a0f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> @@ -3,7 +3,7 @@
>  /*
>   * dtsi for Hisilicon Hi3660 Coresight
>   *
> - * Copyright (C) 2016-2018 Hisilicon Ltd.
> + * Copyright (C) 2016-2018 HiSilicon Ltd.
>   *
>   * Author: Wanglai Shi <shiwanglai@hisilicon.com>
>   *
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 963300e..f68580d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon HiKey960 Development Board
>   *
> - * Copyright (C) 2016, Hisilicon Ltd.
> + * Copyright (C) 2016, HiSilicon Ltd.
>   *
>   */
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index cab89dc..f1ec87c 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon Hi3660 SoC
>   *
> - * Copyright (C) 2016, Hisilicon Ltd.
> + * Copyright (C) 2016, HiSilicon Ltd.
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> index 7f9f988..d8abf44 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon HiKey970 Development Board
>   *
> - * Copyright (C) 2016, Hisilicon Ltd.
> + * Copyright (C) 2016, HiSilicon Ltd.
>   * Copyright (C) 2018, Linaro Ltd.
>   *
>   */
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 8830795..20698cf 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon Hi3670 SoC
>   *
> - * Copyright (C) 2016, Hisilicon Ltd.
> + * Copyright (C) 2016, HiSilicon Ltd.
>   * Copyright (C) 2018, Linaro Ltd.
>   */
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> index 7b3010f..3f387f4 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dtsi file for Hisilicon Hi6220 coresight
>   *
> - * Copyright (C) 2017 Hisilicon Ltd.
> + * Copyright (C) 2017 HiSilicon Ltd.
>   *
>   * Author: Pengcheng Li <lipengcheng8@huawei.com>
>   *         Leo Yan <leo.yan@linaro.org>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 91d0867..3df2afb 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon HiKey Development Board
>   *
> - * Copyright (C) 2015, Hisilicon Ltd.
> + * Copyright (C) 2015, HiSilicon Ltd.
>   *
>   */
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index d426c6c..dde9371 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Hisilicon Hi6220 SoC
>   *
> - * Copyright (C) 2015, Hisilicon Ltd.
> + * Copyright (C) 2015, HiSilicon Ltd.
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> index 369b69b..40f3e00 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D02 Development Board
>   *
> - * Copyright (C) 2014,2015 Hisilicon Ltd.
> + * Copyright (C) 2014,2015 HiSilicon Ltd.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> index 4aed8d4..7b2abd1 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D02 Development Board
>   *
> - * Copyright (C) 2014,2015 Hisilicon Ltd.
> + * Copyright (C) 2014,2015 HiSilicon Ltd.
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> index 9f4a930..35af5d3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D03 Development Board
>   *
> - * Copyright (C) 2016 Hisilicon Ltd.
> + * Copyright (C) 2016 HiSilicon Ltd.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index 7deca5f..70d7732 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D03 Development Board
>   *
> - * Copyright (C) 2016 Hisilicon Ltd.
> + * Copyright (C) 2016 HiSilicon Ltd.
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> index 81a2312..c3df678 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D05 Development Board
>   *
> - * Copyright (C) 2016 Hisilicon Ltd.
> + * Copyright (C) 2016 HiSilicon Ltd.
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> index 2172d80..6baf6a6 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
> @@ -2,7 +2,7 @@
>  /**
>   * dts file for Hisilicon D05 Development Board
>   *
> - * Copyright (C) 2016 Hisilicon Ltd.
> + * Copyright (C) 2016 HiSilicon Ltd.
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
> index 0359bfd..93064c7 100644
> --- a/include/dt-bindings/pinctrl/hisi.h
> +++ b/include/dt-bindings/pinctrl/hisi.h
> @@ -1,7 +1,7 @@
>  /*
>   * This header provides constants for hisilicon pinctrl bindings.
>   *
> - * Copyright (c) 2015 Hisilicon Limited.
> + * Copyright (c) 2015 HiSilicon Limited.
>   * Copyright (c) 2015 Linaro Limited.
>   *
>   * This program is free software; you can redistribute it and/or modify
> 
