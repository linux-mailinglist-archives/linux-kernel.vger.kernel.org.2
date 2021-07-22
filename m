Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D703D1E55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGVF42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:56:28 -0400
Received: from mail-eopbgr10096.outbound.protection.outlook.com ([40.107.1.96]:42519
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230117AbhGVF41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:56:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWqbBPFecb4dWF8KsfWJQQbR43LQ2HACvSiEglTVwzTUSyndmcfBkJZCMHCGYXX+nnt4keEpGsAsdhqMNo2MwtAbgAMNuc0OIVdkDTAF0BlPlwbc7Er8AZ3/p08irsHkA7BqdzpE/1KzRFwbdC/S2Jtwbay6Ow2VaojAgcKok/p6vM5JQNHvYL3RcqMHb1dLGudfUq8bFRddi3fJKFIKLltxCeTIv1jqf4biGQb7zhLkr5ceUWNVZmdykTcgeFTUByAUPykOSEl/0XJk1oOGM/Yd220QdcRJLaJTsAiksg3HpGMm1RnieUViyPY5g1R9zEVR24Z8+iy32jP2Lq6s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARbVZO/T2rJfVFSrgCcji+fRlxC2uWXKhkBmWGdqfzw=;
 b=NJFpEFNm9ye0h6jfAaxFEkTrx3U5gio9QKUmAm8jSQ/TYWImlRh5hYzVu5qOR4N/FLy1DX6g4m00O0rjst4dGzWrvUDk3ewtzNzA+oEOESa3nh3fbJsX6/qdolHFkRNbQDKUN0pjxOobFWVAAm8Vfb3xnDMf3LnfeDiPcjAEqvO1TiqsN4jKUzT0AFeXuivAV0xw6icdJkx7HOJaI017x2FV22EMYPhzQclbCaL9v/2XOegYy5BdmlDnpRxdKulcrZafQXY3ChHHvaf2PuSYzY77ijeZApPJRi/xavHya7j/g5oDesN3e+UdPzhtOasde4ke62At4SaPvnKjp+xAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARbVZO/T2rJfVFSrgCcji+fRlxC2uWXKhkBmWGdqfzw=;
 b=YrUDi29PD4B3C4iBJYX5Cmha0YiVcyoAyJewlWe7wdYMp0aFRadMpxHJK6VcKZHCTMDZ4Ftxb8Mf9YCqB/SS+3uWYccBdaNsze1o8hHRHcToId1wt4l1yUw4hnJ5S4Tgsv6uMZu67Th2l6nB0ahEsoZEc7QuEwP+yyzJ6EoFoCE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Thu, 22 Jul
 2021 06:37:00 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 06:37:00 +0000
Subject: Re: [PATCH V2 00/13] soc: imx: gpcv2: support i.MX8MM
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <3c5ef283-0895-05ab-7568-0d108b761008@kontron.de>
 <f7937500-f2bb-aa5c-caa2-1788693895a7@kontron.de>
 <89534836-6688-9cbd-1f33-ca78a4db47d4@kontron.de>
 <689e5fd6c290ebec09d45c5d55354d78f5cea647.camel@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <94d4a625-bdf2-9b40-8b6b-50c2bfd8f103@kontron.de>
Date:   Thu, 22 Jul 2021 08:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <689e5fd6c290ebec09d45c5d55354d78f5cea647.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::35) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.32] (89.247.39.170) by PR3P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 06:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d666ae1e-a9c9-49f5-c976-08d94cdb1bee
X-MS-TrafficTypeDiagnostic: AM8PR10MB4308:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4308A945F9A399BBE63B460EE9E49@AM8PR10MB4308.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkwoUurdMzigYosHZJ5WnSga++Zf4h3xB8zROFLg2dwp63HZ0Va2HFw8VFAXGhm20zRTrbiCxL0Pdt3NOkEb6XurLH+YWbb6KwP6GP7qaKhd9VTONXcKiqhu/IBbEd0/MnQSHJcaKjVXsu0swe2wuM0C3gcb2DaQ3Rzh/ZPM/PykKX3/8k5imZz/w3VuNul0MAX6Iu2elfb2PGcEh8qs+IDRk/33Kg+Lfldt7BjnTzxz2bZnyw79eq4PVoJlRCXAIMuVEKAxDcol+pQwzEuR8rgAllq+Sbj+yiz3iLNfaXTHGDN1FEWy1idTEkbVCQ8z4GSr0Eem8IZoRadSVZxpdWCj+b6xbUELRoEmD/NKblmG8xw2wAdzbVbFWwnYKOzp+0jeY3qhKEGzaPCcMBnr27f12Datezuoin7dNTpgmFFd6Fo6LfIXKeVViaTOaAi0ojwX5cAYt0QGR+cQNJr5QYNVLTEEqmy8sopmDgmIkwOX/fkmWs+vwKnd47MYoESItDvLsuktledo6nTyORE/Mm0w8QfDjHIWbzVyHppGCoV5jyPu3Jzhu48lsLxR3V1v115avQwzlyK5s/cm50aL7EsLkR+hg2e+i5/2dR3Q9FXH37oZFsRhhSfRr9P5NRcadg7IUjiyO5SLBRKgApoTsnhZKA9F6NeSNKF5HVig7ocMydFuPa3g13fXk5fKzFgmjtczdxsr/Sa4vYZfj3LNs0YLUDLco5Z3NAKOpTwRJ7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(38100700002)(316002)(26005)(16576012)(956004)(44832011)(8676002)(66476007)(83380400001)(36756003)(31686004)(66556008)(31696002)(4326008)(508600001)(5660300002)(2616005)(6486002)(66946007)(110136005)(8936002)(53546011)(86362001)(186003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVFOXhHR1FXa0g2bzl6M3JvTFlHakUzOWdNTWJlRWNiKzN1YXpVM1I2QlBM?=
 =?utf-8?B?dGxqVU5GSXlhMytvZDVNbEMrcm5aeDllV3l0Z0ZObDdnZmJLS0xrdXROd0J5?=
 =?utf-8?B?UXBPNFFYL3FlRWRTU0ZwV2dNd3RTWkwrRzFNYzdoN3V0UlFqR3BKSm9vV29m?=
 =?utf-8?B?V2FVa09xY0Z2Y3ZNRllJUkltdEFOUStDNFVXZUZNRVB1UmlrYVpTYUxSOGtV?=
 =?utf-8?B?TVkyZnBJRFJHdGNocXRIclE3ajU0ZEQrZHJRbmJKT0dOWmFlSUZnU09FQjdG?=
 =?utf-8?B?cmdBY1JyanlHOHpYc25BRTJMNERVS3lhdmlOVGNtOTk4QmtsazdXdWRKQWdY?=
 =?utf-8?B?Wno1VC9BRVpZS1ZIejNjVk1xbW5NazBHaGN1WkRBNjNsTVdLMStSTnhHRndP?=
 =?utf-8?B?MHA4WklndlROaGJ1bHJ5WWVyRVhnQVFOTFY3dUVSWm5PRmRCWlhYVmYzQkN3?=
 =?utf-8?B?VGc4U1ppaDlHTWVaUkJiZzRtSWliWXd3M3VuRWJKVXlobGtiV3lQbjB6K1Vh?=
 =?utf-8?B?b2FKc2NWMlpJQ2VDVUJwSy9Tc0VwZW5KeDJ1ZWg0ZGkxaURicDZvVjlpT3Ju?=
 =?utf-8?B?SmtaWjlyWGhTcithVjAzOW5Hd1JSTmViQ2p6NEhxcEN4ZGpYTDNNY3dUKzMy?=
 =?utf-8?B?b1IrQzlrYWJWcVJ6dVZFNXJ6eGJVRmNmV3RyZkdRYVBvSWNQQmRWMU9oSUZ3?=
 =?utf-8?B?RzNrVWgxRzBvL2JmR283UlJhVnNqbXdkNTYxM0UyNlFXaWVIRHBMS1lUeTVY?=
 =?utf-8?B?Q3dZTTlZdWwxeWJKTjBGb2lrL3Q5ZkgySFVtOEt6cGJ1Q2F1dUlCZnZRaTdC?=
 =?utf-8?B?aWVQR3BydTd2a3kvZFBNUFYrTVhEV0I3aTJOVDRRUEhKVjNZTllTS0lOT3Nl?=
 =?utf-8?B?K3BHU3FhZmFYZzZld251YlZyWEp0clJGdk8rcFdQQzlDQ3lxMjFoVFF5dEtj?=
 =?utf-8?B?a0VFUHlWYm9SUjZyNExudmRjViszTUVuNEtKbUVtTm1zL1lHeDhJMlorT1BC?=
 =?utf-8?B?NnhCZ1RwSWEyYmdjcm0rUTJva20ydVJGK01tV2RlYlVhRm56L0NoRXFwdFpI?=
 =?utf-8?B?M0hVY0RPYnJXbGxXRU91U3lkeUJBNUUvOU1TbmUwT0h1MW5lTHVNY3BxN0JR?=
 =?utf-8?B?bk8xSm1ZUDRQdHFrckZZL25iUzljVVJ4YUgvUTlVb1cvSHgzdUVOOWhiWlhx?=
 =?utf-8?B?S3cxQ0c3YzVTbC9HY0JsVFVNZW1oYWpJVVhJZnkwemdENmRlK004VVV5Wi95?=
 =?utf-8?B?dnhCQUZkMGFvTjRlM3VlTkRmY1BxRkhFK3V4akd4QkVVcWNia0dzU1g4UWNo?=
 =?utf-8?B?eWZVVUwzamZwSVBzUWYzVFdBenVpRGxCc1ppZDhOZFUwVTV6eUlYL3FoRnJx?=
 =?utf-8?B?YnRiZHVzdHlSRUZHK1VMN1hrc09qSVltakVQOTk1M1MxYmRqTHpxeGlmTGlF?=
 =?utf-8?B?WkdtWXYzNitjdk1MUHF4bHFQcDRDTVJyUlloTWs4YkdlWXpMRkFueHh5MTVM?=
 =?utf-8?B?NFBhQU5ibkJPNXU4TW9sUWpnNDBzcm42cXluNXhCWDJremJYc0lsZHp4Z042?=
 =?utf-8?B?ampBRVR1emdWZWg1bjVpVUFEdU9GN2tDcXpiR3NLdUR5M29ScEtDM3hJb0FB?=
 =?utf-8?B?VlhBTy9lZFNmZkJ2NUFTanJJb1Mxb0ttWG5xRTAveUZGSXVOVnVQdjhlVGhX?=
 =?utf-8?B?SGV5YSsrMzU5RHJsbVJJOUc5NkRYWitXb2RuRlhtdm45LzNYeVlnT0FXTUlw?=
 =?utf-8?Q?wv+5baZ8/SR8obu03UAfXpAUYxfNymYcCd2yWEy?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d666ae1e-a9c9-49f5-c976-08d94cdb1bee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 06:37:00.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su+6dbb3yHIHB0FvKhk3ds84FaYYqYeKwt7XdTsYUx7yI8a9My0nMDRKqsCLvhORxLHpujBgbsjUoZkMFlyHD0SK9TQHZPtFBa1ShCXRVTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 21.07.21 22:51, Lucas Stach wrote:
> Hi Frieder,
> 
> Am Donnerstag, dem 20.05.2021 um 17:16 +0200 schrieb Frieder Schrempf:
>> On 19.05.21 18:09, Frieder Schrempf wrote:
>>> On 06.05.21 10:32, Frieder Schrempf wrote:
>>>> On 06.05.21 03:04, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>>
>>>>> V2:
>>>>>  - Add R-b/A-b tag
>>>>>  - Merge V1 patch 13 to V2 patch 6
>>>>>  - Drop V1 patch 15
>>>>>  - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5
>>>>> to explain
>>>>>  details
>>>>>  - Add explaination in patch 8 for "why the resets are not
>>>>> defined"
>>>>>
>>>>> This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and
>>>>> several
>>>>> minor changes from me to make it could work with i.MX BLK-CTL
>>>>> driver.
>>>>>
>>>>> Thanks for Lucas's work and suggestion, Frieder Schrempf for
>>>>> collecting
>>>>> all the patches, Jacky Bai on help debug issues.
>>>>
>>>> I tested this series together with the BLK CTL patches by using
>>>> the GPU and the display stack. Everything looks good to me.
>>>>
>>>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> So after some more testing on different hardware I stumbled upon
>>> the problem that USB autosuspend doesn't work properly anymore.
>>>
>>> I have an onboard LTE module that is connected to OTG2 on the
>>> i.MX8MM. When using the mainline TF-A (that enables USB power-
>>> domains by default) and removing the power-domain control from the
>>> kernel, the device comes up after a few seconds and is enumerated
>>> on the bus.
>>>
>>> Now, when I let the kernel control the power-domains, the device
>>> comes up at boot, but isn't enumerated on the USB bus. As soon as I
>>> disable autosuspend for the port, it comes up.
>>>
>>> Is this something that needs to be fixed on the USB driver side or
>>> is something to be considered for the GPCv2 driver?
>>
>> So I think this is something that needs to be covered on the USB
>> driver side. I would expect that a device appearing on the bus should
>> resume the autosuspended bus, but I don't really know much about USB
>> so there might be other things I miss. For now I will disable
>> autosuspend in this case.
>>
>> A different, probably more severe problem is that I was still able to
>> reliably run into lockups with suspend/resume and the GPU. I thought
>> I had tested this before as it was one of the things that already
>> failed with the previous implementation, but I must have missed
>> something as it still fails with kernel v5.12.1 + v2 of the GPC
>> patches.
>>
>> This is how I run into the lockup:
>>
>> echo mem > /sys/power/state  # Sleep
>>                              # Wake up again
>> glmark2-es2-drm              # Use the GPU
>>                              # Device locks up
>>
>> Peng, is this something you can reproduce?
> 
> I could reproduce this issue on my last GPC+BLK_CTRL series. This was
> caused by a bad interaction between our slightly unusual way to control
> the nested power domains via runtime PM and the system suspend/resume
> code, which lead to some of the power domains not properly coming up
> again in the resume path. v2 of my series fixes this issue and the
> above sequence works as expected.

Glad you could reproduce and fix this issue. Thanks for the effort. I will try to do some tests myself soon.

Thanks
Frieder
