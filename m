Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC44445FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhKCQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:36:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:58166 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhKCQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635957244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilFhKLK7irkRE+PfhRgibjE7Zsl3QoMXM4CQ9fmf7oE=;
        b=dVH54fyvKeQOGhscHec5vbM0/ME3pMV+naWv9FgQwhTHuzp4D0NRXqkcieBTHJ1LSYeTGR
        pJV5MgoI9LgCjzNbD8eJvCiXjAOfVwg2RxNRcOb4tDiq6TmRhIjFwdzBbyO6CaW/QDDMAz
        MKgdzPfIHNoDFs1wgIgHVfKR/pYu7as=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-H3tF7HQKNoqB9zOI0w2C1g-1; Wed, 03 Nov 2021 17:34:03 +0100
X-MC-Unique: H3tF7HQKNoqB9zOI0w2C1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASM85MBcv9KWmr6n0HvMw8SjyWmcbHl5JHzktfInQp4Yy+GfZSzY2R4Y5V7rjQGfJxUIWK0Leupys6zs/55/t8+LRmAdpGL6NO7hBUsEsHFWeCJyfE/stRGSYm+0QoMe0IZMVpEWKcdUiMMDveeiFwQm9tutALubwxF/C3C0JPcXjk6MuvHFSj8AjTeA2zqVnS0yBF2VhgzAKbTM+7+nhcs7ZJuqwEwUkEY1JsuJT1x9P78m/mMKcjboA6M/mU/l12/7X/ZxNt4J9xHLTCWMb/v3h9+KRU2KlLAuta1HUS33M5Cn1EcnFnzf0swzk+ls/xhFccmcTxYdfeBlZn73XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilFhKLK7irkRE+PfhRgibjE7Zsl3QoMXM4CQ9fmf7oE=;
 b=ODdGhonEm7adRNBGlb/iuRXIUpGRoBZrYZLV//hh1xcJOadG/zr4Ehs9SbnVhKhCdoJ3SFHf+PJFms78jhXV5CywREZFUdidf7XrOE3CPV6y0gU1sX8Dz8zQI95zxnafE+vyY2apNvEmvWTcUJB9xwUVRoOQCLYesRLDRkQg5jIMJbcb+q4smZiskhqbcmzwiQ2ylQbCxqzuFJvxAdl5rn9ciW9E+G+85yeR5ZHEEJ6Wa9xwj0JWa0wUdSTvJrJtcongnumplTsL4WC+RTyD+Oa9nwxs2TwFBMFhQgzQbisakpB+ynab09+OB3SyKYob6ajiKE0RWGeBAs7hjUo79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB6679.eurprd04.prod.outlook.com (2603:10a6:20b:d9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 16:34:02 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::b81e:116f:90fa:1b9c]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::b81e:116f:90fa:1b9c%3]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 16:34:02 +0000
Message-ID: <d3de34d9-a144-f955-bd41-13384c9a04c8@suse.com>
Date:   Wed, 3 Nov 2021 17:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
 <20211029215516.801593-2-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/5] drivers/mfd: sensehat: Raspberry Pi Sense HAT core
 driver
In-Reply-To: <20211029215516.801593-2-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0081.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::22) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
Received: from [192.168.0.18] (188.86.219.160) by AM6P193CA0081.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 16:34:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b96c91cb-7a90-49de-ada7-08d99ee7be64
X-MS-TrafficTypeDiagnostic: AM6PR04MB6679:
X-Microsoft-Antispam-PRVS: <AM6PR04MB667946247A020F70138AEA24BA8C9@AM6PR04MB6679.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELNF7SyuUVkM1ybLmKb2ytcUQpyQ654k0hfAJlKSnp24AlUHVVZO7lVVSXLrXOme6a5lqJLmyAivAaQ9IPD5a5yQcd7Q8pLflQVP7LmWjGc7xSqciS68fG7qscZpM8vu9mKtsOGJmufhhB9X5I4VRRCrlx53vhhtZnJezW2sMOlsP3USLP3imM0PFLxqMuAcoYMKSL91toDTJKeVKSMlqDDwKYHwBMZcL5uHd/xh5jhvQ7GrXNld/7J0LpGuKpXTl8GCQu1MmlPUyJtsNzSv+R8Tcm7f6/1ajiR8klzlUPNSDVe5iYS6+RF+7KVLtSJbPPQNgEN28yq3HC1peAWy5ium5PbJGkRpgG1jZKc8X0sx9qYTTQRNXk/6c8cLzwUXh2uQaedIxDOMkKV64DyaUIpbsrIiUreabTp8AaFzHBd0RnIiXYXiJf9Nnq3+qNzxCoGnpFXjI8CIo+tmMQJ4BxFnoWgvFtiU7tVmya1yY3brCJhuaiPHjTUmKrkWPD/7gkMtkavATGdCqC7fkr6/koz6R0mpoNxoGhQNUCgRYI3Z6Av1EIbUxnsE+wul6fXfmESlRWv4KcZbaojcKXrUQ3fSjqcqAXCj+ObnuY49yM5V1gBk2pyaY2W2vaHvIiv1UUzUSVsfjvchbPRC8NQsTzFb+c/xWwGN3YXsRfFaqwsIMq8WNqKSChZxONSEExC4EshVq8dpR0rd9lKMc9yD0YV7U4LJ/VfiH4QsFToD7/2BMPo1/xKaQQhEttNhDaM4gBmwjquGcznzF/9myWNlTZfs3CBt5njf+dapU4wJa/QghLZU6dZOYTJX9cKVdX1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(508600001)(8936002)(66476007)(5660300002)(8676002)(4326008)(31686004)(66556008)(53546011)(7416002)(38100700002)(26005)(36756003)(956004)(86362001)(6486002)(31696002)(54906003)(55236004)(2906002)(966005)(16576012)(316002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdOL0NtRzFoVXlHR0p0SEVCdGFHTXFPZndjTmppbXBUcExLdXJ2ZFNrNFZY?=
 =?utf-8?B?Uy9RSEpuMlMwYkFUQ3h2OWJ1a3g0RDl0bE4xeFlBakJBQXRMNkpoTWxBbDRm?=
 =?utf-8?B?VzZSQnlUcllCRjUxbW5KR1J3YzBLOGxBQzc4MHpkb21jQW1oWU0rUncyMThm?=
 =?utf-8?B?UXVjRUdsSktoK1JMNmQvMFVwS0MvQ2xiTHROOGMvZ2RrOXlGQ2RXVVZkUEYv?=
 =?utf-8?B?a0VrY2R4dmlIckxxRTZ3Z2xkZXpMaVByWWtyZm9RTzRpUGtwM1g5QjA2R1dn?=
 =?utf-8?B?VkhCRzVMTEpJc0NUeHFXY2VrYU50RWJuM3MxUnV6aWZJSHMzcFdBRXdZcG5D?=
 =?utf-8?B?OXkzNmJXc3N6SGdwbWh2WnV5VXphRVpzcVAxV0ROUWMySWgyMDdQajMzM3B0?=
 =?utf-8?B?OHZJMXA4RDN1eDlHQm1ZT0dvSGdvN1BxQ2pIbERmc0dxWWNLMVRDODdEVlVU?=
 =?utf-8?B?UXFxNEZ4NmRVODRFTUZHQ2ZhMEQ1L3doNkRjR0VacGY4ZDVndCtuSktWdUhm?=
 =?utf-8?B?bk40VmRQTEhaUWtnSEtUV1d4RFVzUC8zOEprcXZTYVVHV2FVMWxnWXdvTkJ2?=
 =?utf-8?B?WVpvNEhqTENpRlR6MEdQblA4SXhlY3QvbmVvM2RqNEwyWDl6S1A2UkRNVGVS?=
 =?utf-8?B?YWtLT1R0OE1nZFpPWnpkNU1MTitxeU1zQ3RTUjRIQThTdzZMS2k1MmJPQzdj?=
 =?utf-8?B?SUxRSWhtR0lNMk9NSFNWZFJGMlpZblBEbnJ4Ulgzd1B2YUFpeFhNeDNTRjJY?=
 =?utf-8?B?OStSTzN1MFRZUDBLb3RCNXJSNmxOUngwWFNXZ1NUT1p1dkdXM0lSTlRpUU95?=
 =?utf-8?B?WU5id2ExZWJOaTUxMVJtZjdQYnVIN2I0YWJ0a3V2S3Bzd2tvM0s1YStrM2xX?=
 =?utf-8?B?RG5RZlRNeDhkS3hnMTJOT0FGbjF2THVHbFJIRHVqL0k2dERTRFk4RG9IcjYx?=
 =?utf-8?B?Wm1EQjQ4K0s3MWczMUhqdXVLT3Z5eW01VllXektjZDZZb3M0UXdzNUllU0wz?=
 =?utf-8?B?eVhnMXRQK0NJZFJtSWUxaGlmU2xzVktxMHdNTWF1STBkUmRsbWM5d21uMHNY?=
 =?utf-8?B?NTNmbHdzVlhXU1QxeXBuaWJZYkg0MTQweWlFOEJ6czVFa2lld1ZGcG8xM2NW?=
 =?utf-8?B?M0pGTENaTzBycTByTlkzbm5iVmJwRlNmb2xSNForS3hIK3kzOXUzMytxR0VO?=
 =?utf-8?B?dlJDeUM4ZWF5cDNoTFhaN25VVmtNeThhT1VwMDdnTDlQYnkybkQwYm92R09V?=
 =?utf-8?B?cHpYWTVaNllJN21LTXpma0ZQWUpGVFFzY28yMDBObUhvQzFTRE1ueXhYWjEy?=
 =?utf-8?B?aGVuQ3VHSkp2SkRLWkIxRFNMUEsxc3Z6QVZ2SVJROTBwSk9jd2R1TGozZFI1?=
 =?utf-8?B?VnRLRFFFQU52eXpReTB5eEpjeXZxVDl0OFM2d01ab1pwNzNoRWFaYmFEdWhh?=
 =?utf-8?B?Rjg0azJoSHpFZzJhYjduaUp5YVMydlNJM1ZkV24zTTR0c01qaWkrbGtXTGRP?=
 =?utf-8?B?K0s2MWNJSDFlcytGQ2xjNmRsRzZzeE9hNm1LOW0zaXJtNzVQZ1NxN0JjOHhY?=
 =?utf-8?B?eU1WUTdsR2NOVm8wVlVza21UaTBiSHN4ZlVxOXZRM2Y5ZGpSckhwcHlIUFRw?=
 =?utf-8?B?bGNidE1XMzZDNU5mZjh1QXhlOWRKSkNGU3Vjb2pmZmg4RDlySDZGZkdXMTBJ?=
 =?utf-8?B?b1BRRjM5czJkM3Q1ZGo5Sm1xS3J4dFU0NW9Yd1drdVJXWWUvcW50RkJ2Mkgz?=
 =?utf-8?B?M1Z5YTZiTmJ5Q0I2UlVEWElVblNqelhXU1VjRVMvbVMyM09NZTVlVlpOTFEz?=
 =?utf-8?B?bmJLZURxa040Mm9VNThWbDA5azkzQ3BpdUFHd0FkRXA5WklJMFJJb0h4QTBI?=
 =?utf-8?B?TWdPVVZKVU9rT2x3d3E0eUFoMDdtQnlSM0Q1ZkJqWWRQQmk4VTBOeWtEVHBO?=
 =?utf-8?B?MHV0dUM5MmZLajc4MklGR2JiM0IyTzJ5WDZsYzQ3akl2YTB2S0RPV0RUaWZy?=
 =?utf-8?B?dGJ5NzhVRlRjY0t3YUVHL1FaQmZ4cGYvSlFGckUxNlpqTDI5MUVObjJPYkJh?=
 =?utf-8?B?QllDM2ZPNVorM0ExUjB6MFNydndmL0pwc1llK1hFelBiSmFEdEs1YnB4K0hM?=
 =?utf-8?B?a2puYjMxQTNoajJYYVZtRDdGTXMzWnV2Q3dSOC9lNi9yM0FHR01CMlMzVXk5?=
 =?utf-8?Q?yPsHJ35ad/H0xszEj21R4vc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96c91cb-7a90-49de-ada7-08d99ee7be64
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 16:34:01.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAb0Cgu+rEEBhMA76vMAprSrfw4FZo4RTc9bBViJCbehC5MOK8vKalPqQwBO4iGvDB9MSBO0RWLfNIcUJIVoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2021 23:55, Charles Mirabile wrote:
> This patch adds the core driver file, containing the regmap configuration
> needed to communicate with the board over I2C. We also add the header
> file shared by all three drivers, containing common data and definitions.
> In addition, we add a config option to toggle compilation of the driver.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   drivers/mfd/Kconfig          |   8 ++
>   drivers/mfd/Makefile         |   1 +
>   drivers/mfd/sensehat-core.c  | 164 +++++++++++++++++++++++++++++++++++
>   include/linux/mfd/sensehat.h |  64 ++++++++++++++
>   4 files changed, 237 insertions(+)
>   create mode 100644 drivers/mfd/sensehat-core.c
>   create mode 100644 include/linux/mfd/sensehat.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ca0edab91aeb..297ab2143ced 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -11,6 +11,14 @@ config MFD_CORE
>   	select IRQ_DOMAIN
>   	default n
>   
> +config MFD_SENSEHAT_CORE
> +	tristate "Raspberry Pi Sense HAT core functions"
> +	depends on I2C
> +	select MFD_CORE
> +	help
> +	  This is the core driver for the Raspberry Pi Sense HAT. This provides
> +	  the necessary functions to communicate with the hardware.
> +
>   config MFD_CS5535
>   	tristate "AMD CS5535 and CS5536 southbridge core functions"
>   	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2ba6646e874c..7347a040a4ac 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>   obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
>   obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>   obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> +obj-$(CONFIG_MFD_SENSEHAT_CORE) += sensehat-core.o
>   obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>   obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>   
> diff --git a/drivers/mfd/sensehat-core.c b/drivers/mfd/sensehat-core.c
> new file mode 100644
> index 000000000000..fb6c89510ec0
> --- /dev/null
> +++ b/drivers/mfd/sensehat-core.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT core driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * This driver is based on wm8350 implementation and was refactored to use the
> + * misc device subsystem rather than the deprecated framebuffer subsystem.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include "sensehat.h"
> +
> +static struct platform_device *
> +sensehat_client_dev_register(struct sensehat *sensehat, const char *name);
> +
> +static struct regmap_config sensehat_config;
> +
> +static int sensehat_probe(struct i2c_client *i2c,
> +			       const struct i2c_device_id *id)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	struct sensehat *sensehat = devm_kzalloc(&i2c->dev, sizeof(*sensehat), GFP_KERNEL);
> +
> +	if (!sensehat)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, sensehat);
> +	sensehat->dev = &i2c->dev;
> +	sensehat->i2c_client = i2c;
> +
> +	sensehat->regmap = devm_regmap_init_i2c(sensehat->i2c_client, &sensehat_config);
> +
> +	if (IS_ERR(sensehat->regmap)) {
> +		dev_err(sensehat->dev, "Failed to initialize sensehat regmap");
> +		return PTR_ERR(sensehat->regmap);
> +	}
> +
> +
> +	ret = regmap_read(sensehat->regmap, SENSEHAT_WAI, &reg);
> +	if (ret < 0) {
> +		dev_err(sensehat->dev, "failed to read from device");
> +		return ret;
> +	}
> +
> +	if (reg != SENSEHAT_ID) {
> +		dev_err(sensehat->dev, "expected device ID %i, got %i",
> +			SENSEHAT_ID, ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(sensehat->regmap, SENSEHAT_VER, &reg);
> +	if (ret < 0) {
> +		dev_err(sensehat->dev, "Unable to get sensehat firmware version");
> +		return ret;
> +	}
> +
> +	dev_info(sensehat->dev,
> +		 "Raspberry Pi Sense HAT firmware version %i\n", reg);
> +
> +	sensehat->joystick.pdev = sensehat_client_dev_register(sensehat,
> +							       "sensehat-joystick");

Why don't you use devm_mfd_add_devices function together with mfd_cell?

> +
> +	if (IS_ERR(sensehat->joystick.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-joystick");
> +		return PTR_ERR(sensehat->joystick.pdev);
> +	}
> +
> +	sensehat->display.pdev = sensehat_client_dev_register(sensehat,
> +								  "sensehat-display");
> +
> +	if (IS_ERR(sensehat->display.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-display");
> +		return PTR_ERR(sensehat->display.pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_device *
> +sensehat_client_dev_register(struct sensehat *sensehat, const char *name)
> +{
> +	long ret = -ENOMEM;
> +	struct platform_device *pdev = platform_device_alloc(name, -1);
> +
> +	if (!pdev)
> +		goto alloc_fail;
> +
> +	pdev->dev.parent = sensehat->dev;
> +	platform_set_drvdata(pdev, sensehat);
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto add_fail;
> +
> +	ret = devm_add_action_or_reset(sensehat->dev,
> +		(void *)platform_device_unregister, pdev);
> +	if (ret)
> +		goto alloc_fail;
> +
> +	return pdev;
> +
> +add_fail:
> +	platform_device_put(pdev);
> +alloc_fail:
> +	return ERR_PTR(ret);
> +}
> +
> +static bool sensehat_writeable_register(struct device *dev, unsigned int reg)
> +{
> +	return (reg >= SENSEHAT_DISPLAY &&
> +		reg < SENSEHAT_DISPLAY + sizeof(sensehat_fb_t))
> +		|| reg == SENSEHAT_EE_WP;
> +}
> +static bool sensehat_readable_register(struct device *dev, unsigned int reg)
> +{
> +	return (reg >= SENSEHAT_DISPLAY &&
> +		reg < SENSEHAT_DISPLAY + sizeof(sensehat_fb_t))
> +		|| reg == SENSEHAT_WAI || reg == SENSEHAT_VER
> +		|| reg == SENSEHAT_KEYS || reg == SENSEHAT_EE_WP;
> +}

I wonder if we really need this. In the end this is tied to in kernel drivers. 
AFAIKS no userspace process can read. Without this we could move senhat_fb_t 
into the display driver as it's local to that driver.

> +
> +static struct regmap_config sensehat_config = {
> +	.name = "sensehat",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.writeable_reg = sensehat_writeable_register,
> +	.readable_reg = sensehat_readable_register,
> +};
> +
> +static const struct i2c_device_id sensehat_i2c_id[] = {
> +	{ "sensehat", 0 },
> +	{ "rpi-sense", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sensehat_i2c_id);
> +
> +static struct i2c_driver sensehat_driver = {
> +	.driver = {
> +		   .name = "sensehat",
> +	},
> +	.probe = sensehat_probe,
> +	.id_table = sensehat_i2c_id,
> +};
> +
> +module_i2c_driver(sensehat_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT core driver");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/sensehat.h b/include/linux/mfd/sensehat.h
> new file mode 100644
> index 000000000000..7e2e97a43f90
> --- /dev/null
> +++ b/include/linux/mfd/sensehat.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Raspberry Pi Sense HAT core driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + */
> +
> +#ifndef __LINUX_MFD_SENSEHAT_H_
> +#define __LINUX_MFD_SENSEHAT_H_
> +#include <linux/miscdevice.h>
> +
> +//8x8 display with 3 color channels
> +typedef u8 sensehat_fb_t[8][3][8];

I'm not a great fan of typedefs. AFAIK they are rarely used in kernel code.

> +
> +#define SENSEHAT_DISPLAY		0x00
> +#define SENSEHAT_WAI			0xF0
> +#define SENSEHAT_VER			0xF1
> +#define SENSEHAT_KEYS			0xF2
> +#define SENSEHAT_EE_WP			0xF3
> +
> +#define SENSEHAT_ID			's'
> +
> +#define SENSEDISP_IOC_MAGIC 0xF1
> +
> +#define SENSEDISP_IOGET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 0)
> +#define SENSEDISP_IOSET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 1)
> +#define SENSEDISP_IORESET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 2)
> +
> +struct sensehat {
> +	struct device *dev;
> +	struct i2c_client *i2c_client;
> +	struct regmap *regmap;
> +
> +	/* Client devices */
> +	struct sensehat_joystick {
> +		struct platform_device *pdev;
> +		struct input_dev *keys_dev;
> +		struct gpio_desc *keys_desc;
> +		int keys_irq;
> +	} joystick;
> +
> +	struct sensehat_display {
> +		struct platform_device *pdev;
> +		struct miscdevice mdev;
> +		struct mutex rw_mtx;
> +		u8 gamma[32];
> +		struct {
> +			u16 b:5, u:1, g:5, r:5;
> +		} vmem[8][8];
> +	} display;
> +};
> +
> +enum gamma_preset {
> +	GAMMA_DEFAULT = 0,
> +	GAMMA_LOWLIGHT,
> +	GAMMA_PRESET_COUNT,
> +};

Please review, which of this defines really need to be in the header and can't 
be just local to the corresponding driver.

Apart from that, I'd appreciate if you could add me in CC in the next version of 
this patches. I also wonder why you didn't CC arm-linux-kernel mailinglist, in 
the end this is a board for RPi and hence Arm.

Regards,
Matthias

> +
> +#endif
> 

