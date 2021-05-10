Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25683377CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhEJHPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:15:43 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:27905
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230002AbhEJHPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7h80FlzngqC4b2C00m79JPFIkof7QBoFAEI1vyuaxkCUqtv2BwBjcxaq6ZMZDJoRTSHVuN5+FbM/rlmMf01feyYJGeysRyOR7yqz3ChQ+I/lhX6QGiNRqqXkbwUj7dUY1rd6oNZ7oc4pSWorGrOPyXZKYN8W/Wm/Q5jzYRNFdol+SDcHHt8B2J6Z1qqQInFpXTpImRX2iX8eDZl1HKX8XFqg5KONRYFaoPnXm4RsHlIyoRTrF1PCvrDpED0BVnuXk2ozQHPX+tCtyyE19rvaQwVz1W7Gfh0KdM8zsZpXUjDUdDio70FgocB/hkWV3Ig/4AlI8XxoFxN4HNB4seYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ttBidosx2BNGPzwAKKN4jUAH0mIXpedSPvAx7wytlg=;
 b=IlUMgAFlNnLDv8L9tJ/3bGaEXrRlLStMDkYUmimGaxD8oxm1LvPrJEapZGtOJRQayE6uuaeAfcuAAlOV5MEafaqugFvoHgUgfMCHliHjVuijGB51m3JTDfqOBnQbsOMNS9qQSpa3q5mN9+cpr+KfMLZGwBAZzHMMXTV6gpDpBcE1g1DbHku9wjWja5+9NtlD+e6NPEHyRv5zmR19hYlPi3MpdhBH4HtEQDj0wUbj/SBIwGF5mdBhpwLNCnydaotfxyZsN5xOZXLqpFQ0GJ186FVv7492JQdZkf0q3yKeE9bdJ9r4ipLevA6rMhs3Oa2RnlUNdZ/qfh9QtXlwuvsOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ttBidosx2BNGPzwAKKN4jUAH0mIXpedSPvAx7wytlg=;
 b=QYsyhmNeuzaX0AUXFAPmGZhhiAsxLFxfMHuplLfMC72I6k8vvSAOchaj4QAOqeeHi9m0fuhPLUGZgPVZFAtBqk4LyVuBG66cYPR52ccQl8hUQrZPTPV3OdMyFtw4JLsNvmrcPLCIkoL//tqVXwOdVSYESjb36lNkEQ8rZTYPAqo=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 07:14:35 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 07:14:34 +0000
Subject: Re: [PATCH V4 1/4] dt-bindings: power: Add defines for i.MX8MM
 BLK-CTL power domains
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
 <20210510040704.14997-2-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <b8fa08a8-1a07-6f19-e794-73f3870dba2c@kontron.de>
Date:   Mon, 10 May 2021 09:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210510040704.14997-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [46.142.79.33]
X-ClientProxiedBy: AM6P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::16) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.79.33) by AM6P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 07:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e907cfc-3322-423b-6cea-08d913834392
X-MS-TrafficTypeDiagnostic: AM0PR10MB3572:
X-Microsoft-Antispam-PRVS: <AM0PR10MB357230F4405886A7C2D2FE25E9549@AM0PR10MB3572.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+MMy0+aamjFWd4bk1ksjtj34vYUVTbuusrbxvZQUSEtfkH/uAXrkjyg/wZIZ0BP/4K6tipBcNebN4wHsC1lJ5Zlzp/b0NCauOXDR3jAEVZWGE04e6Gq7+ByikqZpM/MfJrtphHO9N75iN8TpGl3U6zax5SwskUUEhO40Otsvyhq6aR9E4PX8jmozypIxxu9i0Dp66uVpkeYE12QBw/i+yd08HCFfu2u6bzfPmrixCWdfsPJTKlFRcHres/xkxiw9URSOZJwlSs+ID6PZJ1t1US1nF7MFTd5JLCjW0fDdl9G2/z1RJrPUs0Ocvpb0/qCwQyXmTQAvcG1jUzSggM/UdJRJpRLcENP5LZvCr2S54DgzLWr0nw6Jwd/Qofl/s9OSlq3EodtaZU5dgBZueRIXFBlSypiiRY1Idy8N8TJDZnNqHFdovn1M0fBXCs3I6FSI9lMnqORquc7TAFWIX2HTmvgb7cEd8hWjfiugVHEQ6/UKDTtn9Xxy4L7BTD3UKG97jfW/L5alFJhsNs6mzF7AJUI/UZRGv+HMmrxAtoBaOFAx4BRkOotwLpnYhGNrYuw7bLjtrdFUYm11LlqldUhcc4KODjzqf3uiI28cwP30ZtcDWpXhIhpvlMe3JZCzCVhCtLo2+ugZZweZeFKxlcEBq934+xNjgSybbPr003sLCQDOJzVa6UxYR6HumNhtwe5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(4326008)(16576012)(86362001)(316002)(26005)(186003)(8676002)(53546011)(8936002)(38100700002)(478600001)(7416002)(2616005)(6486002)(66556008)(5660300002)(44832011)(66476007)(16526019)(956004)(2906002)(36756003)(31686004)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N1F3YXJJclFtVHc3M3pFMTQ4a0hEN09EbGdOa2N1dFpuYVExUk1hNHBRMkw1?=
 =?utf-8?B?V3EvMlFrYjFMaEwwL2xLZVpTZjc3QWpOZHB0QlVSOHk2T0pPMjFLTitXMFpM?=
 =?utf-8?B?SnplUC9oaUx1N2d1UU5KRlRzNk9JWmNJOTNBRHZxUG5Ya25GSmRBc1hCWWNo?=
 =?utf-8?B?M2ZiRkNaS3VidEhBY3haMnpTZkFQYjdqclpNTmpROXhyR2lnSFhZUmpvODJ0?=
 =?utf-8?B?U2ZrOXQ5UzJOWHJCc2I0c2R3aUhncFI2d2YyQ295WUhVYTJSWW9YQmwzQ1Nw?=
 =?utf-8?B?dzlUV3g4SkZ2ZXZhNThuUzNXbUJ6cUZoWTRUSXA2L2R1aDFqVnIwb0M5d081?=
 =?utf-8?B?Q0dyNFN2NE5QQWhjLzBUN29GQlZQMm8xcXFBL1I5aWorSHJSOHNPV1M2UG00?=
 =?utf-8?B?ZnZTVUp0VFBoRW9aMGNBZGlOblVTckdhckdUakpGVUVqM0g4S3ZsUW5YWTNm?=
 =?utf-8?B?bnNvcXJYa2owS2hqSXBhdldUM0RiSDJUNWtGVXJtdVVDeDFBQitMZ0pDdjFE?=
 =?utf-8?B?WVJyQVBSQko4VklFSkdjWVZJTHhSRWt6eUlLOUgyZmovTHNNWFNKWEVHemNK?=
 =?utf-8?B?UmFUQ3FiNWtqZ0U4ZmNGellDVEpjaHowZ08rVDZ3UXlvK2gwUEI3dlhuM01l?=
 =?utf-8?B?SDAzRlBUNHpNV2drcG5teHhJTThacHdsZzlpb0JiRjNwTkNrdU9LTEFJRWdI?=
 =?utf-8?B?WStvSFFVZ2Z3UTJBa1U2OFlqRHMrVjd4aDhlQmdzOWxkUFdScUR2UDJpM0NC?=
 =?utf-8?B?TlpVdzRtY0poWTZCL0RUNnpya0Z5ejAyV1Vqb1ozOFVleU80ZklvUERWY0lz?=
 =?utf-8?B?OVJrSXFnNGN1aGNyWjJ3ODR6eXp6VDFIVUZzb1pPMUtnQlkxSVVaWnNkSUVZ?=
 =?utf-8?B?Y2N0WGlqK0VCZTNuQ0gyMTFIb2tYYm1BaGlob2F1bjJ5VEJsc2h6V0lVdjlq?=
 =?utf-8?B?MExHdVpRc0ZJb1lOSU9nYXlvM2dYSDJFTGtvWWxJVlJUNi94VnY1SUYwZnIy?=
 =?utf-8?B?MTBaMmJvZm1VRllkVUlhQTBRNnNEUE9jQUxHcTBOV0pvS083bGVHU2kyeUtL?=
 =?utf-8?B?L3FMTmJDa2JHTittL1F0bzVRZ0FwaEE2NUkzSFJnMlhrZ1JaeUpRLzExbC80?=
 =?utf-8?B?L1lodEp4VW5pMXE2cTN3d2syMmFEaWFnaUFxRGJJSmhTeHBMWXhCeUZFYkox?=
 =?utf-8?B?NUE2Smt3anFFZ1ZaeFoxNUk4elM5SXNlUVRYSUtzVHBQVXFDbjFNYkZKSnJn?=
 =?utf-8?B?dWhvNWlCLysxZmV0TStkOHNOSktqL2xkYU50Y2xCcEVmRWE5dGtmY1VveTJm?=
 =?utf-8?B?eTE4RXhPWTRLcUpFcVFXR0cwM2lWcUNFRkdlTzBxOWFjdVJ4SEtpOXZydGl6?=
 =?utf-8?B?OGQwcGJ4bHVvTlIxekFyaUtKVXJlSktiOUxRZXNGMEkyc1N1U2FlOHNNOGo0?=
 =?utf-8?B?eWFjNHNjNmdVNnZOd3d1UGVDNUJXVTVaQXdhS0NtMERRb0xUZytHNXJ0a2Nj?=
 =?utf-8?B?ZndIeHc1TDhVTXpwNGtvZG5GdEFjUllTOGhWeStZWDNtc1ZCSWdkampreUhs?=
 =?utf-8?B?VzBZb1dOSy9IWG0rZ0FKaGtEQ0RuZDFCcFlicUgzS3N5L2ZpeTVuUGtiYjZh?=
 =?utf-8?B?ZUhwNytneUI4dStHN3BEelFSUXpaWHZqNUZsME1pQVdtdlBNN3ZXOUhpY1BR?=
 =?utf-8?B?TzVQaExEdURLWldodlltQkh1a1U5d25HVGp1ZGErYzBzK290am5qdzNlM0l1?=
 =?utf-8?Q?xZIvMDA+PuCKajlVJV2SMcqzvp2i8ay9VTimdeW?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e907cfc-3322-423b-6cea-08d913834392
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 07:14:34.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlzLvgjA15nlQhPUWwChGJuMkUgbROdnsFjwzoq0ytaFMOAc7VB5wPXFvxEZpOtDwhtH2+gYc1VUqTwSK1MAqNSvXU7oOe005UWh2QF/2e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3572
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 06:07, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Adding the defines for i.MX8MM BLK-CTL power domains.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
> index fc9c2e16aadc..a10266befa9c 100644
> --- a/include/dt-bindings/power/imx8mm-power.h
> +++ b/include/dt-bindings/power/imx8mm-power.h
> @@ -19,4 +19,15 @@
>  #define IMX8MM_POWER_DOMAIN_DISPMIX	10
>  #define IMX8MM_POWER_DOMAIN_MIPI	11
>  
> +#define IMX8MM_BLK_CTL_PD_VPU_G2		0
> +#define IMX8MM_BLK_CTL_PD_VPU_G1		1
> +#define IMX8MM_BLK_CTL_PD_VPU_H1		2
> +#define IMX8MM_BLK_CTL_PD_VPU_MAX		3
> +
> +#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
> +#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
> +#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
> +#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
> +#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		4
> +
>  #endif
> 
