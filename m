Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022AF33C5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhCOSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:43:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCOSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:42:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FIUi6n120934;
        Mon, 15 Mar 2021 18:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jxlR+5BC0MrB9RRJtH/mXnURJL77812tXQJrbZ4UKy4=;
 b=KEZ9GQURpzGxr2LAtixVWU0p/0pM4AbRtqz+2tPSN3QC6NNFaFVn1HVOD0lb0MEbAvt7
 LH3OB9+I7ornCD9qutMgEY1wAyrbC9/XBlLpOHGvM+/BZ5amp5VIxJYx6mlvoCf3c/T7
 XRC6/Z4fbDpmG8tUYMTth4Vq/O9Rcvl4gqs71YMOsseA1aTddT2UWMHq2dORJ7WyNjRe
 etMSmMOen/U3ROm3T4DTA36dpbjHuIJPOvRMqltM0JHT5PN38FtalPn1U5pc6RBcqMWF
 SqynB78vs0JguWVOpLdX52n+O3ej+RvGoySLHgWp72FGBNgf3nNGEfrq72jJ9mcEMFcW Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 378p1nmysm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 18:42:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FIVb9g037051;
        Mon, 15 Mar 2021 18:42:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3797a081e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 18:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvhe8yq8jc2FPffrr6X9/UHYR4soZhazZq3QNPwKYHwxZ9dTgSy5TPU2u4yu01OIwtRXbaiOcK71dIatHpLqAEe6gW+msUpZs6S2QaU3ZeqhhoJAQl9AaUsmvggRieHuNO4p1ZSbkuU+i5AmrkVJP0iFdUxSjSK7f5pCDHPPJN8c6Dp4OouJbc1Pfc6OtfwkntjWyzjXA//B9v6xPkOxfIg7PzdoP64oU/nldqNUsHb2oW60WUKAbG9dBfS2Vq2cfbUU2UM/OIYJTIoHXLTt1ZUm5RSsHjDK19bBT9X3UL3eBz56hp1Qy/EXNSM+aR+vnc8M+qzRCn9t3x4+gV5N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxlR+5BC0MrB9RRJtH/mXnURJL77812tXQJrbZ4UKy4=;
 b=nSxKRBCPxqymRwbGnPRsHaQRsu65vQhz9GKKj+lUvy8otAPq7+DcVU1WFsW975MNrch1WIZedNIj7bYSrCyv9xaGElI7tTV6+DT08a+Nr2SCrO0pamTv0p8nSpnyajgMiS2EjNpHbdSg/DgLM6g6xtMhbbE2owqi6NNnl5WoIQAqzeB0uF+kv1nhbzYXwZ1e/t4OB3rAsBk7MdReyDulR+se4g4Llyeju6d3olaVqsywmethzsIIACnknhyNgBvCvGQV8+l26eE1UWgR4Q7dGWJl3snTds46Me21gBijhkk6xmEdao8WDrxfY3k55R7r4/HAhZ0ZzUJU8oBtq7TMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxlR+5BC0MrB9RRJtH/mXnURJL77812tXQJrbZ4UKy4=;
 b=Ou5KnIRriByneEDJJhwFLYJDKh2NwBR9891JZpnieICFVQ76rMTdJb6q2nMtUchwQw2sGmrzUuxLqiKa+8goElAluTN10puR+O4hqY4PG7Wb1XJ2yL39P92Q0r25bb7mqTRXuEBnAcXVTyPXfu8MnXiS2Mz4pg8Lo6XqbdJZ8/Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3208.namprd10.prod.outlook.com (2603:10b6:a03:159::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:42:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:42:38 +0000
Subject: Re: [PATCH v2] hugetlb_cgroup: fix imbalanced css_get and css_put
 pair for shared mappings
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210301120540.37076-1-linmiaohe@huawei.com>
 <771ee69e-61d9-b1c9-b72d-3a50d2cbe4de@oracle.com>
 <7868ec9c-0762-2a78-2dfc-2bd07dca15f5@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2b23bbf7-bb32-4ed7-87ae-5e55b4bc6629@oracle.com>
Date:   Mon, 15 Mar 2021 11:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <7868ec9c-0762-2a78-2dfc-2bd07dca15f5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 18:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5663619-e3fd-430c-875c-08d8e7e21b45
X-MS-TrafficTypeDiagnostic: BYAPR10MB3208:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3208EA5D5683FF374BE44C84E26C9@BYAPR10MB3208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBS8KWjuv5ngCQSPfdbiO2isGyyg+1xDMVxJliD1umQ8RJykMyQonpPlDYsEZ3vTQgSX/AuJ8XduBTk+n0KLEqyNcRVn1zRxEj+LryL0e/2EQETNdY3cSXSvokF6HXBVCwXnhSRPqskjy4wdxwyzPzML7sUVeNUYoJfVRsuNtp+jfNlLmem9WbawfOh0xSUs5qjdZ4J3jzdO0+3GEiSD9IUyr/E6q4L+qdZHXkje130POCkzehbvuxu2VohY3S2y+4SM+Wxx+SP7B88w74XMnD/kR6TzUtYwd9Dc4jCquO763cuy1d8rbQerhmo5ci8coIz10fyFUubCY6A0KSxgpZspZWYd4uLY6vxM2iSpOvTKWTC2CxXkzcgY2eSXUp/Lf6hKCrlTQ7MlECFq41Cs4AVvt0n7zhTSY+HUQVGCBa7nJE511h3KKcBs/Ll3m8SvuL0gEQJgLmoATDC9XtBrcVGVdLVlDX4seghVT9c3mvlxfrv9FbTPxIiSMpPfw4WLcEfT9KoAzJC04/7WYcmmByc/Nl5mPp6BX8wnzsqs7HJTiidaBDlzEKpK8MD0XW583q4TSc5ESzNnfrpEzsBubtGFr7swEFeXZecvOnG0nOfbE3tVbltkU6Iyte9Oh3iSZlTIgakN7CmCDcX9MV+rDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(31686004)(31696002)(5660300002)(478600001)(36756003)(186003)(16526019)(86362001)(2906002)(66556008)(16576012)(66476007)(52116002)(6486002)(316002)(44832011)(53546011)(956004)(2616005)(83380400001)(8676002)(8936002)(26005)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VjZ5a1hVNnRMOUtiRVpvWkl4N3VSc2VTbEczc0ZwdnhldzRlamh3YkdnSlEr?=
 =?utf-8?B?Snh1em12c1dSeGxYdGlMUjl2M0tzZURnUUJQUU1sVHJjUTlkd2RuOCtvZ0lC?=
 =?utf-8?B?dHZBZC9xTmpDTUJEK29TRFNhZ0FGeXNoaVpOcVRadFEzRzIxVWJiY0xsdTJi?=
 =?utf-8?B?dTd4WjZZd1htNXV0a1BoUnBvVXN2Y0ZGZlQzdU40NFY4aGU5enFQZk5LRjJk?=
 =?utf-8?B?amhJTnFValFvOW5oaG1YZTIwWnBCZkZOZGthT3k4M2hnT2RxS2VxRHFOeGp2?=
 =?utf-8?B?TUEzQTFYWXYyRDR6c2pMYS9NMU8wL3Rva3B2Z3k0VTl0SjVUSzd4enJNbUZ4?=
 =?utf-8?B?TlV3WXRLSjVSb2VoTWtydUtBTUhYSkcxNDJjbThNeVI1NlZiUytyZHc3ZzFV?=
 =?utf-8?B?Q0lzZzhRNHMxbGpIZG5uako3ekdHYjdFNzJRMkZIY0dCd0dYbC81WGUxdmp5?=
 =?utf-8?B?dDhWcjlKa1l1b3pUck9iejU4aHBzZEFnbURMRTR3ZlBoVjRkejZ2YlBFQjVL?=
 =?utf-8?B?ZVF6VzhYVmNBelE1Kzc0NG1qbStTdllGZ2xUcG1aaEhwamRBcllnNXppckNR?=
 =?utf-8?B?Um9mNUErSmxwdzFicGdIZzg4RTZhTVgrekxIb2YwbEgzLzcwWS9oa0w2RDlO?=
 =?utf-8?B?VUF2VEppK3g0UU1mMmpOcGhRMTFNVTIxSlhBcGdvOElJcXVOUnd3b3ZjWVEy?=
 =?utf-8?B?dGJrbmlheXM4NHN2N2NpQnNIMHM2VEVFZWZxNzdWODdIUElzTnV6OGdwMDV5?=
 =?utf-8?B?Zk11cSszaWtTb1U0NTRqNk1lOHJ5ek5IWm4waE5oOW9oTWRvRG5ENGt5M1Fk?=
 =?utf-8?B?U1JIaUNmY2daaTQybkd5d3lJNzUzdk95bmg2MGwvT0licVRPTFFuNnNpYnoz?=
 =?utf-8?B?d0RoS1pXSFFPempVRHdPV3JPd0VWZEt4SlFzYVl1dGlMYWE3K2dCZTV0NjM1?=
 =?utf-8?B?L3MrcGoraVl0ZlpxQ1B4TEpWcTRvUGRnWU1tMXozWUFLUkVEQVpESjhUWjRP?=
 =?utf-8?B?UXFIS2puOGNPKy9jbEtVSkhiTklmK2tWNFhMaGY5SjZCVHhpYjlNejdvMHVJ?=
 =?utf-8?B?b2s1bVcrNlJ5S2poZjc1T1JDeWtzczFHcFJWd1NBbk02aUdwQ0N6RkU5N1Ev?=
 =?utf-8?B?UU54UTV1RnFPNE43M0ozNkZ3ZGxLS1Y0a2VOMlRySkx2Uk85eXlmdDZMUlBN?=
 =?utf-8?B?ZVN0QitJVHhvdlVBcTBOcWp5bll0Z2huRlZmRllaUGYzOVJNcDRoOXAvV0NU?=
 =?utf-8?B?R0lQN3ZjcmRVZnFITmhiRW5UVTRLUkxObVh1ejJURi9FcE8ybVpJbVYzYkc0?=
 =?utf-8?B?QS9oVkVxclZ2ZzMxYW9Od0Y2UXJnMit2Q3JWZ3JWZ1lidmVjMlByYXJLejFG?=
 =?utf-8?B?ajR1b1ZvdzF3YzZiMGkrMHFlL3g1MmhHSzNEdUtWdHl3SXZabW9qcTUrdWxS?=
 =?utf-8?B?TUp3VE9TRHo2STJaZDkzQWV2Q2RzTzhmUnlNMkE2V0l3cWFBbG96WUw5TlJD?=
 =?utf-8?B?Qk4yY2p6Y2tiWkxFYVJHclpKTHhNT1EvcGE5MlhzcWlJcUErNU1vdDRyWi9X?=
 =?utf-8?B?UTRwSU9ZUi9pY1JtMDFtOVVuQWx6SFVFVjlJUVhqY0Y0dDJTdGljVHZjcm5E?=
 =?utf-8?B?L1JvNS9hMjlVTFdMcVhHOVpaWk5WK3FVcWQ5MGlXMkRBV2NrZUlTQ3FxdVB1?=
 =?utf-8?B?cDZKdHF0d3gzaDRweTJTSWZoNmhIejFHV24yL042R0hBM3ErTGlSamVFdnBk?=
 =?utf-8?Q?/rPQKsuOs/fE0s48oopctCSevwmIPPUG5E2x++L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5663619-e3fd-430c-875c-08d8e7e21b45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 18:42:38.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OeSmYVZHs6VgIuWvqO8S1RpZfusmgIj8KqFjutwic3AJtv+LHTb1wTxYVcQto3ExX38J/XU2hwlkf1KbobCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 7:11 PM, Miaohe Lin wrote:
> On 2021/3/13 3:09, Mike Kravetz wrote:
>> On 3/1/21 4:05 AM, Miaohe Lin wrote:
>>> The current implementation of hugetlb_cgroup for shared mappings could have
>>> different behavior. Consider the following two scenarios:
>>>
>>> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>>>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
>>> count is 2 associated with 1 file_region.
>>>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
>>> count is 3 associated with 2 file_region.
>>>   1.3 coalesce_file_region will coalesce these two file_regions into one.
>>> So css reference count is 3 associated with 1 file_region now.
>>>
>>> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>>>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
>>> count is 2 associated with 1 file_region.
>>>
>>> Therefore, we might have one file_region while holding one or more css
>>> reference counts. This inconsistency could lead to imbalanced css_get()
>>> and css_put() pair. If we do css_put one by one (i.g. hole punch case),
>>> scenario 2 would put one more css reference. If we do css_put all together
>>> (i.g. truncate case), scenario 1 will leak one css reference.
>>>
>>> The imbalanced css_get() and css_put() pair would result in a non-zero
>>> reference when we try to destroy the hugetlb cgroup. The hugetlb cgroup
>>> directory is removed __but__ associated resource is not freed. This might
>>> result in OOM or can not create a new hugetlb cgroup in a busy workload
>>> ultimately.
>>>
>>> In order to fix this, we have to make sure that one file_region must hold
>>> and only hold one css reference. So in coalesce_file_region case, we should
>>
>> I think this would sound/read better if stated as:
>> ... one file_region must hold exactly one css reference ...
>>
>> This phrase is repeated in comments throughout the patch.
>>
>>> release one css reference before coalescence. Also only put css reference
>>> when the entire file_region is removed.
>>>
>>> The last thing to note is that the caller of region_add() will only hold
>>> one reference to h_cg->css for the whole contiguous reservation region.
>>> But this area might be scattered when there are already some file_regions
>>> reside in it. As a result, many file_regions may share only one h_cg->css
>>> reference. In order to ensure that one file_region must hold and only hold
>>> one h_cg->css reference, we should do css_get() for each file_region and
>>> release the reference held by caller when they are done.
>>
>> Thanks for adding this to the commit message.
>>
>>>
>>> Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
>>> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: stable@kernel.org
>>> ---
>>> v1->v2:
>>> 	Fix auto build test ERROR when CGROUP_HUGETLB is disabled.
>>> ---
>>>  include/linux/hugetlb_cgroup.h | 15 ++++++++++--
>>>  mm/hugetlb.c                   | 42 ++++++++++++++++++++++++++++++----
>>>  mm/hugetlb_cgroup.c            | 11 +++++++--
>>>  3 files changed, 60 insertions(+), 8 deletions(-)
>>
>> Just a few minor nits below, all in comments.  It is not required, but
>> would be nice to update these.  Code looks good.
>>
> 
> Many thanks for review! I will fix all this nits. Should I resend this patch or send another
> one to fix this? Just let me know which is the easiest one for you.
> 
> Thanks again. :)
> 

This is really Andrew's call as it goes through his tree.

I would suggest you just update the comments and send another verion.
In that way, Andrew can do whatever is easiest for him.
-- 
Mike Kravetz
