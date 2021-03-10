Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342AA33483F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhCJTpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:45:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34884 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhCJTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:45:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AJdXNF093642;
        Wed, 10 Mar 2021 19:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QFyXKKTg2etKltUGmqkVevYUwtN0xK241PKmVgukfrI=;
 b=EGmBIzL1Q0Yl9hV6rQTFlaKKV8tvXykRGFAIy7PCX2CgaCCAIluXC/rcJ3mMO9E74poY
 /IXcDfHnHycNvm2sV6LEYogm3ZhUiJypQjpeOYZRMS5v7HX408bT+UeUZBpUv8GXmzHj
 HI2PHDpKnEvdf6k+C1f45vR7T4DHtWkuoUwJpA1RXT9hs744kUsbS2+NXLFtAZwe7E19
 p+earzfMsX/B404vYHNFsfzy4Z+/UyHBb6zICZ3h0n8kzd6tGc8rr/ptDyMCPP+8dw/6
 2W+b19lWJBxwASjWyUlQqcnota5HxM1IGVu6OQutIl8do23/G4kzA3d32evKfsp1OcYI vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 373y8bvdrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:45:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AJdYkJ005180;
        Wed, 10 Mar 2021 19:45:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 374kn1epw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz3RlVITjuICnOK5dT22MEQ0/Ew/yHH9fAFf8e/uEMo9pgT0c3NUOsrqEMueHz0nTnpt4Cp+leoaid34jcCDL2fh/q8INbu8/54Nf14gHwKEEMQgU/tnJ1n4rjq/77GZNwGcqMgt7CiBg7PAywk4sK7TrjCbqx1AprrTbOPZZdWR3zyWanIXaH8ax5iOBXUt3CuyHnIacp+kOm4iO3Fuys/8TrY/IKsGC2jiG1pLxKxEx2FQ80UUessRM3wAIhq+PI/PYCzh07PWX6G8pfe4Rne+CBVdADIHrM7MQUhXwaaYisVkZfmbQLeFiRowXbYlqw9PIQhsj0w6G8GTSx2MJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFyXKKTg2etKltUGmqkVevYUwtN0xK241PKmVgukfrI=;
 b=bFtHIKGSRLq4zlk05oQrGoW8H415q+h/iICOHbOU7zX80RXATJSq3hxrWovyvG45knH9kEjeZ3l1EbtOFK0ul4496Up0nksNgDr6Ea01GghsT0Rp0r3+EPW6Pb57HNnPgrTxsClaPHFHnAnrHqyG+72MVL2ZVVrCf4xk/ivEQtmHQB240QIb4iefxiUkb5vSFxaMYcLtz+VKIc6RKd735h7Ldjh5w1LpEVzxtUvpgVlpCaM3aLKwYx/pcADUhy2mctoKvpvsITN8+fNwGlBLa+9+skzNGcKmC9F6qV2cg7sCqKxLa453K01KXKQHU9x3hXFcUHK4JMEQCEZDh9v3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFyXKKTg2etKltUGmqkVevYUwtN0xK241PKmVgukfrI=;
 b=ul6rwsKttn35m8VoAdagq4uD/Ke4XKEdg4HqcNltuLSXRggmfUotqWCET066PfrsITy5lHZGKK16b4/GOZS0rxgSK1afhAOL0bkRODKgbbWUmaFmTnO8niVRoBj1tt0L0sZlvDUOMQ9nx61s5jy7fJz4b/ZkZY5jBE3I8BgH/ds=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2597.namprd10.prod.outlook.com (2603:10b6:a02:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 19:45:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 19:45:24 +0000
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4ae28031-6cee-59b4-94d1-832290d7813c@oracle.com>
Date:   Wed, 10 Mar 2021 11:45:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:300:95::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend Transport; Wed, 10 Mar 2021 19:45:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8153ded6-8674-42a4-b302-08d8e3fd0c1b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR10MB259779106D87941567599AF3E2919@BYAPR10MB2597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmYqMIWhZXyOmv+V3IP5uL/bryrhbBRO+fmxKGXchfTEVpae8SjtY9kPnHY4E1BEQF6Mgu7ArbxF++f7fINZByHx5DlqE4AG6m/Q46/sL2tRDufOf0tXdZijsZQzkaMHWam5QCcdzZtOypJT4MAnLPu1qmO18+5ERRVJhZf2IYk9haUVlnlFHg1+bLPmAAuGAIrngxeSSprhHMyZhz9S/1Am9usPFnHPtLuLXT6Lz23K2+bhc6G4Tng5rHzCNGX2o4ssWM314eedjRwwIbVeX4Axahqz6eDqHlAcALjvrIqaQmm+QLCRpNpuzi9F2uF6M/2Uuo9WBfwGZOBah13dlTOW+2O7QN9vEKXGjc2l3D/LqRzgHX7O1uTJfx9NCzEGJ0tf0PZ3HXSSq2jZHEuH1lslqtce5m00oX3fNXa3X+54D+JkKtK99FYn43byPJb7KZDZ84ILb4LgDXdqNB+jzq9zqCeCyR4DhPq39sQ5DaXeHhcq0YkCLpM8Pqmo9Xv6WUFRXaMXR72OCz5XyKAo4BW5rPALks+hb6qwbTvAyI/27/zBz6uDLE/Iu2zxicSenSJa+qjHUhp8UgLPVyLHVo/EgDxqkaQsnXIAOlANTaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(31686004)(4326008)(44832011)(316002)(6916009)(54906003)(66476007)(8936002)(956004)(8676002)(16576012)(36756003)(5660300002)(2616005)(478600001)(52116002)(6486002)(53546011)(186003)(2906002)(66946007)(83380400001)(66556008)(31696002)(86362001)(16526019)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1RNUHhyL0ZLaEhtOW9CRkg1ejV2UmtVL0toVFI5OEhSMk9MRFppc2NvRGN1?=
 =?utf-8?B?Ni9PRVdTaWdRa1o0eXRZT0VCTHZlbisvY3BndE5hY2ZLZDcyUDJuRjd2RnVW?=
 =?utf-8?B?eDIzVmRnSnp3RXZEZEo4aWxRSWh2b0Q0RHJjeWY5QXp6UjErYTBOcDlGTENn?=
 =?utf-8?B?R1BqUkZEZ0VhanFnc2trZlpqRFZRSWFmb1FnNEo4ZTVzUkplSFJ5ZXFNamxR?=
 =?utf-8?B?aUNyTERoSjhCeGM4aDV3a0dVL2hXUm9QcXBrbFVXeTMrTVQ4b0J3SFRXVzU2?=
 =?utf-8?B?eU05M1JPV0dsYWJaaGxUekQ0NzQyWElPMWJKQnlIelUwcHplNm4zMXlmWU5j?=
 =?utf-8?B?eHd5Yk8vZ05EeGh5NXFYQnEzNmVidXNzY1VFc05hSEwyU1JjZUdFdkFHRDV3?=
 =?utf-8?B?c3pEWU9zS3crazl2bjBUN09OVTE5bHJYNEsxS3dTYmdraUxKRUpQeDBGa2Ja?=
 =?utf-8?B?SHIyOFFFb1hwaDZCZC91Um04Yi9uRkdoaktNVFVnUFVIZ0svQzdXeEVJNXBt?=
 =?utf-8?B?ekwvc3B2a01sZzZJVVoxQ2k5WEFZUFBFaUwxWEF0bko5dkJmQ1lPdlNFVzBC?=
 =?utf-8?B?cTFTMXpjWUt3Y25aRzhZbW1FeTlqLzFGUllpUDlaNGJIR214bTh6bFFUOWNB?=
 =?utf-8?B?cS9tN09QL2o4bmJoU3lPb1lrMmd1ZU5pdVVISFl4d051VWVaeEdVdVJXQVE0?=
 =?utf-8?B?dUJ4ZEVWSjhLYis4bW5oRTJEVGlFZytqMXFWd1QxaWsvSThXZGNkR0R6V0Ru?=
 =?utf-8?B?ZTZJZ1d0aHR6QkRhRjBGdHJHdnI4OXVSeGZSSWJQNE1ra1BIekozcHljcE5V?=
 =?utf-8?B?WnJsU2NJN2NqTnV0c3JWTitwZnBmbEttazAzT3NMVG02WFBJQlE3ZjhwTzFY?=
 =?utf-8?B?ZEswZVJjZnFEdXVRZmlndnRMWFIyd1Q5Z1Zsb2FWMUxjU1hGVmVaUW9BWkVM?=
 =?utf-8?B?Um5oNUZFN0IzRWpQcjAyWjNLdFB3UnFiVW5rSisrRitpZmJrdlZoQ0UrUE4w?=
 =?utf-8?B?M3p1ck5sTndaVDJOc1R5TTFPZzF5WkZSTjA4NGdZVFBRK3QxVHp6aTdMNnZl?=
 =?utf-8?B?ZEhJTFcvSG0xbXVJYXNEZGU0THFUVG1hTlQzRTVPY0ZJeWRHaUluTS9lMXVG?=
 =?utf-8?B?TUthMndGZFlqcnNvUWJzaU5FOFY1T2FqWTBLcHVESlNMQU94Q2pXVC9wNlVK?=
 =?utf-8?B?ZVBITm83SnY0M0g4ZVU1eVNtU05tUXF2TkJ5OENLNjExNVdjTWFRdVN1QWlB?=
 =?utf-8?B?SVRYTHlDSno0d2I4aXJ0RndlM1ZnL2E4WDJFQStMbkFxK3BHOSt2a29NZVBO?=
 =?utf-8?B?bzFEdlFkay9ESHdVT21Zb1gzUi9sOEVJay9aVzlXcXRURDFLVEJDYUY2QWRY?=
 =?utf-8?B?OW5YR1NrU3R2czU1TUE0QXA5Y3JXYU0rOVBtRndEaStiVFFvN01ic1dZL1hK?=
 =?utf-8?B?dDFxTVlRbFB5YnVXYmEwbXp2YUlCZFcwZmtFajFBMG8yS2FIM0RkaStQekY4?=
 =?utf-8?B?ZDNXNmpoMVZHU1RGZnpSNGxkQ1A0Ymh3ZFkyamV2Q1NLUHFDUVdYOU5nNWNt?=
 =?utf-8?B?cUVaYURPaFFYUTBOYTIydFo0OXZMRk92R2ZOTzBPbHo2NUF1Y213UGR1cEVW?=
 =?utf-8?B?ZjZFOE1MUFAyYmpjelJEWnlFbUN0bWdHd21EZ2JjbUVteis2b2VEVUJhbG1P?=
 =?utf-8?B?dUdwbko2OFhYR0hpTVJ2anBLWElBbU03cERtSU1OeG9DQzMyUkx6cjhnbDZr?=
 =?utf-8?Q?Mx3rG1uY9P9i6x6NZh2/Mc7m7rOmZdDNH9Lwm4/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8153ded6-8674-42a4-b302-08d8e3fd0c1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:45:24.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo68tW746zrwAx9MZKzJS+/A/T2XtnH6aemJUpWuqk/k2HpU/Asjkwl5WJdmvSIqJAEQ0LeFEIGFC79K7rFcdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2597
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 8:23 AM, Michal Hocko wrote:
> On Mon 08-03-21 16:18:52, Mike Kravetz wrote:
> [...]
>> Converting larger to smaller hugetlb pages can be accomplished today by
>> first freeing the larger page to the buddy allocator and then allocating
>> the smaller pages.  However, there are two issues with this approach:
>> 1) This process can take quite some time, especially if allocation of
>>    the smaller pages is not immediate and requires migration/compaction.
>> 2) There is no guarantee that the total size of smaller pages allocated
>>    will match the size of the larger page which was freed.  This is
>>    because the area freed by the larger page could quickly be
>>    fragmented.
> 
> I will likely not surprise to show some level of reservation. While your
> concerns about reconfiguration by existing interfaces are quite real is
> this really a problem in practice? How often do you need such a
> reconfiguration?

In reply to one of David's comments, I mentioned that we have a product
group with this use case today.  They use hugetlb pages to back VMs,
and preallocate a 'best guess' number of pages of each each order.  They
can only guess how many pages of each order are needed because they are
responding to dynamic requests for new VMs.

When they find themselves in this situation today, they free 1G pages to
buddy and try to allocate the corresponding number of 2M pages.  The
concerns above were mentioned/experienced by this group.

Part of the reason for the RFC was to see if others might have similar
use cases.  With newer x86 processors, I hear about more people using
1G hugetlb pages.  I also hear about people using hugetlb pages to back
VMs.  So, was thinking others may have similar use cases?

> Is this all really worth the additional code to something as tricky as
> hugetlb code base?
> 

The 'good news' is that this does not involve much tricky code.  It only
demotes free hugetlb pages.  Of course, it is only worth it the new code
is actually going to be used.  I know of at least one use case.
-- 
Mike Kravetz
