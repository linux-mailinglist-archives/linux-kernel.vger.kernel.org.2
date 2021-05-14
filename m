Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14D33802A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhENEDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:03:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhENEDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:03:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E3wtjN080798;
        Fri, 14 May 2021 04:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oLy1AGFiD2JVhdVLZpag/ZhR0NPkdxjIoEVOSfBM5pc=;
 b=M4ORIB+7sI8KjZf/exOCBTfNgGIdawhU6G51DukxL+zMJFChKPQoGSsdOLLciWZpOT07
 t98V0lsCleFzS8T1CiplD9uWLWWoY7VkHc6uWVJReglhPM7tqSVVf4n3Q1BstYKR035w
 WDJmY+AgoZsP09YVsWPofS2T1L7gCsSRoht1voaXdXDs/yYYZjcjfpGImbsjos1AxFe2
 o6I9WNsFU4qLZi1SLiDO9x1nHQRFTtSjYMGJse1YIiZCgKDx0k1EkZZQf+Wm0ywdTuHu
 fFy+gQeQuSe6twZSeFiA6N0O+OihoAlvFvlItN0IVTWnt+VXcyyb9F2ehj/5EjMdWBR1 Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38gpnuk9rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 04:02:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E408BP170678;
        Fri, 14 May 2021 04:02:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 38gppgts6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 04:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwT3WnF1EreMaGYWQUpnygWHzmL4e4z4D+gZAKTgy8zg4KOuCO132RAZpdskSfAY76CSUQunqy6nFEICMxzzbgjFatdsDGwHlolSpOHmcBCmyGV/5I2Fb22b7s/hsfpHwav7qlD7sIxxFllJbPj7LwX5YpAASWvrxM2JEFuA78SteNfs+hzQHOGeM5dVMqOsPZYdag9UsxLzID0gThBq7s4Y8xEHUMI6bnBguftI5hPMtO+6ZUK5/J+6kdF6rGyLqoOwZr+BMNcAbOj0KoOCEz+vfIh+1F0fyQe9IDuhYU0bTb+isgRv6tLNvSmGOPeeJA4dyCgOSJ4qXKrDw3OJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLy1AGFiD2JVhdVLZpag/ZhR0NPkdxjIoEVOSfBM5pc=;
 b=YOw/quJJlLWlOJAmMUjKXdPiATA40VPDY9cKoxpveB8KF3pf1NLjW/EL6/GJe7bfH1kRZmaiOX2sppbX3Vn0WqdrGD22ZlW/M7CD5yVrbns/TelIdrkwbrT6kriUgq7rLsn4+ZEhu1aoGQg8zlsk/lrjw3is7z1YAWpT5LVph9JG+0bkvPKHn5B3UeFlLC7/Lf2Ggl2gW+WbH5XuC90KkoCPUF+foHpii2eeyn/GVfCUkHV0qj31etkEcj66snNsDsOkKey53IX06xV0biKphrnHSwYFnqeiAhWbuEHkTiSPnREdwnawFqyZocEGtkdITw2hKRWz2f9V1NAsby++EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLy1AGFiD2JVhdVLZpag/ZhR0NPkdxjIoEVOSfBM5pc=;
 b=fW1cnx3IYUXPeg7i5uiHtUX/rS8gvWubf8mZjMHhQDZHW973N/JOwXFwgkQVbXLdU9D+uI/pG6JkFOPl+0CDwfPzJhNGpVujkzzMOxSLLu1ADqEH88nQPsst0W7d8vDgQM3w9jmqTsbiuCfFgj10eXQsy07aCMBo44T76TSwHWo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 04:02:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 04:02:18 +0000
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
 <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com>
Date:   Thu, 13 May 2021 21:02:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 04:02:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753294b8-5d36-40b5-8828-08d9168d1114
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4211F3B306F80F329BE395FBE2509@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7+rM4Y8cuAcW41t/O292ZScylWm09yzWvQVnuUJq0SygFRaNGdum+uwQxaHwKurc7sZ4km1WFyLWsdHj22WNuW32BgH/jImeFjLr5Dpw+YGnC9+4Gp8Cwy9R1SypF6QGBbvkFPmAjxliit2UaW3yRhu5ew37EYS/yOPsbZeyGCuLMrUMONfINc6kaKx/UM7PaWWyCIlwRSp7uiewD158aRPhQTj9lpOxmf7dgPUdAxmpZjj1tAMYfRc/rIkSTxVuPNY0qKhaD5gXeMuV7dqV8RPZRYkqZPaAb7VSmIlpvdIXuNOBmDKW8m55XtuXn/rXh5Gs6qXvCP9td947P6SfMx6YA2DXAH/I59sH5DjZtkPzVgVe5SEhfSwEj3hTWnnmuj/BJi/yHp8ZXyD1oiiDoe8CAAKp4ookKGkiqd5BErq5eI9CeICyNnGSA8JWP/ZKuKCC7vrPaHGPUum0ySDdXgtCGqtE5aRJoDh4pIzIERsJEr6V1LLQ8RAtKRknIgNiC1rhsa30BwDC3M1APVnnGxgvMMlYMv3FdThyukZFUepu2HFJ/yTsr8SH+bxQkwg+Of6Y3Xc9FCFD6FtP83+2c/ePdOdUAMC1iueAha/UZsXuccOUZ53O1WEJfZLhm/tZAMGy0M5QOy6ZvgO3z1FAc2wpYYK9seqwEHiOkg19JfQ6LyItkms3DCZnRFZQhtonDKZ69iM5TICwRT7tv2iAy3SDr4p01xalaXfjidDelAd6lqxtbIkAYczTkSU1LYT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(316002)(38100700002)(8936002)(186003)(54906003)(16576012)(6916009)(38350700002)(26005)(6486002)(4326008)(2616005)(36756003)(83380400001)(44832011)(2906002)(5660300002)(31686004)(956004)(53546011)(66946007)(52116002)(478600001)(8676002)(31696002)(86362001)(16526019)(66556008)(66476007)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dm9HMHA2N2VBSHhna0JyRkdiQjhFbkNQUXdtNzN0YzZ0cTNnQU0wZFlXdmhk?=
 =?utf-8?B?Nml3UURBMGZVNEZ1ajVFbmR0eWtUR2hmMWdVS3M5MjVmajVmWndUaWxqVjNx?=
 =?utf-8?B?TEJKNTI3SEpOTW15WjQ2R2FQMW1CQ1R6RkpFdkFoRTU3bXptRkRxd3c2NHhr?=
 =?utf-8?B?RXVzMTByUkZTQ0lVSTdWdmVwV1B3Rk90TGZRWktJRU43THlabjhta1YvaE1x?=
 =?utf-8?B?NFVWTnNMUDRLQmlxUWZDaWVhQWIwQXowR2RCb0E5NFJyUTVPYkcybkV0a3lJ?=
 =?utf-8?B?cHY0ZkxFMllIWVRuTUtWeUZ1QlkydytlWkllTFZLNDlqdEtKbWEyVFYrRm1Q?=
 =?utf-8?B?V3hBZjl3Y0M1dGROVE1UZ01mVWJhVEJhRGplSFVETHJzVTRTUjB6Y0ZxeTEy?=
 =?utf-8?B?UTFCLzNabzZ3NEo4bTVXbGRad0ZJbncxRTB1M1F4RFJWSkJUNnpUR0RNb3dL?=
 =?utf-8?B?MXBWZ1Vmc2IrbkV5MFhScm5ib0JRZ0J3cnlvK1JJUFl4SkJoalFQemNvQ3U4?=
 =?utf-8?B?UEZzZ1J5aWtLNEZNcGlhWjJzd2V4aVlPb0NvRTJ5TDZIbXhnaVlHdVNJK0hF?=
 =?utf-8?B?b2lFTFdzWFF0UFg4YUx0Ri95UzVnUjdIL0VuclBHSGFCaGxUb2tlM2w5UFRN?=
 =?utf-8?B?eHJzZGZpTFB5ZWpsMEpVV3ViRU82Z0J0VUpFcE1tcDVadXFsSmUzeWxaWXFB?=
 =?utf-8?B?c0xZdW4vdTNUTmpRaXM0V3ZoRXllaEg2ZnY5UExLQVQ4MVZ6eTRiRlUvZCt3?=
 =?utf-8?B?S04zT2NmdmM0OCs2eGdNbFhNVVJCL2cxT0U3LzNyS2xqd0dLdnpZT010ZnBh?=
 =?utf-8?B?cWFqTW8yTlR6TFdFYmxnL3gvUnU4bkN6ZWVsV1ZwUU1NNGFXcTFnSUtnRGZH?=
 =?utf-8?B?WThaaGpvbUdTaWxpMmlweHhOVEhNRXRVa1hVMUNSaXhjTXAyQjcxdGdRYUlx?=
 =?utf-8?B?RFc1MklOWVBkRldOeXNvWFNjNVVWcHl2MGVLOHVSVUdKdHhjak1OS1ozUmJN?=
 =?utf-8?B?TDAxWSs2ZEJNemxxZi9CTGN5N1NkOFRzblBoZEhNZHd6ejBubTNhRCsrSDJ2?=
 =?utf-8?B?a1RZbVQyTFlKTlZGczlnSTU5N3hEUlJISWdnZEdKek4yN3NLV2lqQnU0VFZR?=
 =?utf-8?B?MXFlOUl6VEhGRDIvYkpjYVdVTm0vMWdPRnFRd0x3cnlqL1JQSmhMb21QNlRz?=
 =?utf-8?B?Tjk1QU8vRXpGbmNvUkVVYjJoZ3NnWElyMEkyMFBnUFFWdnRVVGtWeklVNkpM?=
 =?utf-8?B?cDY2L1JISDdLanNlMEZleTFDbS9ybVRzcWc5bmYvRUh1OVM1MnRya3dKTVdD?=
 =?utf-8?B?elliTUhBZ2tyRzVvZXZVWjRlM21kbXFsUTMvS0xiamZoRlNIM0ZDbjZHbmU3?=
 =?utf-8?B?QlZDazZaOXRNTzNEOFNiNVZ4Y1YrdERVeHg4LzN4dTBCa2NZWnVsbG10dHVj?=
 =?utf-8?B?ZTllMVZHSGNlRGZkY2VMS2x2Z1RScmJNaDh1eGs1SkVnYmRmMCszeWhoQ2RE?=
 =?utf-8?B?dnNEcFNKWFV5TC9BUC91UEQ4b2JDL0lRUkZNZWxRNTBsY3lsUUJnQytqMlkw?=
 =?utf-8?B?MFR5NC9xaVoyRk5TMTY4RGRBOHcvMWhHcE1TYk5TZEs2YzFRZ3QzYkl3ckF4?=
 =?utf-8?B?K1JBOWhPV2ppUE9rVE1QQkxJRnU1a3A2aDlXMWpGTFlrSVVoZnRIa282MDV0?=
 =?utf-8?B?QzU0UlZnaUl0ZWg1WW1nTjNqUWF5SStGSlR2ODRzN1BEZFNuNW1YUVl3bG04?=
 =?utf-8?Q?OiQg6OmExVE3Od38ZNLGHH8zd4TmPCZv/Gmiac6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753294b8-5d36-40b5-8828-08d9168d1114
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:02:18.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2nmfvBizrmpp8spnkwts/RSd0BWnYSszhSuWSjwOnjBKezs8RS/NxEDNbFBOAqxDkR+dHfFm+MdnbBZbJkC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140025
X-Proofpoint-ORIG-GUID: kE-WU_PKWdFOkvjhjLP0EVfCwveg8IWs
X-Proofpoint-GUID: kE-WU_PKWdFOkvjhjLP0EVfCwveg8IWs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 5:23 PM, Mina Almasry wrote:
> On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 5/13/21 4:49 PM, Mina Almasry wrote:
>>> On Thu, May 13, 2021 at 4:43 PM Mina Almasry <almasrymina@google.com> wrote:
>>>>
>>>> When hugetlb_mcopy_atomic_pte() is called with:
>>>> - mode==MCOPY_ATOMIC_NORMAL and,
>>>> - we already have a page in the page cache corresponding to the
>>>> associated address,
>>>>
>>>> We will allocate a huge page from the reserves, and then fail to insert it
>>>> into the cache and return -EEXIST. In this case, we need to return -EEXIST
>>>> without allocating a new page as the page already exists in the cache.
>>>> Allocating the extra page causes the resv_huge_pages to underflow temporarily
>>>> until the extra page is freed.
>>>>
>>>> To fix this we check if a page exists in the cache, and allocate it and
>>>> insert it in the cache immediately while holding the lock. After that we
>>>> copy the contents into the page.
>>>>
>>>> As a side effect of this, pages may exist in the cache for which the
>>>> copy failed and for these pages PageUptodate(page) == false. Modify code
>>>> that query the cache to handle this correctly.
>>>>
>>>
>>> To be honest, I'm not sure I've done this bit correctly. Please take a
>>> look and let me know what you think. It may be too overly complicated
>>> to have !PageUptodate() pages in the cache and ask the rest of the
>>> code to handle that edge case correctly, but I'm not sure how else to
>>> fix this issue.
>>>
>>
>> I think you just moved the underflow from hugetlb_mcopy_atomic_pte to
>> hugetlb_no_page.  Why?
>>
>> Consider the case where there is only one reserve left and someone does
>> the MCOPY_ATOMIC_NORMAL for the address.  We will allocate the page and
>> consume the reserve (reserve count == 0) and insert the page into the
>> cache.  Now, if the copy_huge_page_from_user fails we must drop the
>> locks/fault mutex to do the copy.  While locks are dropped, someone
>> faults on the address and ends up in hugetlb_no_page.  The page is in
>> the cache but not up to date, so we go down the allocate new page path
>> and will decrement the reserve count again to cause underflow.
>>
> 
> For what it's worth, I think I fixed the underflow with this patch,
> not moved it. I added a check in hugetlb_no_page() such that if we
> find a page in the cache with !PageUptodate(page), we will reuse that
> page instead of allocating a new one and decrementing the count again.
> Running the test with the WARN_ONCE_ON locally shows no warnings
> again.

My bad, sorry I missed that.

I am also concerned with the semantics of this approach and what happens
when a fault races with the userfaultfd copy.  Previously I asked Peter
if we could/should use a page found in the cache for the copy.  His
answer was as follows:

 AFAICT that's the expected behavior, and it need to be like that so as to avoid
 silent data corruption (if the page cache existed, it means the page is not
 "missing" at all, then it does not suite for a UFFDIO_COPY as it's only used
 for uffd page missing case).

The interesting thing in your approach is that there was no page in the
cache before the start of the userfaultfd copy.  Yet, because we drop
the locks we could race with a fault that would normally add a page to
the cache.  Unless I am reading your patch incorrectly again, the
!PageUptodate(page) path in hugetlb_no_page is going to clear the page
in the cache.  This clearing would race with the copy to page done by
the userfaultfd code.

> 
>> How about this approach?
> 
> I'll give it a shot for sure. FWIW on first glance it looks more
> complicated that what I have here, but my guess I'm not doing the
> !PageUptodate() handling correctly and that's why it seems this
> solution is simpler. I'll give it a shot though.

Ok, I will look into this more as well.  Unfortunately, there does not
appear to be a simple elegant solution.
-- 
Mike Kravetz

> 
>> - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
>>   that you added.  That will catch the race where the page was added to
>>   the cache before entering the routine.
>> - With the above check in place, we only need to worry about the case
>>   where copy_huge_page_from_user fails and we must drop locks.  In this
>>   case we:
>>   - Free the page previously allocated.
>>   - Allocate a 'temporary' huge page without consuming reserves.  I'm
>>     thinking of something similar to page migration.
>>   - Drop the locks and let the copy_huge_page_from_user be done to the
>>     temporary page.
>>   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
>>     *pagep case) we need to once again check
>>     hugetlbfs_pagecache_present.
>>   - We then try to allocate the huge page which will consume the
>>     reserve.  If successful, copy contents of temporary page to newly
>>     allocated page.  Free temporary page.
>>
>> There may be issues with this, and I have not given it deep thought.  It
>> does abuse the temporary huge page concept, but perhaps no more than
>> page migration.  Things do slow down if the extra page allocation and
>> copy is required, but that would only be the case if copy_huge_page_from_user
>> needs to be done without locks.  Not sure, but hoping that is rare.
>> --
>> Mike Kravetz
