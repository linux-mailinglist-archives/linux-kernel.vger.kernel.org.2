Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E612332CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCIRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:11:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhCIRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:11:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129H5Eot042438;
        Tue, 9 Mar 2021 17:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Z2I636NOf6k5ECxbObixp906Gp9FvF1jjNJ2XhzpjiA=;
 b=wE51kG9TBYH4iOIHv97rI5WB27uIvfOaVHb8DfIhCP3qXWFITX43ZK9DSmrvSmufhqrk
 nh249ZA0wDrg+LctbrL5jPIsxvB0h8Q7ApXf6SZK/fkahTSPpkurc6HMjq4z10WYV/Nh
 GJjT8U5MgMS78PX3vLLvpg2MCVkEtAR6xhts3XKbC8fTf22I10q0akUEg7n1lcrRzLu7
 S1SoFNSO0p4lqNL6zp7YOkYGpBM4EABc5IseA0noeMLOj6h1L+PysT+oSp/NRJwAI0Wg
 sSdxaBnxXSi6DdciG9bsP4kXkinaY43xgkapdsAGOoXG8Ayg7VZEsTV3rMGiBWRaUCUW nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cn83rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 17:11:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129H5WWS118416;
        Tue, 9 Mar 2021 17:11:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 374kmyrfdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 17:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7IP0HmVN1hMCtsmiUxdSEOYc68066XvIWXgiQKbRzIe+QZcMFZTyiEj4pb7RoZRdFoWYrkXYLOUgNzg9aDC8XBUWfMkSZ5cMy17WDhIf7mG1SaZQFZ5jm0qLrN8P+1sEHcsBldp2UDgP7orGAMad0J2hiCf2e+1IiJuMREp6QOO7SxpLyacXnkGkWRfMquP8FrqTPl4XMXKanQVXx3CLrVq5xfDCEhXJjseIufqRO5wskeXhUkVP6BhMJWiFLgqTQUuu4La/M5kyBFYHH6msBGYElALtDWNVmsV/JQZtiYl18FibNv/TozkGs34DjHearX1OSSzrenxPPOayO+e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2I636NOf6k5ECxbObixp906Gp9FvF1jjNJ2XhzpjiA=;
 b=dHzbb77aNG1Y5E0zA6qBeJx66Fwfbor0Qj1wmpmNrKXepKQJTHCp7JCLvaGHJ6ilBs4LFCU3/vCBEdIKcW+1acSu9dDUAyn1VxzxhglrI1sg+QLtRS3ccxj2xQ/Mu21nhJlDgU5uVgJ9V+8AyZYGEHY2mIM11XUJhd31jBQlb4fMSRCJxSkmJywuucG9DiuqzT7q0jd+fAT5tOeNoBsipUMP530O2TyswPRxFTY7KmptY3X2SP5S6zzMvW0L/Lj/tXXzJI3kn0be+nv/ce2gcAYZSI6KbXIzEo3RLL15ODp7mBcULAQCLGqhOoSktTnRRK4xV0DFJgCwmSLldu7uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2I636NOf6k5ECxbObixp906Gp9FvF1jjNJ2XhzpjiA=;
 b=pb5y/eSBg1A7vtyf8hqOaAApSWXAApzXkZnjcUzyleMfMe5DJ8irIDzOmbcg2BU1E6/jFs/Qs2yBKHBUxjJECTmefLAB+LDVFDJc7FKJuaL/Rt5mVY75IH85zmgbfRXPyFJpIVVgpsbygHEAIvRBblUU+jHuUqj2Hjzxh0L27Ik=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3971.namprd10.prod.outlook.com (2603:10b6:a03:1f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 9 Mar
 2021 17:11:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 17:11:13 +0000
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ebb19eb5-ae9e-22f1-4e19-e5fce32c695c@oracle.com>
Date:   Tue, 9 Mar 2021 09:11:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:300:39::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0055.namprd18.prod.outlook.com (2603:10b6:300:39::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 17:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06792f24-d64e-4350-8b37-08d8e31e57e6
X-MS-TrafficTypeDiagnostic: BY5PR10MB3971:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39711F69D08D12449A54C439E2929@BY5PR10MB3971.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92hJv/8spAwAhMPKa/8tt9bkvYs81bcx1EiktUsxNkFjrAXVA6rPyjIbr/aLJkFyNKvSH7UJCEAmNm95RWBInw7M+/LltA0eCzzE/x4u+CvR+IQzH0voVoI22nrl7GIUMBvAMquxp7eFJn7FOe/nmheDWedvEK+wjC3JpvKiUvZc+G/qfUww0Cggyz6DseA3mlKdLEjezkh7Rno84j7DZQwfB/Gaj8o22PmI8J7a17LXK4rMqUbprdhWj21g5Lb/JsHWvBQCkuaaT4gKSkTVk7FV7lMQdeKn+xDfdp6UP8v5y2LLmZnJfkfSyhIjzKDajLMWNTfzVHZRInKE+6nOyg/p8KR1F95AMFmwavPnbMZUbgp4omDDQRhpu6bgN8bO9Bh+scoCGutamNBkt88lc3WXHdeqt7VDHgLPzmRjHMLgzkUXcC5uV+h8PU6a0jwXaOCUUyRulyrCSZujIQjBzh1uUaRYN5D+7k9TT4dEPULHMxZGVoIJ3EMTYfarTjcbaTb7JButEurNHSr0LEn2x6HixmLaAGr+zuM8wM89y5ZFFSNk1YBra0AkyF/3mn4/5PRDMsfcCHprp1+2WMVCh6ZX28u24fOfpIpCWRew/7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(8936002)(86362001)(44832011)(66476007)(36756003)(16526019)(66946007)(66556008)(8676002)(31696002)(478600001)(52116002)(2906002)(53546011)(316002)(54906003)(31686004)(16576012)(83380400001)(956004)(6486002)(26005)(2616005)(5660300002)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z3hNc2lIRTlCZ1RwdnIrayt4UFFvQk5XWUNkeEprOFZQK0ZkSkJkcnFpc1d6?=
 =?utf-8?B?VFAvd093NG1tcUpqZUVKWUk0SXhuZWdoVHkzaVlUSDN0VnQ0TGZiYURtc3E0?=
 =?utf-8?B?WDJnWU9XSFFWUDlZMWIyUjlWazlJYU0vWWxTOGR0MkFpcWRMQWovbHJEaFJZ?=
 =?utf-8?B?eFZxalluYnlFalFuU3U0aUp2UTVZenB4K1IvU2k3MDlCUElOOXdEakJwR0p5?=
 =?utf-8?B?bzBpUG1MTThyNGhKQmRQQ1BEcjdOT1dKSUw1dTdiR2xidDE0Z0ROaWs1L2Ew?=
 =?utf-8?B?WHJncEw3SE5CT3BRT1hkSU9KYTdsTU9HN3FzTDI4cGJSY3gyekZlQ1dzMXdT?=
 =?utf-8?B?UWR6VnB4UysvNzVyL3BrVEcvM0E0Z2grRElSY3lUVksxMWdvQ1JiMFFuR3FZ?=
 =?utf-8?B?aDZENzVacS95YXVYR3UrSHpiYW1kazF1RWdPK2FCbVZ6dkJtNWtDR21DcHlM?=
 =?utf-8?B?dG9xM0ZmNmdQV0ZPb0pIUUJFVHFzbFhsR2NWRFR4SCtaTmZoRGlHTG1aYkNw?=
 =?utf-8?B?cmlqSmRrb3ZtVDQvdnJqRnhuU3NKckJPbDlockdvVmhVTk5mTnRROURPWDlr?=
 =?utf-8?B?ZEQ2MmFpSXVFV0JlSGZNSi8zaWNGWjFlNnM1TVdic1NwM3BkTGt2dXE4bTNU?=
 =?utf-8?B?MXpwNlpKa3ZCTWFEcVB6bUtkZHpvalNaWjVaQVpjTGlJOXlsM3djOVR2NDFy?=
 =?utf-8?B?MlFUeUQwTmtCcGtacFB6YjBKbkY3Q0tTaDFITkJINTZLVzlHL1M5RzNoOGJN?=
 =?utf-8?B?NFNpaXhuOFEzWjhBY01FUWR2dUJZVzdmditSdldiajFpRGdYMUdFanpzcG12?=
 =?utf-8?B?dzZHc2JWTzJDVVhqMlM4aEYyMXEvKzNFcnZTU1lwblAzQVlVVTY5U0Y1L1pV?=
 =?utf-8?B?b2RkR3BpS3V2ZmFtRmRkYVZpNGoxd2lsZ01HOSttZmhwVnlSVFRJeWxoalJ0?=
 =?utf-8?B?dEpqNTdVdDNDb2Y0M0N1TWhQVFpFV0R6eTNuRy9TaXEwZnNyTjdXcWNFZ21q?=
 =?utf-8?B?WTBXaElIY25qZzR0c3ptOU05bm1uTmxadDk3ZFBEL2l4bjB1Q3JsZlIrNzZY?=
 =?utf-8?B?dnNUcVcvdk9aUnVJWDBWWjJpRHVSL2JXZXBibzVyM2g3bUs1OXJ5RkhqckR0?=
 =?utf-8?B?bWx6TnlMeWZPYXZRQnRNT01VTStWSjBkOHNPdFNRS3FRNjVaL3VYMm4raG5v?=
 =?utf-8?B?Y1dsNHJVQ2xONHNmYy9aUTdEd1pUcmlBMzY1anc4QjZMYWFIbVl0RWNpait5?=
 =?utf-8?B?YzlUYnljQkZsSC9yNDJBQkFtUkpKM25kR0gwQTAvNjdhOXk4WXNxQk5JZ2Zl?=
 =?utf-8?B?YVUyYUxDV2pybm5ON01TajRydFAvbkNFam83emdRRHpySWR6R3lnNUFsV2VW?=
 =?utf-8?B?cmY2RUZRYmllVjQyS3pZU1Q2RWZJdmxGamd1OEg2ZjZJT3lTU1h6N1l3MnFa?=
 =?utf-8?B?S2FOQzVVVWlLdFI1cG5SZ2xtZW1McTYyWEdNc2IzaEluQzJuaUczUitNQUNV?=
 =?utf-8?B?Skt2N2hReXNxQUV5eXkwd2RzWUxtWTBmcHA4eXJOcStpRXZHYnJwdGNKQUhx?=
 =?utf-8?B?b0U5aU40VXZneWFSbkd0cU14b0tkSFdNcm5iYmI4bWE4TEFkTklTVjZJZDJ0?=
 =?utf-8?B?dnZ6dlJTYWY0L05XS1AzV05MUE1DSEtSZXh1aWd6S1FzWkpqQnJwRlhMbTEv?=
 =?utf-8?B?ODJjUWJYdEEvR1VlcGwzSElURTU3YW40dFJuS0FJQXJyNWhzNzJJVHE1ZnBU?=
 =?utf-8?Q?WydS22+XJ5Don0v5eKzQpVL7xb46Sipt6OKlOCK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06792f24-d64e-4350-8b37-08d8e31e57e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 17:11:13.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCqbPyqayLBqobXFot9omxf39BqJygrC63wJzgcWVzzhm+A62v8XllSE0XJ97shU/SgngJYY6nZGFiGmE3Tk2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3971
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 1:01 AM, David Hildenbrand wrote:
> On 09.03.21 01:18, Mike Kravetz wrote:
>> To address these issues, introduce the concept of hugetlb page demotion.
>> Demotion provides a means of 'in place' splitting a hugetlb page to
>> pages of a smaller size.  For example, on x86 one 1G page can be
>> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
>> - demote_size    Read only target page size for demotion
>> - demote    Writable number of hugetlb pages to be demoted
>>
>> Only hugetlb pages which are free at the time of the request can be demoted.
>> Demotion does not add to the complexity surplus pages.  Demotion also honors
>> reserved huge pages.  Therefore, when a value is written to the sysfs demote
>> file that value is only the maximum number of pages which will be demoted.
>> It is possible fewer will actually be demoted.
>>
>> If demote_size is PAGESIZE, demote will simply free pages to the buddy
>> allocator.
> 
> With the vmemmap optimizations you will have to rework the vmemmap layout. How is that handled? Couldn't it happen that you are half-way through splitting a PUD into PMDs when you realize that you cannot allocate vmemmap pages for properly handling the remaining PMDs? What would happen then?
> 
> Or are you planning on making both features mutually exclusive?
> 
> Of course, one approach would be first completely restoring the vmemmap for the whole PUD (allocating more pages than necessary in the end) and then freeing individual pages again when optimizing the layout per PMD.
> 

You are right about the need to address this issue.  Patch 3 has the
comment:

+	/*
+	 * Note for future:
+	 * When support for reducing vmemmap of huge pages is added, we
+	 * will need to allocate vmemmap pages here and could fail.
+	 */

The simplest approach would be to restore the entire vmemmmap for the
larger page and then delete for smaller pages after the split.  We could
hook into the existing vmemmmap reduction code with just a few calls.
This would fail to demote/split, if the allocation fails.  However, this
is not optimal.

Ideally, the code would compute how many pages for vmemmmap are needed
after the split, allocate those and then construct vmmemmap
appropriately when creating the smaller pages.

I think we would want to always do the allocation of vmmemmap pages up
front and not even start the split process if the allocation fails.  No
sense starting something we may not be able to finish.

I purposely did not address that here as first I wanted to get feedback
on the usefulness demote functionality.
-- 
Mike Kravetz
