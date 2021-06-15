Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918BC3A7CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFOLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:07:55 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:29314
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229520AbhFOLHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfdFLLBvYMkkt0neVIubMa0LVH/lCeLfP25ishV6b9RV2w2N4Lhso+AU9grMqZDdJbQLXBVGXwI55ncgg1BU54G2L0LzB6DP7uJh0adoGVrHhoeTlmCkWk0cah7X7NfIciQAFAXfr4gnwA1zGYGMzlzfL2D9iu1txYTqPsdIKcUVogS8gh0ntlOQLBsUXgLoggTy8CvTZmlojW4E+onNnlIFj3SPpPZQLlOlM/YSyNILsZnPX5YJD1Jce3T62wufS+U0KLzfxcaK5dupU5/5a+9gggOs2nceHFDQSkXPGGnsSk5z+qKoHEXhzhLlh5/aP1+bfAX444czSqhvRfk4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k42iFnr5tLUVvq4ByqtbKlF48U6fdUupMbV30JJSVkk=;
 b=Tj/D7I+YhY3kM9SWN6QY+Mwp2C4rv1OZpLXJyZwKmi/Cngq78aNBf5tkY7azc+T6J0+wqIvs5LdNm5/2MYbSoYRkSTSkfxk0AhBPNlJ3ATn3Do2tz1vdTHZlRWNYgybkZvchNuMQsnfQfUO4RtULDMvVPEnUJmbtq3asrJ0eux8e8ogDKID3Aj7DfNvZ5EyNv+NW15dMdM2rywB5PzByFflPmuaDQ4BC867ymM77w8O7LVMxJ44Igt7os9A0Lo12mXsLsn4z84nV4YnHmQiimHQ8/h27xOJijQ48iyHBNGzMqa/Z50CG/ZsZq0rq3/jQmoW6uCk+UnuRs63KzJ1Uow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k42iFnr5tLUVvq4ByqtbKlF48U6fdUupMbV30JJSVkk=;
 b=NCNCTCWo59uxI0unzdgpYU82FUYgMZEwjJPfq1WJm7knn/5/LIylhhgBHySYQ/DjS2KWHAGBMYCYiqQYoSNeKuYkt0/+nbGX9qu7dQ9Lxdx1ANQuL43ovuUtnh+p7pGcrD81kQGm+A419EGrYEv6CZDYzapH2U4SAZ4lGMw9Ao8=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5804.eurprd04.prod.outlook.com (2603:10a6:10:a6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 11:05:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Tue, 15 Jun 2021
 11:05:46 +0000
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20210612133134.2738-1-peng.fan@oss.nxp.com>
 <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <7683ab0b-f905-dff1-aa4f-76ad638da568@oss.nxp.com>
Date:   Tue, 15 Jun 2021 19:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0137.apcprd03.prod.outlook.com
 (2603:1096:4:c8::10) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.59] (119.31.174.71) by SG2PR03CA0137.apcprd03.prod.outlook.com (2603:1096:4:c8::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Tue, 15 Jun 2021 11:05:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a76ec5-7f01-4ade-f108-08d92fed86a1
X-MS-TrafficTypeDiagnostic: DB8PR04MB5804:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB580442B084A339D248AFF201C9309@DB8PR04MB5804.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2c6A6tFtnc0wRuFuenNNJt5n71oTqlAwswUsz6UllgO8JZzEVqjDR3zT8HCXyL6NAEAbDCbeUZHLNyGLHwpe8iAGpm5Ysy4dRXU7hlmmma6QgKNPS4u3GPOEgQIn20hTvwBAWkmvTymnXbj01bEfqhWcbCZfPZsOAT4mOs8I0p1Srud4JYEmBVZQfF2N8pWxgqArMaHj/+daUQbj+FXgUCGhsU9JaEZlZC7bNBrwhXczIvNnDTaBo1FvZcCKZNTLFwjyGDeijIx4qjCwYQCSaEDh9oZMxqJ8MiycWbKUlT78LGt3qjR00IRYdDvDXZc2EF9fF93W97ZtoUuzgr50/BbuCm8lmT9F8ose8NDGhNO+OiV8JwzMmEPnHh+X3U+MOT7N9C2TQ1UBjdn2cfSyEM76rqGMJRW7cpPGZkrqnpGv4no77SD5eAC72/h/PG8pruUQd0P2g8nsRF/vh0vtYLapju4ky+cyrhaloElYlc1BX21Zmyecu+8uGZDm7fK8lx12UfmWLKwOTY6D/pp3SrvgHmt2v2iqIF+2hEt1JiPMe/CWJ13CedySD0pv70ompaAJYvfrjPHaRo7mLheQ9brQ6cJbXMuBjcadYZeJdz5FXPyG5RaQSq0NM5C8//gBkWGkT3EeLHaJwMy07v2QWfgvUD2TKKbjdndtacrKgk0U4OuqQBN0tUnv25yHOTmNHO7zaGESWk99YDVoG9vxCRYwn05mR+5ZS8iv+imFbtpbrDRlecgD+GggYjC9erCaiMrtATOktmG4BXK1InSbeHWXrFnAzm2DGUm2EkVP8yJtb7RJWiHlz2RVP1OurNFbBdRfB4RrHnYHcR/mb4qAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6486002)(2906002)(6666004)(31696002)(2616005)(5660300002)(186003)(38100700002)(38350700002)(53546011)(26005)(16526019)(956004)(16576012)(83380400001)(498600001)(966005)(8936002)(86362001)(7416002)(6916009)(54906003)(31686004)(66946007)(66556008)(66476007)(8676002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEN2anJjTWkxa3c3VkZneVlLRVF3QjVUTjR5dkU3NjVRMWVjakM2ejJMbFpt?=
 =?utf-8?B?a1FyR3haeGRHaGVubis1WWdPMXcvc1gzUTBtdFBFbTNpdG0yVHhjMG4vb0FW?=
 =?utf-8?B?WW5jci9PZkJDRFlFOFRBM2s5SzlyTlE2NDVXWEJ1L002YzdNenlFWm1Md3M0?=
 =?utf-8?B?OEpEMUI4bHJzNk1PN0ZYRFQxQWdBa2pXd0p2OEYveHdHcjBsVWJFZmR1YXFr?=
 =?utf-8?B?L1cvOC81amRTTXRrSVVHQTdnZ1cxV05RYWgyNzAyVjdibjE5em9YOGVWTXRj?=
 =?utf-8?B?aWJqUUtvSTZrUzFmMkNrUlVybnAzdVFYUnlnNlFEcnNSQzFKUFRKdGdZOE96?=
 =?utf-8?B?eXQwL2pmYmNnSEZmRWNpMlo1WHAyVzdFR0dtL3JZMDRYdThWY1o5cTNTNDlu?=
 =?utf-8?B?YlVjOW5xUjcwdjR0ZGp4OTFQcGQ5N1ZPVFFkU01rNDN6UElEYzNWb0ZYbFN0?=
 =?utf-8?B?Y3pwS0Y3czVkY0JWa2M0bDA0YVYzREhOYyt3R0lwYTdzU0tjN1V4UGY3cTFj?=
 =?utf-8?B?bkNyWUJVL2hiaXkzVE4wdzVsdFNZYVpWMXdaSVY0MUpRWjlCc0lHRzgyWXU0?=
 =?utf-8?B?S0ZzamZqVWQ5c0tOWkRnRGR1VnhmeEhTMjRXQ2FOWFVKd1E1QnZUOWlPYnRS?=
 =?utf-8?B?b3JKc0RNR2dzSDVDdkJZdTNoQldZVURwamlXNktmWmkyZGxLZnAweWlIVTNL?=
 =?utf-8?B?c043djh4KzVCK3hmQkN3c1RsVHdiTTRkRzczcVhEYUpIdzhRaWZNc2l3M3hZ?=
 =?utf-8?B?L1hpY2hyYnRwdTM2aWFJbDVsUmR1Z211UVZVSWlRNG1RZGdHU25MMVlTRlhp?=
 =?utf-8?B?amdwSG96OCt6cXhXaXVOVTBRY1ZjdUZrTEhwN3ZVaFZmckczdmIwczU2bTEy?=
 =?utf-8?B?Zi92TEhUbHVidEZhempZUDRTMFB0RVhxWjFIUzkyMzluN3grNVM3K0xFMWp0?=
 =?utf-8?B?K2xCS1NHMjIxa2ZkeDlJT1dVRzVyYVdaZ3hqYnJPVWh3Q0RDcDFNLzJSa2Q3?=
 =?utf-8?B?MVB6M0FRL0Fyc0c0bCs2WjY5MVFjYnl4amxQamJVWXkvTHgyTVlSV3pNSjVi?=
 =?utf-8?B?Z3I2ZnJ3cWw4dDBFWU9Da1gvMjFudHVQdHY4Qno1ZVU4SGFiMHQvak9TN0dv?=
 =?utf-8?B?SndYTWlUYm9uVnhmdXJ4NUtjc3JzQ25aUGFnREt2azRTVUVzYnNLQ1VhMWh6?=
 =?utf-8?B?TDNwckNpUk5mZEV1ZC91NzV6UUxjckE5c1RNcDZQSmRyYXFDdG5GWkJsNnIw?=
 =?utf-8?B?emFra0FTQUp5UkgwWVhjaFRlOW4xL1pzd2ZjREtENWhvU2lSeEwydlc4bDVv?=
 =?utf-8?B?V1dWeGcvb0VpOE1jTW5TNHRWaDkxTFd4RnhZOHVsQjZmZFI0MVZkZW9rVXlD?=
 =?utf-8?B?anhJTDUxcmpZbSsxazRRN1Fpb0NlVEpqQmZZZnlIblpjKzlibkhkcktpaUtD?=
 =?utf-8?B?QmRENlFuVGZ6SXk3dGhBNW1XWjN3MlNVQnEzMnNwSXlNYUZHbHhxaXA0YjhJ?=
 =?utf-8?B?K2RFZGw0UENDMEVlZHhwUXRyOGZ5aEJua3V5VXF0ZkdaUzNGZ1NzMVhuL0VR?=
 =?utf-8?B?eElSSXcrMVB0RHU5Wm9FaTZEMzY0cEJGbkFKM1pGbWR1aFFMTE5lRE1YeGpJ?=
 =?utf-8?B?ekprSlpJTDdHbDFMamp0b0RYdkVSSS9OdHlyZWlRUnl0UjdWUFZzNlRQNEZ2?=
 =?utf-8?B?aUxhZVplZnJndkxLSTRJTXEwQWpjVWJCOHdteUpNak5XUVh6VWl4RUNCU2VP?=
 =?utf-8?Q?iBt6XDaKabdZzhENeYCmRi3UPQ1gE8Vlsy5Mqjc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a76ec5-7f01-4ade-f108-08d92fed86a1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:05:46.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /puRBbpTlMDDIECNqSGrF+FHi/Z+VKYwqPnI0UhP+UNR5fySFwgyg1VQ9mv51mfYWPdlSq37bAAOBdaDSwaw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5804
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/15 3:29, Adam Ford wrote:
> On Mon, Jun 14, 2021 at 1:07 PM Adam Ford <aford173@gmail.com> wrote:
>>
>> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>>
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
>>> that support in this driver.
>>>
>>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>
>> Maybe my TF-A is too old, but I am not able to wake the device from
>> suspend-to-ram with this series.  I used the device tree from [1] to
>> enable both the GPCv2 and the blk-ctl stuff.
>>
>> [1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/
>>
>> I based both off Shawn's for-next branch.
> 
> I tried to enable USB with the GPCv2 stuff pulled into Shawn's
> for-next branch, and my board hangs when USB is loaded, but USB
> doesn't use blk-ctl, it just uses GPCv2.
> 
> I looked at some of the changes with GPCv2, and I noticed a comment in
> the GPCv2 function called imx_pgc_power_up.  The comment reads:
> 
> /*
> * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
> *   (reg_val & domain->bits.hskack), 0,
> *   USEC_PER_MSEC);
> * Technically we need the commented code to wait handshake. But that needs
> * the BLK-CTL module BUS clk-en bit being set.
> *
> * There is a separate BLK-CTL module and we will have such a driver for it,
> * that driver will set the BUS clk-en bit and handshake will be triggered
> * automatically there. Just add a delay and suppose the handshake finish
> * after that.
> */
> 
> I didn't see a delay here despite the comment saying we should add one.
> 
> With the blk-ctl enabled, I attempted to uncomment the above line of
> code without much success in preventing the board from hanging.
> 
> If BUS clk-en bit needs to be set in order for the handshake to work,
> should all these power domains reference it to bring it up?  If we
> decide against using the BUS clk-en bit, what should this delay be?

It is only for power domain has mix and need delay for the handshake.
USB no need that handshake.

Could you post a github branch, then I could give a look?

Thanks,
Peng.

> 
> adam
>>
>> adam
>>
>>> ---
>>>   drivers/soc/imx/Makefile         |   2 +-
>>>   drivers/soc/imx/blk-ctl-imx8mm.c | 139 +++++++++++++++++++++++++++++++
>>>   2 files changed, 140 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>>>
>>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
>>> index d3d2b49a386c..c260b962f495 100644
>>> --- a/drivers/soc/imx/Makefile
>>> +++ b/drivers/soc/imx/Makefile
>>> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>>>   endif
>>>   obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>>>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>>> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
>>> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
>>> diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
>>> new file mode 100644
>>> index 000000000000..59443588f892
>>> --- /dev/null
>>> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
>>> @@ -0,0 +1,139 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2021 NXP
>>> + */
>>> +
>>> +#include <dt-bindings/clock/imx8mm-clock.h>
>>> +#include <dt-bindings/power/imx8mm-power.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/types.h>
>>> +#include <linux/pm_domain.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#include "blk-ctl.h"
>>> +
>>> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN                     BIT(6)
>>> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN                    BIT(5)
>>> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN                    BIT(4)
>>> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN                  BIT(3)
>>> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN                            GENMASK(2, 0)
>>> +
>>> +#define MEDIA_BLK_BUS_PD_MASK                                  BIT(12)
>>> +#define MEDIA_BLK_MIPI_CSI_PD_MASK                             GENMASK(11, 10)
>>> +#define MEDIA_BLK_MIPI_DSI_PD_MASK                             GENMASK(9, 8)
>>> +#define MEDIA_BLK_LCDIF_PD_MASK                                        GENMASK(7, 6)
>>> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK                           GENMASK(5, 0)
>>> +
>>> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
>>> +       IMX_BLK_CTL_PD("CSI_BRIDGE", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
>>> +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
>>> +                      IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("LCDIF", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
>>> +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
>>> +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
>>> +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
>>> +                      IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
>>> +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
>>> +                      MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
>>> +                      IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
>>> +                      MEDIA_BLK_BUS_PD_MASK, 0, MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
>>> +                      IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
>>> +};
>>> +
>>> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
>>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
>>> +                      BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
>>> +                      BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
>>> +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_RESET),
>>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix", IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
>>> +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
>>> +};
>>> +
>>> +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
>>> +       .reg_bits               = 32,
>>> +       .reg_stride             = 4,
>>> +       .val_bits               = 32,
>>> +       .max_register           = 0x30,
>>> +       .fast_io                = true,
>>> +};
>>> +
>>> +static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
>>> +       .pds = imx8mm_vpumix_blk_ctl_pds,
>>> +       .pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
>>> +       .max_num = IMX8MM_BLK_CTL_PD_VPU_MAX,
>>> +       .hw_hsk = &imx8mm_vpumix_blk_ctl_pds[3],
>>> +       .config = imx8mm_blk_ctl_regmap_config,
>>> +       .name = "imx-vpumix-blk-ctl",
>>> +};
>>> +
>>> +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
>>> +       .pds = imx8mm_dispmix_blk_ctl_pds,
>>> +       .pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
>>> +       .max_num = IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
>>> +       .hw_hsk = &imx8mm_dispmix_blk_ctl_pds[4],
>>> +       .config = imx8mm_blk_ctl_regmap_config,
>>> +       .name = "imx-dispmix-blk-ctl",
>>> +};
>>> +
>>> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device *dev = &pdev->dev;
>>> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
>>> +       struct regmap *regmap;
>>> +       struct imx_blk_ctl *ctl;
>>> +       void __iomem *base;
>>> +
>>> +       ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
>>> +       if (!ctl)
>>> +               return -ENOMEM;
>>> +
>>> +       base = devm_platform_ioremap_resource(pdev, 0);
>>> +       if (IS_ERR(base))
>>> +               return PTR_ERR(base);
>>> +
>>> +       regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
>>> +       if (IS_ERR(regmap))
>>> +               return PTR_ERR(regmap);
>>> +
>>> +       ctl->regmap = regmap;
>>> +       ctl->dev = dev;
>>> +       mutex_init(&ctl->lock);
>>> +
>>> +       ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
>>> +       if (ctl->num_clks < 0)
>>> +               return ctl->num_clks;
>>> +
>>> +       dev_set_drvdata(dev, ctl);
>>> +       ctl->dev_data = dev_data;
>>> +
>>> +       return imx_blk_ctl_register(dev);
>>> +}
>>> +
>>> +static const struct of_device_id imx_blk_ctl_of_match[] = {
>>> +       { .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
>>> +       { .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
>>> +       { /* Sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
>>> +
>>> +static struct platform_driver imx_blk_ctl_driver = {
>>> +       .probe = imx8mm_blk_ctl_probe,
>>> +       .driver = {
>>> +               .name = "imx8mm-blk-ctl",
>>> +               .of_match_table = of_match_ptr(imx_blk_ctl_of_match),
>>> +               .pm = &imx_blk_ctl_pm_ops,
>>> +       },
>>> +};
>>> +module_platform_driver(imx_blk_ctl_driver);
>>> --
>>> 2.30.0
>>>
