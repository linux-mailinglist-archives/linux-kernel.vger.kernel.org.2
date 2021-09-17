Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7641005D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhIQUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:46:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16670 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhIQUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:46:41 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HIxVKw025247;
        Fri, 17 Sep 2021 20:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8GE2eT6ssr1C1nKdjzhvirq9HFTv+7Cip8H7q3oczms=;
 b=qT1sc37OaW8NMMPCoEoaQWFHfvHDY+8jXBDrYp92cty2MJp0WSIUWO/xaBPoBGg4683h
 eGIu8i3vVTilzB+AdUJzZAp7IZMh0r1vzqRGxVgcGBuqwUgN4TZUmIlVqiA7GLVBKJFK
 bRyXisF4JqVRGs/SVa7jwp4UtjBZXQUNxuINCfHi7EjwSha84MG2rB2FaElVhn0PLASr
 DnknC9zMCbMrwtTjjB7vF1Bgdn7ivG3RD//MXdQJzDsWCQBxaaL5wYutkFKIoifEKA6y
 DZZpGtca9bAE0tt7uvHr75kFYcIpmmCKtJFg78ImOCRYQRkOcESTtCkSrSBOj1r4Mb7X jA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8GE2eT6ssr1C1nKdjzhvirq9HFTv+7Cip8H7q3oczms=;
 b=VFXG7L0zRw64A9EW5hGVwBO2Bl9VTzEXKe3FBdF/z2haUdNSsQjbiHNTfmMeiGbc8Lk7
 9gui691yfLI7dWkRSMecp0gQU2rJK2txkW8mt0CbJdBiMGxv2CEpM5NJVysaqtBXm45K
 c0LD+KlPgzYKz86h5a5sTrI+NIpz8vDyRymJ18xYIxm1bXjkhWrBLsGp1vKh3q76VzSB
 ymHTkUZi7hHbWSRZsF/j7Z6UzfVNYaJhPIzA3ZZvCJji/d/wn+jDQOsLtQW+RImC8V3I
 BOGs+8vqUstjgbJQnCPxnsMt0bbwHITXXO2I8/VXyMu/B1Ol1MSxkKaoGUHrHmcxKT/n TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4px8ak7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 20:45:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HKZmr2088579;
        Fri, 17 Sep 2021 20:45:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3b167x9w00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 20:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyA5PTTgeJnVak7bPlYtCzA9BKx+ddbqxZ4++qHtXUBTRg4TtknKjDWIzGEey857beSKLy53Xy0So3FIv+I1lsBxQ79EUEDkAVCcM9un9F5ma2kgn2C5NWaKy2gSpq/03cHdUJUACk3JbU6Okz9c13dutMPq394fZ3qXVdy0PJZ00biLOiknxH2o+O6Ba5aEgU0oN3tWdtRxnuWoQgOgk+6AB7kSpplaDKYDPIilKD4qTqh1NSi0p4lQgX9ZxP9unFoPMAJzmKmUsCWNzLDZwAvPdmgM7xcShlJMDXR9yU4g1i63dVMn8av9freO1QeMBMXv6WtyByaZ4rSHMsJBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8GE2eT6ssr1C1nKdjzhvirq9HFTv+7Cip8H7q3oczms=;
 b=AAgL8hArHOfzhSwGn/DNMtX1dsPTA3jmPjJC1T1ItlUwVZo2yUcZsa0JHQBt6Ci1fH6Mn2XRLxG6NzY7Oel8FUmhrC6N3LBFize2/S9RRnT90i7/CeLZ+XVq2N2iwto4OoCN+0YWijsYe8ew3lI6HNR7mzyTd6634pL80hY+Qrz4Xc6yGbGYKdhM/w/pe54QcGEERKpau958l9QSc3jn68UdnTcoUq0B6s+qfX7HVsAvKwOccUf3x6e766fOhF6Crs9Dv3swB9jfgKprcSz9CYfiu0Vzcd24BF/R3PXf3sRlj1I3ICmM1sfOKmIdgytAqTjrNiDdWIlyk61UdJjNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GE2eT6ssr1C1nKdjzhvirq9HFTv+7Cip8H7q3oczms=;
 b=xXL8+3mJAY+rgxjgJOlw1XPCiQ79ple//NwYhlvBKjV95N/RoMJkDRGdTsnjHqdS3+GvbaV+I/uxibZlC+koAVGxrbqwJTl4v0LaOsm8gT0b2CmQBkpvAjuyjmM4M12Tih84JviYqygEyd4wOrk2/hJCLDpOtq+SZ57xF6bFDPo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5438.namprd10.prod.outlook.com (2603:10b6:a03:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 20:45:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 20:45:00 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Hillf Danton <hdanton@sina.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
 <YTsVT74kAgpAD17s@dhcp22.suse.cz>
 <2519e0f8-98ee-6bad-3895-ac733635e5b0@oracle.com>
 <YT9zUaPofENSMQHg@dhcp22.suse.cz>
 <b053cb84-67d3-d5c7-fbb6-c9041116f707@oracle.com>
Message-ID: <3b3d4263-8872-21cd-cd05-4e13043a882e@oracle.com>
Date:   Fri, 17 Sep 2021 13:44:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <b053cb84-67d3-d5c7-fbb6-c9041116f707@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 20:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b1b6ea1-e87a-4544-75fa-08d97a1c0435
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5438:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54381C22FCFACD340B8CF838E2DD9@SJ0PR10MB5438.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQXkLsfqhMNT6nIpKn7yM+o1061Lx+sgXCf2a3Z0HCFMHLcRivgqLJtr19kINuj9TIdj1/mXDfWYUcRfs1DO8r0hTQqXxmfqnK65et7m0KKfSPHjMp9jvVsu5OAxkWmYKXYDYDp+S6om+AYjoHJtHsZAQGRSslyvSpqN/Rw7C13UKYrJDDjC4ttWvAzBTMF/djycQaYvgOLdt0p66N5dbDgHCwhBE9XF5bhuRKM8rOKuO0MzsyEbhe9a5BWec6edMye8DSNa3ICTOCh9peZvTnnP3QMReP0VYMsKx12v7/y4qedB8kUCvMSTjjyDixJzvCytdP1BntSOe5jlh94OoLihU6GQaluqCCQI92PFl12Xp0PleM154pE9rvrayu3O0F+34KkhhRFaFY3ZQ3UI4+ndro7yLq7e5FOnBt+O8rZ58iJLXGkjezpaP2tqvPa3YRHsTKZF7CEiHGHxqVWRWnRP2bMugbhkWdDVpDZ36G0gTHLguPFs76XvKps4WP2FemZw9DqyaXiXEupbmxhYDIwjlo82Eo4s2QGTL+egAWuUuflMTSlzJEo89KctqizC1nPn0kjU6CbiqppYuOHoIv1UzCt3fO6lAv8y1KCJCNTCBMVvPvIndZwSCE2/KMCPuBSz+q+hfNsOAr7+ZLslD/x6qKlyuzWNMBQWO9rpiQQ6ZPAk5Zuu9H1Ee/dzoAe0anFP95GPAVGu8TMzT1SMtKtLTLYybMmNs3GiTLwQm0XKgILWvuy+82QFwFv6+VTbFBOlduo9wuveb8y4iSmRng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(316002)(31686004)(6916009)(36756003)(54906003)(31696002)(508600001)(4326008)(86362001)(5660300002)(6666004)(83380400001)(6486002)(2906002)(66476007)(66946007)(66556008)(2616005)(26005)(8676002)(186003)(52116002)(8936002)(956004)(38100700002)(38350700002)(44832011)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lBUzE0eHNBS3pFZzJYVU9pTk1zR0JjSkRjSWVYVmxxVW9kU3Z4ckVzbHRG?=
 =?utf-8?B?ajM4UnlPNWJFRksyWm1qdTg0MGE1VlVnSVMySkEzdyttSk5pWStzUXhpWFJ2?=
 =?utf-8?B?SG1pMi8wMUlaL0hDNnE1dUZ4OEtFdEUvaEUySG1mVXJVYlFMSWltS1VZRFY5?=
 =?utf-8?B?alNoU2RocGdUaFlvOEZib0hIYm9UWjFBME0xdmR1TWVZSm9abVdEa1BmLytQ?=
 =?utf-8?B?ZFlzeGEyellPSzFZU1ZOS1hXTmdwaDhQUnExY1JKNVM1empYMC9hYUlVRkdG?=
 =?utf-8?B?STJOb1FxQjV6d1AvRS9PaHE5THB5STd3ZFVuVGpINnNVL3pPZ3F1OTB6bldR?=
 =?utf-8?B?N0ZXSXNsK0tFZkdsVFJhV3FUd1VjSWtqN2ZNNTFVU1hBR3BsVDRoK0tLbmZY?=
 =?utf-8?B?MzdRNTJCYmhGUFhveTRRMWxnMGpERHRaSDNUNWVwOG4yZFJiL1BHbk9ySUI1?=
 =?utf-8?B?UmQwOHI4TDdZZCt3ZklHYVl2TmIzOUR0QWxEZ0hJWU9JdEl1a0VaY0dPY2FW?=
 =?utf-8?B?aWV4eGVvWk8vZTFwU0R6Zm1YM0VEZitEWktrcUQ5RUp4NG9rMnJPWEVlbW56?=
 =?utf-8?B?T2w2dGxPWDgyaHo2RlNRTXE0SnZiLzBHZEFva3FVdW9HQU5qZWJkRG9halpk?=
 =?utf-8?B?eHYrOWpkTG1rbnhsWXhla3pQcFZweW1YdW1Rc2ZSZVNiRnkvVks3V1RuMVFF?=
 =?utf-8?B?a2xqMTZ6dmdHMnBSSmxGSm9oUEJyb0t5QTNkeHhoYVNuNWF3OUkzQzF5MVVq?=
 =?utf-8?B?djh4d0NZMXJmSVV4LzRFeElHMWFWK0tFMEh6Y2RNQm91WS9PUGNOVWNMWXM1?=
 =?utf-8?B?SG83Z1RSUCtoQit0TUI2djRsWlJoUko0RHNFeXRXVHpOVGtWQ29KcDNkVTM1?=
 =?utf-8?B?WE5MVDhxUHh6YWo3d1BwRXVmREtKSk1iOHRnNGdRdXpDV2x5OC8rRUpzdHVm?=
 =?utf-8?B?M0ZVSXdSaDVsTjJ4WTdQaW93WUV4aUxVSmNyZnB4MDF0SmNzLytBQjFDRUVi?=
 =?utf-8?B?N20wRWJQQ3NvRGFBVVo2bWpVdVRGc3JvUWtPbUl5YTNwSFJjd3JRSk9uKysy?=
 =?utf-8?B?b2RNN0R6U3dLRVFQMW4wRXlQckNLVlFOLzMybzRaVnNLTC8wa25GaUpoRGxR?=
 =?utf-8?B?dWpmVVNLRnBNVWhJSjh0dXN0dU9kR01VTGhRTHJhUEtyb2I2cHA3WXJLSDI5?=
 =?utf-8?B?eVdGK3pJK2FCZTd6UXQwMWcyY3VmbitBeGZSMjRPeXB0emw0R1ZOb2NpYWRW?=
 =?utf-8?B?MWF2ZHRaaGRaUVlucFNJSVcyNkk4dUsyejJaeThpeENuR2dNd1FIODdPa2Y1?=
 =?utf-8?B?YlJaVGVVRERIQzF4UzhxUEsrRkkwZzRMK3MxOEZEemJucXBHaytjdDVsRFVU?=
 =?utf-8?B?MndLWlNRUWVXeU1lay8wRWpaNzVNR0JDSGN0KzZ1ajFQT2FtdUVpb1lVcTJt?=
 =?utf-8?B?a01Ic29qcE4yMFE4QytPR2toSUpuVDBCSEh0WU4yTXNnQzBieDZrL2Qyb1Ux?=
 =?utf-8?B?cnd6a3ZtYkdGam1icmdjS05kaWhoN0FnWTJzYXV1aXZsalVYQVYrUGlZM1Fo?=
 =?utf-8?B?cXdzREdDV3N0OUgyeEUzNjhJU3JtaTFaK0luZjBBdFNVdWFXbkp6UzkzVmJs?=
 =?utf-8?B?SmVJODh1NlNyY08xREVCYW1DRzZYOXU0WVhSOHlqM3hVWXlSRGlmeFNRaGlG?=
 =?utf-8?B?dytEYVh2Qk1ucEFENzJVWk9FZjc0MzFGWmN3eTlaRmpCZUo3WFM2RjAyYmRJ?=
 =?utf-8?Q?UErMcTd7JM3VT2xQeaukijLPAboARu4GCsT9mUV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1b6ea1-e87a-4544-75fa-08d97a1c0435
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 20:45:00.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5iW2Uqb8c89DTo5na2RvvXPPsbQ2ordCamjiMiyjWdzxbxsT+eT8Id/3TN7zbU8bh7FisWxcyMPwTVuBYiHyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5438
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170123
X-Proofpoint-GUID: PN2DGMwu_VDURcyIVjR9Vr6Rr1DnT4Yl
X-Proofpoint-ORIG-GUID: PN2DGMwu_VDURcyIVjR9Vr6Rr1DnT4Yl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 9:57 AM, Mike Kravetz wrote:
> On 9/13/21 8:50 AM, Michal Hocko wrote:
>> I do not think this is a good approach. We do not want to play with
>> retries numbers. If we want to go with a minimal change for now then the
>> compaction feedback mechanism should track the number of reclaimed pages
>> to satisfy watermarks and if that grows beyond reasonable (proportionaly
>> to the request size) then simply give up rather than keep trying again
>> and again.
> 
> I am experimenting with code similar to the patch below.  The idea is to
> key off of 'COMPACT_SKIPPED' being returned.  This implies that not enough
> pages are available for compaction.  One of the values in this calculation
> is compact_gap() which is scaled based on allocation order.  The simple
> patch is to give up if number of reclaimed pages is greater than
> compact_gap().  The thought is that this implies pages are being stolen
> before compaction.
> 
> Such a patch does help in my specific test.  However, the concern is
> that giving up earlier may regress some workloads.  One could of course
> come up with a scenario where one more retry would result in success.

With the patch below, I instrumented the number of times shrink_node and
__alloc_pages_slowpath would 'quit earlier than before'.  In my test (free
1GB pages, allocate 2MB pages), this early exit was exercised a significant
number of times:

shrink_node:
        931124 quick exits

__alloc_pages_slowpath:
        bail early 32 times

For comparison, I ran the LTP mm tests mostly because they include a few
OOM test scenarios.  Test results were unchanged, and numbers for
exiting early were much lower than my hugetlb test:

shrink_node:
        57 quick exits

__alloc_pages_slowpath:
        bail early 0 times

This at least 'looks' like the changes target the page stealing corner
case in my test, and minimally impact other scenarios.

Any suggestions for other tests to run, or tweaks to the code?
-- 
Mike Kravetz

> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eeb3a9c..f8e3b0e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4413,6 +4413,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  
>  static inline bool
>  should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> +		     unsigned long nr_reclaimed,
>  		     enum compact_result compact_result,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
> @@ -4445,7 +4446,16 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  	 * to work with, so we retry only if it looks like reclaim can help.
>  	 */
>  	if (compaction_needs_reclaim(compact_result)) {
> -		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
> +		/*
> +		 * If we reclaimed enough pages, but they are not available
> +		 * now, this implies they were stolen.  Do not reclaim again
> +		 * as this could go on indefinitely.
> +		 */
> +		if (nr_reclaimed > compact_gap(order))
> +			ret = false;
> +		else
> +			ret = compaction_zonelist_suitable(ac, order,
> +								alloc_flags);
>  		goto out;
>  	}
>  
> @@ -4504,6 +4514,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  static inline bool
>  should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_flags,
>  		     enum compact_result compact_result,
> +		     unsigned long nr_reclaimed,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
>  {
> @@ -4890,6 +4901,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>  	struct page *page = NULL;
>  	unsigned int alloc_flags;
>  	unsigned long did_some_progress;
> +	unsigned long nr_reclaimed;
>  	enum compact_priority compact_priority;
>  	enum compact_result compact_result;
>  	int compaction_retries;
> @@ -5033,6 +5045,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>  							&did_some_progress);
>  	if (page)
>  		goto got_pg;
> +	nr_reclaimed = did_some_progress;
>  
>  	/* Try direct compaction and then allocating */
>  	page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
> @@ -5063,7 +5076,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>  	 */
>  	if (did_some_progress > 0 &&
>  			should_compact_retry(ac, order, alloc_flags,
> -				compact_result, &compact_priority,
> +				nr_reclaimed, compact_result, &compact_priority,
>  				&compaction_retries))
>  		goto retry;
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eeae2f6..d40eca5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2819,10 +2819,18 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>  	}
>  
>  	/*
> +	 * If we have reclaimed enough pages for compaction, and compaction
> +	 * is not ready, this implies pages are being stolen as they are being
> +	 * reclaimed.  Quit now instead of continual retrying.
> +	 */
> +	pages_for_compaction = compact_gap(sc->order);
> +	if (!current_is_kswapd() && sc->nr_reclaimed > pages_for_compaction)
> +		return false;
> +
> +	/*
>  	 * If we have not reclaimed enough pages for compaction and the
>  	 * inactive lists are large enough, continue reclaiming
>  	 */
> -	pages_for_compaction = compact_gap(sc->order);
>  	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
>  	if (get_nr_swap_pages() > 0)
>  		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
> 
> 
