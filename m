Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3C361280
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhDOSvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:51:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhDOSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:50:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIXxFH194362;
        Thu, 15 Apr 2021 18:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BSvULNkdql+fFv8rD9J+5JCGqK3t5+MMP6oh3ed0k4E=;
 b=EOi1ZZ8DMseQEV/3zKCOa9zEuXCxx4ySAlvAN0rHST/VFajhUq8NX6VehqQa4fjCqDcW
 re+mp1GXAbrALiFUQ+4r3pAuBE0kPCkEAyEKPSzacS60sqNvMBIDgJeYXaGd2X+JvTSA
 jKPjB/GMdKulIIr5o3FXVJ0th3wu1zIhX0FKkLfdauOXM7qOFm3H1jReyAnezK/7JT0x
 afwGthwzR0IzD/r7QlSw/yZafzojRlC/n23OM/LSCdrcyBvJKbXtDvGUmTvFq23xRN9a
 rgmfs9xLdFRx9Wku+Ch6omqeuEsBQum996DW/hfSGQDP5mg7O8tN30hY3KRO4BDvvP3t BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erpxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:50:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FIZqHK161373;
        Thu, 15 Apr 2021 18:50:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 37unx3bwuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 18:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiLXvZquBwgBZXbROn87ztHsml9bxM8BNydGligcl3szkxIH9Nafd4FF0/VBTEQUDhgz46EG/ziF0Rms0+6YQpsatfEFn00UrZ1szknVETtDPnJ6FGzJq/r8bvvsu+CR/8FnMTZQjbf0aZixnCS7dM1DbHK3b4cI3K4ZODEnCszkM7B7slcn/obVHjYjjAdW5DROUqYckjMAjx24VTGfZURMH5RMz1tSDkgrnExpw9jXHlM/fkF7pzUnY6wlmd944iiRsuJ9C37EU+fuCfp9Qk0rTVxsMTMQv8atzfq7vu4444byKKap65N+bhb88n5oOBDwPJaIg2LvACChd+EBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSvULNkdql+fFv8rD9J+5JCGqK3t5+MMP6oh3ed0k4E=;
 b=ZFa+DPrMPZT9uoRZ543jx0PkMj+dNnFTh3XuVmuJBUnncWcTZ8jQtflnza3RDqk975sYW6wQ18uoM2VciqSN5ttR+UaNWuYy1uN1xXPUVksJ2Ml6TGu2s7AS5Si6UdM/p9SejsijBfdf03xf0ayMSYnmWTbsRDY2N0D6LEdC8lYwXastW2rwZbbLaqzY7OAKOlE4SFG6IqMoCxmP6Y1U9mF4UAdnxo4yIFzf3H8wl/pyfZDphBd9Hy+MMeoJwHSklGYQpwgw+NUXY1sIxPf1x17s7DwhhUPTOkAJfKZuKhKfP4GxKV6UUKaCz4k0fhwxmmOMskmn6FGYKDPrg4iCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSvULNkdql+fFv8rD9J+5JCGqK3t5+MMP6oh3ed0k4E=;
 b=TSaK5MJMQKcEgxbd8a7Xz0lQ07ZDLvAaKm8xNNo/FgFYR6XYCwYSIAmhX5sf+MiJ4APOY9Je8K61/NCmUTTToM7TOT6FsEWwo+0G6ohKF4u66a0dkUSJ2clzo23xiIAIjceI+5T0jOGIwT2IAJE2NG9nfTpj3+xZUq3Aqw750FE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2856.namprd10.prod.outlook.com (2603:10b6:a03:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 18:50:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 18:50:21 +0000
Subject: Re: [PATCH v8 3/7] mm,hugetlb: Drop clearing of flag from
 prep_new_huge_page
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-4-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ce5e5733-6b8b-63ba-3e43-b5cfb5a10899@oracle.com>
Date:   Thu, 15 Apr 2021 11:50:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415103544.6791-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7 via Frontend Transport; Thu, 15 Apr 2021 18:50:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b2f74cd-a89c-412d-c532-08d9003f525f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2856677BBCB3AB5C035BC601E24D9@BYAPR10MB2856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QxVsRFEe1e4UbMtaN5ZbvpnUm4jmOMTrJ6MClPi9Dbyfq3QwgF+46HwBUKwltJNL5MUaG7WKXtJ4QtOPTJs3yds+aDtNuXAfoqH46KHvyOW1B8cfbmjpLau1kgiJpmhBGtyoa4zrjwdDOiBHVK6m/BuQP9U3ZAUwOJdF3lL7FrflnHS6Ao5b2fcrqO0XU8ne8/Lhve8kaED8jDUQ6Kqg4vnTNXVHeu1VukpnS0sj6aGxf2ZI2Nz5KI2s7quj6ziGjFGZ+HGO4r8ZH1AJXc5sK5i//bP27LzTiH7DNc/27lXs/7W/z75PROOOr3igsCqTQ102o5leri9zuFgZM1DaUzQedJfhq52YgqDQN+ruuj8PRMQ7UGYMhkQKdo6ZNz2GohJ9OM/OdEuJwR4nDvjuBWcVC6jfug5dyhNhmD2AVJ6FKA9ARMbEhXIZc2Pw9UsNfsJGZHQV633xAb7l4MV6TGKsnQBy7bS0h6H6xV5dayn1bLXn4J8qDPYOYXc9vv9QLTu4WavNZyafYTBwfItutx7E8MCOi7E2cifSk3iQS7ZexWK8bxg1MVH/MwUpJYF9CEqzwbgPNt4pINFUz5dWOtL9n4HHJ4cs/gm5LIEyi+y0bo1B/bGOlOdNfqt50t65T7BnIL5dQl2oKmBQNKkxKGWtamul5cI1dUTojA/Om61aPTPnn6L9v+fa/MOH6BS30x+fS7rFU3vGWNBo4Ea1GwIEEpKdw6oUe+ZIAegOFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(2906002)(316002)(83380400001)(5660300002)(956004)(2616005)(54906003)(16576012)(44832011)(110136005)(6486002)(8676002)(66476007)(66556008)(86362001)(31696002)(66946007)(52116002)(4326008)(53546011)(8936002)(478600001)(4744005)(26005)(31686004)(38100700002)(186003)(38350700002)(16526019)(36756003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXBoaFRWdFFQZmJ3Skh3VVlucVVta0pmRXlLLzd4djQ3WCtjUXBmcXVqVk5Z?=
 =?utf-8?B?b09mNjFNRHl1dG9kZmlGeW1tVXlsZ1gzZVE2aEl3MVVkY2MrWDA1NUFlajd0?=
 =?utf-8?B?Z2htUkRQbU80STRrdno1SnJvaE1NbUY2NmllUzA4ZTAxdlJnOGtHazNXUDJl?=
 =?utf-8?B?ZFhLMHVaQlI1YXV6dWcrMzBuTE1JY0RuOWhuVVpCQ1MrUnlZMVBCNHVxM3gr?=
 =?utf-8?B?SHNOa21CM05EZTVOd2JSbjc3Ti9KWTRwUHE3bzVSa3ZMZGN1RnAzRVZpajV2?=
 =?utf-8?B?eWZVRm9BZU0ydjRhTm93clFTOGRrdUpwS056VnNtVzRZZ1FVNDB0V1dZNTBP?=
 =?utf-8?B?NUptelgvSXdqZzN6djh1TXkwdUpYK29BK1JZL3d2S3BUdTZyQ253MWJWRHd4?=
 =?utf-8?B?UjJoN2FqRm4wMUtGZCsxRXprcXFqUWJIcFJ1Q3ZTQ0RLN1I4MXkxamRSYVJt?=
 =?utf-8?B?enZnUEdrMjc3SHY3eHRYajgxaFBVbVFFcEpocWhIZStSNlBDMW84UjJXbE9W?=
 =?utf-8?B?ZERSbkN3amxLelY4REE2bVAxZ0JKUG44NHhsTGxwWlBhK1BBUFc0ZTVZVEdR?=
 =?utf-8?B?cVdVdVNUWHF6NnhuNW5iY1EvZEUxTDk3eVFMN09DaUdvUUhvQWk3b1RMeWJj?=
 =?utf-8?B?Q1lBVHRKb1E2L0F2d1VNNnZoOHYvSjc2R0h1ZnY2SWpjMWdWd2lqdmVLYXlO?=
 =?utf-8?B?ZjYwZE52UVoxRmdGTWJsYlRnb1FPRUlQWlBaNkFzdzIydWtiR2FsV3lNZEZl?=
 =?utf-8?B?Yk5lYUd4TWRKRnRLZVpsQmxybHM0dnBPR0U1QkgzT0ZyWE5hMllRNm9FZ01C?=
 =?utf-8?B?OHFJTE1YdHBjeUlscWZka1BETHlEa1RHMnVsNFhZWCtnSlBNS3k3ektWYnV3?=
 =?utf-8?B?TThXeG1XUE92UE43ZzZ1UDNrTHFaemRsR1JlRDJOZDlZTER5OGlhUGZtbDBn?=
 =?utf-8?B?bGVUMHVXR09kWjJlNEdNRys2eDVqV01LaG1TYTJjYm43bHRhUHp1RlprY2Jy?=
 =?utf-8?B?S2dqOHdmTUNnREdsdHFVZVBKM1Z5YWM4K3NBZnhQTEUxRTFkeWZjaHRvY2lW?=
 =?utf-8?B?YVlsblVMOXVxc3h6VE9VNWVQc3FlVGtJa3lWQ0ZGbE9CZ01NeUZLQ3RsTXNS?=
 =?utf-8?B?YVV6em85dUhUYUdIVG1yWmxYY0xCRXlhTVcxYVJSak00c2t1WkIrSnNZY3hh?=
 =?utf-8?B?dFJNNkdjbzlibzBrVnI0RmFiL2czaHlwS2VXVitpdC9xdnBFUEhudEI0M29P?=
 =?utf-8?B?U3hjVHlvSXBKRGpRM2lTZmtNYkhzWG1maFJjN1VMdTV3OVVLSDM0UnkzWTgw?=
 =?utf-8?B?K0dRTmttdWlha28rQTNEaEZlUGNYVDZxcUdkeG0yUnIvaU55ZDhjZEdoaU8v?=
 =?utf-8?B?UFRTNHVUL0dzZWJhREFaa0JKVytsL21BeW9obVpTVFQrbnJ5ellmTUE0bmZT?=
 =?utf-8?B?eEtLNHhuYytGZytRcXFmd3U5NXIwaGxmVitIbmV0b29XU0pCMzNQNXdpUytr?=
 =?utf-8?B?dG8vSmxRRkM0RnQxMEpNUWdOS3M1NU0wZ29Ib2NxUGNFdVZSM3hsWWpvMkpQ?=
 =?utf-8?B?Nk8wcXh5L001cTJtTkJRM2J1TU9BOUg1cmZnSWlRbXJDN2VvN09sMW5iNTZn?=
 =?utf-8?B?MG9Kenk4blMvTUJSZklpNURaajBieHZ0NTM4cEVFYjdsWUt6UjJQYkhkcFR0?=
 =?utf-8?B?RUxvckxaSHNNQ3d3UnNMak02N0FvZDJKMGdVaFRERlFwRjB4QmUzUDNGOUMr?=
 =?utf-8?Q?RVNRZ+bCEF4Q04nyKbBNnqLpuxHpHarFjq6j3ib?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2f74cd-a89c-412d-c532-08d9003f525f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 18:50:21.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh0hZUH9rIhoHjFNgIuM8GchLeRBcuFyiPsRv88DCH1YqINZlDfAxX/i2WZVyS6xGHBLDsfS3XMsIpzv2mtzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2856
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150115
X-Proofpoint-ORIG-GUID: sv3qBW4SMnowQjoQiQ1TxUls-ylQIRwy
X-Proofpoint-GUID: sv3qBW4SMnowQjoQiQ1TxUls-ylQIRwy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 3:35 AM, Oscar Salvador wrote:
> Pages allocated after boot get its private field cleared by means
> of post_alloc_hook().
> Pages allocated during boot, that is directly from the memblock allocator,
> get cleared by paging_init()->..->memmap_init_zone->..->__init_single_page()
> before any memblock allocation.
> 
> Based on this ground, let us remove the clearing of the flag from
> prep_new_huge_page() as it is not needed.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

The comment "allocated after boot" made sense to me, but I can see where
Michal's suggestion was coming from (list the allocators that do the
clearing).

Also, listing this as a left over would be a good idea.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
