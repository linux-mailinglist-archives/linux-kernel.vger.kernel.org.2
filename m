Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789536BB49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhDZViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:38:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhDZViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:38:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QLSQ2Q071773;
        Mon, 26 Apr 2021 21:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2uVqenGc7voeiwHlxzgi18QMuERvCKXFK27ir1+QUZs=;
 b=tEtuahpcZMLpV8ntkhnVlDB32VeDgZ/FawzCgzO4tfY1oyOjui2q5Y0aHDIBtvsuvOgh
 J7/YTqzLsuhcVQYvOzObQhJyUZfEyNyvJ7cMoMb5YjButEzi5X2S7ENAEe1uQ2Xz14FV
 BzpqHv6ljzpSIu9dgqSuAVSqvoJtMbKvZKtM+gjjCT1WFq3KTpae9fgJS8AugsJYdzyf
 HdXqH6qE8AA5r55xmDfPWTHLTeLgqJn00m8LDmWuTqz7x/OD9oocbf0K9KCWcr4QBDoS
 WVI8Xfb5g9TAy5BKSp+iJMasezB3QfnVrfoIFR5BIuQfWzbg2YH5lzKOmF7S/gFYi5xG YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 385afpuj1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 21:36:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QLUQlB096093;
        Mon, 26 Apr 2021 21:36:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3849cdssrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 21:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYmgNOH7eGnFC6W94HZQP3NGDTeFIHl73XjZwoii0kQlW1/3jpk9IOL91IVEkvgiTWPkWPUneO8pHFbvhqwm4c3ayT09n2W2IFs8G8TPGJiJMYhXevHYLBoD5KqwnOiH11tHjSco48pb0o5p45TZqmXWAwjW0x2fhSjbfCnLPtUAeAl5kVA/UbZBHASt9/bEjxzASLyoDsgh1uRoNtNAx2w5QQ6HsjGOse/vMjNH3gxW1mrVY2niUUk3JNJB8Y6JzvapXIoDn+BpSjMPVq+0y8L5zppWHowTZIXBhRHn8PW2tUJ2HuCTeKv3pAGlbdq9kFy8XeK4ifnLyBJNu/As3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uVqenGc7voeiwHlxzgi18QMuERvCKXFK27ir1+QUZs=;
 b=nmsG/XvUeRMIj+MzR5y3md34/8fk8D0Ko7hyhtUGg+LaTc88O30pUhtwmWTk8wpeQ6T/qvyjNlFZUdwq/jK8eVVkJ2QLkQs93JOLXvNgQ82QsmmE62Qt/NlrdMUe0MPoPRwi+xldHTlBWJB2JL6lcBAqCXL+1lMof8luXR9Yx1Nfc3Jy0gU4S30Zd8F5HWkNU+5kpOUuNsFrJtht/Yt7gh6ZmnWVBHrWP23f1B863Sm90mJryFgo6muoMf8dbD6ve2iOYioRG5zC35yyYi0v49W+nAPQCf239j7Rqku/uq3iTTFDkF8/TYcTrKoayp4go8p00Q88d72jFgyhFZbG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uVqenGc7voeiwHlxzgi18QMuERvCKXFK27ir1+QUZs=;
 b=HfjNiQG0+rmnoOEjptRpg8Wd4mgUHGwRYGa32+i8D4e3W6N+a3J8OmfgXYB4rp5RnWCMJ6NeDFLFW9xqZJ9LNbGr5xKEVQrrvUIEjlPbD8451ysXcpYz+RiC8zo5M77vJykRR+5yeEth7y8+KZJkowjQfPCrE3a82MPzM9OJ9u4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 21:36:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 21:36:29 +0000
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1419a8cb-1028-31e8-bae7-4caf79819f02@oracle.com>
Date:   Mon, 26 Apr 2021 14:36:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210426211653.GH85002@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Mon, 26 Apr 2021 21:36:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dea5e4f1-edc7-45d2-4cea-08d908fb5a60
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26649F4046A8139FD8D657E0E2429@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoPBsMOrt7jmFedDrBWgF38TLS0iVIQ0pAcU6LRc6Ztjj1WXG1g+sRhso/lBuSVmSedTTqi1Ty1zoGjwiL2E/7iWUrQREdXY/Tv+lnfKSEntMRoKKNwl2Wgsce7mc8svoxarxBsc/4qzMssRCkyFTYIQjV53yDOZRaKtDltJylt+jwgRiZPH1e+RvuIWS3pGS/JbZ15MIfKayiPHI8yDBvTLVRxKoB8f9/dQN4q2OW50KYKEWceiCbbCKdCsWNSG+LOwWpjptDOaZiuKiXAuinsbpdYh75/uRu+sN5B6f0Rryp3ADPNt4tIndZSYAWseEJycl3wYTAmgJY+V/5oQHOImiZ3rX4e5ZVr0l5ZiB84gvxVHWN0uVTEnVCQJmvG1lklGfQc5Wp0qSvULK3T6FkktmKLGSOcdd9d6DX0PWDxMTyIsotSR8cTaAVnF/siuALtZJKMTqDcF6RvHTqLLJPr+ps6rOEfBgDkAi8oiCsuE7miQdeJdQVkrt1l3QMmUBV3tqMLy+MlIDqRTNoKr72uTY3LXhYCd9bUM9oq2Jne00ia2Jqes682kKXw5+Lzoo5/J1JFzXxWWx3KBcxIbBUZ4ui2VF3MCYqhSP23yJSB4g5rjEs/F97zIiwW+dcjEZcLtnYMe1bWAPejFmz7oljSUa8BBF1qkZS0Lj7PReCAcPukdo0JYhznwL/oj0dYFWymmAXpFrVGpCPPL6W1ZWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(86362001)(6486002)(8936002)(8676002)(2906002)(7416002)(6916009)(38100700002)(16526019)(5660300002)(478600001)(38350700002)(956004)(31696002)(2616005)(4326008)(66946007)(31686004)(44832011)(16576012)(316002)(36756003)(26005)(6666004)(66556008)(66476007)(52116002)(53546011)(83380400001)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWJxUWpKb2w4b29BRFhjU1h3aFVYT281MTVWYTN4UlFzdCtFZ3Q1clJpTHU1?=
 =?utf-8?B?aDNGNElxVUYyQ2xVL1pHcWlwaEdkbW1GSU5FcFExdG1JMnRYYXhIaVE4UFc2?=
 =?utf-8?B?RzFKU2RPQm1LcmNZekk5T3U0akJCemRaTVNLSTd2dHYySGllUXNtMUVBMlVG?=
 =?utf-8?B?M0N1YVJENFNOdmw0YThQbDlrSnR4Zjd3Z2VnMFhuMFJjOUhjaHBFN0VYU2lW?=
 =?utf-8?B?QXJLYituUzVSQkErNkE3RjBLSVVYbW4zM25iZjVNUTZJUHpLSldQbHJIaUwy?=
 =?utf-8?B?L2tIT0NORFNleCtqWnBkQW9GMG5lYnd0bHRDRDdZK2dnbVBLUC80bHBMQzYz?=
 =?utf-8?B?YVl5ZUVZd2c4dG1HOWg2S05pOUtJT1VnNlRjck1oR1o0S2g2QjZIYVc5VU93?=
 =?utf-8?B?eEtyekh1MUdWMWE1V0JPQkZhTVRaam1UMDIyU1Z2eDJGVHdFcnREM01WZlBW?=
 =?utf-8?B?b2JoekwyVkpZTGp3TFgrRUc2NnBaTk9DVkM4YWRTVHhWbGxTV2hNY1VSY2E0?=
 =?utf-8?B?amRWOGZDNmx0dkQ4L3JHM2o2NEQ0Vi9LVzlBNStRNGxnbGtvRUREWk01TjNr?=
 =?utf-8?B?dE9hOFJ6U2hoTHdLZDR0Vnc1d2RaeFBpWWZLbTNLL0h6amJyL0FIZXVYcDlI?=
 =?utf-8?B?enpZaU9ILy9MeXJiTFlSS3VOZVRWSUdGSjZ2SGdsOXJvc1dISjRpMHNzRUJL?=
 =?utf-8?B?U3g3cExWU1E4aSs3RVNteXQyQWtSOVpFUTZjOGZ0Tmh3Y1M0R3JqS1NaMVdY?=
 =?utf-8?B?S3FSdjdyTXBRNFowWGNWRkNGdVdNN0l6VW9DUEsrc0UzYnhySUJ1UUozUDU1?=
 =?utf-8?B?QlVsb0lCY1B4SmdDWnZ0UkJMRFU3N1g2dmo0Mklva1NoV0Z0dGt3YjNxWGls?=
 =?utf-8?B?VU9lSmV2anNMM05lTDZTTVpzMm9tbm1uZmxIMmhBZWE2citDU21nT3FkTWo0?=
 =?utf-8?B?Y1lxTm5FSGdmWFF3L1lIRUwyLzlPVmY3TVJsZktCSGlLSXdqK1QydVRNUWIx?=
 =?utf-8?B?N0d5NW5FK2dBSU5sbXdRRWZaVU9LemN1Y2VPUFNsOTBsb0NiNnBRR01FUE1S?=
 =?utf-8?B?NG1VOGhrMDd5WCtjeVVjcTBjc0N5RFg4K2lWMVFPNDg0QndQUkZRSWc4dkt0?=
 =?utf-8?B?QjNvQWFPdXk4dlU4SG1hNnJoOUV5QkpyNXMvVmxMaDVtdFhjRzhWdlFTSEh0?=
 =?utf-8?B?WG95clpDc0NoZ1ZncVlNd21FQXpIY04wT1FZVjVha0U5cjFOQ255YkI3NWpV?=
 =?utf-8?B?a05SUnlTMEU2dXprU1YxVWZ5eUY4Q3c4Q0RPekMwdnAvZkpkeVI5ZUNzRFY1?=
 =?utf-8?B?YTNKMFM2cmNYRTRFY3BpOHlMem9mdkFPYkFpZ2twNi9TTEQ5U2FUbVV1N2Jz?=
 =?utf-8?B?N21mOWU2RnpYNnk5VTFSRGgxbnhjSGpSMTkvbWxZVEtHOGYvb0lLUXVYNkxY?=
 =?utf-8?B?WlF5QmJReVd6RlNUelV2ZnZvQUk4MWxJYnhVZHVuWUFKOFByeXpGbE1EeVcx?=
 =?utf-8?B?NHJETjVhSi96THVEQnBneE5Tb2xIb1pLS1g5SG9nRTVqTU0wRForUGV2bXFL?=
 =?utf-8?B?Ynp5N1A5b3BqM1BUZ0NyZkdCc2dGRGNDUUkzbWtXckR3SkYzSGY1TlQ1ZWRI?=
 =?utf-8?B?Ky8rZlRoQXhkTjVoYjBKN2JvOE95VDdpc3Fmamw3QVdmckhiYk1uUWFDQURt?=
 =?utf-8?B?WDhwYi8xOXJqWU11eUg0VVp4N2NtSDZqWHgvSXFuRVk5WkVFODhoTEp5VXVY?=
 =?utf-8?Q?kZ33que+oEyouMSAFIKsbCGbkUI/e9aS2gHF/WB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea5e4f1-edc7-45d2-4cea-08d908fb5a60
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 21:36:29.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzI15271wRh6wRReDtwstWPrSeQlzYRsQHeW4Maf32iFMpw9WJTjl4Tcvkj5yiMs3OnnzF6JZ+jFbkzXdxbI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260164
X-Proofpoint-ORIG-GUID: 8RJua3GA7QXfeQEXKMpLobAbH47pcJWY
X-Proofpoint-GUID: 8RJua3GA7QXfeQEXKMpLobAbH47pcJWY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 2:16 PM, Peter Xu wrote:
> On Fri, Apr 23, 2021 at 01:33:08PM -0700, Mike Kravetz wrote:
>> On 3/22/21 5:50 PM, Peter Xu wrote:
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 92710600596e..4047fa042782 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>>>  			 unsigned long *, unsigned long *, long, unsigned int,
>>>  			 int *);
>>>  void unmap_hugepage_range(struct vm_area_struct *,
>>> -			  unsigned long, unsigned long, struct page *);
>>> +			  unsigned long, unsigned long, struct page *,
>>> +			  unsigned long);
>>>  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>>>  			  struct vm_area_struct *vma,
>>>  			  unsigned long start, unsigned long end,
>>> -			  struct page *ref_page);
>>> +			  struct page *ref_page, unsigned long zap_flags);
>>>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>  				unsigned long start, unsigned long end,
>>> -				struct page *ref_page);
>>> +				struct page *ref_page, unsigned long zap_flags);
>>
>> Nothing introduced with your patch, but it seems __unmap_hugepage_range_final
>> does not need to be in the header and can be static in hugetlb.c.
> 
> It seems to be used in unmap_single_vma() of mm/memory.c?

Sorry, that should have been __unmap_hugepage_range.  No need for you to
address in this series.

>>
>> Everything else looks good,
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Please let me know whether you want my extra paragraph in the commit message,
> then I'll coordinate accordingly with the R-b.  Thanks!

Yes, please do add the extra paragraph.  

-- 
Mike Kravetz
