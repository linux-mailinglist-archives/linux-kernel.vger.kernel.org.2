Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B7380114
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhENAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:16:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhENAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:16:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E0B2PH041967;
        Fri, 14 May 2021 00:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xThT6y4G4/WsuiSZSeiGoaqNWcRleJjoo+igRQ3E/tw=;
 b=Y3ICbJzUDis8HsyWWH95/UW62kUHXKQOA2TQ4G1GmfsZVXDe4RKb0si0BNyrbtnSDSJA
 lpOSxb83rWCairpGrnE+vC2gcQt/b73J+pQ+i32L3/qmXff4MkPFqV4ALQ/iIi47UGIP
 Ur7vXjmHalYRt+bZ2cUsS87gAu4S2SV9ksbhF045Wis+ikgbjSoD5Vvl8DayNCXLCNFW
 RwweZToCFSPZImR7tqcFxaN/SMvn9l1PjaxAFMP+i7FPv/I6vMCz4tgYQKg5jIY9epkY
 1yXbm4JrbdBX8gFKS0HowxD8J+arjpop6a0wfz+yewbSO+g9k1zOl9gpljg7waAeYIRi 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38gpndb3bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 00:14:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E09wh6085901;
        Fri, 14 May 2021 00:14:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 38gpppm9qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 00:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZmJJtKT/XIUY1TQkq/PK4GDn8MfwcT4fg8Iuj0c8epnklG70WAHxnu+ivtRbfzM8kCP2aH4g7wXSg8ICZnqxcRo6a+PZzX193w9qDbEvTtlXoy5fHfOVdrVNKVVU0o7absodD980eShWyB05kpRPet/ZBhim2fJZO7MXKu4sl84PcW4r+yPNDwmg84yykvGCYXdaA0fZQDvEc0gPVBXE30jMPsnkAjb/kUSVt0uyPhz9ntUAUuEqQivr66L2UnGxQ4UKU2TnMcKRJsFNKKwKzeQDbJoGbBfUQMjfYpVCVWMMi0d69hf+113hQWM1zNGmf9hUXyYxz6gSrqijqoY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xThT6y4G4/WsuiSZSeiGoaqNWcRleJjoo+igRQ3E/tw=;
 b=Hcgsj/9Vus9Yy43qkxjRJaYVj+uLvCaw5JCLmqBcL0kivH1Bk3wu3R0CG8WI9fFMo1GOjN8M/GFaIfnxVzn9dBnmmOt0OlhJqkw0Wb9Plh4xjUP9L8DED93vTLNns6yx+cJeEv9Jy03RAOpdBTF8tfPuadSAicV1AEQoqktreqq3xUY1UYQQ72OlCxXQpJiWdtxRlQkGqvjR9d3zuDZ7FE/BuGLPrHJsnXH938Jv4ZX16L5ZVchhuw3bQInhu8ul2XV/LVXfY1nbZWInvFjn9KWRsSh60xMzC/GhdC8KIcbGyjSMglyBkOSP4cus2SeDS5b6xss6ggVydJ3ZcmJorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xThT6y4G4/WsuiSZSeiGoaqNWcRleJjoo+igRQ3E/tw=;
 b=Ot04VowUkrMEnGqgxL0MyEr7LN3UWDG+ftJqhTuYbje14RA3K91Vw+l//JFT0dePi07Q1jWob53egiFZpedPnxDVR1oSJD6btSFSstNFV7OMq+DZm+JUt1hG38sLNPrsWGvKOSxnE0SmMCaNCADToQ1RVoIUS2Yv2HOpyiW2gZs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2597.namprd10.prod.outlook.com (2603:10b6:a02:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 00:14:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 00:14:51 +0000
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
Date:   Thu, 13 May 2021 17:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0188.namprd03.prod.outlook.com (2603:10b6:303:b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 00:14:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad3f6f7-6c76-4fd1-b671-08d9166d4abc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR10MB259766F50A6113393890E1C7E2509@BYAPR10MB2597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdnsu97cwpcj82JhYzpRlPz4NL0EG1vLL1oj+EjgvQwHEAg5GQN7s2xAF8xb+Tiwhfbxpoe3hOGmTzIQ13tzob5g/ZH2IVxtkXLbovHXf3k1m9JAIlIzS+TMj6vT39MvSGCSGaA/c9BWlWOn0mMLIDxT+z9yHjHuNTX7SmtC7IJjtvIdbZ0A43Kt1Qm6QMNSA9zD1B9ApA9QuNoKlOwaCf2WTd+KsWYC4ODFF/JCrKz0XtOTtlJHP1UBTZG4Qz8Yy5FHtqYDCYLveN5i3b/rxZ/EPfa7FBfN/bIkEiLYbr/P2KHvFJNbD6Z7+JXFfIrY6R/eP1+3SeA0+ZBirrexpdOO7oqtJnBp2Da4RGOQRNEBc9COpckzHcbm5P0IDeLiVsL86RlVlAiH2Vn7TvixezFlv429C5tyq1beOV2KXb9bDSmSHJJNdNgiF4AcPiRxhfl7LE+IwHMY88MB7MlteywuxxDUxnqm+smkyUBcvqR4YrasPFHrxRl4iuwBngN8YuqMIvSU9yuJoUJQq4AXa63Z+vLG16CQLGKydShZNVEiCQ4LFu2Onxpcyk0EKG+9XZyVFXxWXv40YDDg762PWXgvvdv2FSz/76rNrR6V41LBZREd89xWtkStuCndABk9ytE19YwTXJdORavhI/C5TTArlsgpbVr6kmh76bZe4atVD+/57OqSH7yENIP77U5OuIWDqcGYVIH2EtDt8VZY2QRmQDZpu515qVEAblzf5OClrV0YX+nlVbkYnsHnfBUh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(36756003)(2616005)(2906002)(478600001)(53546011)(8936002)(52116002)(31686004)(186003)(44832011)(956004)(16526019)(26005)(66946007)(86362001)(6916009)(31696002)(38350700002)(66476007)(66556008)(8676002)(316002)(16576012)(83380400001)(38100700002)(4326008)(54906003)(5660300002)(6486002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1h5bWgvSmMvajZnd2FQOUxsb0hFZ0dDTXlEbkQ0L1RXMDhzVzdndmo4S3lB?=
 =?utf-8?B?Z2k2WEp2eHZPK2pWVkZwcll1ZmEvWFJQaDU4Q0xnWEFJU0VFVTJpS2ZjVXZu?=
 =?utf-8?B?OEN6cFJxbm8vTzZvU2ZBaThBNENYYmxaT1Q1SG1SdmVBY2thek1WZklZbGhX?=
 =?utf-8?B?TkdqWjdtZUc3dE05NTVJdzRWNHRGaUppa3IwYTRoNmRrdnhNKzJuRUpDQkZB?=
 =?utf-8?B?dVFRdUlobytKeVRXZFdVWGRnMXRHMURiR0tLM1FjSDA0OHJUbjhkY2JOWGxp?=
 =?utf-8?B?am1uc2NNTHRNcy9Xa2ZMUGFjK1NjcWJ6dGpsb2RUKzFBaVpmS3YvVFpDTTlv?=
 =?utf-8?B?dUN1NEQxSUo2QTJYd0ZWVlhGNEZMWnU0amZRQlFaOGxVSmhQM0dlbFM3VXRw?=
 =?utf-8?B?WXBjNlJNOG9TMnFRTE54MU9mZ2pFbzFWV1ViZlMwak1vSk5uYWdPa1NUalIx?=
 =?utf-8?B?Z0NNM3hoMXFBMUVUK1h2SzlOTm9lQytwMVdmZU9JRks3a3RhTEdNcDkyWXpN?=
 =?utf-8?B?Znhha2FoNE1rZWpaQW82bnhHUUlINlhuOXkwbFUyQStkOWkxZW5MNTBMQ085?=
 =?utf-8?B?UmdGNmY1aFBGUGcvOVNVajFoZWFRd1grUnJsd3pqYlNibVY2YmxOZGd4Nkhi?=
 =?utf-8?B?cHBXZ0FTdkhuVURUN3hoY2hYYmttMlMwUCtRYW1uTWIzbm5Bb2ttb21BWkNC?=
 =?utf-8?B?MG5CaGZGRndFUDY5MnNyM01MNDJsOGtpL2hDaTNYUk43SGh0eHdaSGdvWnoy?=
 =?utf-8?B?dkM0Um92RGlXc3RlZzRlbndRRURNMUpMNnpqalpNVm9NUG5FVk13RFFjYkY4?=
 =?utf-8?B?ZWVGMkl2amt0VUowYnFoeWVWaVROSTRqYkhlcStzbGszWmZDTVRIWmxaOFpX?=
 =?utf-8?B?cElTQnFlVlJZdXE5bFZYbjBUTDA4bjh6MUNlY2ZDeUxpOHNNb3JtUCs4akQ5?=
 =?utf-8?B?c0RCczZrWklUd1hzV2lXRTNBVzJCZSsvWEx4ZlJQKy9xQUZaL3ZCUmtMRFcv?=
 =?utf-8?B?VkhrVG5DSVNJY1NZSFJpY00wTDRqbFA1bXhGV1BBZ1ltbzBTdHNWNUdkbUxh?=
 =?utf-8?B?Z0N5YllvdmRpaE0zUnh3d2pQaGdzR05WM2p1ckpEeHpHVXNubXlSbFhQd21L?=
 =?utf-8?B?V3hsTC83U2ZxZy85TUZjOGJHRzVaVTFLbjhxaXJPdUFhcGhsem1hYVFuMDRL?=
 =?utf-8?B?T09yWEwwcEZsYXVyR01NTHNOVXFPbVNsQXl2N2lDOVpVcUE2UU9nY294Z1lN?=
 =?utf-8?B?bWxhdS9peW1yUENFTXlwNkM1ek0rVzZuNkRYWnVVZVY0TEc2UzJPT2VoZGlu?=
 =?utf-8?B?ZmZoRStlaVRNQ2RjUUo0Z3dUVXNuM1U1M3VGcVR6VFF4WTJnV2Q5aGNjYTUr?=
 =?utf-8?B?aXlheXM3R3krWmZPdHNGNjlGT3hac0xpREdTWGZlUTdiOGNUZnY0cUhVODRE?=
 =?utf-8?B?T1JlTlZDeTV5eFJvdU84Ym1ucnArYzFGZUJ4VmFzL1kxYjBDL2J4MUN0OHFt?=
 =?utf-8?B?TkFPdC90SkszVnFES3lKQm83QVd2WWpkTWhPYkpnWkVicVNtOG9EaCtEakZk?=
 =?utf-8?B?NVVsSm5tZTJjOXM2aFc4WmxHTzlCN3V0RzZ1V05UbFlmRHN1NVpRNncweW1i?=
 =?utf-8?B?dWdudWFSV1NPYTYvZzJwaWVrTkQvaFE1TWc3bGYzRGVTTW5YZVRPVlJGWGhU?=
 =?utf-8?B?TkdGb0xINUFiSmpNcEJsRmIwaXl4Yml4dEhhbXRFWjhkb0MzK2RBMWY4QVBo?=
 =?utf-8?Q?8hrZA8agg2EWEBGDbCwuBbuvnWuxCDzdr+gOocg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad3f6f7-6c76-4fd1-b671-08d9166d4abc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 00:14:51.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7Be0asU5d1Id1ImxKv1A/oPf+KEAy9QyanWGcCRJGsmmAduQP3Tg/NGKqXdlrxe937hcgXSlAPwtPke2jQ75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2597
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130172
X-Proofpoint-ORIG-GUID: ZsnNocHzQxPzgfj63gqS35UqJBehT0I4
X-Proofpoint-GUID: ZsnNocHzQxPzgfj63gqS35UqJBehT0I4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 4:49 PM, Mina Almasry wrote:
> On Thu, May 13, 2021 at 4:43 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> When hugetlb_mcopy_atomic_pte() is called with:
>> - mode==MCOPY_ATOMIC_NORMAL and,
>> - we already have a page in the page cache corresponding to the
>> associated address,
>>
>> We will allocate a huge page from the reserves, and then fail to insert it
>> into the cache and return -EEXIST. In this case, we need to return -EEXIST
>> without allocating a new page as the page already exists in the cache.
>> Allocating the extra page causes the resv_huge_pages to underflow temporarily
>> until the extra page is freed.
>>
>> To fix this we check if a page exists in the cache, and allocate it and
>> insert it in the cache immediately while holding the lock. After that we
>> copy the contents into the page.
>>
>> As a side effect of this, pages may exist in the cache for which the
>> copy failed and for these pages PageUptodate(page) == false. Modify code
>> that query the cache to handle this correctly.
>>
> 
> To be honest, I'm not sure I've done this bit correctly. Please take a
> look and let me know what you think. It may be too overly complicated
> to have !PageUptodate() pages in the cache and ask the rest of the
> code to handle that edge case correctly, but I'm not sure how else to
> fix this issue.
> 

I think you just moved the underflow from hugetlb_mcopy_atomic_pte to
hugetlb_no_page.  Why?

Consider the case where there is only one reserve left and someone does
the MCOPY_ATOMIC_NORMAL for the address.  We will allocate the page and
consume the reserve (reserve count == 0) and insert the page into the
cache.  Now, if the copy_huge_page_from_user fails we must drop the
locks/fault mutex to do the copy.  While locks are dropped, someone
faults on the address and ends up in hugetlb_no_page.  The page is in
the cache but not up to date, so we go down the allocate new page path
and will decrement the reserve count again to cause underflow.

How about this approach?
- Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
  that you added.  That will catch the race where the page was added to
  the cache before entering the routine.
- With the above check in place, we only need to worry about the case
  where copy_huge_page_from_user fails and we must drop locks.  In this
  case we:
  - Free the page previously allocated.
  - Allocate a 'temporary' huge page without consuming reserves.  I'm
    thinking of something similar to page migration.
  - Drop the locks and let the copy_huge_page_from_user be done to the
    temporary page.
  - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
    *pagep case) we need to once again check
    hugetlbfs_pagecache_present.
  - We then try to allocate the huge page which will consume the
    reserve.  If successful, copy contents of temporary page to newly
    allocated page.  Free temporary page.

There may be issues with this, and I have not given it deep thought.  It
does abuse the temporary huge page concept, but perhaps no more than
page migration.  Things do slow down if the extra page allocation and
copy is required, but that would only be the case if copy_huge_page_from_user
needs to be done without locks.  Not sure, but hoping that is rare.
-- 
Mike Kravetz
