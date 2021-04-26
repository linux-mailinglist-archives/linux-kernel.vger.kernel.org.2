Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1EA36BBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhDZXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:10:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56586 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDZXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:10:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QN5JKk147177;
        Mon, 26 Apr 2021 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QPR2P28mhFkwg5akqF8mh5kqkphK/VBNzW6nvGwsvyc=;
 b=q0BI+D1EqRNFA6F+ZNRDHiSHxckWOe5eRN+eZAXZIaVwozXDEpb1VWuQUxw0A4V5C1qE
 ntEE5tCxqRoqNiZRWEsGtHsF7tJ9jbiXUm1VSkXEWufpDQ9c0/hdU0gjX7opQajgqUS2
 rcDV7IH7rTII8/NlaqavPq5VmQxvxPYjvj+bjldj09XsWdkbjHzvRt1Z06DpKp6YeU2u
 3MI39Rl8QmIp3HF0n/5MqPIy8TVZPMDOUVdwrQq3+8xoRYwKKc9sIGa42pstKh6R7pnV
 wb8dyF6qksb1K5/BmLv/CkKxUkhkhKdYwLtHJQpL/8eO3oynmCibww2D91zXcvX09dM7 sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 385afsuny9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 23:09:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QN4dFC088520;
        Mon, 26 Apr 2021 23:09:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3848ew3vcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 23:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgB0ax4dKllG6IPL6hsA/dxAV444bGfAl40tkv3xh+p8Fsd+YGxLKunzVAGVu0cycs/7XzvwNlSx3CJ8UCy8xtU4yoi2ppIXbkh04qcglIwWznhzlZx28keat0kcpfi2hfSY1QkS81bQdXvjC0/wOHp/Ylr9y8s1ljYJqQOB+bqXso8Hdn7JF93+jMwmhTLRcrQP7SJ91okg6GTaQwtLSzYMZnwIM07eUjCnywdtYkDCu6E+tjlyqMeciYiQLVxZUPH1/vUaAR7/YTOk5/IgYTobx/bqV76OM2QQW2K/bgj+2S2zRxtRc/Tw2e9QGZezb1p0Te1tKcSHqEja7gURXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPR2P28mhFkwg5akqF8mh5kqkphK/VBNzW6nvGwsvyc=;
 b=UYC1UpF/ihNTljs1z+i7hgXhAr5ThzCTbVXElWiGUy6VoADJhnkWgu+LWYHkWgxoTS/o+dFuQpg58JCP7WkjqLy/YZ+bS94JnzFv7We4THd4ACYio6rCeeh78XUO6ZDAlFUAwFOGlMSpgWq/K3JitRWX7o2fDOEfwDMXkl1XZikJvBHUyvCXBkkGXkU9P8BaMbD62T/xppBgAqexrG8ndGg3qY0jjX5vYiVUAdAQnTeW8OnRVkF7xrszJWolWJbSsrJPLvJjABmJe1dmpi3gU7+7SnzpCMTcZxrkMOWxoTw8XK0v8wPWo9f2d8WebovBU6wsU4PtBgi/b8UOedqz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPR2P28mhFkwg5akqF8mh5kqkphK/VBNzW6nvGwsvyc=;
 b=LKK1HJgQdElFdrSXq7xlkihwPPYYELNcXIL8rpW9MJT370vX9VgZgHSseJZa8S8DL+TJXRVnTRdErdunmOeyw3TbHmnVmARRsEC/UaE5mbv0rPlM1qsUIG+3Wv2yexmrbeKG5r9yxMZWVA0N49U+t3C9E/AdRuzbq9P2CacuYMM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 23:09:28 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::2497:c257:20ca:590a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::2497:c257:20ca:590a%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 23:09:28 +0000
Subject: Re: [PATCH 21/23] hugetlb/userfaultfd: Only drop uffd-wp special pte
 if required
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005054.35973-1-peterx@redhat.com>
 <02712955-0552-f82a-0ab8-460d63af3519@oracle.com>
 <20210426211653.GH85002@xz-x1>
 <1419a8cb-1028-31e8-bae7-4caf79819f02@oracle.com>
 <20210426220544.GI85002@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5c198016-91ac-119f-a5a5-40c79c98182c@oracle.com>
Date:   Mon, 26 Apr 2021 16:09:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210426220544.GI85002@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 23:09:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97c3308b-e432-4d2e-1455-08d909085758
X-MS-TrafficTypeDiagnostic: DS7PR10MB5150:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5150B214819F5E0A9E4503DFE2429@DS7PR10MB5150.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdeFZL+HxKfwInGR7Qc/M2jPk3grPNsxcxwT8IPo7+l+j1C/kTgodjw3+ng11ouK21MPG3GsF3ap62zjda1vtJVwCRyWym7TWb4Prqa6Z3lJpgqofMZNTrdyVJK6MEC+7jzc/nmue1EyGwVekI9sQFC0xl5uAF4RnO+VrIjYo2XP7QhGXE9uP+zgAXc58bL09CoH1GEtmaZvcfSDpkcTxDe6UAhptoFDtvWfICFOZe15+rYwk4vXrwcQuecwo750IFH3TyAc/gzjQsn21NUaVZKLxYSMvmFgI0j5kQokiie6eKjJ2iKUbzRSEL0Mt7XSqf/QIl1By3AfIf+6CmnOUuogrTEmQnB5Xi4SRau91NWZHpr+xSOszOqwDNlVCFaUVY0WJfQeGOnckmHpHWQbozHt+xFEFSTOBDKuGv1DbnyPgFpOcfDxEm54X+w/Is96Dyed08jA7KyKBSFb+xL8IJtGRPi5uHx9zBFcYHYvS+v9yRoHKrhLat7JfqDPyog2IVo63tqDnET8/EIfFbUOcQKzYpxenOMEZXyMRRjlcTw7L9jNYA+abytxJxHLB7k8269sAZOuIL0vfhe29jC8zRpvSl4fWdRo8fd9w53L7EbvGRuGDB0n2ZSJcfMCy9/Qz2U4KFBLazzYAH738TS15ywbZGcMNkbRUbPwULNggawD7YipQF4Jz4PAvE1VC3tqtTwlLBHR0aFp05qavQfsHPuae/r/npM+Of9dX88uXw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(38350700002)(38100700002)(5660300002)(956004)(66476007)(36756003)(316002)(7416002)(478600001)(52116002)(31696002)(53546011)(8936002)(4326008)(8676002)(6916009)(66946007)(6486002)(54906003)(16526019)(26005)(31686004)(44832011)(186003)(2616005)(66556008)(16576012)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnUvMVBScXh4MTJIblJJdUFJRHE1dFhjOERIbHk5c2poMzNkd0pVUTZWQ0Ev?=
 =?utf-8?B?TWVsRk5XeVlzZTJXK3Q1bDFFV25NMVU1SUJ0VjdzRE1lWXNabjhIa29hcWtG?=
 =?utf-8?B?ejVkMWtzUkRsQjZNMC8vTVgwTHhQYWFkU2ZtQmJYSTFtMWh4YytlVW5NWDdv?=
 =?utf-8?B?UFkxK0wyT3BSMzBCTVdnSlcwQWVuSXl3TWc4dEV0L1U5U0tGOGNydmM0elI0?=
 =?utf-8?B?L2xRV1NtMmcrTEMwbmZISGh4UHdGeUlaSU5YSDgzV3AvZzlnMHBkTnpVaUpx?=
 =?utf-8?B?SjNKMlE4OFA4TWg2ZWNiOTFKZXBRK1loN0E1aDgyYkNPcjFuSjJCdU12dWE0?=
 =?utf-8?B?aFE1NHBqaGZhQ2U3c3RZNVprRFo1NEttK0NDZlAxVmFmdzN0WndWMmx3Wklv?=
 =?utf-8?B?RzhUbTZEbUhLbFJSOU94cFV4UEpPNEtQbG5uNkJnWEhTd3Joa1hPT0lsK0F5?=
 =?utf-8?B?TjQ1WkJKamswMUF5UUM3QUFwQk4xT0F1VnV0VWZNNkRlR1VlQjVTZzA5V05K?=
 =?utf-8?B?QUkxTWR5MGpmbmZHSkhlSGR3L3Zvc2h0R3hYMVpsaUlHalJpeTFFSWRyUSt5?=
 =?utf-8?B?Ujg2d0VUYXZBUWpqc2FmazJ6SmlaV29GTmFvQ0dYRHlpK2JFR3c1WVBPVkJy?=
 =?utf-8?B?QU02TVlvZ05VYVMvSE51THdoS081ajRVWmlEaU1JSjZSVlVvM2xVK3orSll6?=
 =?utf-8?B?M2JvNHQxSWpURWZVQ0ZlRk11QWNObnRqbDBtWFgxaHJHT1hPL3lJbTNrNXVT?=
 =?utf-8?B?KzJ1clVReXJmWlp3aDgvYzhVdmE0TFp4NWxYQmpFdnJkV2dhaXJiYmJoNW95?=
 =?utf-8?B?cWxsMVQ2UHJCRThzbS9Hc21XQkFlUlhGTnRsdlJPMWQ2d1BGTzlqT25jamtC?=
 =?utf-8?B?Ylc1WmQybjh0Q0pvWXVYNHA5RnVETk51eGQxVVg0N0pkalRZU2NlZFFhcFZL?=
 =?utf-8?B?anFKL0tsUlZZNUoxNUF6eUpVcHJiL2l1U2V5eTZnajVGc0lzeGNpYTV4Q2NF?=
 =?utf-8?B?MDNxOWdRZjdRYTFwdGlveEJzQjZUY002NXdVb1NnNGZWN2pkMWpaNzExZEZl?=
 =?utf-8?B?VjFiMnNIY3VRMUNuVzFKUSsyZWwwQkZqSng1Q3BoNWM4QldtdUdDRnNZNFpW?=
 =?utf-8?B?aGUxWUZ0bmNtMXlvZExQampJd1J4R0tGV1NBeDNjNnIxa2xWbnQ3M1pFNXVR?=
 =?utf-8?B?R1VyMHNRMjlydXVQRGJaWUtZSnhUcVhER3Vxd1dEanhHd3VFVDFIRkN4UGZV?=
 =?utf-8?B?bzZJQWdjdks1QkcrcmJvdFBBcWMxVjVJTmt3bWlXZXQ1VUc3MGRMTnJGWEZZ?=
 =?utf-8?B?ZmRzaHRnTlUwWEtHbzRwejlvWXU5bEtVTlJlU0MzVUhiNFNkcjQ5Q0V4bUdj?=
 =?utf-8?B?c2pzTStWNVYwQ3hsZjFKdWo1RnBydk50bnUwcmUzSjQyVkExSlByYTFib1Rz?=
 =?utf-8?B?UnJVdDlFRGxsTUpLKzJCcmd0VG1EYXZVNDNNdnY2UjB3VVp3NlhjOVdPL0ZT?=
 =?utf-8?B?TkFoS3NLME5UTmcwZXB2TjIxMWVFYm5xcjU5WHJIS0d4dldCcW5oR2MwSVF4?=
 =?utf-8?B?ZTRETktzRlB3dk4ySkdFekFBbFdzOGVJOCt5bkdqbkFwZDNYYVdHRXlzZGhn?=
 =?utf-8?B?Q0YzRHZYajdqYnJkY1hjUWdQL0xYNHJXNUgySFAvbDUyeWZ4b3BwOHVpbTBq?=
 =?utf-8?B?SEV4aGh0dElORnZZd3gwYjdYKzU3NkhWMWd0RWx6NnNnTXRRZGlSeVlDeEs1?=
 =?utf-8?Q?L2ssUA0NJIemgTJY1k5DLI5gP7Csnx7X75ouBIQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c3308b-e432-4d2e-1455-08d909085758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 23:09:28.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doJ6DIj3bCEH98Zgv6gTFhzvn9KEAywoqF8juXxJFnn7N2uXde1DeDX2ZZlu3wLrcdj7W9t7fu2EJvILLi+DVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260176
X-Proofpoint-GUID: eScyWaR841cFuBPNUNH-thsMWAJDozE3
X-Proofpoint-ORIG-GUID: eScyWaR841cFuBPNUNH-thsMWAJDozE3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 3:05 PM, Peter Xu wrote:
> On Mon, Apr 26, 2021 at 02:36:26PM -0700, Mike Kravetz wrote:
>> On 4/26/21 2:16 PM, Peter Xu wrote:
>>> On Fri, Apr 23, 2021 at 01:33:08PM -0700, Mike Kravetz wrote:
>>>> On 3/22/21 5:50 PM, Peter Xu wrote:
>>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>>> index 92710600596e..4047fa042782 100644
>>>>> --- a/include/linux/hugetlb.h
>>>>> +++ b/include/linux/hugetlb.h
>>>>> @@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>>>>>  			 unsigned long *, unsigned long *, long, unsigned int,
>>>>>  			 int *);
>>>>>  void unmap_hugepage_range(struct vm_area_struct *,
>>>>> -			  unsigned long, unsigned long, struct page *);
>>>>> +			  unsigned long, unsigned long, struct page *,
>>>>> +			  unsigned long);
>>>>>  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>>>>>  			  struct vm_area_struct *vma,
>>>>>  			  unsigned long start, unsigned long end,
>>>>> -			  struct page *ref_page);
>>>>> +			  struct page *ref_page, unsigned long zap_flags);
>>>>>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>>>  				unsigned long start, unsigned long end,
>>>>> -				struct page *ref_page);
>>>>> +				struct page *ref_page, unsigned long zap_flags);
>>>>
>>>> Nothing introduced with your patch, but it seems __unmap_hugepage_range_final
>>>> does not need to be in the header and can be static in hugetlb.c.
>>>
>>> It seems to be used in unmap_single_vma() of mm/memory.c?
>>
>> Sorry, that should have been __unmap_hugepage_range.  No need for you to
>> address in this series.
> 
> Ah yes; I'd rather add a patch if you won't object, since my series will touch
> that definition.
> 

No objection if you want to fix, thanks.

-- 
Mike Kravetz
