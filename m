Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B398389345
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355105AbhESQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:10:53 -0400
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:55072
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240705AbhESQKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnMEzyuXDy00J3d+1IC9v27zVuQXa0DOGHtJWAErJUxQxA0yjY3PEA0iQSWNoxSVd3nsvXRmFQhOWjcx6Q49p37YQyADH9IL/KIy4zv4pTbwPHLFRvo89Um776995WB7fYrY/W8x3Y7xIBxyaYfZhPdBXVq2940gm9KN1QgciZifWqwNUZBvtjAb/jsEIfnZh0u9rbbuUdH0IgMIOLrdYu6R7+x+HBIZukqfLF8mbee66LKcvt2UQbfn7MrfkxCWCuLZMl0/EIXtPX8j2DGKgPxVTqeGwQAucR/9vVtk/dWzpKJcPx8U4uORkmP/NLtJUFlzcnWjULwhV0OVmEpAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dT7wI2uZNtsXKUa9uX+VGz6GTa2iv3YadogCU+XKBo=;
 b=Lp6lApDRSNVaXzYei4m90MBkXC1rNhZ3Bs1jWZ3jHXN78DBv1l93jUYzsa6bBqTStNPo98aR6ILSqKTbdv1vH/NetMLqA46fHkhAnkcifxxdnbwwHYkjLXYMw2iuRS73McO1uVko5xOCiKBi0QFo4xcOXTWjO3//UxCWWgF0hYdKUDJXwaN6Ud/yl/BTnopXFZ7UcG97NMvU6EGEmPW8vkeptxdWj3eAznN6U+j6U8cafLXNbzkt9450M4P6aREMALGD2y5Ozr4eMzwLft2lFfJ4he6oqkNGnHMGpBdF11ygIyQbzh3+Kb2PomWKkV98YpLKzSom5uXBwlg12HyNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dT7wI2uZNtsXKUa9uX+VGz6GTa2iv3YadogCU+XKBo=;
 b=TEauUJwPhvIK46OmuoaeAKk9DCKCHNnufeXWXxXKXuG+uvW0qh6b/hcIYpgvHKnUYicTfMVqpycgQiVM7iooEu7EROxx565YTgf2yjpVamWdZD91pmI1AgHSks65akfQp+rcUf31f8V84nnCAHaWLlgz39QL253HGZGGlxNZEkg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:da::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 16:09:29 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 16:09:29 +0000
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
Message-ID: <f7937500-f2bb-aa5c-caa2-1788693895a7@kontron.de>
Date:   Wed, 19 May 2021 18:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <3c5ef283-0895-05ab-7568-0d108b761008@kontron.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.189.149]
X-ClientProxiedBy: AM5PR0301CA0016.eurprd03.prod.outlook.com
 (2603:10a6:206:14::29) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.189.149) by AM5PR0301CA0016.eurprd03.prod.outlook.com (2603:10a6:206:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 16:09:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a6af927-0156-4009-360f-08d91ae07b1d
X-MS-TrafficTypeDiagnostic: AM0PR10MB2354:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2354E1592508A270CE1ECE18E92B9@AM0PR10MB2354.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYwhEMbLmaekRqL8vLjbrmPB4bEdeRGXYphebJVRaeRL4/qVb5XQwtLy/aHVGrqORlaGhQ75U168vv1nLpl15RsLXPH/fHGRJcJkYE3hrwlkoSf8el9XTqK+ysyNYlDeaC6/5Wdz3Ur0lGLbEUDBuURr14xgG++SYE6wyEjuCfyeqw27ZOpo4xNR51oaC6h++s2RE7pYgFlndEp31tOLNWOt1JYM3Ki+wpoHT7qxCkwLoNQlOYNbxbFDngiQrysqmpsatlHdSIreffpfguFQhhtwRb7ZjymYa3utH/UVOc4v5zdn7Jhu+QqydzB5saHCVi4qsjOI9RTKoJrbgytG23KCfhG9s5Jm5ZZjyCIMCpa4GMnq/Lkr2S9Imyo+z9toV8FrMoNHQRkZFAXb+dhCaI9IUZ9fjVWpg6261BKJ1YXGyhSoeGoqZ4QK0z82KusPp1jbvTMswrNKPSzlaCZnpPzAgI1gWxMCUrmNWZRddozNN/qauw/g2lwvkbG2m9dOBvPO2dL62yjFYwtLzL7fkqbDGDEhvs10D8ZP39s2ZhZpqN4xBUlki6NWMD7V/K+OBz6au8toOuXXhXeFDa5U+WFZdQCtOFzOdxSN2phND8axGK78uLKnH4H4IjanNo8LRAgx/fPs7ItrKjmOJG5n3e1NNGuasvdzYXsc83KK5KjOOgeXV1V8cchbHE1NMe+f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(366004)(136003)(346002)(16526019)(66946007)(66476007)(66556008)(38100700002)(6486002)(186003)(956004)(2616005)(4326008)(36756003)(16576012)(7416002)(316002)(31696002)(44832011)(478600001)(53546011)(2906002)(8936002)(26005)(8676002)(83380400001)(5660300002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFN6eGs5U0xTcSs3REVBZ3lWN013a0wwNlFoa0RRK0N4YWdPOTNoL2tZSGg4?=
 =?utf-8?B?aC9NbDY4Z1RVZ09kMnFCaHJvVmxHdlBjUDdyWHBrdzJxU3pvUlZEVWVLSHdD?=
 =?utf-8?B?bndRZWVmenQxVThDYWlFeVVKd256dncvdFlibDlyelp6QWtRTXNHUmorNkpn?=
 =?utf-8?B?dzl6VmdubHIyRElKU3I1b21aVVMwK3Fac0xXViszeFVQN0RlRGoyUzdzazc4?=
 =?utf-8?B?T1lDWEo4Tng1YllxcDFkK1hzV2s4WU5PNlNBenpMWkU0Q0FlOW96MnZQcGNK?=
 =?utf-8?B?WGgvSDdQSUgxVXcxeUZXODhMYitlempuejdiWkhGNS85V3hOSG1XVjFaRndN?=
 =?utf-8?B?S0F2alJSTk0yT1QxU3F2NVNHclp0dzBySktwQncrU00wSVdIdm5qOEFuelQ2?=
 =?utf-8?B?UVpkUlNjdTZlaGpUZHdlQlUyMEF2M0l4RnI5aUtVMWRFa3JVNmtjNE5TbTk4?=
 =?utf-8?B?bHlHeVAwMkp3WlpmWkJRWlpCWDVxRGhTMmVLOUU0VU5nb1JqVnlMaTVEZFE3?=
 =?utf-8?B?M0dqczNVcFJCeVhaVjZrK0hXRWg1djJUcFZXdGhiVkJ5RkdlNmJVSkhxNEhT?=
 =?utf-8?B?YURFNjJqU20zMlU1bGtHbFVodHp5S05QTmpKMGw4V051b0plaXYzL3oxam1D?=
 =?utf-8?B?VmtydjNsS2dRaHdNcWdxaU1aZVJYVGc4c3FDN3pKcWFIRDIwSERlN1A5MUdo?=
 =?utf-8?B?UnkrR1Myb2oxZ1VZKzZ4N09NWmFlY21wTzd6QW9TWXNlZDByNTVkcGZyenNI?=
 =?utf-8?B?ekRtODEwajUyaVRwbFZhUFBEMnZJMFFkeTM3ekVjQk9scXlibERGUVpIanVJ?=
 =?utf-8?B?bUhGTmNiVkRWL0hpUHdOdHV0TDMreFkyd1VWcnUvVWlRUzUyNTZhRGtyVnZq?=
 =?utf-8?B?NlFxQzhmTUpZM252RWphbGJwRk50UWx6MExqWER5RExPY0ZwenNwR0xwWUE4?=
 =?utf-8?B?K0t1RUROYUllM1lBY2pVWGhYK1BTY1dUelNNSXVJWVM1RVRXdTRIOGdwUnFz?=
 =?utf-8?B?NWphQTVoRjFRRGRNWHJrb2R1Y1ZRT0ZwMUd6ZzFhaC9zOVVDZkF5L3paNmxs?=
 =?utf-8?B?bVNGZ21udjlPcGpjNWVSWndVdzBFd2xsZGx2eG96Y2twVkFmeEI1NDNWOGRi?=
 =?utf-8?B?bzBIbHFCKzlCbFkvakFBUjNGbWdHRGMwdFMwNU9FaFZJNk9RSVY4RmJPWC9n?=
 =?utf-8?B?Y2dleWFKNWlsUTM0Zll0T1N3WC9rUzYrTStXc0RDSVVxelpqMGxOai9xY2JY?=
 =?utf-8?B?azZteUdLZTdubnJzVVJSSTFIZ3diMDMvc3NwK2hXM0lwZ1pNZmluTDh4T1dG?=
 =?utf-8?B?elowcUpMV3JxbGpIQk9xZ2RIUmVZVzlXbFY1ZjlsZFVNcStiWWRaT3UxT3Jm?=
 =?utf-8?B?VXBmMXFCRnBHU2VRSklGcTBNSnFGekt3ekYrbHhxMXpXMURONkpML2RTSGt1?=
 =?utf-8?B?VHFhM1BIanozWEZKNlBjTVFrYWt0b3M1dmhGWTk5Y3JYS25GOEo5bEdVOUsr?=
 =?utf-8?B?UWpIT251UmVPY3BRekdGZGhNVTBlVlVHeXhGMUlGK3JKdUF1eERkMWVUZUJh?=
 =?utf-8?B?VTJjYy9VRk5zdDFxUU1mNlBLRUtUSVlkTkdheTBUTUxvVXpYZzlCbGZWd0dl?=
 =?utf-8?B?YzJEek1iekY5UmZ4YklOQnptWVNSZlkxaUdacHpERkphdUlqYlZJNVlsUjA1?=
 =?utf-8?B?UlFFSmdkNVJMdWFQNXhzb1hUUDV3TWpRN2M2UjY1UlUyTDVKb0ZWdjJtVmN2?=
 =?utf-8?Q?Vjc+3BEeisEoiKatwGO29/rTze0DrdRR69guf4O?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6af927-0156-4009-360f-08d91ae07b1d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:09:29.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYOZID1/aHPgrYze5odRLfuP6F9U9Q/kUGh9nGVBZZvU2/W1FAToZFqi8rCQQrntJ2h6o6YvHOhkzcSr2sAl/ardhBVDIAL6s5FMuV1i6yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 10:32, Frieder Schrempf wrote:
> On 06.05.21 03:04, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>>
>> V2:
>>  - Add R-b/A-b tag
>>  - Merge V1 patch 13 to V2 patch 6
>>  - Drop V1 patch 15
>>  - Merge V1 patch 16 to V2 patch 5 and add comments in patch 5 to explain
>>  details
>>  - Add explaination in patch 8 for "why the resets are not defined"
>>
>> This patchset is a pick up Lucas's gpcv2 work for i.MX8MM and several
>> minor changes from me to make it could work with i.MX BLK-CTL driver.
>>
>> Thanks for Lucas's work and suggestion, Frieder Schrempf for collecting
>> all the patches, Jacky Bai on help debug issues.
> 
> I tested this series together with the BLK CTL patches by using the GPU and the display stack. Everything looks good to me.
> 
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

So after some more testing on different hardware I stumbled upon the problem that USB autosuspend doesn't work properly anymore.

I have an onboard LTE module that is connected to OTG2 on the i.MX8MM. When using the mainline TF-A (that enables USB power-domains by default) and removing the power-domain control from the kernel, the device comes up after a few seconds and is enumerated on the bus.

Now, when I let the kernel control the power-domains, the device comes up at boot, but isn't enumerated on the USB bus. As soon as I disable autosuspend for the port, it comes up.

Is this something that needs to be fixed on the USB driver side or is something to be considered for the GPCv2 driver?

