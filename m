Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D994546D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhKQNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:06:13 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:61693
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233951AbhKQNGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:06:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxZjh321exWfpMvto9h7LGfVX4VjFZkw4nHDyZOUogOj4dzDJa147reVBosUz4ZWG+5KT9COy6zIPYuAbpl/Myr+dXXPd7hd52d0KugpXth+UdywxkHLseW1CX0jIZyRAzz8+7HVfYUjaE9ln1Uj6fF2bF1tm3lubanwTUXRzj0SG2fDV/jztRu6L9PK4IgihuZPGZVGPymWLhyrb2AaRG+k/zMJlOSUQZHSAcw4UP8kR/limozLS+70Cn26e4gHRYevYx1S5Gg6Hgw0QfOCITe3GlXgj9mJl2hRfBEQqgVgdo7F7reo/5jxzcppnqmvqu31o5NJu2dqOiPfiQtAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/nMtflEQ02b6BQkufwYTZIHrMrfOJemVL1cEN9qUwo=;
 b=VMO6iqgpYeaXGvMZREhqzXfvaZ/4ODcJ4paeiRlpC0Ffo+b7pQoQ0BxWnEOVtPMhd4ofzGD6FEKV0MEWFMMkPE6IPDCzzJZ1FV3XoPkq9Nn1krHJ5x6jmWqgMX/cUpFrzT/fQOv6j6hyOJ95rH+i+NyapXB9sBXw/j7pWyl/mZ1FiIrkVGPN9YjeY+MeXRw2533bTWByXeX7zvNtDD2iK0HyXIWmO1ga7Nt5dLT5Y4bGpO+i+cILo5+35+sUctAlMAcqChHeFicm+hDl72styuQ+n+rgycqZPEQm00Zuucr9uH0xS+mnJbHZXBfXtBqrUIyVv7wL4nAP8hJg3m0jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/nMtflEQ02b6BQkufwYTZIHrMrfOJemVL1cEN9qUwo=;
 b=O+26xz8uacOX1jLMA9aYHIfFC3R4mY/h52xpx4QEKQty+2HrhzLstvCy8sMNB9Jn727fvLMnCFQlbDuaPU12+kFoyQtsqenZjVQLEYOQ16Iwk0J6rMmHmh9mZ27EqqBm5eedgx3voRGLGgMQ9J5O6XsG/GL5hkd8OaEekq8T5LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3422.eurprd04.prod.outlook.com (2603:10a6:803:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.22; Wed, 17 Nov
 2021 13:03:07 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 13:03:07 +0000
Message-ID: <a61c7240-f053-e0a4-c4ce-f93241f7181a@nxp.com>
Date:   Wed, 17 Nov 2021 15:03:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20211111172340.fpn4pou2xwm654g5@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0100.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::26) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from [192.168.1.106] (79.115.171.37) by VI1PR08CA0100.eurprd08.prod.outlook.com (2603:10a6:800:d3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 13:03:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49548f9d-4c75-415b-d4eb-08d9a9ca995c
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3422:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3422C73AAD7DB8F5BAB9C4FFEC9A9@VI1PR0402MB3422.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kypuhli+wAkQYpaJLkchCuvcpTFqKhYZs5awbvZYarVLVwgb3pbYsZ4DD7D8Re7W2ivdU/Df1vQrx1Z0m9sMK4bD/k0uBJaykPxtvaQDGCQ8tUwWmm31xeC9SkcUnkIYsA0T/srAYMiPyufX2kGKPlarEvgPCjPhpQ1E13gFW1nQTPW1/gB+VXiLZBSn6W65cz4HFXNOpKqNt3h76QyXekBJVAtrAuhMNsiRGgFS8YJ9F4P7Y7gqRme7Hy9XXEaQvrYxhX2Jxvj/Qt90u1NA/v8dWdAcqYgt04MBFrmMvvAJ2brFS0sP9B1cTE7HILihYFEjUYq5d66PazgElufQM04Yn0dTtRnt0XWVzUPLWQ5ecL1fAqzqjw14tLjb9iookBCoYqc+CU3Q6NDrxyz7K4sp02yH8sd/ARlkc18OavweSAxcvFWW2cpXO73qICH4RNzhJgYKR1jkoRGpnUHYgcB9wA1UvSAExwGvlsjakfjzhhUTRyrAA16oBIOCgbLp2+CEGsqlSk6AQeOfsMJP+Zm7Nmwi83ilyK+96sMrSbzRAggOySKNJg+YVpIz6hfC25imeqFsat5HFkQLUch0X66j1DdHTUswKCpY9qbfC9fpii7Idwe8BZimgGKtH21jjHHSwfGNHJodCTj8SU7DjQMKJGvunkzbEPdQVzzAHox2AGriyhkfFmIvz8lGq3FBlomsH5aAetYN6Bqnq02JInTFIxsTRfGpIuBVYtgch8VePOWiYFSqgMZehn6tLkUBFvHCWTH8kAVj0sMjhQfxBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(6916009)(4326008)(26005)(83380400001)(8936002)(31696002)(5660300002)(36756003)(53546011)(66946007)(44832011)(316002)(6486002)(66556008)(66476007)(2906002)(38100700002)(38350700002)(2616005)(956004)(186003)(508600001)(31686004)(8676002)(86362001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJrbjVIRVIxSCtHUXNrT3J4RzJjalIxam9scUNKZzRJWFFSbTRmWUhPUXcr?=
 =?utf-8?B?TGlBT3hBeC95d1dvbHc3VDJRUVgrMXpkVlpWY21jV3VuVDlZRTRIdXBSaTJ4?=
 =?utf-8?B?bzRUR25NQ0VlT0VWNnJ3dStFMWpLK0k2SHhRNzRSMGF2WkNHWHJoazFIL0tE?=
 =?utf-8?B?SXM5MS8xM2RtZWJ1b3VkMEtlMUFMczMzT2pmTE1yeU5BZHhsNUZDeW1KOTdl?=
 =?utf-8?B?eHhKNFcyVU13OWsrQm0rZDBwdUUvaTFHM2hoWWVlSVNBbDF5UHdLeDZGVTRQ?=
 =?utf-8?B?aEhhQW5Wckc3Q0J1TlNNN1J6QU9JaW81dThDYnB1NEJHc1I3VU9kR01WRUx0?=
 =?utf-8?B?ZXB4YjJRc2ZybExEQjk5YllUNHRIWU82QVRUcTNhbE9LNVZTdFVhNXI2SjhQ?=
 =?utf-8?B?elNuRUd3c0VhTU11Y2UzYlJNZGpwM0ZQUktrSnlkLytkZk1wZ0R3VnRUOGxG?=
 =?utf-8?B?NmNWOTY0NUVGcm11R0F2WHNMamZTbHBZWUNLa0tGTkY2dktwTmdEWnZGVkY4?=
 =?utf-8?B?SjZ3ZG45d0w1SGV4SmlGbXdnV3dwOTk5T3JUWWVhSjVLOXByMzk3MHdQb3cz?=
 =?utf-8?B?V0RSTUtENTFWVmFzK2FWK3ltbm5iYjU0MkFHUmpqVFNqNXl1dlBISHQwbC9Y?=
 =?utf-8?B?RUVRV3VYb1RiUVNyYmRiRklFMXBmMEtJbEw4ams4UGgzbFdYQ1dRZFdabW1a?=
 =?utf-8?B?SlVTN2s1QU5HUUc3RUlsd1g4RXVhY3psV21PRVJ5QndzWmFQdEo4OWlDTU9x?=
 =?utf-8?B?ZkpTK25ZbzVld2h2aGhSR3VpTzEzZGkyazRXQTRjb2NSWjc5QnBEMlRKZVFW?=
 =?utf-8?B?L08yS3Uvc2NCQStoRklHeGFDNVAzcUJUYjNhckFGN1NaZEF3V0xXcEExa082?=
 =?utf-8?B?UmN2UGNYcWhSdnNsWlhXN29VdVZIUThMbkNJbk1HLy8wUFowM3hnMkJKVDRz?=
 =?utf-8?B?Rlk4SnFuYi9ncS9Ec0g0WkFXUjBpWjd2VUxHbWZjaWdDQmE4MzA5QTlaa3lT?=
 =?utf-8?B?RDFnVnhPS0JTYW1tbWNDYXNLd3pYSGZhemYrbUtPdzdLbmdzdHl6enJuQlF5?=
 =?utf-8?B?RWwrWVkwMjA5VlJnSWpNY0RDRWQ0MncrZWJURVhWWE5Hck1TU0lLcWROR3Zv?=
 =?utf-8?B?Uis2SmY5VDhHanhmazl6RnZyR3c3SE5NZzE0RG5lbW5VSDJacFFoWk1sZk1L?=
 =?utf-8?B?UGQ3WllVU2Q3MmhxL1NqcWcrSzhqSWtqaVVKTFV1WDFHMTEzNTh1TnJBOWtV?=
 =?utf-8?B?L0Y5TWNyVVNzall4Rk5OTnNiWEN6ZlNVYzlEN2pqNDR0RlB4dVdzd3I1QmdY?=
 =?utf-8?B?MWhWNVQ1SG85VjhSbkNpdkNiV3B2NVJaR2xFMExzcEN1VDJmWGVpbXR2aGxL?=
 =?utf-8?B?dGVaYy9Yb2J4VnJHWUJQUUdSQmg5RGNWZ2VDZFB1UldWdTEybkUyWDJhQzYw?=
 =?utf-8?B?eCtmc1dYS0JLMUxwRjRoV3NDcWVpWEFsSmpid3RVZlB4WTZHdzNZbExyMFJY?=
 =?utf-8?B?bzhEdGI2ZlluSkJ5MWtxUGlsNnFmSXpCeVI5T3RLWVF4Nmk1VWJSQkp4NEdY?=
 =?utf-8?B?S0VUeFp0R0NoL3JST25HZXZmZjJaUisyUTB3UHl3SnB4c2NEVG44MklaWEJV?=
 =?utf-8?B?djVZNW1QbWRWcGNDbFN2Q1U1Uy9iQmdFNzVuVHZQY0JtV1l4M2xXQW90OGlz?=
 =?utf-8?B?NCtDM2llYU0xQnoxamFsYWVFSGhqVzRzYllDcFAwbGlsdENlN3hjQXBlbncw?=
 =?utf-8?B?SjlXajVuZ0FxR1dqaXJSZTRobzFDOXV1T3VaaEZLMzd4TE8vMmNyVGNjUFM2?=
 =?utf-8?B?d3hpRjBRVnA3cTlQaHNNQStWNm5FRS9EZWhleStmNDBlRktNYUJHZ0wzeVNp?=
 =?utf-8?B?cXNhMUVXc3NYNStKUU50Y2U1RFludWpObEF3U25pN25LTk1JaW1iV1U0ZzR6?=
 =?utf-8?B?NnFDZ1ZZTi9kRGJudHRabEVPekpoTldrQjNTRHQzVTUxWHl6K2RUOEk4SU1z?=
 =?utf-8?B?bG02QnhTQUdJMXpYVXBONkRlUlhMOXQ4WXd2Y2xJeHhPd0w0M2c3RTRxeDAx?=
 =?utf-8?B?MS9vNk9IOC9XdHphdlFGWFVURXlWRmNKU1pGall1eFlJU09CT0NuU2VXSWEv?=
 =?utf-8?B?SjlaMGRnaXZxSlpvZW1JeVdhYzk2RW12WGxITVV2V2hwL1JESnRBUWs3blo2?=
 =?utf-8?Q?p0AHb5jOnRcCZZm3WriKVJ4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49548f9d-4c75-415b-d4eb-08d9a9ca995c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 13:03:07.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wtVAUsvtcd4xgntZH5Qs8xCmH7koeMzwWNRbe2t/zQakX9Ktb75PhXMpYDzTIYuhkt2iMJ8kr2iID664dE9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3422
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Sorry for the late reply, please see some comments inline.

On 11/11/2021 7:23 PM, Daniel Thompson wrote:
> Hi Laurentiu
> 
> On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> ACPI DMA configure API may return a defer status code, so handle it.
>> On top of this, move the MC firmware resume after the DMA setup
>> is completed to avoid crashing due to DMA setup not being done yet or
>> being deferred.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
> v5.15. It seems like it results in so many sMMU errors that the system
> cannot function correctly (it's only about a 75% chance the system will
> boot to GUI and even if it does boot successfully the system will hang
> up soon after).
> 
> Bisect took me up a couple of blind alleys (mostly due to unrelated boot
> problems in v5.14-rc2) by eventually led me to this patch as the cause.
> Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
> problem and reverting it against v5.15 also resolves the problem.

That's pretty strange. Was the DPAA2 based networking working with this
patch reverted?

> Is there some specific firmware version required for this patch to work
> correctly?

It's a bit of a long story. As Jon already mentioned, we're waiting for
maintainers to agree on the IORT RMR support on which we depend to
declare in UEFI reserved memory regions for the MC firmware.
For now, the recommended workaround is to use the
"arm-smmu.disable_bypass=0" kernel boot arg.

---
Best Regards, Laurentiu

> 
> 
> PS: Below is the revert I applied to the v5.15 kernel (after
>     a fairly simple merge conflict fix)
> 
> From 4162b64e4f361a6a773e065b592dbc5493202524 Mon Sep 17 00:00:00 2001
> From: Daniel Thompson <daniel.thompson@linaro.org>
> Date: Thu, 11 Nov 2021 16:50:25 +0000
> Subject: [PATCH] Revert "bus: fsl-mc: handle DMA config deferral in ACPI case"
> 
> This reverts commit d31e7fe20a2251f87adc6ecefbdaf25e6961ce74 because
> it was causing regressions on my Honeycomb LX2 (NXP LX2060A).
> 
> All kernels where the problem manifests (as either a boot hang or a desktop
> hang) issue the following messages in vast number:
> 
> ~~~
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm_smmu_context_fault: 1697259 callbacks suppressed
> ~~~
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 8fd4a356a86e..429bacc7de20 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -1130,6 +1130,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  	}
>  
>  	if (mc->fsl_mc_regs) {
> +		/*
> +		 * Some bootloaders pause the MC firmware before booting the
> +		 * kernel so that MC will not cause faults as soon as the
> +		 * SMMU probes due to the fact that there's no configuration
> +		 * in place for MC.
> +		 * At this point MC should have all its SMMU setup done so make
> +		 * sure it is resumed.
> +		 */
> +		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
> +			     (~(GCR1_P1_STOP | GCR1_P2_STOP)),
> +		       mc->fsl_mc_regs + FSL_MC_GCR1);
> +
>  		if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
>  			mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
>  			/*
> @@ -1143,25 +1155,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>  			error = acpi_dma_configure_id(&pdev->dev,
>  						      DEV_DMA_COHERENT,
>  						      &mc_stream_id);
> -			if (error == -EPROBE_DEFER)
> -				return error;
>  			if (error)
>  				dev_warn(&pdev->dev,
>  					 "failed to configure dma: %d.\n",
>  					 error);
>  		}
> -
> -		/*
> -		 * Some bootloaders pause the MC firmware before booting the
> -		 * kernel so that MC will not cause faults as soon as the
> -		 * SMMU probes due to the fact that there's no configuration
> -		 * in place for MC.
> -		 * At this point MC should have all its SMMU setup done so make
> -		 * sure it is resumed.
> -		 */
> -		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
> -			     (~(GCR1_P1_STOP | GCR1_P2_STOP)),
> -		       mc->fsl_mc_regs + FSL_MC_GCR1);
>  	}
>  
>  	/*
> 
