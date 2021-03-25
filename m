Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7F349B09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCYUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:34:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54076 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCYUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:33:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PKURb3084507;
        Thu, 25 Mar 2021 20:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=q7GUs9E2sbcsXand832pjsaVkYNfwkGimUDSTcW/TbQ=;
 b=ERSfiU+hhHkZUeBvBc0mIED0rGeTWTjDS+yaMRTiCiAC6zsA4SQZKjpcyeR5A/wDxGlm
 uwzBNAgm10XW/rm+1umnLur89AWS5Hd7A+o9ycTQ2lBmX6chf2CKGF0U1MD0moIDSl3/
 rLluXfRmatAasL8iz8IlN0cxBHGqnhJJsgilcRY98koEfUf4dIfyqiPXDkq3dtjvCAyS
 iV18hhHLNORhHFy1snK9fUM5m7F1MV2dc/AQDL10KdPzdLqBKkLykToSUQhNNvtLqAsw
 ildvxiVBWN7T+1JXpIJM+b8aD1MJwdYOraZKyJtadttHOR6xYl43y5UsKmNcA6G9oJWe fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37h13hr3t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 20:33:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PKP9dP154211;
        Thu, 25 Mar 2021 20:33:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 37h13wse86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 20:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApXyAIuWFRT93ulnYo8R7FX+Xt+m6YlmMyLBucWTt195Cct02iBp8x3RF9F8A2F+Mf2X0HQC7HjDk4VJSWcz9LtBdvqNJcV7uWID9iREVfHr4iaC+M5oM4yZpjYe5Unar440bi/VVasdfU7m/K38/zjBH1eQRHcQgrnD6qJjYYJlc/nov8qrWKaW5kIDp9GrHy3P1XcSubHcmJteo8mxazoK1sZuSTbYI4uttu3qTFak3HlS8GaeOLdbk7sh+UXtPbF1zXovfXhboaOznSpRdVOupdxy7TBVygSVi7fqyw5jXwMYUAEGa+SFUoAcpERuPNvhLvjhkvXD3XOHlxxRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7GUs9E2sbcsXand832pjsaVkYNfwkGimUDSTcW/TbQ=;
 b=S16Wn12CTHnmqixHR3blWREcdrGtg8ufv/1jIwjXSOfg6gSmS1pF7rjWLXR8hVOq9/tQs8EwFIJSNH34Lo/18aL4wVJno6hVnBAvu0LNkGp/W7sJS2nYa/LDIFunU1JvBEtSnQqdjZq1ekv7R73gXSD3wQH66qu2BXixh10JZ8XFQxu3GLkTGqgWp0D+2R1StnZxjy+JY+AQnVc26T8WmQaoFebSf9yPqpIkLPf3wS3Rg1irC9q6kY42JTIggEirV143M6VxqA9kn6pFNMUuOYz1n7vy4FnEnuYoyPCLcFmU8GdaOaa2JidUPj4hVO9GicaWmdE8y/tO1coqabJwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7GUs9E2sbcsXand832pjsaVkYNfwkGimUDSTcW/TbQ=;
 b=EVjp2HRAy19XtIW1gzimvTMkfbQ+KOVXE/xoiS1lFvYlWoiqLUmU8VIQ9aRzYxYfNG+4etxMtBPNgJ9Qv5+KY81kHTtVEIf/xYzwi7nq6LidUoK3L4Go9jtXWggurBsZJJ2JohSdzpIXDJAGsvaPFEMiyDFp65goa1jYqfYPzuo=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 20:33:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 20:33:15 +0000
Subject: Re: [PATCH 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-6-mike.kravetz@oracle.com>
 <YFxsB4YLXCobtGGv@dhcp22.suse.cz>
 <d60a13c9-24c0-1d24-85bc-08a0090d282e@oracle.com>
 <YFznBKyLx2JYPkO1@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <04c98faf-32fe-4d39-03c5-f8dabb5677b1@oracle.com>
Date:   Thu, 25 Mar 2021 13:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFznBKyLx2JYPkO1@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0071.namprd21.prod.outlook.com
 (2603:10b6:300:db::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0071.namprd21.prod.outlook.com (2603:10b6:300:db::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.2 via Frontend Transport; Thu, 25 Mar 2021 20:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4edc63-c3be-41e1-961c-08d8efcd3770
X-MS-TrafficTypeDiagnostic: BY5PR10MB4353:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4353E56FE764C7CC5746546FE2629@BY5PR10MB4353.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVIW4aHZmx8yHQXYZmogRPrRKW52t63E/b7zd7Szgijo0TwBrcZ7take/NZCeZ+hSYS22JI/NAH0KyV72HujilRdIBkXYaLurMexOSWF73Ap7X/zylBQzNBHrXyDBw7b3FW6XDpJlnECGT8iO+wXhuSPK1v8azxvVNNfJQfwJtBkkS3BTh1B9waKF/J8N8LH2WO1XKHp+GuuUTrd+SSDkt/tGFy96xW095HWT7MqqKsZaoyqYr0i0wNRpruzQ1o6WiKUzEm0+1mja5PGUt+ibPn7ujfHiV/DXPx39+4yGMBPygrpIr2ATvIu48XKefaeYjtE/IwsPRulZInFZEEySRPaM8pJ4uEWrgt6woTfkz18hJacdEBm5gSmQB3MYgnM+bo5nJNHP4nYbLkAW81+OHLOwlD5zKRxGj3sJhqaiq/VnhaE/uUG4jnxk0u7DVEyacHND/+y00bFvt4vU1EFIdm72GmSvFmNWC49xvkpraaeKe2LHzaEf2FT0C3IS1/+V/6f39GMLgXwqOo0nFAZSC0Y1LQJ0nHjv3c5i3v62kJPmdquyQpfsDQ+wg/qnib+JcwQpTx5LPhyUN8lu8Y7K6BxOalNo1+1IIYl8fAZHWs59rrqTVJGcLovyxi5EhRk+rxvqM1nhI6J/7L8RSMYGCIwqyjkbomQo0+YFAAyZpaEjP/IbytmBhreGd2KMZAfzYYZRFg3YzNDLo3OrB2R6zkX19jVXkBfGsspf8NqRkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(83380400001)(478600001)(6916009)(52116002)(2616005)(36756003)(53546011)(54906003)(31686004)(16576012)(316002)(38100700001)(44832011)(66476007)(15650500001)(6486002)(2906002)(8676002)(16526019)(26005)(5660300002)(66556008)(7416002)(86362001)(31696002)(66946007)(956004)(186003)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rko4NGJ1bEdKc29HRVBITVRuUTVsMDV6NzZXWlVqWWVwUXMyTEs0YmNwYUI4?=
 =?utf-8?B?TTkwcUdEU2JwU1o2dWIwVDRIbEJXT2VzMWdXMzEzSVp0TzB1OHVQZDBHdVZI?=
 =?utf-8?B?UkswYUVrbDV6UXd4cU1NbnNZbDFhellGWVhmQUZkNVo0N0w4SXQwUGFNdUxU?=
 =?utf-8?B?amtjbjZyd0hYUlFxUjNXSUFrUjh6b1F5cTdqeTNEYnZSNm95a1RCMk0rekNk?=
 =?utf-8?B?YlFLMzVnamZxZ1VRVDlmOHpwSlhkb0J5cWdPSkpwSHVlMGUwTnNmbWk2NDdW?=
 =?utf-8?B?MFJUUzBsVDVDd3ZqRVdsdXdVdTZMZWZ0VWl3Qnd3YXRDd2JtUVE0eDZMVFpr?=
 =?utf-8?B?ZzVIbWhBL2tuck53ZEVzNm9PMHY5L0tZNGlrQWRBRlUwRThjT3lqbnIrWk8v?=
 =?utf-8?B?QlhBSS85SUtxNHdlWUZFQ0dwelZESk1GTFI5UDNhQndEdEZlbzNzQzBta2ZO?=
 =?utf-8?B?RnZOUFpKbEhRNnM3em5qbTBlbHVJQ2RIQ0lZSEhxb3ptaGZ6bGxLMXdKNDd4?=
 =?utf-8?B?NGxIbGl1aDd5dDUyVDJEanZ6bithZUdxR3Nya3U0aFplTHAzMVNCSmtnV0d4?=
 =?utf-8?B?aE40NWd6ZEROUEFhbm1iUUIxejZIb3pIR1F5QUl4elp6TkxWeEJPSjFkSmIx?=
 =?utf-8?B?eGtNU0Q4eGZLTTl5UG1MMHcrN3hSWXk1VW1wNy9NTm1hbmRCeENIL0t0V2Fz?=
 =?utf-8?B?V1NpREhFVkY4TkQyYlZwUzl0Unl1UllpMFFhSU9hZXdxdDZMSENaOUpsYzNP?=
 =?utf-8?B?dmZrQURsdjBDYXVjNElGMm5FUVVYK08zNjB1Z0oxUU4vdVA1SVd2VktpTTl0?=
 =?utf-8?B?WHM4MTkzZGNPbkRGUEhpOHcrdU5welFkYnJxRkhvUndweDVac1ZUZDZ1VFYy?=
 =?utf-8?B?eFYwdm04WVUwZXJwQXA4QlJGb3ZQOEZBUjNsSG9BTTB6UFI0ZDlBeElXNWxm?=
 =?utf-8?B?b0xaa0VWWXZFMWp5R3Vsa2Yrd0VJMlo4aHZXTlNWallPV2lFdDJQanV3VTJh?=
 =?utf-8?B?TnJTN2FhUmlDRURjWjJ4LzBlMThwWHJRd1hKbEhvUnNBZVZmeU5lbHZjU1lR?=
 =?utf-8?B?ZlQxcVJjUU5TL1VEeVFOQUlZY2psMUYyWWtSeEFXeGgzeVR2YkYyN2pmZ0l1?=
 =?utf-8?B?QUszMUp0MS9jM2hrRUdwdTFFV05rbE5WNitPMWliWWYraTV0cStjVVUycDNi?=
 =?utf-8?B?aTF2d0MwM1lCSXZsbVYxMFZzbkpkTWxoZW9yemxwSE5FZUQzTDM0VnVPbzZI?=
 =?utf-8?B?WUp5T2V2ekFBZVRGOGR1YlBsS0toVVJkbkZ2ckJqOTRKblQwd1JvZUw1ajRD?=
 =?utf-8?B?TFlzamdJT3Rpc1h3S2gzK09vLzE4ZU9OR004ZSswMzlYL3p3Qko1S3AwN2lh?=
 =?utf-8?B?ZlVCSkk1NGJnVWxEYTdRbXdxL1dZVHN0L2NCNVdZSUpTSXo3WDFIRDErNVdS?=
 =?utf-8?B?d3gydCtGUWRxb1p2Wlo2NHpGVWk4UlNTSXk5QVdQMjFkL1hkTmdKY1M0TVZo?=
 =?utf-8?B?eUg3SGNvZG5vQVc3cWNudy9EYXJDc3U1cXFDV3F2R1V4SmhBWVdSbFV3OEwv?=
 =?utf-8?B?Q2F1OGttZ2ExWHVzMWNwVWQzT1pBRTlQaVA3aVZsRm5mSDROQ0FTMnhHVnlF?=
 =?utf-8?B?OVBwTk15VHd2Vm5uZWthZjhQeGVlVXRQbUtpNE91L0EzZmxhaGNHd1ZwR05i?=
 =?utf-8?B?K2tVK1NJR3RHTFF5MSszSWNFa2RrT2tYTno1WHcwUm54dVVoRGZWdUlNeC9t?=
 =?utf-8?Q?2Nt8WX4cPctPd0n9nFrtk+ebPKZah4X48ejslaF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4edc63-c3be-41e1-961c-08d8efcd3770
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 20:33:15.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV5cPXe5ABh5XjjFKBIEPhdYcivdheRBqnN4KyH1xIdrsmejU4A7Awanu7rOFWbgU1f9kn0xLoBdhpUDR8PU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250150
X-Proofpoint-GUID: Hbz9whOmEMaJ67aRzFFUFxkJFImoYgV9
X-Proofpoint-ORIG-GUID: Hbz9whOmEMaJ67aRzFFUFxkJFImoYgV9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 12:39 PM, Michal Hocko wrote:
> On Thu 25-03-21 10:12:05, Mike Kravetz wrote:
>> On 3/25/21 3:55 AM, Michal Hocko wrote:
>>> On Wed 24-03-21 17:28:32, Mike Kravetz wrote:
>>>> With the introduction of remove_hugetlb_page(), there is no need for
>>>> update_and_free_page to hold the hugetlb lock.  Change all callers to
>>>> drop the lock before calling.
>>>>
>>>> With additional code modifications, this will allow loops which decrease
>>>> the huge page pool to drop the hugetlb_lock with each page to reduce
>>>> long hold times.
>>>>
>>>> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
>>>> a subsequent patch which restructures free_pool_huge_page.
>>>>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> One minor thing below
>>>
>>> [...]
>>>> @@ -2563,22 +2572,37 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>>>>  						nodemask_t *nodes_allowed)
>>>>  {
>>>>  	int i;
>>>> +	struct list_head page_list;
>>>> +	struct page *page, *next;
>>>>  
>>>>  	if (hstate_is_gigantic(h))
>>>>  		return;
>>>>  
>>>> +	/*
>>>> +	 * Collect pages to be freed on a list, and free after dropping lock
>>>> +	 */
>>>> +	INIT_LIST_HEAD(&page_list);
>>>>  	for_each_node_mask(i, *nodes_allowed) {
>>>> -		struct page *page, *next;
>>>>  		struct list_head *freel = &h->hugepage_freelists[i];
>>>>  		list_for_each_entry_safe(page, next, freel, lru) {
>>>>  			if (count >= h->nr_huge_pages)
>>>> -				return;
>>>> +				goto out;
>>>>  			if (PageHighMem(page))
>>>>  				continue;
>>>>  			remove_hugetlb_page(h, page, false);
>>>> -			update_and_free_page(h, page);
>>>> +			INIT_LIST_HEAD(&page->lru);
>>>
>>> What is the point of rhis INIT_LIST_HEAD? Page has been removed from the
>>> list by remove_hugetlb_page so it can be added to a new one without any
>>> reinitialization.
>>
>> remove_hugetlb_page just does a list_del.  list_del will poison the
>> pointers in page->lru.  The following list_add will then complain about
>> list corruption.
> 
> Are you sure? list_del followed by list_add is a normal API usage
> pattern AFAIK. INIT_LIST_HEAD is to do the first initialization before
> first use.

Sorry for the noise.  The INIT_LIST_HEAD is indeed unnecessary.

I must have got confused while looking at a corrupt list splat in
earlier code development.
-- 
Mike Kravetz
