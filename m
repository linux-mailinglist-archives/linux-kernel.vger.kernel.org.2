Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C800F38B2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhETPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:17:52 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com ([40.107.8.128]:31447
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232623AbhETPRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFeswtBKwvCCSLoTxPfKY7t11d8BgNMAi1V4ljVuc+AXI+S/e0gEmh4+i/SAVlJHqZ20uVfs6LjBzAU75nOJg59FyefjKmPLG9wzbt0n+uy0iCNTum5oP7KYCm5pUtiQJ800rtERc5t2QAkFcEuFc5W5ifgWnBbM3j0ZoSSqMjwTwBsxorUXhn1pKokDOTfXDcQHT4SWyjQ/i9neqTCjAowubZ9XBMyi5bsp5GApOWe5SmQuT5Ekm8pGhQ+4B0mFOSeaphTa12P7uZhVXLZ1Yqbq+FaRndlVSFkYtkEGUsiofa7FfRpullMLOZQwzxhX8B+ULhhbh+wqCZqIAgKrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYGjHEVrPNvdh/6J5u/7NJ/WgTlu93TXhNdJkVI2F4Q=;
 b=PN3hhVBUsMfjtMgYALIkSLi9JjPUOwIKClS7yPWcmUrBGQw1dbiGt+Cr5U7yEcv5PdzQlhlpX6sacEuYmRh0kWTUpaHSuTIeF3jh3E1+ObGMgyuFLF0Ll+0XZzi8z/zYojgFkej8/P75JFRN+XbD5nc8rr3MQjX6Bp21LUXmg2gLn2d27IKfJ2r+BDA+QdM+soJZ/UudoTvXsVA9JQrR7oFfPmW+o4eEkIWA5+upIT0N99wy+UhOQxSgJSc+755kX0UlIxUZqrKv3fUBp1XzsvU2OnZe3qIqLDznuibCnHZx3xJhYGQU8Z1yqKoZiBFPhwfvfKMQ+nKkQvp4XBuG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYGjHEVrPNvdh/6J5u/7NJ/WgTlu93TXhNdJkVI2F4Q=;
 b=Um4oJDs/rXTWMhaOUOg4ApKVIuOI056gx6Xqk6HzwhPLUqUmze4F5WMOLhHC479ijPqIMTKlhh0UieUBy9XZWOy1YoITT9bsVxz47RTjTR29/xAPKe3Bl11f4T9mODrAyWbU77EVQpweo9hOBObEXfPT356DgjAFF+PJoLlRvyM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 15:16:26 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:16:26 +0000
Subject: Re: [PATCH V2 00/13] soc: imx: gpcv2: support i.MX8MM
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <3c5ef283-0895-05ab-7568-0d108b761008@kontron.de>
 <f7937500-f2bb-aa5c-caa2-1788693895a7@kontron.de>
Message-ID: <89534836-6688-9cbd-1f33-ca78a4db47d4@kontron.de>
Date:   Thu, 20 May 2021 17:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <f7937500-f2bb-aa5c-caa2-1788693895a7@kontron.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.129.60]
X-ClientProxiedBy: AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::41) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.129.60) by AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Thu, 20 May 2021 15:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0d5ee3-546c-40b2-e575-08d91ba23c68
X-MS-TrafficTypeDiagnostic: AM0PR10MB3681:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3681F38105DE8A6DD439E832E92A9@AM0PR10MB3681.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oguGMTqTKQGt27mf8/0I2eh0qqry9A4eu/mY9HZ5kiKW3E1BJK5N1KFZYiZkHgZFTJKgUzZ2uXWNc4oWu5IV4cKSwqFLgBYAgrLMP+b8AYg+qeBgnahIcszBK3pNWCmm3vTjOkZfJ/P70vVK7revpoooK0PKngaX102FEG5j0AT5tdCOgCxjQMha2A/aZjpwKvKSWM/voIcO+fdIZ+ONPXKNv2o7xkiSVcNLZS6FMAZTOoA+tK37RaN11H66sIwIJM+EvOxJN7MXeu0EmLHaJ36zk2GDosa4qoWr/ivR4N7u1FrKTexspPBjPsw9O4a1f3nTp8SUNgX5uWj8qJBGvlR3lc3d2zOEj4n7VZt8jBoDUzLMP2hvPv3NkuTC6dJclntboHK99yb0CrMINqa38wtkl8OOBKpIE6QPJPKjzti2Ue2mfk6YZpVpcx4rDDHiUh2iqdKinNtcdbYP0ylIW4x1HMCvCSaVD0H8FTGj5laVxptrejYaMBs9Xs5SM4y8s6gjJv57RmBDZ4VDRnYNj03SX7aq3tQ7VcpdBK0rDAmyGM4izmM1UOGk+AL4FAcNZsZXI6rXo8nSyiwSvmKXhlIU2CFo+AVOwuKSl5aLzVpsNxHorvL4Rzelvr1rjMUWAIDyzTie0EVCgBD1mGK2KbNAZ/Z4lKjoztq5HzM++R2CXZU4VhgmebYtWtif2pcm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(38100700002)(478600001)(31696002)(186003)(5660300002)(86362001)(4326008)(53546011)(7416002)(2616005)(16526019)(8676002)(16576012)(26005)(8936002)(316002)(44832011)(36756003)(956004)(83380400001)(66476007)(66556008)(2906002)(66946007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bndOVURsblBlSDJhcG5UdGRZd0doTm81L2VZYVZCdmJxRDQvM0lxTHlHK1hz?=
 =?utf-8?B?bVZsbGJGbXdvZmFTYVJUa2p0R24wOXNRRG96MUQyajZQM2lpdVF2YkJaOERE?=
 =?utf-8?B?MXVWWHVDR3M4NmlNYUdST2s5SXdLVitBUzhaVkdqeStPUzNPS2hTSVRpN2Mr?=
 =?utf-8?B?OVlQNHhwZDhBdUFmUzhhUUNHSGZraVRiZ0FoTW5nUVQ0V2gvUTM4ZTJ2TU1i?=
 =?utf-8?B?a0ExRDJPV0lodm5ZVlVvVUY4L0Q0MHhQSnhPOEsxZ1V0bE5CZU9kTUdiN2NY?=
 =?utf-8?B?OXZ3K2V3ajM5N09IUWpyTmZWaTBLZGlTdVo2R1ZRS2ZZMDFJcll6Rjd4aVlB?=
 =?utf-8?B?emhRYklSNFNSQjBZTDc5Nm11dk1VUjllSUlQdVdQNG16bjRuTmhyZ2lsaVY4?=
 =?utf-8?B?K1BMV2NCT2F0YnREamJPZFcxOUtmY3RxdHhmc0dRZEVzSkZuVUR5dTBHekJq?=
 =?utf-8?B?WnEvVzU0NDJYelRKRUpGWWhUZ2JxeDhvdkh6WFJQSzlGYUk2NzJsTkJUdHM3?=
 =?utf-8?B?eWJ0V0dXQUs0dG9wQks0djg3MGc2RnJueWlvUW5JZlFMSGtHcjNLQ21HZDU4?=
 =?utf-8?B?ZlFFeHMxZHJsNFdwS3FhblM2QTJUWU54NDM1N29sNFZiaVpJaVpjRWhsdHhh?=
 =?utf-8?B?ajR0dkFnWlFmZG85ZUpMamhWakdhYnFOdi91YitKS0RxU1Rld2diZzlJTEdP?=
 =?utf-8?B?ZUhOTWNJMGhGTkNNVDlTV2tWUkJRT3FjRyt3dnMzeHFWSWhzTm0xRjFxYlE5?=
 =?utf-8?B?elVZc3FTclRpTXdpVWZkSGxkWmRtZTJrQWdWVHQxRTRIQTk3b1ZQdUpmOVZD?=
 =?utf-8?B?RjI4ZWpMbHloZmU4Y3JTY1pvQUFxSVU4UnJiaXdZRnRjelhZYXdjU2c0MnBy?=
 =?utf-8?B?RHJFUzB2NnF4aXhmV1Y0d2V2QUFlVVJFSGlCckh0WDZ4bVhNbWRyWTVLQnZZ?=
 =?utf-8?B?TTNCbGxnTGh6UHNyWVlubFNkazZKZDZvZXFPSHNpQUZLUHRlQzFmazRub0RM?=
 =?utf-8?B?UkZqcEpIaWVhb2dWMTVMMGMybnd3NEhRdkUyTzJOSjcvelIwZnFMUWVXaUpw?=
 =?utf-8?B?bUFFV0pqMGxnZUgrYStxYmdTRytjU0JyeVNDRzhBK29zUlpPWDQwMWF1aTJt?=
 =?utf-8?B?bzBDTm5FNjZoUDFnbFc1NDF1VFJBVUQ2ejVDcncwVnZjS3N5Qy9CVDhQdXVN?=
 =?utf-8?B?cm1QYWpCMkZWenQ4L05qc0sxS1VpbGZNYWxGR3VublRLZGxIbEVzdmNaMmpJ?=
 =?utf-8?B?Y2t3T3JjQXY4dWFZd0tWMnMrMW9tMGE4QWo0VmRicUpYYmhnR1NpYk1iS3h6?=
 =?utf-8?B?Q0oxRUw5U0tsTUYydlVqazNGWVRsVTdYNnB5eFVIMUh1MCsrdjQ5a2Z4S3Bt?=
 =?utf-8?B?RURnbmtNTks1UXoxSXVwVXJLMHZBWlorOVdZVEc2a3Y0T0g1K3lVcnp5dDBI?=
 =?utf-8?B?UWRBb3NkNWtlNFp6S1dLNnVwOGhQb2lnODdMYmhKQ2lsRGtHc0N4ZGNHZHl1?=
 =?utf-8?B?ZlhvT1A0N2oyYlpBMmFoampCYjliSzgranVkSkp5N29nWC9EM20wbEhWeEpl?=
 =?utf-8?B?L3lWZCt1REVmT1l0VzRLM1RKUm5uV3owa2ZERklUQ3RBN2s1TGZlSm5PN1Rw?=
 =?utf-8?B?OUx2V1RieDdrMSt6NUdKdUtKWFdHYkQ5MlNQby9JMEs3S0IrcWZ1THc1eUVM?=
 =?utf-8?B?ck90eGg5RzlsSHJRWmtUYS9vS1d1L1NSWHdCVEpTVzV5aXZrdDJZYWNVb3pp?=
 =?utf-8?Q?h81ccmuTburcMv/jbzSjQnI+XVurRmnSK9z43rV?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0d5ee3-546c-40b2-e575-08d91ba23c68
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:16:26.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKS84QA4zQ4C69kRawd0JcFLJDJY9LfMzStcqE0N2dvdHcfgJJRvewWErkod+01Uy4z2pgjp8e7JEtxBL+6x/u4kuyl/96goDBfknkHjPJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.21 18:09, Frieder Schrempf wrote:
> On 06.05.21 10:32, Frieder Schrempf wrote:
>> On 06.05.21 03:04, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>>
>>> V2:
>>>  - Add R-b/A-b tag
>>>  - Merge V1 patch 13 to V2 patch 6
>>>  - Drop V1 patch 15
>>>  - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5 to explain
>>>  details
>>>  - Add explaination in patch 8 for "why the resets are not defined"
>>>
>>> This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
>>> minor changes from me to make it could work with i.MX BLK-CTL driver.
>>>
>>> Thanks for Lucas's work and suggestion, Frieder Schrempf for collecting
>>> all the patches, Jacky Bai on help debug issues.
>>
>> I tested this series together with the BLK CTL patches by using the GPU and the display stack. Everything looks good to me.
>>
>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> So after some more testing on different hardware I stumbled upon the problem that USB autosuspend doesn't work properly anymore.
> 
> I have an onboard LTE module that is connected to OTG2 on the i.MX8MM. When using the mainline TF-A (that enables USB power-domains by default) and removing the power-domain control from the kernel, the device comes up after a few seconds and is enumerated on the bus.
> 
> Now, when I let the kernel control the power-domains, the device comes up at boot, but isn't enumerated on the USB bus. As soon as I disable autosuspend for the port, it comes up.
> 
> Is this something that needs to be fixed on the USB driver side or is something to be considered for the GPCv2 driver?

So I think this is something that needs to be covered on the USB driver side. I would expect that a device appearing on the bus should resume the autosuspended bus, but I don't really know much about USB so there might be other things I miss. For now I will disable autosuspend in this case.

A different, probably more severe problem is that I was still able to reliably run into lockups with suspend/resume and the GPU. I thought I had tested this before as it was one of the things that already failed with the previous implementation, but I must have missed something as it still fails with kernel v5.12.1 + v2 of the GPC patches.

This is how I run into the lockup:

echo mem > /sys/power/state  # Sleep
                             # Wake up again
glmark2-es2-drm              # Use the GPU
                             # Device locks up

Peng, is this something you can reproduce?
