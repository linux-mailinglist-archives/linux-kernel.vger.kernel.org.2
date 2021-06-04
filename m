Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB139C41F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFDX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:57:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16334 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhFDX5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:57:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154NqmKQ008343;
        Fri, 4 Jun 2021 23:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Qm+H07P/mbU0nKk9CFzYUrm8VcZtyC24ITxTlwLfAq8=;
 b=AFt++rxKyWjumcZPSPtB1UMoauxCywQ0Xb8XSBQo3eie+TlqnE+D6TKDHhlVSTvzEeX0
 kLHPPM4QwQ2tHBIas9oCsipCf9LBadoa/DmD8A50i93f/NXzL97GGUD61LOXdMH2B0Id
 9cYIJNPykllqp/QO1e3NlVshoU8RKVMqv32TS4rn/3E2WbiZLfJ7ZxosF4i8ToehVr+x
 WHVZJA8X7ZBLtvLOo0L3Q6wpZg7x9wmgvrW3gum+VNQ/hd/tFflhwyPHio/5uWoljyNL
 c3X+Ymve7NTul9ldFwAoL8YsbAq3pHXmU/EZI/CVFsxMNneHtyLkWuU1RoQgdHiFtnKx yw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38y0p50k0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 23:55:46 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 154NtjkX165967;
        Fri, 4 Jun 2021 23:55:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 38uar0pugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 23:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8nSjhE3+05ZFPt32kChPIKmUnFw1077kO2fJpXmBgKjTkvxHnaig/L6uLcOCaHgE7UzXJKWqOq1S6XXHD4WpFg07QL8x6Advdpa0g9l48H3Jj5TvBVQ/tnfXdVwffwHoNfPQzprjTWhDGnrvK8A1RoohRM4e07HPYsI1IV/tWT/jRdC01bX9VPwgOSeFfvtqkz2VtKiWSDKSJr8ip954GxDo/agjxEdkBM2DBEv06eG1/xrekgu2EFklB1KdZKdpWIsNfiC9DWa64aXVsHyNcUwbkKahEJ0Wi4Ra9vVYNkwIYVfhJWHW42zIvnpkfePqPBHNGXaoRBFXAyR1ADtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm+H07P/mbU0nKk9CFzYUrm8VcZtyC24ITxTlwLfAq8=;
 b=LOdlPBE6fo6/2FbV9kyLVusZPlaFJgeNXnt3msSZ4t2uka3R6W8BHe431Fojiz8/cJhzIAOnD5EuCnF/4+6QTToqFcZvc3PulCnhG4kGTqwC4NALbT3HpScGgdjK0cpkjNAB2PYZtQZsJGfHrFUeaGGe2vFODmjV6eAEG15BOy2AzbNjXn23R+z2eQuhJ7FomHJ+T/17BV6S8EncxWZiXGtkjZhDA1QTp7U9TggqyvmXkJ7pbPntBhbHgDizLBZWQy1cy01DL1RkT9+MXtiMnAlHpdHbOeFVynH2qcthJzmd8kgin7eZbQcDt6FRC84hQlKPTCypyVtWvKkAwiRO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm+H07P/mbU0nKk9CFzYUrm8VcZtyC24ITxTlwLfAq8=;
 b=Ko3pgO5L/x16QvXLKaHzHMfhd2SzfmTOJC6yyt3kwHmzAjHma2wCtxTyyMJR1Y6UbPeVU3bqWq9t0jlu8HyWrjVO2Rgxe6Gv5dP0zpthLE+BUSsvmV91HPOK2afyKe0FrEkc9TV9P5ONwL2d+sfo3EZfY7SlrOGrK9c7W28N2Es=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3494.namprd10.prod.outlook.com (2603:10b6:a03:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 23:55:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 23:55:43 +0000
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <69922ccb-9ab9-33a6-4aa6-ea47431d60a7@oracle.com>
Date:   Fri, 4 Jun 2021 16:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210603233632.2964832-2-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 23:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8d9137-3237-4616-59ab-08d927b44368
X-MS-TrafficTypeDiagnostic: BYAPR10MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3494E1A031151551568B4EFFE23B9@BYAPR10MB3494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B93OPlCD50ATmZzOvQ7zZIQTjfryeDg+S7BDFJAYWVY1MQV0hLem+iwsqHAyS/FDa0P9PAYNnEdcZMqe8C1wuVNNzUcuQ8bfy4J+Jy+IO1PNFN+CXeeIaRjMlhaWc3zNoOVCBrU+GqrUBe8nK1hAZ9P9MRINXYmfAxAsOJErfVB+WgLsI0CW11xIq/BVfG2yrRwLdGREVUU8K73CaCNVo4SO30SqU13Rm3xLxI0/JhuEliMID2oqXeKx1pvGX3RwEpT9V0cZ0riEjttmvXEhuvQ0BFunVPD0ohBByNltGMT3Ru83NLp/YVy2vXAD/dDbDfXREFz/aDMNsfoE5/drDw4PU1tutVFTWnjlq5VK3AaXy2ggQqjoIJy4Gt49awi3o+IVn3a0ltY6HOrEMTIeTUCflHu3GSLJKyWHmoppQwrUljFqcBfZoqizUtg5YWURuAyFNglnSOoZuE/qQJ17JVkqPdz/dAAsCdRyF3SnyWiVKy8D8rADj5nA/D6uwBfGRZRHJxEUYQU6DiXE4mgFEckFI5bhj+KlgQTdFVfYkhxivBC3T4ciXES+rrpPU7CJXz5THfZHVfuTLWRwuq2Alsq8N5pdAiatThWpqWRHECua+OuD3DLPIQAENrxHZYYGb18IeUqw09+B35rRVA64MCKmUGkWr5MAj2xt58zv2pGrUpbmi/ZEL77M4CaHLr5jgvOlZ+MYlmhvIPXHEJTo/6bRFamZBhwd6k+Vyht5dPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(396003)(136003)(186003)(31686004)(52116002)(4326008)(53546011)(86362001)(26005)(6486002)(316002)(16526019)(36756003)(8676002)(8936002)(110136005)(16576012)(83380400001)(54906003)(478600001)(31696002)(5660300002)(38350700002)(38100700002)(2906002)(2616005)(956004)(44832011)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUhQSk4xYUVTRXcvelM4TjNnSUJnVWh0SFRNOWROZElFVkVNaU1VbC82S0R0?=
 =?utf-8?B?RnVUeVU0N0NqbnBxck9aN2ZlMkZrMWM1dzZYam15VHVZMW5tcitpOXVlODJh?=
 =?utf-8?B?OFdOMnBXYXlNcjZQa3dlRFFwc2ozYjdFSVBKT2xzRDNaeTNBWWNGcDByL056?=
 =?utf-8?B?MDBXcklHb29yY2sxNzg0dGh5RzJYb244VUhNYW5CQnNtdGZvQzI2K0ZsVjdv?=
 =?utf-8?B?WE9USWErRGJvaTNsZzZQOThEQkZvQ1YzVUlZUk5ndVRpYWRDZHdMUWU4SldU?=
 =?utf-8?B?ZlAzQmRLd0V0YVBTTHgxc3ltUEhLRGlIM1FxNnRhejgxRGw1RkE1aDdPNDdS?=
 =?utf-8?B?MnV0TFE3RFhmRExNV0lOUzJkdjR6WlpxdzBwaFlDdEQ4a0EwZVVReWNhOFB3?=
 =?utf-8?B?cGtZbHFncWw2RXF4aVlJd0ZOdm55QTRPTVBaMEYzSklVZFEycEJKYlZBVVNm?=
 =?utf-8?B?NHBoNWYrSEw3SGZvYmxacW45YzJ3N0g1cDMxd0V0Si9Ca2hQSW93ZHg3TVo3?=
 =?utf-8?B?YXBBOEdnb1ZwdzdSdWJKZis4VlFZL2I4RlR5RlNFbWx5M3BRL3MzWHZyUjM0?=
 =?utf-8?B?U3VjMmt6emFLVVlCY2xGdXpOek9IMXFJUmt0R0RDWHNHczM4WmNjZW5jeGsx?=
 =?utf-8?B?ODBWVXc2QmZob2ppeTlGdDhZTFRGVW01a09sSC91MFRrVG5pZmNpUkF1TDZh?=
 =?utf-8?B?aHdKdUlzbVpEeXczTkpYT25wZXBDNFpEK2lOMTA0Z2RieTBkNytHczlUTWI5?=
 =?utf-8?B?WXQ2L1FIbmllc3JwdlduVGtMNVRzWUtmVWFjUGdESGIrVVVqaHNvWmlCbUFk?=
 =?utf-8?B?OHNkTUlmOUhSUXZJS055cXp6UWY1ak9QYWF2WmI5c1krb3VybnF3OVVFcWNY?=
 =?utf-8?B?WlA4TnpOOVlON0p3emE1NlhoME40SWJ2RDdrRTRMdm1OZ0pVQjAxTjFrd0E1?=
 =?utf-8?B?U2xoSVQzK2xkNGxiV3FjNk9HUU1pd1p5R3hzUDNnME5FMmVUR1RKNmg5Myt0?=
 =?utf-8?B?Tld2elh5QU5BK2E3R0xXYkxYWHVqL2ErblRNUk9nVTdDdzBlN0F5K1JTdFlW?=
 =?utf-8?B?YkZvYndxKzhWRHNOdFRJdWpodDNaZHJ6Y1dQRTV6K2k2Mklib21vYXJDNFk4?=
 =?utf-8?B?TitEV0trd0tJWFNmellvWjlPM0NHZGw1Z04zRkRxSlBuclM5NVJuR2cxQjZ0?=
 =?utf-8?B?aWlCUlFGbmhoeWJkTUVRWUM1Tld3Y1VPbWpXWmNmNEV5eEtZOUplcG85bXJH?=
 =?utf-8?B?cDFwRGhCQ2wzcklMVjNMNmpxQ3lvakowU2x0UFJKa256MXNaaEhtL3d4OFhS?=
 =?utf-8?B?b2NUT0puYWJiUGN4TGtaeG9JckhZTFJxV3FVN2FrTUxLeElBMStubGloV1Rp?=
 =?utf-8?B?czIvSmZjb01xdXZYWWZGT3BhWGhXYUY2TllIa29LdEpwaFNreTA3dWpwSkxq?=
 =?utf-8?B?bis2UnRodC9hdEZJcXZEZ0RqWDZublV0U1pjSkdkRjRHMWx1c1Z0bjVKTUM1?=
 =?utf-8?B?ZnpVQ1M0STZlOUxMcEV2ZmszUjZWTXVpcitRaEwxR0tMd0VmZW00b2RvbHBs?=
 =?utf-8?B?MlVESmw2Zjd3SXZkR1cwSzBZNi8yR1c1bEpsTUZac3JxNVNleVdGT3BvL3lt?=
 =?utf-8?B?RVpWYURibkZjRzBVM1BJUGM4VnlzNXRFTWltTXN6QS9CcUZOYVQ3a29JOSsy?=
 =?utf-8?B?UjJqRnJKK3NqUWUyclc3b2VKdDRtVkcvcXhUWXJxbGdBOFpBcVN4MjJGb3FL?=
 =?utf-8?Q?6NNyPesZYvJ7niCvLSVk13cI3uc0D7XMNcWA9o0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d9137-3237-4616-59ab-08d927b44368
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 23:55:43.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC2fbQi+St5xXX5DTN/n5NfTGpwQyk/WlGBnQAh/sHxe6m24trywDNpo54DU9FR0B9jpqxVh0ydb7p5RrAxxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040163
X-Proofpoint-ORIG-GUID: RgEeWr5rCYsGXIWxBRzChfTXqJGZo_p6
X-Proofpoint-GUID: RgEeWr5rCYsGXIWxBRzChfTXqJGZo_p6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 4:36 PM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks the page refcount before taking an
> additional one for memory error handling, which is not enough because
> there's a time window where compound pages have non-zero refcount during
> hugetlb page initialization.
> 
> So make __get_hwpoison_page() check page status a bit more for hugetlb
> pages with get_hwpoison_huge_page(). Checking hugetlb-specific flags
> under hugetlb_lock makes sure that the hugetlb page is not transitive.
> It's notable that another new function, HWPoisonHandlable(), is helpful
> to prevent a race against other transitive page states (like a generic
> compound page just before PageHuge becomes true).

Thanks!

I believe this is good enough to prevent the race.  Since access to the
page is not synchronized in any way, it would still be "theoretically
possible" to race.  For example,

    CPU0:                           CPU1:

    HWPoisonHandlable true
    				    page freed to buddy
				    page allocated from buddy
				    page added to hugetlb pool
				    alloc_surplus_huge_page

But, this is very Very VERY unlikely to ever happen.

> 
> Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Cc: stable@vger.kernel.org # 5.12+
> ---
> ChangeLog v6:
> - defined HWPoisonHandlable(),
> - updated comment and patch description.
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 15 +++++++++++++++
>  mm/memory-failure.c     | 29 +++++++++++++++++++++++++++--
>  3 files changed, 48 insertions(+), 2 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
