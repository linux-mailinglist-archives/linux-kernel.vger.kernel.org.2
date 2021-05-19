Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FD388655
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbhESFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:06:19 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:17770 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhESFGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:06:18 -0400
X-Greylist: delayed 1398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 01:06:18 EDT
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J4fKPc001856;
        Wed, 19 May 2021 04:41:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 38muc700cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 04:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6kVg42zM/vob88cGXaa8bbE45U9mWGYSJjUPdFXZbKDUsHWw+YCoUOU7IwaB76n0kIkA+fl/XO36dvugeAYWyTE9DapQtNNyJgWadV+M9teSiPkNpgQ9AZvKKUMYtFlbWSgJwCPsQciEGCMn+4iBQ6dfknHDMsjIWXSUdtgdq/inSgUYc0JzUjv/FJ32klpFekOXDYKakMdMfLgndqoPBo6Xxj7eoWGA5EcHXYTH9fmvUTsk0vfs3N9TWXNawPID7qVYbWzFsRWK268RkmyDwnI8le2sli1yfLWTzFI7Edh59o2Q4z+iU/FEUy+6H/hfAFfN+Noo0EK9E14OCPyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiahe672UKRXzQerQRTqCUC/2fSASY2rnohD44pLqrY=;
 b=a3FvohZmkgCj2GrWp6JhxUsXrl0r5SkCvvBwV6YKAZ2AvpGnhAkE1JZsdtcb8x1xtEF05BHI9QG/gdBTNQVEHKZXL7+vjeIiXbhhK32jsPi6bPRH9cVBRtqWflN57K8XoZKapcXrnnnb9dt8rCGvW7bjHeu00MgPePnIfrrhy0lQYK14PYTBidBROoLL3LeIhF803rCD8/X8G487J+VwzRUgiodt6PQIeCcvF1nK+VKeNDfTSISF3wQGRt8/yXQZOw4cryzdM1S+EDDjVSkjUWS5RjMQwSQOxZT/B1qa5tv78kHdbQ8iwxwQG9oDcYDzwGSa69VW2cJ8CfcfraYcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiahe672UKRXzQerQRTqCUC/2fSASY2rnohD44pLqrY=;
 b=jwkDTJxWUY6KwlZSk6WT9YT2IlZ+8Rqv/UghvqpLOhobg2LjDRzbQFFMj5hyUFM2dlacz2MNKioL51t99cVaLJ0lW00cB1WSMKqhHCCNA2XDnSWM1WYiCr0U8xe3Hg6z31UlTBTVMVld2xGNTh1yiS/+B9OsCR683lzig343vWI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4103.namprd11.prod.outlook.com (2603:10b6:a03:18c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 04:41:18 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 04:41:18 +0000
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <a7ad5c03-025a-4cf8-e4b1-2d150bfe3066@windriver.com>
Date:   Wed, 19 May 2021 12:41:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:202:2e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 04:41:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b93f59-4c51-4d6e-d93d-08d91a8057a3
X-MS-TrafficTypeDiagnostic: BY5PR11MB4103:
X-Microsoft-Antispam-PRVS: <BY5PR11MB41033962A4BCA19F6DCE922AE42B9@BY5PR11MB4103.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KUNkRM9emp4r9/vP1wUA1XO7k8yGjzgNWaAFqLygs3Vd/XohXd0eSCPUIcgPMoRywFbpHbjKnySXX/axpH3RHIw2MWV7iXEVJ10S8vb3BWkneQkBpAHixoThnzgVwNotiH9ecNsxdGuePkPKNGBRElJDQmC7kfleYDhuPa//r/cC3tY5qpyxNUXMLHN3GV2K8xdzFIs9egW6LrXENDMJpBOvAGbYoYi9+vgKCVewbsA1sZ+exbtjofwagpdTKy4ps8MpWYS1wl0de+xZ5+3cHyy38xS/FkjtKDo2kJ+njB/KKkJ934XZHamSSHYUX3YupvLIToBsPqYmu2H22OTZt/PDqVMe98RNXxQgAf6zZZ2LJcst3aDH+dMKHOLLu08zifRf1xxQ9vEdbRIUMqjLMISJ1lunP3WVszgVqnOAYUK5/fokUVNFMjxlC2QerAwxjxMU66cPh75w1ITO2BUQhDQhAnAppW/vDLqwF5/UpsXOULjEpt0g3jOn7M2rwW9xsvNlaX1E30USk4x3LutXtD4RzQmfLJmwfmRSuVQ09oi0rRuTyCCkam8N2nohBeR6nzoVyHy8a97fF5wqu97bJWRrQOkDmt3XrcQ+i7lFyfpIwIhXhDUmnry7EasiGru+dHHh7oQRRDrgsBEpwBC/PE1+MnoJ+dZXFDHqzSQd6gerpqMduhQyR7Ziok7RTCOXlY9x99OolsgYU3bqDLH6Dz3iJaI2qPi/QZNypQB+ejVFbcZitWquDWGa28FL3ex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(366004)(346002)(396003)(83380400001)(38350700002)(38100700002)(53546011)(6666004)(26005)(6706004)(6486002)(66476007)(478600001)(4326008)(52116002)(5660300002)(66556008)(66946007)(16576012)(2616005)(86362001)(8936002)(186003)(16526019)(8676002)(36756003)(956004)(2906002)(316002)(31696002)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djJDYVhQZnA0SUtqT2dROWsxWm5sZC9RMlp1aXh0M0JEeXVJSGpvOC9melNY?=
 =?utf-8?B?YUpnSTd3VEovSnlmTXB3SFJ0ZnQvODh4OHB3aURIUlZtRjZIMFh5emJtdktr?=
 =?utf-8?B?Q2xVRW9IQWtTVXpWMFpOWTJBNDJBbFhBTVQ0UGRFaXpGY0xPUm45YVg4ZVFJ?=
 =?utf-8?B?bU50TkVib3dxOW90RUVMbXc2UHFmY2hDK3JOSUJtc2xnYU5PSTJJdkUrRzRN?=
 =?utf-8?B?WWRicC9JMXRLOG04WEJFRFlKVSs2YXRPY2hlRTRBdnp5N2RuK09odVFFQUlh?=
 =?utf-8?B?M2RNdkFidWd2eGNydnFIRm9hdVZ0Qmg5RUp6NUthdEhQR2pHNnZETXFhblFs?=
 =?utf-8?B?Z05OeTkxTjFhR2kyKzRzeHBRZVFrbmpVYkpaM3N6a1MxZ3czZUZSWmwrVHNQ?=
 =?utf-8?B?WFdqK1ZoaEhOTDVPL2hwRk9idTBoVzh0RFIrNmpwU1FsQVM5L3M1QmowMXdu?=
 =?utf-8?B?TWw4QUx2dmpJZC9KRCtTakwwSk9PbVE2c2R0ZUVDMFUwQmhwUDQ3emx3ZkxB?=
 =?utf-8?B?ZFRXNmYxY2V5aEpScExuYk1pVFY5N0pXZ1hreUExSHh5ZUhORjlWVjZjTUFl?=
 =?utf-8?B?STdyVEhUNGhjeDErSi9WRFJRamlKdGE2VExRODAxZDdiTDg3ME9WejZ6T21R?=
 =?utf-8?B?QXE5RnlsV1I3aWlDZ1JRTVRSMzNtTkJEcTRFa2VBSWxFZ3kyZnR5R2Z1ckx1?=
 =?utf-8?B?bzIydWQ5bXRZaFUvdzNEaTd2YTNJVmtDcVlaN1VYNmYvdmJDYUJtYlk1WTZW?=
 =?utf-8?B?WUg2NUJCaUVKaWNFenVwMVVlbzdseTZ0Y2J1a1h6L0RDNG5RQlBIa1JhVm1s?=
 =?utf-8?B?UlJRTG9jcnhSaCs1cDJzV2dkajZCT3M5NCtMVTBOekJMMjlQRndhM3BwcTlO?=
 =?utf-8?B?b0dRZTRrYzVabnJzdUZHRGM5dUh6NHJkdW82dnovemlueGlCblNHQURsU0kv?=
 =?utf-8?B?VjZmZFYybGdtUUZsbVgvZnArOXJacmpQM3laL2p5MWlSbno0M1orbnhZNTg1?=
 =?utf-8?B?Ykw1UXA0bnEzTVR0cElKVWw1bExXY0dTTFBDQzh2YlJsc3MyUWxFaS9zYWZG?=
 =?utf-8?B?eUZMSmZ6WDhOK3g4WnhmZFM2NGhqd3FUQWVRTGl6Qmc0UDU4WFphUDJQOFpY?=
 =?utf-8?B?Sm9vV0t2M1hidGIzSFhGQmJ3RW9DRWlwWFJXYnZ1cXdNc3dKVUlvN1NlVHQz?=
 =?utf-8?B?eGlwVjdDQXR4ZUxveC9qWTR4bE9YaXRLdjNQMjlFMXVrRTJCWi94K2dBYWJ2?=
 =?utf-8?B?YUJ2V0tPTUNZZFhTM3grM0FISG5HK0xnL0hqaXdzbjRKMUpkN0hoRWxZQVh4?=
 =?utf-8?B?SkNsT1lCM3hGckc3VGZCWSs0T09MMytzd2pEYngyK3h3SFRhMnQ4NGhpVERn?=
 =?utf-8?B?NXd6NVZEclBlcEI3QVZRb081Tjh2aEk2bDFQbUV6MzJXem1qZlFmeWJaNXd4?=
 =?utf-8?B?ZXg2R2JyazhqTVpoRUtVdXl1WDVZaWdDbW51UUd4b3VMaUc1VGJXNWhPVjJm?=
 =?utf-8?B?WHVTTmRnMGVIYkNOWTFCVFMySDRvRkdaQkxWZWIzS0lZanFaRWdSL0VaaGdy?=
 =?utf-8?B?RUJUNkFqWmd6K1V2QTN6QUpNUXluYzFpL2hDTitLVzJtYldtdnNKQ0Nqd1cw?=
 =?utf-8?B?RmR4Wm5HTUphWUdiOGk1YitQZGwzdjBUWlhXUkpyM3p3NHA1TXFtQlhocXJI?=
 =?utf-8?B?WmZYbkJOaWNBcEY0SDVvcTBCcDBhUFhpbGpJN1JNUm1RYjVSQ2JYeGswYng0?=
 =?utf-8?Q?btTmW+l+ZuS07ssX81X8ZXo90zTc0h9EVUhlk0K?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b93f59-4c51-4d6e-d93d-08d91a8057a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 04:41:18.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1rd4XpBEmw2RWbu9jurRkMXHfz/B6qYnN2bYcPu7Z7R4PrrFliQe7QOtDhNRxm//ndlRhnSCB4SfjN/ckV5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4103
X-Proofpoint-ORIG-GUID: O57WMMh7AXC0WXnK1GEfBCqxW--TnK8l
X-Proofpoint-GUID: O57WMMh7AXC0WXnK1GEfBCqxW--TnK8l
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_01:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190033
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
> @@ -1169,7 +1168,8 @@ void __init adjust_lowmem_bounds(void)
>           * and may itself be outside the valid range for which phys_addr_t
>           * and therefore __pa() is defined.
>           */
> -       vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
> +       vmalloc_limit = (u64)vmalloc_start -
> +                       (PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
> 
Here is bug, it should be

        vmalloc_limit = (u64)vmalloc_start -
                        (PAGE_OFFSET + VMALLOC_OFFSET) + PHYS_OFFSET;

>          /*
>           * The first usable region must be PMD aligned. Mark its start
> --
> 2.20.1
> 
