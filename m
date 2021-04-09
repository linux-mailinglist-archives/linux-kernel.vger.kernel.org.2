Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E530735A814
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhDIUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:45:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40786 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDIUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:44:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KeMlY010046;
        Fri, 9 Apr 2021 20:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Nxj3JJXriyWDDh1DLAlo0g6KtgVmNV91xpasvoOXWdQ=;
 b=a1cCAhUn/uKzhN+G5EaYWzbv/RjkxXlxo2Isk7A0YgEJUTM9vJ+lfdA6B9Rm5DGr31fz
 d8Xgv8Mq58o3XRoqbAyctGVfJSUbmywGbP8UzgjdaxExDvBiTJ1S6v2EVCGuasgqZKlH
 siPBbrOAvjxI7FUMESZM2C7m0rIuvZ5cxf7zUyBUSIifnKazEgB3+865kW+bq3aMsgFa
 T1GvQ+VCfwBQtWxBjh0bYdCrujj9WUr1T6jSfVNOPpP950Vj6H5hplgic+0Az4ZsLixt
 ovtXiJwQY9Zp7E7ODbd8joEFm2jCeE3xH6kRFKdRAivadg4jE8NocFCrGnbFW80eYdeg 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37rvawapqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:43:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139KeEZM161659;
        Fri, 9 Apr 2021 20:43:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 37rvbj1e2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 20:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm2tvCb1UdC4Y2pJ81HhJiBag43bdG406QaH4ZfcT6yj2IotQz5Y9qov+WrPNiWc+DOjZRO2jop87dw7TcbTBDVzdWiToxtPR6DIY0F8y+ubSROsA3sYb/5Lm/++34dcnjtCQbk7OL2BM00mmfwaK+9tH8W4e9rn7re1SaW+5SFC7zKuZblah/9DSTRQuQf6iO332QBPrIq/ZUO0cDpQvEn4xy7qAiP5LIMoV3e39XvaD9dpw2d+HrJF7JktVpqXzCYW6Hu+tk57Dw7kN78vfjs0doM6K3EHl03mbB7filqhjy13VG0lqY0DYe5tIEipAWcdiZgAWNaC+dbZ7JIrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxj3JJXriyWDDh1DLAlo0g6KtgVmNV91xpasvoOXWdQ=;
 b=lzq05sXEDasZlKA6xXkkaf/3H4zgLo06o46KZgLeLrbMp9Z0l3a2kW0BbIVkqJew3NoBDT8+leYqRIZEDQbEd2NzZ1rgS03VDARIjiXGO6sKNVK5MrmwQ1I53lNJYFrL3LrVHOnz+Afvqon0N9QMNegrekbbiqNQnbw0cZOHO75igm7ZtIqb2sCd5PY7DtS4gCuGH3Ve9YfMXdVVz/QWfLF6BrUMOYLVDbXkCvEm9BfhBywGuo0WVt+xb+awisNuRvoixHanAaB72cBTjqnf9eBPTxbbuCXJc0rsjiMFkmCiARNIvAN/nIpUl24pf9hYOfedKbXlzTOi+S63cm0Zyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxj3JJXriyWDDh1DLAlo0g6KtgVmNV91xpasvoOXWdQ=;
 b=u11CSNy6vO0eQLii9erAgVPgowKyxSKx3FZmLkFcCh3fiY5fHM7XO/bth4/QK7xZ8gbXvBnnCplQQS4x6icHxQjPe/Fnv/W3xDpASKaKVTe95CVLVf+0YkLRg+QU4colOcPJ9oS0pXapnbwf6GHSoHsWxdtqUc4hg5f93SlvN9s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 20:43:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 20:43:14 +0000
Subject: Re: [PATCH v4 0/8] make hugetlb put_page safe for all calling
 contexts
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <01d8785f-efeb-553d-f075-6501c621ae20@oracle.com>
 <YG6soiwXQJ6EEA+N@localhost.localdomain>
 <20210408220513.36b57e18f1f538213a315ab7@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3485aeaf-b250-6632-d546-e81d7e8406af@oracle.com>
Date:   Fri, 9 Apr 2021 13:43:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210408220513.36b57e18f1f538213a315ab7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:104:7::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0130.namprd04.prod.outlook.com (2603:10b6:104:7::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 20:43:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab853b14-8417-4023-9f9d-08d8fb9818bd
X-MS-TrafficTypeDiagnostic: BY5PR10MB4355:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4355006475D35CB4FB3DDA74E2739@BY5PR10MB4355.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkObwl7q8M3fcg4s01WV5F2Hjf1H0mODIMD/T1VYF6Ami03zgysN/wdPu/wajA1PX7WatgN6QoeYqJjHcy+Awnn2rdvn2DjYCvJat+PpyLwXInhh680g18zm1SDrTHNbKUREpKog56cxLz1f+wKeHHopEF8H1fCyOESrUXRicBEh9mmRXNGMT9mxs0NFznEhCQwQEgQUuF+Uu2qqyM1NvkP5Pem8WQZpyVoesDaMLaIdbjTYzjNHirK3vK3X0kPrZWTPQOSNaFIj0IR1X52cHMY8h/CsVGOQpvSIlyrO6KstowCHSEPH5p1r3rpjFSWSgSrXfbNgKQH/l0rI1jbFa5FEbJ+Vwsuphf5xhntycrIBli1SkCYKCtQIuAc3vh3Qc8ERtxBG1bbk4JadFPBzzI2UQIr0RMHhES+Vtluc15sg7SgN3cyLzpJYboFhHqQvR2lZqTW0RwvLl8fFiSqXiTncRoOu0BFUWnZh7ZqQeyHo+UWhIBJME0IxCGOqzydUQSTSqkz8vKZLiYhfJi/4yNITpWrl7UAmt2GtVvEDbg07lJQ/gYG33LE1zr2ljOseuznwAnHNgZcVYlwAMW61URTdo6xG2sCRyMm8KBg7ddFlG3S+HcemjQ1H5eG6CsGwzfywF93+gEdvjLmJkpe/jqdj/fYe1Lhp9Hyp5HF7PM9/zSj7ZQpbh07OKw6rzsV8jaxprkibB6RkPnAP5UCQ7UsjamYLtE5+tNvOD+4DkgQfoJS8F5RHeyOFyW51zNSJjEe4khlTb4iKRplOAVEtN4hHj+5arhQ5OXPVnvvfhR/WhQxO9JxNe4q6Mb7niO6wf8aJCYSP9xBJY6H7b7SjBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(66476007)(478600001)(31686004)(7416002)(66946007)(31696002)(16526019)(86362001)(36756003)(6486002)(38100700001)(2906002)(186003)(83380400001)(38350700001)(66556008)(8936002)(44832011)(2616005)(16576012)(316002)(53546011)(26005)(8676002)(4326008)(54906003)(5660300002)(110136005)(956004)(52116002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHAxeXprUzlaYlp6YmlWTzg4a1hEUWlNaVg4M0hyVHIyM0cyamd1Nmc5Tks3?=
 =?utf-8?B?MWZLK24zTHJEVWNCU3g4NnBoUkJIb2N6ODhlc0ovUStlS0g2ZXk2REpscjF6?=
 =?utf-8?B?elNPSVRFU1djM1VDTTl4a00zOE1TWnArOThWbmh2S1RPLzUrZTJlY0VJWTlk?=
 =?utf-8?B?WkNsdVl0MXZ1clBPV2lmTUhIMDFzcnJrbU11OEJWMjBETFZXRGNxZTlJbGV4?=
 =?utf-8?B?V3VIZjdHcG1CUEk4VGhMZlNOZ2RZSld2eUFMcGlNcG1ZTy9wV2VkTDBmSEQ3?=
 =?utf-8?B?UGM4aVJoS25FMkhDU3RmbE8vZHhMLzV6cU1EclA3dlpYUStOMkFxa1k5RGN6?=
 =?utf-8?B?anpmaHErR3BFTXRpTklUekFqOG1DZ1BXUTI0dGFUSFl1dklReVFrc05lUTdZ?=
 =?utf-8?B?TEd1ekgwb3dGK1N3MlZtUG5iSmx6WksrQ0QxMFZ4d2pCTWdYanJLTXRlcG5P?=
 =?utf-8?B?VGIwRUZpUzN5M1FzZENVSWJsRER3ejBUbUxWTFlxaFd3YzRGaXZxT0VyL1dJ?=
 =?utf-8?B?UXBYSTVDcldpaGRvRk0zT2MvVDRvMlJUQUNyRFBHOWFZNDUrVmZqdWswUHV1?=
 =?utf-8?B?cjZuMkt0blpXb05pSEZjSExLRjR4dEhVOW45cVBQbGJ5MVdYVXp3SjhjYUxn?=
 =?utf-8?B?REFsRFJvc2dBZFErOUhzN2xSUFQxa2JCVlFOVGxaTkViakpZd1lzeWt2c3Nn?=
 =?utf-8?B?Y2ZoaWQvQTVEendiSTBUUVRxVDYvbGdJYnlXbG9ZNFFldEx3NFM1L2x4djFN?=
 =?utf-8?B?VVM1YWRPVjFxSVVPS0VrVUN6cmwxMHVuWldhTkY1eUJGZjNKUks0QS9wZDgr?=
 =?utf-8?B?WDlxRHcveWtoQWtsd0lSbHRVZHZ5Tlg2SVVNRWRBMDhyMlpCclV4ZExINHFE?=
 =?utf-8?B?Sk5sUVFQV0NWNHczSEIvcGVjTmtpWlRyc1ZnbStQSjdmVzRLSWNhdUZTVDNP?=
 =?utf-8?B?TXBoa1pGVXdXYURMN1hCSFhJQXZZSmx2cXA0TU0wdndZWEF6ek1TNFUvei90?=
 =?utf-8?B?ZC92UHR1Uk9CaGdUZXY0YzNTQ3c5WkREYzNVcXkybnVTZXo4Z3dLOVc5aEdm?=
 =?utf-8?B?Z253Y0kxa1pkYzF3T1o4REhCc1ZxU2ZaMEVKWTJnd2FSV1p5b2Z4V1JPZjFZ?=
 =?utf-8?B?cVRIREdlT25zTjBPWk8veEFENmpSK3oraXF1d2FrMXhOQ0I3UjJnQmVwZlVw?=
 =?utf-8?B?Qyt4TzhTZWE4Rkx6ek5ZcUdzVHF0czRHbHVRVXBVOFMrZ1JsUVBMaVNDakFw?=
 =?utf-8?B?SUZ6QkZnK1RsVkV5akc2ZXMzelk0QW9xbEY1U3J4ZkRPUWhGNGNzd3liVGZa?=
 =?utf-8?B?RnBXaHRVZ1IvSlJ4QjZ5UGUyU0p6SDBkWkQ3YkNhOUkwMVhaVll3aTJrUVAw?=
 =?utf-8?B?R2tLNzA1SEFxaWlySWlmVGg4U3JmSEFoK3A0MDJLWW9zaldZS3JFVHZVVXpx?=
 =?utf-8?B?MEZKcWc1UGdxbG9tM3U5TGUvMHlOMkp1ZmRtSUdsM0ZuQUkyWXZ0bVZRS3dQ?=
 =?utf-8?B?bWNXY29aVWsvU0JySVlNYjRGV1RiclczbWJjVi9JWGw5SHh3Q2h5cWxGWGs3?=
 =?utf-8?B?dnJuMXZJb3RNcTZhRXNpcmxiWHc3b01tSXNlaEZzNTdOSTRlckdzK09JYmVY?=
 =?utf-8?B?VHB0N1huR2k3RVNZT0ZLVTFVN2FJT1NBQ24xcWU0ZzZJM3NhVEp4a2JiZ2No?=
 =?utf-8?B?MU5iWFMvS3d1SklFNzJPckVYSzhld1hLbmoyZVVHb25wTmU1ajlhVEVhaFgv?=
 =?utf-8?Q?PtLWmyLnqX0x6qZs0cjGN0bp1Pz2pY7E/ZzX7KB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab853b14-8417-4023-9f9d-08d8fb9818bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:43:14.6589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU8Y14O/kGmYtZbvfU9lcujA1NOgybYhirLffH2lpr5nxjMMqqXmwfDgamlJMjzn89Lw+oxgjFKe6/i9wePunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090151
X-Proofpoint-ORIG-GUID: nKH_SiLwPvBd3w9CIfyd-YKB-Ykvs_zv
X-Proofpoint-GUID: nKH_SiLwPvBd3w9CIfyd-YKB-Ykvs_zv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 10:05 PM, Andrew Morton wrote:
> On Thu, 8 Apr 2021 09:11:30 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> 
>> But if It is going to be easier for Andrew, just pull them all out and I
>> will resend the whole series once this work goes in.
> 
> I think so.
> 
> I shall drop these:
> 
> mmpage_alloc-bail-out-earlier-on-enomem-in-alloc_contig_migrate_range.patch
> mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes.patch
> mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes-fix.patch
> mm-make-alloc_contig_range-handle-free-hugetlb-pages.patch
> mm-make-alloc_contig_range-handle-in-use-hugetlb-pages.patch
> mmpage_alloc-drop-unnecessary-checks-from-pfn_range_valid_contig.patch
> 
> and these:
> 
> mm-cma-change-cma-mutex-to-irq-safe-spinlock.patch
> hugetlb-no-need-to-drop-hugetlb_lock-to-call-cma_release.patch
> hugetlb-add-per-hstate-mutex-to-synchronize-user-adjustments.patch
> hugetlb-create-remove_hugetlb_page-to-separate-functionality.patch
> hugetlb-call-update_and_free_page-without-hugetlb_lock.patch
> hugetlb-change-free_pool_huge_page-to-remove_pool_huge_page.patch
> hugetlb-make-free_huge_page-irq-safe.patch
> hugetlb-make-free_huge_page-irq-safe-fix.patch
> hugetlb-add-lockdep_assert_held-calls-for-hugetlb_lock.patch
> 
> Along with notes-to-self that this:
> 
>   https://lkml.kernel.org/r/YGwnPCPaq1xKh/88@hirez.programming.kicks-ass.net
> 
> might need attention and that this:
> 
>   hugetlb-make-free_huge_page-irq-safe.patch
> 
> might need updating.
> 

Thank you Andrew!

I will send a v5 shortly based on dropping the above patch.

-- 
Mike Kravetz
