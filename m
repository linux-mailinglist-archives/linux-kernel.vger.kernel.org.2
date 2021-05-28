Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51712394346
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhE1NOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:14:16 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:32290 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234233AbhE1NON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:14:13 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDBRxP013801;
        Fri, 28 May 2021 13:11:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 38thqe8p5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 13:11:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBADZ0ZCYTmAOv9NF3EC0ODOfzT4v+7tEj0JW0GfC1wQDGaldk0QEdpuU3AnVxe//eib+dWshNgO6P1mnWwAAUEu0eG3JnRWWVbMV4T1FVboMf6uSHvK8Jmf1gCmLz50y+6apQ+7pwbVORIVuOyLUypGWUfXgr0f868e2skAQjgLEgzdopErN0QHlHkKUvSTF8qOD3JCC10EY5YPFOLNuqYRk9/GzuhE5BsgKeO0LDzw0SLZHcXCVg6Jcjf6hbAxl2dWu4O6Et1kU31pUzvpCiuJWm1g2ds1WENYJFeoHdKTBK5Ixokkz/V2eNa7UTt0qnc1IxZFNywbc24RpUOhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HWyVljO78nLuc1b77sfVhzw0mKIsPrRbU1osgovDAo=;
 b=fym1g0kuJklcKpIOCXJZ0h/4MgsPn5nMsIRn75U/81GqTw9UHhfJa6/v3U6Q3ocZCiWsfJBSeN/JFsGOku7zYcRW4bqE2ABQ0jcFj2fstXfi2ZPsHE9yKrWLfpF6wNLPnvXlXXSkHADWs7HBRSsp1O41WnyCzAfLav9GCu1RiaoPU8sVvrtZUVCsDlgJ3FLY0IVBbhTHYjfJVi0Qizf9iFZduDnuU0dvsxzUpAXIVgUEcrFtw8yq2x0HZ3EgzbVMMySgvi3drYWKE9MpB9xXoF/RZcMGGqCUCRANzZca+3v+1KPDj0DqR9nHyrsGNRdpFnUNKh9Ggs/866r89kZlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HWyVljO78nLuc1b77sfVhzw0mKIsPrRbU1osgovDAo=;
 b=P17nCwtpAZ63iNBDcXijT4bVDcKHSc+HVr0AVhzW6fyRlZio6oG8LNO5CT6j7glt/3uI76q5AEYF/NVL74ivykcHRZy+jWEzA2OwUlLadqENdnL5P2anf9cTsyoM/ToliaiUT27HlpQooUhuLlevERzyXvtLFZhhe5yELS9sqZM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 13:11:53 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:11:53 +0000
Subject: Re: [PATCH v2 2/6] ARM: use a temporary variable to hold maximum
 vmalloc size
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZSq-0005Sv-TB@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <3c7345b9-d963-7d5d-6c6a-6263eb8e2a7c@windriver.com>
Date:   Fri, 28 May 2021 21:11:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZSq-0005Sv-TB@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0060.apcprd04.prod.outlook.com (2603:1096:202:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:11:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b719fbc-bde7-4e66-0538-08d921da2990
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4942:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB49428162904F80057B9DE78AE4229@SJ0PR11MB4942.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2zs/E7Noj/62ifiEf/E6n3z19PmO2RjZUCqfRF5MJP2t2tYUtpRlmFzJK30z/C1dLgDiynPcHIpe92wHSg22qYzaJzfdo1ymhV3Sk+oXfyDbv0nQioy0FDS+T5Mu4RncwbO4C7MrFywd+5qo2Gdc3scZcUC4ogIdvekI0M6+LOvvP9IaX1ZaR3gsT/Hm9zZzBl/g8dJzMOWXvliYNdw0x5nc0dCPnx38J2mOKJeyIlBLjbPsGMkzY//dCziY/Y5NVL+zp4CTVpWMggs3+FJHu90pThBLe7Kndumj1kvPvnN/XH1SKOmTEsZzv1JclgV+EsE5vf0p3C0WaDWPBOCAQBeTec5c6B5avXxk2SzWsBZWgj2hFd/kZFdjNV5zKpHQn8l7fl6VlBBjr8IZPwfw/lIsFUbht7PtqCTpeQLZn9oU7sAn4DIbqRT3gn0YU5eVtObTTBUxL+/knO1Z0wOET1TS+gu2+WbaYYvNOFTd9JWljzu++GWwodH2Bi+qWUPDNqL8G6k5nMjmVqNv1j/eHF1J8TxbnXSiCsQBRaMdmFs0t9J/ZtBI5BkQXhH2VQsKo17dDPmG4N1FVTqoH3MsCjU7rIo7unG25lh23WvvMV9REYyw4n2lnW5OcXrR1R35+p9iyCEgaydVLuqrvsArL9EOm5NFkb5w2a5zilJU9XMAbWRedpgIhazZKnJLMi92+y9r3UOAoG5LM/PLaf770xBnMGLHiqBkQQbkfoUgkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(38350700002)(83380400001)(31696002)(6666004)(36756003)(66556008)(66476007)(66946007)(4326008)(38100700002)(478600001)(26005)(53546011)(6706004)(316002)(6486002)(31686004)(86362001)(2906002)(956004)(2616005)(16576012)(186003)(16526019)(52116002)(8936002)(5660300002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N21UYk85Tk5HWHdWUGNTZ250SVZLUTRkYnV6VjZPQ2xqbWNWK2QwK2x1SzRz?=
 =?utf-8?B?Y1o3SHZiSGN6OEVTVHlQc212QlpVaVlkR2p1eXV1aWdoNHVFODROdHcrQUJ1?=
 =?utf-8?B?cTVYTmJIN1pOVlpqSVFEQ2tEUnAwZHgvV3hSNWMyMW1MQll4ZDJMcWVDZTNI?=
 =?utf-8?B?YnBhOUNENnNyTXdnbXRBMWM5QU41Zm1tMDFtUzBTb1FqWmh5QlZxZjRpT093?=
 =?utf-8?B?TCtTU0JkWVEvbGRqWmJML3pybVdxN2NtRzRmTEliejZLOXFnVFVaREVLTXZk?=
 =?utf-8?B?ek5rbnY5V2JpNkZIZUpDSlpsWm5rclBaK2RkdmE3VGNEeVV4SGkzNnJMVWZE?=
 =?utf-8?B?UVlKWUt0b3R6WVphdnV6M21uMXFMN0p5eE9tUDZTeFBrQ1VQa1M5NmNoeHM0?=
 =?utf-8?B?aVYydXJEaGhiT3FRc0Zva1ZERWx1dndaSE9YU0wrbGhGODE5UHdLaHIwMWxY?=
 =?utf-8?B?SFhqdTMzQXhiT0NoM0FVTUx5cjNYQ0dGaWtYanRwWDdtamZVL2ZsN2hIOG5m?=
 =?utf-8?B?dlJ5aTA3bTFXWmZvS2pqWGdNcE9MaThhRTFuRUpnNkJXK1dBM0Vhck1tdVFw?=
 =?utf-8?B?Q1d0WTBxQitwZmZlQlQxTlVFemtEbUdoNTlJZjhNVWh6WHlHV0RiWUY4NjB1?=
 =?utf-8?B?QjlReEc3Y3BOOVQzZGY4Y0k0ZW5keWs5QzRSWmVVYTlDeVJNRlE4OHVvd1ZH?=
 =?utf-8?B?TDEvKzdZNVgzeU5vNkJSV3pJZDAvaTNMWmsvZUk2cFdyakxYTitPL3FramVQ?=
 =?utf-8?B?Q1lIWW1hZzR5V3huN0ZjbTdmUEpXRGNwUFd3UnhHYjFCS3ZEZitUb0xqeGdp?=
 =?utf-8?B?NFVCQXU0LzE5ejlXd25ZdnZ2Q2E4Qm01cUZiNFZxc2pvaEROME02ZEFyQmZB?=
 =?utf-8?B?R2l2ejltT24rNGordTdSbzFQRG1QWmZMem9ZYlNub1hIL1NFQ3BkVEV1QmlM?=
 =?utf-8?B?VGY2NGNiUFpPcHRXbXhnczVibUpmd2pUYkNPVDlLcHVDMjlIT1ZXaFplRkhs?=
 =?utf-8?B?a3pZREY4K3dBYUhMWkljdXRCaFlSUFNuNTFzOG9mdE9kNzh6bVZWeUhwenNt?=
 =?utf-8?B?WUVCUzJyMjRSTEtVS3F0SkU2d2RYUzRMdEFlRnpYb01qODQxVDdmejZIL2FY?=
 =?utf-8?B?UW1GaklzTzB1b0RYTCt4WHpucFBPbUJlRWo4MmdGWDFYNDVtMXQ0cUU0K1l5?=
 =?utf-8?B?NUozUlRXbzhqNm55MkJZYjBFaVNrMDJxMVhHRVByMmZjTVJ2Z0gvVFN2TmVy?=
 =?utf-8?B?dHpYOUgwU0FFK2hhcDJoZEF6RGRoMmZCNHduVWM3U3lHenZxeGNsbDI2RUxF?=
 =?utf-8?B?bnF0RXN3U3orSmJmanFNR0s3Yld3K0cwZGpCdlMrZ2NFYzJlKzNLRmphQnR6?=
 =?utf-8?B?eVZBbHc1S3JHUm9kYjkxSWFjNnBWTWdoSHJONUVuOGFXcCsyNE0wVlVybm82?=
 =?utf-8?B?aFZKcGNrYXBZOE1RMGFvODVXTzFpclNTdE9UQVplbDBKVEIvMWNyTjQwK1Y4?=
 =?utf-8?B?ZkIza05KaFpvdHRTVFhZRXNwZGJRRElXOGFzY0hnQkFCb2NmdHZBWnVOVlEr?=
 =?utf-8?B?V216YlJyMno3L3l2NXQvYWhxZk9xQjQ4Qm5CdGtJS0s1VkphY3hpSUFEN2Mv?=
 =?utf-8?B?NlhrN1NqUGJoLzBTSks5cWQ5bzd2b3A4VFA0VFdSVHFGTnlEUWxXbjlKWWRE?=
 =?utf-8?B?NFdWMmY3S3NTSEdkQytQVjluZmtnUU9JbjI4SUVGVHplQnN6aXYrYzZibXpu?=
 =?utf-8?Q?TDtmpHm1H3VKJwSpGJ3jbmGNd5ekJeOORHNhsLK?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b719fbc-bde7-4e66-0538-08d921da2990
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:11:53.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuj4DyxNZ92i1wKS2VjzDlKRYUA9DS4BKxlz7ERnSDosId8bw115/1yx255kUOZFQQS/m/9Fal9L7TpL8oFrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
X-Proofpoint-GUID: 5kBkeH242GJBiN4FWSO7J4oEpixCzzwO
X-Proofpoint-ORIG-GUID: 5kBkeH242GJBiN4FWSO7J4oEpixCzzwO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=987
 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> We calculate the maximum size of the vmalloc space twice in
> early_vmalloc(). Use a temporary variable to hold this value.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>

Regards,
Yanfei
> ---
>   arch/arm/mm/mmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 206c345f063e..d932c46a02e0 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1134,6 +1134,7 @@ static unsigned long __initdata vmalloc_min =
>   static int __init early_vmalloc(char *arg)
>   {
>          unsigned long vmalloc_reserve = memparse(arg, NULL);
> +       unsigned long vmalloc_max;
> 
>          if (vmalloc_reserve < SZ_16M) {
>                  vmalloc_reserve = SZ_16M;
> @@ -1141,8 +1142,9 @@ static int __init early_vmalloc(char *arg)
>                          vmalloc_reserve >> 20);
>          }
> 
> -       if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
> -               vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
> +       vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
> +       if (vmalloc_reserve > vmalloc_max) {
> +               vmalloc_reserve = vmalloc_max;
>                  pr_warn("vmalloc area is too big, limiting to %luMB\n",
>                          vmalloc_reserve >> 20);
>          }
> --
> 2.20.1
> 
