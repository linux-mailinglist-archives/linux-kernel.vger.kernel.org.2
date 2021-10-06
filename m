Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF82424615
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhJFSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:30:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39252 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231804AbhJFSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:30:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HuDLV027981;
        Wed, 6 Oct 2021 18:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qwIiEXDESYJmyakia0BsEFl6pSE9/1U0AETgIjIksL8=;
 b=u7UWLgZ1ToMsSq/KUuq+3SCjF2axJuep0C4pSSUzcYyQ7kZe8ASGwbKzOiEueSKDP4/t
 DOGol8VPhgtHS64G1pWHy/8tMolsLvja0KJkhysDpQYF0zUrc6c72Gv2VGvno3JIrjf4
 d7EGrgfFMcB9Kd15KVeUXJM6Vczy3V/oeMA/qzUe5jrggHSdvNS6ky1WKi0NQSHF845L
 T5dW1txjD2+x3Uekbr6b1Dc4wBdk6BJj6bFH4OfpwuwB3EInoBEhFEtlWM/YQxhQ0fES
 GTlYg8POgcpFJFE8e7yN+Ol4vvx8Pi3PaBJHaBnHmw6RGwYooM6Hd75irs+gjZVivNHt ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh10gf3dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 18:28:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196IAkEU155339;
        Wed, 6 Oct 2021 18:28:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3bf16vjbtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 18:28:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx+H6Kasno4WkGUD7+QSmqZn9UDFc1O3X4IYVYRFI9ETeXtm7yeizKqAqLcOmt4jLAVmirPbBs6fvgndDRdIMfP7NwrXDtxIPmc6GM1BeC+1JnXO4ld6qrvHxmwFwsos0pBpBUrpBr+kROCJgo9xg5uxu2QNpYmNYWM9cF88d14rYs8/7EnYBvTTrzDolIIKC2BrogRGw5KRhSbMlw6n+K9a7b9wSWnavDG8B8emAhWVhG8hSJC3gGG7uaqf93WYFzhQPnO/AUYbhr/8m4GQSw77eepHFQ3skYVvYzqLv2Mxn3XcRualm78JxWm9By2os+cw8iyAlF00nRP7hDgkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwIiEXDESYJmyakia0BsEFl6pSE9/1U0AETgIjIksL8=;
 b=glHJyvQjdsLG8PhjLOc9M+A0NxaKbTEj20f1b4q0fGbNQczaxJE3eHr81heQft/QHCfc89nMSfXuKHT/Mi6H/TmqNyEWZvqnHRSCuq07zp/MtlgmLzh1GEBRFKwLgLoXO99d/1/sTklq9yqKofVaWFIHYs8AVTlQfgBaPo/9KO0Mbwd6kdGKxArr3547j1k3CmHZp5ebdM/kD+Ib7mTfhlWIcP8sx8CK9P06+OIpo7WRJOABr4EvxlSNM8Sxumxcmn/GxA4ZpwMEw+OaXRxm8ODTrb4+sxsf0aPI7jydQtj3zXTM8cZlBWrBsS2unRVIffrKyIA5BfqvtE2J2Kx1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwIiEXDESYJmyakia0BsEFl6pSE9/1U0AETgIjIksL8=;
 b=bmP320F9o6WgbTqgji6vinvpWD4YYa1A4oqEbGIhFFfJRnmEDeWLRJXZp22HFRUZC52VQgTzStRuDHR1Q1F/2Dt0WOG4tCizSCfXPy2MyFnorIRH6WwPK0wuLDyCzUQLxypH138Wp98SZ8LhiZyO10BrY6yxlaQui9aflEnoxlw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3448.namprd10.prod.outlook.com (2603:10b6:a03:88::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 18:28:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 18:28:01 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: be sure to free demoted CMA pages to CMA
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-4-mike.kravetz@oracle.com>
 <20211005093320.GC20412@linux>
 <f1f011cc-5c5a-7c4f-5701-929918fa2dbb@oracle.com>
 <20211006075451.GA11341@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2095ad43-f918-4ea3-9dbd-76a7d1f174bd@oracle.com>
Date:   Wed, 6 Oct 2021 11:27:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211006075451.GA11341@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:320:31::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR18CA0043.namprd18.prod.outlook.com (2603:10b6:320:31::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 18:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994f5830-cb2f-4ce8-17d3-08d988f70764
X-MS-TrafficTypeDiagnostic: BYAPR10MB3448:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3448C4B6EFA70FAE3E814852E2B09@BYAPR10MB3448.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcee6OR3MDEOURXaI8z/2AGNC1ih7bUKV2IbuQGqtbHDbhXc0ru1YNryXxtkvFmw48dNymwpfyaInNGkqRXw93DddIJjD94wiG8qg+SQAb6PDOnjJhIVugsAVpC095Xs/lxJen3IYJUXL37iZHdYiBa6jTuFJPTB49zwyddhxtOvc861AO4d3MfyJaO+yM5d02A/0GNHdSZqYG8WkI+8+LThW4W1K+yUPvNjgcCJv/2zqt+eEn9LYn9kB/wHKmoxLUHLdCWrmTLfYmJ/wFEOaVxjNWIOSAhQreGo5vQNejTgU8qMd8P/ZqT6NYOqSpq7bxzxWd1MvbJAjOJjk8yAy4n9JnSvGc027yiW3VkIMX0xhDC38XOnWeAkZtZTs9QJ95Fnqy4gyy/ST1oEpi/ExrllEvRHg+oOr7Wf7oh5CHK4H53CkwElyatFQWKeNImBuG0IFRqWAluEs9Tc9y7yxI0J30YxpPTXrL1+0Dv0FGRGUwlrqKojGYwyw0SJQa31iwWxJB3pVScJMA7t3BL3rPsME3xRernhipeSsQ3tQdvoHI3vTAwpPjg+DtJ8f8V1H1IGuHz/M/JKyvROwXVKJDM9DEi6arS5Vd3z9DdywgRV0jJB/ifibf+Wltxir0OmgvBHdGEEqiFwWSR7Qeyp3MlPR6fxmz5w5i/B5eET/1Avuyz8kDlBO+VzJ/sIbtSr7sWU6S4Bom0ivjKm61DLIOxockOqgLt2zWJk2ekSbbJzqRa+JIjn6qpXmCz/HaFrm/NCRE9ZNuqlHE2FzP85Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(38100700002)(38350700002)(66556008)(66476007)(16576012)(31686004)(66946007)(44832011)(54906003)(86362001)(36756003)(4326008)(2906002)(2616005)(956004)(52116002)(26005)(316002)(186003)(5660300002)(6486002)(53546011)(7416002)(83380400001)(508600001)(6916009)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFp0WnovNVVsMXZYeTZSbE9jS1p3R3BvMnNJZEUzemF2d1Q0elBEMi9ZeDdh?=
 =?utf-8?B?MzdIR2ZML09UYmVrR1dNV0xWbUlUTlhyMDc5bUhsZFVwc0dNdkVpZWZhenNL?=
 =?utf-8?B?QjlVbC9Ob3hyR1A2S29DVUtQT2tJRnRTdW5zY3NoNnJ3dWdlbXROWHExZkhm?=
 =?utf-8?B?VW55eFJzVmJvUVozd2xQbUZ0Nit5TldLZzFnZHJTc2pDT0Q2L3BiRTA1b0xO?=
 =?utf-8?B?Z0grQXkrTHZmS0dUdVFKNEJXYzNZcXJNbFJEWHFIcnVJUkRHWjRvR2QzZ2pz?=
 =?utf-8?B?NVNyMFZqa1lzd3NYRHg3bkFNQXpGS0Mwai8wY1NrNlBZMEZxMzh3ZXk4dDJn?=
 =?utf-8?B?UEdQeVVWdXAvcVdobnZ2ME1KMzg1eWVxNS9pRitqckRYdkU5ZWt0b09Cb2k2?=
 =?utf-8?B?NkYyNVVzK0NEVTlCNzA0UU5jeUlZdXZRenRUcW9BanQ0SXorWFByVmxjdUpO?=
 =?utf-8?B?ZjFZdUpka1BGY3pRVFN1UERiYzNUNTZDdjlBZHczUGZ6YTZSbkQ3S0hwTHg3?=
 =?utf-8?B?bjBCV2JnNklIMHZQYkEwdzU4VGY5c252dUZ0bWxsUUtKR1lLUkFmWFphN2Jz?=
 =?utf-8?B?c0FvMG5NSmgzdnhXOUgxME42WDIzdFFmTjh6N3JJdzU5enJ6WkJESTdQMjF2?=
 =?utf-8?B?eFFXTDlnMEZObnF2bndxVmFaTXViVXpsMUc1RmQxQ3UveHNFRTlsbU5iekZk?=
 =?utf-8?B?bW5VaXNqT2V5eFlMWFJqaXMwUVY1WGNkUmhoZ0ZNOEJrYzlMd1lFSFpOOUZH?=
 =?utf-8?B?STRIcytVMVNydjdoYUtobDhJV1BoUElUZ1pNR3hHMmhsL1BId0hhd0hpVEsw?=
 =?utf-8?B?NEkwc1haRml5M1JNazBEOURsOEhpcXJ4Wm9zVjlCUEpVN2RLKzRiMTRvUmU4?=
 =?utf-8?B?ZHZUVEhGNHo3RmFrNDRIRG94WHhxbk9LYWEvNit0Z0N4MG1nWncvL0k2ZmFH?=
 =?utf-8?B?VzZPRU1HNFc1UHl3ZTU1RVBseVl4VWJxL2x2cUNobllyN21iK0wyUWdaSTNv?=
 =?utf-8?B?TTJ3ZktGeVQvM3JOQ3lSNEdXVkswQkVJKzIvSDVIWmIyZytlWTBGTEdRSGhQ?=
 =?utf-8?B?bE9BM3RaQTlaWjR0aTdXN0QxRVhiNmQ2cHFRR2t0QUVWOWpIMDI1bmdHbFli?=
 =?utf-8?B?eHdjQXBBalhMWkNjRE9ORnlJazMrdU0zNVJyc3Jxb0E1RUMySHFhbEdUd05y?=
 =?utf-8?B?UXk3RFUzdUI1c1I4RkNJbm9CTTd2V0wwWmlDVmxlL0o3TE9aZGVRWDVDdldr?=
 =?utf-8?B?dlFvYXhONG9kU3VJQmdDUnpqMlEyVXY5WjhiRzFaUUxPQTliU3VaSDVsb0RL?=
 =?utf-8?B?WkRhcExUQW1ERTlGdmxIc1BPZjNaaVdJQzV4NEZ0eDNzdmtROXJ4RFFPMUNX?=
 =?utf-8?B?Y0x4eDBmV1QwSFNsMTIraW5HUEVZZ2hZaHF3UU1oaHU3ODJJL0NnZHc4NHpB?=
 =?utf-8?B?N2Z5emd5MzVzcEhQNzVRK05JTUtpa2ZyVEFMY1VvTnRoYkx5M05lM2ttOG1i?=
 =?utf-8?B?dzN4dnRCVjJDOStLVi9nbmJ5T2ROUFBVN0RpTDFPZUdSNjlKNVhtMDdSN3hV?=
 =?utf-8?B?K0RpMGovc1hoYVhHb25NcXBjNWVHRm00azEwNEtBSFZBR05SSTlXRTkreGZa?=
 =?utf-8?B?cE9rNFZxajJGdk9SeU56bng2bGRxYlJZT1BTR0tkN1lNRTY3aHZCL204M2lr?=
 =?utf-8?B?WjNMY2RSanZUdlRQb2xra29Bb01HVlFmMGJ5RXBxVE9PVkx1VGRvR2NrZ0Mx?=
 =?utf-8?Q?Nn8XAm798pXYsLI94mP9NYUZPG2ed88ChdwD603?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f5830-cb2f-4ce8-17d3-08d988f70764
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:28:01.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jxvgcf2i6cU2ijfeyGiragveKp7Qtgra19g3KKgyftuRKPstm6P9AzjQ1nD+tiM6B53EmliGfrirOJwfHopGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3448
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10129 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060115
X-Proofpoint-GUID: sY0kZ0gjO_70-HW8RnqFmVVuQIT0_dOS
X-Proofpoint-ORIG-GUID: sY0kZ0gjO_70-HW8RnqFmVVuQIT0_dOS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 12:54 AM, Oscar Salvador wrote:
> On Tue, Oct 05, 2021 at 11:57:54AM -0700, Mike Kravetz wrote:
>> It is the smallest.
>>
>> CMA uses a per-region bit map to track allocations.  When setting up the
>> region, you specify how many pages each bit represents.  Currently,
>> only gigantic pages are allocated/freed from CMA so the region is set up
>> such that one bit represents a gigantic page size allocation.
>>
>> With demote, a gigantic page (allocation) could be split into smaller
>> size pages.  And, these smaller size pages will be freed to CMA.  So,
>> since the per-region bit map needs to be set up to represent the smallest
>> allocation/free size, it now needs to be set to the smallest huge page
>> size which can be freed to CMA.
>>
>> Unfortunately, we set up the CMA region for huge pages before we set up
>> huge pages sizes (hstates).  So, technically we do not know the smallest
>> huge page size as this can change via command line options and
>> architecture specific code.  Therefore, at region setup time we need some
>> constant value for smallest possible huge page size.  That is why
>> HUGETLB_PAGE_ORDER is used.
> 
> Do you know if that is done for a reason? Setting up CMA for hugetlb before
> initialiting hugetlb itself? Would not make more sense to do it the other way
> around?
> 

One reason is that the initialization sequence is a bit messy.  In most
cases, arch specific code sets up huge pages.  So, we would need to make
sure this is done before the cma initialization.  This might be
possible, but I am not confident in my abilities to understand/modify
and test early init code for all architectures supporting hugetlb cma
allocations.

In addition, not all architectures initialize their huge page sizes.  It
is possible for architectures to only set up huge pages that have been
requested on the command line.  In such cases, it would require some
fancy command line parsing to look for and process a hugetlb_cma argument
before any other hugetlb argument.  Not even sure if this is possible.

The most reasonable way to address this would be to add an arch specific
callback asking for the smallest supported huge page size.  I did not do
this here, as I am not sure this is really going to be an issue.  In
the use case (and architecture) I know of, this is not an issue.  As you
mention, this or something else could be added if the need arises.
-- 
Mike Kravetz

> The way I see it is that it is a bit unfortunate that we cannot only demote
> gigantic pages per se, so 1GB on x86_64 and 16G on arm64 with 64k page size.
> 
> I guess nothing to be worried about now as this is an early stage, but maybe
> something to think about in the future in we case we want to allow for more
> flexibility.
> 
>> I should probably add all that to the changelog for clarity?
> 
> Yes, I think it would be great to have that as a context.
> 
>> After your comment yesterday about rewriting this code for clarity,  this
>> now becomes:
>>
>> 		/*
>> 		 * Set demote order for each hstate.  Note that
>> 		 * h->demote_order is initially 0.
>> 		 * - We can not demote gigantic pages if runtime freeing
>> 		 *   is not supported, so skip this.
>> 		 * - If CMA allocation is possible, we can not demote
>> 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
>> 		 */
>> 		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> 			continue;
>> 		if (hugetlb_cma_size && h->order <= HUGETLB_PAGE_ORDER)
>> 			continue;
>> 		for_each_hstate(h2) {
>> 			if (h2 == h)
>> 				continue;
>> 			if (h2->order < h->order &&
>> 			    h2->order > h->demote_order)
>> 				h->demote_order = h2->order;
>> 		}
>>
>> Hopefully, that is more clear.
> 
> Defintiely, this looks better to me.
> 
