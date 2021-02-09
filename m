Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1B314CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBIKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:25:37 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:27418
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231742AbhBIKNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a46bQTXxKyDrMhxvYd5+thCGD2qDUwmHN3a4QS7ROL2T/AXv/sOPrKOAznhpQIMhH1YquWQncAmbxl0Qp7s4T5px8QHggjtEOhl8FJSfLmSa3ArOxiokWD5x+azbGXYc4zlyxyn1xjY/bqZlxvp6MOCFmodWONIW6cArjQ7pM20QFNByoXa3dF+g0MbTWOZUnyGylW3ZbDg7rZg/iUnep6lZe0K2HTHbBBNf+NT0hec9jWrySuSeudvg4E/EQEL0BMT2jbue1ZaeR8KAXVkKeLGcYq2SlfkgJSHgYRYjvTmHuhDLFCaNX31l2So8hdSRRk0/E+KlHezrkHDkd11ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq6ujxGJVVBZWdKdTUO2hyJWK72ZmUNJmoqbiq8qNCs=;
 b=SPUkYzk7DYgeLA79oEMRllXaiYuM9fuLiBLw7Q08asn3rxd1xN1i15mr6VOSgPm71PqWxWSq/+2Rln1wS0Gza34IUrLe5UI1RKH2T7qXb6iY1pYmvWjh7yyJ8yFMZIxs0UixZnYXrUS8kiKa049MyPfvy5v6uYq3a92DLSNtRES4EimdGHSAo735E7QP4FUsrzA6D96kQJ4a6Vv1dD6biNBE16eqxiNmwb5HEwy1vuFZDVKNFQ3xthve9E8sFzjPbZ6AmsCoQgZfscb9O5UpEiZ8ys/UGzI032hKPertncjrpfNyzVE2pcFEhPw9fCfz+U40SK9DwZLksVQwta6nQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq6ujxGJVVBZWdKdTUO2hyJWK72ZmUNJmoqbiq8qNCs=;
 b=aOs52elt/1rxRbjGtZxhI7mJcr4sQej/46IBpNteLcXplVNwhsEfAsAzeKjy9BDRVaLV9lnH0SdzBxvVdbLL9807ra2gZlJEiZkmQ+GWUJBO7hT3bJB9dvZoDmY8UwbKRgq0qOsuxf/0PinJ7wo3owOdF5n9bU3Mlysitonp2AY=
Received: from MN2PR22CA0027.namprd22.prod.outlook.com (2603:10b6:208:238::32)
 by SN6PR02MB4829.namprd02.prod.outlook.com (2603:10b6:805:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 10:12:19 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::61) by MN2PR22CA0027.outlook.office365.com
 (2603:10b6:208:238::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Tue, 9 Feb 2021 10:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 9 Feb 2021 10:12:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 9 Feb 2021 02:11:59 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 9 Feb 2021 02:11:59 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 masahiroy@kernel.org,
 hadess@hadess.net,
 grandmaster@al2klimov.de,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=60316)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l9Pzy-0000wL-Nz; Tue, 09 Feb 2021 02:11:58 -0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>,
        Al Cooper <alcooperx@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>
References: <cover.1612864393.git.michal.simek@xilinx.com>
 <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
 <YCJd5Xoy1cT6bCIB@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] usb: misc: usb5744: Add support for USB hub
 controller
Message-ID: <fe8f8175-0b5d-3824-e5f7-b8cb826253bf@xilinx.com>
Date:   Tue, 9 Feb 2021 11:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCJd5Xoy1cT6bCIB@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a6b95b-a67d-4642-c38c-08d8cce32e88
X-MS-TrafficTypeDiagnostic: SN6PR02MB4829:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB48293FA70D3087A7C1A256C0C68E9@SN6PR02MB4829.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2vCPi92WEVte71LclT5s7XK/Fo9yrRPb6tNzGRwFR863mlhU8xErjPzi11hQNk3fpUN2bCrqIbyECYG0Yfm6nr6TONn3gFtKMGlYSnyhcm8Bu5iMwGUrqSLuAMQy/CfvtiqkwA75QoAI6Bha1EVvPj24czri25bPzsN9A7UDPpS4rNFl3zDpq1jBk+OeUD72P9/wh7PrsnfPttiGn4M710ncIhYvG1Za2tvyzqyDT12wZ6RpAw4sSu2miRufP13lyAcDRIrsXkjhxBiWdKc2fXmft6tGdhz3KyYQPMrUp5HyJ5HvBeuxXjMcvFyaUNPP3wEYdRVTaK7aQNfurM8Q9te13TRci5pHFeHqvlBLv0wMJ850MC8oJJ3Ytz0JP5+hYsIbFcmk8Ax8oj5bEUf5KtU0XW3HsJqaEx0vNeLbi7O/OnuPxBquvesZ89I6TR45M8mf1KKB13XZM2+ey9v0iGmiYBph4CyaVFWCauVEzD2kgcOT+qsQAnwxcClJ1GlQx1QyT6ZKfRiz14xCTdWR1i26NbljrYaD7dkj7E1smedqC8JmuyktILNiwgIus3I+MeBaMuPfm+g0S7E/wndHxFtFQ8G//pNkqPqoNMKIna0cbQejBRquxSb1rlst5Puiti58bVKsnXvXlb5ux8GSXAratXRONjkJrngSl4CVz9mdOSevWH3VAI0cFLUDMLGRFTE4g0XEiBDbeMDo1d3eQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(36906005)(83380400001)(316002)(356005)(31686004)(8676002)(44832011)(70206006)(26005)(478600001)(36860700001)(8936002)(54906003)(2906002)(47076005)(110136005)(7636003)(70586007)(5660300002)(4326008)(82310400003)(9786002)(82740400003)(426003)(336012)(31696002)(6666004)(36756003)(7416002)(2616005)(186003)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 10:12:18.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6b95b-a67d-4642-c38c-08d8cce32e88
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 11:03 AM, Greg Kroah-Hartman wrote:
> On Tue, Feb 09, 2021 at 10:53:20AM +0100, Michal Simek wrote:
>> From: Piyush Mehta <piyush.mehta@xilinx.com>
>>
>> This patch adds a USB GPIO based hub reset for USB5744 hub. This usb5744
>> driver trigger hub reset signal after soft reset or core Reset. The HUB
>> needs to be resetted after completion of phy initialization. After the
>> toggling of gpio, hub configure using i2c usb attached command.
>>
>> USB5744 hub can be used without any I2C connection, is handled by a
>> simple platform device driver.
>>
>> As part of the reset, sets the direction of the pin to output before
>> toggling the pin. Delay of millisecond is added in between low and
>> high to meet the setup and hold time requirement of the reset.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  MAINTAINERS                |   1 +
>>  drivers/usb/misc/Kconfig   |   9 +++
>>  drivers/usb/misc/Makefile  |   1 +
>>  drivers/usb/misc/usb5744.c | 115 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 126 insertions(+)
>>  create mode 100644 drivers/usb/misc/usb5744.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7439471b5d37..56d1fcdd24f6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2706,6 +2706,7 @@ F:	drivers/edac/synopsys_edac.c
>>  F:	drivers/i2c/busses/i2c-cadence.c
>>  F:	drivers/i2c/busses/i2c-xiic.c
>>  F:	drivers/mmc/host/sdhci-of-arasan.c
>> +F:	drivers/usb/misc/usb5744.c
>>  N:	zynq
>>  N:	xilinx
>>  
>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>> index 8f1144359012..30335b5c4f88 100644
>> --- a/drivers/usb/misc/Kconfig
>> +++ b/drivers/usb/misc/Kconfig
>> @@ -242,6 +242,15 @@ config USB_HUB_USB251XB
>>  	  parameters may be set in devicetree or platform data.
>>  	  Say Y or M here if you need to configure such a device via SMBus.
>>  
>> +config USB_USB5744
>> +	tristate "Microchip USB5744 Hub driver"
>> +	depends on I2C
>> +	depends on GPIOLIB
>> +	help
>> +	  This option enables support for Microchip USB5744 Hub. This driver
>> +	  optionally reset the hub using gpio pin and configure hub via i2c if
>> +	  connected.
>> +
>>  config USB_HSIC_USB3503
>>  	tristate "USB3503 HSIC to USB20 Driver"
>>  	depends on I2C
>> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
>> index 5f4e598573ab..5920146a506a 100644
>> --- a/drivers/usb/misc/Makefile
>> +++ b/drivers/usb/misc/Makefile
>> @@ -25,6 +25,7 @@ obj-$(CONFIG_USB_USS720)		+= uss720.o
>>  obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
>>  obj-$(CONFIG_USB_YUREX)			+= yurex.o
>>  obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
>> +obj-$(CONFIG_USB_USB5744)		+= usb5744.o
> 
> Can you follow the convention of the config options we have already, and
> make this USB_HUB_USB5744 please?

Sure.

> 
>>  obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
>>  obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
> 
> And then put it in sorted order :)

Do you want me to sort the whole Makefile and Kconfig as separate patch?
It is pretty much unsorted now.

And any other problem with the driver itself?

Thanks,
Michal
