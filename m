Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B842C38B5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhETSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:18:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59430 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhETSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:18:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KIFxxf137125;
        Thu, 20 May 2021 18:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ut9A+SEJlnPZUg+rvdH1z4E55LG1qqxDFC6aG0wLKp4=;
 b=xhgNoUnfq/y+4jK208b0AuW7FhjdrQmlt7D0fkqzDEfVnkRleV6/J0+9J2d/YSuEth2p
 WK4FbVPqoxHnVQYEdEHpzQhdccmPLbTUdeIhBAOIFeh+P+ZcIp8k/qK0GlM2ro/VQsXB
 KfUIVUJN9f/XIOKIjqGZQmPtCqk/XHbLNvWO6ms2C8Rjfqinuu9DqJbMMGlgw5yYKxJL
 r98Rvcvp1UeYdVpwSHVPhpz+SHRlNGwd2jb6uVAy8rzsZgpufcqIeZ8aJDRcUjZgLjdi
 98+oCpsfo744bZ7MWKgZttbUBXj/gICYwKw6rePlt+a4Bc++VhKRJbBpUCUGsoZd3I7S KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38j6xnnh94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:17:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KIFNAH134757;
        Thu, 20 May 2021 18:17:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 38meeh5myc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:17:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYG9auAseXqz1b1TVgrNMg37p426G0sKrnRwpl81Sj+jz+dXuT43BA3dXgdGSV5D65qdYF8GhOrOSY0lESYUY1EIRbxg58WLSq/IQ19dorZaSIFhTTubzK0fLrCDU3+Ex6cwT456g3U1FCqn5TaLwR0PdcCoyeEIfGC91gKWCkQGN5r6ZJWEDaWWhDW57VP/JYFKaVWPo3y7+xVHFM5Eiig9ogoKDIqml5XRq9cZJm8fQhDhr/kPORkPU7fzdehNwMMtMNK038/nJ48z654J0nFS4wV4JFe+mLjlg/dJoENCQjHTIHUHGlz4uxQrvmIgAheBIp1zafhH39PdR6MnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut9A+SEJlnPZUg+rvdH1z4E55LG1qqxDFC6aG0wLKp4=;
 b=dbX6HaCxr8Tqd84CoAIf4pkSMS/FD7Nb1BOD2d6ldBbkuj6gZM1kL8TOyYDOu6zh9HAlVxwCzKh/6FBLfZlAmlrCus+S6E9KHHwAAHvDseJEYbieE/8UVQFOIQqs0CDNxACRY/cQ9JsUhahx+C9Ds27THitQBGfvn/ogRp20z2hR6SAO8TVOEDeH51DBoUWcVixZ/niHYqFda1AEWRkOvTnOotwZu6WgDJF1R7LgEUG0oRbFaoxjvpLJt6i4CJGgKVz+fYHeXrhy3e38IkH1hXXuV+FMSUutr/8P496/DY2fR7MEVRMnBHHvvcRTEjRd367wL9T7Nu2wLSG00rDX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut9A+SEJlnPZUg+rvdH1z4E55LG1qqxDFC6aG0wLKp4=;
 b=Srs0vtNpQrN698D4A3QLS5URn/XiOZXeUF5uwLobskPjnHOK25TMSVNmWD9hgAAbPfZwou7OK1u46M4bKDXBJRN64772YmbweBS22AWMgKg/fe16R3u5jLt8Yw9IEql2jvgnvJVqEbslFfZnofW/j6LSb9kqOQIpOW+NB32+/gU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3157.namprd10.prod.outlook.com (2603:10b6:a03:14f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 18:16:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 18:16:59 +0000
Subject: Re: [External] Re: [PATCH] mm: migrate: fix missing update
 page_private to hugetlb_page_subpool
To:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        zhengqi.arch@bytedance.com, fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210520025949.1866-1-songmuchun@bytedance.com>
 <20210519212412.5653163f94904b141d5d74ce@linux-foundation.org>
 <CAMZfGtVKgfc7Gxf_07038SOJKDbi--9u0Jhwk7fTdrpkXu0m_Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4802b996-6135-7817-374f-d8ddca7641ac@oracle.com>
Date:   Thu, 20 May 2021 11:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtVKgfc7Gxf_07038SOJKDbi--9u0Jhwk7fTdrpkXu0m_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:301:1::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0019.namprd11.prod.outlook.com (2603:10b6:301:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 18:16:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea34275a-0ba2-421c-a71d-08d91bbb754b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3157AA1E14F3CF46713ED0BEE22A9@BYAPR10MB3157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yoWwZYdqxLQZPpnyVmmDou1WYr7usqA5qmk+jq68U+oE1qgZ73/P6QUYExzS4NLgfkYpyftkC31g35/q9V9pNWJuMGaFHVe8hKVJDYCyb5340wpPig3hkB6bBiGHs/tsizgRQgbLLnFmYKvH+/doFap+KIH2FbGV6aVSbGdol/myKbuAoreKppabO9/A75dhQ15zxxXLgSlR+E38DF+oNJF+U2qE+cImWSWUNzTcx05qXJMLM4wMTlUHFi0CUn2Bj7NSDPWbvdYtpkHznHmO7Ac3H6BWfrxLj/aav+C22PNGFSQm23q2eiEMLKfJiOCOHRH8JrMgIzEQS6IrEDRrarVelDGjUv+1zKGhTj1V7t5v06jDLimxNSc2UY4DoQT8uk50iW5scSg3Zp2IGXrt/ck88/ChjL2GAqkRK/R4QfEK4YTZEcsm5QNPfBMAyF+OXddJA9bsswwASKBTVXlYdHd2Yv1ZBZ2MgF1PNaNd3xiWac5pUHQR4kBUciV2f7x7X4hxhNFl9VfWEN/7Pc4//pkNkgnUdR2nuvQhNHtkDmFo8amqh92L3SwSiOXLP1/C7w9+G246PJhpk1slmKWIBP/JOHPhRMWSXc7erkk/Fqy12erdYN5ydtRv0tQCJYagEUinqZp9xX4ZAhabp3Ifyy8WDvtce9yyCgbW7HDM/1hNcJ4u3qWPv9o/jaztD+d/feP5EJKXt5czkt67XA9mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(7416002)(15650500001)(2906002)(66476007)(66946007)(5660300002)(6486002)(38100700002)(38350700002)(66556008)(31686004)(478600001)(316002)(86362001)(16576012)(26005)(16526019)(54906003)(110136005)(186003)(83380400001)(8676002)(52116002)(36756003)(53546011)(8936002)(31696002)(956004)(2616005)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEhURWxBaVhnM3NPNE1hQVQ4ajRKam44WWFnUlRPU1pxK05kbjE3aHM5NHRK?=
 =?utf-8?B?RFZLZEtYdWpXL2tTcFNTTmhkNlAzNlJnUzBEMGNoZDNvRTJDTTFrUFY0cE05?=
 =?utf-8?B?OWFkb1lIcCtIL2Y0SEl6bGZKQk1FSlo4R1FBVGFzZjZ1b2RQL0dtZWp0SjQ1?=
 =?utf-8?B?YXp6SmhLVk1peUZ1Z2ZpUU91aUVBZ0M3MkpXejRaK2RNOXV0MjdmekVIVWt1?=
 =?utf-8?B?TTRyQ040RTlhdmRBTmVMVDRKd3BlOVluV0tLYjM5NkpvRmtrMk5BclFKMlgz?=
 =?utf-8?B?bm1JVFhYT1hRdTFtM1Z5MDJvUE1KTGVQQnhLd2s2bTd6UHhBTnV2SmYwOHBt?=
 =?utf-8?B?RDExeVBsT096UFl5NGNxSW5SamdBb2llWTJieTlIa3VseVRxSlo5Mm0xcEox?=
 =?utf-8?B?OWRCR01xMkVWZ0xxUGZyZ1FmVkhiY0s4UVJiMUxwZUR1anRxMjd5MDZSY3Fn?=
 =?utf-8?B?RkNHeWpDaG84QlVvYW9mZ2FMaHc5ZVpRRmhVbXBocVpMRlJVWTh2L0RQUWZB?=
 =?utf-8?B?anBmS3dVeTFqUCtJb0lyMVRnUENkVUY3Qzh4dUoxclFCa1oyZG1ZSGRyYnpl?=
 =?utf-8?B?VnlWMlM1L2t0bHd3ejYvSkNLb2xvMkFqeC8zNWJacWFBazMxNGlVZUpnaWhi?=
 =?utf-8?B?cjhYU081dVcrMzBoQkRVOVJOSkFwcW9yUnErZUJ6Zmg1cjVSeERPekZzVVRq?=
 =?utf-8?B?WUN1WS9GWE1JSXpGZnlJYVJ3SWIxMlYrY3R3bDl2M1JDSGpFY01VSzB2MGxZ?=
 =?utf-8?B?cDB6R29CaXdVVTk1YW5pZ0ltRXl5aFNRbUtjS2dzVXdKSnlYZ3pidGQwZU9r?=
 =?utf-8?B?SFdmL2dTckJVbzZyRUMyYWdXeE0rQVZPR01QUzlmOWVpVE5QMzY1aGJ5ZzVV?=
 =?utf-8?B?NHNaQ096ZE5KaktoTWh4YTNMNzhJVmIxaTlycWlaS0JtOG9VcFRCd2hBK0Rw?=
 =?utf-8?B?RGU0TnF5TGxlTm5aSXlJc3o5ODE5T212WFFPODJRZm9uYUZKOFR4ZWVlNEJw?=
 =?utf-8?B?Y0dKMXdMRXU4YUVyeExPb2t0ZFlRbC9WeitZZmh1eWc3enNra0Z4NnIvZmtn?=
 =?utf-8?B?U2hENzFSUDliMFZ6d0JCcDlJUGUvUk1Hek1JNDZrdXZnenV2Uk1UY1FFQmtN?=
 =?utf-8?B?am81Znpwd0tHNjh0TlZ4MHpsbWpScUh6YWZDSUlIUmZjUmhhQVBTd1QyN0Fu?=
 =?utf-8?B?bktsdnRnNVRkajh6T3MvY3BSdEZ4bThnbG9VbDhRSmVIUGRsY1JjeWxqTExT?=
 =?utf-8?B?cDhIdTVIbEdaQkVRek1tUGViS0FEcWk2SmsxbXRtUEpHMndLZnM5NWg4WWR2?=
 =?utf-8?B?bGM3UGRKMTZzb0htNGt2TjNCTFlXbUh5UHlwTERibG15R2dTcHpYcjVkelZn?=
 =?utf-8?B?bENCMHMvR3RqZnJXOHB3VVE5K0VoRHR2WC9YUkIreWJvS01lcjlRNGJmcnpJ?=
 =?utf-8?B?Rno5RVFoN0szMnZNMlJHejlRQ2psRnBMbEZqRHkwcTFzcVZFRXIyOHVmNExy?=
 =?utf-8?B?MFRDN3dhZFR5VUJmcFBWKzM0Y1BNd3J5dmpRZGx1V1dlTVhxL1AxbnRwSURv?=
 =?utf-8?B?S2RFYzN5blZET1F3aUNlMkNXdVBMMXk2Y2ZRQmpCWDdqQ1h2R0NKVlpUTzdi?=
 =?utf-8?B?UzNTSXAvbmZMaVJYUEZJMTA2ZHgxb2Q2eHNTdzFxT2pJYjBLQktyd1BWRG1s?=
 =?utf-8?B?dFV2MCtwU3BrWlVhYjFDTnVKYStDbm9RT2tDZ0tPUFdVN3VsWWg5bEFDM1FL?=
 =?utf-8?Q?XbvjNJThjXTHi2f1s/AS7Jy494ljO73HcEXcK4t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea34275a-0ba2-421c-a71d-08d91bbb754b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 18:16:59.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXK4FN8tE35ogpnDcxEjPg3ekyaSsh6fOLjxY4j5a1IJ3TE4zTk9tQK5BBqcAEOb4jR9/GPxyZZSamCLI5a/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3157
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200112
X-Proofpoint-GUID: YCqgMXBOG35x505tStbdDraKeSZkTNXO
X-Proofpoint-ORIG-GUID: YCqgMXBOG35x505tStbdDraKeSZkTNXO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 10:13 PM, Muchun Song wrote:
> On Thu, May 20, 2021 at 12:24 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Thu, 20 May 2021 10:59:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>>
>>> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
>>> page flags") converts page.private for hugetlb specific page flags. We
>>> should use hugetlb_page_subpool() to get the subpool pointer instead of
>>> page_private(). The commit forgot to update it in the page migration
>>> routine. So fix it.
>>>
>>> ...
>>>
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>>>        * page_mapping() set, hugetlbfs specific move page routine will not
>>>        * be called and we could leak usage counts for subpools.
>>>        */
>>> -     if (page_private(hpage) && !page_mapping(hpage)) {
>>> +     if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>>>               rc = -EBUSY;
>>>               goto out_unlock;
>>>       }
>>
>> So it uses the wrong page*, so this isn't just a cosmetic fix.  One
>> cannot tell from this changelog.
>>
>> Please describe the runtime effects of this bug.  Please always include
>> this information when fixing bugs.  And when adding them.
> 
> OK. I should update the commit log in the next version.
> 

Unfortunately, it is more than a cosmetic fix.

This 'could' prevent the migration of hugetlb pages.  page_private(hpage)
is now used for hugetlb page specific flags.  At migration time, the
only flag which could be set is HPageVmemmapOptimized.  This flag will
only be set if the new vmemmap reduction feature is enabled.  In
addition, !page_mapping() implies an anonymous mapping.  So, this will
prevent migration of hugetb pages in anonymous mappings if the vmemmap
reduction feature is enabled.

In addition, that if statement checked for the rare race condition of a
page being migrated while in the process of being freed.  Since that
check is now wrong, we could leak hugetlb subpool usage counts.

Muchun, feel free to use as much of that as you would like in the
updated commit message.
-- 
Mike Kravetz
