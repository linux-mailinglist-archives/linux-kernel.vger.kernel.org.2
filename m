Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195E35793A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 02:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhDHA6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 20:58:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDHA6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 20:58:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1380ttWe048513;
        Thu, 8 Apr 2021 00:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=03nJ9I6aRepIPoFRfeQs31t+c8ce2PlG8jI7eN+aKKI=;
 b=U2w2kcvFzG8nI1OuXQA6ieEh9ZuK9oUiW4Px/AORoMrvFWGHkhXND1fjkXYPnidz8Grk
 8MD4fuOClmjFEMQjCj+U6NjOpnbvpK2KJi+g8FWbwg3X0RaZCBTDjJyjQmQrlgLqLXag
 3VTD4pDjrg3S0evdP2R8dg2jK3uJPKxLUyIR8KpE8UlUqeTth1OYpt9H4/TOqka5w2Hd
 DS+IDfLhq4KUKcgWMZuRly2P4GFxHQnF8bf5xF6HZddXFH0VQUT2JbozrUiuVcac3jmy
 pXbtMp/odaUeMmdOQw/SdGtpMjiM2PmQTvaw+eIF/MAlyD5uVIGeRz16JdvDIMe8VAwc xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvagc9nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 00:57:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1380tNEe067702;
        Thu, 8 Apr 2021 00:57:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 37rvb4p6pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 00:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey2hC0a7+VH6vrwoW/LL5MrDMLHTyY2yEsuf5rduYc/XPftQUQwQdDOI3otaTHHmYAb2k1dn3iok50mfu5xZhalMubbdvU86rOitQO8a2Yqm6BG6QA0RS6G7/fG5PcMWbgNrGz+122QZah4fydranvh6k6XmkIm02zsxB170uaeorP0mpDyRrnFFfHlXjxbFJMhPKEBpiNBWbAGMuds2vEWobFk+o4YrDMxeNDBo4+y4A47hD7geS0JZK3yAz6f82dHYyMx9jCK6LIkbH7VsLdFPXZuJbWm2mQgn5bouhecbNMdpZVAalM6/EPpYDHeA93YPHfcMvHNsxHAK9ZfsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03nJ9I6aRepIPoFRfeQs31t+c8ce2PlG8jI7eN+aKKI=;
 b=UaqKB7ADnBngLRK3pceebQMjaE2XYDhRcYJjtRqQTKMEOAFL6IqVm/BabxzsokIC5QWlThfKD3fTO4ClCdjow6SrMqgzp1vWvYNUmh1R7uWyXI5tvFEBlCGYRc0KY9jcV71FBs5AA43suA6bbAX5BJN84Rc/K6u/SqoR+627R+yN4nK/0UvEVAPxNTyCE2XBc6uqqpcR4NN7YGzkknhXdZSoYZ7/qNB8hyd6KyeJ7/mMUC0PFRnrOnJYFaM7ok9q6vGVeeDJyvtdSoO9DhsGvibuzxSfyf+/g05DBTwCvFtU7RwHPJQzqFBhYHH97DRACYw9XzePTREMh60B/gLSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03nJ9I6aRepIPoFRfeQs31t+c8ce2PlG8jI7eN+aKKI=;
 b=pjQ8SFQBEdJGuIvmUP8Ku8k7aWP7r3lODrQpsPs9FIuwvogZVhBwN8OdGmU8OXGnGM7loLtJq4ftQtuvakNMf0MRcDyCVNUlANEpdFAUBQeYklpW6Rzz4O26AwDsA04wIAyWeO1EnO0XKsZ02bf+pgj5ao+/wzwZnyHWnMkMeZo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2856.namprd10.prod.outlook.com (2603:10b6:a03:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 00:57:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 00:56:59 +0000
Subject: Re: [PATCH v4 0/8] make hugetlb put_page safe for all calling
 contexts
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <01d8785f-efeb-553d-f075-6501c621ae20@oracle.com>
Date:   Wed, 7 Apr 2021 17:56:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210405230043.182734-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 00:56:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb3f8b9-300d-4411-6d01-08d8fa2936d0
X-MS-TrafficTypeDiagnostic: BYAPR10MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2856E977B9E3C2DA78ACA010E2749@BYAPR10MB2856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EDAWFZgrreUIQ4PnYxCSDka/5ox9jJzxCaH/yYqniIz/raAlKKlAaCIzqRZQ3h0WniARQEdOYru3xkSXs0mk1JRuYBQiYXeQ44qDK+XNwi0H3SFVWBN3AMZP/cbXbSVJ2e7xiQvBbmTQGFERgwmAUDwZ/HBrQ/IJZEwiav2J/DQF2Z1JPzNps9AXR3Z04+g83vC6gQ55/rc2TlNxLMFJ+NA5WM8b6I6IXimObP8a5xdl/vxgzlrMa2HZkjkddtEJQsUgqk2CmlyoCIz3gKrOGtz0sCGUzkRavy8f8iHf0xcAt7eHjkBmUOBaUPXC8eVyZF62N+GLIutmbraYj6wTzrjvdkaKi8eUTsUwSVqgBU3LXjnkeuwlGNc7f62DV1jHfbfya0acwtgqIFvUSgSkSUasO4AelJri0BXQJGIt/qGRnCD4GM2/OIzar5dmBa8AGPGYpay2d6pQ5l692HQjBN7TgA6c/ccsIwmhjAruhh3+SBsBuQsItRn60J29IdzomkSbjPvZ3fkn8EVWFqR7wfctplgbKiMSOO0+vGHpgZQwH0BgpHBeXYal8pG8CMFFo+BFX374I00bsDuvxX5VFwVzu3UCl8ir+3sBtMAvWS9D0Z2ZxRJULoI/E7xCH+ihhPB13sxB3RtWcoV0DUVF8NKRf6G39G1DgIPKn0WQ0lel4k+ctvmmCKVY2LeMqpjKT0RPiiHHlAfLgadUSGkZmnXcHiZkRz/KKBVRMq3ioG8FdSca1GALXPpfHVP13CC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(6666004)(38350700001)(5660300002)(316002)(6486002)(7416002)(52116002)(83380400001)(16526019)(16576012)(2616005)(186003)(86362001)(54906003)(110136005)(956004)(478600001)(8676002)(4326008)(66476007)(26005)(36756003)(38100700001)(31696002)(66556008)(31686004)(2906002)(8936002)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUpzMllTTnJObDR6SjhuclRjdHB6VU5JOS9VQkprQjI1ZnhaZ2xzcDhnRGts?=
 =?utf-8?B?LzZwcGVUdUFrRFplSmU3ZWhSTWEySkhSbmhRdjF3QW56MDFheXN5cURQVzdr?=
 =?utf-8?B?WVo1Z1lwd0FJbzdZQ3ZYQVRnaVMrTWxQUlc5eEF5QkFyVjMwNFdzWTVDeHpw?=
 =?utf-8?B?bk9HRGZoeTJTejFaNjh6NjJOTnk1QTZhYXJZbzdYYWN4cnJnZmZXUXVrdXdi?=
 =?utf-8?B?Q1ovcFBFcVo1TVRZTXV6WEtrVEJaOTFoWXBSc0xLVWt5V2VnOEg1OXJYczBl?=
 =?utf-8?B?TmxQS0ZKaXFNRkJnd3AzbXlTLzcvWmNNNHZyZllPdG9HTGNhRllxdEdFaGRG?=
 =?utf-8?B?bnZlYUxqS0NRTGxKOWJGaEtIdVg0NFE2eHl6eHE4TFI5dVJXK1ZUSVR2SnJK?=
 =?utf-8?B?NzhXcEdLN0xIUXFUdndjVjBiWGpLdVcyZ3N6dFpseU80YnBLaldmaEtGUUlh?=
 =?utf-8?B?aDBFTUNVb1ZBdUpKY3lCKzdtRVpIcStsMnkxVnAzcWhvVUVvOHplLzVpaG1D?=
 =?utf-8?B?TVZwcG9wbEF0ZWFUWm5oK1FwN3orbnVXK1VYaVh0UjBqdWQ2RG1jNWNUL0Jy?=
 =?utf-8?B?cy9FK0h6TEdWQStnN0JiSytXdzI1OWtvVFhmRVRXNUlsWGRYSTZ0ckVodUpo?=
 =?utf-8?B?eU42Y3RNS3RuRzFsK3pIN01oQ084WUtaYkI1WTFxejlkY3lZemNJZXZESWVv?=
 =?utf-8?B?V3ZRKzlVSi9Pajd6RGFXZ3g2WmgzTnJzZGlVZVlremFhdE1KLzU5cmdmZEdV?=
 =?utf-8?B?eTZsZGEzSkFkUFlleENaL2ZiNm5BY295Vk9SelBKU3Y1OTNWQVhUUm5DcUtm?=
 =?utf-8?B?VzRJZC9jYWtVSE5iOUlrS1lTWHRQcDRtb3hsRmVRWkNCRytJSFU4YWdJc1pZ?=
 =?utf-8?B?Y1RXZU1pSzN1TUJva0szL2hzSk5hTEluS2xmd0c5VC9xbGozcnQzN0tPcWRX?=
 =?utf-8?B?eDR6QnpUY1h6bmRxeHhMek9va2YxcUJYdWdrcmVzcTNRTENVU3F6cWhiaEtU?=
 =?utf-8?B?SEpzMk9GOXc5RlRaM0dmNkc0OWJSM21FVm5UakIzVEY1eW43S0VuK01IMXVK?=
 =?utf-8?B?OUErdzhkKzNtdUh0eC9IeDA2Y3IzRWRiOFMrWm9pQ3JkUGF0RmZuMjdtKzRB?=
 =?utf-8?B?dWRjRXR5MWtYeGx1NmJjVlV5RzZGcDhQMHMydHc4NkJzeCtmUHYvYkJzcDVQ?=
 =?utf-8?B?WDlBTVlCTnU1dFZ5cHpFbGRkRWlOQjJ3VHRqZWxXV1dtYlJiTWpzUGZaZjRK?=
 =?utf-8?B?WmVDRnVjZDFLbVU4anNISmh3UUJHdGlXZmNKZDRya21DL0NVR0h0OC9XVXIr?=
 =?utf-8?B?RzNFV1ZvNVp6VnZQZTdwZmlvK3puL1NmMkkwY2FacFpwY3VFa2FVc0hGOGVq?=
 =?utf-8?B?bStrYjZOUlhCYXNKRExSdk1RWHo2Z1p4a2FRTnczK1F4ejVaTHZJMVZhRU9X?=
 =?utf-8?B?RDNMOXRudks5NzFHVnRPVWw0RDBTZzdXODlha1VoLzNsYnhVYzNVRmRXRE1N?=
 =?utf-8?B?L2oza1lpOUEvUWQ2MVdkQzBhVmhYU2NkdkRhTDFQN3ViUE1ubHRxWHMvTE5i?=
 =?utf-8?B?OUtuT0ZFK2dPQVJmdW84QWk1VTh6Z2g3ZUpTbEkxYmpVaFBpcWs0SXZWV2xS?=
 =?utf-8?B?YzlvcDA5Qy9hekdiejFRd3ZTNk1Qd2JZa2V2RGEvUU1yK2xILzBxc3J1TU5l?=
 =?utf-8?B?YmczcWZDODZiVXY4Q1pRMTBOZ0I4N05HY3hOZmFxVmtOa3J4VllNa3J1UW92?=
 =?utf-8?Q?nnyPjFZ3dWAKj33DGBsGsVOiMkAv4UVk4H1ZDrk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb3f8b9-300d-4411-6d01-08d8fa2936d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 00:56:59.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZbAZfoFWZNM8MZf1Q/xRbES9LAhFUjGAfeNouXhc3Y3YpyN3RNcqXmbqY48HA7J+u82NLa+SwBCtT2BH5CB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2856
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080001
X-Proofpoint-GUID: u3AqC2cz3NLrlXGE5xFKnaR9AGtoAvvI
X-Proofpoint-ORIG-GUID: u3AqC2cz3NLrlXGE5xFKnaR9AGtoAvvI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

It has been suggested that this series be included before Oscar Salvador's
series "Make alloc_contig_range handle Hugetlb pages".  At a logical
level, here is what I think needs to happen.  However, I am not sure how
you do tree management and I am open to anything you suggest.  Please do
not start until we get an Ack from Oscar as he will need to participate.

Remove patches for this series in your tree from Mike Kravetz:
- hugetlb: add lockdep_assert_held() calls for hugetlb_lock
- hugetlb: fix irq locking omissions
- hugetlb: make free_huge_page irq safe
- hugetlb: change free_pool_huge_page to remove_pool_huge_page
- hugetlb: call update_and_free_page without hugetlb_lock
- hugetlb: create remove_hugetlb_page() to separate functionality
  /*
   * Technically, the following patches do not need to be removed as
   * they do not interact with Oscar's changes.  However, they do
   * contain 'cover letter comments' in the commit messages which may
   * not make sense out of context.
   */
- hugetlb: add per-hstate mutex to synchronize user adjustment
- hugetlb: no need to drop hugetlb_lock to call cma_release
- mm/cma: change cma mutex to irq safe spinlock

Remove patches for the series "Make alloc_contig_range handle Hugetlb pages"
from Oscar Salvador.
- mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig
- mm: make alloc_contig_range handle in-use hugetlb pages
- mm: make alloc_contig_range handle free hugetlb pages
  /*
   * Technically, the following patches do not need to be removed as
   * they do not interact with Mike's changes.  Again, they do
   * contain 'cover letter comments' in the commit messages which may
   * not make sense out of context.
   */
- mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes-fix
- mm,compaction: let isolate_migratepages_{range,block} return error codes
- mm,page_alloc: bail out earlier on -ENOMEM in alloc_contig_migrate_range

After removing patches above, Mike will provide updated versions of:
/* If removed above */
- mm/cma: change cma mutex to irq safe spinlock
- hugetlb: no need to drop hugetlb_lock to call cma_release
- hugetlb: add per-hstate mutex to synchronize user adjustment
/* end of If removed above */
- hugetlb: create remove_hugetlb_page() to separate functionality
- hugetlb: call update_and_free_page without hugetlb_lock
- hugetlb: change free_pool_huge_page to remove_pool_huge_page
- hugetlb: make free_huge_page irq safe
- hugetlb: add lockdep_assert_held() calls for hugetlb_lock

With these patches in place, Oscar will provide updated versions of:
/* If removed above */
- mm,page_alloc: bail out earlier on -ENOMEM in alloc_contig_migrate_range
- mm,compaction: let isolate_migratepages_{range,block} return error codes
/* end of If removed above */
- mm: make alloc_contig_range handle free hugetlb pages
- mm: make alloc_contig_range handle in-use hugetlb pages
- mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig

Sorry that things ended up in their current state as it will cause more
work for you.
-- 
Mike Kravetz
