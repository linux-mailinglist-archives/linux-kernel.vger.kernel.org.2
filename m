Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5337B368680
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhDVSXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:23:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4328 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236459AbhDVSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:23:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MICoq8023707;
        Thu, 22 Apr 2021 18:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QIP1GkQszGDoYXhD3XiILhnYAmXLZLlpqiRhoZ6ftpE=;
 b=n+m23H5A1vLvuLNVaHy2av3XijEXUtWxQkvtsjJbd6D7zzEXe4zzOpx/a2g1AJzflVjm
 LhB6/tYalPV2NZVymwR3hQtMw9rb0kc1eN1yyWIMOpAHwn/c7jCzyRxqfx6aE+vzsv5C
 opAjjNN5aKDgwCTPhHFVH81+3GdgUK9Xw3xo+RFKsUvxcNje1PieUOvKPI4wxhFNHio0
 UQcYNjc/ZdwmrjgrkSEAGMOiJ/URFSPxhIYy7FRaWQibVIxNzmdN507SEmCnuB1ldN8w
 VQNafyc1b8EIchZw6hyK3mcsDeJnbgB26yEAdZQ4ST+D3AVK4bdXfZJE4x8CxT2BSVf1 5w== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 382y2q8bb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 18:23:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MIM0pE066782;
        Thu, 22 Apr 2021 18:23:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 383ccendbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 18:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRE3XHZ6mcLyXd8ADYDBg11LxrhATZpWxFgEl3f+kJ+cqHttli1A5rb0fOJ7kMdpIfVDQDZUULXWYdBxe1nZdXxC9QuzE4iKcbEDvoyAqxl+dOgFxi2b0Pt0IpoUIMCRFeo9a37M4IvVpqeSoo1k0I4BVpg/+SwYDj6MhqSoFXLLN6h/fOQY+rpJN3Z1h9ATlK09//gihSi4+V5UWbTORzpQgmAsTpDFJcD9ZT/svs9orIrMHm64Pjq9hSD8SzETen15jBorpWc+yUPGg7iAMkaLdlURHgn2tVT3byduJU7biQH9U+vpGZ8Tt8MxUNfqgVQ+AfzWtXLsMK70ID8ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIP1GkQszGDoYXhD3XiILhnYAmXLZLlpqiRhoZ6ftpE=;
 b=RLlQMzEWFowbt2NWGn8pf+zE5H/rrNkuQOEF9ds7cZNF0jfUjO4qgHM86zPZwICWTiqXQn/F6KRQFJlk+UzNTDoa5fPXy9H1o4fsjKsOITGS8gaUqD1Rm6UUiyTO4kap6QOB7VhpvpIVghL2BleS3R30yVThjOJ7S5Tys2Z7kVKQ080g+f8vpX/SaNOlE91bOLc2ay4ys5IXejhgNnhR99AshTueXlOsFJOLiYRlyZxP1Fz+LHxCxcnI0PXB5tpaUlRAe9MPShKv7UUGf+B9c1N8FL5/zfsarFlRMvpdkWvks1jBz1ZXQ1SZuI5Yn7VJKaYH0nY0O8TrIpXU/pnlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIP1GkQszGDoYXhD3XiILhnYAmXLZLlpqiRhoZ6ftpE=;
 b=p12QX41XGcu9ajMZIuey7inBmPIz0CxXoQ7OQ0dkPyaqdHyYe3YK3GFMKjETeiOt0fw/aB3tS1ILF5xyxx6XTR4KGqpB2fyRgSh56XkWQoAt3xUpg8P+ee3KDtA6CZkoNbFmWQeLwbdho0V3jPoIkccZ4VQIC49FehPem5aIKvE=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3640.namprd10.prod.outlook.com (2603:10b6:a03:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 18:23:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 18:23:00 +0000
Subject: Re: [PATCH 17/23] hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-18-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <35d6d357-df2d-66fb-2885-af5ff35a1aa0@oracle.com>
Date:   Thu, 22 Apr 2021 11:22:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323004912.35132-18-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:303:69::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0022.namprd04.prod.outlook.com (2603:10b6:303:69::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 18:22:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0120dfcf-3c43-4522-b9a2-08d905bba908
X-MS-TrafficTypeDiagnostic: BYAPR10MB3640:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36402923CCAB9E450AA9CCDEE2469@BYAPR10MB3640.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qHGjEZwQsRXO/L/DWWJNqaWpEyQvbdQ/o5Vy/8jiHgSpYG675kT0tBXeqLaErFh7W5QNdZPuTfxwWdTJxSkqfStqoq1ep4HQwy9ofkOZS54giu6gm1wS9Gwdh7id8sF32s8KR6hCm+wa9owJJnrl4Xydyd3ynLhJdt3en1Ki+RhdPkct8kUuVW+yiXVDKZEFZi/xYW/ZdYzyNQlvXblCQK/zmlihk7pRkPDbOhO68tM7A74d2tj+SsN25vFjK2E0Socbwamq7qClBi900u5XjziBoAb3KBsfam86xh6aeHLDjV4hAsKE1EwdYLxAgj+lT1iDyRmL2PopR662wEx/bd0+zk4i+E6EGZPADp90rhI40ke/Zp8onwEKuY4HdFjC3JimEhroDoylEEDl4H80xSaxmwhuCTtAcCNJbn3jU+JOgmRTZXp6qmA5B6YQ3gbeIyDpVONlt3w4Uok38v5Rl5JFjh1/bo8oDuRUd8lKDriNgshTmaNdGBTmMPB52ZjYyRvBl3FU7RkhySp7y/lxYqB848bnp/aFHNPcxY0rQHwxtyJUD6p98NRC6k8kB52Aoz3Xa7jmT/kDStIdqGpBNoWA2bKp2B2QL21m++xODHjgfJdJ68Tr1Y2+LnCMHDudMKs0LuoEJCtN7I8NhplteSTPCYVoNmawR4+8SDV34YFMzwBwINVXnyToS/ASlTYtg1AddScegiCwybtTgK+eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(66476007)(478600001)(66556008)(26005)(7416002)(956004)(2616005)(16576012)(8936002)(316002)(66946007)(38100700002)(44832011)(31686004)(36756003)(86362001)(38350700002)(4326008)(52116002)(186003)(53546011)(54906003)(16526019)(6486002)(2906002)(5660300002)(31696002)(83380400001)(8676002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?citaTWJQUzdYWkRXVkIrakdycGg0OWxhZEZ5Z1JZSGRIelg4bGlOSlNLRWsv?=
 =?utf-8?B?MVh0anhtSXpSQngzeFFLYm1PR3A5NThIWUtRUzU3dnpuRUdrUkJZYTlwY2dK?=
 =?utf-8?B?ZUhER2FEWmllL0tQcGZtdFc1Rk9NTWY1Zm4veUs0dGwxRzZ5SUFxUENyb2NS?=
 =?utf-8?B?NEhIZkVIUzNEU1l3Q1MydkloUG5iVFV2dzB0bFU1M3BPYndzYWVmT3JwVjFH?=
 =?utf-8?B?ZHlwMWhlMWpDazFIUUc1c0lOSGNsalRlOFlNMWR3T2ZjMnJ0azlzZkUwaVhF?=
 =?utf-8?B?Ti9CWkNMdjlSeWMydmtRK3Z1VkpPbUdHNHp2cXBnUWFTSFJGZzlING8xR2tY?=
 =?utf-8?B?V0pWUS8ydjRhUUlBcU5ucXo1ZG5NMHBSbTJvTkM4L08rSTdaTWFYMWNlQWly?=
 =?utf-8?B?dEVCdCs5NlFPb3ZUWjFSUlliZHdSS0piRzA1NjdLbkRSNC9yODlnUnloMHZF?=
 =?utf-8?B?MUJ6RjJDVXc1VjFuRGFYek44OFpCVlBBaWdzdlZYWmpQNHNFM0diWTdVNnZz?=
 =?utf-8?B?eGhGUU5JQ1VVNlNscTdMeFZLNDNtQnBCUlYxVkdVck1Hdk9LN3VZVjBNRG1B?=
 =?utf-8?B?bUdmTGZkYVVOK2FKMjh0a0hOeldYWFVubytjdzJNYUVYaC9rZlM4KzZQUXo4?=
 =?utf-8?B?UlJ4TERxcTBqYncyVC9RbVNQcFJyd1BTMThYUDMwRzNyYXh0QUR3ZUZrUDJl?=
 =?utf-8?B?RmswcXFLSmczdXBad29UQ1V0cHd6dWpUdVUwQ0J1ajgyL0IrNm12NFRzUE1y?=
 =?utf-8?B?eVVzVTFQSTUwWlZTaDh1NnZVTXd6L3U1S3FpdEZZSmowRzdWLzFyMmNnT0Zm?=
 =?utf-8?B?b0tDOTRaY0llS1A5RFdjZjZad1FEaHUzQmpXUTRESmdhSFB4VkcxOFZpdGNw?=
 =?utf-8?B?bExZbUQrMlMwNkZBNXh2ekl0QU4zYm5jS1VXYzhrcDd4NlZHY2pRbk9BWUdL?=
 =?utf-8?B?OVV0Y3JZN3A4aVM3RElsNGdwZWpqNTByY1ByajgxNDgzTlRWa3ErR0kvdDg4?=
 =?utf-8?B?SmtLUVdBU05DTWlKdGFNczFmV3RINDFzNTkxUVJnV0pwUm9yN0JEZU5KMXhu?=
 =?utf-8?B?cXFkOEQxSElaWGQ5WE5PaGVqNytTT21Pd3V1VWpOZzNXc0JVN0hjUmJ5YUNG?=
 =?utf-8?B?bHNKdktsWCt0UWJCcG9MYmVlSld1d0l5YmE0UFdnZE9YKzZpaGMzbVBxV1g4?=
 =?utf-8?B?V2tub0RYcWhSdlF6aktybHM1YkUxUmJvSXd3K2hHbWVLd29MZmtMQXgydU5z?=
 =?utf-8?B?cE0rZTBpZzNTVktBMm5Ga2xpckU4alh5N1p5MjR0TzBSbzZheXgrbHpqMTdJ?=
 =?utf-8?B?RXdVYzNtdHY4UUhISFcvbFpwZlBXblh0anVxWmZKR2ZOMnRUSnQ3LzhTOW5P?=
 =?utf-8?B?UVRueVNWb0ZOSm9EblFSOGpqWWJ0Nnh5ZFhKU1R0L2hlaFhNWDZubnJmeElV?=
 =?utf-8?B?RU5aWWppVVdGNzdNODVPdjZYZkhUUDArbXpXUzJDbk83QVU4QUEyaDU0YVhr?=
 =?utf-8?B?a2laWmhaSGFZS0FKSVNWVjhvK1h3MzNnaE55TEtCVUxtTFpKdkd2QnpDbVlu?=
 =?utf-8?B?ZWtlZ2NKaWtrczdYdHB6UXUzb29aSjR6TExLbGNQdGVIeGUwcFNwY0VSZElR?=
 =?utf-8?B?VXY1SUlQSUZVUEdsNlNtTzhkN2NKOXdUN1R6emFRY2VQdHJYZ1VSOGVoQXlO?=
 =?utf-8?B?dkppb0VVSW82bVNVNTR0bFcwZGVGN25nSWtEeHdXM1hjQUhpdFBxQlg0YTF5?=
 =?utf-8?Q?Ifr/Z8h9QRoHmMJ3tePSftfHiJqispduj3/CjS0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0120dfcf-3c43-4522-b9a2-08d905bba908
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 18:23:00.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od5P3hP1QwN8Z9G8tbBvXNojM4acfB5K/tuYuGcqwP2NheJ818RcgoBv+RN7SBGIBJeTy7abLfeOskyTT0gFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3640
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220137
X-Proofpoint-GUID: bLcfq2OCyM_iNgQTr_z-f7fD_8Z-wqnu
X-Proofpoint-ORIG-GUID: bLcfq2OCyM_iNgQTr_z-f7fD_8Z-wqnu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:49 PM, Peter Xu wrote:
> This starts from passing cp_flags into hugetlb_change_protection() so hugetlb
> will be able to handle MM_CP_UFFD_WP[_RESOLVE] requests.
> 
> huge_pte_clear_uffd_wp() is introduced to handle the case where the
> UFFDIO_WRITEPROTECT is requested upon migrating huge page entries.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/asm-generic/hugetlb.h |  5 +++++
>  include/linux/hugetlb.h       |  6 ++++--
>  mm/hugetlb.c                  | 13 ++++++++++++-
>  mm/mprotect.c                 |  3 ++-
>  mm/userfaultfd.c              |  8 ++++++++
>  5 files changed, 31 insertions(+), 4 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
