Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64611354B13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 05:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhDFDFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 23:05:11 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:39392
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232555AbhDFDFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 23:05:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxr1r82FrdzyWeFO23mOsnHyXoIh/AuQy6FpXjq2xOHmLyFZ7lD9+/lHEor3OoEgj3cM5lnJ2Oz3Drb6NGPk25bZAV4crl5yDQTIN3gCrUOuE61Bul1qE6Tf3QuGiJLbUs3tFrMBVx7alT9ZRaXdYdmY1p6ogiPAhTS1eyzyyYcv/mMlZgnTRqN716Asrn4DZodIUT0tkkl2pH4+xmTAAHBzegjg+WP7/Q1r/Scve+xY118SsoauTwuLH8GY1kdg3VBLmkFH2wUU59bAJfeWZOwSebqpcNUD0Us7j0INza4MvVlvFFm2CMYMt78bXVXJThNxla5Vq1YlECXywGS7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA122XNzORqsJcsdNO3Yb/jI0+kam/NDdgroHgmrPTw=;
 b=Cj58MhTMtyxN4dv6itqWuXEWjNATZ00BJj1KiWpYb/MsZEeqvt8KwoixzCVgKGspTbkz/Ot1XgcdjeUin+0Sei3e3XBBXT8edYDEXADmnWNdYIEBkqr5DFWUvtC6s+jJsDBsEpFEF5uPPRI41jr2zZXMXBmhQXFgw1OxrMJjo/HxMCblw7zkCmovWsBe2+P5YKhsh27L5PodC/oSRGrpqyZGuY/jQQ7TdoxKRu1rPUxxzkCUyqvncq2M1NaYRUznk517a5N5vIL1ph5BrvsXuhHEWrx7McmXD5j4tLrcUIsZp/aXmvU1zt9R475eJgMhU2EatPRs4Qd06skA8lPrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA122XNzORqsJcsdNO3Yb/jI0+kam/NDdgroHgmrPTw=;
 b=YObGr78QjmCCQSy7EGoJAV2ttZqXdIJs6sCjO60MMZ4DO/uymEOczXJ0dM1Rblx+gYE8gpstI2I0OLx5+JavLsVuRAi0ZZbMR1HX5ydoJgrTxFMqrQRtMz3GOPENpOaSYQB4HUtjvufna7IyeaZbRPwm7P4XLxEy1SdnQwswUzE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 03:05:00 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 03:05:00 +0000
Subject: Re: [PATCH 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of
 iterating over vmas
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210404153311.1460106-1-yanfei.xu@windriver.com>
 <20210404153311.1460106-3-yanfei.xu@windriver.com>
 <CAHbLzkrSaODz+SeT+GY3tOS6Jm8NSznmknP83RUCrn+Sr9cAAg@mail.gmail.com>
 <e0fa88df-ff8b-f820-e255-92fbeecc37e6@windriver.com>
Message-ID: <6d188d5b-94d0-1606-52c2-a3e0b6455a27@windriver.com>
Date:   Tue, 6 Apr 2021 11:04:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e0fa88df-ff8b-f820-e255-92fbeecc37e6@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::49) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BY5PR20CA0036.namprd20.prod.outlook.com (2603:10b6:a03:1f4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 03:04:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73866985-f028-41be-86f6-08d8f8a8c413
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4896:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4896C77D8B254E614E6A9F5BE4769@SJ0PR11MB4896.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g90L4YSf5I4S12m/IrCnKXz6+hkaxzr5sL5uRBuA12fLyH+3sb92o/BXZoTI0YcaGao/NNlNvvoOWbYnfPAtzekJ0ZEOOhm0hG2HrbopDB2SOh2Oh6DQTv4nm6P7XmeWSEYNZ5kB3My+rSrWX8GuobnjfsO3p/IX6St6q6mt8OzbVXqUIXmW7A+J8aUxYjeQZuWtk0jFYwJpB8fWZbHg/C6YoyMK+kQ27Ez/NEJZhD8Cm5JiOq6SEaWfFHZOaiwpxbp2R9HfEzGkzExwjFMpHDFV0pXNHIkCdFIyQap9+7nxC0IFho1FAuF8HNmi3o79UJasyuR2hHM+eP+z2Q9gMOrc5sNTMhyzlLceabW6E7o9sB7d7nGRR9H7beDb8dVUo4HLOlyF4dIy6LY5f/LgvBSDVfH16lqrUGff7iIKlbkvUtOKS/vCq7OzvpyMJjKHKRvV5cUW1zbEjz1wAdeXW7zI6Jb9gDyd4KhI3rVjLQPphst0tCXeIlj8YLObVfUyIw2r+coQ9LeoNZVLIJqLOv7XNKxwjuJESWdfTRqjtQFIcitJVQ3LqYV23yc/AQAQiK0TL9HrAXz23zoQPMiAvNTcuQw51MbN5yyu9Um22rHIfwK5piwIOCjnnTjmolo6p2BRU1hnBM9j1RuItR6iRU0T1JukgrZgxkJH8ce3cub9g9rtzZSbsXO2iBFPaqGnGyUuHSgowysmZJjUi1ayeFQXY1ZksbPHAx+S89SHKTE+JhuMjltvQjsvAyKkZWJ0qLlRSQL5Zj/uBYK5yu7Utw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(366004)(376002)(136003)(6916009)(38100700001)(6706004)(52116002)(8936002)(6666004)(2906002)(36756003)(6486002)(86362001)(478600001)(31696002)(53546011)(26005)(31686004)(186003)(16576012)(66946007)(956004)(2616005)(5660300002)(66476007)(66556008)(16526019)(83380400001)(4326008)(8676002)(316002)(54906003)(38350700001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXp6VVVtRTl3Zzc0U3hrMGV3NkhhQldYZm1NTGplMUtGQmJmbXMyenFRVlZ4?=
 =?utf-8?B?MC9sYlg2dk9zM0orNlFsQ25aejU4dEp4cWVzc2YwZERjbTh1dkJTdm9EWHUx?=
 =?utf-8?B?dVdxakNoVEc4c3FYMzlSdEpScThQeTRoajNWSFhRLzNMcWpYb1ZLdkN2ZEo1?=
 =?utf-8?B?c1d4YmVvZmRhNFZFYjA3bU80OTNacXgrd0ZGTHl3cGw5SUVIRXZnaFFYMnNt?=
 =?utf-8?B?YjVoOGFVR0pZQTNNbGlNamlqK0tlOWtCbEQ4MStTKzZFYkgzWVAvK1pUdjZM?=
 =?utf-8?B?a0FubWhDeE9ETlQ2T2xNZ0U3OW9Bd1VpUU1DdFNsZmFDM0VMSFczcmg4dU50?=
 =?utf-8?B?SEJjWUN0OXZ0cDlnejRzYW9WZUJJVHVOVGNXZEZvV0VRL2oyZ3BJN1lUTGtJ?=
 =?utf-8?B?QTgrMHBCOXVyRndFQVFIMTFGakJITGFvcFFzZmJvM0ZPdVQrNGdGMVlkVm5t?=
 =?utf-8?B?akQ1RCtMbGtEa1hmL1NScUFzeURVWjFZSXBBNzl1Y2pJOThzbGxGSmNqa2l3?=
 =?utf-8?B?RkltOEpBZTk0MDZDSGJ2VlUraG1NdXlMKzJuNGxqUWRmVFpDVmR3SHZBZ1Zp?=
 =?utf-8?B?dUhCUm9hK0JUQ2ZmV1NnTE11Snc3YWNVQmZ4eTNNd0Z3MUt5djN2RzVIa1hq?=
 =?utf-8?B?cGVTbjJNMVB1VGJ4cExWTEJxUmdhdzZXMUdjd3NmY25QMXB5NUVhdUY1S3Vh?=
 =?utf-8?B?SmZxTU1SeTBaUkhkeEx0dHlYTDZacmdxUkVzMzkvcFpiamIwdkxGOWFZTU9u?=
 =?utf-8?B?U2VTNjJhd2RJeGlPaktXc3RLUVRSQUtHNFJBL3h1MXRLYXRWbGs3cklVc1RK?=
 =?utf-8?B?UkYvYTQ1aHpqbTRIS0dGNXlSN0N4R1ZMRHBoMUtpMEdSbFFDT3VmVTdQc1lI?=
 =?utf-8?B?ZUVNcytTeldjcXh5d3Ixck95MU9BMkltbnVOVEtyay9VQmtnbWptcFlLYnRK?=
 =?utf-8?B?QndRcWZnUnJTOGpDTDdKUXhHVnNPdmdoN0h4cndCRkl4dGU3TmNpT2RheDBO?=
 =?utf-8?B?MWZOak5OSHJqSEVSc0I5d1ViaXpueDV6Mm9ncHMrcEN4cFNIMzQxdk9yOWs4?=
 =?utf-8?B?UjNsaVBjaDZibUZWU1JVZGVqN1N5ZjZqcGsrRmtJYklMTVBJa3hhSmZtMDJV?=
 =?utf-8?B?U1IyVDJ3UzltdzhranJ2VUF6dkgwd1ZIcUZycTV4bXhSSzZUOVI2M3BSS0dB?=
 =?utf-8?B?Wjl6RXliUlRoQ0p5aXRtOGRHc216dTlQZTlVT1BWcHpNaUpXVVQxUGNITEZN?=
 =?utf-8?B?Qng0cjJDSENiMllvemRGVWxCT0UwNG80UWRUS3V6NHpOK09rd0lBb2N6N2JQ?=
 =?utf-8?B?Zzl1b1R3RktWMUFwKy9LTlJVMTlidTlXdkNtc25reUpZNDNKZkYwUlBoV09D?=
 =?utf-8?B?cDlkME1ibW1GTDNFVTYzRFI5OE8vK2hxZHJaTlMzbDkwVm9CeDN3eklwRXEx?=
 =?utf-8?B?T3EwQ2Y1c0ZLeGRqMU51aXhqUFBEOWE5WExDQkcxTTNDQnNNMDBOUnhyUzJL?=
 =?utf-8?B?cm9SNEFwL3l3SmVQZjRwY1hvVWgwS0JEVUI0UGlXSU8yeERzYVNTR2lWQUth?=
 =?utf-8?B?REFMOUVOS0s1djNsVE92MnpleEMwN1p2NXBqQS9GbmtFbExsa2dDMWpSRkhF?=
 =?utf-8?B?T0VrQy9leEdkNmhDdWVwVGR2alR5bkZHUFl6bW9WYW9oWHl1Si9xRGRnTlZh?=
 =?utf-8?B?dk43VkdpR0dER3cwMEdkS25VSHRJQncyQWhPeFFEa0hudW9SUW9vdE0wQ291?=
 =?utf-8?Q?QnMKi6UcvqpLscGvDlQ4Mng9KHzbtCozFKmmfMb?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73866985-f028-41be-86f6-08d8f8a8c413
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 03:05:00.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5Z4GXBVmS4UFqkgBJ/faA2JrXlC3CxH6WKMQgdBR6h7qmGyUxoLftflrbORr8Y4RDuj67iK0vyMCWGKKCHUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 10:51 AM, Xu, Yanfei wrote:
> 
> 
> On 4/6/21 2:20 AM, Yang Shi wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Sun, Apr 4, 2021 at 8:33 AM <yanfei.xu@windriver.com> wrote:
>>>
>>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>>
>>> We could check MMF_DISABLE_THP ahead of iterating over all of vma.
>>> Otherwise if some mm_struct contain a large number of vma, there will
>>> be amounts meaningless cpu cycles cost.
>>>
>>> BTW, drop an unnecessary cond_resched(), because there is a another
>>> cond_resched() followed it and no consumed invocation between them.
>>>
>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>> ---
>>>   mm/khugepaged.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 2efe1d0c92ed..c293ec4a94ea 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -2094,6 +2094,8 @@ static unsigned int 
>>> khugepaged_scan_mm_slot(unsigned int pages,
>>>           */
>>>          if (unlikely(!mmap_read_trylock(mm)))
>>>                  goto breakouterloop_mmap_lock;
>>> +       if (test_bit(MMF_DISABLE_THP, &mm->flags))
>>> +               goto breakouterloop_mmap_lock;
>>
>> It is fine to check this flag. But mmap_lock has been acquired so you
>> should jump to breakouterloop.
> 
> Oops! It's my fault. Thank you for pointing out this.
> Will fix it in v2.
> 
>>
>>>          if (likely(!khugepaged_test_exit(mm)))
>>>                  vma = find_vma(mm, khugepaged_scan.address);
>>>
>>> @@ -2101,7 +2103,6 @@ static unsigned int 
>>> khugepaged_scan_mm_slot(unsigned int pages,
>>>          for (; vma; vma = vma->vm_next) {
>>>                  unsigned long hstart, hend;
>>>
>>> -               cond_resched();
>>
>> I don't have a strong opinion for removing this cond_resched(). But
>> IIUC khugepaged is a best effort job there is no harm to keep it IMHO.
>>
> 
> Yes, keeping it is no harm. But I think we should add it when we need.
> Look at the blow codes, there are only some simple check between these
> two cond_resched().  And we still have some cond_resched() in the
> khugepaged_scan_file() and khugepaged_scan_pmd() which is the actual
> wrok about collapsing. So I think it is unnecessary.  :)
> 

BTW, the original author add this cond_resched() might be worry about 
the hugepage_vma_check() always return false due to the MMF_DISABLE_THP. 
But now we have moved it out of the for loop of iterating vma.

um.. That is my guess..

Thanks,
Yanfei

>          for (; vma; vma = vma->vm_next) {
>                  unsigned long hstart, hend;
> 
>          cond_resched();                 //here
>                  if (unlikely(khugepaged_test_exit(mm))) {
>                          progress++;
>                          break;
>                  }
>                  if (!hugepage_vma_check(vma, vma->vm_flags)) {
> skip:
>                          progress++;
>                          continue;
>                  }
>                  hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
>                  hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
>                  if (hstart >= hend)
>                          goto skip;
>                  if (khugepaged_scan.address > hend)
>                          goto skip;
>                  if (khugepaged_scan.address < hstart)
>                          khugepaged_scan.address = hstart;
>                  VM_BUG_ON(!IS_ALIGNED(khugepaged_scan.address, 
> HPAGE_PMD_SIZE));
> 
>                  if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
>                          goto skip;
> 
>                  while (khugepaged_scan.address < hend) {
>                          int ret;
>                          cond_resched();        //here
> 
> 
>>>                  if (unlikely(khugepaged_test_exit(mm))) {
>>>                          progress++;
>>>                          break;
>>> -- 
>>> 2.27.0
>>>
>>>
