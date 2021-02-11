Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148053182FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBKBR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 20:17:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33308 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBKBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:17:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B10SN7020066;
        Thu, 11 Feb 2021 01:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MRGosLz54IwnzJBQSCt4OMjmUXrcaGRpRCg7lL3tSsw=;
 b=UQUEfb9Vzahq2VIT7377lWRtzDUB4WBPbi7h+7W5sQ+3XnRu6LxyrgcrrY8ZAf0VEu3v
 1low12wY2r64pkyOBq2uZ7sPRc4P6tBAQW4+uuYWZ33KZEPgWbyRlBegg8v+tm2SmSBS
 /kFYbFIABAGWNJvvUV5paWXbIGuXr5eWSVb/HO+MLbdjcWpBltdXjtqaZhO8IhX0bnrs
 8gI4Fo/gs8hLTJlZI/06zhbkiU31W/ym1uQ1VqcVDfAAFo/YYrYukRMpHIBNuPSSl9kr
 YArX8pGiUDQ4cy5ggGNzX4/6Lc/87iJG2GekIh3LRkJLkP182+p7eOzl2tq9U7FrI9qR EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn5kc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 01:16:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B100EF141949;
        Thu, 11 Feb 2021 01:16:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 36j4pqvfcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 01:16:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrSgqcrI6ZQ5fE8+zuIkLIqq05LewrcP4P1RZDRFnSLXMaAadk978+HVzd4B0vOfn4y9L3HaEeSZytbPAShkgENuJMz2gTAyh2qYCmP1YJrxzXpujd6Ac9xfq2avM5nt/6LHUiJ1MzqAndFPGj+l7uefBh5m29uNlGvxQ/Ci9Sw+AOpiZIWMA1cR1axR6yAON/nXWZjt3IPAp6PJuAjj9jTeeAEJ6csORZKbf0v4wY0+xkZWTe0+J3fRtJUSTRJmQNOGSEBOoCyhntl5/iTmknvR6N3YWKWuaCB2k/2DWdSLTQYBxRG+d+jk++9gqSoLZWhTMqfMsMjTT5DBfZgzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRGosLz54IwnzJBQSCt4OMjmUXrcaGRpRCg7lL3tSsw=;
 b=RMYhNujjwKhYunKqe8Kl3FqPgaEjrJ37f0LlnmVqWYnzzaN6Nmu5vWS+tyi8B14LLQGyT+D1l2jF7Y+ZQccOO4StFGbSd/CxMyPe/LhtsjsAsXoCa8EO+mUwvOTmIgiu/IhBOK7c0YcQpmaKRS6ECpBAEq3IP7jXswm4haa0hoFqDqHa4SWaN/giW/kxQtkoBH5t4ifcr8VZStv5oVZ9DxWh5JxXGcX9CJFE2Jw5y0h6LeVqArvcTLOV3oMcoqp3bDMdnPKb2/Bw63vo4WWp75a0NwIx8JHuBZfuuAfPPZmHdu3bMvfiCxzFo1M00lEYxPMoKUxN2t2vPhH2MW8k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRGosLz54IwnzJBQSCt4OMjmUXrcaGRpRCg7lL3tSsw=;
 b=l9mqsD5EbXJRj5E7SD/JAN4nO92HRKm7T0VvszFvYPoPJhIek01/5tSpwvvE5P5iL0F5BrWvsllCgne89nPJYsZp/e1VRagoc9y4tcyVylqdtmEhq+XEruDaU5z/AM3D2lWqszyop1xscQkrhERRQkr5BVXFViOXx7q9CM1MXKY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (10.169.232.150) by
 MWHPR1001MB2063.namprd10.prod.outlook.com (10.174.170.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.30; Thu, 11 Feb 2021 01:16:31 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 01:16:31 +0000
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5a6c0efb-4667-c382-8c3e-fd95b6ae839e@oracle.com>
Date:   Wed, 10 Feb 2021 17:16:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208103812.32056-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 01:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe476d6c-1e48-4533-1239-08d8ce2aa9e8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2063:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20631015C9C60B5425EEAEDFE28C9@MWHPR1001MB2063.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mjy0pun8ZmKhiFSsTYOEW139r7HD0IC5MgQy/NIEEJqebjZTeFmSfDbG1U138i/cGGb87wRDwPM++Bq5f7D8AhUD8/a0Ws9yS7CQxg8P5pGqFVpv20c7mw/Uy7KYGF16N4Yg75CG1FR6TuITcqcnf+72Alzgnwp9sL/a0bxATSmJYMLXvbuytZliVlylHo5DzA5XdIEWRv5G21mUaNvLoaFJVEiSN9YAy+j9LaK71h9ToncGRriBB74e2HijL8TNBfWrrFurQnJHpzwMLhSFDuUgMM/rjcM82DzH3QCgXHSY9jUaA8mvWJus1BepHlL4Nini3l447d6NLqniuKDJWXTpnVVPzNu4KNXmRfApvO8I/j8NdAUvHFgdeUTUDsDBXB2nnfBjEC/zAZNy00foJWOey56afFHoP5IZHeezQa4jLyCQmzEkzC2fOdb9m9HV6GCJrp3vtSOzwTcla0eCoLD026PizLS/CvANu0rYykKI/M7M0tdTippzdYGvr2hfJrohj+qHGqZwIoy656Vebbi0oqC+FVoK0QFIKyM96Apx/BfuwbjOgXQFoKGXG3zfbl0xRVaJDagoNXE9W38H3QaXuLcepEVvEy+EKUcNqJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(4326008)(8676002)(2906002)(16526019)(31686004)(44832011)(53546011)(66476007)(54906003)(66556008)(83380400001)(2616005)(956004)(5660300002)(26005)(86362001)(478600001)(52116002)(8936002)(6486002)(66946007)(6916009)(16576012)(316002)(186003)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RjNIQllPUENrdHk2MDYzcGFNdkJHd2ZIUExYc2FNQlg5OFp2OXBRSU9YaWth?=
 =?utf-8?B?T1V2d2ZCZHNQRS9uWkNJdFJ3TG4zUENqL1NyMWxZWVQ4K01zbTJ3cjFJWXkx?=
 =?utf-8?B?Q1JlZU5pWWJuK2twMVFIZWZ1dzMzQjZBTm1WcW8rbTJINElGcXg0TElpZXVH?=
 =?utf-8?B?cEVNWFpMbFAyMG1hRUNSRkh3R3Bkb2d0d1o4R2tZeTZoSW5RWkVXMUJqN0ZN?=
 =?utf-8?B?M2hqZnRhSGR1dVJLMFYxVFJ1L1p6ODVBbDdmek5KenhCOVQ4YjkwU014ZmJJ?=
 =?utf-8?B?b2tWYUY0L2JZR29NQWJadkdIMncvcyt3akZ4ODR6bWt3enREZWRYdEE5VDhl?=
 =?utf-8?B?Tm4zOUJEVEtSVEpqZDdJRDc4eGF1S3RCd3k2RGpObnJJZmF0WHl5RWlMVkJM?=
 =?utf-8?B?R0pGUWN2M2drYkw4THUwYUFFNDhLem1JOFZmNjFVWFJ5TnBKM0NhaERNNVpM?=
 =?utf-8?B?SUhJOWZzZjlFRDJqZTNHblcyRkhJajBiSDBhMGU3SXpYcVlVLzlXcjJaY05y?=
 =?utf-8?B?OW9LQyt0bVFTS3Y3bVBXTTBRK09uRnBva1crckcrNkxIYm5yaEJVM0RRdWlt?=
 =?utf-8?B?ZTloOHpCQUtmVHJvaW5aQ0N0dFlkL2EyS0NEdTlBcndjb1VBWXZ0L3EyOHpa?=
 =?utf-8?B?eENoT1VXL3JMUDR5UGhRSFZKMzR5T0VvTy92WVJyTFFsUXRKak1zSFZ2azVw?=
 =?utf-8?B?OXlDWThlRjkvZGF5Qi91UTNyRXQyMVBYdFFtREFUN3hVYWMwMTY5ZUJGcDJM?=
 =?utf-8?B?QWUyOFVaQy9rY3lrNkF6dHRkUnNSUzdNUEYzY2FnaEhvY1JURXFoWXdDTUpD?=
 =?utf-8?B?M3VyTXh6OXRYeS9MUGJhS01BaW9qU3NRODNBVUphRVhtaElNY3d1NjkrQ0Jx?=
 =?utf-8?B?TGN5K2hKNVNUS0RMeXN1Q2c5eUs4TGxyNlcvQlNObG9OZ05URklETk5DSFFh?=
 =?utf-8?B?WE9GbVdmVjRpeUxUdHZxVG1iSTJRTmtZdDNaMXlDUWdQdnZCMUlWNmZDeTd6?=
 =?utf-8?B?K0RCbTZTNWR3OXhZQ1h3SlVBQmYvU0VQclJ0VTQ0cDdJaCtITVZHM2tudkxm?=
 =?utf-8?B?ZEk5RFhmc09ZSVZoTjBDdnJ2dkh6OEIwQVlsRmVVUG14MVREck0yT1VFWnZs?=
 =?utf-8?B?ZzZ3SUowbjNDaG1TTFlvTmg1eW5IT1VGY3FIQlE2MlJ5aGJHRzJVQkNNMkN2?=
 =?utf-8?B?RzFKaHFEOGNYMFJRRkJSSWVYVmEzTVlxK1ZEMG8vbWpTaW5QQXhualpuZkR5?=
 =?utf-8?B?Z280S0QwQjdZeHdnMGF2T29FWndCV2luMUFBTW9MMUxXQjg2dkpsL21XZWtB?=
 =?utf-8?B?VDdFcFdReGNwZSsybFVlanhFelY5T1dEWHJBRUJnN2VXRWtPbGpzVkxxZ2xB?=
 =?utf-8?B?UHE1RmUydG9lK0ZJQWc5Z29sOWpNZ0NQTXBCYk1ITUluYXFmOU05YnMvL2Fu?=
 =?utf-8?B?MjBDUHphSko3RS9SMlBqMmljdEVuK2RZWGMzZGtOVGRVbVVwcjNOaDhRd3ZQ?=
 =?utf-8?B?bUdmRUgvNTVMdGN3Y29DbWN2dUdOUThXUEN6WXhKYWVFdm5tbXBacUtvWmlC?=
 =?utf-8?B?MHdnbytaZEMrdno1VTJRMTNJUmJ2b2tHc2JIeDNqdC9oNXRreENtOGo4WDll?=
 =?utf-8?B?a2pzS3pjd1VTR3ZjSU1qSnd5aTI4OTNDWWg0bFg0L0o5R2N5dVlDMmpnU2FY?=
 =?utf-8?B?S3pmaHgyWW12UHU5UXBUY3MzZFVHV1Zwd1NDZTJlYlZ6WVMvVWYwWnBIQVRm?=
 =?utf-8?Q?LUQeTcaylvLOoR4DK3aEWjf4GoTLl1SmFVT7Y08?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe476d6c-1e48-4533-1239-08d8ce2aa9e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 01:16:31.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnZRq638qKjTsmDhVuUB7WsmBndE4S+FTp24j0xYkOGhfI+LgwGH9H3ENimW/a4P567NcOrWAO7/8xcl0fhMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2063
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110004
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 2:38 AM, Oscar Salvador wrote:
> Free hugetlb pages are trickier to handle as to in order to guarantee
> no userspace appplication disruption, we need to replace the
> current free hugepage with a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> in introduced.
> This function will first try to get a new fresh hugetlb page, and if it
> succeeds, it will dissolve the old one.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/compaction.c         | 11 +++++++++++
>  mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..f81afcb86e89 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -505,6 +505,7 @@ struct huge_bootmem_page {
>  	struct hstate *hstate;
>  };
>  
> +bool alloc_and_dissolve_huge_page(struct page *page);
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				unsigned long addr, int avoid_reserve);
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> @@ -773,6 +774,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> +static inline bool alloc_and_dissolve_huge_page(struct page *page)
> +{
> +	return false;
> +}
> +
>  static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>  					   unsigned long addr,
>  					   int avoid_reserve)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 89cd2e60da29..7969ddc10856 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -952,6 +952,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  					low_pfn += compound_nr(page) - 1;
>  					goto isolate_success_no_list;
>  				}
> +			} else {
> +				/*
> +				 * Free hugetlb page. Allocate a new one and
> +				 * dissolve this is if succeed.
> +				 */
> +				if (alloc_and_dissolve_huge_page(page)) {
> +					unsigned long order = buddy_order_unsafe(page);
> +
> +					low_pfn += (1UL << order) - 1;
> +					continue;
> +				}
>  			}
>  			goto isolate_fail;
>  		}
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee317900..79ffbb64c4ee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2253,6 +2253,41 @@ static void restore_reserve_on_error(struct hstate *h,
>  	}
>  }
>  
> +bool alloc_and_dissolve_huge_page(struct page *page)
> +{
> +	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL);
> +	struct page *head;
> +	struct hstate *h;
> +	bool ret = false;
> +	int nid;
> +
> +	if (!nodes_allowed)
> +		return ret;
> +
> +	spin_lock(&hugetlb_lock);
> +	head = compound_head(page);
> +	h = page_hstate(head);
> +	nid = page_to_nid(head);
> +	spin_unlock(&hugetlb_lock);
> +
> +	init_nodemask_of_node(nodes_allowed, nid);
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one,
> +	 * so the pool remains stable.
> +	 */
> +	if (alloc_pool_huge_page(h, nodes_allowed, NULL)) {
> +		/*
> +		 * Ok, we have a free hugetlb-page to replace this
> +		 * one. Dissolve the old page.
> +		 */
> +		if (!dissolve_free_huge_page(page))
> +			ret = true;

Should probably check for -EBUSY as this means someone started using
the page while we were allocating a new one.  It would complicate the
code to try and do the 'right thing'.  Right thing might be getting
dissolving the new pool page and then trying to isolate this in use
page.  Of course things could change again while you are doing that. :(

Might be good enough as is.  As noted previously, this code is racy.
-- 
Mike Kravetz

> +	}
> +
> +	return ret;
> +}
> +
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				    unsigned long addr, int avoid_reserve)
>  {
> 
