Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA8935E905
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347379AbhDMW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:29:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33090 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhDMW3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:29:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMOvP5094629;
        Tue, 13 Apr 2021 22:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Bw6MNPgOoncUqQwvmWtvAps6Q7AIIO0mJWuKwwzeR6A=;
 b=dewUKBErRrnmypIMe64iPV0adCMFk3h/5SG2AZS/ORCIYp/7rw5c66kgPFzHO+YONyeg
 wFIp4ee2zK5HvVXu1v/Nw3OlhXY72zWjIu7hZS1rEp2W8ZGRV/1Uiwro4N9asTwzPCR5
 p7bTzwJBGwmUQAG4ddqd2gvKtTwobFNBtF9W3nj1SLBHn71Gja8LudmnnUrd7kHIAYQ7
 o8T05ycQuum5oMqqeWiyVoZ8TB0qQBYeMLzd7mhUbaZx/ZZwPWYS/jeYTkymwZClvoyP
 8MCmTEeU5Qzeij0owfD2I3WnVK8mWAU8vbqcGBjpe+CVLCDLZ9NrE1izz/eai5h8xsNR yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymgk79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:29:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMQPpb011532;
        Tue, 13 Apr 2021 22:29:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 37unxxfabt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/YCjaUIv2X1bdWixRUbOJUJMWF1UC2DC6sgHb0DVicwuMkv940yhpoXOvfnRsUTgrMLiLl62IDRUNwTDrpL39WLhIn2T8lpoUNbIqztmLgCYZiBiI89wjhFOcEMjxdL2ShRuVZ6GyQKHCESqzWXs1ZRLHMwDlXDxom6g9il8x+JweoP6ETZm6SoV5qF8n2oCS/up7IgUxG34wxRRdwL+hsIMfDP7cjLNLY2EzSen0vACbvjIjwhyGJCk1PrBJ/pt8gHE1GiEcWxYIj0NAf8B5Aw53ZaIztaJmp51te4wJWbpmrZmcTudgeMCprfqxb4HUme0iDOVp/Ahy3Q02u5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw6MNPgOoncUqQwvmWtvAps6Q7AIIO0mJWuKwwzeR6A=;
 b=cSxHKPHYWD8Dh0mhV7NlYv+bCU9xkUIHDxzh3Fubhltv7L/6hc8gZjFG+gsM1i100gn8SrBYh3/iNX3spVydkEHGDV+k/h5qN9256LKx90ui7x/e4+DeRlq7ocJue7KoKrvBXymu3UcnCShgRMKgSbCGzDVzBnZDTaN93OT533RrcFsiPiugBj69b0BwbqFKd4F7FimfZgoYOxgEwxZuXjqQqlUkxUNbR5AyWTua6WE3FRY8gfKQ5D6LePivHJZkZ2jL1IrVgliJ9l606Q8Z4u3RmxRnbnDfqCib4VTUbVSR4YFFFGR4fnLuv3sWROwT+C0IpFTgUtw8wfD36vEuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw6MNPgOoncUqQwvmWtvAps6Q7AIIO0mJWuKwwzeR6A=;
 b=ZW9oHDbAcEIVB3sLnrPHzh6soM8xKuacpRMKKnJrwEQSz7OOQRK94oCPgxjnYgig4d3y169M2XmC79qOGTDOj06sGW/07FBkncWgwekv02QuxDllNAT5CH88d6SRUenUQu9xH+z6gaEJDzWRTi625JqH22FM4eT6px9rCinkO2k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 22:29:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:29:04 +0000
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <338f73f5-cff6-61c1-5252-01d9b30be627@oracle.com>
Date:   Tue, 13 Apr 2021 15:29:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0069.namprd10.prod.outlook.com
 (2603:10b6:300:2c::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0069.namprd10.prod.outlook.com (2603:10b6:300:2c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 22:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ede4a3eb-cfbd-40cf-f408-08d8fecb8b63
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45090288CB469E249982174CE24F9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +URTHK+BTJuOSjIjDsfTuhDNPstlkpSwLLwJvrYYBYvJQMUFOH8er85LDN5FbUoZUb7qWdQbVeSydhuM4hOfbFAXyX+zhVm3R08KBOo2Blo6Bjle7xLhzXKZiU8N25PPj/21N2wk2wDuI3+dLN1F2K1j4JO+cIlMzDfHWJuASadvELHY1jpAwL2KfsQAY9+rw/M3oRrxPUZIOSBunsLdHf+5TrcSgQVIWsAF429XzA9oaGMhfMvaxbPFQpAlJ3a5VUQ7luAozCOW3FwbniYRpoF1cGYRv5oTHclWZMIc8FyVnPMTXeCSwAeT03zXdl9TYThxrTWiiYZB10ZYavNEHgZTEPiAJifv5uBlh69dyps98CE7T94ctKgVFnHSGEcRh5mqomg4VXcK0XMK6g8VR//rkvxQeyEhPSJJd9OJLqLe39T7iqbjdxL6kk8go35JLZaZfywM3gR4K9O5XPhp6zV9AE+juddbIlTr4R3yJ1Or8dmj7bNbjGE2QpnloCq1qGN+wWX50juUnYaZKwrX56Vut/6RQuDEGo1nBrB8LeplOhAAsOxSAafyUgc9xcpSjoQzRWejZmhr5NqFBH7kDLsQrk4/fZl4blagueNquGLoyKpuvFqU2rfxBrZn7o/URZxBvGpJUZ//smoYB2+tHjRgfAb6C73moqwk+wEB33ollnE3l3bKZho46IBmXM0Vw0rVrNflqVwbJsh6U+xXYrMufsvRq+A6zUPyXeQWUzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(38100700002)(38350700002)(186003)(86362001)(16526019)(52116002)(31696002)(66476007)(8676002)(4326008)(8936002)(44832011)(5660300002)(66946007)(110136005)(66556008)(26005)(83380400001)(53546011)(2616005)(36756003)(31686004)(316002)(6486002)(2906002)(478600001)(16576012)(54906003)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UERwNGtIK0xKZmJxdU5LRlVLSW1KYXl5NDd2VGlZMXJnU25pcVI0aGxKS280?=
 =?utf-8?B?bTNjR3hSNkRIdHJ2Y3E2Z2tiNGZnL2JVamNjazYxbDNxZS9xNWhoYW9lNDNv?=
 =?utf-8?B?ZUliRTZoVjBPOTZpNjFYNlRLczdTcU9NcjN2by9EVkR2V3l2dzRVczAwU1JG?=
 =?utf-8?B?S2JGcmZlaTRZZ1F1Rm9VYWpxdVJyWU1CNVRxUFBNZkpoM1dOOGlCelpxOUFL?=
 =?utf-8?B?eVIvOTlXL1V5dndmWUpsUDk0UXVSZy8yU21yVEcweVFKNlZpNUpUS3Fxb0Jr?=
 =?utf-8?B?MjA5WHVaNEJhTmtpRzlST0EzZWlXd0UwaVBSY3ZPSldzSFFPU0dHREdHaGJz?=
 =?utf-8?B?azdHYWZEYUNoWHRUWU9OQnVmNzBqZGtncnJDUG1VZDVuK2hVSFBSbDJiZmJm?=
 =?utf-8?B?b3FyUzFlS1F5RDhCSWNiOHM3bUxqOERRLzlza09sNVBwWE1yMEJ6WGNBdmYw?=
 =?utf-8?B?M05JcGxsRkt0bnBIcDhkRVduWTNpckJhUm9oM2g5bVcrc3NNSUFiS0toNDJv?=
 =?utf-8?B?WkJUNk9EZnNxd3JWcGhtZU1ueldYVHlYb3BzczN0V2dnbzNLckxnbDVXZU9H?=
 =?utf-8?B?RTY2SFh4T0NMUi9YS0FyTVJmSldZN0tNT1BCWStGMHZGM25hdWdyOGZ1eW9p?=
 =?utf-8?B?MGNxL0Q0aTg5bENyNFpOaStVdGw1TlJIOE5Nd1JMQUxGMFNzNzkrRm1Fc3FW?=
 =?utf-8?B?YUpWR21WZjAyM2RDNUZVa2ZSM3FtSDZXL3hCZUtZdVl0Mjk4VGJzNTRXUDdM?=
 =?utf-8?B?MmwrQlIxNldPT3NRUC9xVnN1ekEvNUpJOTdzZ1BKNmppOGxxd2NJcjJ4NFBB?=
 =?utf-8?B?ZTJVekxSSXNEbWNUSzhRcStuQnVaZ0Qrd3U3N1RJS2FQNmRsMllpaXh4dzAx?=
 =?utf-8?B?SFdzMUZPR0d2SndTN2JZUDRFVzBIN0lNeTA2TkhyVE9jdnIxOEVZTjhESUFG?=
 =?utf-8?B?QnBOd012UnJBK0cvcmU3QUNqNTJweitnV3doMkxIdnJqaUxjUXo0TjU0SFNj?=
 =?utf-8?B?elVxWFppRHRPdy9VZ0FYdWVFMWl6VHlKcVhBdUx0SjQ5TThhNXRlY1Rmdk94?=
 =?utf-8?B?dk1XcTJ4ajNPMGZOa081U1NFdkNVcndRWDNZR0lzdk5IbEdBSnlCTkZIdWd5?=
 =?utf-8?B?OGpyMDd3cVNPYTlNck4wSGthWjBsS01YT1ZLTWIxc1F2RFpJMDM1em1OZ0pW?=
 =?utf-8?B?U1VKbytFV1U0L3AwYzU4MWg4U2I5MERhTTZpQVNWWlBDNUxCeVN0dk1uMGlT?=
 =?utf-8?B?Ukp3Sk9GRkJINmFzeW10VGJ2bzAvZjBEMEtPQjY5cHpjdkVnQkpCYk5KcDhJ?=
 =?utf-8?B?MXFOT2UxNmdSZ0Z6WUJ1ZFB6SVh0WXp4OC9PdWhORVpsUy80REcvc1R5ZXZj?=
 =?utf-8?B?cW9ZeENkMVAxa0RBaVo1dlB2ZmdwSGxVU0c1YnI4YlZUQllFUlNDMHU4TWZo?=
 =?utf-8?B?U0JReTZ6Vlk3Y21neHdzYTFPTW8zQnVWcCtlNHlUSzJvWWZaWFgzb0p2KzlS?=
 =?utf-8?B?cXJRYUpGenNuNGlSS0xkQi9VbjAzTFJMZExwTGk2NGwwaXFMVGg5RWJmZjZr?=
 =?utf-8?B?TzVHMVZFanZMaEtaR01LNHF5THZwOTNqaU5IM1JoUDdXN0twMUE2cS9XSHdw?=
 =?utf-8?B?UlA3RTlRNUpiNFE4NjZkbGJsY1ZWOUxDV2Rxam1jYzMrMmh5aG96U1MzbnE4?=
 =?utf-8?B?MmdENXc4aWFXUksyRFFRajlXb2NiRm5yYmxjY2s3Zk9vZGJWcTZneGpvNFdN?=
 =?utf-8?Q?+B5aiLIyVu2I3KjbMMNh8ITDMuTx85AAqw/K26n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede4a3eb-cfbd-40cf-f408-08d8fecb8b63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:29:04.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGaaS2B0KXg6AKF6rnRWc1Wm0GQyvcsQE2av7aI5RwrOxhbQM8yJj8VEdUK+DIf3UGyFB4G7qkJJ4jxoVeZycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130145
X-Proofpoint-GUID: PU8NfLtglCnC8O1XPM_tMcIFd8vwZ4it
X-Proofpoint-ORIG-GUID: PU8NfLtglCnC8O1XPM_tMcIFd8vwZ4it
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> The free page replacement is done under hugetlb_lock, so no external
> users of hugetlb will notice the change.
> To allocate the new huge page, we use alloc_buddy_huge_page(), so we
> do not have to deal with any counters, and prep_new_huge_page() is not
> called. This is valulable because in case we need to free the new page,
> we only need to call __free_pages().
> 
> Once we know that the page to be replaced is a genuine 0-refcounted
> huge page, we remove the old page from the freelist by remove_hugetlb_page().
> Then, we can call __prep_new_huge_page() and __prep_account_new_huge_page()
> for the new huge page to properly initialize it and increment the
> hstate->nr_huge_pages counter (previously decremented by
> remove_hugetlb_page()).
> Once done, the page is enqueued by enqueue_huge_page() and it is ready
> to be used.
> 
> There is one tricky case when
> page's refcount is 0 because it is in the process of being released.
> A missing PageHugeFreed bit will tell us that freeing is in flight so
> we retry after dropping the hugetlb_lock. The race window should be
> small and the next retry should make a forward progress.
> 
> E.g:
> 
> CPU0				CPU1
> free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_buddy_huge_page()
> 				    spin_lock_irq(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock_irq(hugetlb_lock)
>   spin_lock_irq(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock(&hugetlb_lock)

Very small nit, the above should be spin_unlock_irq(&hugetlb_lock)

> 				  spin_lock_irq(hugetlb_lock)
>                                    1) PageHuge() == F (freed by case#1 from CPU0)
> 				   2) PageHuge() == T
>                                        PageHugeFreed() == T
>                                        - proceed with replacing the page
> 
> In the case above we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
...
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0607b2b71ac6..4a664d6e82c1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2266,6 +2266,121 @@ static void restore_reserve_on_error(struct hstate *h,
>  	}
>  }
>  
> +/*
> + * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
> + * @h: struct hstate old page belongs to
> + * @old_page: Old page to dissolve
> + * Returns 0 on success, otherwise negated error.
> + */
> +
> +static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> +{
> +	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +	int nid = page_to_nid(old_page);
> +	struct page *new_page;
> +	int ret = 0;
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one for the
> +	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
> +	 * not having to deal with prep_new_page() and avoids dealing of any
> +	 * counters. This simplifies and let us do the whole thing under the
> +	 * lock.
> +	 */
> +	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
> +	if (!new_page)
> +		return -ENOMEM;
> +
> +retry:
> +	spin_lock_irq(&hugetlb_lock);
> +	if (!PageHuge(old_page)) {
> +		/*
> +		 * Freed from under us. Drop new_page too.
> +		 */
> +		goto free_new;
> +	} else if (page_count(old_page)) {
> +		/*
> +		 * Someone has grabbed the page, fail for now.
> +		 */
> +		ret = -EBUSY;
> +		goto free_new;
> +	} else if (!HPageFreed(old_page)) {
> +		/*
> +		 * Page's refcount is 0 but it has not been enqueued in the
> +		 * freelist yet. Race window is small, so we can succeed here if
> +		 * we retry.
> +		 */
> +		spin_unlock_irq(&hugetlb_lock);
> +		cond_resched();
> +		goto retry;
> +	} else {
> +		/*
> +		 * Ok, old_page is still a genuine free hugepage. Remove it from
> +		 * the freelist and decrease the counters. These will be
> +		 * incremented again when calling __prep_account_new_huge_page()
> +		 * and enqueue_huge_page() for new_page. The counters will remain
> +		 * stable since this happens under the lock.
> +		 */
> +		remove_hugetlb_page(h, old_page, false);
> +
> +		/*
> +		 * Call __prep_new_huge_page() to construct the hugetlb page, and
> +		 * enqueue it then to place it in the freelists. After this,
> +		 * counters are back on track. Free hugepages have a refcount of 0,
> +		 * so we need to decrease new_page's count as well.
> +		 */
> +		__prep_new_huge_page(new_page);
> +		__prep_account_new_huge_page(h, nid);
> +		page_ref_dec(new_page);
> +		enqueue_huge_page(h, new_page);
> +
> +		/*
> +		 * Pages have been replaced, we can safely free the old one.
> +		 */
> +		spin_unlock_irq(&hugetlb_lock);
> +		update_and_free_page(h, old_page);
> +	}
> +
> +	return ret;
> +
> +free_new:
> +	spin_unlock_irq(&hugetlb_lock);
> +	__free_pages(new_page, huge_page_order(h));
> +
> +	return ret;
> +}
> +
> +int isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	struct hstate *h;
> +	struct page *head;
> +
> +	/*
> +	 * The page might have been dissolved from under our feet, so make sure
> +	 * to carefully check the state under the lock.
> +	 * Return success when racing as if we dissolved the page ourselves.
> +	 */
> +	spin_lock_irq(&hugetlb_lock);
> +	if (PageHuge(page)) {
> +		head = compound_head(page);
> +		h = page_hstate(head);
> +	} else {
> +		spin_unlock(&hugetlb_lock);

Should be be spin_unlock_irq(&hugetlb_lock);

Other than that, it looks good.
-- 
Mike Kravetz
