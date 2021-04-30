Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369536F63D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhD3HPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:15:45 -0400
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:57957
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229744AbhD3HPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epebPQ9AHt8SqkVkKrp7765vajp8dyQW2Zlb/3ebY8w3IlBjfOeJK8gHEGdiHoCnFFQrfiK3MKxPtER6C7v7vB/4PKvUH8DOUBtOSo3+xJEhVsIoc1IO7BlcGf9IsADQGhYpxV/74fCmHU3hpDAE50oWKjbApbIUf3CnGRSfbdQc1+wAz4lI7MksSYE8V+jeysnEuvjWx7Voa6nLQJ9koYj/qIoBG60kYpzMFcYrx9XEsanRpEvFLGs6WxSk+CWRZWG+qBJbKibjSv1jPFyCF+4x2TFB9J5Vfcq0QS7iXxo8/Mm0NM//FrJKT8SXYViOIJAPaqlLtgVZRll//j9Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38GpZfXMotGlZOkNnsRtK1Dn+oF0FV0ot30lLe+CAM4=;
 b=V1UjGH4ysMERriPuPH9zWB7NVnRP9hjOia8rWc4o7bCwD+GyY213JjZOZTyqZvutGKC3myYLnfyufiFPa9UnUIETxxhhWndgJ08xQt2TtkeWCp7mFQJ2FYwP9fsHF0F0aGQxqLdvoImS9Cv0fBlqkfofnV2//pFBsZUPWDnDT7mLhZz6bBRoWVTpNFL0ghn9RqBtoRHkxN32OZBTosWWvg/jvFnnUu884KQUD+P+8Ny3RvM6Pvktn4CRMrBjiWy7yrBHsCFvGlNiaiyMcFbWITgklhbKC0QPJMzvQ9iZ4+JCOhiyUPNMo9FrX0UUgrO4JYtm9AulYLl+cf4T+PWyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38GpZfXMotGlZOkNnsRtK1Dn+oF0FV0ot30lLe+CAM4=;
 b=IzN/MQnIxBmVsTzlfmtsivd2lu5n8xnwnaJTyYcHs8glPHwiHNNtT4p7Gpm06FrdyOC1A71dGLH/CoeE+zAhb+oYL8vqJbfDyRiVgZQekLdNoOL90vC/3UtFiJNzCNasHZix+bsdwEhOhXnIF9SYzFFhR3muTp3xc5iuhyDngC0=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB2767.eurprd04.prod.outlook.com (2603:10a6:800:ad::9)
 by VI1PR0401MB2429.eurprd04.prod.outlook.com (2603:10a6:800:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 07:14:48 +0000
Received: from VI1PR0402MB2767.eurprd04.prod.outlook.com
 ([fe80::94bb:4daf:4a4b:5d1]) by VI1PR0402MB2767.eurprd04.prod.outlook.com
 ([fe80::94bb:4daf:4a4b:5d1%4]) with mapi id 15.20.4065.032; Fri, 30 Apr 2021
 07:14:48 +0000
Subject: Re: [PATCH 16/16] soc: imx: gpcv2: remove waiting handshake in power
 up
To:     Lucas Stach <l.stach@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-17-peng.fan@oss.nxp.com>
 <abde5337ac265287f8e1225846e140e8df370f47.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <e5a94506-7bd3-93b6-b331-1cf04672a459@oss.nxp.com>
Date:   Fri, 30 Apr 2021 15:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <abde5337ac265287f8e1225846e140e8df370f47.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:c8::16) To VI1PR0402MB2767.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HKAPR03CA0011.apcprd03.prod.outlook.com (2603:1096:203:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.11 via Frontend Transport; Fri, 30 Apr 2021 07:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99cc378-9b1c-44ee-5494-08d90ba7a2e3
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429E142469C7CDCFE4148A8C95E9@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fvfhY1fYU8uxBW8gAP4cJTQFt1MiIrnENHCyfdydTjld9z0wfsbcRkVjOy6N7+lxZJIZxSx6x8lINwXTAp98LeJfn6yH7pApBGtUA1FX8/PL7vBOFpggnnRByTJZe/NmLfTgdi/RNTQ+q2GHh6Jm/qWgguiIoGC1dMiom9GUTJy7Iv/XG1yDNQORdx+qItu5+890wUZx4TCBS6uWf8sYkwOcgpBe/AXsAssiQh7cygygn4jlziWcsbBxMfJHwOKJtQA5J6CUFqVTtYheLYFmiFsXQ+zMvXGk1kZOF7kKa9fvsVusGwHaDhk/AgRS1NLbFzoRV0C7IktC7CGW5sjpORQLvFSffg2jefkDVOlh3cziiBSiiIkyLK6/RFaxIk20NGuc/AjjJxFhbBZz5BTiiTHV3dAJxYmfQb6EP1pivbXWtyjwn56xZvcUnm6G++LiDsB9hWLvWZGHAS0WWHMsjrkFyrnIugMLHlavIv65KhWsiLKU+BtVZiEgx2WesK/DD3bKzkDnDp/E+y7SP6VkO0SjpLPDpWUijTFTWLW8c2e2m1pUwYApaBlAsDPY8MGtYOR1q539KflDV64g2aQR7oAgJIRBuMiBbS70TJuG8pLlWauy1JZtbyv40u8Yc1drJxxXeZvS0rDYa/iezhDoOqRfhleLSQ1/gJHlpucPDcC0afr64AUSmbxIwHR5oG/hDBfY1MFJVqd61T0Wi6EsLoW6i5BppQYdCF8vxEBNTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2767.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(186003)(31696002)(86362001)(38350700002)(26005)(53546011)(38100700002)(31686004)(16526019)(478600001)(83380400001)(4326008)(6486002)(8676002)(8936002)(5660300002)(16576012)(316002)(66476007)(66556008)(66946007)(2616005)(956004)(2906002)(52116002)(6666004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmVHcEVhOHgybGpIVmJ1Z3BUWUs1dHpqNTUrNFJlNGt3TlVBb2JNb1phbklh?=
 =?utf-8?B?RmIwVDMyLytZOG4vVTJ1bHppMS9HTHBUVFEvZVRTN3ZlNUhkTlR3U3R6V2tz?=
 =?utf-8?B?WUQxRnRZQXFnSFFpU1RKT0NuVk9kN1Q4MHVZL3liMzV6ZUFIWHRETzVtZWdu?=
 =?utf-8?B?cUpKOUo4S0hMZHBodFRGbjJzRytRUmlWYmt4YzJuNWhWUTFZRnl2NzVGb0tW?=
 =?utf-8?B?bXNBN2RlOHh6ZGNpZGk1azJKSldmQ25WeUZyZi9USm1GTjA0bm55WUx4K1Ri?=
 =?utf-8?B?SldkSktEQTVhZzI3Z0kvcnRTd24wWE0vYnphTyt5WTlkN21NMFVtb294VTBj?=
 =?utf-8?B?V0ZwdGp6SDk1b0o4dThoSitrVHV5UCtXM1VuaGR1MUYzWmM5MGt3cDFjVXJq?=
 =?utf-8?B?Sm1IbExuT2NTM1dIQjNFcVhNblFYY3J6UjdQYW1hNkE0MTFvTWJOYXdGQ2I3?=
 =?utf-8?B?KzkvL280N2UyOXZ0dzR2SmU4TWlzY3dXc3FMYVp2LzlMTnd2Ukg1RDhSSzdi?=
 =?utf-8?B?a1k3bXFIbGIxWm9DVTRZTzIxd0VQaDMvL1pPd3BZOXhIbGlyUjVvclNiN09C?=
 =?utf-8?B?bEQ2aHBrYit5cDVmMkhuTVlFOXJLR2Fhay9WcE1GL1J3Y3ZyRWpocjcvdDhZ?=
 =?utf-8?B?NG1LODhHWXVuMDNlNVB4WjMrU3cxeC9saGIyd3VNT21xNDExWm0rYmJwdDJ6?=
 =?utf-8?B?N2pSRkZ0bzhCQ1V4TkdqU2V5TXdCdE1Mc0lKTERER3VGeXdwUi85bXFSTHZG?=
 =?utf-8?B?c1hOTHd6UTVqTW8zeStuTHR0VVZKeXFFS1JCdlNVdW4vaVp4dzFSdzZ5eEZW?=
 =?utf-8?B?Ym8yanh4V0podDl2ZFhuZkh1RXpRYkM2NmdKblVuQmRWckhTaEp5eHVvYTEv?=
 =?utf-8?B?WjJDNzhPUjE4SDcvTVpkTllKeWZTSTBwWU1xeFNGMC9aWDU3NG9PdDlKS2Nk?=
 =?utf-8?B?d1N3Q05uRTczTXhCdC9XWExNL0hObzh5NnpKN2JsYWhGZU9NS0hkK2crYW1p?=
 =?utf-8?B?aDdCSjdxd3JraHJ6cDIzYlNjZnNQOEVhNWdGTFBPY0R2eEFPUjA1OFlnVVhJ?=
 =?utf-8?B?UGx5bGNJUFdObmJnOGNwQjQzdWtXR0I2MWg2MHJDVXRMY0lqaEZ3dnZ2OTY5?=
 =?utf-8?B?QjhkaVVHMXdaTitaVFFGK1dJNHM3WTczUFNzc3ZPd29hQmlyaFVJR1M2WVU5?=
 =?utf-8?B?NDc3S3d2bTVXcjNKeW5PMmxSUDFkcUFDbEMvMXU0aFJJZ29aQ2ZzUTNBSlBC?=
 =?utf-8?B?WlEwNWwvMDBTNkhZeHJDYjBHb0xYZTc5cGozRlNWSEx4MDZGMFY4WWR4dVMw?=
 =?utf-8?B?VExBR2hlRk84MUgrM2F4YXAzMi8rMUhRZUlKUjVPcmRaSlFnQm9DdGhmYXkv?=
 =?utf-8?B?WjluUGpMRHVURFhPeTArMXIrRWZPNGlXVmhMR3VNYXVBNkppdk9GamdMaHZJ?=
 =?utf-8?B?OUN3VG40MTdONm9WVkM3dzdwNWFJL0tCclAwK0JXR3RnMi9FRGxkYm44UnJ0?=
 =?utf-8?B?SnYrYi9sWHA3R1RTY2dSQlVLcVNqYmJBNDZ6YlYrS09hTmEzNDY3MWVrSW9K?=
 =?utf-8?B?QStSclFUMkxUbHBGcGdjQjc4N096MmJwRTkxUDJuSVdvSFppRk9BWEl2b29q?=
 =?utf-8?B?R2NKd2MydnY3eWtlbzM0Vld0WFlieHc1WVNWdnhnYlgyUFVGYzZZVk9oN2Vl?=
 =?utf-8?B?Y1R5SGV6MFVaNEhwTi9rV3d4bWRTV3BIb3ovbzllVlhtZ1d1VFdNd2Vrc01P?=
 =?utf-8?B?VHpXU2tQWDh6R1VxdXdkRVU4OGpLQ2hIM1lhVnZ5eUUyQTh1UEl4UlI5M0Fq?=
 =?utf-8?B?ckhqYnhCaGZlNDJYeXAxZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cc378-9b1c-44ee-5494-08d90ba7a2e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2767.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 07:14:47.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM3Snmhi74/LDLau2GdZ05QWBTJosEJD9c2Pcvk1ZweLO2agUyyXXpOGuY7fdmjQyzfcPCTCGR69x+vEJuzBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/29 22:34, Lucas Stach wrote:
> Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX8MM has blk ctl module, the handshake can only finish after setting
>> blk ctl. The blk ctl driver will set the bus clk bit and the handshake
>> will finish there. we just add a delay and suppose the handshake will
>> finish after that.
> 
> Instead of this patch, just drop patch 05/16 from this series. I think
> we should leave a comment in the code on why we aren't waiting for the
> handshake ack, as this is non-obvious from looking at the driver code.
> 
> Basically add a polished version of the commit log from this patch into
> the driver code.

After thinking more, for power down, we need wait handshake. For power 
up, we could ignore handshake, because BLK-CTL setting bus clk en
will auto trigger handshake.

For power down, the bus clk en already set, and we need wait, otherwise
we need add delay there.

So I would only drop the power up waiting and add some comments there.

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/gpcv2.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> index 49dd137f6b94..04564017bfe9 100644
>> --- a/drivers/soc/imx/gpcv2.c
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -251,14 +251,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>>   		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
>>   				   domain->bits.hskreq, domain->bits.hskreq);
>>   
>>
>>
>>
>> -		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
>> -					       reg_val,
>> -					       (reg_val & domain->bits.hskack),
>> -					       0, USEC_PER_MSEC);
>> -		if (ret) {
>> -			dev_err(domain->dev, "failed to power up ADB400\n");
>> -			goto out_clk_disable;
>> -		}
>>   	}
>>   
>>
>>
>>
>>   	/* Disable reset clocks for all devices in the domain */
> 
> 
