Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB5354B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbhDFCwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:52:02 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:53473
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233030AbhDFCwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrYFj7ysxYSt0aE7Wx+Sr55OAn10UExPT7jszaBDlkLs6dIyJrfhkIFFZWyEKaeU2GrtUYdebLvPg75qxMFskmdLUvFV77ZtuBXYPOHFHWkf10U55B+WP0EpY85OeYg+sMKgTJHL71eU5Q/iNczPDp3ahYkjMtWMksVcyesYSb/+Ar5Wl9H5Xop3I4ZXBhc3Bqo+GP5DaCLuVkeL7qujMj/EgDxCkJoFmO4VycsFw0mzMMqe9Rk65kd8p6dtfI9zXOMYROu+Rgc2DDX22bA2NBoMTgh15+/wC9VPRhWlj563ndHB7VeNAwQpDhgm1Xx8KPqUej3IiBehf3I+b8pRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn6XrAIzdBibMLmpTMJ+ZShSgPtQG2biH3gf0cy0r9M=;
 b=NQfrBt/RFzrQqJQjURegi/fDSs65xf4T9Zl9LjOPP2l2qMlkujLblLxKoEeFjFTtcJGCK6xWq6VNt2SpOPVJG615zBd6r1A8LiAUsstJABiQnMYE5Es5rAPle28hm1vIF6AMjm/GW2sP2JBGuq2a2+hHN1mqqe+ssH0An9ot8qo+kh3IlUoRKjI4ehe4VHAc+qLwdvUl79OpB19tkHNmDmRV7zQyvqj6bM+M99hlSnBLZjZaw0797g5zW7Nc+AKSa7vujtZjKkZ+/of2IqeupbESU1AzNriaA6BBk+U0xaB8QIweXxBOQw1jirY9H/xwFa9/Oi5enlC7fvyptc0zAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn6XrAIzdBibMLmpTMJ+ZShSgPtQG2biH3gf0cy0r9M=;
 b=XuQsrMhuNLKP4CYP3CKS0GEaOWmuEOJB1Vkdv+G8lRpkcuVX4kLG2de/1xTGTuW2IFOlawDN0ob+JlYw7uwMyG3MnvvERcct5KY1+Tj8ewhtntIr7RfTwIhBa4sa6J14PyJgH1rOQvLMAFFh+zX3XOVg83fC4XS5zWCPRvY93Qk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3909.namprd11.prod.outlook.com (2603:10b6:a03:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 02:51:52 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 02:51:52 +0000
Subject: Re: [PATCH 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of
 iterating over vmas
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210404153311.1460106-1-yanfei.xu@windriver.com>
 <20210404153311.1460106-3-yanfei.xu@windriver.com>
 <CAHbLzkrSaODz+SeT+GY3tOS6Jm8NSznmknP83RUCrn+Sr9cAAg@mail.gmail.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <e0fa88df-ff8b-f820-e255-92fbeecc37e6@windriver.com>
Date:   Tue, 6 Apr 2021 10:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHbLzkrSaODz+SeT+GY3tOS6Jm8NSznmknP83RUCrn+Sr9cAAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 02:51:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf0d89c-cab3-4f49-69aa-08d8f8a6ee61
X-MS-TrafficTypeDiagnostic: BY5PR11MB3909:
X-Microsoft-Antispam-PRVS: <BY5PR11MB3909DE8DF4A78A9119272FCBE4769@BY5PR11MB3909.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8swvzJZb+w4eUHJZ8Hk6xmAV8V6zkF+/Bez9Y8r/JrG1rZ/JqWzpRfOiQZREUv0gukO8J43ltIeznJieURyl4EWB4STzcBuaTtzMVsr455Jv4yvMzx14CE82Wo8Mpyzki1vggf9Bd7Y+QA8bi04uBEh7cySEhKjEKumWdsnT1GwsmPmvNJf5b3s41guTz1sYhC1Nw2sbVMU1aNwFJXBa1DBFI/Mo9ysjSEz5QmdsTEk/4i2bu0zR2YoPUaNc4r1lJrPcpCUQCJr7N2DbxUUm5tofa7FA4giKMM0PgIa1fOituTj7L9MEegsLGOzptR2hYdFAlORfripHNTFNAMCEmJeDyTwjw+igrHiMSv8he1RGsEvTvfE2gWVqGRYxevKmq7zYnpxQX765gbSaIejRY7Vqfp3bJBKfJfikA2YRUTf3MKAaMrzgE9vuu77INsRBOCYdGD/CSZ4LHpLJJotOgsGSCfTd7kAod/IvdtjS+rqCw7STTxDCEaN3uJxcRUQGbYps1OiOzhzhgLrnE74jrS8rLedPvxmRm0UlaWcGJbNuLqsjTAb9iJfjq8RRDB7XduclLbx797ufY8EyNOProRQ4he/OprnAbKKvhhAKU57qNNsaEeixXziApN8OHDl0pL2rh7OzSEm7Y2T6etuhrF+MwMNliagLpXJ9qmayQgxznyLaKwBUg5wokiCaTTR3g55i/e9GtD6k45fOOCPel8atmQUmn/j6HNMNqEt6mGnzOdvoIE9sbekIO5znOqWjVN3LTq4apT8aoXeeAS1d/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(376002)(136003)(346002)(16576012)(5660300002)(956004)(478600001)(8676002)(6916009)(6486002)(186003)(66946007)(38350700001)(6706004)(8936002)(316002)(2616005)(26005)(83380400001)(31696002)(4326008)(2906002)(38100700001)(6666004)(53546011)(52116002)(36756003)(66476007)(86362001)(66556008)(54906003)(31686004)(16526019)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L2RiOElNWEgzN0xXZ1g1ZDN0Tyt5N3lPcExCSEJRYUtuVG9Nd25nTHNNbnh1?=
 =?utf-8?B?ejBaOUJFTzhNQWJSR2JvKy9tNGtMVVN0c2Z5b3N2eGhGKzIxeDNCbFExMXor?=
 =?utf-8?B?OGpMM2t2bUcwVkJnR1htbkVVU3ppM25HTTFWZjdRMGN0TFNudzRBZHZKVWF1?=
 =?utf-8?B?WEZybkVlQm1KN3JxYXVsYVptcUp6NzhtbDI5RGQ5elBxWHYzckRPdituaDFr?=
 =?utf-8?B?aEpaSU5JTkErM1pDVE4zWkRMeEhtMlRPRzZYWENXdTBMSkw0MXNrNlE3bkVE?=
 =?utf-8?B?b0JoSHptMytLZHpzRFlnZWV3b3QwL0JWSkdFVTFvQWhwdFZ3dXlhUU9GdllG?=
 =?utf-8?B?RnM2Y2o5TlhEQzB0ZUZld0hEMU1zK1JlN3JhNC9yQjg4WWRYZHlxaGk2SjFS?=
 =?utf-8?B?K2UrUmQzeENPMk94aDc2UFozWTR4dDRON3FwMmgyU0hwSnBMWHhXbm1TcDZq?=
 =?utf-8?B?YXhsRTFyQUpOczI4Qnc5OFgzL2VCR3hlcUcxTVJNV0JualVIK1dmSzJWSlZG?=
 =?utf-8?B?WHpMUlJKRmczZTV2QVJuaWIwaHJyL0pjdkR6WWM4Z0hVRXpTVVNwb211Zk05?=
 =?utf-8?B?eW1Ka2wvd2JDazh5WGlVclZQQlVmMEMxdjUvS01Fa1FvWXV5ZWRaSGdZZFgx?=
 =?utf-8?B?TnBSSGo1S3dtYjlPWW5wNjNEVHJsbHVGS21UOTYrd1p3WW9oQkI3UnV4VTZR?=
 =?utf-8?B?M1poVTNZcG1DdHZZaE5JTWh3VmlVeTBJRjc5bTZ0aUltSDkrR2FsQUdmek0x?=
 =?utf-8?B?TmxjWWpRb2t2NDNEN1lpc2FzTDR3V1NIWWk0WG1QRVllaUlhSW1LSWh1aDUv?=
 =?utf-8?B?NUxjdVY3R2RCaXpSK1lkTEZoTU1lRHhlSm56MVc1ZVdYcE5CZkNmTFZFTDA2?=
 =?utf-8?B?VXpxRm1JVzVaUlEyYUVpRy81eW8zVlMxakNlVWZnZ0IvcjdiZVY2L1JISFYr?=
 =?utf-8?B?a1IwaEtwUmJRN1N1V05BeFNZTEFCZlBTZzA2disvS1NHdS9UdGp2bFNnTFlS?=
 =?utf-8?B?ei9xZXk0dE9DNHZrYXAzT2VzVnNTTk9BeEZBQkhVdis0d0RabHRlR1BsdFdu?=
 =?utf-8?B?ZnpkamZOcjBMTThZb2F0Q2s3TG1xdnhYZFYxdy92M3VSbktaSHB0ejhxMmpT?=
 =?utf-8?B?Y3V0M1lUQ24vczhKNXR3cnFrdjZkRlJDTGp1Mm9mZ1gxU1o5a1lQYTY4UDFz?=
 =?utf-8?B?Z3BFVXJ2M0U2SFN2SHpaeXY1WVNwUHhIU0NIOTk3T2g4dGlVdHpvVlFGSk5O?=
 =?utf-8?B?bWoyZUYwYTlQTHlBUkVaeVp3R2RUdXo5YnpXYS9tYjhYK1dISFJvUHNuWUtL?=
 =?utf-8?B?QW05MjQxbW4wNTJzRnhrSmU0QWRlMy8rZ05TOVZsSURrVldnMUtYeTJPNCtX?=
 =?utf-8?B?WWVjS09HY21uc1RmMkJCR2dkNSs4MVVMMVVScWhhcENuMWh4V1VUZkcyU2V4?=
 =?utf-8?B?YU5QdGVzZk15VE9xTjRId2VDeHlJMjhRUHFZOUxZelo5dUFpajhYaFVaSEF5?=
 =?utf-8?B?U0FWbkFIaWtrUUVUSUVCc3I4RWtOMCtTQWZ3bkJEWlRQTk1rWkhwYksycUpJ?=
 =?utf-8?B?dEJmbmNFSWRqL2JXYVdMbThyZm0yV29hWHpMeTFNWGdzc1BEVEdIRzVrNzJq?=
 =?utf-8?B?M3ZDVzY4UFhqQnBpWW5vd3JkNzQ4aURVVVpRdklUWGZyYWJod2Q0T2lFeVd5?=
 =?utf-8?B?RFBma1gvSGdpUjNseURjZWY0aUVkblpadEcvcXhsNmNoNHdEVm1LS2FyLzFu?=
 =?utf-8?Q?ZOhlzQABT5juOjoNkqIbeXAT5id4YeAp8OtSvO+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf0d89c-cab3-4f49-69aa-08d8f8a6ee61
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 02:51:52.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbAJthtuprGB6Iq6m3rx6skIB0nm3DN+J+syoL+oJiwSCfgNl5g5pHo/J0IhJZyY1OHK3GCkffGfY3janPVsnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3909
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 2:20 AM, Yang Shi wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Sun, Apr 4, 2021 at 8:33 AM <yanfei.xu@windriver.com> wrote:
>>
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> We could check MMF_DISABLE_THP ahead of iterating over all of vma.
>> Otherwise if some mm_struct contain a large number of vma, there will
>> be amounts meaningless cpu cycles cost.
>>
>> BTW, drop an unnecessary cond_resched(), because there is a another
>> cond_resched() followed it and no consumed invocation between them.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   mm/khugepaged.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 2efe1d0c92ed..c293ec4a94ea 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2094,6 +2094,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>>           */
>>          if (unlikely(!mmap_read_trylock(mm)))
>>                  goto breakouterloop_mmap_lock;
>> +       if (test_bit(MMF_DISABLE_THP, &mm->flags))
>> +               goto breakouterloop_mmap_lock;
> 
> It is fine to check this flag. But mmap_lock has been acquired so you
> should jump to breakouterloop.

Oops! It's my fault. Thank you for pointing out this.
Will fix it in v2.

> 
>>          if (likely(!khugepaged_test_exit(mm)))
>>                  vma = find_vma(mm, khugepaged_scan.address);
>>
>> @@ -2101,7 +2103,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>>          for (; vma; vma = vma->vm_next) {
>>                  unsigned long hstart, hend;
>>
>> -               cond_resched();
> 
> I don't have a strong opinion for removing this cond_resched(). But
> IIUC khugepaged is a best effort job there is no harm to keep it IMHO.
> 

Yes, keeping it is no harm. But I think we should add it when we need.
Look at the blow codes, there are only some simple check between these
two cond_resched().  And we still have some cond_resched() in the
khugepaged_scan_file() and khugepaged_scan_pmd() which is the actual
wrok about collapsing. So I think it is unnecessary.  :)

         for (; vma; vma = vma->vm_next) {
                 unsigned long hstart, hend;

		cond_resched();                 //here
                 if (unlikely(khugepaged_test_exit(mm))) {
                         progress++;
                         break;
                 }
                 if (!hugepage_vma_check(vma, vma->vm_flags)) {
skip:
                         progress++;
                         continue;
                 }
                 hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
                 hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
                 if (hstart >= hend)
                         goto skip;
                 if (khugepaged_scan.address > hend)
                         goto skip;
                 if (khugepaged_scan.address < hstart)
                         khugepaged_scan.address = hstart;
                 VM_BUG_ON(!IS_ALIGNED(khugepaged_scan.address, 
HPAGE_PMD_SIZE));

                 if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
                         goto skip;

                 while (khugepaged_scan.address < hend) {
                         int ret;
                         cond_resched();        //here


>>                  if (unlikely(khugepaged_test_exit(mm))) {
>>                          progress++;
>>                          break;
>> --
>> 2.27.0
>>
>>
