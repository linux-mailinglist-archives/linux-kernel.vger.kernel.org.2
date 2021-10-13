Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9F42C4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJMPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:32:27 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:3505
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhJMPc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVddW8HU3DQiTpZm7YbcWhJ+S9i2aX5rDa9gMJTytLTGzESEFZs6Up9uTuSpKWNKAhYoNoRHHb3vDvpTOZ36CyCsTVLQwmdjMh82/Jm+j5hCXudyxVcmCDQX+OsTwmeub3R64hSlqSmz0bxSK+PcgcXCJ9KYrhHIDHBGCcgl87UQpkin5FiYPyZEpZhEq7CfBuJwEsQfxunaF6og3FCEDHObP7xEcwoUnRZr5m2izE2c4lgQnzZLJgE3JD0WTHkU1aC6lcvcdgC17Ezr9aaR8LctpSGLA/cydToJxNDU35jF5JvbRf8Arw6aO5q87b3/NO/5V0eWD6kUpRb7hI2ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6EZDqpqmfIToJAHFf13QlQpsarvka+8+VvvpIEkevo=;
 b=aerd/IRFJFgHnnzxIJvB+m9v7Wt3nf4VoJVoctZBkyNEIWp+M6UWgAmDFg3sYlINksPbbO/BIvbLeBpTqyabCM/OH/UPg6gaCz5IVaRZO60f0QHrCXa57TWHfcD32t2oJ7sAxnZ5cVkRjHE89q0606FmxQtuF8wZUH8Fj/WbGR8TTypGFwA3mebtMJcRsn5uexbd4GfQ0jdC7g4W0m9rG0R8VjM1lIGb8sggFrULA6HsCAdGc5sZsMI4sj81mn0kURYGR8HiarjkK6t7hxnF2TuLmGGghdSWpZAeNiYm/LZR+d+V4zbHnXuxPdYo1yc9jYaY/qZ85CBuFPp43FHEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6EZDqpqmfIToJAHFf13QlQpsarvka+8+VvvpIEkevo=;
 b=GERgxvlF4ylntfYllPz/fMFYIF2jvNp/DmagRBaFdxFI1VrLP/Dp0IU0lSp3qR4wukOpHIJCGcIwnKm4RiTStHQ47rMEosMfcxRLFrVSeUgEKNksrYfviGzgcW/OHck2uyF2idVKYoXp823u5noz9bK9h9qz9GWZnXftl82triY=
Received: from DM6PR08CA0037.namprd08.prod.outlook.com (2603:10b6:5:1e0::11)
 by BL0PR02MB5698.namprd02.prod.outlook.com (2603:10b6:208:8a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 15:30:20 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::9b) by DM6PR08CA0037.outlook.office365.com
 (2603:10b6:5:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 13 Oct 2021 15:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:30:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 13 Oct 2021 08:30:13 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 13 Oct 2021 08:30:13 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.49] (port=38114)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1magCn-000AMe-4m; Wed, 13 Oct 2021 08:30:09 -0700
Message-ID: <f63e44a0-c187-8278-6c89-935b7006b64f@xilinx.com>
Date:   Wed, 13 Oct 2021 17:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
Content-Language: en-US
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Abhyuday Godhasara <agodhasa@xilinx.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>, Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
 <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbtSiHWNOf2djee@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YWbtSiHWNOf2djee@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d44825-89be-41e8-840e-08d98e5e5e30
X-MS-TrafficTypeDiagnostic: BL0PR02MB5698:
X-Microsoft-Antispam-PRVS: <BL0PR02MB569828C8CF18D777DCC8E13DC6B79@BL0PR02MB5698.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F93rkBrkglJynJMa7N0K4Db4TRe0WK0kPwwsbcTqqDyoOAHfeoAJWyNU7gEmLww27s0PxzmbvHbwumkzSb8hP1Xkfba7phcBw9AJTEkZGZcy6cp1T8Lu9QbEEbcSrqzcTWOsS8UbkFlHrp7yO+++Ihdr5Cws35mpKwS8ITjDP2fxiWdedy0uZv0vVMZeM2iUzAWgKGZpuMQph14gS9JbDXZLCieH4Bdq+48zQg6qLXYCj7j6KjsED5vIyR1WbpbD66CZ7HxPgEPWCBJqfwp25RVrSYMDlbn5ZobEZdchTpsJYm0+LO1bV9S2elaQpFF4rSmMjjl2aqU6v4WCrMry60vMp4x0EldLT3hiHze5qPBolID49GjH9h4mWXOyQCru4VlxkCi8RCAM03eaC8JSJu2Znay4XHWBR2bYTKL2DuugBSaRC+z45wEOYHy5b2J1/b5fT1b1Z+24XsJ+FxUC/F9aNP52JVzsneL6w6LHhmxZvAe1jJXwY/0jKO0aIxXDSBe/4OTLnxwt59sGynQAWzdExkU+INDB7Y+eaaSrzFT6tdv+CRuKz7CJmsA0WeajM+uMJVMlyU1ymKvPqDOXYyHAox36USl9btp3Z6Q+G5WSn+yTuf+GTA8SDLIAGVaQqwLFg5+tcIg+TZUT1UZrhOr1gKT0iGJTIgsEIg6MvlVO3w+HdFJ61DX16pwhMEvjamT1CO+8yWoiIMYewIxe1DKpSADcdQriR92Hi8XdjsOQvlsbqq0HVf1uuAAalR++
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(83380400001)(26005)(2616005)(8676002)(70586007)(82310400003)(356005)(36860700001)(186003)(7636003)(36756003)(70206006)(53546011)(47076005)(36906005)(5660300002)(6666004)(44832011)(2906002)(4326008)(336012)(54906003)(9786002)(508600001)(8936002)(31696002)(110136005)(31686004)(316002)(426003)(6636002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:30:20.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d44825-89be-41e8-840e-08d98e5e5e30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 16:29, gregkh@linuxfoundation.org wrote:
> On Wed, Oct 13, 2021 at 02:21:01PM +0000, Abhyuday Godhasara wrote:
>> Hi Greg,
>>
>>
>> Thanks,
>> Abhyuday
>>
>>> -----Original Message-----
>>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
>>> Sent: Wednesday, October 13, 2021 7:41 PM
>>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
>>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
>>> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
>>> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
>>>
>>> On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara wrote:
>>>> Hi Greg,
>>>>
>>>>> -----Original Message-----
>>>>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
>>>>> Sent: Wednesday, October 13, 2021 6:36 PM
>>>>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
>>>>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
>>>>> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
>>>>> zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
>>>>> Jiaying Liang <jliang@xilinx.com>; linux- kernel@vger.kernel.org;
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
>>>>>
>>>>> On Wed, Oct 13, 2021 at 02:59:21PM +0200, gregkh@linuxfoundation.org
>>>>> wrote:
>>>>>> On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
>>>>>>> Hi Greg,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>>>>>>>> Sent: Wednesday, September 15, 2021 6:46 PM
>>>>>>>> To: gregkh@linuxfoundation.org
>>>>>>>> Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
>>>>>>>> <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish
>>>>>>>> Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
>>>>>>>> Potthuri <lakshmis@xilinx.com>; Jiaying Liang
>>>>>>>> <jliang@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
>>>>>>>> linux-kernel@vger.kernel.org;
>>>>>>>> linux-arm- kernel@lists.infradead.org
>>>>>>>> Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
>>>>>>>>
>>>>>>>> This Linux driver provides support to subscribe error/event
>>>>>>>> notification and receive notification from firmware for
>>>>>>>> error/event and forward event notification to subscribed
>>>>>>>> driver via
>>>>> registered callback.
>>>>>>>>
>>>>>>>> All types of events like power and error will be handled from
>>>>>>>> single place as part of event management driver.
>>>>>>>>
>>>>>>>> Changes in v4:
>>>>>>>> - Rebase on latest tree
>>>>>>>>
>>>>>>>> Changes in v3:
>>>>>>>> - Update the commit message.
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>> - Removed updated copyright year from unchanged files.
>>>>>>>> - make sgi_num as module parameter for event management driver.
>>>>>>>> - Use same object for error detection and printing.
>>>>>>>>
>>>>>>>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>>>>>>> [Abhyuday] Michal suggested to merge this via your tree. Please
>>>>>>> have a
>>>>> look.
>>>>>>> Please let me know if there is anything required from my side.
>>>>>>
>>>>>> Ok, I'll pick it up, thanks.
>>>>>
>>>>> Nope, I can not as for some reason it all did not show up on lore.kernel.org.
>>>>>
>>>>> Please resend this, with Michal's ack and I will be glad to pick it up.
>>>> [Abhyuday] Sent v5 with Michal's ack.
>>>
>>> Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?
>> [Abhyuday] I added linux-kernel@vger.kernel.org and linux-arm-kernel@lists.infradead.org in CC. also  added you in "To" for v5.
>> Please let me know if require anything else also.
> 
> Again, I do not see them in my inbox, nor do I see them on
> lore.kernel.org.
> 
> Are you _sure_ you sent them?

I got it but I expect they are not sent out of xilinx.com domain and you 
are sort of blocked. You should talk to IT or just simply use any email 
out of xilinx domain to check that you got it.
Also I am not able to see it in lore.

Thanks,
Michal

