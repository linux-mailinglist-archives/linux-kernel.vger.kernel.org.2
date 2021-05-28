Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC294394356
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhE1NWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:22:21 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:37068 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhE1NWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:22:17 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDJQtL009416;
        Fri, 28 May 2021 06:20:27 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 38thst8qa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+zmP8ikJUzOxJd0Lk/hMDEIRkmNx1L18mfXUHmaKASqgAEDMhYm5OUdbi48QLo2FBWJlCjAw//8BmE/u5ayYk7PtWB2zbMy4GRx55qhlv2pZHoRFKE8/IfaqzJzWEsp9JNyUXB1saGsulfYi8C/0RuFHcAhN0pqxrr19Yj/fKRsNMJvkmMsBQcwZNMP+9mwcN8SeuSmcDbvfCbSxbTh7OJeTpA2hAm2TrKMDBfiIgz6EjxGxksWUqJvDf1UDSBfVQlRVhBBPpg1uYtW7P+YxSIunPhyK5Cjm+S6k4+7i7sFzxsm6lHkPJEbSAJdeGt011OeEJdxZrIHnAWydtuPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm5XwcioHMLc2PqYIult3Zg0uhRfSR/rUnQ6XBTuLyc=;
 b=iCxgkmB9CqW0JUPUy1Fll/zz0aqsoI3w9vSzYliR33CPXuIKDd0CvuHJRvHnrFJksyddLaFfrSEETOPveDIMISsfoI+y6anyXYzumEXttkvGffaSuKqkdapL0IT9Iq1Z9sKdg1JLTqnTkCTDpLwUkFH1TRDWhvttMEJoxB276vReXxq3qe5ZqwjkTljzUXr818m1j+ZXh31K5S6ZfTzVyccwQ9gCEu/PDiXyIG8cqad01v6G4MEOuUOmbXAr+5g91NO8hIgXSfUHg3p9FHhSkIqtB44TS0QBYCTnSh4QbFGZrevkuRZUO2ZtVR9ySXBen095B8tepekDwJ0wunVxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm5XwcioHMLc2PqYIult3Zg0uhRfSR/rUnQ6XBTuLyc=;
 b=kXlUczJaxbLnDUF5A97WZg4l2JXARFh8JVSxZkYuljqrsaAznkLLVEhWD3zKoaiRcXt6zdYruPYyxmpaNVb/Mm4t9ZqYACD4wm7TXNUPlkYgXGI4TuY0195CSOOfY+Zqcm/v0bS80ZlOL8Gt38dErl3ZtqwTZMqnSwIKUYSQ71E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2629.namprd11.prod.outlook.com (2603:10b6:a02:c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 13:20:25 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:20:25 +0000
Subject: Re: [PATCH v2 6/6] ARM: use MiB for vmalloc sizes
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZTB-0005UP-C9@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <0acfa653-1480-b474-8ad4-d3d7ef10bea5@windriver.com>
Date:   Fri, 28 May 2021 21:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZTB-0005UP-C9@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b65efa-dadd-4eb4-3593-08d921db5a54
X-MS-TrafficTypeDiagnostic: BYAPR11MB2629:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2629F304086EA8C79AC155F2E4229@BYAPR11MB2629.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rRoQ49lhE2/5S1SYZdlnm/4+tJGXUfsT+DCelX+E0L2b9Vev+MgC/Ea1zGQSkrkOPAQrYevzLV7oqHhLaMGIDK2L8GwL3veLPjrCXbZYkQGbGoy7bZ+H7ZR+5CNFzSwmgYboxOo5Dqzfn5Tb97hZdyPSReBCccKWfNjdVtFbP8XxTBLWy9/NYi7vfXA+2P3Py+x5PSgVBQyzuWkZsioIVRXpYscsooJ/ZkbfB08mINtR4EGxetI5FU0o+2G/w8QLAJYX7B53KbAGcWecBlrRFFL7v0rwqh8sgEe718wBRw2dbuKjjLrMqKRzRuUExOqUGq4IMOhvP6mXyJdrjkrRlBdBKTd9xh174JoFzuA/pIBfnkxQk9u/jz+mUsWHDQXPQqE9XSWhgsUz4iVQjh3OrM56PLaeSPXyTLxFWpMGNoShQIW2eNPcNyTep2X68XqHwwEckDBBuaJMeJllJqxQSZN9DlB+DedkzgNP8EoXFL7hT5XYWK3r++bnVYE0TIg81MCGo+advbQ+gqyMbZK2CP8oFfR+asvoXaYmxkNUVE72b0TuyEnfm3lHNNpvRxI/RWhIbGvQofxkvsl6GHs1APx3It4gUEWp9gcZ2qHjuPw9sJloiWA2XqdcEfo6n7niK+LGHucFE+cUPZ9Xv+d6qO9nG2RapTqInSwya7hr/iJDP3UBTvygzsZDzf31rEip4hen0Dq2ozrZTFTEW7M3iFM6tnCt9QfisQq+hKKFxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(136003)(376002)(396003)(346002)(8936002)(956004)(38350700002)(2906002)(8676002)(38100700002)(31696002)(86362001)(6486002)(52116002)(83380400001)(31686004)(2616005)(5660300002)(66946007)(6666004)(66556008)(66476007)(16576012)(16526019)(478600001)(186003)(53546011)(36756003)(6706004)(4326008)(316002)(26005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2pPRndMK3JEbnlkeXRZK0JSVG5TUFRTRXhIN1ZMWW0vWWlOUTNCZ1czeGo3?=
 =?utf-8?B?UEhjT2Q0YUxKTDV3cWZtd0lxdGVtR0hqdlRKTmQ0R1BvelJlSzNlSHZ4bks5?=
 =?utf-8?B?dmRKZVRERzl1Y3Y4SmRYUUYzSGxXWERLbFdTdm5WZHRFUlY5cDMvSVB6T0pQ?=
 =?utf-8?B?MnFPSXBEK1pER1ZPY1kvdHZ6QXIrMEpjdkNxV0JoMTBSaHZjcHR1ZlJMN215?=
 =?utf-8?B?L0l2MDlPeHVtZWtQNlo5ZnhhV1FrQXo1d1FEQTZJcVRtTjRrWEtXK1BXanZ4?=
 =?utf-8?B?blZlZ3JOUy9PS1JUZWh5NXBQLzlXRUYrOW95Mm9WV0ZQK0NJSHc3bnlPNGVm?=
 =?utf-8?B?d3dsM3hJQWRiSmQ5T2JZUEw1eXZ0Q0ZnaG1PUjJJK1VsZDh4MDJCVDRKMjRD?=
 =?utf-8?B?c3ZiZ21Cc1FoUGNBVE9zRHVrdERjbEswYUNwMWpDU1lQcy9rcjZweDRJUGVG?=
 =?utf-8?B?UXBVOURURS9TVzN1WExnMEN2OHpSTHRrc2Y0aFpzaTlkVklEdk1TVExMTlFS?=
 =?utf-8?B?ckN5RWs1RTVQSE1IZEdSSWtVbGN1dVluSWg5UjBTbmJkdWdtRU5ZeEZaZElB?=
 =?utf-8?B?cEtReXZ2ZVpXSHZtQkZZZVN0TVFxVVpPak1Xd3pkcnlEa1dPSW81V2FRcDVY?=
 =?utf-8?B?Z3pqcHd5Ti9HdzUyQ2hKMmd4cHVYV2dwT2tqTzdrc2U4c1VLZ0FsVGhOeERN?=
 =?utf-8?B?N2RxUVJZbmlHc0hUUms0V29oOW4yazNnOEtrVHNZUXJTNFJZLzQ5NDFaUnRC?=
 =?utf-8?B?QUFUNFBLT0lIRFhOWFdmNE1CeHkzM3ExVXhpcnVqYzk3cVBTaTErSGR2UWln?=
 =?utf-8?B?WEZSb0VhSnpLZTFlakpYeXNoUVhObkFkTllTRWxwTDYzUXVyMm1pUHN2T1pn?=
 =?utf-8?B?SUtQYlVoVVh6NUNYMGhWZ2xTVlNXdStZSFo5cTUyOHdWWmdBRzdYNldsZFhV?=
 =?utf-8?B?ZjN3ZWJlSmoyVWZ3c3JFR2R0K3I1UG11RlNhaDZJNXBlYUMwU25PblFiYTcx?=
 =?utf-8?B?KzVLZG1DbXJWZzU4S0xaSW1veGY0SldoaktBclBwNml5SzcrY2VNdldlOW1i?=
 =?utf-8?B?aGkxV01XbkI2azVNa1dReG56VjUvMzdvTE1sNXF3UnJOZ0Nld0diZXZKaUFD?=
 =?utf-8?B?TDBoRUVtUkxCM3RJOW96Rm1VV3huTlNrZW9UYURKRkczNDdDT1dXS0UwTVJ5?=
 =?utf-8?B?N0Y5R29WM1NZa1EvcEx5ZXUzMEM4NUZOTjBQcEU0UFM1Z0hUV3pVSHloblV4?=
 =?utf-8?B?MVpxenBWcUg2V0NkRjhXVmtidHVJTjdMUmpVRDFPODJXL2RjSmMzcjUxcnhz?=
 =?utf-8?B?eW9MTEtFY1pDSFBQYUxxdU1xbCtlRkVSN3FzV0tweW9LVmUvS2Vxa3ZnMjN2?=
 =?utf-8?B?QUZyTEY0QStsVXZGd1BVdkxYS0cvenFCbXBlV3pZUlBNZGlmYnpTTTRGUnNC?=
 =?utf-8?B?Y3pGdUh3U1NqalQ2NjV0NTFtMnVmMDBZWVZzanVoNzBrNENpQ2xjRWJLODFt?=
 =?utf-8?B?ZDd2OWdRYnpZdloybndhS3ZtNkplWXJzSkhad1U3VWtZSUR4R0pjRUdKK1Ba?=
 =?utf-8?B?SEYyWGRFTzlrTlFJc3FVWUZnVjFKNlNqMDBGWG40Ly9VODNCMEViTjhGMnJo?=
 =?utf-8?B?Uk1YSTk4U0tFVzg5S3JWRWFYMWV0UnhtUXZNM3E4dlY1bjVYMDh0WXFSZGwv?=
 =?utf-8?B?NDJHT1VUdXZsUktSZFF1TkVrZHZXRTdxK2ROaHVuKzUvMzhSejkxcTA3di9L?=
 =?utf-8?Q?Fv4qCE7hUEJQnGVp4C7XQ9fsS2Ic165fluU0ONk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b65efa-dadd-4eb4-3593-08d921db5a54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:20:24.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k48Nu89OFBCUO8eCGDCPueM4ERJQu9IFyae6xqcI6xazviI8l1G7gpgVzUOndIxGmkDOoS9636+ljadJh7Mi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2629
X-Proofpoint-ORIG-GUID: KVR2LEkd6QWkXSlKoPdqxB3lONQONG8L
X-Proofpoint-GUID: KVR2LEkd6QWkXSlKoPdqxB3lONQONG8L
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=938
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Rather than using "m" (which is the unit of metres, or milli), and
> "MB" in the printk statements, use MiB to make it clear that we are
> talking about the power-of-2 megabytes, aka mebibytes.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>

Regards,
Yanfei

> ---
>   arch/arm/mm/mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index d52647b6261c..a96e9420ec2a 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1128,7 +1128,7 @@ static unsigned long __initdata vmalloc_size = 240 * SZ_1M;
>   /*
>    * vmalloc=size forces the vmalloc area to be exactly 'size'
>    * bytes. This can be used to increase (or decrease) the vmalloc
> - * area - the default is 240m.
> + * area - the default is 240MiB.
>    */
>   static int __init early_vmalloc(char *arg)
>   {
> @@ -1137,14 +1137,14 @@ static int __init early_vmalloc(char *arg)
> 
>          if (vmalloc_reserve < SZ_16M) {
>                  vmalloc_reserve = SZ_16M;
> -               pr_warn("vmalloc area too small, limiting to %luMB\n",
> +               pr_warn("vmalloc area is too small, limiting to %luMiB\n",
>                          vmalloc_reserve >> 20);
>          }
> 
>          vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
>          if (vmalloc_reserve > vmalloc_max) {
>                  vmalloc_reserve = vmalloc_max;
> -               pr_warn("vmalloc area is too big, limiting to %luMB\n",
> +               pr_warn("vmalloc area is too big, limiting to %luMiB\n",
>                          vmalloc_reserve >> 20);
>          }
> 
> --
> 2.20.1
> 
