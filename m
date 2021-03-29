Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3D34DC06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhC2Wpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:45:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhC2WpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:45:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TMd23R181379;
        Mon, 29 Mar 2021 22:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VndeSK/yOVqA66YYiXg3RubANZD27gg1AgF+93ceKrk=;
 b=0EC+22Rwdizitf6Zhw4+3TVm7ESoAdQzmfoDV/ZVSDDvTuXhk0JDWce/RnBbI2PDkbN+
 49jlwPiuDD1AoBhuDXwqV7ivoNbmZqejGC68qlD0T8NhXeUOt0dRo5Mt4F6qlfIScYU0
 gmlCNpK+7cYYuEin0fqEIoRnf5PPEcAp2QWwuCrSExiWgXLrQnd90q0c8w+fSMVzHjp2
 ehQQd8MVqIdtNH1eJZmNy7txYDVkxvjiYUpdBZ79oJx5IWEMvTVSPVM6026VuBU+NwZK
 xqIPK3tAXVTVgL/e87Yax55XsmJ7CnxVSNU2ysQG4FSK8WymRJGCj/OfKkO9465UGSLZ 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37hv4r564n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 22:44:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TMfXrE163261;
        Mon, 29 Mar 2021 22:44:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 37je9ny9pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 22:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmf8/w+Dg34GTSqh7Tc9BAZqp/QLU5mzz7TU+e+SqetAJHIjqpirs92P6a4ssIqZ63EkEO/gbbCCEqrlb2OygfJwMXxzOCBYYhmnrUoObuy7E+H8wv7nZuPS0mzrAnhvyRoeFwfBP2DPzxbqaHgZAM5n3aa+b56MWwRH3/eDCuJ45c+9Y7zS5i6TC6+4swTGojHVF+NKmLbZ/6pjfdTaoM5irZ7FCgzLChgbER505gi0CWKmYyigkvwVPO9RWiHijYiUPQOEzlWFLTfAKWKdlH+Jn4ZNZ7MaVlDcJMWXc2rf4XSvJ+MjNfMXh2B7IXyG0cMjUGIYXY1+BeYsTQG9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VndeSK/yOVqA66YYiXg3RubANZD27gg1AgF+93ceKrk=;
 b=MhxI4aKfDNIAfe0ghjO9g9vPj2APmafb1XNo7mQz+tSQei5adbDI+U/lKKwTurr6ccy8ZxQTgmFC4iQZY8CHSeEwLQQESujpEnNShQAyzgE+estyYPB8k5RrAOfYHZqnlUfMrVjar9hO6ACNyW/61x7EWPr5hxL37R9bcqIrbRD6+B1J06WPKyK5p7ed7iaXPA3IU0884gwckO34F5C8pY3cmUl0x/ZaFpsYt5KbIwZ3G9FeAaYiOpO1e2Dw1x2utsFi8O1P6pc72EI09l6awCvyFCrA6EJPuqX4H8xi0FeMNhWfPSOoEiq8TuKqYQ/2IiI9dyjjAlMVkrkyqjFWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VndeSK/yOVqA66YYiXg3RubANZD27gg1AgF+93ceKrk=;
 b=wVNQtEv7f2Reu/ldOgrJWeqvw11qanvnig1/r9VXhA84lS+ogIVousPjNdsSBAL2oEgU8hAcsdD/iNibiHnZqRanHBXdZhnQBvNOY3VRjdoWFqUqQMm/KBX7MTipD4o6L2sRYQAtD426KSPW5JwZUjzV1Hc+L9m/sMg4sOTOPIs=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3095.namprd10.prod.outlook.com (2603:10b6:a03:157::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 22:44:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 22:44:34 +0000
Subject: Re: [External] [PATCH 7/8] hugetlb: make free_huge_page irq safe
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-8-mike.kravetz@oracle.com>
 <CAMZfGtVghACpXiXRrNhQa-fM8A+-xBZvsW+QiEUU1Rqjhd2W5Q@mail.gmail.com>
 <YGGGfBE0JVrxyFsW@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b593cd13-35d3-8311-9e72-46e6a1c5b72b@oracle.com>
Date:   Mon, 29 Mar 2021 15:44:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YGGGfBE0JVrxyFsW@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:300:ed::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0040.namprd20.prod.outlook.com (2603:10b6:300:ed::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 22:44:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81e21448-b107-4ccf-f690-08d8f3043959
X-MS-TrafficTypeDiagnostic: BYAPR10MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3095B9D89C0FCDF9DAE3F33FE27E9@BYAPR10MB3095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Hfmm9vXDkuMjf16olqoK11gc2vaagSLT3N7nvfoQ2iZvXJfZUboYXlnwv2Vyd2jKzeUTDmzF5kSIgeVlIe/rCBxaroIi/kekM26j8Wofgr1jL/Pus9CvLyeHri83SgT6EnoJnqUt6QW8m2sFdoUJELALJb8qcn7W1n3g9dYD45r8iwKuMiuz8t9I+BhC1TaaI8h95ptzrqBOgfTgyt17nLlvkUHdX9avNDQdBJldE+ccC0+7uyXm1RrluE/1nlz9dF16FzcTqJlGh9UuHUvssFECwnCXeLXyoyvrk0QLsc4Lo5UmXlV0sqRZEGOWN2ktJaTECtcTPMnLkoyOxSdabnU9VhniYk9SHVI1QF8Y7gLZ91mSNvqgPJwu6DrbAKZfvRZ3rS8kh+YQJZpl5QPSEtTuk7uuSsEp4ZZbyLaJ4uZY09wxDx6KyzciFTOrMCvWz/lOB/+FnuwI8185gPfJ8JSITlh9loOhUytfvGiSGKFScATOFlIVMYbgTtOmgO6KzmB4+rlw1tsow/u5RC96aHSDF0duH7Tas96mMR6obqjHLuu3pWpc9vKarRrv7cLQrDpo2Hq9fu+pOSFCB1gMszkttLAeC105DTPuq+e01DfOpdpVQWyLS+IJ5Hnn+kgpBEyYYXNbMEjj+5wi1n+0dp2XWIhMklQrd6+49fOwUQZPD3Ln4IPRIKu1PVu06RKXnaNwh2x/MD1Aic55IxcsPGeBjmXXRDPMVPT/SBEkXIITwKVql54yT9kRpY07FMf6CVD+D8VcWl+1xK5AAn7+HM1a2XcZjoe9NDqFHCo0J2FnsF0av1pjXyQjuJHLN5M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(44832011)(4326008)(2616005)(66476007)(66556008)(66946007)(8936002)(53546011)(956004)(54906003)(31686004)(38100700001)(110136005)(86362001)(6486002)(5660300002)(7416002)(186003)(26005)(16526019)(83380400001)(36756003)(2906002)(478600001)(316002)(16576012)(8676002)(52116002)(966005)(31696002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTJ1MWtFNUxKZTlBT3ZKNkxaV2pVWHhNUGgxcFpYL3cyNjFpcmdsMXZDZmVp?=
 =?utf-8?B?bWJ4U1hSR3hwVFNZZ0pXcWpmemFNTG5nSWg4SDlOSGdMVExiMkhETjFJdng0?=
 =?utf-8?B?algvOFAvYTJEcnY4UjB3Y0RiUVI5YWJCa0hxKy9TS2dITmlTVmJUbmxPS3E2?=
 =?utf-8?B?M0NCdlA2c2ZwaEp4TmlRWVdJOGVzOEZoK01UQzFWVE1Wc2htY0pzTlFoTEJ2?=
 =?utf-8?B?UVFpd3FoQTlMV1VUUkp6UFQ2eXhOWCtrbzN1WDFRTkNFa05LWkJKY1RPQys1?=
 =?utf-8?B?OVgyMXorQjVzVnpxT1dUQjFmdHZCSVJjK1gwTHUyUEc2cWJTcExWQldlYWZD?=
 =?utf-8?B?TUx1ZjVQZVdFbGg4TGo5QU9XM0xlSmNiLzI5TVZCaWRwbG9PNTJuZ1hQOWFM?=
 =?utf-8?B?enRWR3BkUE5pc1ozUGhWQ2xvTlc5SXRqL0ZaR2lsSWZPcVk4eUV4YWxvMGhu?=
 =?utf-8?B?eFE0dmNaWW5WZm5jMjZXdS9LK05Gdjc0MVlmNUE0TUk2VXlzNmNuaVByN0di?=
 =?utf-8?B?ekV2UGsvWGprSWZpSUl0d0RYbnEwSDI0V0pvbkNONDRENWdSYVBVS0ZxenBk?=
 =?utf-8?B?ZXhuRVJrWnIzMmdkR0ZNSFBOYy9DNHdGSjJpaWdHOW9HN05LZm9IbUc2Yzd3?=
 =?utf-8?B?TFVzMkxCOVkxZzRXU2dLY0E0VWxoRjJIWUJXM0VUS2ZhT1o4aG1hNjJpTWVx?=
 =?utf-8?B?MGhpOFBjTjBxRmJJRk9PQWhvV3dLMGNWRkhlSjU5bGE2SVFnL0YwRUJhMGlT?=
 =?utf-8?B?eGN1NEJ2VTc5c1JQRG5EUDVYV3VJYUdITFNGY0JJVm0wOVorWDQvRzUrL2VQ?=
 =?utf-8?B?aDBOV3Vua1V0Q2RTbk5pcFEwbHluS2lGS1RYWTRSMnZVNHlLSWR3T1ZGNnZ6?=
 =?utf-8?B?M25FOCtJZTNvTVppRWsyQTh6QmFXRlVlZ2xLcHQ1UG43M0phQmRWVkJRdmhx?=
 =?utf-8?B?NEFDNUFxRjZraDliY3l1c1ZFd1JHK1NQem5qYTdEOWppaVpwNmxnQ0JWV0VU?=
 =?utf-8?B?VFVTMzdaTW5VM1hZNXlDbi9zTHpESVhFV3RkOVdNNXg1eW80V3lod3BXK3ZQ?=
 =?utf-8?B?cTFWQ1QxUlMydGJqNWkyeXNEdFljLzFxeGlpL1ZnSG8xTUdOem90cElpSDZu?=
 =?utf-8?B?YWk1WTZNZ1dYTEp5MmgwblY2UVJBSnc0TnVxK0oyNXpiSUNZc3hLbHlwUTZH?=
 =?utf-8?B?TzdQZ3JaQzZlWkV6QWRsR2R6ellZU000WkQ5VHBrSHdyemlOVmxWTXhUWng2?=
 =?utf-8?B?bGNJdkg3R1k1M3BLQ1FCL1FOaVhCV1E5N094c085S0VjOGcwVnVKaVo1a2Fz?=
 =?utf-8?B?c2V6QXpNRjhPc0JBaklPOCtjUTByTmxJUkdLRTBpNmZOVXJSU3c0SDUwWmdQ?=
 =?utf-8?B?a2pvcytyYXQ3Q1p1T2xYQm1TcVdWVXpGaWlYQkpkZXpFSmtOSER0RlNBSFp6?=
 =?utf-8?B?K1VUK2tTUXZjWTBKT1ViK04rVWczUmJqT1Y2M0dhV3IvcngzU3NzZGNoaFNT?=
 =?utf-8?B?Slh2aXh6NUttQWE5RWRxU1hJaEMxRFZ0VDJvaDBFUDN1dDlvVTZtOGFvL3Bn?=
 =?utf-8?B?RHZBdXZuUUdiOWkvVExGZU1hM3c1ZjdoaWFsQXpNY1djcE81eURET1ZSanVm?=
 =?utf-8?B?cXRnSUpNV2UvVWVrOVJnenRYY2tDY1Mydm12WE5PcFlJQ3hLc0lDTmphWmRC?=
 =?utf-8?B?VDNNM2xOWFBZWk50ZE83Q2FVZllqYlVwTStPZXM2TVllQnJHM0dlWUozdnBX?=
 =?utf-8?Q?DHVQ69MLRHxenYFvAtYWMvtrHsXtQ1axWFPpEGB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e21448-b107-4ccf-f690-08d8f3043959
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 22:44:34.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1qWi0iNKYzjFvDpEhkocJCDctpr4Z2NU3NGXTdEXFsVSkuwnO1J8OrWUuCl9S2QO2Ig8Cvn9cFWNlFQGofOqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290167
X-Proofpoint-ORIG-GUID: 67vA8h6fgZgZhB7W0O8hH861xo-lq-sx
X-Proofpoint-GUID: 67vA8h6fgZgZhB7W0O8hH861xo-lq-sx
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9938 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290167
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 12:49 AM, Michal Hocko wrote:
> On Sat 27-03-21 15:06:36, Muchun Song wrote:
>> On Thu, Mar 25, 2021 at 8:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
>>> non-task context") was added to address the issue of free_huge_page
>>> being called from irq context.  That commit hands off free_huge_page
>>> processing to a workqueue if !in_task.  However, as seen in [1] this
>>> does not cover all cases.  Instead, make the locks taken in the
>>> free_huge_page irq safe.
>>>
>>> This patch does the following:
>>> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>>>   changing spin_*lock calls to spin_*lock_irq* calls.
>>> - Make subpool lock irq safe in a similar manner.
>>> - Revert the !in_task check and workqueue handoff.
>>>
>>> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> The changes are straightforward.
>>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>
>> Since this patchset aims to fix a real word issue. Should we add a Fixes
>> tag?
> 
> Do we know since when it is possible to use hugetlb in the networking
> context? Maybe this is possible since ever but I am wondering why the
> lockdep started complaining only now. Maybe just fuzzing finally started
> using this setup which nobody does normally.
> 

From my memory and email search, this first came up with powerpc iommu here:
https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/

Aneesh proposed a solution similar to this, but 'fixed' the issue by changing
the powerpc code.

AFAICT, the put_page/free_huge_page code path has only been 'safe' to
call from task context since it was originally written.  The real
question is when was it first possible for some code to do (the last)
put_page for a hugetlbfs page from irq context?  My 'guess' is that this
may have been possible for quite a while.  I can imagine a dma reference
to a hugetlb page held after the user space reference goes away.
-- 
Mike Kravetz
