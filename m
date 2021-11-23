Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8560045AC32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhKWT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:28:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6698 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhKWT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:28:37 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANIfmGa008259;
        Tue, 23 Nov 2021 19:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WKYZGNU+t9HoJdFAz1yYvzDvtaECxQhtBupVJcxpeUk=;
 b=Mbsrw/mapwX1ZAayZFpiVRr7VwWdhQoa7z3AIpa5WYJlDc0LjuGYeIHEksrrfeZbkTzt
 cQO8uPIzocxTTYDg0XqWi1lz0aRtPvSn+PsHG8pRqFOjpCle5F0QFfIHVMancQukCRVH
 S3WFJ0u6xW0JDvF5rPcNYjqSkRarg9sK0N5OEsqi+oLTe+R5pQq3aSu7GOnI6Ht772Pl
 4+ZZTpulsqsYJD1jr5bfP2ZY3kn2jnbfHc9RH4kHQkKnPvi4l6MLIewiwyL+htCBdplc
 1ILnNZvPsLlcmqrWMgUpa7N3tFCWyuP++8QoTebOSGWin/dzW6N9oHAk7EJQhzTTWhjT RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461kf2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 19:25:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANJFVLi162126;
        Tue, 23 Nov 2021 19:25:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3ch5tg1grg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 19:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGGQonPuqGiMYU+XPHggrUOgxen01V+XrHRIMKoat+PafwjC1R6HkQqcYAkudgy+R9MDgbuNcHcRxfWdkgwtSnRwObJqAYU9KIZdK6V2xXYSHq0wQVYeKiG1z0pNro67mRMILW+p/BAamZGYTh2omD7rzcvodBW6Ey1Mbi0p1gGL/iZ5tArn5ZZPgbnVTcD4bA/yGRFYtcP0ogas13Hqfo8UZ/7ULwykJKvNNfMFqgBXJUc+YUG/bD4XodZOxyqovuPvR1J593F1YHKV6LHJ9fVk+RRsRrR9KIatIex8nmMD76LoIjgMJVnjbVy5DEyrCuB13jmO8HRjpYfbs4z6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKYZGNU+t9HoJdFAz1yYvzDvtaECxQhtBupVJcxpeUk=;
 b=JNgEe2xw0WKYObnYZQm70L0U5Vg05rQK3d1fRDhAyxsHHPpYNtqhQKjJb+EyKR1o0UJjozrY1YQOG1NSgyrIA5MSKRb/4X7lMDBDVbRVT2JypMH8IcLzD+lwci0MJNoZctvwguXpzu0FRjCuVXcnZf3nBB16xfWkq5rGCoKivoVF9QlNRZzFYfl82uSVHPwVWkksGAxvXlyvq/6PE1d1dFrhWMBlNX46Wkgi0n9c/DOh7XKb+u+xhE3ukKFr57dyOL4Gw4FgcBz1TA39zMtVOrumwKJ7jjDpt90ayfI7ZRtmbpC74SqiuI7tv7hKzO6eea/vyF2H73Sxd9udyyT84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKYZGNU+t9HoJdFAz1yYvzDvtaECxQhtBupVJcxpeUk=;
 b=rklpvz6RsKMmgMFm2+qIK8hf3U+iwDYXiLbeKsVOacM7R6KYsvWn8Xa2NDMB24RT22L+pBpJGu5AOxKF8Wpxpi4OQyNJIvqDaFB3esm/EEJBXou1qG9/KsRPSEBAuK70HOb9P4Z5r1oLIRxKom7uIC/aGf2GGZL9We87q731CKo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3256.namprd10.prod.outlook.com (2603:10b6:a03:152::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 19:25:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Tue, 23 Nov 2021
 19:25:08 +0000
Message-ID: <3e6dcac6-c947-5f94-cd94-b59a8247dbcf@oracle.com>
Date:   Tue, 23 Nov 2021 11:25:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
 <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
 <71816b8f-93e5-5a2a-e616-d52a1c4d354c@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <71816b8f-93e5-5a2a-e616-d52a1c4d354c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 19:25:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b978ad6-7976-4571-eff0-08d9aeb6f5f0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3256:
X-Microsoft-Antispam-PRVS: <BYAPR10MB32568BD3A393A343E75BDF59E2609@BYAPR10MB3256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eT/jHqHBDZcQfESjcBYPRQNqEMKUlQnJTEM86i/6wXdxclPJBj9lUMhsUmyYyCdKXAWGsqXGi59JBdkgAY8Mdk3pJ4LOI822G8UYtrYMFF8m7om3lQ24PcmudvdwWC389yKuVbGlfO6IU4q+KjlOgNbUfvfoUuk3YevHWrC1/CDh/+GsWe1esJToOhi8UJ4Exm6IqDogVRjSm9NpWO8iHrNXp+9hhUKUq/ObIwYw77E7KAeTQOdDAddeLawmLr80687dgf0+fQV+k7FAHGRqqMj9JJDVft1xs9tM+0HDGH14ZOKAAslR5+g1PtnStRItrSVDv64yy6g5HEFIq5OGHd5eJJQkUk9HoP7LGSn4zBKcmtfmUnKptzUJ6i9Zb/oeHPHOJlox0nY4t/FyK21r6ZwotZqBkVxnAgnV/qzjEK/cjpMpRvLVzEJmIcwqLjLrRbcPDZfHJdGI2k6yicyLZDz5coleUqbkCuE4hku0YcBgd3Gv6YBKuxx7JQuJk9fJkc/mhKc4JBDHDrkDPUMau/P1KXpkNtUaVtivCgEWPsVN95GdwHYQ1lAZcbH2JJHNWvPE3xUToSB9JtqQesJOpH3SLW6ohE+ph7aX5Bqy/T/OuM3W4u10UEOdtef+Z6AftsXr1mU3u6cJt9skLqlOKqztsSLF+uQCLMAapJI7v7ZFDOPDJWIudzs0OPRwGaXYcGeG4AGLJd2e6AWs/53VwoQmeCTb465HmSugxBlukp+DCccKvXJcX0HNiMfxC+brxSEZNKaEsYguAKoBBRCN/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66556008)(66476007)(5660300002)(53546011)(956004)(31696002)(66946007)(2906002)(83380400001)(36756003)(38350700002)(110136005)(8936002)(8676002)(16576012)(38100700002)(31686004)(186003)(2616005)(6486002)(4326008)(316002)(26005)(52116002)(44832011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhMaHM2c0FxQUt5T3RGeWVEV0hhZTJJdEdLNEtDZVllaGoxQW1qQnU5U1pY?=
 =?utf-8?B?Nnc1dlNPUm5EcEVoSjRvOXJrZmZRcDg5dHpyVmZTNjBaK3JvUkxzOVkvWWhp?=
 =?utf-8?B?Z2hLNjBzcHo1UWFSMkdzQkZuRzcrYnRvbUp3VEkzYTNhaTFMcXBNOGZTWElW?=
 =?utf-8?B?eGw5U0pzK0gyVnluK2NKU3RkWkdiZTYzU3BXNWV0bjhsZ1JMa1NCWDY3amVi?=
 =?utf-8?B?aGFyZzJZTi9KVzRyYnZjTi9UeGlRVEdDcUpRN3cwU0FoalIxZU9tWXNPWk5q?=
 =?utf-8?B?dFU2cHRrcVVKc1ZyakpMN1o3RmQxaXJMbmV2R1p3UUlMcWd5aWpnN21ISWNP?=
 =?utf-8?B?MWpHQWhJYzM4Y29qUVRLNFVyMmljZkRZeGZRcDI3R2pjZ1E4dS90TzhORFVt?=
 =?utf-8?B?V2l6a1FJZmtKaGtxTURocHFtS0NzR1NyUjJWR20wZjQ2VGVYR1NwdW9yd0tE?=
 =?utf-8?B?a3U0ZjVBY0J4b1psSTZvVThyb0FVTmpvQlJSdFowblp5OGhTQ3BndkJvL2Qy?=
 =?utf-8?B?aEdIQzUrUDRNalJ1UzFhcFJMK2k5UkY4REhweXNwcStNcTVKZHVzaTlFL3Qz?=
 =?utf-8?B?YVhiMVFlYnVER2JramwrQnVGVzQvdjU3Nmk5d2tRWUk3Q2xKSWErWVlkanJy?=
 =?utf-8?B?Q1ZRRGliZWw3RmpQbzIyNm10WnRqaGNmSFkyRUs3Umtab2RDekUwaHNVRkd6?=
 =?utf-8?B?MDZuQTlrZHcyRlE0RDl0c0FoK0hSRUxQNlJSN2JNKzAzeUE0YkJUWWlDZ1BP?=
 =?utf-8?B?SGpPeXhETHdDcEQ5Q0xmL2dzUnlMNFdXL29DMGErTzVUcmFLa1B0WEJtdjF0?=
 =?utf-8?B?UlkxL0lBZ1FZRDJNWG9McG9kTklwMVNVUUQvc3pIOEx5WDZEK2pHYm5TczRO?=
 =?utf-8?B?T0c4aUZiSTlTYWFEbXFoWHl1N1FBd0pFcml5RVhwM0pCSlo1NmxQMFA5NGFF?=
 =?utf-8?B?Y2dON1FjWnFhektRK0MzWUZ6ZXY3TDB2aXI3VGJ3VGp2eWp5MkJUWjNwMzM1?=
 =?utf-8?B?VHF3Y3Z4TnMycjcvc1g4K1NsdEhCTlkxemFkVVZIbFhZOUhSSkQwQzRidXRr?=
 =?utf-8?B?V1pWaWViakVVaXBwVmVBY3h2RjVXL2NaVHJScUs3aHZvajJZK0dqQytNY1Fj?=
 =?utf-8?B?alZmNHpxN09taWFwZjZMTkRXZEZIay9scnIwYXJmWTArSUh6cHlVNUxsL2tR?=
 =?utf-8?B?RVpEeXFtY2E5ZVlGaE5SQ0pITzJ0dG50M0pPWW1FcGN6cUY5RHcyZlo1cVU5?=
 =?utf-8?B?RUtGZGRlZXFsZFpobFc5dFBiVFR4dUVXcWk2WU1xb3BOeW1qNDdHR0lEY0NH?=
 =?utf-8?B?VlordzNHbnU5eTZobWJzSmk4QmVCRkh0YXZPaEx3eEx3ekdWRWZWajFUZ01V?=
 =?utf-8?B?cTNuNzYyNStVcU1oaDYxSUUzSzkvTnlnUnV0QzFLUUhFRHZkUmloVldZdWdG?=
 =?utf-8?B?aGJUV1Y2WmxWYncvak5EWTNkK2xpbHlRT3k0UG5zb05tQXVLYUF6bzdDVWpp?=
 =?utf-8?B?b24xL25QUWhZNlU1N0RtQk15cHFvTnNMQ2pYMkszdjBOUWlMSjI5cFdKVlZW?=
 =?utf-8?B?VmRqc0ZmNlBBSGllbGwydkFHSGxna0JYNFJFNmdKVTRrc1FHLzkrcnFQTHJO?=
 =?utf-8?B?ZTVUK29JaDRBb21QQ2ZydytlU3RmOHBRMyt6SDBpY3BmTk8vckl4YXkyOXhz?=
 =?utf-8?B?VWx1NC8rZFRLZWRoUlN5bWNFeGZZditNNWJPZFdFd210ODNwMEZMTlZmbFpO?=
 =?utf-8?B?VHRueWluRFFuQkhaR3UxTUdVbEhhcXpTUThjeFFjT1ljLzJwU09TU2RNdkh2?=
 =?utf-8?B?b29qTmNsVXdXSGFITnpUdlhsakd3WDRlbWFSS25rZW1MOVBHU0pGRTQ1T3JM?=
 =?utf-8?B?bFNFWW00ZWlZcG9OMW1XckpCYWpQVmhQdWFvY2tVZmgzbWdCL0VYVnkyenln?=
 =?utf-8?B?cjQyZzFpUTJhdTlsZ3ZkaVVhdzRXV2h3dmpzdzJNY096N0pvZ3ZFYmZiaUdm?=
 =?utf-8?B?TDhKVHJOUndvUDJFRW5uTmN4RURaU3NYUzJUbWhVSXl0bUhkZll0M1VJS2FC?=
 =?utf-8?B?Njc1Z1FNSGR5NmhCSzlQb2Z2VlRreVorbHlLR01MMnZIM2llQ1N4UTRhWVJn?=
 =?utf-8?B?Rm90QUdGaURmdkpoL2ExV1VHK3ZVaFhsc2pFYzN5azU2eXB5alE4Z3ZuY0J1?=
 =?utf-8?Q?3pyT28Y8rU1BOPY3OcXyzTc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b978ad6-7976-4571-eff0-08d9aeb6f5f0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 19:25:08.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZSiQ2O8H+8yjQ0g/IHA7z8JaQmRNaoOvVzQallgs8J91WNYacDF1vmYpCcbUlGNzDsC4vDqvk+YogfmpMuE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230094
X-Proofpoint-GUID: VWtvZkyiOgio9PsKqpGzGZLQSgWn-1II
X-Proofpoint-ORIG-GUID: VWtvZkyiOgio9PsKqpGzGZLQSgWn-1II
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 22:03, Baolin Wang wrote:
> 
> 
> On 2021/11/16 12:21, Andrew Morton wrote:
>> On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>>> Correct the migration stats for hugetlb with using compound_nr() instead
>>> of thp_nr_pages(),
>>
>> It would be helpful to explain why using thp_nr_pages() was wrong.
> 
> Sure. Using thp_nr_pages() to get the number of subpages for a hugetlb is incorrect, since the number of subpages in te hugetlb is not always HPAGE_PMD_NR.
> 

Correct.  However, prior to this patch the return value from thp_nr_pages
was never used for hugetlb pages; only THP.  So, this really did not have any
bad side effects prior to this patch that I can see.

>> And to explain the end user visible effects of this bug so we can
> 
> Actually not also user visible effect, but also hugetlb migration stats in kernel are incorrect. For he end user visible effects, like I described in patch 1,  the syscall move_pages() can return a non-migrated number larger than the number of pages the users tried to migrate, when a THP page is failed to migrate. This is confusing for users.
> 

It looks like hugetlb pages were never taken into account when originally
defining the migration stats.  In the documentation (page_migration.rst) it
only talks about Normal and THP pages.  It does not mention how hugetlb pages
are counted.

Currently, hugetlb pages count as 'a single page' in the stats
PGMIGRATE_SUCCESS/FAIL.  Correct?  After this change we will increment these
stats by the number of sub-pages.  Correct?

I 'think' this is OK since the behavior is not really defined today.  But, we
are changing user visible output.

Perhaps we should go ahead and document the hugetlb behavior when making these
changes?
-- 
Mike Kravetz
