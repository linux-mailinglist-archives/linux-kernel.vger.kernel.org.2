Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5736F52A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhD3EwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:52:15 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:8708
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhD3EwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtJCZQ16znV0qSIbiaO/rrh18j7Nd7WEDvpKf46QqK/Q8RRt+le5IlgMb81ndFL0VAZYoqOPliS/v4jwhgJZggKcbWsWJwqJDvYM44/WmZDmtW8JYjkvL8MB4AuKROqQWPa0PrdBHMBqDEcIf214EJHHmuDuZaihdss2vvloijCeTt9ERXbyU15Kcdif0wVBCIEDzKfu7WFWyfDUKD9LEVrgGe8ZBFIIQNLJqMOehiI5nrN5dk0DThQAh7ESZBBh5LHUgQfjj/8ybvBi8ma16IjHNnQ/5VY6qb/p7Av5YYXrTl3TAvcXwQo9nwZUImwBCFeacPJnOQidRmkbntg0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5CE1F3BYqnNsaWW5ulKNNZUEfM1cVkq395JgQVFLCA=;
 b=P72ORWNr2d8KmmYszm/wWEbTNAej9pQVqryH7JSjCSNi/379X33bkXqKYGfi5O5C1vtmji7ySOx7qDW2H1if/Ej3WgPZ38wh5lcvUtMBBpG7Jos+xMbArR7py+CNEXxcO8zze6BlyORP3QEwB04aQH4hDPpGRb6rn5ZinOhU97fCwSFQgrVTyGEG4VMh9vEvZC3kjSGreNoELVLiINu0FmbQX6su4rFonMH89nIyZZrcDQG989dF4g69zcyYIWdZGTVM7t1TIuexiY6NmY1Na16N8Wm2vnBp4MxJ0fFYYfI/ZzyskoURLctDYlwsuqgiARORKQC7l4vba2HuRqFdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5CE1F3BYqnNsaWW5ulKNNZUEfM1cVkq395JgQVFLCA=;
 b=QtkbWQpiAiT2lQfoGGVpgoPXmzrMvGMhE8+KZSYrHvoZ5lxnMSFjSy2X+vhlnCk88xq2AFQkxoq2n14s7GUiHyAa+ExfK0hO11DmULpml7A1ySe1JXjqF/Nv2tzti9tnKqqryyXz7fVNgeoQdOMOHxF5ENd+8b0LA0UsSBIaWLw=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 04:51:22 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:51:22 +0000
Subject: Re: [PATCH 14/16] soc: imx: gpcv2: move reset assert after requesting
 domain power up
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
 <20210429073050.21039-15-peng.fan@oss.nxp.com>
 <43f3fd817b5d0448eeb940b4f3386d3c13680da0.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <51aa179a-e644-e8b4-a055-087ffb555589@oss.nxp.com>
Date:   Fri, 30 Apr 2021 12:51:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <43f3fd817b5d0448eeb940b4f3386d3c13680da0.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HK2PR02CA0190.apcprd02.prod.outlook.com (2603:1096:201:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.33 via Frontend Transport; Fri, 30 Apr 2021 04:51:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde246fb-c04e-44d0-4968-08d90b9399d8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB391667182A3D1EC00C29E4A1C95E9@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzhxZC5hgDrDEZge+dHde/8mTI1RrTonf4uffqhBjCb0K4t0NG4uVrE6S7Jg+ZBvlZw0nr1GnwGJ6nhF62B6IQs0vkPEKjXLvssrU5SRx5rBwwJmfIJ1S7oK9yCl2qC2+TOLz3okKFs+yGxnVtDo1lSGNko8moWKw66m032tkAsaxhQ4nFoMGaEMuq1LMp5Un5IqGBOJiHO+34MbarQnpQJ4kbCTgRJ2AQGXjWS3WAc+Yw5lq4k6swJWguhvnHgTDOpHgSU0zIVBCVHh+lssl+lOstJTjQj6E++UaxFgTo12iPciPscxczVxsyigNTs43Vcbac19KmuzWMjWghQIR8Dgoik67fb4d2VsaCEGmBlxMvqBNtuGbRBErPZ54whzeaY1MbWxIQG3KW2NHzPs6HAXDenoLT1f9ArWV9vn4o5KBZjjw6PS/anFro7Ef3ng0YN13SbsNa6XnRtcIOXYOrBlKEGJpZBMy4y4UWfTDPfhQMm5rojCongX5eTyKw520cLu2r33LotLQx9xZkBcO29o0D3J1A3jFzK7Wo2z9nVDxNFCu1SOQzNYZvwCJwyNDq2Cym8EOTpcZFVdRIpTXUwXZhOiO+m1tKok4kZvorBa3tzcqQmSW4lvJaGobFWTNiRfT1TzJstyCQa5lDTvCZuNf1cjTYB5Oa7MK1K8qE2Jr0KMz6N97B49nY2uWWLm/4u3N+IAPag1geiDjTdy/SfQ+3SX1irrGLKxOjjX+2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(31696002)(31686004)(2616005)(956004)(186003)(6486002)(6666004)(16526019)(86362001)(478600001)(16576012)(52116002)(26005)(2906002)(38100700002)(38350700002)(8676002)(53546011)(7416002)(66556008)(66946007)(66476007)(83380400001)(8936002)(316002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVdkWDM1UDg0b1F6OGV0RzlWdkRHSnY4Y045VXBGcXdnaWdlRGlXSWVtdko2?=
 =?utf-8?B?V05PYzhMOGN6ZTRhejFHRVlucTEzWFptV21WR09uY3ZtbU9PWE9sUkt5Nitv?=
 =?utf-8?B?WVkwYnl5dVRiUWlCQXcxTXhNUE1ObXF1L21qRlZoMVpLcEREeThYY2luSzI4?=
 =?utf-8?B?UlB4UDNpL0NoaENuZzFFaGt2NmZESGtWd3dEWFRzRXVvSXp5aTRMQ2gzRDdu?=
 =?utf-8?B?b0ZjODZWajhxeVhtbTRCQmFvWjdWYjV3SkFKam1GWC9adEZXb3F3cUYyMGsw?=
 =?utf-8?B?d3drV05Fc2xBTmpYdXliV3Bpd2xsUnloL1FYRDBQbjFpVWlJUGpYQXMyYTYr?=
 =?utf-8?B?S01ma3dLM21NUmlFdHpMRnZIbElBZmtzT2JkTVBFM0VPdDVsYnhnK2lIMWxK?=
 =?utf-8?B?bWlKejN2UlhwMldFc0wvbmk3MVU5eFpEOC9yQml0YTI0RExPbWVHYldDZzlv?=
 =?utf-8?B?YlRlRk43TUV5Z2dTSUxLMVh1WkwzSnpGR0ZKOTJBeG5sYWFZWXFVN0xyTjcx?=
 =?utf-8?B?ZmkyUU02SEt3Ty9yd3EzRWZpL2lTWTZDWC92UU1vMjNhcmhwek81VjVmU0Iv?=
 =?utf-8?B?dG9IaGhIK0Y1cm5RSGN5S0VwSVBGZWV4anprTmV2ZXhLOEh2ZUhWU3Y5SVMv?=
 =?utf-8?B?MmJMN3VadmJGdGFtWE56YjU0T2dwY0pLMWtWYUo2dVJSSFdVcVFLQll2L1J0?=
 =?utf-8?B?am1NWW96OC9yeFRkYlZ2OEF2SnJiS2lxOHlrL3NhYkhDeU01eFY0UUdMbjdz?=
 =?utf-8?B?NGhLY2Z6OGh0aW9xY3lsUElsaDN5Sk5DK0R1a3BqTXN2YXM5ZnMvQnZYbi9C?=
 =?utf-8?B?cmZoWFRyQ1FGbmFvTUhwS1c3Z1BaOERIVjJMTWZ6ZE5QdHd3ZEMxUytRVGNj?=
 =?utf-8?B?ZGZhRFRLOTdhUlMrSS9aWFZjUUVRRjFVdVJSMkZwMmV1ZmZKV1didG9TUCto?=
 =?utf-8?B?QUt0VmhjTW1TZFRDbWhGRnc0aTR3RFlnSDB1YW52aG85RENYMU1aLzNVaFM0?=
 =?utf-8?B?MEN2dFBRVnNSc0tkZ3ZCb2RpNUZMN1drM0pqYjZQUUFtVEpCTXAxYUZEc3E3?=
 =?utf-8?B?SmRYa1FMTGIwbUo3YUErUWhvUTRUNE5QY2RLNmx2ai9XYmIybWF5Q2lRbGwr?=
 =?utf-8?B?Yncxc3VjM3N6SXFIM1RDNm1OTHlKM3RsS1VYdC9XR244emRrMEdBTXhOaUxQ?=
 =?utf-8?B?Vmgvcm1YK1ZUbFBmZWkvSVBNa0RSMWljOVRuWjN3VkI4OHlsNEFvaHdReWNP?=
 =?utf-8?B?MXZqZEgrZUJZcm5TQ0pXRDJsZzlJZmZWMm85bFU0THZkbk8vUHlUSk41S1hP?=
 =?utf-8?B?YXJQYmpvYWx0aitCdGVDUEg4dVdScVpndzAyYjQ0SGFJYVhlY2FTSnp6UUNO?=
 =?utf-8?B?amVBNDljNXJyZHpGY0NKTlYzMkJnMGd5alpkdXNvRVhXZzhWVE82QkdsSm1G?=
 =?utf-8?B?M1RaZ3RPR1phK3dVQVh5Nzl5VUZzd1RQUTNIbWMwTkdHYVdQVjJ0YXRHQzc1?=
 =?utf-8?B?SE5lTFJQY3gvTU5iNExmS1pWRVhDU0JibXd5QmwrcXdlVGpGUGJ6WTZTdC9R?=
 =?utf-8?B?anAyYzVHWWhhdnNjeTE1bHRUcTZrekJXc3luVzByN2xBcXRDUjB5M2ltQ1V4?=
 =?utf-8?B?V1ErM1pOK2E3UVg1Y1RJQ1BkajhOWElUVVRoYi9CVVVqK3RudWJoczBCOVhl?=
 =?utf-8?B?RzQvTXdqUG9nblNuQ2JPd1ZuV1V2SmhTRlZVQ08ydmsrRmorSWU3cGFRazA5?=
 =?utf-8?B?TVAzQWlTTHU5RkRSZ29JcitvbFh4R3BRa2RwU2xUOXJibHpvOFJvSjVibVdR?=
 =?utf-8?B?YVdGREdXenhXYno0akcyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde246fb-c04e-44d0-4968-08d90b9399d8
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:51:22.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwGEz1choTG1/cs9x6rAP0m6NgOgVFeVARnJRAIx31oKBgpUXvOOf3IULE9qzlYe4Ixy2qETP3+SO3xkFHgGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/29 22:28, Lucas Stach wrote:
> Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The i.MX8MM VPU power up sequence is a bit special, it must follow:
>> 1. request power up
>> 2. reset assert
>> 3. reset deassert
>>
>> This change in this patch will not affect other domains, because
>> the power domain default is in asserted state, unless bootloader
>> deassert the reset.
>>
>> [Note: We expect bootloader leave the domain in asserted state,
>> but this may not always be true, so we might need another solution
>> to address the VPU domain requirements]
> 
> This is only about the VPU and GPU domain, where we need to handle the
> SRC reset from the GPC driver right?

For GPU, I have not tried. From current ATF implementation, I think yes.

  In that case I think it's a sane
> assumption that the bootloader does not touch those resets.
> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/gpcv2.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> index d2ce47a5ebad..072f519462a5 100644
>> --- a/drivers/soc/imx/gpcv2.c
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -217,8 +217,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>>   		goto out_regulator_disable;
>>   	}
>>   
>>
>>
>>
>>
>>
>>
>>
>> -	reset_control_assert(domain->reset);
>> -
>>   	if (domain->bits.pxx) {
>>   		/* request the domain to power up */
>>   		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
>> @@ -241,6 +239,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>>   				   GPC_PGC_CTRL_PCR, 0);
>>   	}
>>   
>>
>>
>>
>>
>>
>>
>>
>> +	reset_control_assert(domain->reset);
>> +
>>   	/* delay for reset to propagate */
>>   	udelay(5);
> 
> As this is a pretty arbitrary delay added by me, can you please check
> with the HW team or whoever knows, if this is sufficiently long for
> both GPU and VPU domains?

For VPU, from my test, it is enough. For GPU, ATF code use 10us, let me
try to enable GPU and do some test, I think 5us is long enough here.

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
