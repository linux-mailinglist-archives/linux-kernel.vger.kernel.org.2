Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89701344C98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCVRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:02:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhCVRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:01:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MGwdTr080346;
        Mon, 22 Mar 2021 17:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cBMgFePnKpOYWFaGIx5y4TFM7Kt9niLANcRPIQ0x22Y=;
 b=lJEdBMIxx44Uhe5qNbTq4qm9HuZiHttM0YjwgmtwoITi/N7MVPUNNHc0WWRF9306vJFl
 eEAyE1Pu7X6HW4Js9yr/QVzzPkmKpWpWUARMMvWKjXIixos+fziOuozvR2mz1GnfxtJ1
 3PforklK3ghFHe/41dGLWg70vNGd9Brtx1Ltza5xbpE4PWHit6/bsecZy3YPBCp87DFV
 fvfm0ctT4nhmrWW3boLEA5zZomM5wdmgWhd25cFG3FBOBBgu6YPgGxWMVMWqckVkwQCM
 9z44x2VKASuwTTUlVDISI3FSBjG+beiPWUNqfFJPVS0lxqnT2pl+AXe3HAFeq4rgB+we Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8fr46kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:01:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MH16hk150163;
        Mon, 22 Mar 2021 17:01:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 37dtmnf0nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKVYdARjCYLj1TdJpjyA4+eKb+aXsNMHtBy8ORc9xcY1qqagOqfHlvCVgK0AcbpxOCYDXomP3SeBDTJ22Rg3ISvxxy81VMFZg1LBSLHBmJMxHae0NTf/Ngv/fy8B1GFD0jsuiEQFexj6qmhu4iC/NcWdH/161Nu/WaLsrGld98agqKiossTtm2CPHhBe0vjwObvvNd4K9gysDCpWloome+NTVxv1cGOR+w0r2+ADIWAFbkgXNJ6Z4Za6ImgVXZAHuJ0XPnfJFkXUNZBw3ZBkkfp7rdI5JjBeaL08COMwVPrfch8b4Dw0FLSNjRIENchfOxoZym2eXkBrAlVQKGN4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBMgFePnKpOYWFaGIx5y4TFM7Kt9niLANcRPIQ0x22Y=;
 b=P0d2C8WwOD9N4QswqLZcK9YjzOG0ElcJOKRUSO12YU2mR+7NgzH3feaIOfOfLwg0hCUDpjx8oRIeWHUQw8kfN8/4BHXDUzEsjAqVpGvvF1yEt+oTjybRgkYKnc1rOZu7CJgWbsvRaHCKodt5mGJN/KUKYZVwtpq5LpGd6PJbp7Zs8tBqBt3ztaLqtzXpcVE/zIy0Zs1Oc3kNyRVlcGbXgvwd1XjYk1bg7yEs+b75JLdORZAw/9SI7voMr40AM2o7AyxnlYeK2oGtEpKsaTvV3UagPnqbed0jRhovmYZh8jMwTeoz8Oqq1WSA5aJWotWd4vE2+xWblFXDEDFjC/5T+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBMgFePnKpOYWFaGIx5y4TFM7Kt9niLANcRPIQ0x22Y=;
 b=WfM2o7/j/1S94RpSKXUO69WWqLJSrdOOuxVoqcDV1AESoGEHs3DpFhUByPU6oGgGR0qOhGIOsBlW6StwrIA0KECcw66GU5O2oUHQ6M18wsSMliLpyfXwrX4NnaRKKWIMFD1BOiEWJMqJSZtDPEUZOxd6K3Rhyo8dFE0nqulDzW0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:01:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:01:08 +0000
Subject: Re: [RFC PATCH 3/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-4-mike.kravetz@oracle.com>
 <YFimj4UGBat8Tp/C@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ee1903f-879a-3fca-9abe-7bfafd4118fa@oracle.com>
Date:   Mon, 22 Mar 2021 10:01:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFimj4UGBat8Tp/C@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:300:13d::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0018.namprd20.prod.outlook.com (2603:10b6:300:13d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 17:01:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65d234d5-1b96-47bf-cf4a-08d8ed541656
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4114A7CA27F4972FDE7BA4A7E2659@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giaGZPSSIFVxhhHoNLaHHTe/kLSb1XyH5Tus+gAS+KjHcyk0B2EPE9T3MDXb+Pny9gMC89Ggo3HsGwFWDCu+TlEYgD53l6zS2R4X2vSvDNA9MFSIwss9rp3JuA1Qv1O9RHuSGPtU2mH5/8/53jw1v4a85+9lzEM02MTtSkAQ0mDB1HglcARaiVswi79g0wXO66db9VGLWj+n80t13lytM73LfSFm/0iZYYUCKH3WTtnrgRizu9b2nRTVsRupjO2K4uTb8yzzAg+OT22/Thhf7qFgHOEt2hs1EPp6Zro4aZETOZ+BtvjhwuOGCwSIUE4pNIaVj4r8q8qa45U8s4UFHrDRpOnqV3VRI9bQG7TcFjmu0H1djHOCwpTashYw6utYkSPawIrqQnz0/fcSgA3Ktj8En4iesYS7IWixYnjdxtxTNtl1kZyvEuza4qJfuNV7UkdDQnlm+L+Dd+mRQWOVFKFVAosc07ZRuF8ohCu6myr6TGzQkPzRxgXc5G1/W8TzrBQ/7liKmshvb8XKTKUI8ZgouZgndxmo2zlO5pybhPg5/SVfLxNS1p5VPGN6fYnsfW5XjwkAzofqH6+DwMLDXTCahsRJSUMX40qjF7niArefzxlzloSA1BmXypIkA4L6/xf+KIveKy15CKPoUT0q9Z8oN2n3DF7FUTEOudaMkgGpaQjBVdUlXhn8xSOF+lzqov1rzu3vNNxRfY3p/680nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(44832011)(38100700001)(36756003)(54906003)(66556008)(31686004)(16526019)(66476007)(7416002)(66946007)(26005)(4326008)(6916009)(31696002)(186003)(8936002)(956004)(8676002)(2616005)(478600001)(5660300002)(316002)(83380400001)(2906002)(16576012)(52116002)(86362001)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXFydFlnUm5JZjZMN1phSTRvV1FpV00yOXRIOFdLS1lYN1BhR21aaExYMVVB?=
 =?utf-8?B?ZmM4SnVrcVQ0ZUpFZjBIV1RHR1NlSXZyVkUwZjZYUWdJTCt1OFBHM1ZQSlhs?=
 =?utf-8?B?bENDWHd3Qm80NHNFSjQzRHlmZnhKbkJDR2xWVG4xVnFXRU53b3dlUDU3Q2xF?=
 =?utf-8?B?SFYveFdBV2F2QVRIRHlONjA2UVFwM05HQjhMNE9NSUtzcnlsdDU0d1ZXUC9O?=
 =?utf-8?B?V21YNHNmRm1pVHU0SFFxdlRnVmlRR0w5N1JpY2RTNVFLZi9EUzgyVS9DaVdT?=
 =?utf-8?B?NnNaYUVRNCtFOFY3YlVOdW1mVzE2U1BmZE5LYllUY2NnaFJBamZHMDlzdHJh?=
 =?utf-8?B?NllUeGNnak9KcmFMU09pRmNjMXkzZ2hZWjN3bU5qL1BnOFhxRkJzWXZPWkx1?=
 =?utf-8?B?KytiK0M5QnU4UzZvcmJBdzE0ak1Pc0xYTTM3NUM0bFI4OXBiemNuT2dtZEJN?=
 =?utf-8?B?ZUJ4WXFaTS9JVE9rYUdKTlN5Ykw5OHJIMk5lNE13dWtUeVlUbkxjakZ0L0k4?=
 =?utf-8?B?MUMzWFVuU0FPODZhWG5XeXMrcUN5UnNZOC8reGZLTWd1TEdXL3BVUEgzTHdo?=
 =?utf-8?B?aXNzV1hkNjFMK3BVWW5wenJVM2Q3VTdZTGZLSE9TQWJjZXNleHRzczZmcGg0?=
 =?utf-8?B?S1N2U2wzdGlBWDdWZFRpdXFmblc0cW9YbGdmY1NDL05hby9OTWM3VGRrNjNL?=
 =?utf-8?B?YzdNYzErdTJzUUJJWEpUOFVHWkQvOFVZcEh4ZXZJejM5MWZDcW5OakFFcVQ0?=
 =?utf-8?B?cnFnNDM0MXhsMm1KK3JiWVp0bGtIY3l1RFB1OHNqVmwvdldXYnNDdG1tNFh4?=
 =?utf-8?B?KzJOR0VDaGpuWTRTaEVDZkJGTGdXYVRhM2VrWitWbWlmOTJDamROTHJ2K0J5?=
 =?utf-8?B?bGh1dVRIVGFUR2RWbFlHVGlEWmw2TVhiNktFc29EcUpuazN4YVFZb0dYNlJx?=
 =?utf-8?B?ZHRJRDhJQWxkc2RBcGxFNVNUSmVBMVhyTm5kRUhiM3I5OUxaMHlPYU4zZlcx?=
 =?utf-8?B?VEExZENzZXJpczROOExMaUNlZDY5MHlvby9qTDl1ODRCY0M1VlAxSGRsKzJl?=
 =?utf-8?B?em9TT1E5THovYU9PN2Z5LzZFYUozMFByc3grSkZZUFAxNGRlOXRZK2hrMFlW?=
 =?utf-8?B?WEFWNEt3YzlwdHN1K2J5T21aT2hYMk5SUGYrdmtHOEVxU093L0h5M2FvekVv?=
 =?utf-8?B?cFgzaThyUXZxZldZNFV4ZWwreWc3elVSczRUTzFLbGRMMWtETHlSVWgzd0p6?=
 =?utf-8?B?ZjJoZ1JpQ0NDMTJzaEdoTHM3NnlMVHc4OFZjRG1RdUdkbTJFRHJJOWVoU0tE?=
 =?utf-8?B?TXNMK2djRFoyd28vL1N2N2tLVW5Mcnc5cytJaFdKc3UzZ2hBRTB6TjJPK1NT?=
 =?utf-8?B?VnlTR2QwY2ttSmg5Mk1RZXdYNUhFWitRdWpyTjUyTG5YRDE0aDhkeEQyZE1U?=
 =?utf-8?B?K0dDZi9JdXZVTU1GKzZENG1ZMkd6c0tCM0dNd01EcGhWRUsxVEdoUGd0OWpy?=
 =?utf-8?B?SDNaaUVwcHZUODNjMzQ3alRaRGJvUGFXNVVVcVZIQmFwQS9QM3BHWW82ZWZu?=
 =?utf-8?B?dzlQbHlOS1ZOY0N4ZUhxQm4yWFBQNkxocEtlYkQ1Mk5aQVZFMGlJd3J1bFAy?=
 =?utf-8?B?bW5nbHR5ZUdUSi93M1MzTjYwT09pRnZXS3ZQZSt1QkV0Y2pxNXorTjN5K010?=
 =?utf-8?B?ZlNtQkJBYTdSSlZweGRHK3lCS1h2UGJ1QnZoMDdMbFpadFdsOTNFWkQ5WVgr?=
 =?utf-8?Q?hvPRIKybwYBF/RTCJTBGr6ILFQL5LZ/6UIpEAuo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d234d5-1b96-47bf-cf4a-08d8ed541656
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:01:08.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwHvxA6jid+RyC346ynpdETpYzqX7ZfX3wQ9eqfh4sa89uC4g3rpJw2rVvgg6xqrYD3y6f/bvP5UQLOBtaPkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 7:15 AM, Michal Hocko wrote:
> On Fri 19-03-21 15:42:04, Mike Kravetz wrote:
>> The new remove_hugetlb_page() routine is designed to remove a hugetlb
>> page from hugetlbfs processing.  It will remove the page from the active
>> or free list, update global counters and set the compound page
>> destructor to NULL so that PageHuge() will return false for the 'page'.
>> After this call, the 'page' can be treated as a normal compound page or
>> a collection of base size pages.
>>
>> remove_hugetlb_page is to be called with the hugetlb_lock held.
>>
>> Creating this routine and separating functionality is in preparation for
>> restructuring code to reduce lock hold times.
> 
> I like this! Counters handling both in __free_huge_page and
> update_and_free_page is really confusing.
> 
> 
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 46 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index c537274c2a38..ae185d3315e0 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1306,6 +1306,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>>  						unsigned int order) { }
>>  #endif
>>  
>> +/*
>> + * Remove hugetlb page from lists, and update dtor so that page appears
>> + * as just a compound page.  A reference is held on the page.
>> + * NOTE: hugetlb specific page flags stored in page->private are not
>> + *	 automatically cleared.  These flags may be used in routines
>> + *	 which operate on the resulting compound page.
>> + *
>> + * Must be called with hugetlb lock held.
>> + */
>> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
>> +							bool adjust_surplus)
>> +{
>> +	int nid = page_to_nid(page);
>> +
> 
> I think we want lockdep_assert_held here. Lockdep asserts are not used
> in this code but now that you are touching it then it is probably better
> to start adding them. What do you think?
> 

Yes, with this type of change we add lockdep tests/qualifiers.  They are
lacking in the code, and would be helpful.

I will add them.
-- 
Mike Kravetz
