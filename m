Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C24308CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhA2Srj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:47:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58980 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhA2Sra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:47:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TIZJgo077283;
        Fri, 29 Jan 2021 18:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/Z7MRAgid0WUN8qPAe5W7ZFPov7d3uwa4FaRtZU04BU=;
 b=ucKl19VLmuKLFNtfaNe+9TeyFcQE0x+CFMLrjiR8z6Xn7g1f1DB38TdFeobVq6Mwc7Yq
 jOTKe+uPy0U3Ob9cn390VzBjghylVANkwLTPIODuvuEWs5Knp3kxihmlq519XOLXT2B+
 hSQMOkVVEZpr9/mTDYeLbu4k/4ii2KUDpntN34NXIjYspB4kEtkHw2ncRun0XFjE5231
 5V0vlSIIjODZccjbXjaf1gmMLd2db9c+dnOnpZUBK/WlCMwFceBSg9MWwgH1y5QpU+hd
 DH6UaenVn7qSNw1Fb4LwwwKVpTx3h8HGTGmMXii+z7/YTbwNRzvicPUJe1wKwl76vCnv XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689ab2xc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 18:46:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TIUPeQ110277;
        Fri, 29 Jan 2021 18:46:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 368wr2ahg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 18:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgZJGdIqOrKjottKyiDPp2s01/+rNJza17e7s10wdbpYKo7jZT9EGNgByyTStC9nCGZngWjL6L6A4uqjhtj76zYFU9ZSk6UjorPM1NGmS8Q/fNgeDwaVskuKBeiuwWgt1RTHGQWiJ2NgTP6TwQc03zUmi9fB7vDNu3tIzk/Wx91YbLYaq2JGG0Xuv4vrW2EclIVloSNeX2sxOOGCqCNS805kP+1hE6Rbb7XxSw/GKZpSALoXQa/hvHQTltOBvRBYTEYGN27La2BUEHtmsRrP9TrlIEz6vyaQRM+zF2g3I3kyYcaUSb8ghthihXPfS7qzTxcztOAbPx5MoPcVk3fmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z7MRAgid0WUN8qPAe5W7ZFPov7d3uwa4FaRtZU04BU=;
 b=WfU9CfOSQCDeG9y0xsXCPbUAQt9p5AEditgmqGlJXPIMRWDanNgJx0Cw0w8mw7wdIAIeTzCOpsLamfAi7+nCNm62LkvFjw9MD95JlmSdHoiSRU/dwUER2GHldlwliYzdhyqMfTizESOHjW3AjXYnJQeojBAKvDQmBGlc+sQXwJfQJ/Y4DJU9S/Qt8pos2kvUCbRDMSVSq3Ghq9NESPq9Aintpni/8K359/LmOqN163136RHXpZlAzuhe33ZXRcVnxHY6GH8WLQtCDUTtvuWMrN6wXf6nRSDvAFcbRs/pHIOtRFqDNO/o3qAlgSM5/lBqz2vBefnuHxAbpSkajCt74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z7MRAgid0WUN8qPAe5W7ZFPov7d3uwa4FaRtZU04BU=;
 b=jCgHHEueYw6x1leRu0HXoxv4O9x0FYYqwuKtz5898dNN3x6ntsXIn0ejT56roUyoqV+9Dt+MisJ7Df0lslVJ4MFOpr8W1r3/7VBYyIz2wkGsBLSHzcVIUS6F1J5jjAVLytt/pwJr4DiyuaC6QYhkPQRzUV3ZfzaHDsKjm8+sNlE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 18:46:17 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 18:46:17 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
 <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
 <20210128055221.GA3166@localhost.localdomain>
 <20210128133733.ce1fb2eac98ab5696c08f288@linux-foundation.org>
 <12187293-e972-acd8-7789-22ebfa736f95@oracle.com>
 <20210128141531.17fec31e6075fe0eb6e33683@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <62a80585-2a73-10cc-4a2d-5721540d4ad2@oracle.com>
Date:   Fri, 29 Jan 2021 10:46:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128141531.17fec31e6075fe0eb6e33683@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:301:4b::21) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0011.namprd14.prod.outlook.com (2603:10b6:301:4b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 18:46:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edbd2365-88ea-4f0a-a2ca-08d8c4862945
X-MS-TrafficTypeDiagnostic: CO1PR10MB4419:
X-Microsoft-Antispam-PRVS: <CO1PR10MB44190E5BD55C934B7C7E3275E2B99@CO1PR10MB4419.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2OKuZV4ZcbhotnVx0OsiAhfUhddZY53dgvAQhxOHpL9XWIvZZw9O4vw+hf7jPp+HWx0ZhAn/x0MmSpxpO2KHC2T0LYXe7kUx0JeiH0YJtTtc9nFqqJ7sA9jtrtLA5TcIOau8kTIi4RgtcHlzwr2mtaN5mIH0Xwr83bopY7ZO5lgFyaFtb7RpgdJz0YcqBpgVqA6PU6DCcOriPwzxmAIdtJ46Cyh8ifvJxNLZvRSlYQyzEjsXMZ7dHbr7OR25TjNb3i4YAZQnW4ThHj5S3BQqGXn5nVcUA6phbwnzaKqk7kTWT0lm1mDUtE0hjJfSlPQcYW73CXw+62s5yR1zcpESXBkhsejFB+qQv8V4eeOR14dn9Q3PggRcHTE2ggmyltP51h5whbeMyivC5MS8m+aix7VvMy1fTuEUJ3PWQM6BFbuh+KTLSqf1ockRUgjh0PbSceDopg5x2NvMGeSadMu+zEzipDBWjPITB4pyHJvubb9QFXTl59952ZJUdr5BeLc8qNCGIeQ/9lYytUrhwjHnYmfjVGg+VNvTKOetToMIohGIv212GCkctx9FF/Wh58TRfXCTDprpIs0uAA6/wDOjL/CzZfZoSydrrhnP4hXXL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(956004)(86362001)(52116002)(66556008)(66476007)(2616005)(16576012)(53546011)(26005)(66946007)(31686004)(16526019)(186003)(316002)(478600001)(5660300002)(54906003)(31696002)(6916009)(83380400001)(4326008)(8676002)(8936002)(6486002)(36756003)(7416002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OWs5VTZxYzFvNkQvbGpOMVplYmtXc2VhNTdBSGQyczlEMlBUSUpNZE9uelN0?=
 =?utf-8?B?cnpMSVQ5cUg2bWRyWUlPZ1JNdW96SXlnbFhnTTVVMDVmVTI3eFVUTjFjNWV3?=
 =?utf-8?B?SGlPMDUrdTlMZk5heEJDanZFZmNIcWMvNnRob3ZFaDRYMFhydTY2Y0Y1RE5W?=
 =?utf-8?B?NmpXaWs3MWhlWFVUOHJkZ1B6cGdqS3FRbUR0dUcrNmFRNFBWa3Q3c044RUlH?=
 =?utf-8?B?TWxKNTRqRkFmSUd1aVEyZk8xTGpYNjNhb2toNW5zcG1XSWdaREVvWG43RGRi?=
 =?utf-8?B?ZGtoTHpzNzRQVWY5NlQ1LzFKUXh0RGhSb0FwK0Vwb3BCRXFyOTF6bGZMTlJP?=
 =?utf-8?B?QWZwWUdYNmpGdXJpeEUwb1ZDV09xWllNcDRZTlU0bWkyUG5Fdy90Y3AyQ2Rl?=
 =?utf-8?B?dUNvYjIva0pJK1FPUUtkbGhCellONEsySG40MVRUL1dmMk9FVi9qbGlhaUQ4?=
 =?utf-8?B?NFdITCtPYWxOZEdvbmJ6eG83VWJSMWVITkM1UGo1UzBzdTZMZW05T3pjaS91?=
 =?utf-8?B?bUlXQnIzd1lwUU9uNE8rdk1HaEdkTmJrQVRMZU02clBlMHJIcG5tNmxCUDZD?=
 =?utf-8?B?M0o3NUJIbXBocXhhNmo1Zm9HaXlVWTRDaGtid0tMSUF1NWQ4c3pNV3dodXFr?=
 =?utf-8?B?WmRWZXVFdzJsRGRsQTBzRUd6U0lVN21HOU1pK1Z6eTJuKzF1M0NISzRxc3Rq?=
 =?utf-8?B?ZU1LMVlSU2xWNURHUTkzNnpkQi93eWV1VXFoNXYzVFErVlI2dUpEUmtMRmdP?=
 =?utf-8?B?dEVWYWE4eUJ6eFZEYlNYVzI3eTlHRVFKc1EyK0UxYWFWeXNzTlR1THVBZER6?=
 =?utf-8?B?RG12SW5CV2NyRmU3TjZTMXJLdTJKWkx3UUxKc3JpckgzZUtiQ0Y3aFBpSDRy?=
 =?utf-8?B?djNFSG56WTdJdGVLYUZsb281NWNreUZ6WkZZWUNwaVQ2cGFwWnlUQy8zck95?=
 =?utf-8?B?YVgyZ1VsQlJEQlprQjNLWTNjZXhibjI0WTFob1pxY1FnTjIwOEZmOWN5MC9C?=
 =?utf-8?B?bXgwZzhvMjFSdTZic0ZVdXJUUWpGTXNjZlBVMkFBU2ZlRUdKOWhmRXZOdW0r?=
 =?utf-8?B?R0FxWGlTcGRMSko2THFBQ3NpdWVBb3REV0MvUW82bnpWNmlSWlRHYzZlMlVP?=
 =?utf-8?B?cWZWdUpIT1kzRVFGVWR1bWpkck9Xdk5ab2ZYQnlLakpyd3VRRHZ2dWhpdThS?=
 =?utf-8?B?QVk3TXNYQitEcnNjcUhLZFlQRkxLNHlGOWV4cGozMVh4ZUlMT2tuQzZBaXhE?=
 =?utf-8?B?OXFYbG94LzFVeGNzdUY4THlFZzdZRHNqUU5PcnRjM0l6TTRLNW5CcWpYWXF6?=
 =?utf-8?B?S21Vbmp5bldsNzR5Tmc1NGFlaHZOVlNJT256YkpQRmtiWGRYd0R4MXBZRDBB?=
 =?utf-8?B?ZU1HQVlrUFUwakVtaXRsYjUzT0NEdXVKNWFvYUQwY0xUOUdpaUswbTM0UHNI?=
 =?utf-8?Q?DZIO89Iv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd2365-88ea-4f0a-a2ca-08d8c4862945
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 18:46:17.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4EwtKY3AQuEq8W8c64TJ/Xcvd6dXojuLt9OZ9EhdEtH40qdLKTebVCR2V6ob4lBt14R9nVAevXfJXiVXp/bnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 2:15 PM, Andrew Morton wrote:
> On Thu, 28 Jan 2021 14:00:29 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Michal suggested that comments describing synchronization be added for each
>> flag.  Since I did 'one patch per flag', that would be an update to each patch.
>> Or, I could simply add a patch to update the comment block based on what you
>> already have.
>>
>> Let me know what is best/easiest for you.
> 
> I guess just one patch is best for reviewers.  Then I'll split up into
> a sprinkle of -fix patches if I'm feeling energetic ;)

Here is a patch to update the comments for all those flags.  It should
apply on top of what is in your tree.

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 29 Jan 2021 10:36:12 -0800
Subject: [PATCH] huegtlb: add synchronization information for new hugetlb
 specific flags

Adding comments, no functional change.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e5e6ffd55392..cf70795d2209 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -480,14 +480,24 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
  *	allocation time.  Cleared when page is fully instantiated.  Free
  *	routine checks flag to restore a reservation on error paths.
+ *	Synchronization:  Examined or modified by code that knows it has
+ *	the only reference to page.  i.e. After allocation but before use
+ *	or when the page is being freed.
  * HPG_migratable  - Set after a newly allocated page is added to the page
  *	cache and/or page tables.  Indicates the page is a candidate for
  *	migration.
+ *	Synchronization:  Initially set after new page allocation with no
+ *	locking.  When examined and modified during migration processing
+ *	(isolate, migrate, putback) the hugetlb_lock is held.
  * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
  *	allocator.  Typically used for migration target pages when no pages
  *	are available in the pool.  The hugetlb free page path will
  *	immediately free pages with this flag set to the buddy allocator.
+ *	Synchronization: Can be set after huge page allocation from buddy when
+ *	code knows it has only reference.  All other examinations and
+ *	modifications require hugetlb_lock.
  * HPG_freed - Set when page is on the free lists.
+ *	Synchronization: hugetlb_lock held for examination and modification.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
-- 
2.29.2

