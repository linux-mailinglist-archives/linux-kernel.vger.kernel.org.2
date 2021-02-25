Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D131325A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBYXGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:06:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49062 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBYXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:06:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PN4ZNW011482;
        Thu, 25 Feb 2021 23:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T2FzzfaZdiUFO//vK9El6mAJ7RZNxSOPoML+VKcTqAM=;
 b=wiAyv0aup19X0PKcUi69foAm//mnZdsVCAR6l/JkPUDO1iqUf8Iy4acfs4Lrh+MMzXOX
 uwPdmv3vzeT0RGs3aimdWduwzOfKQwrkEH8Xx/L9mnzbpBuuAAEdCcYblg0+st2wyF0A
 hoB/eU7jXoClj21UtHAYaqoC/8dvGN4fVf55qQUwADYoG+EsI1zg1dzN/cv73emcBbs9
 X7UxsnFM+bvWBLQlbw2UXIH8D6PhcWtEzSDNKy24jed57bqPdOQ7g45E1hYTcsC/ipgH
 BzNiQJFkW2lzsMLJjFtkfIoaTqGcx/enf4JzBN1CnVD0KIguLqvYFmQwAoUnJEUInljp VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36ugq3q398-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 23:05:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PN4cFG113244;
        Thu, 25 Feb 2021 23:05:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 36ucc1v2xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 23:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP8M8BlgGjeUQVJUotuyZzqgZPsIE0o44fhNnhLNe8whcZ9yJ0yj6AKEm+Qrz6EAgug8tCNHmWKOb8RLH1Uo+fl2bVPSerwctoW/Y6Y0Gi85NoRJkUzrCT0rND3hDDtJ6axEeLBtXGT/hx1ZkNFTs2tKJGYNlb2DWzwxOmWe/lz5jjhzXaWve5B/+nJoDtXK0od6MyT5Axpi6aQWEZCY2ZIm2M5bxvfS4RHxUmYSkxaPqtecqsTb16HL4HYstMQJNL7qH8dDzbFWoiiDY+69NkSxXJco4Py5+tfZaipBeCBXGnjcYtzmET8HkE1nXXWV3wcwTX+bGdQa171Akau0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2FzzfaZdiUFO//vK9El6mAJ7RZNxSOPoML+VKcTqAM=;
 b=V9Gy9FHQ2kldvq0tqQDpIL2bxZlV7+5363gWdy4Z+zkR7v2JxU3ifZN/hcZcsNXUcC/SsOK1bXUYBNw8sAGk4u0Gq2pqY2alTbX1WCeJf7XvIJOnadvu/PcOqjIjvpCckVyIn96qdotOnu1tElJENP1mwM4Mi8AVL9utjb6UnoEui1aPdIb9EvFeB3Bd2iiQ5w+5LqpYNdiZQgAwgeUQqcg0b4G92B8Mkz65XO9b7bDEQWoYRT02sp0RlkY+5jO0A3gE3EbXpn8zounVJ8+qUShiKZ/vMz5CX5F+QCwJ1JDt5vbWgEI78u4mkhxANfZV9VLX3p1u7nAHP4H/R6VA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2FzzfaZdiUFO//vK9El6mAJ7RZNxSOPoML+VKcTqAM=;
 b=kNu/UUZiMc87mQq8ot7uDzdFFucSSpzRDe27+B10EUUqLI7AS4peZHiJMGqDOnOaBkHy9gzvcl5wHSHsruEzNRGy11xnvNvusSK8CQaIdHr2eU+9N+qd+uf68ACY4LwWhCrfl/2y8pHXuTr0uSVWWM5n3RveY1yaxrqt9WBYf1w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3640.namprd10.prod.outlook.com (2603:10b6:a03:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 23:05:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 23:05:17 +0000
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f179cd81-5c8f-7b98-2ebc-c93da5a60ee2@oracle.com>
Date:   Thu, 25 Feb 2021 15:05:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210222135137.25717-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:300:ee::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0044.namprd04.prod.outlook.com (2603:10b6:300:ee::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 23:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616ffb4b-0bec-4836-715d-08d8d9e1d10b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3640:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3640CD82E32D6EB511933BA1E29E9@BYAPR10MB3640.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO1bKyQjo8uOmPRFPct5DkUAKa9MqLL1a/wZG3o5sapU+0IHIhi7/v0kHvv5/1N7+Utw405arfVNf/EjTg1UrM9EYilRgX8JoN69Ypwu09jIxeaMCbC+GTnUeyv3Hn3YCQutXWu5osdFhhFV971uabdwBgVmjyga9d0lmhCwzMANHffqQuz1SlcvBoqIkAlJ4wBwnChS6NNAtRXZkU3pNjHk4og1BVva+DT6gdV9JNCTURvsLj0SX+EH8Fet4OWfeOB9/a2Od+dkH2MYvZ0PCV4xhDahl6XDbenoxcc2DNLAUJ8nLtBOFu+K6RgZji1chg+pNWUyfxkSBZFOKDFv8UekOfc8Iq23adGsjrMof+EFI+z377qQ05COi8g/SSNSDA6vh4W4XUTg0EWsQ0R8XbS5+BpdiUcmtOl+DrVvIQF2Mq3MJQHN99HeAB0Ybu1+QDP7MuWGwbpivdUa4tKZoNWX39llqGzMehOvf6vuZVjIFF0cXUT7Xt+W6yvhnfS0tg0IEGE/MNy9lbPqV4997/+lSerTbtN1S5CDJq2gVE667QPQQe1Xkbepj6oZzuKdYu1BNjYONNaE4GhwqhRhMICPPE/bs/ZJKoWchYIryTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(316002)(53546011)(52116002)(110136005)(54906003)(4744005)(5660300002)(36756003)(4326008)(8676002)(83380400001)(31696002)(478600001)(6486002)(86362001)(44832011)(956004)(31686004)(2906002)(26005)(8936002)(66476007)(66556008)(186003)(16526019)(2616005)(16576012)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0Z0S1owYVlKVmhRQ1FjSmxNcm1zWFF2bjZvdWQwaHVHRlR3QnR4dVphUTZQ?=
 =?utf-8?B?VnR6SnU5LzlCZDV0ZHR2cGVDaEc4ZldyK1NNaFEvcVdpKzYrUGFRbXR5dkU5?=
 =?utf-8?B?UjUxdDkyM3VUODRLM3hJcXV2SDRVWnhhb1YvVzNDWDR6aWhVNUVyV1loYldn?=
 =?utf-8?B?S29NNlcvZEVCT3FGVEI5aElTTHc0dUN1aVNqRFpUWVI2Q1FDdmkwd1dCNi9B?=
 =?utf-8?B?ZEljWnJRamJxWVRyenVxZVQ4aFdSWHBjRkw1UDBZMVd6M1lOV0RNTS9ZSnJU?=
 =?utf-8?B?TjZMYlJJWE5DSXI3ZUczMmZwMFZMYlM0UXd2NkxBbCtxblpuOGx0eEUrMWJD?=
 =?utf-8?B?OFNsSnV6Mm1EVm8vTllQQk82T1RKQUZqSThJQVluRm1DVlgvajl5Z2tzTVVp?=
 =?utf-8?B?MGcyTVlvakdiSHhDY3FaYlo2ekEwV3Q4dWRLRmM1NUNXM00rYWNvWXFvRWlz?=
 =?utf-8?B?QWsxNFlJYUFzOG9QL3R4aCs4TXdUN1NLMHR3VGlDTWFNVXZkZEp4RkxSODJZ?=
 =?utf-8?B?dTdLekFoVEh6TWZkY3FVc2M5bk1uQTRYRUEwMGh4YTJvdE5hRzZZSWpTZFEx?=
 =?utf-8?B?cTEzS2l6K090ZzQ1bW1weE40MUN2cEpyRDdHdFIwRHVRb0dMNlZDNityblhL?=
 =?utf-8?B?YTJkOTNUQllqaTd4cWZ6SEIvU1o5U1Q2eFZteU0zdS9TaDFzbnNtVE9XWnJu?=
 =?utf-8?B?WFduTlViYWc3cTBkc3V0OElTeVhGMFR6RWJoMlFLZHpsTVIzc3FxSmdpNWxF?=
 =?utf-8?B?ZzR3aHo0RTgwVWsxODBlNmNXaTRQak50ak8yMXFRR1N2aXlDQmNiakUwbTgv?=
 =?utf-8?B?aTExeHpIalVtVlQ1cnhPeWVXeEorTzNKWm1UMUxKZEI1bGhjRjhjTWRIOHRW?=
 =?utf-8?B?UXJrWUZTOEhuenZwVUNNQWJXQytvbHV1VGdCL2t4SThGOHFKalpuQmF6dkdO?=
 =?utf-8?B?UHZ6dVU0RktiSWxCZ0NZVGpkV0FxT1o3S1l2NE8ybFR4M0tGdkIwVjRtN1J1?=
 =?utf-8?B?K0xzVTRoaWNIMWZtNzJBS3RlMDVnS3BzMDBFb1FTRStKazZEb3I2LzBZL2kx?=
 =?utf-8?B?d2M4TVlPVThDamdleWNVNi9obm9NNGFYTEkxc04rR1RaWVljYVAzRU8zckww?=
 =?utf-8?B?bHlKaFJUM1dEdHE0ekZ1SFhRRWUzaEl3ckZIQmYyNUE0WFBaZ0ZFZDZEN2VU?=
 =?utf-8?B?b3FJcUI5SUUyTlM3L05Edk1qWnRQcFBkOVRKVnFjSE55SThGb2VuNDEreFl1?=
 =?utf-8?B?MVVqZlhVSmdyTjBrV1hpWXNpVEN1V1pPbEQxRGtDRyswYktXZmNKV0lxb2pw?=
 =?utf-8?B?dGFCRnhuZHUrWkk5VEhQdFZZVlIwWWNZV1I5Y1o3N0VRcjRRN2ZDejZuMjhC?=
 =?utf-8?B?Ymp5R20yRS94Yi9adnJDNHcwa0F3L1Q1NHY5TVVXdVpKejI0T1UrRzFVYnh6?=
 =?utf-8?B?TlBnS3Vtdk1uUzlzZlc4ZlZhVjNDTnBHTEFMSDhtczdmZEF4SlZ4WmovTEln?=
 =?utf-8?B?UW1WZDFmNEYzRS8yMzRGOXREL0FGcmdLZThaRnVRL1haTUxBMW41K3BTbzY0?=
 =?utf-8?B?bDlMbnA4Q0paVzhoRjBmK01WdncvN2haWU4vNGszSFJIOWFjY2VCS3ByMitQ?=
 =?utf-8?B?RU5pTmRHdzdLdzhRMXJjZmVaQjQ5SDErVzM3NnEzSndIbzhMK29Pck1pemFp?=
 =?utf-8?B?c3ExdEw0dXI0THlvNis2SzFlRWp5ajd5eFdrVkVYRUMwSVlya2Z2UFByVWkr?=
 =?utf-8?Q?keRhAr2g091zaXPA6i+x0fz/NPfxLCwr8Z0Z2RW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616ffb4b-0bec-4836-715d-08d8d9e1d10b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 23:05:17.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfp4S7ZR+No1cQBipL53+SrKTlwbbhiG0xH7ZO2YW/Va+QOlbJHyYhr3p0mV2Ra6/FfDkuy2tB4yh/4g2oWmlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3640
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250175
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 5:51 AM, Oscar Salvador wrote:
> alloc_contig_range() will fail if it finds a HugeTLB page within the range,
> without a chance to handle them. Since HugeTLB pages can be migrated as any
> LRU or Movable page, it does not make sense to bail out without trying.
> Enable the interface to recognize in-use HugeTLB pages so we can migrate
> them, and have much better chances to succeed the call.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h |  5 +++--
>  mm/compaction.c         | 12 +++++++++++-
>  mm/hugetlb.c            | 21 +++++++++++++++++----
>  mm/vmscan.c             |  5 +++--
>  4 files changed, 34 insertions(+), 9 deletions(-)

Thanks,

Changes look good.  I like the simple retry one time for pages which may
go from free to in use.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

BTW,
This series will need to be rebased on latest which has hugetlb page flag
changes.  Should be as simple as:
s/PageHugeFreed/HPageFreed/
-- 
Mike Kravetz
