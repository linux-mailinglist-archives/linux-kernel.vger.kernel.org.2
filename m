Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A318458CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhKVLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:06:14 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:8416
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230322AbhKVLGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:06:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U01xiByAO1HZoiuKgjvy0UQs0zzha8suaAUXmWKIZo43FfwtYWqzdp4yJlBfAGHX2e1e/axKXHeNPcEsWuj6cBJjKmdUGeMTUO++nH2ZyWauBgT2kIcmlznpSxJ6kwx41NRAlMq/E2Hy17c5/826Dy7MkTQX8xLhvMkwD5KSGqHE0xwq3aUtoNaqFB8B4RrWir4M3tpOrBR8Qn8Z8MBf6B1E9D5sM2N8Dbl7Phv79gtLCgbUJePeSENJz9cA5VGUsicFwHvu25aSca8GMZKiKuPOZKfpQ+MnNw9bPextcSJgB5AADALPJmWMtbhdIXeHWBzwvGoTyhtE248ylHwWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O+hYlKKyHnAuygqyhnpR2XICxJO1FBCOtprRcSgwW4=;
 b=eDTpy1tmwmhAuoWCscchp6m/1xXwElzOwmocDD+/gppy168uMguWpupxOZTHbngwWN2QjmTiGkVMK3XozRrRfqfVhqsXIayuSesjHppzVZA1FDDfs8Hcw53S+ImVGVK6P5FQLPncXNByGvRDInq/ORMmQqHUnhgkp/ITvCy8itaMC24LFcc278zxAxErXG52/WhWZzvqX3V97aBrvkjoqg2WX9UVzgQ3N90pbUztordGLG29GHlfiJRYIzAuBGsiGKJ0Dh8grrnFv8yfBNWRIlfQRVZ/sDHAP9VQ5Zom3BhtMlNOxJoRE7XOKf8s6omsdPPLKppBGfSdX/uDBg+gVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O+hYlKKyHnAuygqyhnpR2XICxJO1FBCOtprRcSgwW4=;
 b=BldZxfm2Mxj3a0gQnZyh5cyF8LE8kvMbiL1tVylhLx5pVJd1XfMqHmLMIabMiaA658KE6UD1WmCT0BZkAcsVX7ciwtIqA/RPr7kowJ4QWuTAYaBYKQhEXUEAkWN3Yrhi7mmnaABBrpkfnzJbW7zf/Py8Wd/mRxDNCQYbOFyPgzs=
Received: from BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::31)
 by CH0PR02MB7993.namprd02.prod.outlook.com (2603:10b6:610:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 11:02:58 +0000
Received: from BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::e8) by BN9P222CA0026.outlook.office365.com
 (2603:10b6:408:10c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Mon, 22 Nov 2021 11:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT050.mail.protection.outlook.com (10.13.2.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 11:02:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 22 Nov 2021 03:02:56 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 22 Nov 2021 03:02:56 -0800
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=34734)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mp768-000ATX-BK; Mon, 22 Nov 2021 03:02:56 -0800
Message-ID: <b4064914-40b5-3789-bebd-793cb27a29cd@xilinx.com>
Date:   Mon, 22 Nov 2021 12:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 2/2] usb: misc: usb244: add support for USB2 ultra fast
 sd controller
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>
CC:     <robh+dt@kernel.org>, <mka@chromium.org>,
        <ravisadineni@chromium.org>, <stern@rowland.harvard.edu>,
        <alcooperx@gmail.com>, <michal.simek@xilinx.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
 <20211122062834.1812005-3-piyush.mehta@xilinx.com>
 <YZtAb9lz8WLnWu7E@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YZtAb9lz8WLnWu7E@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0c3d3a7-df9e-49f9-1d4b-08d9ada7a4b5
X-MS-TrafficTypeDiagnostic: CH0PR02MB7993:
X-Microsoft-Antispam-PRVS: <CH0PR02MB7993EE37279FDD0E7DBD84DFC69F9@CH0PR02MB7993.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I51k369x0zZphCwrqEpQm20fTt6RdKLdvxJLVQb9TU2gUvoSuVIHovy61KMr2VuO5nDAW3oGjgTyhhEO+zy/IFHfbTE7Axbgp5FBUMnZ3GcorRUjw3QT10ZJUS15uIpwt2qqrNNTVyMIdliGhI5tRRts2fSwvm3bCPL5pc7T3HUbVqHNvq2A+UvByQ3A57hZcttiBY5F0x1xnennYWElmtC5OGSx4IbZfzLuzFpL8GHMmMVCwiSm4HKqNCw5FH41e/ItkT9+zQPppWSVAOP8I8CS/CjK8XbbbZNF8PuvWIZDct0ucYiP0R80QzzuSIZValTgQhb2E5z61DEUSnfL1Iv6kSMKhHzucW3kca7lcafb5rd9Hz4hog8z4k75f8zCUfofWdKNdjG4KleD5fidI/rMMsFSgG8L53a4sIAIVTyDc2NlFaXbm4vompT1HTrASq7jq2W2Qil48JPu2oXvtfNfhM8kTPBYFv19joCxoQ3Hxm6T4ov7VR5FLMq9Rx6WtAEppNG3cvdM0dVQfYFON75spMzBsr3WtC2ps40vFSjmSMU3nWmEXSRcXYmRr3kczJ1VWGpP1oVYClOJIP75TyOOrCvOlxkGegnJ26qDdrvujWfg8ER7L/ldet5JckuDbufXyZpfJz6HBOXVlRsCTD49qfjhmj65ePYauwc5drlLM8McUmDPz+QdqYPrGE15uarTKoN7biR01wllmyYJ559Cbjyn76gYL0nbUTf2N8y/FrsEL1dURmiWt8AkwOdbyYx1TaB1lqVySItxQm279KP1V7d8xhXq8+/ECGtTtc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(6636002)(966005)(426003)(7636003)(26005)(9786002)(36860700001)(2906002)(4326008)(31696002)(2616005)(5660300002)(336012)(44832011)(6666004)(356005)(36756003)(110136005)(54906003)(70206006)(186003)(70586007)(53546011)(47076005)(508600001)(36906005)(316002)(8676002)(107886003)(83380400001)(8936002)(31686004)(82310400003)(50156003)(15866825006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 11:02:58.2713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c3d3a7-df9e-49f9-1d4b-08d9ada7a4b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


nit: Just spot typo in subject. It is usb2244.

On 11/22/21 08:02, Greg KH wrote:
> On Mon, Nov 22, 2021 at 11:58:34AM +0530, Piyush Mehta wrote:
>> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
>> provides an ultra-fast interface between a USB host controller and flash
>> media cards.
>>
>> This patch adds a GPIO based usb-sd reset for USB2244 USB2 ultra fast
>> SD controller. This usb2244 driver trigger sd reset signal after soft
>> reset or core Reset. The SD needs to be resetted after completion of
>> phy initialization. After the toggling of gpio, controller gets out
>> form reset. USB2244 is a simple platform device driver.
>>
>> As part of the reset, sets the direction of the pin to output before
>> toggling the pin. Delay of microseconds is added in between high and
>> low to meet the setup and hold time requirement of the reset.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>> ---
>> Changes for V2:
>> - Update reset polarity, make reset ACTIVE LOW in the usb2244 driver.
>> - Fix WARNING: msleep < 20ms can sleep for up to 20ms by changing msleep to
>>    usleep_range()
>> ---
>>   drivers/usb/misc/Kconfig   | 10 +++++++
>>   drivers/usb/misc/Makefile  |  1 +
>>   drivers/usb/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> This isn't really a USB driver, so maybe drivers/misc/ instead?
> 
>>   3 files changed, 80 insertions(+)
>>   create mode 100644 drivers/usb/misc/usb2244.c
>>
>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>> index 8f11443..e1c66a2 100644
>> --- a/drivers/usb/misc/Kconfig
>> +++ b/drivers/usb/misc/Kconfig
>> @@ -215,6 +215,16 @@ config USB_ISIGHTFW
>>   	  driver beforehand. Tools for doing so are available at
>>   	  http://bersace03.free.fr
>>   
>> +config USB_USB2244
>> +	tristate "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
>> +	depends on GPIOLIB
>> +	help
>> +	  Say Y or M here if you want to reset Microchip USB2244 Ultra Fast
>> +	  USB 2.0 SD controller.
>> +	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
>> +	  SD controller. This driver reset the gpio pin makes controller out of
>> +	  reset.
> 
> Module name?
> 
>> +
>>   config USB_YUREX
>>   	tristate "USB YUREX driver support"
>>   	help
>> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
>> index 5f4e598..5b4af7d 100644
>> --- a/drivers/usb/misc/Makefile
>> +++ b/drivers/usb/misc/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_USB_LEGOTOWER)		+= legousbtower.o
>>   obj-$(CONFIG_USB_TEST)			+= usbtest.o
>>   obj-$(CONFIG_USB_EHSET_TEST_FIXTURE)    += ehset.o
>>   obj-$(CONFIG_USB_TRANCEVIBRATOR)	+= trancevibrator.o
>> +obj-$(CONFIG_USB_USB2244)		+= usb2244.o
>>   obj-$(CONFIG_USB_USS720)		+= uss720.o
>>   obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
>>   obj-$(CONFIG_USB_YUREX)			+= yurex.o
>> diff --git a/drivers/usb/misc/usb2244.c b/drivers/usb/misc/usb2244.c
>> new file mode 100644
>> index 0000000..5a868c2
>> --- /dev/null
>> +++ b/drivers/usb/misc/usb2244.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the Microchip USB2244 Ultra Fast USB 2.0 Multi-Format,
>> + * SD/MMC, and MS Flash Media Controllers
>> + *
>> + * Copyright (c) 2021 Xilinx, Inc.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct usb2244 {
>> +	struct gpio_desc *reset_gpio;
>> +};
> 
> Why is this structure needed?
> 
>> +
>> +static int usb2244_init_hw(struct device *dev, struct usb2244 *data)
>> +{
>> +	data = devm_kzalloc(dev, sizeof(struct usb2244), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(data->reset_gpio)) {
>> +		dev_err_probe(dev, PTR_ERR(data->reset_gpio),
>> +			      "Failed to request reset GPIO %ld, errcode",
>> +			      PTR_ERR(data->reset_gpio));
>> +		return PTR_ERR(data->reset_gpio);
>> +	}
>> +
>> +	/* Toggle RESET_N to reset the hub. */
>> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
>> +	usleep_range(5, 10);
>> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
>> +	usleep_range(5000, 6000);
> 
> Why do you need a kernel driver for this at all?  Why not just toggle
> the pin from userspace?

It is usb-sd convertor. If you have rootfs on SD you need to get the 
chip out of reset to be able to access init. There is no way how to do 
it via userspace.
Maybe there could be a different way how to do it via different driver 
to toggle the reset. It is dwc3 -> usb-hub(usb5744) -> usb-sd(usb2244) 
+ usb phys for sd2.0 and it should be also reset in the right order.

Thanks,
Michal
