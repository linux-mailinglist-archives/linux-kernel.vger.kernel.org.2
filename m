Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA87346DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhCWXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:19:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49696 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhCWXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:18:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NNEvoR033485;
        Tue, 23 Mar 2021 23:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GapeZICg63arON+TMaGj2+EZ/fF07YJPgYCGC4ENTQk=;
 b=gituu8oJ+E7JK/z2z38lrUEUCXbCFpfavYql5tkQUymUJKMwNUAdELiLEEJ8SdacvhiZ
 O3nUibk2I4HjsHIUFT2+5e7iFPZ1WQoPfyh02Mqfnjvf9FfTFQa+2mloKQ0haSHpNr7H
 COQtgo8dumVTvmQZfwwXH6y28RV/oD70AZRosW9yyrLRRab+c289R9pGlHjfnh3E05bE
 k9Rn4KDpqaCJWZyKGrut8ma+P8fyq/1h721mZMGlo7lsMBThvx99u30ty0sptC7VmCg8
 BGX+PrOgYKgVMZXntZWJcygyiQu6RkGr5u6j0eHe9OWp0nytw0/YQioNDIu6uwmAZNk1 Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pn0wsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 23:18:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NNG86x083060;
        Tue, 23 Mar 2021 23:18:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 37dttsk9q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 23:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hojf9mdpzIdchR834Ngc3dLvPOxiOifuk5xHxQeJuGrc02XVQatTVhPbhwY6Pow3vK5YcfggAS74Ge5bHsbL8GxPWlsYjakXNsBo9/MW4TPA+0J310lHqJZMm7VdRpTicejuTkblMpFeYdl4ACRw2QlpGdc6ktdk4w8Oeecy9NNJw2R9sUcmt/SZd1JCv2k6GNq36aGpFboVgDOxwSzm26HBoS3cfRtTMUqFLsty+7R5VDx2hOkKWiDrQhNIy7bA5dePf8t9I/352Bm/fu1qHzENlIs6KSXduu/pd4P4RIQpuBUiSoExzguR2bFvvu5FQEw+3tYxgM9epfVtQYa32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GapeZICg63arON+TMaGj2+EZ/fF07YJPgYCGC4ENTQk=;
 b=J7Fu7F4U6nY8WMkVuKgWZA5cXSvJPoOemYd46PJabdXzvbbCGylsIAQL6sCWUtScwnsoR3zr+lU9fqCHdXGtK9cHKQsyJVHDml0nxyO5nJgFk+HmKksrMEEWH8LihzchAU4I+cPJzk2SPBmxRLgdQfZETUWkLNfRPQRyoITQOnyIYhsSPaS/xiPhK/xwLi39rYVLaw0cCHbqtdiKCk0kgWgN1FbkSpPSuYI4ZUsfurFATf+LkeeNYsBnrn/HIwqy9Su+5CBdn/6DidsyibJhbEAaDAck74lvv+eItLNPWm5tmMtcQvt9JN5W6GkdkUZUNdmsxOhrIEdO1E/UD8RSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GapeZICg63arON+TMaGj2+EZ/fF07YJPgYCGC4ENTQk=;
 b=XG1I9YvYdoaOaxFswqpalIFZqyEAeZFSJFhNGfXWqZHYPkSFq4fvHuUEJnwD3DQLPXZg5BBMOZeKeTvJcXEJ+0hTGEXbkr06QuKUI+r93ArqEhJ3K6JTOE5FXVw+hQwaiTZkQMhVpsROeBrLifdRbz6OZl4jtBm0DHCsTVvTSpU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3494.namprd10.prod.outlook.com (2603:10b6:a03:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 23:18:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 23:18:11 +0000
Subject: Re: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping
 hugetlb_lock
To:     Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-3-mike.kravetz@oracle.com>
 <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
 <a7d90d58-fa6a-7fa1-77c9-a08515746018@oracle.com>
 <YFmd3d5B2VT4GkiG@dhcp22.suse.cz>
 <YFmgPkTzZY6Ocj6X@hirez.programming.kicks-ass.net>
 <YFmjVNnnHHpyxqKe@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <52db15d1-4ed1-6c3c-b638-6efdccf6e62e@oracle.com>
Date:   Tue, 23 Mar 2021 16:18:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFmjVNnnHHpyxqKe@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:104:5::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0181.namprd04.prod.outlook.com (2603:10b6:104:5::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 23 Mar 2021 23:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7736d27-9133-42b7-c35a-08d8ee51ece7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3494440F9109F34A15C4F6F0E2649@BYAPR10MB3494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/dUrktjN/qNtpJoijQcAg15BkSeDwuipYZMQ5SR1JHbQX6MI32Qonrjyge/+fNn9J4xmHsQsCpMJO8BdvSalk5ji6Et4rNiHMzzru36kscoWIH71Rn7wXWPqEAUcMS3kr+RWQdpXePIp75AXVv1iRarv0T5eBGQeINLei8hfmKrEeo7hlpSIvpVR2e5/9KPhTiM4GLCx7mMW2mMoc4K1NRQ0uSux1eYWvplNbYElW70aK78j4HrAdY+4NF8DB+bHk7MlAX+O0Go1+0Bn/rLQm5zGyDaPYPYC3kZCXn0szKiEZnWgcd6UBkJiwpy3WRAdTrJmIJ7eywi16EoLQEy8Q7TdfUmiEsIFPc5afFkHwi65I7m61jUNo2TgnyvJZ6dUQoGkh3dnZ3OUEOiJAWCdj4lL5SCiIsZcUVF88zsDBPGM3RnWTq3Iw/CdEHvDzUr5Yxv6sGotk+YQ3YuDYdT8Q1AbBxYDs0fJXVi4vVOZALIPzlUQUqwQZefZZiqeliSIQVF+JrtvA6naC1mbk0meb9owGJ3RxwhFzeIIrOkwD1qIUxBoVe+LD2w3tB1pOBWVcltGKr4uq1dnzGwoVhUDz3XA5o9KKowR/M871QoO2XbjLg+lBTQz6Tgh/6xTm9JTVee7Ub4MulLqMxBm4FiO0u0yiGoFTtSfY5pejOkvfWFgFgLdNbc+Izrpzvjqw4Zq32i3EYGS1qL4jC7SoRQww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(2616005)(31686004)(8676002)(36756003)(4326008)(52116002)(2906002)(26005)(66556008)(186003)(956004)(16526019)(44832011)(86362001)(8936002)(16576012)(31696002)(6486002)(66946007)(7416002)(54906003)(478600001)(5660300002)(110136005)(66476007)(83380400001)(38100700001)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QjlodDVyMWR3UlNCV1BLZUFzNHlkUnRML0ZOclZDYm9oYjhRbkJXTXpoY3dk?=
 =?utf-8?B?TEQ3T0FWQmVaMDZwd2Q0Z1RnYTRFR2NvcnZnckh2QTZpM204NEtpcjVXZVlO?=
 =?utf-8?B?OUc3VHJ2bzRjM3NIWGNILzZRcm5BYkI2cE9IOVp4Mmdzays4SlR4ZDlMOGYx?=
 =?utf-8?B?aFNuWWZPUEs2L2x5b01JSnM2dDFiNjNDYi9oeTNZUFRLUmFTOTgrcDdCQVJE?=
 =?utf-8?B?UTI1ak8yaklGRHAwZlNwQTZJQXhOMGdTS3ZzcTA4dE5MYlgxYmdKcVpEdVV3?=
 =?utf-8?B?YlVyVVdNUnRGWGZyaFROWkkydUxRNEtuOW9OYjk2S25ZVkRSdVI2d2Voa1pF?=
 =?utf-8?B?MXAzRW1CRjVkYVcvTVR5cUJNNCtwUGhHWkd6UzBwbVF3S043b0dYSWdqSkwy?=
 =?utf-8?B?eHg4anVOZ1JORUJ6ckxLUTNxRG1JUGVTRkVVWENjTnR0dmE3dVpudEx6SStG?=
 =?utf-8?B?RnRSTGI3WVhOblFyOE9wQlh0QSt4VzFqQTZRdHF3UmNwdk5tOHFtNEJZalRG?=
 =?utf-8?B?b0hDbktXQ2taS2V0aEtNcHhDRmxqNXA2R1N1VWdTK29VVTFMT2dKMEUyNUsw?=
 =?utf-8?B?dTR6eTdxdEVXLzdXb00vcUpGbzZJeFR4cnF5bCszQjM5cm5Zc05sK0E5Qjhr?=
 =?utf-8?B?N21yRzZRNlVPZllzSzlRelFWeHNXSW1VbTJ4ZVA5RnF4NW9PRFBsVkJmMEF0?=
 =?utf-8?B?ZkgxSFJyYnBlUGVWbURhSWF1bGo3cW5iYW5PZ3FUV3lsQlI0WCtCR1FwRm1x?=
 =?utf-8?B?RUM3cVkwRjdJQ1I2Tk9mNzA1a0pVRmV2a2hIRGZJT3EwdVpQNmYzaHR3SzZN?=
 =?utf-8?B?NC9CZ094RmxFdWpnRjdVcDNWeWo0VElJWVRKa3NyN1JTZjFIcFMrdXZpTG8y?=
 =?utf-8?B?MkpTRzY5QWFoRkNtUThlOXkvU0RVeWNzSmxXZU43L2lXa3VMRFJhN2JWTHI4?=
 =?utf-8?B?OHE5bk0xTDJUUGs3Nm9QR2oxNFhmTVdBVVJnWVZyeDRtVjlFMVgvd3dhNGJI?=
 =?utf-8?B?eDJHam1LY1ppKzJWUU4rMnNHazZmZ2hyeUt4N3BJZDZwQTkyWnNYaDhtMFE5?=
 =?utf-8?B?ZVZsWGVCc3h1ZnAyZ25ERjc1ZzNOUzFPN0JzN2wrTE85V2tPNjQzbDdkQU9B?=
 =?utf-8?B?eXJHeEUzQU5McG81V1VsSG50eFJWT0pUVUc1N0RtR1llazVkMW1WL2FHWnZt?=
 =?utf-8?B?aDhYdnlYTU5uUXhLcFpCNUhwZDdOdjNvYjNwK0xoMjIzZU5mQ3dsYlhDaVNH?=
 =?utf-8?B?NGdsZmZwT0YzNVhCTkpVQmdZVGk0dWRwTnJkNlZBWU5qWUIvendnakp1TExC?=
 =?utf-8?B?UVZMc2dyUCsrcXdFYWZneWZEaHVZU2dHOHlZc3N4bGJ5UE1ndko3WmRJbEZP?=
 =?utf-8?B?OElSK0hxQnRoaDQ1d1VaV0lUUWZQTGp1VldRc3UzeGhHTTJSS2MwU01hQkNE?=
 =?utf-8?B?Q1BrZDhIdERxVmVTN2NoNW1obE5GK1BhY0dDZkdzZGsyWGZiM2Z0MnFwOEl1?=
 =?utf-8?B?ZVNXdWpsSkpsUWtEMm1aTVJNbm1pbFhCRkhvZmxoaDVDbldFLzhuVGhNbVVn?=
 =?utf-8?B?SXk2dk9CUlVoZTFBSGh2T2lHN3J6dC9qQSt5VWdnaDFvMWJ3WkpiSG8wVEZv?=
 =?utf-8?B?d3VxajlzN0kvZnQ2cVFyaktIaVd1NGJpcXpnUFJhK0dwOXlnSHRYWUNaL3Jk?=
 =?utf-8?B?NU5sRnZJVFEyQ09xTlU5OGNmU0VFNnZHU3dCWEpobnJuQW1LTnNMRmtEUEdj?=
 =?utf-8?Q?D8z3l2As9WFvZ3l1u3ttxqtM5tOzOh2nDpWO55i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7736d27-9133-42b7-c35a-08d8ee51ece7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 23:18:11.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF87I9c7/DC58kQfi+RpcTFd26fLRwI/yW1GADfgy883lEkI29GVAxEr7Pmot64MUYlOp6kCy9xfUKbfp44gQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230172
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 1:14 AM, Michal Hocko wrote:
> On Tue 23-03-21 09:01:02, Peter Zijlstra wrote:
>> On Tue, Mar 23, 2021 at 08:50:53AM +0100, Michal Hocko wrote:
>>
>>>>>> +static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
>>>>>> +{
>>>>>> +	unsigned long min_count;
>>>>>> +
>>>>>> +	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
>>>>>> +	return max(count, min_count);
>>>>>
>>>>> Just out of curiousity, is compiler allowed to inline this piece of code
>>>>> and then cache the value? In other words do we need to make these
>>>>> READ_ONCE or otherwise enforce the no-caching behavior?
>>>>
>>>> I honestly do not know if the compiler is allowed to do that.  The
>>>> assembly code generated by my compiler does not cache the value, but
>>>> that does not guarantee anything.  I can add READ_ONCE to make the
>>>> function look something like:
>>>>
>>>> static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
>>>> {
>>>> 	unsigned long min_count;
>>>>
>>>> 	min_count = READ_ONCE(h->resv_huge_pages) + READ_ONCE(h->nr_huge_pages)
>>>> 					- READ_ONCE(h->free_huge_pages);
>>>> 	return max(count, min_count);
>>>> }
>>>
>>> Maybe just forcing to never inline the function should be sufficient.
>>> This is not a hot path to micro optimize for no function call. But there
>>> are much more qualified people on the CC list on this matter who could
>>> clarify. Peter?
>>
>> I'm not sure I understand the code right.
> 
> We need to ensure the function is evaluated each time it is called
> because it will be used after a lock is dropped and reacquired so
> numbers could have changed. The point of wrapping this into a function
> is to reduce the code duplication IIUC.
> 
>> But inline or not doesn't
>> matter, LTO completely ruins that game. Just like if it was a static
>> function, then the compiler is free to inline it, even if the function
>> lacks an inline attribute.
> 
> OK
> 
>> Basically, without READ_ONCE() the compiler is allowed to entirely elide
>> the load (and use a previous load), or to duplicate the load and do it
>> again later (reaching a different result).
>>
>> Similarly, the compiler is allowed to byte-wise load the variable in any
>> random order and re-assemble.
>>
>> If any of that is a problem, you have to use READ_ONCE().
> 
> Thanks for the confirmation!
> 

Here is another thought.
In patch 5 you suggest removing all pages from hugetlb with the lock
held, and adding them to a list.  Then, drop the lock and free all
pages on the list.  If we do this, then the value computed here (min_count)
can not change while we are looping.  So, this patch would be unnecessary.
That is another argument in favor of batching the frees.

Unless there is something wrong in my thinking, I am going to take that
approach and drop this patch.
-- 
Mike Kravetz
