Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31F344C78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhCVQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:58:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCVQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:58:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MGtw4V031340;
        Mon, 22 Mar 2021 16:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=o/vAWEbuqz0pDT4xY0f47q2MKzpPpXGjSScgy4g2jiQ=;
 b=kUrCkmbcVocxNm0y+ufhSedIYNfTIEKEGu/8YWS+ra+TrYOuJMc6wsp0I+K2bm8y6RNl
 pMuhHlPa3PgCoUICrIdZbBz9ECx3LnNVdH6VeZelP5WtgXdZOdLiW4eBqGuKRKfNYNgO
 ocVnIeZxcl8Y4AbyspRv+2B62waRyWG7mG7QV9v056mQb3XODT/jd3rw5kkrTxsanLqc
 /Nivy6CDTInUU8RbB+Ui1JUciFNxO9jOE3cNM42ufMPvkCUx++RKkQmqlnrQ2RDvUO9d
 92xoAknlLTo9A7pLmHm+RVzwGJ/mEa++z8tvT9ffJGiTQ2oKclz6iWjFdV5u9CZqDLXi 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37d90mc5gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 16:57:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MGt59C125336;
        Mon, 22 Mar 2021 16:57:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 37dtmnetqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 16:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaVj3uyVRGvc/7wpwA7lqXlH0ZEUWSRF3nhyz6DOYnhaEdwi/44noIuQyhisQNFeGR/hClDB71BB16dz8C3YrmDjNPkGzWd/C6OQ3rxtlqluBJaR67zMPrZjly5o9P2vw4zLwKi4foSN+g992Ui7qmbU8X4i/q9gwno62FniXIsDaU/jh93wgzbmyj4ikNnms8dzl9JTcbc1o0UmRioiGlIxMXG0v+xe6JQqY9HEs5t04UW88LNBuVc5mxfzbikZbd74HFveep6Vi10A1xp8EQvYvfVDOzOiFbHBihhmO4Jid+t7zxL8sr1aTFpNyt/gKdm9t+CZP+XZ3qjB2m5pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/vAWEbuqz0pDT4xY0f47q2MKzpPpXGjSScgy4g2jiQ=;
 b=l0KvKn1rS89VilEQHxg/C0F1EQNcsPxrrUxDaWRNc3TctInI+XGRmwuWdvg8b4D4B7K6Vv8e4UtSpuguVG68cx4TutomSBmW2htQAZu3uUGMfpEzWS9DCrtpoeCbU9a7Vao7tWXMIzlWaEEo5qfAmYGKdZ9OPRnpu/+VsYO97q6tw1VAkLMcW1U+VcoNWzObaoB7aWPOXIpBHHhwB8YdQA0PPn2eOfIoaWGfM+4gTYi/OAj3Fo4T3ZYkG92ebnwDoKjjJaNCByotO0krTcDhq5MLAcwR5DMUK6fnNu5wdiw8yzO/pcMZWsCVEGCl0Naypk9lcknWD/4QKxJ7A+iTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/vAWEbuqz0pDT4xY0f47q2MKzpPpXGjSScgy4g2jiQ=;
 b=a5mKI9iQLMS3mBI3ZDeGm4DmGFs88MH/5EgkJXMz4xElT+hyzp7CY0VotOI3xb6ejJJsWGfvGdbrrnTy1y9qqCtiyVqrEzVpn+ze3896B58ecF0W7b5ObYvLOHdV1nOIRJLVMQ+hrCI814KPVZA8jo0zWQtf+5K0YlpptwMvJzY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 16:57:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 16:57:18 +0000
Subject: Re: [RFC PATCH 1/8] hugetlb: add per-hstate mutex to synchronize user
 adjustments
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
 <20210319224209.150047-2-mike.kravetz@oracle.com>
 <YFiipzEs0wuL/Qdl@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c88f14aa-cff1-a857-e969-fc5d491e8f2d@oracle.com>
Date:   Mon, 22 Mar 2021 09:57:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFiipzEs0wuL/Qdl@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 16:57:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba5a9fb-4a8a-4e94-066c-08d8ed538d2b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4225:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4225786E94CCB24F8F575A81E2659@BY5PR10MB4225.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qbo98PTUzDA36/YjTdNku8nxNZMLmUHe7WNqnIVzyf05PsR1Fg8vLAgUbqASWdiVuAR97zvV/9BJ0nvxHEq+/yb3MsUB3MQxXICk9W/MAfo7FJlUe1pQ6qsovUFYUpnHzBfUzZsL7/KYqQ0mHW1fYQnUt5o0JdSlpPmXPqLbxWZB0UJRjRnQL7uicn0hDtB7friJuV+dlsV85bsMP1epf/FAUuiTQiXpDkA0dw1hyPsBZOyd6TfufYbClDOXTYKAAGTsBojqmbUGxrAlrx0FRMUOSbH3P/OpzYy9tRq+cNEV3NgcC08aY2UNtEWnk3vH7xvKoVB9wZD90ynqZRcpzOtW0elNvNgHNfDyBtGxV2+Py051QheSjEe6WCh4y9jWc/R1BtlnOLfIBX6y1/wNajehdFis/cdywd1I82nGwM1JlKaVCTfFBqRPepHd2ekrW60vmrsXl5AMOz68APNuJYMgVkYHBuFC5zONy/i7kCLhLkkTrtR7ghR02vmGyZhq1VhLqeKWuW9sZXeKdbdenE4rtErehmA9I/EtTbvFpvOwfVFAicPl8nkCH1oVWrw7Are4OXN6TYp8pfRyz5vMMsENIHUYwykLhj+W02tm5Acs8f1Km4pvLI0i0c7pCpQN+n1ediK6o+zo2OiddXvx1kTjUaEfWzKTgx01nqh+lcM6SKwVfK+WVhjJ+ctsg7cEUoROa+lks4b4FR+fzO7+1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(396003)(346002)(136003)(54906003)(316002)(2906002)(4326008)(6666004)(5660300002)(53546011)(6486002)(38100700001)(52116002)(478600001)(16576012)(7416002)(956004)(2616005)(66556008)(16526019)(31696002)(66476007)(36756003)(44832011)(83380400001)(26005)(8936002)(66946007)(186003)(8676002)(86362001)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUV6L0E2M1pwL1ptcmRadkJUSkR5QTRITE9vN0ZjdkQ3NFoxbTN3dnJ5SDlr?=
 =?utf-8?B?d0F1N1hSWTdqOUlVT1VsSmlrNHdGc0ZsNEpRYjdNOU9ZVkhhL2tibjRXRlp3?=
 =?utf-8?B?ZjdJNjVDZkpoUzU4TXVTRXBxN2RieUFKaFV4WUgrUFYxeUljSUJtM05yZlVL?=
 =?utf-8?B?ZDNFSTJnQUhyVFVZTTgxdDdlaFZDWDhDTWRqc0tNQ3V4emNnSzdNcU1ZNXdZ?=
 =?utf-8?B?MWtEd2txQ1ZTL0dWcTFnK1RkSmRvQS9vdEhUK0hBOWlDUXczNVY5bjgzem0y?=
 =?utf-8?B?OHpoSjRNYXhLSG51dHp2ZkQwck1hNzJ3aWlranR6Zm5yc3JqOUpqdS9MWGd5?=
 =?utf-8?B?ZUlpSTVOakdMdjlia004anEzTjBiZUQ4SnpyMXhVS001WWJQSFdSUXNlcGFj?=
 =?utf-8?B?Y0FBd1pndHZtNGwvRmtNbDU3eFRaeVg2UW15ak1BWlJKbnN5WVRFUUJRaGRo?=
 =?utf-8?B?THNIdU5ERFYvMXFWdHpzTjVhbWRJTjI1RkxyZEtLeDI2aWpGMjA0eEUwTjN4?=
 =?utf-8?B?OGtzMGZLcWdyaE9ZU1EwV0RZUWVSNncrVDhmOVZFRk96RzF4ZlpuZE1YTjVL?=
 =?utf-8?B?SlhLRzlNR05tSm5YZDNJUllsdkpNaUQ1aHBxNnBYSFgyM0pxSk10UXE0SkxP?=
 =?utf-8?B?T05FbEczNmdXZGkwU0dUbUlpSHRQb0ptKzg2TnpjRms4RTNDY2FiZEtPSFcw?=
 =?utf-8?B?K1RnR1Q4WFFyN0VUS0p1WnBqUlBBdG90bXVBaFh6ZloyWm1UZHk2UFFBSTV0?=
 =?utf-8?B?ZlphOFJOaHhuQ3ZOaWlIUGtUVGdUM1hSdVFrZ3lib2k5L0w5V0xJOTBrcDc2?=
 =?utf-8?B?MUVwYW95OEdCVy9lMFp2Q0NRc2Ywc3Y4MThIbHlHSnQrQU5hRHBHT0NrdXcx?=
 =?utf-8?B?MFFwWklTV29yWmVLeVJFak5Jc2lYalR4Rk1JRHZ5UXM5S0xsUkR3UlZCdmhi?=
 =?utf-8?B?Y1BCaktnM2tpcjRJL2hCTE9hQW1ob29GMGJoRzJRcVIxRkl1L3ZFaCtwM3lq?=
 =?utf-8?B?b3E2Ynlhd1JwM3kxYTBRZE1ZT0xlS3JzekwvK2pNN096OHByV3V5YWhnemFp?=
 =?utf-8?B?cVlDSFJHK2o3aVJ3UXI5RGVKU1hVaUMvdkFKM21IOGEyRHRGS0QvTEYzcDY4?=
 =?utf-8?B?c2lpU05kbGVSczhZV3hVaUFMcndNOS9RYzVKNzVISFE2ZmowWGdSZ2syWDJO?=
 =?utf-8?B?cmNnbVVxTGxzRWdpY3MySmwyY21UQ3lzUnU2VkVFblh4T1ZQYkJaMklvNGxQ?=
 =?utf-8?B?RHRnQUxjNUVuSHAzS1gvVWdOKzdyT2lTeXpVZWF0RnMrU2svWUd4QmhsOElZ?=
 =?utf-8?B?VWcyT2JvMXNqZmxJR1FjcGhxWU5SK01tY1R2a0VmWnZ1MVdQM0NVSnJMdC9R?=
 =?utf-8?B?YjlHOVV4ZHlIL0UzTmxIS052Um1aQ0g3R0R5N1k2dmFVWXM0VWZjdlB2ODk1?=
 =?utf-8?B?SWoyS1hSQjhjVExDaFQ4QU9kemZZWTFVZjVmbnpNWXlzMDRxUlRlamQrQ1M3?=
 =?utf-8?B?MkU5dUJsZHpOeTM5RWZsc0lERlExcDBFK1RZd3BLQVdWQVBObnhpSlJTdVlx?=
 =?utf-8?B?RW5sTkFwWWdmdWxQV2xWZ2VodS9ubGN3alJ0UXJtTHFpbHlYYXZacWw5ZDBp?=
 =?utf-8?B?Ui8zY1hGT1UzV0NjTkhKSktiRXBJYWE4d0V3MHRNR2o5SkMxemkrcTFraDEx?=
 =?utf-8?B?ZCt3L0wwMytsWkIrRlhhWHZxeE50Yk5jYUxiVVZadkMvcldhZFhlazlUbGp1?=
 =?utf-8?Q?fUKJa+O20zMtnLYUAvqyA8frY4FHBrmmyJx+K7N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba5a9fb-4a8a-4e94-066c-08d8ed538d2b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 16:57:18.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on6qXz8wuSHWL9Lt3v20PiiNwr6+ELtRZl6pYcAiQo74gstgJ8PpFAUvZwz3Y7NuFbMWLa2sgbAiRBin/r6S4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 6:59 AM, Michal Hocko wrote:
> On Fri 19-03-21 15:42:02, Mike Kravetz wrote:
>> The number of hugetlb pages can be adjusted by writing to the
>> sysps/proc files nr_hugepages, nr_hugepages_mempolicy or
>> nr_overcommit_hugepages.  There is nothing to prevent two
>> concurrent modifications via these files.  The underlying routine
>> set_max_huge_pages() makes assumptions that only one occurrence is
>> running at a time.  Specifically, alloc_pool_huge_page uses a
>> hstate specific variable without any synchronization.
> 
> From the above it is not really clear whether the unsynchronized nature
> of set_max_huge_pages is really a problem or a mere annoynce. I suspect
> the later because counters are properly synchronized with the
> hugetlb_lock. It would be great to clarify that.
>  

It is a problem and an annoyance.

The problem is that alloc_pool_huge_page -> for_each_node_mask_to_alloc is
called after dropping the hugetlb lock.  for_each_node_mask_to_alloc
uses the helper hstate_next_node_to_alloc which uses and modifies
h->next_nid_to_alloc.  Worst case would be two instances of set_max_huge_pages
trying to allocate pages on different sets of nodes.  Pages could get
allocated on the wrong nodes.

I really doubt this problem has ever been experienced in practice.
However, when looking at the code in was a real annoyance. :)

I'll update the commit message to be more clear.
-- 
Mike Kravetz
