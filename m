Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC21F439E57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhJYSUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:20:22 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:30183
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231512AbhJYSUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcOyn6P6LCxbH3gAQAUOjzzC0HP2FjMXvmBfOz2AmTGP6y8yH6IUefnujQvbNnbfICP3f5o/kNRck4lBdRZFj9Eqv8m6rcXC3gcCEaT5LDaArzKhA6XAzKYcg6knBkzWIVXDWD93aAFPpEPHIv1YmKq9yZaZwdS95aV3hb0n69OTpR3AbVuOY7K0Mwbdz9hQ9+UdqwNwUQLbl+Fk5XicleufBilwwqIZLnIQgo7eStaRfuV/KUhB5Ony1Mtr+61cjV7e3m53OQPmcrzsZM+0MPnCG1HB8LsyURk8X+uWuqIWhlIl/z0eeqi4kjtiqXNE1YJoVv6H8Ut3r+dVFD9Ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOsXJu9vCg6NmfEO1pzMT0o1rL9E0LUQ2//UY6+5LAA=;
 b=QcD1LZ039TFFGoRl0aPH3c0/7JlCaKNJSFby53kp3RkrMt3MSlahsVznFgUEJ4IF2/qYaVn0hV62aE/HF/Gl8Fn6Fkw26e8nzKGtJhoFM0bw8oOYQ2YCPnIiqj0fhpQsH/6OgneqpE8/TfWOjEaum2Qr/wg4aoEUEKID9NyL+PjJrF5MOuHPdrz7frWvyW/h+BFFLSI1L7fbs8jPVhh0BND/ISxkakEdK73fw7Me2UoMmBSwiVpVGiPdb5L37qQPTjgtSvA6x6UrvxXjxSB/roqb/1e/Wx4eyXcQ5jRE8N8c2hrDDqjJdUhNQOh60ieoKN1JIY5Lhb2EhxHTi3KkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOsXJu9vCg6NmfEO1pzMT0o1rL9E0LUQ2//UY6+5LAA=;
 b=tGnNUs1u/vwwR0YJ/ZCFgXbYreOrxU5+rkhgvgRij/pmWPQJOAdLbiIPfRy9lKvbqX2EjMMjCOXoU9U3KDycqeie5iN1Hq5iSfXCibtSGrmraSgWvWN13UasLNzrr6qtakmucBbqV5uJBjfoHKjk+PPFO2SsGJb3zYSP2uQj/Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4859.eurprd03.prod.outlook.com (2603:10a6:10:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 18:17:55 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 18:17:54 +0000
Subject: Re: [PATCH 2/2] reset: Add GPIO-based reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20211018234923.1769028-1-sean.anderson@seco.com>
 <20211018234923.1769028-2-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <4303204a-12a0-e81b-395e-14b3dc7f64ee@seco.com>
Date:   Mon, 25 Oct 2021 14:17:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211018234923.1769028-2-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Mon, 25 Oct 2021 18:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47389fe6-00a7-4272-55a9-08d997e3c336
X-MS-TrafficTypeDiagnostic: DB7PR03MB4859:
X-Microsoft-Antispam-PRVS: <DB7PR03MB4859BBE14D21FB07FB25D2F096839@DB7PR03MB4859.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz0Zicbm6z4HlDW17suLbBB09PlIs48Uohshv/S2Xlt8W5D9slcnIZZdnPP2T/q30bHYCqUiaEDbVIz1gW6gx1yHw6O7PGXMFvklBsbXG767yZ0K4Yr5eYcWqt8jROcpvT3fcR3C63gI1g9J9glJisjFOrkhSijkHCPOnWu3Y85+6j8x8yhgyPwjp1UHVI/0sd2lxSEiTHfl0fsiHiTorOafaysg+/ffcBWQZWF/ajvuvt5V0ZugZxlKX1lnzGbt/Lu04mZsIrWt0Ihnww4gH7Cq0G+fzd4Qeeih3DFsTc3EURs1DZ7frgPgy5ftQ3QAqElGvhfAr5x13NcujDUUCa3D/KoJFSOlZgbC+YysX+pbgnElrqiGkhwigUiTziLihE47BoqNnSEZJsJEj/jHuogGxK6eLW/ReO57JiaWjp+Y+MZBudGyyZy/dltBq9qtj+glyV5xlCKcyHsyQJany/MP65Uxf6dHl0evd5VQt0vvF9RTqRbxVusVklHyOXzlvijCEFFm8VmteD+xu1OVV2CZxDT07wWQXxex0qhW4ZHjnX31GVMuNzBDIYTTkmemGm0hLrGJU23aQUu0v/f7Oem+RpHRU0uyQRuLbZ6HP7MmupN8tOPw/HnIxhJJb8KQSrMu/IXn1zG+gf/y6H4OSwQW8iKPzPRhj+elxDpfq+nG5fHAlvEjUGxY+/d6OsfF49F40roTIKCpc3M9EfUK//g53dOti49AbAhD/h4Vmq42CeRHsH+klJ45yjhGsbk4VgUJTtK8bleYkzbmm1kdrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(8676002)(36756003)(38100700002)(4326008)(316002)(44832011)(26005)(30864003)(6666004)(5660300002)(16576012)(2906002)(86362001)(38350700002)(31696002)(2616005)(6486002)(956004)(83380400001)(66946007)(6916009)(8936002)(53546011)(31686004)(508600001)(66476007)(186003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNmMytYTTNUMm1ndEl6L2pGMUJVakI5a2JrLzhQZWc4eWNUUkhlaVJXYlpZ?=
 =?utf-8?B?Mjl4MnJ4OFN1UDM0Q295aDYwUDc3WEtiRVhDdmQvZ1BCV2NNN1BUcVNiUExq?=
 =?utf-8?B?ZXZrVnVCVU15UnJEQXQ4N1lKcXZuTVl3WVpJUTVwcCtWaGZ4T0dYT0RpWkpu?=
 =?utf-8?B?aW9yWjB0cVlKZVlWWER5Skp5aWdlTmVpT3dHaUNvNmJqN3h3R3FwT2pYNld1?=
 =?utf-8?B?di9HQ0FOMVpSaTJGTHh5YzZEZ01WdXY0TFIzdXdQRXVsY1ZHMWVyTXpMWlFY?=
 =?utf-8?B?K2tIeWxTRnd0clBzRElybm9ZOHdzRmpVQUJYNSt1Tkd3OXZ0TlNCWTJsMmZP?=
 =?utf-8?B?UG5DMHZaYS9Oa2YwOFRFTWxucUxjMXhrTlhyZ0hiSGtxK3ZmZElucGoyZzlD?=
 =?utf-8?B?azRIREgySm5PMXc0b1FTQ2luZ2pqbUxlTTNJOWFycFpRWVE2S3cyNzhpVWcz?=
 =?utf-8?B?VVl4cGxHeFpTRzBSN3MvUFZZSTYxaVpNU2FOT3BUS0VFOEFZeEtWMjJSRVBv?=
 =?utf-8?B?Si82cXVkSkMzaStSQjVtVjRkQXlPWkltSlBsRmNMd0hFcXl3YTRkZGdUcDlT?=
 =?utf-8?B?b3ZEanN0Y3VNRDdmcTJ0RjNHV05DdzduWi9PWERYdEZMUkROZWRpNHA3Z2tJ?=
 =?utf-8?B?QTZ0d0FNZWxtUDg4WSt5NUlPMWFkN0pCeHV2KzFzMjRlaElNSE42QVZBZXQz?=
 =?utf-8?B?ckpaRUZIM0tia1Y1K0VPSkRqMlNLTEU2RCtUMTZnMEtIQ3pPMDJHSHY0Y3By?=
 =?utf-8?B?NHJGLzV4U25Dcmduc2xIR0dQYjZhd2kzUFVMcUxoN1pKUDVjTnB0L0g5ZzhH?=
 =?utf-8?B?T2xZSVBabmFLTW1HZHlsVDFTU2pUVC81ckUxa3RSN3hjTzlIRSs4U2FlYnlu?=
 =?utf-8?B?ckZUUkpGdXM0OXVWeFpTRGNlRktqYlZFZ2RqbG5hUGZ2SG9qSWdpMDRpM0dx?=
 =?utf-8?B?czQ4OVhPeXhLYm1Xbk9hSFN4em5xMHBzdXVlVGtOaERSaWxCZFoxUU1BdXJw?=
 =?utf-8?B?a1BDN0Y1VGpKSE1ZRHVBVGExdkNNanh5N0dleElxQUtTMFdyU2JwYXYxYzRU?=
 =?utf-8?B?WEl2MDZ1WnhGQWV1MEdtbWg0eFVueFkxek1QWXdydFcrZ3RTWXNrY3NTWVY2?=
 =?utf-8?B?Zk9TakpyblFpeEVTRDY2VzRoKys5TVkvaGVGY29SQ2JvV25MNFlwZkFoSnho?=
 =?utf-8?B?T1NnSWpuUnFVVXBsa3p2b0VGY3RQZHpndWE5eDZjc2MxZnpQd3QvTEZTUkxP?=
 =?utf-8?B?dFhneU12eVpRdGZEWTdVWFpkRGJ6azNaeTI0N203M0pUbS9lWGt0bitPUFAy?=
 =?utf-8?B?T01zSzdJeVBRNW5hTUluSzQwQ3NmNEV1L1FseHdJMXAvZlVoZ1pUMU0yN1Nt?=
 =?utf-8?B?QXNJMHpmeU80YlF4RWZLaU9udDN3QUY1VXV6Y252enRHVlpmR3ZOMzdQb0Na?=
 =?utf-8?B?U3hOOGZrY0hjN3kxMzB5cEFWaEk1NG9PQURFQXNWa2VHR2tibElTZ3FXTHp4?=
 =?utf-8?B?N2p1MklPaUI4dHc1QjMyb2FBVUp4aEx0SkpkeWZ6TkxMVUQ3YzRObVV3MCtY?=
 =?utf-8?B?NkRlQWpMM2huZ2N0QndrRzViTG1lZ0paZm41d1FlNkhHU2xISUlQcmM5SEpT?=
 =?utf-8?B?SWxRNjlZMTg0RklBRnVLMVkvcUM2Uk96Zmt0TmRBSER1cUZzMkdqdXIyQ1dK?=
 =?utf-8?B?N28rOEh2Y0p6R01vNFFYMDNZQmE2R3J6Rmp3S1FiUzJnVDh0Wm5VTFBJUHJj?=
 =?utf-8?B?d3p1SlBkUFlTNTNDYmZ6anU4Vk9Gd2V2aUdUVDNEQzFZV1JSQTJPMjRVUVNw?=
 =?utf-8?B?NnpUMGp6WTFjVmp0bGhzbFpVR1NUb3VkSTE4bW1waENTcDYxYVk1L0t3OEhh?=
 =?utf-8?B?ZEh1elF0eVNzM3EzblZpVlFJS1hQSU9GVytqb0RXaDF1b1RJWEtwdjArTWxs?=
 =?utf-8?B?aXEvS3FKTFBaMEpreVA5RmxZajBrSFFyMmg3Y3BraGhRb1M1MTRFOFVFTnJ2?=
 =?utf-8?B?QTA3UDE3d05INjdUaFl2dGErSDUrUkkxS3RjUURqaTlSNDJWcHJMMUhDRmp6?=
 =?utf-8?B?eUdnN2g5WVRaSS95bldETmJ6ZFZ2NEJVNUpKYjlWOFN3QnhPbjVEMmd1ZVBJ?=
 =?utf-8?B?ZWJ5VU9pKzZqbXhXdzl5bnZmM0ovb0lxWHhub1ZwenM3NmMwMlhNNVdOUmFU?=
 =?utf-8?Q?ebXHWkqCVLyjedLxydBkWfk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47389fe6-00a7-4272-55a9-08d997e3c336
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 18:17:53.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sInpPVrRaLanGyWiP2nwrA6lDTgU8JNBdpu7COUThHaVvnSpi3M7cO4Yj62zg1cIm/AWNALnLNM3kYWc576qNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/21 7:49 PM, Sean Anderson wrote:
> This adds a driver to control GPIO-based resets using the reset
> controller API. This allows using a common interface for devices which
> may have both GPIO resets and reset controllers, depending on the
> configuration. It also allows for easier sharing of reset GPIOs in the
> case where one GPIO is a reset for multiple devices.
> 
> There are several properties for specifying pre/post-(de)assert delays.
> This device can also use a "reset done" GPIO, for cases when such a GPIO
> is provided by the device being reset. This can be useful when the
> datasheet does not otherwise specify reset timings, or specifies a much
> longer maximum reset delay than the typical delay.
> 
> There is one queue for waiters on done GPIOs. I don't anticipate there
> being a penalty from this, since there will likely only be concurrent
> waiters during startup. I believe that wait_event_idle_timeout is the
> correct function to use here, but there are a lot of variants of this
> function, so I am not completely sure it is the best.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>   MAINTAINERS                |   5 +
>   drivers/reset/Kconfig      |  11 ++
>   drivers/reset/Makefile     |   1 +
>   drivers/reset/reset-gpio.c | 223 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 240 insertions(+)
>   create mode 100644 drivers/reset/reset-gpio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d118d7957d2..0a54c4dd83d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7813,6 +7813,11 @@ F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
>   F:	drivers/i2c/muxes/i2c-mux-gpio.c
>   F:	include/linux/platform_data/i2c-mux-gpio.h
>   
> +GENERIC GPIO RESET DRIVER
> +M:	Sean Anderson <seanga2@gmail.com>
> +S:	Supported
> +F:	drivers/reset/reset-gpio.c
> +
>   GENERIC HDLC (WAN) DRIVERS
>   M:	Krzysztof Halasa <khc@pm.waw.pl>
>   S:	Maintained
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index be799a5abf8a..24888005baf8 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,17 @@ config RESET_BRCMSTB_RESCAL
>   	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>   	  BCM7216.
>   
> +config RESET_GPIO
> +	tristate "GPIO reset controller"
> +	depends on OF
> +	help
> +	  This enables a generic controller for resets attached via GPIOs. It
> +	  may be used to add GPIO resets to drivers which expect a reset
> +	  controller. It supports adding delays and waiting for a "done" GPIO
> +	  to be asserted.
> +
> +	  If compiled as module, it will be called reset-gpio.
> +
>   config RESET_HSDK
>   	bool "Synopsys HSDK Reset Driver"
>   	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 21d46d8869ff..f577ec16fd93 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>   obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>   obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>   obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
>   obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>   obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>   obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
> new file mode 100644
> index 000000000000..93d3dbb150e0
> --- /dev/null
> +++ b/drivers/reset/reset-gpio.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * This driver controls GPIOs used to reset device(s). It may be used for when
> + * there is a need for more complex behavior than a simple reset-gpios
> + * property. It may also be used to unify code paths between device-based and
> + * gpio-based resets.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +
> +/**
> + * struct reset_gpio_priv - Private data for GPIO reset driver
> + * @rc: Reset controller for this driver
> + * @done_queue: Queue to wait for changes on done GPIOs. Events occur whenever
> + *              the value of any done GPIO changes. Valid only when @done is
> + *              non-%NULL.
> + * @reset: Array of gpios to use when (de)asserting resets
> + * @done: Array of gpios to determine whether a reset has finished; may be
> + *        %NULL
> + * @done_timeout_jiffies: Timeout when waiting for a done GPIO to be asserted, in jiffies
> + * @post_assert_delay: Time to wait after asserting a reset, in us
> + * @post_deassert_delay: Time to wait after deasserting a reset, in us
> + */
> +struct reset_gpio_priv {
> +	struct reset_controller_dev rc;
> +	struct wait_queue_head done_queue;
> +	struct gpio_descs *reset;
> +	struct gpio_descs *done;
> +	unsigned long done_timeout_jiffies;
> +	u32 pre_assert_delay;
> +	u32 post_assert_delay;
> +	u32 pre_deassert_delay;
> +	u32 post_deassert_delay;
> +};
> +
> +static inline struct reset_gpio_priv
> +*rc_to_reset_gpio(struct reset_controller_dev *rc)
> +{
> +	return container_of(rc, struct reset_gpio_priv, rc);
> +}
> +
> +static int reset_gpio_assert(struct reset_controller_dev *rc, unsigned long id)
> +{
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	if (priv->pre_assert_delay)
> +		fsleep(priv->pre_assert_delay);
> +	gpiod_set_value_cansleep(priv->reset->desc[id], 1);
> +	if (priv->post_assert_delay)
> +		fsleep(priv->post_assert_delay);
> +	return 0;
> +}
> +
> +static int reset_gpio_deassert(struct reset_controller_dev *rc,
> +			       unsigned long id)
> +{
> +	int ret = 0;
> +	unsigned int remaining;
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	if (priv->pre_deassert_delay)
> +		fsleep(priv->pre_deassert_delay);
> +	gpiod_set_value_cansleep(priv->reset->desc[id], 0);
> +	if (priv->post_deassert_delay)
> +		fsleep(priv->post_deassert_delay);
> +
> +	if (!priv->done)
> +		return 0;
> +
> +	remaining = wait_event_idle_timeout(
> +		priv->done_queue,
> +		(ret = gpiod_get_value_cansleep(priv->done->desc[id])),
> +		priv->done_timeout_jiffies);
> +	dev_dbg(rc->dev, "%s: remaining=%u\n", __func__, remaining);
> +	if (ret < 0)
> +		return ret;
> +	if (ret)
> +		return 0;
> +	return -ETIMEDOUT;
> +}
> +
> +static int reset_gpio_reset(struct reset_controller_dev *rc, unsigned long id)
> +{
> +	int ret = reset_gpio_assert(rc, id);
> +
> +	if (!ret)
> +		return ret;
> +
> +	return reset_gpio_deassert(rc, id);
> +}
> +
> +static int reset_gpio_status(struct reset_controller_dev *rc, unsigned long id)
> +{
> +	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
> +
> +	return gpiod_get_value_cansleep(priv->reset->desc[id]);
> +}
> +
> +static const struct reset_control_ops reset_gpio_ops = {
> +	.reset = reset_gpio_reset,
> +	.assert = reset_gpio_assert,
> +	.deassert = reset_gpio_deassert,
> +	.status = reset_gpio_status,
> +};
> +
> +static irqreturn_t reset_gpio_irq(int irq, void *data)
> +{
> +	struct reset_gpio_priv *priv = data;
> +
> +	wake_up(&priv->done_queue);
> +	return IRQ_HANDLED;
> +}
> +
> +static int reset_gpio_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct reset_gpio_priv *priv;
> +	u32 done_timeout_us;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* A short macro to reduce repetitive error handling */
> +#define read_delay(propname, val) do { \
> +	ret = of_property_read_u32(dev->of_node, (propname), &(val)); \
> +	if (ret == -EINVAL) \
> +		(val) = 0; \
> +	else if (ret) \
> +		return dev_err_probe(dev, ret, \
> +				     "Could not read %s\n", propname); \
> +} while (0)
> +
> +	read_delay("pre-assert-us", priv->pre_assert_delay);
> +	read_delay("post-assert-us", priv->post_assert_delay);
> +	read_delay("pre-deassert-us", priv->pre_deassert_delay);
> +	read_delay("post-deassert-us", priv->post_deassert_delay);
> +
> +	ret = of_property_read_u32(np, "done-timeout-us", &done_timeout_us);
> +	if (ret == -EINVAL) {
> +		if (priv->post_deassert_delay)
> +			done_timeout_us = 10 * priv->post_deassert_delay;
> +		else
> +			done_timeout_us = 1000;
> +	} else if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not read done timeout\n");
> +	priv->done_timeout_jiffies = usecs_to_jiffies(done_timeout_us);
> +
> +	priv->reset = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Could not get reset gpios\n");
> +
> +	priv->done = devm_gpiod_get_array_optional(dev, "done",
> +						   GPIOD_IN);
> +	if (IS_ERR(priv->done))
> +		return dev_err_probe(dev, PTR_ERR(priv->done),
> +				     "Could not get done gpios\n");
> +	if (priv->done) {
> +		int i;
> +
> +		if (priv->reset->ndescs != priv->done->ndescs)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Number of reset and done gpios does not match\n");
> +		init_waitqueue_head(&priv->done_queue);
> +		for (i = 0; i < priv->done->ndescs; i++) {
> +			ret = gpiod_to_irq(priv->done->desc[i]);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "Could not convert GPIO to IRQ\n");
> +
> +			ret = devm_request_irq(dev, ret, reset_gpio_irq,
> +					       IRQF_SHARED, dev_name(dev),
> +					       priv);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Could not request IRQ\n");
> +		}
> +	}
> +
> +	priv->rc.ops = &reset_gpio_ops;
> +	priv->rc.owner = THIS_MODULE;
> +	priv->rc.dev = dev;
> +	priv->rc.of_node = np;
> +	priv->rc.nr_resets = priv->reset->ndescs;
> +	ret = devm_reset_controller_register(dev, &priv->rc);
> +	if (!ret)
> +		dev_info(dev, "probed with %u resets\n", priv->reset->ndescs);
> +	return ret;
> +}
> +
> +static const struct of_device_id reset_gpio_of_match[] = {
> +	{ .compatible = "gpio-reset", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, reset_gpio_of_match);
> +
> +static struct platform_driver reset_gpio_driver = {
> +	.probe = reset_gpio_probe,
> +	.driver = {
> +		.name = "gpio-reset",
> +		.of_match_table = of_match_ptr(reset_gpio_of_match),
> +	},
> +};
> +module_platform_driver(reset_gpio_driver);
> +
> +MODULE_ALIAS("platform:gpio-reset");
> +MODULE_DESCRIPTION("Generic GPIO reset driver");
> +MODULE_LICENSE("GPL v2");
> 

ping?

Philipp, should I be CCing anyone else? MAINTAINERS only lists you and vger...

--Sean
