Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5D3164A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBJLHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:07:25 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:31328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231336AbhBJLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:05:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jroQMUspvZ0YAG4fK3orvd1i4W6SXtrvrliWcykvjt4ulCQVCDo9k567aRM/lEB2QSCMgyT9N2tQCjZIQnN2sgynZLk2z1nuYNajRMUxcF9DoZ7drjDQarEByxIZvyNXetLk2NAFqNDYx3pqpLnKVwrFhL1PRvqPdCptKH/mAmCeZOYmbJ/efEhrI4zS4yI5+rMa5MQoKnrr19alYqef4Ab240mAvl84mfWugeso7ySPNLb+vw2WEGC8a3g8bYeS/5VO0HfsFHWaZHr1RZVKDU+A/8xTaX5c+8xK26x32z1JaoTTPg5aGt6wIgYSqsLXMXRKEnkPPabrGYGTSsoyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNQIpFHWqSVtaAys/eMovB0hNqUq0t90tOfv5WBffXA=;
 b=odMkm8ozdgtQJUgvnZZxc19WPHcsFJHu8+TtI9HYbKSmFXaA8nLae/moJjtSAB5lxQm7pAEq2BmKAi7mIBkMgB6BgcsDLIffliO4ri6thCG8LQIVkoe8QHxNqCEdGjFjJN7E7RLs+wZIjZ0PKnZk6QiL21OeLWg9aER+dYh1npINLdom0slaueEIiGRwWaWrtu0fzv9mFh0ju1WJhdUr7st3oGuop3KeLkubkXdLmwySUe9FCd+dthChL5LkIPv9MwHB0SgCEIjiyFRxtu4RUCybt6suRXuGg0wCrrMeNxAKMJQoG66MAuE/j4IZ2ZGGNcqXvyeyHnEelwjjFfhBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNQIpFHWqSVtaAys/eMovB0hNqUq0t90tOfv5WBffXA=;
 b=d/aWXwcltc707f8CVtwzdkt3NARBcBYjh8d2VY+WiSjLnsSt1ED7ZKg6ChGNqwq9v9etXPOTYl/Q1D9zmQ1OMx7erjlutoIgIsMfA8AmU1oxi/l5XuqCnDzVT2/e4OYsyfGvUYFp9hhbG/sXkvjeZtUwNL7APQaNfMfWUW3Br6k=
Received: from SN4PR0501CA0077.namprd05.prod.outlook.com
 (2603:10b6:803:22::15) by DM5PR02MB2457.namprd02.prod.outlook.com
 (2603:10b6:3:44::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 11:04:22 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::d4) by SN4PR0501CA0077.outlook.office365.com
 (2603:10b6:803:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Wed, 10 Feb 2021 11:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 10 Feb 2021 11:04:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 03:04:01 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 03:04:01 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org,
 hadess@hadess.net,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 masahiroy@kernel.org,
 grandmaster@al2klimov.de,
 linux-usb@vger.kernel.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Received: from [172.30.17.109] (port=46886)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l9nHs-0000op-Oo; Wed, 10 Feb 2021 03:04:01 -0800
To:     Andrew Lunn <andrew@lunn.ch>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bastien Nocera <hadess@hadess.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1612864393.git.michal.simek@xilinx.com>
 <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
 <YCNKgAUi5d6LY6zf@lunn.ch>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] usb: misc: usb5744: Add support for USB hub
 controller
Message-ID: <58de4ddf-70e1-c20d-3d0f-c32b69f55ecd@xilinx.com>
Date:   Wed, 10 Feb 2021 12:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCNKgAUi5d6LY6zf@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ba1132-eb16-4c98-26c3-08d8cdb39ea9
X-MS-TrafficTypeDiagnostic: DM5PR02MB2457:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR02MB2457C064AF5DDA7343383193C68D9@DM5PR02MB2457.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dsfjlGrlhvt0yxVunT7C6oWXuFuAygWE+CNma+/+WrcshU13ez0zdRlZqs/Udke3K7q2f/ZtZivsITaAKhJeaWuzZoZkAdKTrsqcV5EZy0I2Mei7Z9dWT5KAyHqF6egsX1ZyXNoVUYUkWV5x0Jb52C3kVM9V+/kMNDIrEmxNPCvQ4RL6YY5sZ/0xR+hvZ5RGcSvuDp2G3PCkb+SaUhGGTaGv+YbY0il5LBmf30qz8TNTfC9lG9aQn/Al6DYBCTYzsG3VPWD3fxMFq22NWqPCVqlaN392uMMCZowMpoAFlp10Wmt1fioiSRzIe6fjYs/PbN7vE+Rbvd6lzdQObQl1aGxPdvThQugsn4WSuBITlyGXm7i4OXra+YuvMxWDiJQmrRvH6LnfyMh4wZ55N7FPdDH16oVRB61coB1JmSnQRsBmSgKPCAz8lm3SMtM41wvPF1ewGHIoqOBpzwlXh1Te96sGIqAHi62VQhSOwPLENkz/CyRhVzBskVReF3rI5jVQ1Iw9Nd+8Xk0F0MWFS+pPlU32lzDVpVIqtdbqtNBRzC0cBbAWNBN1wFVH/N4mWPGm18inbOLp9XgOMzJND6gEtbe3fg1cNYvTycfmjqqBtbhctM76e9Dj1vrTOrtawGOcC3ISmMgnNbzjz12nbK0Dc8SGkYBRwRb3CF9FH2qeYBfqFWBdAnnyvB5lnRYO1/3dLFmy54JBJ52DsHquxRabA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(36840700001)(46966006)(4326008)(6666004)(47076005)(8676002)(2906002)(44832011)(31686004)(70206006)(110136005)(54906003)(53546011)(356005)(82740400003)(7636003)(336012)(2616005)(36860700001)(478600001)(5660300002)(26005)(8936002)(70586007)(316002)(36906005)(31696002)(186003)(426003)(82310400003)(9786002)(7416002)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 11:04:21.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ba1132-eb16-4c98-26c3-08d8cdb39ea9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2457
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2/10/21 3:52 AM, Andrew Lunn wrote:
> On Tue, Feb 09, 2021 at 10:53:20AM +0100, Michal Simek wrote:
>> +static int usb5744_i2c_probe(struct i2c_client *client,
>> +			     const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	int ret;
>> +
>> +	/* Trigger gpio reset to the hub. */
>> +	ret = usb5744_init_hw(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Send SMBus command to boot hub. */
>> +	ret = i2c_smbus_write_word_data(client, 0xAA, swab16(0x5600));
> 
> Hi Michal
> 
> This is not my area of the kernel. But that swab16() stood out, and
> made me wonder about endianness. Will this work correctly on big and
> little endian hosts?

thanks for bringing this up. I didn't test it on BE system.

I have grepped the kernel

[linux](xnext/usb5744)$ git grep i2c_smbus_write_word_data | grep swab
drivers/media/i2c/uda1342.c:17:	i2c_smbus_write_word_data(client, reg,
swab16(value));
drivers/media/i2c/vpx3220.c:97:	if (i2c_smbus_write_word_data(client,
0x27, swab16(fpaddr)) == -1) {
drivers/media/i2c/vpx3220.c:106:	if (i2c_smbus_write_word_data(client,
0x28, swab16(data)) == -1) {
drivers/media/i2c/vpx3220.c:120:	if (i2c_smbus_write_word_data(client,
0x26, swab16(fpaddr)) == -1) {
drivers/usb/misc/usb5744.c:50:	ret = i2c_smbus_write_word_data(client,
0xAA, swab16(0x5600));
include/linux/i2c.h:168:	return i2c_smbus_write_word_data(client,
command, swab16(value));

And last one is interesting

 164 static inline s32
 165 i2c_smbus_write_word_swapped(const struct i2c_client *client,
 166                              u8 command, u16 value)
 167 {
 168         return i2c_smbus_write_word_data(client, command,
swab16(value));
 169 }

And this function is also used

[linux](xnext/usb5744)$ git grep i2c_smbus_write_word_swapped | wc -l
76

I think it would be the best to test it and see if this code works on BE
but I need to prepare it first.
And current code is aligned with others but it doesn't mean that it is
correct.

Thanks,
Michal



