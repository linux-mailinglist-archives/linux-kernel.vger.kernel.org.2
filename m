Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D5343472
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCUT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:56:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57780 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCUT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:56:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12LJtWtx006160;
        Sun, 21 Mar 2021 19:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NnT6ZkNpWCSp0gFawNCgTgQZJPJHJoXZecSjwbimFPE=;
 b=vMruevS3hYJBdyh4rML5VwKJ0TJeZQK2t5vOGhzfk3s0ERhw4KeazywI9lnlyWC/lRjh
 yfnlPWTVjqog2x4On40szzdeNAi5P34Citn4zKvK3d4kBt4lIEomIqsJWt/3iSdu/U93
 8WKPYW9ePcTcllEH8nGf/OHzCzyGVIpHRK9vG23+iUoqkGCKA7NAWLzCCVA5oBJ2kWMq
 q/4HNy/OgmVVu0nmoSCBVOTAMiMjAZip1Rap/o8yZXxcFKAiwyjoJLbhSecy8pyrRSqr
 E8su7UGcioGK7yaSYP6KPOwTRl36ktROGLyuH5mpp5slRTotUF1Bzh26XsxZyD8c0dVX nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37d90m9vfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Mar 2021 19:55:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12LJt05G061150;
        Sun, 21 Mar 2021 19:55:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 37dtmmgxst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Mar 2021 19:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEC1ydCJu74gi5iTe3SMPZ/DajjbSQkOswf+LKi1B/s3T3OQE6g4qdeaMbdwhsun0y9FUSGmab/b7l3FvgJRN9VKz1M+2k6VFX+QRfl7vDEInWeo9F1IP2agkuC6A7avfCmjAuFYPSyhDKzPD67wsmlpCZsf5vztqKKeWxydzbqbSlAYTSZF5RsFWTLW3j+O99dpKsiPYf8vQGFfNu+JlDclB2YVFqLcysHqEAV1GfDhXks0tH7pGkYyWPagW/8In/rtfFR2Duicu2MnveCLa+6w5P+RIUgS13ghFccsm9Ia2lGGQFQ22QYZAgadmKoOWbBcDcS2hQtC2sDdZ4cegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnT6ZkNpWCSp0gFawNCgTgQZJPJHJoXZecSjwbimFPE=;
 b=Hi206Vd0GgwJl4KLekQUOTSRZImXDVEPE/3HhJvGQtxMNTEnUVFwL5zM6IX2ZoJXIsoNScGwOra+l5eGfYuvU3zuAMF3d3WSXnHjLbIbu52xIWQIfAQAgoeiZ1IPs4jvMi6zeVzY3dRgi7LwWTASDHapIE2TUbWF79tgNSJe25tff89V0Pz+3yxMskcF3FxzYMI0Q42SdsHKXAO3ZWHl/qzwemJl0MS8T6DvqFRIreQA1RiVoylL+rtzr7Sbu5xNGNw6D/8AefS0UnibJA3ibEzdmJl6dkZjvyXYMON2al4RMDdNearqARWslbMwzsDPiLj9X+HW8XE95x+y9XTtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnT6ZkNpWCSp0gFawNCgTgQZJPJHJoXZecSjwbimFPE=;
 b=tT5FUxx/yl31xiaT/9M38jgiNAN3+MGBzfpsGE7gEAlDmgTm0bgvbyQMHfPNsq588GHdXMVb725a6A1ADLbK2SpLlS61eER9sQ+t5qFRvMz0tmyAp6lW+ywBz1bJnNiqP+1ns7GhbREM1ZR/ZYo/Whlgnm8HLM7l9hK8kh8ExW4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2854.namprd10.prod.outlook.com (2603:10b6:a03:82::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Sun, 21 Mar
 2021 19:55:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 19:55:29 +0000
Subject: Re: [RFC PATCH 6/8] hugetlb: make free_huge_page irq safe
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
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
 <20210319224209.150047-7-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <75ce83cf-8313-f2da-03f3-b407e262d1fc@oracle.com>
Date:   Sun, 21 Mar 2021 12:55:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210319224209.150047-7-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 19:55:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e8b0f52-301f-4d82-e2dc-08d8eca34743
X-MS-TrafficTypeDiagnostic: BYAPR10MB2854:
X-Microsoft-Antispam-PRVS: <BYAPR10MB285479FACB4A1ADF5C0A8EACE2669@BYAPR10MB2854.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUnAoX5bXD/drwpVcDP/aGmIAs/vYho5Kzz0dtmn9SSSRPLC8VRR8JY0vdV+xG0lM8Q4OMJaWXvWRUouNDnxUC1q6TpwuhVJfUtX0SvloRYNOyltz+K4uE+oeSeUUmvgC+nimx9Ql67xAWH59bp/JzWB0aajdQSWC7L7p+GyR7a9HT9D/m6yAkcS79Z+gtC9rrf6wd9U+EczOiWknPXg79hvbQuIoE+QWWFFsHsSyaj7t9MvB8F/RKSiwADAgpeBT4z/2nzO5Vt57GzEk18gjEU/E4j3iQwAOikHmhtSNm19MWH8iYLUVUIppx9sdTeYDK/arRBfZDuvt5m7kxZ2jG3gxjXoMQ9miJz8FGHHHcbaNvEtteJVk26UZCsnQiCXcbH74AFkslrGnwFEKBtGtiOKNCLUDEuQhf62J+bSxOL2Uyo1LO0ThvFRsQ5Fbtuz6U76+lT9l4YBWYBs4EVoQfvVPJiXYVEFTDpjQfrejsRRugM42uzogqJuWTR9lgiHo+VjZtG9D4CsUEG1QmuP57rGhrsgO3uFexS1d9L5nCBLFBPAtRqTHUrfYC5/T2VrDcFdToVUsZG7XxsWpama/rDtUaBgiufZV0sno1iTrokatc8NKKXpwWI4+XxBtSkVTXPkD2su8YwYC499HZQ/1MLb2BvDTwtaNsJkWjVvQFrywgYjSeziZ8kyhsSDGxVtpl+ruALXYn247585UXejtMEAF0P7j/U76OWBXN52Y6fu2NaVgVkTj+Q50Q2akR4fbw57/rNahqsC+hiAKsBcCmC3rhh29porK8ZwZ9iJ7RPpLqF+Z3/s7xKQWPA9uQUs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(366004)(38100700001)(66556008)(66476007)(956004)(2616005)(186003)(26005)(316002)(44832011)(86362001)(16526019)(36756003)(16576012)(83380400001)(66946007)(31696002)(6486002)(6666004)(31686004)(478600001)(4326008)(2906002)(966005)(54906003)(52116002)(8676002)(7416002)(8936002)(53546011)(5660300002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXNhRmxiWlN4bGc5RjIxaWhTQzRQT3dQbkZud1d1eTFDWHBlRTY4eml0a2Rt?=
 =?utf-8?B?MnVOai9DV0t0VGp5T1VjcTRLZVJVbzRaaXBTZUcwZ2d4ZjhEZEpwUHZwMVNi?=
 =?utf-8?B?V2U2WDltRXFFUmxIb1pSWGVLcm42NGxrNWlIT2FPLzU4RnNRSmVGQUxneWp3?=
 =?utf-8?B?eHpwWjY5eHF6dEJqTVBOckUxajdvUVNIZ0lVMCtramQzRFlVRTFPWFQwemsr?=
 =?utf-8?B?K3U2UEtOTFpxZG8vcmI2aFkyTGg5ZXNnNzhlVkc3RDRuRmNBY3Q0Vk5sWWQ0?=
 =?utf-8?B?ZlQ3UzlQSVphTmptQmp3TStSNHBBTzZ4eHZiN205RlE2aG9qSUtsclQzZi92?=
 =?utf-8?B?WjVJeUkwVnZwTlE1RDNkMjRKbHY3RFE4NzYvTjRUYlNVVU9vYldBdWw1bjFr?=
 =?utf-8?B?VDA0TUhvc0ZQT2lvS1ZsYm1haWdPc1IrcEVvNklJb3RTNmxRY2M5SHh2cTBp?=
 =?utf-8?B?M2l6VUVBb256TVlvR3hkRHV4QzlZbXpGTWt0MXZTRWFHSlUxU29ocGRFQ2pE?=
 =?utf-8?B?WU1hRkhaRWVnWVFxalNxOHRnK0Vra2JJY1pnNUlGNGJYQW8wVUpUVFZFa0Vn?=
 =?utf-8?B?ZzZBMmhQR0FqMHFhQWszckNKUC95SHBCcjVyblZWQ1VLNjM5SFhKUjJyZEV0?=
 =?utf-8?B?SWdTSnZoVU11TXpDbFlYY2Z0TFlJV20zQTdlT05oTGowQURoRTRHeWh1MEpz?=
 =?utf-8?B?dzN2cDg1cExHZjdFeWoxTGk3WkZhczYvdjE2Z21ia2xBVkdVTDZ6SjdVMlFh?=
 =?utf-8?B?K0NUR0NwSW0rKzIxd2VxZ0I2cWxEeHJHSjFScmFqYmx4QjBHMTJuRDBxaG5X?=
 =?utf-8?B?MWs1cUNWd0Y0NXlYZHUwQ2pTcFppZFA1dVNQdzVDdFVzSXU3WDhJaDNmR042?=
 =?utf-8?B?TUlQcWptS1doZU1TcXN3UjBCc2srQ0E5aTZoMFArSDhqWjNya0c0V2ZDSHZi?=
 =?utf-8?B?U1ZjQThKbkh0bW5LaEJHQU1WS2xJc2sxellBeEwwUDYxQnFwb0xzS2JXTUxC?=
 =?utf-8?B?aDg1RTBhSWRmdk9ERnFEb2YzTXBpYUMvY2FPZm40K2NrYlg4Q0xtZDBET1dN?=
 =?utf-8?B?SkNTQ3FWRmNkaXRvMDVUNEZtb01aYk1rWS9RSmRaVjUxTWJKUXhWRmc5d1Nl?=
 =?utf-8?B?aVRlWVZ4V1k5SlVlbm5qNlphOE50MFVyS3ArVUR6eFl2WkJudC8xME5zRXlV?=
 =?utf-8?B?UXd4QU9tRmZQNWlOc3ZmYkMxR3RBYzRnM0w3ZUtFSVo5SmNBb1RKcm5hQy83?=
 =?utf-8?B?VE8zTlVvak0xckl6VHdENXVJek1BZFV2Y2d6Z1hBaUV6aVM3UEs0TXVkTnh5?=
 =?utf-8?B?Zy90YWpscDdvSzlTUUhrdXdIVkkzdXJBelVXWFAzT1poQ2hqMG1vTjVEWEEr?=
 =?utf-8?B?MWxFZWV0cWtDSkhCbUl2UTIrV05jS3BPaFJhZmgwRERrdjdnYnUrc1NFUXRj?=
 =?utf-8?B?Ky9GM3pORXJodWFadzN4N2QrZWVoMnVXVWlZMTZWc3IrRHAveitZRmhRaHNQ?=
 =?utf-8?B?NEpPTksxNXc1TWZZRmlTVFVsV1hKWDVzSDNtUXNHc211U0VCVWlMaW1NMURT?=
 =?utf-8?B?VFY3SXR3V0NzaHM1QlJvS1llMVlKWDVIZjIxZGpKMjNaaXR4UVRBSVpIRFJm?=
 =?utf-8?B?QWNXTk5pdUFQeVNORmxhK3AzTEJXL1NRem1MTU0yM2tEV3haeTFTLzhMR1A1?=
 =?utf-8?B?aGdPWkpzaVZuempRa2lHOWVycXJVdU92UnNnUS9jbk9WQmZsN2llcDBsTWxy?=
 =?utf-8?Q?gJUaOimAbmUsIqZLFASUG+FmcNfJsZ+tu1vfFCq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b0f52-301f-4d82-e2dc-08d8eca34743
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 19:55:29.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE9CiJ4PtvIlNCwuU6rsTPWYYt3AeiwI5ApeKz8qwbzjbfrkAGulCWi3vS2WntoF5id4wYlisYPt45qQBhgeHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2854
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103210159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103210159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 3:42 PM, Mike Kravetz wrote:
> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> non-task context") was added to address the issue of free_huge_page
> being called from irq context.  That commit hands off free_huge_page
> processing to a workqueue if !in_task.  However, as seen in [1] this
> does not cover all cases.  Instead, make the locks taken in the
> free_huge_page irq safe.
> 
> This patch does the following:
> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>   changing spin_*lock calls to spin_*lock_irq* calls.
> - Make subpool lock irq safe in a similar manner.
> - Revert the !in_task check and workqueue handoff.
> 
> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c        | 206 ++++++++++++++++++++------------------------
>  mm/hugetlb_cgroup.c |  10 ++-
>  2 files changed, 100 insertions(+), 116 deletions(-)

I missed the following changes:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5efff5ce337f..13d77d94d185 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2803,10 +2803,10 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 
 		/* Drop lock as free routines may sleep */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page);
 		cond_resched();
-		spin_lock(&hugetlb_lock);
+		spin_lock_irqsave(&hugetlb_lock, flags);
 
 		/* Recompute min_count in case hugetlb_lock was dropped */
 		min_count = min_hp_count(h, count);
