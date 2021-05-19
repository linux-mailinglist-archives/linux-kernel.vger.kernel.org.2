Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45477388681
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhESF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:27:15 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:21616 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhESF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:27:12 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J5PSh2009430;
        Wed, 19 May 2021 05:25:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 38m8uh8ap2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 05:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXFzocCn4nlrOFucMgleUcmQC/9fWZ64VqJIeLSOYoHjt3PWrafKra+1FwpKvoUD18a+ZfCMIdWiIn8ch5CaSJm76coOihRpvg29vOkFv4kn5DsrMmMaIPWizOrkM0LQea9uYmbUN3rFGsmTlimHxuBxdtza++joDtdpI7Tm+5/8xWlhW0Qjs8gRTAffzDUSSmd1Rr37o5aCYW7AXOAZ80e/RnQTz1glUdoj5D/zVw59nMerp8TSFDchZXIInPWbmaqJtzu3BbXpkZe66npVByU9ulKvL8pq3yzb31+B92v+TRoVG85onnySGqwRdH0LynLhdJJtDV2Vyp/Fq41J3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ey+YgHm+xKSIMrA3/AysQ9Oo+IC6CEyA5AUz34xxdA=;
 b=RdxX6dLNOdbxJGCGxY/g5HOz4UBnbOddOQZ6iuDxrberp1Wuna/2YWCmkTACyJhNvnZLiP0SHl88N9AmZMJIuQhC2sNgjpJ+a/PhvQEp3ptCUVv0kc1VWf2RrfHK4DM2oJ+we+10fgbGPkmOeJ/NnuFx2p1CFLolqYkDezOYcfdWapLhM1NH2ONOW0Nmx7a5MUdpfhL3RNufngicQcFkchmE+WBRLpLkrHGrJ44vKivbK6ZppEmOGFCoPi13kmu8e1sReiJ7rCRGzq192XHBV+qRq5+rXLoR1fSMXZ64pQVKG46gXT2xo0ggQHbJ1Pe1KytML4U6Q9u68ED38v1scQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ey+YgHm+xKSIMrA3/AysQ9Oo+IC6CEyA5AUz34xxdA=;
 b=WEqY+Y0J37wF3rPKqwh+U2bd+EwEfJEZ4DnQAhXkgMbc4VCHQSzv4wmv1Z7KwwqhH0JVlX9kAG574eGEZhmMrXdOQZPSyZZkBojnoW7J8WvsC7lT082guBdqbRWgquB1t2FcMLwX5y+DZK9aBNgR5cCufi5xHn+89TTR4s2YUqY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 05:25:25 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 05:25:24 +0000
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <34802b34-ad4e-7e9a-f208-a9171eddaf32@windriver.com>
Date:   Wed, 19 May 2021 13:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by SJ0PR13CA0222.namprd13.prod.outlook.com (2603:10b6:a03:2c1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Wed, 19 May 2021 05:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e75a17c-b1a0-4766-310c-08d91a868133
X-MS-TrafficTypeDiagnostic: BYAPR11MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR11MB26320C177DC782BCF1A772CCE42B9@BYAPR11MB2632.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhi76JEPZfD8dwvRNedgwBXocF8O8R3/yfwI/oqWIcEJ+9SRd6A50h2pAL183qWsHxVZ3FYaKhKQN5ZVBpt7JWFhlAEHADYyVfyvbIJ5/PfgxbdYeBuwc/dbcc3zEV3cSpFoNJZs2MvTAGIaCZyZdUmU7+V60vdqFhaOOg/WkbebppLFsGaO/UWsiNIqGi9sUcQwhe9RQ0hKOWSIIW1LC6JJicdAaIqZJvnfv2AVLfzB5LR2p3AwJUvT9Ha5PLe8He3VpD/foNDb7ciPzp3YdsffqlA+cCLUPR0Swv/fotMOM49YRNPmXLf8TxOP5I4ZB2T34kV1MlDP2Ie+dO+XQARZWRf0Zoin7PY5YDrco8Xt7ICVY0uUTIRCnFsfImYQZDwywDMoksUlGUYrb6MOlksk9WFsTzHUMZNh1kyxXvUdlGIBGp1wzBwEIebp0nqEuB5rT++PSEdxdFDe8Wos+KWwcwi5CAwEsETJG4qxe3I3jyz9PrziZBWO49C7j+Q2GZJQWJsT+TWeMXy9Yj/SYn6idi9c9bScUp7dCMVpZyl43z1VYwxbYsUXbpUwfxJkeAj3IkPGDweXeyKEnv+CrPQBX+PyHMdVW34zCDQMRfqkZ7Jq+GADSQCGkryb+C02+p/v7FjjALsVcM9BGtyzrTjEZggFeL39BkR7EqXYPSNB3mTe+VnNfESF9ExYAjsHuBcxspOCt4u75dSPF8wAbARz3Eg+oTbMf9XguKREAaZg6F6FKslOGetYCUoWPp16
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39850400004)(346002)(396003)(16576012)(316002)(31696002)(26005)(52116002)(53546011)(186003)(478600001)(16526019)(38100700002)(38350700002)(8936002)(6666004)(8676002)(2616005)(6486002)(956004)(4326008)(66476007)(66946007)(66556008)(36756003)(5660300002)(6706004)(2906002)(31686004)(83380400001)(86362001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmMzKzV1ZzhrUHdaNzNCN2ZWanFVVDI5SEppSXpiejZjakxzSXRTVVlhQUNU?=
 =?utf-8?B?OFlxdk5DbnVzSXp6cnVCc25aWXpKWS83ZXg5M0V1SXovTFpBWi9BQkQ4eGN4?=
 =?utf-8?B?R0FZU2lXTm9SY2pYVFJhbi91a09HWTZ0alFPSTRSdy8wS2w0SFAyb1NtbUVl?=
 =?utf-8?B?VndBUDNVQis0akNNSlJidGE3Y2hkWnpreDJvV256TW5OamRKM1Q5N0txbW1T?=
 =?utf-8?B?S0xRQTQrRjcrSDNRajZQSEdVdW9zdG9zTkFTUmFneTBwSk1oeVhVZlJXSTVv?=
 =?utf-8?B?UmpLSkI1b2pXSVg0TENuVlA1TUlyTlZmRGY0VlBOOE9HeVRLNlFieVNaRXlR?=
 =?utf-8?B?MTJtY3RUTUhPR3Fxa2hpTk1hQVNtelpGeTVhUUo1OC8xTjVSTGNGNW8xRmU0?=
 =?utf-8?B?bWhsNU0xRER0eTlBeW5uUEg2a29INWZWMGdnRGxvd2NTOGtBbHJVL3lXeTh2?=
 =?utf-8?B?TGtWTFV2Y0p1a3lpOTZVZTBaajQ1SmZsSkdxUE0yVVFsR011QUNINW0vRDJt?=
 =?utf-8?B?bVFhRU9tSjhZR094VVN5cGRzZTkzdDU1WERkZzNpbmk3cHlHbzgyZ05aVnV0?=
 =?utf-8?B?dkVJcnFlVHJ3U1hJY3prOUtpcGdRcHVYc3dnb25BUkdBTlZJSmJiVFpZWWVw?=
 =?utf-8?B?MS8zQ0J0Y0tKV0dNSUZpOUpKbUlwVXhNajh3OXNWaTdXd0h3eGFoRlgwcGh2?=
 =?utf-8?B?c0VnbWpFSVIrRktnQUUyRWFkcWlCbXFKekkyQWwzUUw3bkpDZzBCNC9HNmVI?=
 =?utf-8?B?bk5lODRjWEFPUElEb09GaDdDcGF1enNwZkR5S0xkcG13RHdOSnZQU3hhTnRj?=
 =?utf-8?B?a294eldLOXA2Y2YxVzR4a3RPeGxmZVVtVUVsNG0vTXlvcDZDbG1tTjM3Y2t2?=
 =?utf-8?B?QVR0UnVuaSsyVHFWMmY4NWZ4Z0RzaTZ3UjhITWVpNkVYMi9CNmpLUEJVM2Qz?=
 =?utf-8?B?dkZoazRtWHg3SzNXWWJRbkJPNjFLaE9QRkpCYnJTamVCcmhMTVB5NVRaelBm?=
 =?utf-8?B?MnFoSVpmZjlZcnZEM3kydjVMS3UvbzdPclIwNVJKaVN1ckQyNnIxaUg4VnpL?=
 =?utf-8?B?ZmltaW9NenFMU0QzQ04xZktYQ1JqdlgzdVA5Y3BrM3JmSnFYeldZcGpEUjBw?=
 =?utf-8?B?MU1iWFZtbkdrL3U0QVRMOUtLa09NSzFTaHUvYzJGNkRuMm5mVlFFU1h2NytI?=
 =?utf-8?B?V3VaY3J4alY0NXA3T01vWlRCeHRjUjJaTTFPVEtVd08ycmw0ZkxWSmlraHZW?=
 =?utf-8?B?QXdzcmQ3OEIzVjNnQmRLa2s4YUtzdDVFR0Y0ZTZSUW43U3BoNktiNmg3ckRy?=
 =?utf-8?B?WFI0K2hNZ1N5K3FNN0JDU3VFYzd0cUhrRXdmVXF2aUJpbnZRSjF1cmNuWWpL?=
 =?utf-8?B?YkpvTGF5cG83ZTRTL2NTbE9PQkEwd2tGOVpQaWliUk9UMjRLMFBzRytVUy9i?=
 =?utf-8?B?UGJlQnhGVnk0UUNGYTJYVEdrRDJ2UGd6SVlnci9lMUNzWEtBclU5L2cxeVR6?=
 =?utf-8?B?T2JocTBVSGIvckxucGtGMytkTFBMN0taeUtPcmladUJxSDlUS2ViZElOeTQx?=
 =?utf-8?B?R2VNV1RYaWd2OXRKYVRWWlhJbnFtRHlFSXA2UGI4MHVJMmdPRHROTXlza21J?=
 =?utf-8?B?dEN0cmZBakdleGtMUktkZnFhY2xjMWQwY2xlN1lwK0loVVUyZEp2ZWdnUEhn?=
 =?utf-8?B?Yk9VN0RVK2NlOVIvQXBOYjFydkF0YVNZTzRKNElGbHMrRGFBR2dta2NpeVNH?=
 =?utf-8?Q?bJwvpUsyzJYyeaFoItcZG4R/nZhbI9kxoC8R7RX?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e75a17c-b1a0-4766-310c-08d91a868133
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:25:24.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJVNw4iPF4m66CqjA//Ge+3OnIhdNj8xqaUvW5l3txPc60wL90SkSoeriE9jvIbdvT1nhOKvZwjp/U6qaM+t3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2632
X-Proofpoint-GUID: U-Vx4eplveDam2_9J49zpuK0hiRa7jfo
X-Proofpoint-ORIG-GUID: U-Vx4eplveDam2_9J49zpuK0hiRa7jfo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_01:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 8:15 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Change the current vmalloc_min, which is supposed to be the lowest
> address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> which does not include VMALLOC_OFFSET.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/mm/mmu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index d932c46a02e0..457203b41ceb 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1123,8 +1123,7 @@ void __init debug_ll_io_init(void)
>   }
>   #endif
> 
> -static unsigned long __initdata vmalloc_min =
> -       VMALLOC_END - (240 << 20) - VMALLOC_OFFSET;
> +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> 
>   /*
>    * vmalloc=size forces the vmalloc area to be exactly 'size'
> @@ -1142,14 +1141,14 @@ static int __init early_vmalloc(char *arg)
>                          vmalloc_reserve >> 20);
>          }
> 
> -       vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
> +       vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
>          if (vmalloc_reserve > vmalloc_max) {
>                  vmalloc_reserve = vmalloc_max;
>                  pr_warn("vmalloc area is too big, limiting to %luMB\n",
>                          vmalloc_reserve >> 20);
>          }
> 
> -       vmalloc_min = VMALLOC_END - vmalloc_reserve;
> +       vmalloc_start = VMALLOC_END - vmalloc_reserve;
>          return 0;
>   }
>   early_param("vmalloc", early_vmalloc);

The minimal vamlloc size should reduce 8MB, to be same with the original 
vmalloc size.

@@ -1133,8 +1133,8 @@ static int __init early_vmalloc(char *arg)
         unsigned long vmalloc_reserve = memparse(arg, NULL);
         unsigned long vmalloc_max;

-       if (vmalloc_reserve < SZ_16M) {
-               vmalloc_reserve = SZ_16M;
+       if (vmalloc_reserve < SZ_8M) {
+               vmalloc_reserve = SZ_8M;
                 pr_warn("vmalloc area too small, limiting to %luMB\n",
                         vmalloc_reserve >> 20);
         }

Another point, the current size of "vmalloc=" will be align up with 8MB, 
should we align it down? The original is align down when we consider the 
vmalloc_offest in vmalloc size. If yes, we could do it like

index eb6173315291..1fc2696fadd2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1133,8 +1133,9 @@ static int __init early_vmalloc(char *arg)
         unsigned long vmalloc_reserve = memparse(arg, NULL);
         unsigned long vmalloc_max;

-       if (vmalloc_reserve < SZ_16M) {
-               vmalloc_reserve = SZ_16M;
+       vmalloc_reserve = ALIGN_DOWN(vmalloc_reserve, SZ_8M);
+       if (vmalloc_reserve < SZ_8M) {
+               vmalloc_reserve = SZ_8M;
                 pr_warn("vmalloc area too small, limiting to %luMB\n",
                         vmalloc_reserve >> 20);
         }


Regards,
Yanfei


> @@ -1169,7 +1168,8 @@ void __init adjust_lowmem_bounds(void)
>           * and may itself be outside the valid range for which phys_addr_t
>           * and therefore __pa() is defined.
>           */
> -       vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
> +       vmalloc_limit = (u64)vmalloc_start -
> +                       (PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
> 
>          /*
>           * The first usable region must be PMD aligned. Mark its start
> --
> 2.20.1
> 
