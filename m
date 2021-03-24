Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB8347E44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhCXQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:54:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46724 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhCXQyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:54:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGoPqi158572;
        Wed, 24 Mar 2021 16:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=knDoRfAHPtwgpr+DCZG8W8hKRir/bdlk9nIdqZnE3Vo=;
 b=LHjSb/3gxWAMXiVZDqzuN2KGHsIBAx+YM7m1z3hMhsJ09kyYMY5SW7rWU0/1ezySgTDw
 baRMG4FSTuRvHtlEHjdMOR4mMJLdfYbCgJAQzJdL36bKmehyCtEYmdhCuVaA13M81fbO
 eoX+aJ+btU1QCO8r0qFl/rFZ52iyVvnZ53WUkYkUh7Mb/hqDtD7yo/QyQeG9wS/ogd0E
 C5wBw+8aZJPWGFKl2DtJO8/VqcACGsla3A1/ENEQMC8keH/GV4wO6MmqfTuItPLA8GG7
 KmpCB1P9T/59j78HMil087xG4C3P3PtwqOR4Vl04EP6HIGEHCc9rp6NhZrZAB6Us709F uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbkksy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:53:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGiuls065426;
        Wed, 24 Mar 2021 16:53:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 37du002nn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:53:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOCkM5ydHpA7b+4H7JR3SCwBY45Jcv24yQaHq9br082PEEMBJrzS31z3HZqlKjG0waSD3uwUHdWS1uqzu4t+ODqJWxHwTD7pO8crigvJkqfddsr46wN1Vk30VL4Ff2Tuo8S2aCDaZSQQcHUkCX8YwIhXq6ayMIbPUmFI7VXYkiAVgKWaS6S8WZvz5+Yyu1mA7o6Li2bHb2eu2Jtjza3urEj2l7VBOrXo3Se5NEw8Bj0lnR88N6lOCxNjr7aw3AgTy9d+wQbtQvnmXWLtmlRfsAnTjeQ8pBpHZmG5jn0mWyIlBcA6rLcaWTn8nuYyqVcPg7q6m9CennDBrYugWk4Xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knDoRfAHPtwgpr+DCZG8W8hKRir/bdlk9nIdqZnE3Vo=;
 b=dItyzebKJtJTap2oCyni+XfcuSRrFi4Fq0OKi7yrXFN33+FnkKMwF9dJ4joAr2vvOYf1RKqgKgMyn0bt6qGxnXz3BuufO4IU/jLLkkIDrv1Zyi2QcyeoOIMLyFN9iT2epmsT5T870qFv0DArey0AuZtVHkLIE3R3LMayG9sX7a75DCj+/x8QG4ChxVrd2fS3u/mrXCR5xUXMXmkanGf6+31X+fYTeik4SnuGoeObVf2t6rhOA6G5XWMIKtvuWMO3bi8HdrjNlud/PczuvZPEMypDqSvWTIyk+lT/x+PohB3CuDPyGySRWBg+qOkjoOchgwv0yo5/r/5FSE9NCdlBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knDoRfAHPtwgpr+DCZG8W8hKRir/bdlk9nIdqZnE3Vo=;
 b=w7kEuqijVZ09U329eQ0+RCzg7eEqMiwDj/Q2wj1Xi0SanDvZYbguMpztSf37VjZlWfqVZe3pt0/mZy+H6z+zUfUVviGLKlG4xHkE77tXVgka+JRJyAkaiDjctNunYfg9747LcLcT4a2b803zUmg8eJCUYyDcdEKKi6tmc125UEY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3207.namprd10.prod.outlook.com (2603:10b6:a03:152::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 16:53:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:53:46 +0000
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
 <YFjdpDwKaqwvW1I9@carbon.dhcp.thefacebook.com>
 <8a28c691-1e7c-1463-9d59-da31a2926adc@oracle.com>
 <YFr7t1a+gEvLPuAw@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ad1d1c1-ab28-38fd-14e1-9165345e8088@oracle.com>
Date:   Wed, 24 Mar 2021 09:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFr7t1a+gEvLPuAw@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0162.namprd04.prod.outlook.com (2603:10b6:303:85::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 24 Mar 2021 16:53:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd42a385-639c-4b83-f362-08d8eee563de
X-MS-TrafficTypeDiagnostic: BYAPR10MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3207D8485B42CC3574BD6740E2639@BYAPR10MB3207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEY2TxgjPr3i/1qNre4rYwtsvfsltXDLuEPJK0EhfXZXo6DiJ8mQkvBvd12k+QziDVLaooxceFwMd0JLIDf0z8Hm9UGZuM2SZzNwV/Di1vyl3JOMc1D0EAvolZ7rqrpFaW5tpBZofskCArqdOs3+Obxmp+KD3th/UKVz+t6YOObZ/ubZDt+Ktbw9BnU4nlIBcqy5+FZuAOnpjoJZoxuRwjoxybbpRZfM90ebCiuqY1udjFm680kLVyHQvsi11fC3NcKM5vpMTPnveWYWugOeAbmnRKMoLWz+NJBleAUZsvxnxgo7ozWFGafxHL3K3aOhXIbhMv6TnabzqCxsS9zzy9387ifU213T3EL/wSzc0KSAZ6UkBmMLWgt/it7z4x2lCX3EUz9H+a4wPpJLXenUvKQ672If/PRiWCj7CVt17fwDoZZwkZ1rKJ0WwO7SsVgZSpB6gMQPjq0E+ZWEvngDJnKCbNRXX1FMVuoQ/3CQBysLlQVHKFR14N6MRZhXCcZjXIw5BS8piozjyiH0gO994LcQSSEAiRwmFTaLyOsEBgR65POPLjnNeKL6RAK88JEVrM14InMIt7tgpi+TPmUQv5GBgAUKPMzhR6A3IxtML4zVV9h/3yVf7Bn6Q5IDVfG3TRQE0moKBzIIBc3xkeuCK4El2KzIpwKCWBh2mfRqeWkpB9Xf/PvBiauxdqdiINynIj4NkkQqkCcjIP5m1KMXUfLIANmASB/s2llWF7oZauU0Lvrqsnctq1j9WhQ/uUy79Jc6KGxx8kYdvofpsedW2o5FdK3bEHttzwFisTVvssc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(86362001)(316002)(31696002)(44832011)(54906003)(16576012)(38100700001)(4326008)(26005)(6916009)(53546011)(186003)(8676002)(2616005)(6486002)(956004)(83380400001)(5660300002)(52116002)(478600001)(66556008)(66946007)(66476007)(2906002)(16526019)(7416002)(8936002)(966005)(36756003)(15650500001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2dZc0x4WXEvTGhVMWVCUTFvSDJhNkJ0WEVmeEtHQUhPNEVvV0lYVVFrZmVp?=
 =?utf-8?B?V3Y2UkV0c09VeWp6aTRsaGUvSlVrKzB3d05QZmhBQ3NxN0p6UXdJYUJDcE1Y?=
 =?utf-8?B?eHFsTDJYOThnU3pKUWFUL2NEbXY4VGFuRjIvMUZCdkpGWXF1ME1SWGZ1TUhX?=
 =?utf-8?B?S00ybjc3WUFzSER0TXV4UWFVd0hBczAwTExFcC9ORWhTSGh6RW4vbFpPZDhC?=
 =?utf-8?B?K29FU0Y3S0plWm1COXNuNEZyRlAvaWhTRCtBVkhsanhMNVR1T0ZzcU9ueTBV?=
 =?utf-8?B?dDhnU005MW13VTgvOGJTbGNGMEp4blQ0WUN4L3pSV0E2b3RxT0QxZWdQN2Q4?=
 =?utf-8?B?dllvejVLcTQzbFVLWkcyZDg5VGdjOTZFbXRLbmI3SHZ1K1FnSzNJZnR2YVFm?=
 =?utf-8?B?NTlWbmJhOFlqMjRuVWV0cW80TGZzUk9jZTJab0JSWVVrMXBkYkZJWWNkVXIx?=
 =?utf-8?B?STZkaURQN2tST0xOc2MrQmt5bVNkT0xRSDVsU2hYd0VXTkxldnhVVkpFS0lp?=
 =?utf-8?B?c2ZJWThSNzVwZGxRTmw2OFhXUk5LV29NaW8xVHdSLzRtZ0J2K2FvUFNuQStH?=
 =?utf-8?B?NTcwUG9TVjg5RTF3UGE2WVN3Vmc2NmdHczgyM3NMVGNQeWNqamsvak5wQ3FO?=
 =?utf-8?B?VTJFd3JYNFhuRFZNTG9PTFNCQ05uTHlCdXMrVHVDcUVkaHA1dW9tbVVucEY0?=
 =?utf-8?B?R2o1cW5FLzlZcHBiZktxNnM5OFRTa0tFVjRBZmNSQ2ordFgvKzZOK042Wk5I?=
 =?utf-8?B?YlBZSklPT3JkckJPMFE5UDFNT1NyWkRYSng1L0RPTmNWWGwvaXlSZnJheVdQ?=
 =?utf-8?B?bFVYdHFSbmlqTGdBVkFkY0JsdDZuUVdKdlU5Mm1LdFM2R1NNMjgwcElUaSs3?=
 =?utf-8?B?THNtaUdyQ0F2bHUxY2hZK1BMODViWDJabThvclBBUzBSaUpQUjc2c2lxcWdj?=
 =?utf-8?B?SzN1MUF4TTNPclVyK21YMXo2aUFld24wejIvWFdSUUZtaGNpM3k4azdVYVB4?=
 =?utf-8?B?RzFUaFpFeFR3cTEzdWRJenAzTnRDeVVsd2xqRUtlWTBENUQyUDRnbzRXSUxH?=
 =?utf-8?B?NWlzN0MraUhrc3FyRnlTcTc4MHBxdWs3d0RUT29PM24xd01waHFPYzBBMlpB?=
 =?utf-8?B?RDJSVEdaM2V4bVRxSXpUWnM0NUFseWp0Z1BaWFlBQ3ZDdU5hczIrL3NHOVJv?=
 =?utf-8?B?WFozZ2xsclV4YnU1ZkhoNE5PYjRIcXowa1IwQUtaajFCOVJVS1ZSOW9waWkx?=
 =?utf-8?B?ajRrdFl3QmVRNXRnTHVhUmVuby9seVZCMjUvQmR3Z2xiWU1xcUZLc2VmU2dm?=
 =?utf-8?B?VVFNNlhsQ2xEclMySVRDM0F3WlF1ZHFlcWNNQlcyUjRMa1ZxY2VBSkFyazEr?=
 =?utf-8?B?cGtER05DdVlEVTdYMll0NVFFcUpoRSt0N2UvcWpQOGxueGJNdjNFcm84cG5z?=
 =?utf-8?B?ZUd4NWZaWVVrV1lvclptQXpDcHhudE9ZQ1RlNmdJUUZhWTU0WnA5Vy9MWG5E?=
 =?utf-8?B?K2w5STNxZGlJMDZsMkRTNUpkL0Npb2dVMEtRVmlWUnpzeEkyc0MwaC93djM0?=
 =?utf-8?B?bnVPRTFzME92bjdxUS8zcTF3cEZhdDhuKytNV1kyZmJkcXdJMG96TGE5d1Rn?=
 =?utf-8?B?NGZtU1hkaU44VXlxTHM4UE9OWjFZdnB2R2VRT2xMNnRIdytlUFN0TzU2Vndw?=
 =?utf-8?B?cU5qOEQ2S0ovc0NscGZNVlFyZkxsZlplaThHM3NoU1VrTSt4eVMvTUFyV1dQ?=
 =?utf-8?Q?gUFc67yY/hMB2Wdi+fZM3bB0vb5QcKYmzaUKgPl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd42a385-639c-4b83-f362-08d8eee563de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:53:46.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBC3O8Dv0T8aOkdthWKBRielXfbzFup/3FwvkoNRWRlpbRPDP8sahlB8tvvEDsNSGjwz2lVyYo+H7rrDkmX0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3207
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 1:43 AM, Michal Hocko wrote:
> On Tue 23-03-21 11:51:04, Mike Kravetz wrote:
>> On 3/22/21 11:10 AM, Roman Gushchin wrote:
>>> On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
>>>> Cc: Roman, Christoph
>>>>
>>>> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
>>>>> On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
>>>>>> The locks acquired in free_huge_page are irq safe.  However, in certain
>>>>>> circumstances the routine update_and_free_page could sleep.  Since
>>>>>> free_huge_page can be called from any context, it can not sleep.
>>>>>>
>>>>>> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
>>>>>> new routine update_and_free_page_no_sleep provides this functionality
>>>>>> and is only called from free_huge_page.
>>>>>>
>>>>>> Note that any 'pages' sent to the workqueue for deferred freeing have
>>>>>> already been removed from the hugetlb subsystem.  What is actually
>>>>>> deferred is returning those base pages to the low level allocator.
>>>>>
>>>>> So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
>>>>> should be in cma_release().
>>>>
>>>> My thinking (which could be totally wrong) is that cma_release makes no
>>>> claims about calling context.  From the code, it is pretty clear that it
>>>> can only be called from task context with no locks held.  Although,
>>>> there could be code incorrectly calling it today hugetlb does.  Since
>>>> hugetlb is the only code with this new requirement, it should do the
>>>> work.
>>>>
>>>> Wait!!!  That made me remember something.
>>>> Roman had code to create a non-blocking version of cma_release().
>>>> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
>>>>
>>>> There were no objections, and Christoph even thought there may be
>>>> problems with callers of dma_free_contiguous.
>>>>
>>>> Perhaps, we should just move forward with Roman's patches to create
>>>> cma_release_nowait() and avoid this workqueue stuff?
>>>
>>> Sounds good to me. If it's the preferred path, I can rebase and resend
>>> those patches (they been carried for some time by Zi Yan for his 1GB THP work,
>>> but they are completely independent).
>>
>> Thanks Roman,
>>
>> Yes, this is the preferred path.  If there is a non blocking version of
>> cma_release, then it makes fixup of hugetlb put_page path much easier.
> 
> I do not object to the plan I just want to point out that the sparse
> vmemmap for hugetlb pages will need to recognize sleep/nosleep variants
> of the freeing path as well to handle its vmemmap repopulate games.
> 

Yes,

I also commented elsewhere that we will likely want to do the
drop/reacquire lock for each page in the looping page free routines when
adding the vmemmap freeing support.

Unless someone thinks otherwise, I still think it is better to first fix
the hugetlb put_page/free_huge_page path with this series.  Then move on
to the free vmemmap series.
-- 
Mike Kravetz
