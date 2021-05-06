Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA4374FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhEFG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:57:39 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com ([40.107.1.127]:23108
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232904AbhEFG5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSTwpvtdyOqNsM0xGqbKOm071DmUwF4VmWCGXwOWrFWQXVezwwaQ1DR0M575bka6DEMmNYHwRA08tdFBumluTAzdYx4cYeD/RRlTqkSVev4lR1ksmoZFOGNv4b4sREe7F7r0DWp9UzI/wNAaj932NLEuXDje2tCEIVPp+OqBSVCsxwxlAiFtEGnF0dEUgLgQltw0twT844NktIiUgNsWFBZ/Kl/s4Sr+fwCX2zHceNSG92jp1rd1dnI588yKx0pUg2RCWaFjf5fGIuHftsZNma9TRX+367Uu3QX5kUxXWf+WPR8R0I9GZbHvl3mRRbvvL6oKefnkAlAhI049W0uv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qryp2D8iNMgl67CtXn5tvpLeRqjT/vrfshFoO6Ta6xM=;
 b=E+hPPQYnUqbONHhp1Y2jAd1aXUGW0UkhN6nK5J6f91arA7ZaYJB/4+1sUEGWEjDZR+anjYCL561L8rTb0tCW1A1Olixl086FhDOAV5MCtCzIqeZMhRK3r0MjxIiGDPQvfivbID/q/in3n09G1gHCd4nWVj9TTOtYjlECcYgME+IAsrQeo/Nff8aK5rylptTdi7MGq7o7xBAqzyNKEwqG5i5jpGstzO0fEG25iu6bUP9JiZOvQhWhNRK2FP5xg+7UFYTvM9XAuNpvaHEgKy7m+Tvs/wevKYwAAENSCU1q9R7IEFwVjXSGCtNok2VpZoY1PVOdaSkW5ep8HC6lhusTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qryp2D8iNMgl67CtXn5tvpLeRqjT/vrfshFoO6Ta6xM=;
 b=SoXm1zo7YBQag1M6rAhlCvz7/wX4tp3ZNdFeHV7erWoPvHxtTCOZsX9QhqRZtrSPlePBkbmn28wylDYv7zGkkCZoBY/JKcohMbFVQbbq8F0MKLN1KoGEfk8aJdDxJvZtnmvh2R5AOBsDXavlYqGfz7jBAf3UEVLEcBAvT4TRXas=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB3986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 06:56:38 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:56:38 +0000
Subject: Re: [PATCH V2 13/13] soc: imx: gpcv2: move reset assert after
 requesting domain power up
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-14-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <b0d9eae3-0f3d-acf1-8553-0a80e6f6c96f@kontron.de>
Date:   Thu, 6 May 2021 08:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506010440.7016-14-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Thu, 6 May 2021 06:56:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf7e457-d51f-42d1-d3d0-08d9105c1878
X-MS-TrafficTypeDiagnostic: AM8PR10MB3986:
X-Microsoft-Antispam-PRVS: <AM8PR10MB3986276FFA752313F9C1402BE9589@AM8PR10MB3986.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twh89OYVPwObk6tSUyqEuoJw6wQSMKGn5X/BPsN19U7gsVjyFRMv19r6++rEsV8KXKvc7ODpl3/bI/L3OifA1I1D4StJmaBKe9QKUR92tCfxVlpJwnTpaE0+hwqSphn7ckTNXZa1yht9w5YJgLMkWVuN9bVTTVHMM+O1PRc53+3bm7jtHZeTnWiRlhbRenFb/RfGh2oxrQbEijCg1TzGV4/gQvCfRnhxvIoGqPvtZ29UXFVTMnZ/Jj1cG08ks6fdZPmGU0x4Zkaqob1Zfb1srgYGaQE0pEulvBcJNFUwHKth4P05J2mTej92PinJCsXzeQlGwrDmHzi+zbmcth0LiYegPg4uzmlJzN6HsGU/dvi9OENDhlRomQJKt+P6/0+yPKDobAx8hQPothcBabpdjcRWZT/xIx0/NsC7S1lHMhbafvat73UDgEAPMij8/KY6+pM5vIqz/x+yYCVqW4Zo0h+FU2HXWBQw/nwMUMZBzi9Bx9XNWXtIDGJjspCWI6edca9D2b/EvG4lE5bTNwp31kpX6KqXi+yGSxiQjAHTS0VMvJevTSuDLCAkhroUHRVKZvbjqHGQBvxuyFXGYkkZW7JoDaHZtGz/rGghA2rZCilInro4Eayzk4w82SMPr2bHSFz/DkU3FZFDqhUGeiV1AAFx6v52YR3hmeSe239MIAqOXRuQcdrIXm0nTvFUC0OT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(2906002)(38100700002)(83380400001)(7416002)(53546011)(956004)(316002)(86362001)(16576012)(31696002)(4326008)(66476007)(44832011)(8936002)(26005)(31686004)(186003)(5660300002)(16526019)(2616005)(6486002)(36756003)(66946007)(8676002)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZkdnYjhHTm5oc1d5aUVVcS9GeGJnMGsvOHM1Mzl6SkdYTWNZaS9NdTU2SFF2?=
 =?utf-8?B?cnBsZUM5TjRqYWVOVjFPcWpHK1RmMTJzc3Nqa3Z2UW5BVnoyR1NtaUpGY2Z2?=
 =?utf-8?B?ckdXRlpuRVZyTzlVRkVIVXhxbForUThFWVl3WlhjS0cwMWlyVGF6R0hoemQx?=
 =?utf-8?B?b0hDbGJseDFFQkdQVjB5Z0NCajdVR3RWNWpTUkU1MnZ1d0Z5U2Q1emRIeDd5?=
 =?utf-8?B?Z2NncGIwaGJnZ3ZObm5wQ2d3amc3ZFE5aVVMREhFSVhiRlVEUGVNTWtiUmxO?=
 =?utf-8?B?c0tFU0s4cFI3aElJOFc4b2xvQjBlN29GVE9YSldQZnhpVGo3d2NUMGppVVNm?=
 =?utf-8?B?TG43ZmtLRjBVS01DRXpZSVNqVDlSQzdHV2JHcVdLYlEzMFhFZE5TVXJLVmc1?=
 =?utf-8?B?ZXhGYjJzbC8rM0NyNWQ1Z0JHdGE1QTFOYXVJZm15ZHllUFN3ODIyZkdRZk9K?=
 =?utf-8?B?dTNFQzVsUkZrTDBiT1hPd0hDcHlicEVUanNETWp5Z0ZhTmhPM0xCWVB0N3JJ?=
 =?utf-8?B?WDJVYUczaWkwdnNrNTNjRTY4Ym9ZSmtzVllKNytxTVo2NTlXVVh2R2hHU0xk?=
 =?utf-8?B?WjZvYVdoUmJlUXZrTW5kNFdwbVpHZU56T1liTE5aSkM5aW85Q1BicW4xOW11?=
 =?utf-8?B?OGtVaXhPeVBDVTBzWHhDQWg3L1lsUkhqMnA1RzRTTTBJSE4rUm9NeGZGMDUv?=
 =?utf-8?B?UmtQL1dnZlkveU10enhieEluTWc0a01qSEdpQ3RFR1NGa3VoeitWSlpFaXZG?=
 =?utf-8?B?ZzN6aHhwWlpiQzJkM1BTZFVKM043dGRHMHNabFFjRm53cmYyWHEwMVpzcWtK?=
 =?utf-8?B?QXRiTDA3TVJ0aS8ySlNHRXgzSlhZMFhsVDNrdHVvN2M3d052cjFPNTJMMXlo?=
 =?utf-8?B?MXVyQlNZOFBzRzBLVFNMb2dyVmRmUTREb3pPTGU1OWdlTlpxa1BEdkV4Njdl?=
 =?utf-8?B?ajRFLzFFdVdTa285UER0d2szdVRqNGFIWlRXd0lnM0hVNVdPZkxYYUpRRnpq?=
 =?utf-8?B?T2RGRTNaZTdjcXpCUytESmFDbHgvYVRXSDYvMWduL2lmazg2amNOVE1QUGwv?=
 =?utf-8?B?R2tQK2NZays3Z2U4cWxuaFNqSmU2WXFscUxWU2ZuQTZmS1pZUWNtODNoeTdo?=
 =?utf-8?B?aXlMZXdrSmtSQWVTVFBydGw2SFhCM3VWVW1sZ2hQS21qbG54bkttS0ZGdVl4?=
 =?utf-8?B?VGUweXhjQlFsNXh6SDFIMkE3ZU9jMmpDZFdRN0U5NFl0OGtjOW5zdkkvMUw2?=
 =?utf-8?B?ZFY3bFVTUjkzeEMzWFBWT2dyRkhTVFlpb3MvNko0U2Q1YWpiS29DZVFuUmNx?=
 =?utf-8?B?ZEJMWjkrZFhYMlhQVU5ERVlmeEZHTFprUzJTbzV6MjBhNjdTQVNWS3g2VTdK?=
 =?utf-8?B?dm5IczZ3QitCQXBxR2JuWHVFTlVpSE1nN2xtUFFxL2w5QncrdWVaUlI5Ni82?=
 =?utf-8?B?RmtEWGlIVjBLSmNxUVJySkVlMWNBUW9RUllQSGh6UDNxWWxaU0Jzdkljc0VS?=
 =?utf-8?B?U0VCSnkzYXZqalJXamo3c3ZjYkVaS3pnWitLcTlUekhqQUhKc1A5b3JMOXli?=
 =?utf-8?B?cGQvbnc4TUwwb2pwS3N6TFBkRzRnVTR6RnBwRWlpWURIcytEcTNlN0VPSHov?=
 =?utf-8?B?WHkzQWNTSGw4OVdReU1Rd2pZa1pabzNoclZQWHoveTZVN3dGbXJTRU5BMXVO?=
 =?utf-8?B?OXAzN3hCQ1Z1RlgzTDBFUDJZbGpvRDlTREdLdGpDSHJrL2NacU1YdWVoQW9x?=
 =?utf-8?Q?QJOf4i6wepFg+40G++mfqghNADWXsNPtsN/yI3l?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf7e457-d51f-42d1-d3d0-08d9105c1878
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 06:56:38.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWdXTvVpFZXtngwHubvAXYQpzN6Gs1PWbjzu2VDMc7Y/rHlusUD3PoM7hwq/3NbFRsBAWpmips8E+6UM0+a3s7qr1lie8dOwUpFhOUfGwLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 03:04, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM VPU power up sequence is a bit special, it must follow:
> 1. request power up
> 2. reset assert
> 3. reset deassert
> 
> This change in this patch will not affect other domains, because
> the power domain default is in asserted state, unless bootloader
> deassert the reset. It also applies to GPU power domain.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I don't really like that there is a dependency on TF-A/bootloader as we never really know what they will do, but from my point of view the approach is ok and it seems to work properly as far as I have tested it (only with GPU).

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/soc/imx/gpcv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 65b562cbcc6d..325a34833ffa 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -217,8 +217,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  		goto out_regulator_disable;
>  	}
>  
> -	reset_control_assert(domain->reset);
> -
>  	if (domain->bits.pxx) {
>  		/* request the domain to power up */
>  		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> @@ -241,6 +239,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  				  GPC_PGC_CTRL_PCR);
>  	}
>  
> +	reset_control_assert(domain->reset);
> +
>  	/* delay for reset to propagate */
>  	udelay(5);
>  
> 
