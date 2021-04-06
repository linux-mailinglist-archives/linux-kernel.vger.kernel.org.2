Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE19355D43
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhDFUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:54:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhDFUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:54:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Ki603160438;
        Tue, 6 Apr 2021 20:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ctw/SdAW2VyUdk+Qbiw/ocrXgqa2knASa8mT27a/j8Q=;
 b=nXx1GX8k6GUiE35ZjWlUBi5k2ZrqMCk2i0zhPqJ94i+/A8TFDTbPYD9GAThfV79dkVgQ
 k0/UX81cNU7EsDagL8O4Tb6c9KxaE952GDkJewecvDYlHMbYgzvw6LuLQEB890GZi5DB
 haxhuXggTeS4NDdrpLtfNqGWBZZuIO0Npe+PBfDCTjQ6tPU/PNYS8E3Cv8QzI03a2stF
 /FB1A36SWzqMI1Fne6/kiAbtw4kLDgEiJ2mbZxyeOiWNT8ZwTURIVdGLE574Xpzi/NS6
 AuHB5zOccCAgLiTLcXiwG9/40G8DxVZJbOMjrUKWVKtnm2y6k2xzLQ4J/9LOO2Gl0JtK 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37rvag8gqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 20:53:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Kjvof134109;
        Tue, 6 Apr 2021 20:53:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 37rvbd6dbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 20:53:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdzFbKoW24CN3YFk7ZVfuFcgJ0zv1ZRYs72AFIlfOZQTnRtjOedjiVNQvwuq8DtY2xmosgTOEN41RslpozQgu1PdV6xbsKetXELo0odmilQ3Q+nHmpwUfeAPwA9ebeRVu2MeTQIVwbX9UaunceCf+CF4aPU1aCzJ2hdHQF3+4g1JIYtLw9b971GzKJbYqHhd2RoskOuDyykmkz2vpyg1jdlZ0/G37CmQ2pJWcqUmPtrI3lI7pdh3Wi2T1nH2Mr3ukliB3HaxiD03gebWz34r7OSMQQJ7KgqO5in1UBvYWnVHGofmvmsEN5WMATY6mpuw5AJ0oGFxSTwYuxtpQ69SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctw/SdAW2VyUdk+Qbiw/ocrXgqa2knASa8mT27a/j8Q=;
 b=fT2tPnTQMgnrBhm2+FQ9xlxkHT7k1ebHJAKqhlDJF+5F7AcAui3CJtgY7rVBGXdhFaUt8viqy4Gp1C3y8EAiVz4AJEF4zhuKo9oU+0CqsbWW6jFz9/6/CALqptVpDF1Ma7tJf8T+41TEWAH0JpgS6F51l2K5O9wFg3Ldt4/ZqONgRvhpNEioh+TGpE6mU/CJ78Co+x8PkYdBjf8baxFpcQCf56rCYp0Onutsoe/6p15YMjRAre2NsjeUxl5hxW17CR986Qo9ZBf2GxHo1LNnLZZu7DyScHNdwxfdZKNpqZdQ74F+cCevVjgrQBcyv54Py0zKxzCOGbXeK1FrBzcl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctw/SdAW2VyUdk+Qbiw/ocrXgqa2knASa8mT27a/j8Q=;
 b=IaOy7FNvG94/rscCNyzWHxa+aD2JcyUWSkRIsVFvSsDjVFVke0QVWkfs+oewwacO7zX1JFBSrYfzOEH0tkQmGp2fqkd44xS6cu6TVkdZUSVaqC/Ezr5+9nc2qFSJvvURJC2kz1iGXSdLxt//kbuO/5yUnJQxJDRItqwwJayfrmU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3400.namprd10.prod.outlook.com (2603:10b6:a03:14e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 20:53:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 20:53:01 +0000
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Oscar Salvador <osalvador@suse.de>
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
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
 <YGxk85nXJD+NxzYX@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <86020115-11af-e4fc-9b42-4fe809f7b26c@oracle.com>
Date:   Tue, 6 Apr 2021 13:52:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YGxk85nXJD+NxzYX@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:300:117::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR03CA0018.namprd03.prod.outlook.com (2603:10b6:300:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 20:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1210dc19-57af-4679-8109-08d8f93df6e0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3400791B66304A59A215196EE2769@BYAPR10MB3400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +F/0grmDQAND1c2p/iKKHcbVOxK9/XjcOzk8wY+Z43Lz6ACtUKT4gDnfbC19e6di1cZYUljuPfTHvPvthmgCmAcajmeMqR7IZ266StmTvHwkUs9BTqaVjpmI6UHO05CP00oDGXO1/6Aq/P7PevjOv1P6Y8Jx5l9OpOD8d39v9t5ewn9AOjeTsbBfziZOXfVIoUXFzxdn7DdGnzrl1t+/+9jGYRl2wtA628FiaBA5FEt1lfAqRcFnnl1SD7jb5u/yvU2XFgLj+jYaFWMfnXXXbJ/6m/znmFYla2iiK2qGBoF+pcupvvuEhgri2iv3VB5/qrCeIU6xELihNY9JoJRUyqrjf+M3P/yn3XnMsHSUoFvtOnA+rGHoaHFD8XJxTTGf4x4Il0KXEsmw8GWYfSw6UGxm6Z2x3p5Zrn90gkiO/PSWw44wc5N0MAITUdLUXPMuMAKXh2ghvnz+uA5CgYALMIKIaWinGIIsc4BFq3CShSViaTstJm3n8JfgHMHzIcSxcLNi03ZvHItBTOLqjkGF8G/zrDEXpCoWN1P5zu+4d4tuCm0hydUv02LMAgDv5ijeqL30mTOW1Afk0y6WimRMfgfx6CaPev9GtcK4Z127NeD683h63TBM3lw9q3jDL7Z0NScmNnT86ImBNcveCCLnuIIDlQIA3Cy+BnXjpPvcgNFQ9Tk+nkT1RtHQzQatls88d4eZ9cUx/cgiBSgKZtbKDqRfQoz5u6RDIRURcQTE8MkWO/x//Hrih+t1XPmZRTxH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(83380400001)(66946007)(478600001)(6916009)(86362001)(8936002)(54906003)(36756003)(38350700001)(4326008)(2616005)(5660300002)(956004)(44832011)(66556008)(316002)(8676002)(186003)(16526019)(66476007)(31696002)(6486002)(52116002)(2906002)(53546011)(38100700001)(7416002)(26005)(16576012)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajd2U1FZSVhseWlWa0hwNmFyNUZlbEFYQ1F4Ym1pRTZ1Y0hEMTdwb3BRY1lp?=
 =?utf-8?B?bXRBcVNtTDZidndXbmo5N2g4L29DSTMvdTVsMXJoTFlUZ1h6M3RWZjRwajI3?=
 =?utf-8?B?cjBGMlZReVk0SERna0JXTlRtS1JvUEdNNnRyQ2hCb1lSWXZBd2RsekY1bWxZ?=
 =?utf-8?B?NUJydkRjT1pORFpYenhhUE1BanVRMzRHc3FWRnUya3V4UzRac0xmWHZ0bHk2?=
 =?utf-8?B?b2dUMXh5VVJNdS9HK0U4ZlhXMnJEWWZMZWQ3NUhSUERpVFZybmcwait3Tmht?=
 =?utf-8?B?Y2lRU2R2b1dJdXh4MEQ2Qko0RXRmczNERS94TmZDTzVpUjhJMHJuMXd6ZEdn?=
 =?utf-8?B?d1ErT2VrNFcxd3dIVVVhOThMc0U3bXRNN3pBTTFkR2l2WW8vaHdRQ0xTUnVu?=
 =?utf-8?B?SW1uK3M3TlgxTkFoOWJ3SkhKQUgwRHpuR0IraWhscnBydUJoMThTLzZSUU9P?=
 =?utf-8?B?dzJqRDlRd28rMVFjU3haQkNvd0RjZEQzdDkxWit1Q3NxbE41REJ1MnlHTGd5?=
 =?utf-8?B?MW0xSVRaOEpSKzBveDI5RHY5NWlrUG4vVjdBU1N4N3BUc0cwQUtiRWFTMVBZ?=
 =?utf-8?B?K1lseHFVM3BXM1ZxNGtxYVRiT3Uzajk4QzRKSFVFeHl6T0JSRmhKbVM2Q0E4?=
 =?utf-8?B?WHFtVThNOEpyMFNscUJWRDdXNTBwTW9xNVpvK0xiUzZYMWYyRjIvZUY5d3Fn?=
 =?utf-8?B?aVQ1VkF4R3BtSURiWXpWdTYxL09VSk85L0JaUGZhUDRYUGRhMkUvb2l0M29t?=
 =?utf-8?B?eVlBMHIvaWlCbVBpcFhhTjJheFlnRkMyNTd5UlJWNU4rN0xWMG44aEFEVkFV?=
 =?utf-8?B?blJ3NDVtSnRXeFN0MFlBMURjYlVIS25PWEdrUTVPcVF5ZmxpT1BtY3lkZ1dT?=
 =?utf-8?B?VkZzUmxySmFsNGk4OUdOdzczdnd4SVlORGMxUFNpRnR5SkRLNURYZ2FQUGhQ?=
 =?utf-8?B?OG16aGpBV2U4WldKaWdlYnQwcVVDbklMNFJFaEc0Tlg1bEdRUlVESVhQc3k5?=
 =?utf-8?B?U0FabmpOcUE5cGRiTlYweGc2SGlaNDZKcUdtWDl1MHVJVkR1SW1KT1JwNnVR?=
 =?utf-8?B?V0ViZ2gzR0dOZGovZ3VxUTdmWnVSVzg3MDdsV1JQZDlTV0QzMFRDUmhmZTNH?=
 =?utf-8?B?YTI3UGsxV25kSVVlV1REQnc0N0tkdld0dk5Gc0M4akVXT29CWFBob0wrZVJU?=
 =?utf-8?B?V0QrNzNzY216d3VrdURFdEM4NXBNZWRvU3ZYTzgySUZ3dEZ5aGh4eEdmS3FD?=
 =?utf-8?B?ZXI1MmRPQ2JDbHNKVTIvSVNXUmV5QTZ1VTBCSGJseHF6N0RTMk1VVTJGeXVO?=
 =?utf-8?B?L0JNU0pQeGVnU0FzbmJad0MyOEVzcitYV0hnY3MwK2R0a0Y1MzZQREFqN2hX?=
 =?utf-8?B?WDlxbGlsWTRzeFRSWlY3UWhLanovb0pRcWg5R3NJOG5yS1YwTTdBSmFEenMr?=
 =?utf-8?B?RmtsVG8rRmh4R2pFTzdVbXg0ZG9tRjZxNGFuUWlYcjNlbXBSbVIvZ3lKNGl1?=
 =?utf-8?B?Vzg1TnowSldyQSs0c2lpUUREdUpqa1YrNkJBNkVMa0JZSHNxZE1sKzd1WElp?=
 =?utf-8?B?WlRZVVdCVWNUdytKaEgraDNPL3dkRUhrUDNocXBjbXl3M0ZxV215Zi9Dbjcw?=
 =?utf-8?B?djJQaEswWFNBUVFRVENTUmRjRndEaTBYRFdVTG1teTRWM0JQSFVmdVA3Sncy?=
 =?utf-8?B?Vk5DclZCV1FORUpjc3c5MldXREdVdVI5ak5GOHhqRGNXcGxKajlCNm0yclhR?=
 =?utf-8?Q?rwZbAZm9wfWEnwOMpy5LBzDXxzJCVOnCdSNMQ/o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1210dc19-57af-4679-8109-08d8f93df6e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 20:53:00.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4suIbX9Y9Mv5iXFo0JA5DhSD8Zu8kZQhlQWnGHeRz1TN9xzIlxR+MPzRZuJsx1/sLBpfmQy3W/9jmra+gM/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3400
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060142
X-Proofpoint-GUID: 9MTuZPCxOul4eTxLCiviRsly4Yb8oYxz
X-Proofpoint-ORIG-GUID: 9MTuZPCxOul4eTxLCiviRsly4Yb8oYxz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 6:41 AM, Oscar Salvador wrote:
> On Mon, Apr 05, 2021 at 04:00:39PM -0700, Mike Kravetz wrote:
>> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
>> +							bool adjust_surplus)
>> +{
>> +	int nid = page_to_nid(page);
>> +
>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +		return;
>> +
>> +	list_del(&page->lru);
>> +
>> +	if (HPageFreed(page)) {
>> +		h->free_huge_pages--;
>> +		h->free_huge_pages_node[nid]--;
>> +		ClearHPageFreed(page);
>> +	}
>> +	if (adjust_surplus) {
>> +		h->surplus_huge_pages--;
>> +		h->surplus_huge_pages_node[nid]--;
>> +	}
>> +
>> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
>> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> 
> These checks feel a bit odd here.
> I would move them above, before we start messing with the counters?
> 

This routine is comprised of code that was previously in update_and_free_page
and __free_huge_page.   In those routines, the VM_BUG_ON_PAGE came after the
counter adjustments.  That is the only reason they are positioned as they are.

I agree that it makes more sense to add them to the beginning of the routine.

>> +
>> +	ClearHPageTemporary(page);
> 
> Why clearing it unconditionally? I guess we do not really care, but
> someone might wonder why when reading the core.
> So I would either do as we used to do and only clear it in case of
> HPageTemporary(), or drop a comment.
> 

Technically, the HPage* flags are meaningless after calling this
routine.  So, there really is no need to modify them at all.  The
flag clearing code is left over from the routines in which they
previously existed.

Any clearing of HPage* flags in this routine is unnecessary and should
be removed to avoid any questions.
-- 
Mike Kravetz
