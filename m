Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7453A41CD65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbhI2U1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:27:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2890 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346361AbhI2U1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:27:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TKJ75g027990;
        Wed, 29 Sep 2021 20:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4AhW9kIN8x0+SRNyixl33/n41FV6M2YbLCQQLhVcswc=;
 b=vl41Zblc5UOUnqg4I3YkbUBovjSzNYWYerl840j6T3+RvXpXq+gF+jyjhymdPtqSRdQD
 dK0ELLPsNNf5FyH151W7qv2XCCyOnP/6Qv+wKL9yTyJRvewYhIVG9Nf98TbU3W/3BwEi
 G5ll4Xyt5NWPdS18m28BHBgo9rcutmPWErqfRPrGNjH+Oh7W0vyOFMKZPysZKmlI+Kf3
 DsT+woJBc8nuaGcT7Al+ipE28ooD1MztY+U4j1v3oSnw0I6VPTy0TryahYZ2oMk3zRoV
 /kwVnVcLTAEEaASjdgpfu+aUGmLWdj/sV9lkGXJ5MZnRDdq2sk03LrQCGnpT2pUb/Qfv tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfkxa51-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 20:25:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TJeTJs127890;
        Wed, 29 Sep 2021 19:42:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3bc3bkg0sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 19:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJfckro0pvFqWRdvyr++sRCJLF0yQz1NGxBlS/XZ6Hvhe2tNR5UpoaM9oHaYAYwxhg9HURQpdjTiWHrv0GRoBDY9+L54fQeFL1M4FYh5JJiJ0KuDqHdo9Rd2YcAguenlf+Pm8GNBpgN5mixDn7YusgCkurScGLQ6yeS5njlDoLeL2s1GhIPt4ccVGldnUcTr/KWqOo/TOoNBfhz/GXXj0FvW9J/K31tJgUWebH4o0flxDRfcGhfuR0n9iVAGV0LUIxLANQos7XpJtTQXishUDU2lR4QnUXxBqNcjqGvLQL9tsrPJzfOzbX8oEiSR3v0fgV7qNled/hoUI5mawPtQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4AhW9kIN8x0+SRNyixl33/n41FV6M2YbLCQQLhVcswc=;
 b=cMSGFjMjPj8OqAQKeUp6IoPOx5LZ3PEY49sdyxYGv+hO9qusdgTwRHIUcnetPULAXkFNFs31ZEjDRmiZjmQ0hiff7Xl2wdviTocqNm3D5imHI6vqPqyZbcMjsSY83lHCN/t1hj7bmy9KhM5XympdRyzsarWl8U8fsOS3m9hAtdvL71Xi84dUdkI3VlOcD6d/kglQVx85Hqa+nVICaVlQrHCenXcNininXIexD8kdBhPGQWcGsz5TJPz9Q0Vh5ZzRRR55mAlSbdxOmNin7aj9Us/HNbXrk7qAngWlgmXvfAZ0EOGsqt548iEzZRhOHK9XSQb7VnvJZnJIoTwhqecmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AhW9kIN8x0+SRNyixl33/n41FV6M2YbLCQQLhVcswc=;
 b=qeTNlb3XbJxDqverJZ+z+vyCuHYWGRbrUtD5jQwHJIFRtEHi/BwjloWjD39P3cxtL9qAIEf+XElrsG5G2BmJ///BcHRRWqlQadT6npJNfOb5q6NviWZea5x8PKiI446jMKGu8zG5zTmbdF/fIrOIygdNpUZH+aKQhMi2QV9A0xQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 19:42:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 19:42:07 +0000
Subject: Re: [PATCH v2 2/4] hugetlb: add HPageCma flag and code to free
 non-gigantic pages in CMA
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-3-mike.kravetz@oracle.com>
 <7ab7690d-aa21-0fd9-75f1-f3a23b892853@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <30db728b-36a6-aca4-75e1-c583202d1cb6@oracle.com>
Date:   Wed, 29 Sep 2021 12:42:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <7ab7690d-aa21-0fd9-75f1-f3a23b892853@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:300:d4::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR19CA0001.namprd19.prod.outlook.com (2603:10b6:300:d4::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 19:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c39281e-d23e-4e8c-da89-08d98381388e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5631:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5631BBD026C2FE6BC15B99D4E2A99@SJ0PR10MB5631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2xmKOJHRoQENXWT9xhSfU475Odm6xANtWo+A5153oVgjrtUebZBCweQTq9Uy3xDLoQ3kc5eXSRjnsROlirhrv2q6OiIpA3DIVv4iD8xU3Wfi0uuc+dOTwXL99OJtNFHPl5sBqVy0FyjMSAB/SeaxEmCDg45DyE3i60/IBRIp641ky79on2g048cKZM9K9HkL9OE6MYEL1l56k4yJ+mySu6Ue7XxMMV7L0HvZfI8tt6KbpiZjGnedNG/4dx92Dn9gmdZJr4o2vMGNA1Bsi7ovMtJCcF704tLzlWo2y4L905JdUN/W7Gw1ROdsxJSaVSfZOV/9rh3pGQpFkeKjkKwM8rIYvL6gju9JbVebiATAReIkjetBzEfeFGTBYc40ue6qEJZP0I5hbDnD6r9RzHm66OCX5grzn6ViyxakYN4YIWh83XJHxFQ5UUl/SKq1CGYzqXmsXIcaz+3BbdE5/91QvYUfsQgnd11rndu7IhV3KVsA55GhD6gUST2rfOwkeleEkH/1dOiXu8uXTtmZCalstuRWFNJvVAS9cxOQZPQHvRuEjErl8AE+WYN44mlx3jhHnTkCrlt2y8oosh+KLS2so89X9k+qsFFeIWpjgeWK8sBZRnPnKCkgtMdFzMmfLNjxcfD6BSVPXD1ifje1bsLz9XneEwClaO0lACCh3rUktUyQ2HOiiQOXqqXFHk1aAW4utL+A+CoMr2Puy5+zaZjEf9kkxzHAHrMcPl4Pmpk5+XcV80vSS8Qfb7Fz5GnwovMzDO+V+oUp9/ic7dPCZqF+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(508600001)(5660300002)(54906003)(36756003)(2906002)(31696002)(8676002)(186003)(86362001)(956004)(38350700002)(38100700002)(66946007)(52116002)(66476007)(66556008)(53546011)(2616005)(8936002)(26005)(6486002)(316002)(16576012)(44832011)(31686004)(7416002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWN2cXkxQnYyT1YxZ0lEYkZSdXpFR2hoalc3OU1tWk1wMFBNU3kzQnUwS3VY?=
 =?utf-8?B?Q3lUSy9FMkNleGg3S0xVbHFtNSt0eVNvdWVKUVdGTmJ5cXVzdHhWY2dVYXlh?=
 =?utf-8?B?ZGxvQ0NGQnRIYkJ6QVJ4OHJQTkhsaXFKTnVMbHNRQms0d1ZaRk1qcmNWNWx5?=
 =?utf-8?B?SXM5aUplM05zWHBlc2F1b3psbEY2dXlPMXJLRHV1aU5wbHEvWWFwaHd3VnNY?=
 =?utf-8?B?Ulh3VllCK3plK2lyckJSWXMzVjcxVG1VcE8zaVRwaC92OTZNWXd4TkdUWVZT?=
 =?utf-8?B?RjJ1ZGdQS1YxdXJwU05pMlk1MjFFOUt0dC92MmtKMlZJVUFEdXZYalZKcWlT?=
 =?utf-8?B?ZGFwWnZ2V2JYMS9ncWU1dFR0R1A1OWw4SVlhTWE1N2dzUGRRQ1FYdE1qeCtD?=
 =?utf-8?B?SzZTTGxwelMrTWVodnJlZ1daK3JLSXFQRWFwalFYbmxUOXZmc0Y5NFQ1UFpU?=
 =?utf-8?B?eGpETnVWeFZLUVIrZlhKOWtwdGY1bDJvYUZkeVhxTDNSV1JkcGpiOEphYlJR?=
 =?utf-8?B?N0xMRitpQitFaHh3TVJ3NHVPZk5wb3JKSVFFYzVRRXBBNW94QVk4MnBsMlhC?=
 =?utf-8?B?ckdhVGFPdG1seHBMV1FxVXZLdjZDeGk4NDRxOUlBcG5TUzdNaXVXaE9pZWdj?=
 =?utf-8?B?cnhQWWt2Z1NacGRJUVZETWtnNXZCTmIxb09oMnRoSmU3VmJtd1hubTNHUElO?=
 =?utf-8?B?akZiWGxNOEhJcW1COGI5NmpCNXFTY2FFME5YLzZ5UldVU0UrbkpENmxNUGtp?=
 =?utf-8?B?UjNMVWRnMEF6ZGNBNWlJeXYrSG8wYnhseFgzN3g2STVrWktnMWpqK0hpejhq?=
 =?utf-8?B?LzI5MEJsZjd4NUYxTG5nQVd2VnQyeHJnckRzN24zSHFCMG1iZGFWMzhMcStC?=
 =?utf-8?B?bmZpaDVoN3lnMGNnQzlIdXJBdlhvNDJ2NUpQRzcxOGhWVjBRN2dDcGVKbytk?=
 =?utf-8?B?YVVTMFdBTjg3eE4rM0gxRW40Zm5IYkVLTHBIVnJSSEtHbnVpM0FEUlZPV3hB?=
 =?utf-8?B?T2JQWkFUSE5URmYxZG1NYkQ2UW5tS21kODJLTzBKK09yZzU4d2FuNU13TG1y?=
 =?utf-8?B?Tm4rUVU5eWkxRy9PUDR2N3JibU82R3pPQnhsZ2lsWll5Y3lGbjRGU2RNTXFT?=
 =?utf-8?B?NnVGcllXZ20wakxvYWlkS2hYYjZnSDNvUVI1NUlhUnQxcXNiOUxzRnBpS1M3?=
 =?utf-8?B?U1NPcTBCYTdvWnA0SFFZT25Ka214Z3FaWDZWazJoQ3MrUWJZdHFQR0RmWmNa?=
 =?utf-8?B?RHVOMHJBeU45ZElpTXVJdG1pZEUwaTR0UzJabGJjbTNNYVpoeTFPYm9xZUJu?=
 =?utf-8?B?NG5IWGpnU0FSc0lXaXFFNEV6blEyMVdSKzlMRDIrUkFzVTBmSEFhMjd4aEE2?=
 =?utf-8?B?N2s4SFZVNHd4ZUMzcTRkMGtQM2ZKUDI1SkdJaWx5d3ZyejVGNEV2MTZlZjQx?=
 =?utf-8?B?NEo1WnVrdmd2bCtTbEUyZUMxSjRTc2RZNnVLLzk1THcyTU8zWUZ6THp2M0hw?=
 =?utf-8?B?WU8zdjFWS0Q0ZnBndnpoMnlxSlJRbm5KMG9RYkdOY1NUQVZFOURBSTB6cDRB?=
 =?utf-8?B?OEdMOTVVbGptK0h4dkRnSDhMMFNvSWFoVVJzd2ZHUFRxLzdMdUxFc1pMVlVw?=
 =?utf-8?B?N3NFekxkYnlVc2NoQnJQaExwZTN6OGE3L2x5VC82VXlwbHVSZzF2V1ByNWcz?=
 =?utf-8?B?b3gwWXZjQmlpYU9ZMDhSMEhUczRnVVZVYkpITlNGcDJFTHlpQ3gwLzNsSjVQ?=
 =?utf-8?Q?fU3MQrfmPAdZ4mdHCnMQum02KK5kwljqKaoPoEw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c39281e-d23e-4e8c-da89-08d98381388e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:42:07.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hmrg7f4RRd6ESVy8Oo4OlhCfBCBC2tqFNWUb6EkRODksBLebtG0zXpinhio9l3ZYaV0l3PExR37/LDaQp+3TZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290114
X-Proofpoint-ORIG-GUID: zMEN-w8BDQutOp_cwgnCnaOuqqtMwg3t
X-Proofpoint-GUID: zMEN-w8BDQutOp_cwgnCnaOuqqtMwg3t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 2:36 AM, David Hildenbrand wrote:
> On 23.09.21 19:53, Mike Kravetz wrote:
>> When huge page demotion is fully implemented, gigantic pages can be
>> demoted to a smaller huge page size.  For example, on x86 a 1G page
>> can be demoted to 512 2M pages.  However, gigantic pages can potentially
>> be allocated from CMA.  If a gigantic page which was allocated from CMA
>> is demoted, the corresponding demoted pages needs to be returned to CMA.
>>
>> In order to track hugetlb pages that need to be returned to CMA, add the
>> hugetlb specific flag HPageCma.  Flag is set when a huge page is
>> allocated from CMA and transferred to any demoted pages.  Non-gigantic
>> huge page freeing code checks for the flag and takes appropriate action.
> 
> Do we really need that flag or couldn't we simply always try cma_release() and fallback to out ordinary freeing-path?
> 
> IIRC, cma knows exactly if something was allocated via a CMA are and can be free via it. No need for additional tracking usually.
> 

Yes, I think this is possible.
Initially, I thought the check for whether pages were part of CMA
involved a mutex or some type of locking.  But, it really is
lightweight.  So, should not be in issue calling in every case.

I will most likely add a !CMA_CONFIG stub for cma_release() and remove
some of the #ifdefs in hugetlb.c

Thanks, I will update in next version.
-- 
Mike Kravetz
