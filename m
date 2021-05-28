Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE8394369
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhE1Nb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:31:57 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:54048 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhE1Nby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:31:54 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDMrSR005441;
        Fri, 28 May 2021 06:30:01 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 38tqu5rffy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 06:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFeaB7LI3XPEJ5NFCitpORo5+R6YQ+Kfc2deYJKImjf+dyC1VtKSkjnGRJAmgvz9+plPlco7PJgqL9x0sNhrtLANJpNcirWEPBSbdmV5Emp8yOPogN7RhdChLIJYPFxneQ40LqRLtrWt0wLbqwzMf//ETUjr2Y8cp7tTKiD55iRU1nv7NO9gmosRN9MoD1fODoeeK4x239ktJqX02/NfQX+L4KKF1EKE/bpxahHDhqUWkLdK6d0RXU/JKhY32zawP37ZMoioXqqogURRXSr5K39pvPtwIiqkKvPDmL+bIZFpn6ppCdI3pHx/IfvCUCsIIhPfJ+HE8qqO0PS/BdoQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXs0AUUI5H+iE9tt3CymI+kwJ1g7dOLnKY2TNkUSGKQ=;
 b=OH5Qh8B2h/OQQ4E/5nKS88hwT6GxRDWFDV4corIWvzSwN7lHTUaolnjZr2TzyURa8FjrwCZ5MYQrjDHbrpEdk/ehu0xxSDDawW93JS5ow1SPoy8X8PfOe5s+9YPimQmvi2j3EBg2TpYLlIxsj11pomXpQ60AiOoQ5jkAFxrpuGo5IskLr7OD9DCiatfgAfKCyewkENYMpmeJmVgJmqRwSyfAbMzwEbLXoF+qiMTXXxg1IrcsgAvmN7gpAPxvApKvfmCK7rw8RkqexZwyMWu7Tvdy/4lAskLkNXfX9Xa1KDQ2UZeQkRAOw557YP/X8ZLXSRPXH29vrFBvx2wOID17BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXs0AUUI5H+iE9tt3CymI+kwJ1g7dOLnKY2TNkUSGKQ=;
 b=qJ5BvDBx3vkb1bfPYgCjaojgNq9eL9GKOtbP1Q5P+mcRFGkQ9eWSA9lqD1y37uggshZOKoCFywL2StsptbHyGZzXBXWKa96QzfUMl3KGyxOf9NFZ4MyumGq+mw8R0KwIY0hfNTCw4CTE/TFClGSbtJzESjI7YWQkZtVbY+bkrgI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 13:15:53 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:15:53 +0000
Subject: Re: [PATCH v2 4/6] ARM: change vmalloc_start to vmalloc_size
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZT1-0005Te-4i@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <56b01e19-6509-e6a1-30d1-ac71ec8724b4@windriver.com>
Date:   Fri, 28 May 2021 21:15:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZT1-0005Te-4i@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48f594b4-d1d0-4952-6759-08d921dab87d
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4862:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB486269225F8D4213FF699F9FE4229@SJ0PR11MB4862.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpEOf6460IJWpnCsT49QOWX4ky0gBlG/JazM8PQu7y6zhZsefvba65/p8HVU1yhHdiFkufabPoH69xQdpNS1RpUV36qkW3EdVBwzQSayYojnKy8kyNdILw+17nzreqFylff479Jkm4PbrZ7y07KjbRG1POfH6oFAvnS2DCn0YECg114MxshVnUAAbFAhtuzuz7W3/Th1NREa1r3SB1+WWJFu3wPlV7gmDNx5eKTlStANagwRqjwokLJfU5IsE3fAuL/6k8iL/w/MZPjPmDflKkniKBx8gCi15TLFegnX7to8Vrj4+7kV1R/NQOMDCD69TZwyA9CGBzmu7oyx7n8EY08nnM286TJsiPoM5VWEdfHnFvkdI+QFJlGaMwwrVY2NfOkpcyEzmZSXOLKzTg3gb6Om1pcS0Wrr3bKxEOxXiVRjYKdC/LZCR4BvNspPp43s41kkyL5eSuwzS8EAAd76sRu1ztc1EZgG9DxwjHI7nFjATRRx8rDVsl/N7Iqd/crB+uqKG1Kt1ZFYBUsUiwRa6qfux859tIGvjDDdAfLXLXZ0nBAITCFmLwUNX174OdJyMYjWCN0tskeKp3Vfuk8Hf9gbPavPDOVaDiFcGX9QosBacWxELPBmpbgMXQXktTqhB5XKD/IS/EJWUUbufmENNcXyTng7/TcNxIeK3qcskjKMZGsjysdwpE1m3eo8Or18yWsxY51GWEhXkmv/iWDM7pD0FEbnYgtgbtNqjmTSzqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(52116002)(53546011)(83380400001)(36756003)(26005)(38100700002)(38350700002)(86362001)(2906002)(6706004)(31696002)(8936002)(2616005)(956004)(16526019)(186003)(4326008)(6666004)(66556008)(66946007)(6486002)(8676002)(31686004)(316002)(5660300002)(66476007)(478600001)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWVZQURVQmhxcTdxNkwva1IrMHJ5bmNYeVJ1OTNYNFUzdnZmd3lnOHJHS205?=
 =?utf-8?B?Qm1CbUlaTVJCNkg5MUUrMU1ZeVRhczFOQmVlaU9LL1l5bUVyc3BwUi93U2R1?=
 =?utf-8?B?STRQOStpSzBSeFp6SWJ5SnV2Y2FqaWJvbExzaUtWaWxBcUFobllZN3FiQWlS?=
 =?utf-8?B?Y2U1U2twNzVkN0w2ek1GRzliVlBJZEE2VFpwcXNVNzNOLzU5VTZQa0tkeGRa?=
 =?utf-8?B?NXo1S3QvbEFWUGU3eVQveTFlbTM3Q2lRbjYxaTF3YlVmWjhpVXpYVC91ZG9o?=
 =?utf-8?B?WFdUUytyZkRqdjdTMk92aytVMEY1d3pWZndQQWd6WjFrTjg3T1l4UG5IR2VW?=
 =?utf-8?B?UmN1OE1mTmRhZksrODF3cy9rQUE4K0QxM2FrSFlzMDk5L1lHTW4yWXJuUXhK?=
 =?utf-8?B?NVNSVHZpK3pXSmNGM3VOcjQ1cHFjdGxyNUVrU2xrVXRTS2IwckY1YWhuc01y?=
 =?utf-8?B?aHRDS1h2d25oZ0ZnY012SDd0ck8zNmlFSXZrNXlHTEVLV1daNkJYcFdaM3lD?=
 =?utf-8?B?OGNiYzExUHdGWXBjSXV2WDZDWGtHcHhldytoMFZoVjM5WHRRaXpSY1VWRTE3?=
 =?utf-8?B?QmE0U1UxdHRwOXNpYUdTeHg4REZxSHcyajlFaXZWdFhCSG5aWUwrSml5Wjhn?=
 =?utf-8?B?eHJ2OE51bERSdytUaVNrRnJDT0tDM3NWcTI3ckFGdk42cDNaSmhwYVgwbERC?=
 =?utf-8?B?SzBlbUxuaEh4b3NQbWgxL3hJR0xoK1RCVVhacmFmbWdrcld2T2UzTzVVMEFB?=
 =?utf-8?B?N0hCVFVZa1VOUkU1dFVCL2tVSTN4UlJkS3hETmVUZXNYMlh1WVc0RjhRVm9T?=
 =?utf-8?B?d0R3LzNoZkcxYzVVeDg5M1lHOTZJS1Zram13UWtsZTExL2x6Q3c3cGhLZjBH?=
 =?utf-8?B?R0RXQjhpZ25rMzdnUXREK1h3RzRqLzJuZUMxWmlwakRoay9FL3AwS3FjRkNs?=
 =?utf-8?B?TkcrSVVWb1ZmV2x1RzFkUVJDbHM0K2ZFQWE0ZkVOZnd3VVllanRTZ2greXF6?=
 =?utf-8?B?WEtpb2MyWklDYTlhUkptSEs1b3M4N2NWYUtPWFFVaXovV0NhWmdKd0h0eEhP?=
 =?utf-8?B?dG1ENk4rWm1NMk5mcHpramN2V0xMNWdXSE4xc3p2d3VXUDRPS1hZWVhES0Iz?=
 =?utf-8?B?NnFkQklHMFBsQ3pDbG92NzArNzIwc1pvRGhIRTdsMXR1VnN6bWVYdmVBNWFm?=
 =?utf-8?B?UnNiVHI4eVVpR0JnS1Z2Wjl6QTdoYUw0L0VvbEpQSHk5cWM3Y3dHSnh0ZUZz?=
 =?utf-8?B?U0hXYWJPeW1KbWx5NzNVMGhFaWZtVkM2bU1MR3VqbkwvK1VYRGU2OWxVaWda?=
 =?utf-8?B?OFhOeDJ6a0FNRTJoVGczYWhwVEpRb2h2Wm9vYkdIc3k3Qy9hcjFMdmlKUlFQ?=
 =?utf-8?B?VTQxZVUrRitRQTV6ckZOaHFyWkZPcHF2NnpBelJPK1h4VS9vOGhhT2hmK29F?=
 =?utf-8?B?V3M3UWtQczdBTjJqdG9paVFqUTlMWG5KeU54OGlxaXg1SnBCeXFaVDJlRFBX?=
 =?utf-8?B?N3VGMVdHMjV3OWJtSWJDWHhubnhLNmRsaTVGYlI1OXpZKzEzZDloVW1uN3B0?=
 =?utf-8?B?cVhZT1pqUm9LaERBV0NBWHZOVDN3QmRqVk4vaWFsTzFKaFp5K2hBYm5PRWFH?=
 =?utf-8?B?aHllMlFVc1BMWkJZNzJuVWpHTDVqeFBobHE4TjJLS2Z4bEpQL0pTM2FhT1R4?=
 =?utf-8?B?YkQ2YjVQcVNBMEFBeVh1UFA1NDJ6UVIyZytaV2dPSEt6ankrMlE3WEZGVWlw?=
 =?utf-8?Q?QmS6HF9nfPm+vvHxyrlgJcegw+ETYWFAQz/Rx7Y?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f594b4-d1d0-4952-6759-08d921dab87d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:15:53.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGO3Nj6J4Zojuab/mVer6nmVJcX1LQIkrEtjtJKoVUhy0EBeEL7Qgpri3dgmuBZmJGrkyJvR0SyD2lO+clC38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-Proofpoint-ORIG-GUID: Jhd97s9bMeA7UE3DI3F1tB2WUgcdIBqF
X-Proofpoint-GUID: Jhd97s9bMeA7UE3DI3F1tB2WUgcdIBqF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Rather than storing the start of vmalloc space, store the size, and
> move the calculation into adjust_lowmem_limit(). We now have one single
> place where this calculation takes place.
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
> index ed2846bdb1f4..5ae11e6f2a58 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1123,7 +1123,7 @@ void __init debug_ll_io_init(void)
>   }
>   #endif
> 
> -static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> +static unsigned long __initdata vmalloc_size = 240 << 20;
> 
>   /*
>    * vmalloc=size forces the vmalloc area to be exactly 'size'
> @@ -1148,7 +1148,7 @@ static int __init early_vmalloc(char *arg)
>                          vmalloc_reserve >> 20);
>          }
> 
> -       vmalloc_start = VMALLOC_END - vmalloc_reserve;
> +       vmalloc_size = vmalloc_reserve;
>          return 0;
>   }
>   early_param("vmalloc", early_vmalloc);
> @@ -1168,7 +1168,7 @@ void __init adjust_lowmem_bounds(void)
>           * and may itself be outside the valid range for which phys_addr_t
>           * and therefore __pa() is defined.
>           */
> -       vmalloc_limit = (u64)vmalloc_start - VMALLOC_OFFSET -
> +       vmalloc_limit = (u64)VMALLOC_END - vmalloc_size - VMALLOC_OFFSET -
>                          PAGE_OFFSET + PHYS_OFFSET;
> 
>          /*
> --
> 2.20.1
> 
