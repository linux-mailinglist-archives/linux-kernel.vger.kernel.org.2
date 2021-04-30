Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4CD36F528
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhD3Eo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:44:59 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:53344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhD3Eo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGjsQZMKDD+ZCLo5BPr+S3Gg/Lzn6N9CXqFRGjYVMuAaokhiIOcq4QRCUOm3MWqnGHXPgwc9ZRYyFS89NrRWxE9xAXdr/cwycuJDPy1bbHtbrg8u/kRk/8C1FxHLhpt7t14uHqbIJfP7BFzNeAEGVVNJjq5mdwgSisB+WzxjSd23WHD1g9F9xtdThITVel8E+VRXdDu8ij4TDf5KjZpHvYSuPWSNnIOGRb+5oTxhZ+IFjBigsMn76OpS9vSUfHHEk89T5kMnpR9ggglzErKWNy6ExJAoC1o88mQHfA4z8fDQSLeEfGmYuqY9FzUXrxqg///FC0rjm/NDbhp7hnFTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3kBXDGz3pfXh/31shjmJTGHK6S6ofBbf7IHe0LTFak=;
 b=M8bMi4ua6YeCc2FmTz9NhVZtGJ4IvoypQLVOLU77GKGLX0i89rlaE0YlOXst12OS5puK8kCnSQQ7VhjMaKuwvdtlwAZNN65NwoT4NOUuDVMkZyfqfCBrxs9i1ogSMyDZpJTg+FdREX49ReRu+WShppjw4UC4+fb8HA1OgnMYgT27Ctltaqy44W9EfVenUTE3aMS3Qd8pKyliFZrx+98c+y9wgZYJiEVelq1/tMcsmWwmxSZkMZgudP8rBfCqKInzcG/ggNssB/fnSesgPUlOH6W2MXJLbv8J4szXS396NczHw9uTxheuRjbdwbHQ7gflECLR9HnD4ivg9ghlrnfuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3kBXDGz3pfXh/31shjmJTGHK6S6ofBbf7IHe0LTFak=;
 b=bt7U2QnUS0K9gjjCLsRhf8q9QOvTlWdj6MT2FZvmhff+Qq2DVDjMl1Rr3YcI4sq8n2AeB5xXH12QUc7179XM/NKiz4PJ4uzuXOWC728sQHI/2kwIkaKdkBh2KYRjAj4Pd4tkvlDfieHTADWC0/IlrYTGawF36eEi7ASk40D2D7w=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5803.eurprd04.prod.outlook.com (2603:10a6:10:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Fri, 30 Apr
 2021 04:44:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 04:44:06 +0000
Subject: Re: [PATCH 13/16] soc: imx: gpcv2: correct pm_runtime_get_sync usage
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
 <20210429073050.21039-14-peng.fan@oss.nxp.com>
 <08d8573e7395b341cdec55ee4f92d8cd3da7d0d3.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <90148b7c-a375-bc1e-1000-7452b702bc42@oss.nxp.com>
Date:   Fri, 30 Apr 2021 12:43:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <08d8573e7395b341cdec55ee4f92d8cd3da7d0d3.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HK2PR04CA0079.apcprd04.prod.outlook.com (2603:1096:202:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 04:44:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4f4a9f-acb0-49dd-d07c-08d90b9295f3
X-MS-TrafficTypeDiagnostic: DB8PR04MB5803:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5803935CC0BAC20DE4501AEDC95E9@DB8PR04MB5803.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xZLpfOX04vfKzPmRI5SBxbbB+fz/BKiULBQIW/+QWRkD0H4j90dPcf7UoFF9sBHfELKh1bA0a8ZxcUXAGvdqN1/OJqTvb4Y/SC8Z4hU9JQSrG3sA++sBov1AdIAFRW2nMP112NCqyPZiyuYrNsKoYuRdbJdHQ42bX03Hl+cTECRa3u1i6UM1Rq9FrtHSFoXlxM8MW9HoX3UYuMyqmn0Y+FDcgleCMC130aOmLUth2PBOwvhYNUXcrznlbUfndVtGMgEBLeN5ImqSyIe6t9xM9OICeQuGnuSAt+boMNlXIGdd4NuZUyIsRVE1X6uO7lDQ0IYf8rqL4Mw/Pel42ummtbfE3OWdTHgMPfGLUU89xZ3zFEHAz+mv9GGagrNCQMUnn+Wg9m+rV3g9nJIndrOerbh3cpbMDgEvVWySQFS40fqncAajrIU08C8Fuprhz6xTresysFRLg708bmQDw0t1Nw1lamUPrWfPcYzj0XaXxFSgZ0E/c5nagDJkcztFU9AAj39X8CFqnYZE6N7IiCkMxCLCGFmtR9hvCZ69nhIMzyTdumjHHYXTtCL/pPZDCMJUIm12L35+vRdza1lD72hwqGEqJZx4VIOVhpQbNSrPTbrGOlOiyw7pg/76mfRQHAYPTo6kq6jZv/W+TyNnY4QWo4EoxyT+nca7uC082Xx2f/bxs7h/pxYV1NughWSvbr1YS7qjbFODjGLzAEnC3+PBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39840400004)(346002)(316002)(66556008)(66946007)(86362001)(66476007)(26005)(956004)(2616005)(31696002)(16526019)(6486002)(5660300002)(83380400001)(186003)(31686004)(8676002)(8936002)(2906002)(478600001)(52116002)(4326008)(38350700002)(6666004)(16576012)(7416002)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3FmZURyT2pFRWlnWjhpcWh4TmVzeHpaZjJtYUVpSmxOVVh1RHFRV05ueVZl?=
 =?utf-8?B?S2hjbEp1QS9iQTVRdWs5ZDFyV2J4Z3RuSkcyYmptLzdVRlNGdFFlcXRmRFRm?=
 =?utf-8?B?WU5zV3BkcXNhcGdiNWFMNngxVnBoOXRMaHZNS0tGWmFWbjRrSnhha1BDaFU5?=
 =?utf-8?B?c05YNG9OWFlXVlUwRFRhUjFqS0l5WGx3MGhtOW81KzJZSHEzMjNRY1YyeXR3?=
 =?utf-8?B?OFB1eHZCdXpyNGNqNFZuc3lodGQvWnYrRVJrTmVKZUZwNWxtcGRTTWFlT3JJ?=
 =?utf-8?B?WnBsYndUTERsRytBL1kzU3FtN1doYWVWNzBqWnAwc2ZiSjN5UG9NbFNPM2tj?=
 =?utf-8?B?ZW55OXZUcXc5R0ZKNklyZjQrcFlxaitiQjRnUXZZZFh3Wm16NER6RllHSCtQ?=
 =?utf-8?B?L3ZwVjNWYWpMVUdSL2dBOWNRZGlFWEMvQUVpNHBzSGxhbng0VGdybGJNQS9i?=
 =?utf-8?B?cDRyMWprS204YzBpWGRocCtlQTZZMzJIdkxhYnIyVFZJWm51NkMrSUpQNEcy?=
 =?utf-8?B?YVdoVTlsS0xxTi9KZEd2QzFEVy9kRnJuRjl6a2pQbXU1VTRwZ0pDdE1OZGpR?=
 =?utf-8?B?TVYvcy80UGdoMVFhdG5sdTNMeG1VY0dWYWJ1Rm1US0JyNjBtR01kUTVpd3lC?=
 =?utf-8?B?QU5Ld1lDQkFvUDB0d2ZKN0c4UWlvWWQwaEgxbC9kdnRwc2ZtZjE5QytIck4y?=
 =?utf-8?B?cTRsOEZPaTVobnQveStucjRsZXVUK3ZvYkl6RmhUMmY3a1FxdXNMZENHcmpV?=
 =?utf-8?B?ZlBBZFlzd3cvWlRTbTJ5WGtVRzI2T1l6RU94cXdYR05NT0YrS0l0bm5ESnR6?=
 =?utf-8?B?NUZpdVZDV29HdDhVZUdBaFdCdjdVMHhCcmNZd3hCZE5Mdzd2N2ZtMk9Tc0Ri?=
 =?utf-8?B?QXRWTHNoL3VYTFVHUTRSL0FTYVBOZ2cxNldSbk9DUTRRbTJna1hGL1Jua1pt?=
 =?utf-8?B?WmtzdHhwT003MmxlTHg2N2VOYWVhYU9VRThKT0paeGNRM1NwS0I0eHYraHBi?=
 =?utf-8?B?eUE0N0hkNU5vbDhGL0FxNVp3c1NPTHdyM3VSUVNRNkRRcXgrZ2tqdHdxZHl4?=
 =?utf-8?B?Y21GaXN6cGhlMko5NlFCdUxrNzJRYmpEaEp3eXNzUkVjQjhvaFdRTXVHcEtk?=
 =?utf-8?B?RHlQcnBJQnZlK3YrWk5Ra0tyckw1QjVNcDBDd0FGR2JsbmFNMW4xalFGZ2NY?=
 =?utf-8?B?bGtnK2xWcWZWMFlNN2xiWnBDMkM3TjY3SlFBUFRyZ000V21UTWZoMnhXNlJR?=
 =?utf-8?B?QWx0YXJVRGYvM3h0eDR0MVBpOTVsbzZaK1l0U2NxOVJWOXdiNENiUTN6VjN4?=
 =?utf-8?B?NTZxMkJzdks3M3FKeU1wSUpqczhxanhzanZTYnUrTDVHUnFEaGNSKzgyYzkv?=
 =?utf-8?B?YTBaeVZDL29XTHRldE1LTXpmUkk3d1YzVDN3U0NGSHNCT1hUWGEyQVFyaVU5?=
 =?utf-8?B?WXhKRUpFSlRYRzRZWWpyWkxIbWI3S3RhejBVTUwxeTVDRTlzR0JuektKM29X?=
 =?utf-8?B?RHRIMVN2NHFpV2JQcDZHZ2d3WkZwbnNNZ3Z2b2Z5bG1aYVBxUis0ZFlYU1lv?=
 =?utf-8?B?VkRHVnI0MkFYZ0MraG9mVUIvYy8yS1Rxd3lHV1VpbkZCRDJYa081RFZBNlVq?=
 =?utf-8?B?OTROdlcvTHRzSHZqcDFQVUthS0lyN1E2bjV0L0R5SFFaZ2tzSTdmM0ZEYkIr?=
 =?utf-8?B?c204M2Q4WUE2Wi9QUkdxZFZJNS9iajlBemgrREZDUC9jVjZzVzNWS3ZyMFZO?=
 =?utf-8?Q?UMV9qtSLl6p0JNbxmQOP5Ptwq67U5Kb9SbCTm0g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4f4a9f-acb0-49dd-d07c-08d90b9295f3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 04:44:06.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjBTWpZT6foqG/UmVPpWWGRDjkui+J2l6iLpecnKb8I6IZxH2QNj7PBXP7Yy+X2sGnLgsXDS2y+oKub0zIIi4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/29 22:25, Lucas Stach wrote:
> Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> When the return value is negative, there is error, otherwise it is
>> expected.
> 
> Good catch! As the runtime pm handling is added in this series, this
> should be squashed into patch 06/16 to not add broken code and then fix
> it in the same series. Change looks good to me.

Sure. This will be squashed into patch 06/16 in V2.

Thanks,
Peng.

> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/gpcv2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> index 42b9be05e1f2..d2ce47a5ebad 100644
>> --- a/drivers/soc/imx/gpcv2.c
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -197,7 +197,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>>   	int ret;
>>   
>>
>>
>>
>>   	ret = pm_runtime_get_sync(domain->dev);
>> -	if (ret) {
>> +	if (ret < 0) {
>>   		pm_runtime_put_noidle(domain->dev);
>>   		return ret;
>>   	}
> 
> 
