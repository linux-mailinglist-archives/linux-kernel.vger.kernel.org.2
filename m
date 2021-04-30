Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58936F52E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhD3Exk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:53:40 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:55270
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhD3Exj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G30T20j0HbB0JnrAAjss6htaS48GDVMNX8MCBzEcH3UN83tox+pgg99znuE/R3lFJ20QqtFMjJ5VMfq8G6zWxXjTjAq50CETBJRGjR6SN0VZ9pxO0J5pArkoAN/zwkAa14x7XWZKvFvJjRQeAJXLRcG32w5VzSx8YYbA/TjXNR2q3gi6bj6WfXtV8W++OCKXXqx8vg6LUBUNNZf9aMnfIvC7YY1ARshcYgDT17sxWGGxWrFJDcUIhcXNn8Dr126vZYBCAqjHH7i+jI2Cre8rOSuEuRFLClmWyyZIsmHgnY9eNmE+Z/s22UoP+dEviJHheDROqTM5uN1+Whko9h8mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkquaoc/H7d+YO663WDdqnEqoXMZI375qvwIEVfdHZU=;
 b=TTv1tMfhQDVExP6c8zM6TpzUSbMa2qvywtR2O+l+g8q2R/ZALs/IyNMcPr/o7FdsTDogJdbq48UT9NOYd7D9FlXp6vNW5B1JWY7tW73z+atqszUER8pTQnIXET3bryRqUn+2d/WFLOYrbkfiWbhPzdV2nA8LumZFAdtGxXDtOveYwF/mMhB4dmhTYvtT0q6F+1WhzniBtmCajLYKdanSr2PL10D8nKNionBuzVL9RhPCgqfCYPPAbUPoDUcacMUmVpyw8plACwvMV1qpYBouBFJscXHVrAx5F/N0uGWiVqSoc2AFReUGxOdkW/yk23n7eHvfqK4eGZaguwmEeRXzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkquaoc/H7d+YO663WDdqnEqoXMZI375qvwIEVfdHZU=;
 b=eLafsi4b9RAPD70Z+jwYxb/8ev0964Hh7rjRc/1P8/UTDvBpUx5u9dh5on7b7v/3Tnp64VOAVvEDD84lD7OpN3dIXgWDjLsUo5kXkbw0ex99+CzEUDYmlc+jPUz8Resna43+Rzh7V9PSO3RjziElaqJn3ysJ5fmdcxbU1U7ZSRM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:52:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:52:45 +0000
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
Message-ID: <cd88adf8-8d85-0a7a-6a5d-fd1d616a35ae@oss.nxp.com>
Date:   Fri, 30 Apr 2021 12:52:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <abde5337ac265287f8e1225846e140e8df370f47.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HK2PR02CA0161.apcprd02.prod.outlook.com (2603:1096:201:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend Transport; Fri, 30 Apr 2021 04:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074d34e2-9bae-4901-c1e8-08d90b93caee
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916006176EBB88786751AF8C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gziV6NPXc9VtypV0J3xFBoOkqAgjo1Hn1S5OTDbFijvK4Xal0xejQLJGgy0MfELRuEGCXJsmpKbPb8m3kzqapB/GGRhs9dOivwIx20NE46exOK1zbZIA2XEEMnQrIdi+0LpvrLsQyrMHrsDEFWSIPUByiYcWn4WzUjolB7qpeHWupd4tRIjaC2IdqnHW5KRAFviLMvI5nJ9w5gIVZMmYuHQ8h00Ll2F6+WqCWdGJ4tbCQfDXDPiQUi0auq7F9Fg/gnFkYXDh3ilT+mijbtmQmEg/+KvT/aivmZSw+P47KpbazAUexfOPxtl+fEyKQM468odssd+xx30u5jlZnHlkJCyAwMlF2qAlmE97NNhsTPiMMT1tU/R9YASTH7iGEhTlOkGXnHv+sTRzQzCmvAcvobXay1LxDIbHiM1dmxJvX4DYawz5Llf3QmOzSQ33sjU7Z6FTQqAWmaX99UgFWSUvbQ6DFif8ef74VEvTfs2dntck5XGriRuO2Y/Dc+UhEGf7SpJDCmd96XfShpiDDCPmjsvyaTytSTfh/k15v4C3Q519IjrYnKo9Fk/2+AnGouUuZbfCmDurdXMkV8I8StKJZ7GH0x2Be++9WEqrkPq+ot377RvddDd2HfyHS3YyoqaR0eM38R5I6dWBQbNN/cVt4vNymJ+QZbXjCuyu1WLFjN0VV6KhIQDx+lqA/IfG8K2R8JG78azd6BNYXvsUDP6F7A/p6PzXQz6OWyXr0VWtGzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(31696002)(31686004)(2616005)(956004)(186003)(6486002)(6666004)(16526019)(86362001)(478600001)(16576012)(52116002)(26005)(2906002)(38100700002)(38350700002)(8676002)(53546011)(7416002)(66556008)(66946007)(66476007)(83380400001)(8936002)(316002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGZEN29tcE55SkE0cFMydDArWGZoTjJScERnZzRTbFYrcis3dWU2SE1ZVzZt?=
 =?utf-8?B?bzJQeUhaOUNJbWZiL1dXN29kRmVndUxGcjk3czAydnQ3Z1JDTmt1czBtZHRQ?=
 =?utf-8?B?ZUxvQjA5eThJbUFNcXFPZlFIYkRUQ0hQZjZGNXczT0FpTldnVWYvTG1qc0RK?=
 =?utf-8?B?VEhUSDNkM01Pc2VDWkZtTzZpQmtRMlplVS9OblBWM2FCZkQvc1RpZFJZTmlj?=
 =?utf-8?B?SFhDOTBxNmRIcThmbXRiUW9zR0kxeThxV21zUjU4TVlVd3RUdzV2ZXVOTkNq?=
 =?utf-8?B?SEdzNVh3SEZlWTFUVFJlckxuaWVmZU1kcjA3akZIeERJOG0wU2xNV1VZZnhU?=
 =?utf-8?B?dzBoaHp0RnRPT0k2eW5PR2NpczBxeDdENkdvL0FwZExKZldwU01rS01IdzZT?=
 =?utf-8?B?bzQ4OUhGeVJOeEVPSGNhMDNVZDdieWxVRC85ZkkzbHdHZHROL1VqenJBZjJM?=
 =?utf-8?B?c1BieTJVWDR5UVFXV0dSUmg1YTN0M3ZDajRqbXBnY2h5VGExQ1RnQUVaM2RV?=
 =?utf-8?B?Qk1BTHFqNDJFSE9HZ2xFbTI3S2FuS0hweHVLMnBseVJpVjQxTTlJMDZHRzh4?=
 =?utf-8?B?dnNXdnhFVmJndlM4MkJObjcxRFFYYksydCt2NDhXbnVRUzdBN3lTWFFPK1dj?=
 =?utf-8?B?MmxuU253eCtMZnZQM0h6dnFEd1M0M0xWd0l0a3h6dXVUWHZqcHRadFFwKzM4?=
 =?utf-8?B?YkQzcG1rbERUUC9YcXRBekU4SWVGblpRbDJsTGY5M0gvZ1Fyb3R3R2hKbE10?=
 =?utf-8?B?T3JTbXhWOVozQkxOZEQ2d1Fzdktmd1U1a09uaEM5dHZvU1VnUlB4Ull6Nmk4?=
 =?utf-8?B?aXVoNUFCNGNRcDVKRGM2d0FETkx4Kys3VnpyeVZHN21OZi9UV1loVmRzYS9l?=
 =?utf-8?B?NmxoZm5KamtmSGtPMzJPYTJpYzdMRGNFUHFveStlN2xybFFLQ0txNjNlR0hD?=
 =?utf-8?B?dmM1SFdGUmZTenJKSktwOUt3RUpvdTFIdWg1dnMzNFJBdHA4d3NybWxyV01Z?=
 =?utf-8?B?ZURFWEM3UUNjODdMd0dPc0xab0ZteWxXY1MxVWdtbmdQdzl3UnVmUW5tNXJq?=
 =?utf-8?B?SEtuS0FMTU5LdTV0TmE1bGVnaGdJTStqT3BkaGtiR1Z6T3hDNmVrRG81TldB?=
 =?utf-8?B?WEJFbUhrT3RwZDh1dWE5WEZCclBXWjlMbDV3RG4wejNwcFlBUERjbUdyRHV2?=
 =?utf-8?B?cTdzY241U1NKZjdrM0VXbTNNeDRPazQ0L2NjcVllUVVEWENhdG5jRjlTenBy?=
 =?utf-8?B?bTdiRGlpd1dYTjVhUlBmYmlCRlVYb3pkU3NUajZSWXk2MGloWG5qZ2d4d1dl?=
 =?utf-8?B?eUswT3ZqenFPdnd1cUt2Mkh6Y2RaQ25Ycmc3UnV2SS9UcHo3M0ZrczJZRmVZ?=
 =?utf-8?B?SnFqTnB5cHFPVXJhOXlWOXpjL2JjQmNTZXU3VFcyazNDU2h4bDFnSlBZNXZR?=
 =?utf-8?B?RytnT3JzZ0RGTER4c0NRUnJlSVRhY1FKOUpUWVl1U3Fua21HUTBqZzVzT29k?=
 =?utf-8?B?NDNYWmdPeDAvbGNDdTNFOU1BQWREVEV3T0tGcHY2RFZsaUgrMTc1TFdQV1ls?=
 =?utf-8?B?UGNiaEUwR1pwd0dZakF2NHZVb1dpbE5Xa0NPMTNIZEdTcElhd3NFaXVNZGhw?=
 =?utf-8?B?bWNOTjRxeWl6OEh6TUc4d3FnUENPVmlpNUc0Q0lCUzBTVW45ZlFsbFIyK2hj?=
 =?utf-8?B?ckhrNjJRTXdNdHVUV2pPMnhkR0hiVFkzbzJ1aXYzMTRPdlZJeXFlY0FnQWdl?=
 =?utf-8?B?c1k3eFF0MUQ3cE1HbStVTzVSTHVNcGlESW5HYWdneEtPbUpad0tlSEY4b1F0?=
 =?utf-8?B?WW4rS3pnK3RjKzhYaGMrUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074d34e2-9bae-4901-c1e8-08d90b93caee
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:52:44.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egq1ShrZ91jDGARpz6ZczrJvsKVxxrOr3NZ9RK80AQeDZdqBSOED4vNFeh/4qjk+tRt41jw0RSAmHoU9HS8zAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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

I see. Will do it in V2.

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
