Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2B305DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhA0OKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:10:30 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:42557
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231510AbhA0OIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:08:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izj50VMOU28jyY7BRpIHDj9zIBJhw39UqKpuzcbFci4ZOXcqhOlzLFBlXGVFQU1GwgW83Bt47PhtkEaXehNtFndlLkDsUPU7lFMOFcrcc3BZkFabk1DfvbgJkfvUx1RZcxwTo7YZ/4xt+hKtPDCLUBMBXGoGrYZRsJQ+eyexZ7JnO6IkUB0Glb/BKUzrvSCBwzWkWF5AKtAC6ixX+LK4AWL6v4o1a3zF+wEx27YQIgM9B3lP+slqWe9YqqgW8fCw7BcpcNvEJHo0lfydIeC1yQjbsanPHEDx3ZYCBEciZBkXZlmzeaXb+aKFjL23z50KjY9tgBTvoHBTItw57TGthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiCDnl4nb5ZYBl8nj6XiLbiNv/NWtjIOEYjHKux/7mY=;
 b=H52Ih38FI43Y4h9stv66sBD/MyJRtySZOfprjrb+SCUl2JUSkiYQqfRbyd46K7zn3BJKolskQWCj6WqMyUxuHv7tBwDbq4sbOo5UcMjw1kikl7m1owk6KzGW/+SpMYvVPVLI1daC3qyZEL+DCj5Y6oYXPXab4HB+tqw4Bp/dF5Sy+LiNj8nihLVZukVbo6vzJi0yXdYmAVdnEpqRexrxQjYf2iMIAomTmQ0CFs6Ca2bbUWEoyL71ysr+dsPFVWmSQUKeAKihok9fWR5uOByNdug9jMPH6WWUKWpslVY5f2qvNBZ0s/LJcNmc/6ciHq+rjf2NHYVKQfFx8HXCNKk9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiCDnl4nb5ZYBl8nj6XiLbiNv/NWtjIOEYjHKux/7mY=;
 b=Jf489+oKycYTOWvAMVgbRjwFlpmRfV/je8jH16MKThK711QUTElRGQ8QCfJNXaTXlHVDg2X3hNjYvr5+1Sp9J4B4Baew+/ZsUGFXPbsAqTsUjBXkuwYAwUDTNA+Cuz4WLVSw2lHMEn/ykf+ax0E+R/XsIU16s+E/nJbYb6AXOqM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4239.eurprd04.prod.outlook.com (2603:10a6:803:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 14:06:58 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%6]) with mapi id 15.20.3784.015; Wed, 27 Jan 2021
 14:06:58 +0000
Subject: Re: [PATCH 0/5] bus: fsl-mc: add userspace support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
 <YBFyiQJLklTuQH7z@kroah.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <439f17ab-bd7d-6415-bc02-d570c1288f11@nxp.com>
Date:   Wed, 27 Jan 2021 16:06:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YBFyiQJLklTuQH7z@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.25.96.12]
X-ClientProxiedBy: PR0P264CA0209.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::29) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.111] (188.25.96.12) by PR0P264CA0209.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16 via Frontend Transport; Wed, 27 Jan 2021 14:06:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68c2d1c2-452e-4881-1dea-08d8c2cccf7d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4239E41BEE62CAFF9E2080B8ECBB0@VI1PR04MB4239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnTEZDx8eaJqJOo4bbXMmv135pN6ENTRfQrE5MUF16uNKTFNeEfhlEl1zq0hsBCLqG4mudFDpxvfdCDnRp3N96GYT47f/kVCFNngEs1HXYXpcY2M0CY1jYsAbvTh+wvPnZY4Lgq3R9BNSSAamkCzGpLab90ZUVs0ZoXqTI0+56WbA2kST/E4FXbLaFZxIbOR+c52LH4so18aZt31adNJhsnf/N3RL4Cktktq4KPE/kQjo5l0XVkDVIsvIkXBUrpo2g1t+GZZPoEfwBKF9ZuaXryXLKXlbrfIbCuFRW2260ASUYgdYOremFCGhjU5Nn6P717gh0xOVFiLqtC/Sm17xFzE8erRhb4A4hcjW49PNHmnsktt6l2swUnhO8Mfr2f+OiwcjpwCp59/MT+RWLNdMR84Y1c3yMHEhGxEnHqEfPhKJB9RcJjxyHQBMBKikPTTq5igWe5enEMzNjK2pjOly8pQs6rFZvxeohn1cHyj+lleC+dFZ/tnks3Hp18H5Ua12nJgoITZydxBW00hYC7dAltto91oLD7f7yn3hYdJ1NeMYCgYMOv+bMMHxSwfyPOwz/hQmt6g5dMh2LJo28oEeEwDrJlyFZPBeKqZxpEfRBZ92d/8qTjrm0vl1UbSQHy+nojlygt7kzpJ7hwdfgaKcDZFVfL8Sknzg2azrAq4z5dWrFwJ6tM2IOoffTHpbgwS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(31686004)(110136005)(5660300002)(31696002)(8676002)(44832011)(52116002)(4326008)(2616005)(83380400001)(53546011)(316002)(16526019)(186003)(478600001)(6486002)(2906002)(26005)(66476007)(45080400002)(36756003)(8936002)(66556008)(86362001)(66946007)(966005)(956004)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnNSRU4ydTBIMXhpazdLbWRhNnNISWtwRWRZaTZvbCtUVHNxWVdhT2F4TUcw?=
 =?utf-8?B?V2VaVENtSlloZGo5M21OOStiUUhXNWN2YkpuVjAyTzNlTzFQOEFDZ3pHbWRp?=
 =?utf-8?B?TEtFSUxteHpFbzR2RlEzSG1iUjVjWVN3SWptSElsVGQyYWJZdEpmNHQxeHlQ?=
 =?utf-8?B?aUpvZXBOOG1jL1d6MmNrUVFhNDlWNUxKeDVsa2FHWk1vN0hNOC96Y01TTkJJ?=
 =?utf-8?B?YjFLaTRleHdIWkFBOFBvdmZsU20ycFgwTXZDeVN0NEdlN3NDUzQzTnZYVlRX?=
 =?utf-8?B?TzlPb0g3WVV3bkZpYUJtYlp6eXl0Z2o4Uk5iZ1drYTBYZE13em5xd1lxNlhI?=
 =?utf-8?B?d1JqdDhCbnRlc0prd051cVFZTnVjYUozVDJMN3dud0FzbG1aSkcydFdxRkt1?=
 =?utf-8?B?dW1vcHNQYTc3R3VYSy96aWtLdFVnVEtsazUxc1BFbzV6N1M0Qmg3RUdMSFc4?=
 =?utf-8?B?TUxLSjhRTXJjbHhRbFFYelZqa2lNK0VPNEpvaFpTN0hKT0ZUMUI0QXRYMXp3?=
 =?utf-8?B?OHpKNDEvcmhneXdFdVdEUTc1K1FaZzlwcDBDcklWd0FqaE9vYzJOYzB4b0d3?=
 =?utf-8?B?dmFKdXVmUndqM1BnRThlYWRjZlJXaFRZNENVYTNxYmNjMU9RK0RySmNGclNG?=
 =?utf-8?B?a1l6K0t5MTVlcmZUcnUzTHh4d1BadkJzMi84TWZTOHlIaDdGMXBFcGsveFNk?=
 =?utf-8?B?dnRFR0YyLzRGMGUxa1AvVjZaaVh2UEtHWTE3ME9MSnY5RmNPQlhGeTdCZlZI?=
 =?utf-8?B?TkVVVW5mNURJY3MrOVJsNU82WS9hTGh2V2RZM29IMHBxemw0NU9TRGNmMUFV?=
 =?utf-8?B?MXo4YnFQWUIwMFlsQkRhT3BDUWVjTEpDRFZTNElZNTJjbXZEU0cvWWxIN0xN?=
 =?utf-8?B?UnhUMG9Ick45TTJKQVhpWmRja0N6S3VSdy9BRkhKYXVXN2pZN0l1WERaclNj?=
 =?utf-8?B?S2YycDY0VHI1OVVQSC9yQzcrS1lrdkNhNzQrL2FYTlhmNU04TTBOTzF0NllF?=
 =?utf-8?B?ZGQ0cnlzMW42YVVKdHF0R0JLMVkvc1JRNDdKNVVZV3FYSjZNZ1R4a0lvenoy?=
 =?utf-8?B?RDhOM29lSllpby95ajhZOEtrdmFPczlXUkN6NFZZMExCVCtLVFpKVG41YmpX?=
 =?utf-8?B?d1pWNmwyUVF4cjNtLzdiRThMTWNtM1p3YVFuYkluMndnbEJ1ckJ1S3FpOTFZ?=
 =?utf-8?B?TVhteGpTSEIrTm5mWlgvYzJnZmovTWd2cTJTTi9mR3ZQckRSZEVYckR4SlJ4?=
 =?utf-8?B?eE5DQUV6NHdqQklDcHh4ZXozd2YxWTgwMXlBVVBiRkw1ekljMG9mUll5ckZI?=
 =?utf-8?B?d05kTlM2WHp1amh5dFBMbDhaOVk5YWhKN0RrUjVNZzZIOUt4TEZpdkFKb01H?=
 =?utf-8?B?VVFWZStWamg4WVlsdFRLZzJ6VmZDcXJZcUNNM3NuVnB3RzZqV3lqRnFFVUw1?=
 =?utf-8?Q?JVTWwXB+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c2d1c2-452e-4881-1dea-08d8c2cccf7d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:06:58.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iyqx9J/bjz7qqYn6s/PpEVUCMkwVXLFng1yOPHdbVU3hhPglPRpFPDZ3EauSFt6tu2HBXcp0m8b0t8AO1koN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2021 4:02 PM, Greg KH wrote:
> On Thu, Jan 14, 2021 at 07:07:47PM +0200, Ioana Ciornei wrote:
>> From: Ioana Ciornei <ioana.ciornei@nxp.com>
>>
>> This patch set adds userspace support in the fsl-mc bus along with a
>> rescan attribute to the root DPRC container. An earlier discussion on
>> this functionality can be found at the link below. I didn't continue
>> with the versioning scheme since quite some time has passed since the
>> last discussion.
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2018%2F11%2F20%2F1162&amp;data=04%7C01%7Claurentiu.tudor%40nxp.com%7C8d74c7b04f864d17419508d8c2cc3e10%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637473529759283328%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kDWLNqq91k5LW74jgZ%2Blu%2FZJfCmeLUZm5DccUiS4m94%3D&amp;reserved=0
>>
>> The FSL_MC_SEND_MC_COMMAND ioctl acts as a direct passthrough to the
>> Management Complex (or MC) by passing fixed-length command/response
>> pairs. Keeping in mind that the MC manages DPAA2 hardware resources and
>> provides and object-based abstraction for sofware drivers, the proposed
>> ioctl interface enables userspace tools to do the following: 
>>  - Get layout information about the available resources abstracted and
>>    exported by the Management Complex firmware. This is especially
>>    useful to generate a complete description of the current hardware
>>    resource partitioning.
>>  - Manage DPAA2 objects lifecycle (create, destroy) and establish
>>    connection between different components as needed.
>>
>> The ioctl interface is intended for dynamic usecases where DPAA2 objects
>> need to be created on demand or destroyed so that the underlying
>> hardware resources can be further repurposed. In static usecases,
>> depending on the requirements, a firmware configuration file can be used
>> to describe the needed DPAA2 objects, their attributes or any link
>> between them.
>>
>> Each command received through the ioctl interface is first checked
>> against a list of accepted MC commands. Also, commands which would alter
>> the hardware resource management require CAP_NET_ADMIN.  The command is
>> also check so that it does not contain garbage beyond the maximum size
>> expected for that command id.
> 
> I need an ack from the maintainers here before I can take this series.
> 

Sorry, got caught with other things and forgot about it. Done.

---
Thanks & Best Regards, Laurentiu
