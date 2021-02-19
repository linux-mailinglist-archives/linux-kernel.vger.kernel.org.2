Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951A31FD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBSQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:47:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51682 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBSQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:47:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JGiRh0127440;
        Fri, 19 Feb 2021 16:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RudEtBmNOTkeC4drR/LZ365BhC2NxIcUnsMDrj9p8Pw=;
 b=ci0uDVJSdesScN1x1HPzAE0tZJ5XAebKPnFOctoEsfA2WdmNyVFfp/FySx255A9fVIA/
 NIjzlFVQ/hrj7LS5T/i2SA8OOhZORZwpG8ogIV6bLwCWIq+NZk6jD7ioOuvybnk4xJXR
 S6fXOOoiJ4Hc7MNEprpwHAUxNC2ll8a2HJxHpHIht8C2van44bXn7SMh02ugqpvh2X5M
 oIQ041WkTvQSnAySfi8bQo4xACuO05TALg/Ut7MBlOKWIuEaktK/yNUoL9R7/I3w9CEB
 Ekrx0zc3BE3NchP25suVLUfYNZLofROsAhZc8riJu2toZWpm+fqFXCUJaHDJbmyDV1oV lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36p49bja32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 16:46:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JGjlwX105216;
        Fri, 19 Feb 2021 16:46:00 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by userp3020.oracle.com with ESMTP id 36prhvufr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 16:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZKb5Ahc14vzn3GNEhj91tF/BrWQdLVfBkDPfl7N/lp95tNW41a/x0bwMuC48ghgTY1jdpyAKe8WuwJCmQpmoWUkd4mGqe5AcuQbaAp+GiAKVHc09Z63aMzaKWJylBIrd5aqnGa9u3A10h6G1V+YSTzvMDWyuqI4Rg3TKkIV2mbIbRA1uImwjLRacVuR/xlS7VQbPAC2NkJnNBVl+kDx6mh8l08PblGKZxQChPLu1MdhobqsTxQmGWLgCHac24RTBYBqGz/62aXxqYvfatcwPybifaP2Eqde4/pW2Z9iVAduCoSel+8VSFruvlsbSlxFobx7WbzQ2QMQAOTPIT1rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RudEtBmNOTkeC4drR/LZ365BhC2NxIcUnsMDrj9p8Pw=;
 b=L4KBjwZbQEyCMksYLKJ/nNlBgmP52ZVI6gHoPEpMdnxHN4DZlElDMRvGY9pSyp+44IB4RVHTKtE6TYWm4V3EDzhYHK1GT1iWyutoj83RQ8D/TVrW5Q2FnFCQPhscNvZUz6UupDmLhsc0Db2Fd1kpRvEudwlU4LMt73YFrpA2yLMsxw4BiHzCbp0RVE/lfzEM5AXksM19uOXBWv4WKv+fatw5DHh3qdaGtN6B9PhAXsm9uIrzsTBicEobCfqeOVke+f/RgACh9aAfxL+xWVLeTUXJ+KhlAsd55mIgfUeFCrH356GqS5PdJHh5r3wmuG4zvUdLf5U6Pa6c+Iq6R0IFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RudEtBmNOTkeC4drR/LZ365BhC2NxIcUnsMDrj9p8Pw=;
 b=lPR7pYHErXlQafEbX57EfDiYJE2KCpg0Vrl14vJRJ7oZ9G5Dv2KwdReZwFnnSXWsOHZX+jD9kDDOv4YKX/NCbQ7lv+8Se87rPr9rtk7gu0G57dxWBYZVLc4zmSXHuEK4Ohz3oOkhAIqxAl2N2o56QVrU2uLqUzfoFtEf1hXgwjg=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR1001MB2394.namprd10.prod.outlook.com (2603:10b6:4:34::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 16:45:56 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 16:45:56 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
 <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
Date:   Fri, 19 Feb 2021 11:45:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by SA0PR11CA0151.namprd11.prod.outlook.com (2603:10b6:806:1bb::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 16:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efe1386-b3a9-4471-a2ed-08d8d4f5d431
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2394868EFC48B9099B5E1D7EE6849@DM5PR1001MB2394.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cz5nBgbPSRZzAf0fGUpSrQFeXKwDbq+SX4ZESOLsKCHXSCETzBHn5yZ1459Hn8pbvDtQ3rXRXB7Ro/aQ/oXlE2r8OisQQ9PYKUT3teyTEl5/W5WU4lYORU0VNk096fWIvomuZoRl9UYMJSfXSjrBoaXWpAavk1mn1kQuiHZmcOMtLJqMqwo2hEYn9xlVExbOTGkOGeDgAkw9Jqry0xCOlhMROImEwEoQ1bt20qMaEvn5XNObl/PCsJa0dOigtPPyrfUwSqIAf43Y+FY8NL+30FyX9QmsMJjC+R4jDYt46hDJhHMfJmAsudyshW7MR2VQUYYH8sacTq9qxL4ziyMd6CKOrOBrlg4sf8Zu+OR1ytrdf8CoYZ4UjZC4EWUzNkJd0wzv0kfFuBccoN4x5qonnQudEOONtS9Ucw+cSqpiGs6ObB+N1i8UidbhyjEzA45+pjIEnyN1Enq4wdmXsH6oGBLaXfVNwLpSWVi8Hn8pPF4ZiVWxDkJUaQFeisder9C8vamat6a0VQHZQMwQG1aM6DI5coafX3dyrE5ktGKHlE1l0QifC/PfzC5jywQQEdl50bmBNPQ/fXksOs2khuHLB/Pa3iopX/+mJP8RkQ2oAwPmVUMb5cmpSqcKJ0SDDrnFRS7XBsJgRdrftZjScZyZJmK4hHMRWYYYZyb5eg2ngdnrqirqLsZWV4fp9smxE+Py
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(2906002)(6666004)(16526019)(36916002)(54906003)(66946007)(66556008)(66476007)(6486002)(16576012)(186003)(53546011)(26005)(4326008)(8936002)(478600001)(107886003)(7416002)(86362001)(83380400001)(31696002)(31686004)(44832011)(8676002)(316002)(966005)(5660300002)(6916009)(36756003)(956004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OHgvd1R1emdQK29TcE8vTk1jT3V1OVpNZ0RuMlBKNjRsMGNESjFXamNvSXVF?=
 =?utf-8?B?YnNqcGdzdW1tNlMwWWNnNytYNXBwWUpkQ3JwOE5OSDgrbEhrUG8zeHJESTdq?=
 =?utf-8?B?Ujk5VmxPMnFxVWdaMTk4MDRWdE56UUQwMXhEblFKT2hwSDBQOE9JZlR0TDRB?=
 =?utf-8?B?NUZlVStQQXVrL3NMMXo3Yi9mWWxJU1Vyc1Q2OTJPSE1mRThEYWVIVjZHY1gx?=
 =?utf-8?B?alJyV21BYUViZzhxN3hPVm9HUndEWkY1alp2bk95TitJODhIZkhESUR1TGsr?=
 =?utf-8?B?NVZZK1VyNXk3MnlsUHhqVm15cXFFZ0FwZWxDc29BUFpBMWR4LzNUSGdZZ29p?=
 =?utf-8?B?MzZNMzJERmtsV2pDTUhoMTRnSXdvbElVRWZJN1ZkRDV1SlIyalF6Z1FpVzdT?=
 =?utf-8?B?MjN0UjdoTXEyTTNKWXFUS2xVbExlZkIxK1Z0WEJsVWs0bkxtZks0bUR2UnJq?=
 =?utf-8?B?SXB2cHMrYVFxcHFTa0dEeUxtS3NEbDZvcGZnRjQzOEdLV0g1clVMWUU3UlpZ?=
 =?utf-8?B?MkRpQVhQZ2R6aXJxN1VTaFdQcU1MQ2t0MWlnY2NIc3IwcHVTYkhOMGxVYkZx?=
 =?utf-8?B?ekFaSjhGU1lHSDBTVmIyb1doNHNtcWx0aEZSdUF5WWdCK3oreExvbFh1dEdU?=
 =?utf-8?B?elRobHZuRHd4R0ZpTjRBUTZ4QzN4NkNIY1d4L3gvc2dHYVZha21wK3lTUFRv?=
 =?utf-8?B?RW5TQXdpbWxOWVZqOHYzSkZ3eS8zeWVFT0lZTGtjaWFxNUpuSmtxUkU3Uy9i?=
 =?utf-8?B?bG1RUGp4NDRhV3lWU1hRSXJRNlhUdU1vcjAvYUo2dVhYVkdTRVc1Y2h3SXJt?=
 =?utf-8?B?T1Q4T3VqeUl2NEJXQ0lPUXhwMmhiTjdBUGRkY2twTFEwd2xVRjk4VXlOd3B2?=
 =?utf-8?B?ZG1uMllHWXBIY1BISnVMTE9RRWk0ZldXelorZXRrVzNkTHU3d0ZNNXJvZDUy?=
 =?utf-8?B?aFRwRnEvdnJYdjQyZTh3NVRQRDdNbU9tQjlyamU4YWNRWndPdDdsaGdiRUtI?=
 =?utf-8?B?ajBPSnJldWxhZndZNW1KdW1ueUVhY0Y1c0FFU3ZNVUhyUXZtOXhrcUtveDY3?=
 =?utf-8?B?VzU4aFVFWGU1M2VNeU5DRXNLdTBON09VcmdEM2lKb1A3R1IyWGVLZHV0VW13?=
 =?utf-8?B?Szd0QVNnd285aGZrT21HRFhCQngvV2NUcGtlQmoyeERWck0vOS9xK2FvaGlN?=
 =?utf-8?B?VC9PdEg0THNCbFZIMWZIWXlFaXFTQzlQVkZ2a1pTTWpOVTh4VDM5UnlEWEZV?=
 =?utf-8?B?ZmUvMFBZOTd6VXFpY1krWStLU2xpYUd1RnRvRUd2QVc5V0xlMHZCZVJ1UWw5?=
 =?utf-8?B?dVNCWHZ4WlFSeFo3UzRuNE9oSWkvZVNFd0VUdU1SV3BRTU94MVdHZFdRQS9M?=
 =?utf-8?B?V3JlSWFwTTY5YlNKbkRYNUMrdG9XdWgxZWVrd2RKZHBhNWkvUDlCYzZkaFFR?=
 =?utf-8?B?Zm9ZTm52UFBMRWlhS0NYbnJhTTgyU0NSamxOOUgwYy9vZm1sbks5WTFtRnBP?=
 =?utf-8?B?RnVTbHVRSTdQQ0p0VlNLalJ0RVd0cmVEU3MxRUYxRUNCUmkzVzRvMnplZ0FM?=
 =?utf-8?B?djhGK3dISUVPNGJPTXlTZkVEZmY0SjBPMXBFZHhzN3h6MXB0NUxKZW10aGJ4?=
 =?utf-8?B?c1ZBRHVQMUR5K1ZEbDlpM0FIVy9DTStudTc4djFXcWhuWnhmMllmS3ZPbC9F?=
 =?utf-8?B?WDhjeXNaYXliaC94aDhvOVpFMFM0d0MwTFYrVU4zTVRUeGE1TnMyVHhPeU9W?=
 =?utf-8?Q?JwXdci0uhwa+zhS0QLp272Pq+tIsNqWbnQP+EYU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efe1386-b3a9-4471-a2ed-08d8d4f5d431
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 16:45:56.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu9heShPiyTJzMdC36pqyS5o4cXat77545ebNjQmfssUZpyc7cAvOx+GguMe/rwj2AGNgqPZzz+MnX+hlc9CUBqQsqChnIQKF9BcaEMI3s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2394
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 7:09 PM, Andrey Konovalov wrote:
> On Fri, Feb 19, 2021 at 1:06 AM George Kennedy
> <george.kennedy@oracle.com> wrote:
>>
>>
>> On 2/18/2021 3:55 AM, David Hildenbrand wrote:
>>> On 17.02.21 21:56, Andrey Konovalov wrote:
>>>> During boot, all non-reserved memblock memory is exposed to the buddy
>>>> allocator. Poisoning all that memory with KASAN lengthens boot time,
>>>> especially on systems with large amount of RAM. This patch makes
>>>> page_alloc to not call kasan_free_pages() on all new memory.
>>>>
>>>> __free_pages_core() is used when exposing fresh memory during system
>>>> boot and when onlining memory during hotplug. This patch adds a new
>>>> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
>>>> free_pages_prepare() from __free_pages_core().
>>>>
>>>> This has little impact on KASAN memory tracking.
>>>>
>>>> Assuming that there are no references to newly exposed pages before they
>>>> are ever allocated, there won't be any intended (but buggy) accesses to
>>>> that memory that KASAN would normally detect.
>>>>
>>>> However, with this patch, KASAN stops detecting wild and large
>>>> out-of-bounds accesses that happen to land on a fresh memory page that
>>>> was never allocated. This is taken as an acceptable trade-off.
>>>>
>>>> All memory allocated normally when the boot is over keeps getting
>>>> poisoned as usual.
>>>>
>>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>>> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
>>> Not sure this is the right thing to do, see
>>>
>>> https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
>>>
>>> Reversing the order in which memory gets allocated + used during boot
>>> (in a patch by me) might have revealed an invalid memory access during
>>> boot.
>>>
>>> I suspect that that issue would no longer get detected with your
>>> patch, as the invalid memory access would simply not get detected.
>>> Now, I cannot prove that :)
>> Since David's patch we're having trouble with the iBFT ACPI table, which
>> is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c". KASAN
>> detects that it is being used after free when ibft_init() accesses the
>> iBFT table, but as of yet we can't find where it get's freed (we've
>> instrumented calls to kunmap()).
> Maybe it doesn't get freed, but what you see is a wild or a large
> out-of-bounds access. Since KASAN marks all memory as freed during the
> memblock->page_alloc transition, such bugs can manifest as
> use-after-frees.

It gets freed and re-used. By the time the iBFT table is accessed by 
ibft_init() the page has been over-written.

Setting page flags like the following before the call to kmap() prevents 
the iBFT table page from being freed:

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 0418feb..41c1bbd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -287,9 +287,14 @@ static void __iomem *acpi_map(acpi_physical_address 
pg_off, unsigned long pg_sz)

         pfn = pg_off >> PAGE_SHIFT;
         if (should_use_kmap(pfn)) {
+               struct page *page =  pfn_to_page(pfn);
+
                 if (pg_sz > PAGE_SIZE)
                         return NULL;
-               return (void __iomem __force *)kmap(pfn_to_page(pfn));
+
+               page->flags |= ((1UL << PG_unevictable) | (1UL << 
PG_reserved) | (1UL << PG_locked));
+
+               return (void __iomem __force *)kmap(page);
         } else
                 return acpi_os_ioremap(pg_off, pg_sz);
  }

Just not sure of the correct way to set the page flags.

George

