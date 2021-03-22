Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA07344DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCVRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:43:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCVRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:43:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHYKsZ148475;
        Mon, 22 Mar 2021 17:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=w13it2EfPeedqTe5QN2+hoq6dCXL+IlA9IVxGehnfw4=;
 b=yVJ/AfsVshQc+8zh5MdjobdZKf9nvbubIO/1pcmk0INsEm7dNVrl9aheikxnuOPI+r5V
 hCADDFi3/SHthb9DlZHJCQ4cJt1yUiNBtQ9tNoNKNW0SoGwOBO79/aURySYumLUHvKH6
 YmoUr9hAlkJIoGZPIJgnG5xn5maJFUWQ6Lob4VrJLqzyhj3BI9SDFWuhB2g1OXf0Hyuw
 8Vi8+5n48UcLkL6CIrwA6fhRDMhsNB38x1KbonPUVkCvE1p++DhOvW1Hj9pZkOtbXnFz
 0bA01B6IiqyADe/FEINaO6G3HDWLgSjODbLJdxLkMhCTiJC4K0tJliOm1J+3FRWA2ko9 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37d6jbce4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:42:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHa5rh060428;
        Mon, 22 Mar 2021 17:42:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 37dttqvhat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGAMbziXxNprj333l/Witr19W7t4x3g+mgxouyqEVt4nC0lGpG08Mu++5+jvHQB+AL0Y6E/YWaLwlR3VWWlhKAWgVORX1tkpLB3/WxuEztB1iTBwh8rMzfXPo8b5MjqgLEkcC820jke3QFVWe9ARstwKpxzDzrbgH+A4fyBsZ0ixX2lbaVCWdtGiqlHd7IqXY7WlNAl/w/oC5HP8RVrkj4gRF42AbPQel6SqFl7dgkWhVcXWc8bSp1uXtVE/rV7qSjfjbOKiV583T1qm9QGZQkPJeTRHIrp7d/0T0XxYjv24/Q2GojZf6Ll54fj+tYVb/+hxGrRI5UKRhX+QO+acew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w13it2EfPeedqTe5QN2+hoq6dCXL+IlA9IVxGehnfw4=;
 b=UBpztW44VSiKPQJycCzG1+pj7cxVoNploSYqKMhtBxjC2mcygTyZk++Vqs0v3wiQQCAR7vl18Qyy9QYyWcWvNYHjGTH0sMeK+HEoT4bIZE2QRTr6PRsuLPZI2cospYwwb8KZOmcSGwqDPY6yluz9h00K4RhESe36t4O3m8H4XJYQ+rxZwbFFoQPYiH3pJbo6rytQe9FWwO4GziP76yRvImSJj8Df9JdYrMkj/BiFVQ9rDX+aKlOW6k2PXF8OePQwFI20w4e5rXWgFckL6wID0oD1hGPCb3QTz7hwCM3Vr4ESX/FWxdLbzcROChKLdHt4pYmwsuvZe8by1Bo4Yy2gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w13it2EfPeedqTe5QN2+hoq6dCXL+IlA9IVxGehnfw4=;
 b=vGbRjmWmQCrC8R9D1mNWKeyfB546pId6Sm8gWTyyK7ry/n9Jq2NGPz7k+ZDA8WQO5eLyD8L+xz5aQixG/AtP4r9J1JDOiKbeJx2LHT/9CwYYOE31XIYGaLQHuww+ItFZ+/UGNFevDyJuLDKFQPkeWNFPfC2thzYBFNnz8mOuRXY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3352.namprd10.prod.outlook.com (2603:10b6:a03:159::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 17:42:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:42:26 +0000
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
Date:   Mon, 22 Mar 2021 10:42:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 17:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13686aa6-258c-458b-d32e-08d8ed59db5f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR10MB335216E940365E182517CE6AE2659@BYAPR10MB3352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbQnQEpEkTw6Oh8yyAOoTs48c+9YIAZZJvP585FyDDcXlqlh2p2KWqfqG2aCgT7V7dr8YbiqhdwbsyBL3NXtmbxih9WwCkuErHilQbQEAumBpMGA6S74fhmy041Uj6MtX/TVK8IgQ9MwedIWTh4ki2lwMsmL2fBVG2+HeHUe2Sq6t60+YeV26doSD4f1mptNC72hPyewNwiqEqNxulE3Wx4n5JACHkJgBQccmvgTXEulG0h0wY/OAWfBhaMj+eZFjCPHr1RLDFjcekO1HKK6hDxuCFbsBuScafvCL0Q4jxillUL1YDmggLCYEUhg91Vy88tY5b6dbHKn16yjIw2WQJz324xTZskkt4f8RzQTseVann1QpYNDfuf2/Ih/HuQ6bjUZP51lCvu56OCJidYWhT+g0hMT63bgtHEn+DcCpKMxsejv1ug94ZO0niMXGKHUWKSfr0kskf2+fJ1cOIWK7zPsliAD/K8Y1PItLmjH/26KczZd4HeTiaWIiCZt8LUKyvgtm/oCaBW1JeWPF/Sh7IM5so0v8NPeOY/DscV5+dIrTrEYjYLjIWZA9c4bEW1WUIQyP0P0aagY6mmhA2qCTSxEmmJLqmzUHuiGt2B52zd4MzaXe8UOWUcLJlezBZbNZm88PVxKVr5R/rrw7WHIhoiIiRQyHnABCTUb9CGZtToNWCys3wTBpCVaxIVpyseqgVzLOwSPU+74BEO6KsiAcOvOjoXyBlgOyxu+G4Q+/3VPwqFLrijO68rGBn0kDdO07xCnVFuM1ZHDPaisIKbmmjhwwj6n+SfSvzvQiC2P0lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(346002)(366004)(8676002)(966005)(2906002)(8936002)(53546011)(186003)(36756003)(16526019)(52116002)(5660300002)(66946007)(4326008)(66476007)(66556008)(16576012)(26005)(316002)(31686004)(6916009)(38100700001)(2616005)(15650500001)(44832011)(31696002)(83380400001)(7416002)(478600001)(6486002)(86362001)(956004)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SzlxcjYrSCs2cHR5YkhpRDc4R1h0SWZnSUdMT21oYWZhWWhaSkNmMWIwdFpF?=
 =?utf-8?B?U2RzaVdlTDFWZ1NrUzFIK1UxcmUrSnNubEdaNzZJa1FtM2NURGt4Z1ZYc2xx?=
 =?utf-8?B?cjlDN2poU1lZVnhxbjRNMTJrVXUvazFvdHh3aFJWRzlaL2VrL1BsbnZGcFo2?=
 =?utf-8?B?Smpsa1o4QWxoZEszdm5LbTZIaGZFd2NEVjdyeUdpRXFSRnFYckhRaWtxam9i?=
 =?utf-8?B?VXpjbUF6clRkd2NCbjNsMUVhQitqdUJ2MG50MEp6RzR5VHZjN1FuQm9CVGdT?=
 =?utf-8?B?RzgxcVpjUEVNaXJJdzV5eGxsT0NwZXN1dGtYLy91SWdqMm13Q2N6L0ppaFVm?=
 =?utf-8?B?Mm5mZ0lqZmN0N0JCMHhGeUZxRllDejBNcU5oQ0k1SWFuUWtyNmtHZ3BNMjlx?=
 =?utf-8?B?Z0w1aTFSNXFHMXduMWRJWWE1bWszaUNTNmFnTW1jbENVVHVjNW01MG5FTFZY?=
 =?utf-8?B?SXJESFFJWEtUa2NTQ1ozMTV6eDhUbWNWUmNPb21zcTlNYlNsQWhhUzVEMFVV?=
 =?utf-8?B?bFhkQ0J0bUoxM2RZRVk4alhpK2Roa0ZOdUFBalo0OHczeVZpaWdUTEVGQ09Y?=
 =?utf-8?B?VUdyV3psdWdOdjVBTTJTQnU2S0I3aVhXUVJzQkZsbE9CcDZVMmZ4Sm1mMGUw?=
 =?utf-8?B?a1J2WW1XdVhPdWtOSk9HZWFGUjQ2cEhVMzZlV0JUaFpFYmFrL2NOQWw5UlQ4?=
 =?utf-8?B?dG0yR0wrMUFMWms3MUpna3FiTFhOVVJ5SmhtR1EvUVBuZjB3VERhKzc5QTVL?=
 =?utf-8?B?V3Q1aGswSlJ2WEdubDlLM0VvMEkrdnBHMWhyMkxvbGlETHVsRWRweFpmQ08v?=
 =?utf-8?B?Y2x3S2JYUGcwMjFxeENPZW1tUmpBQ0l2MWNHTFVZMEtFMm1VTTZQWDRpd3pP?=
 =?utf-8?B?VmJNajhJUjBKRm9XeHhjcXdCdUZMdXdCSnU5V1VpekxiWjZFZ1d5VGdLRzgv?=
 =?utf-8?B?T0VpdFZldUhqdGgyc0hVNmQycUlWbUFiVGlBcEFPVkhtWVpqYkp5RGVXMlNT?=
 =?utf-8?B?SDkyOGNzZVVCQW1OdTk1YUhLbDJSTkpUOXo2UlhlWkZGbnFpLzRpcXJNNFVF?=
 =?utf-8?B?c21sKy9Mc1ZsNmNJSkFRb01DYlpLV1ZVblVNYURTZzIyUlY5YlMwUmlaSHlo?=
 =?utf-8?B?UmNvTjBoaVdLd1hJdG1VdnRRa05ndGY5MExtVStla2UvUnBjcmRlc3NBWkRn?=
 =?utf-8?B?QmpTMEswRDNieGd0bzVSZ05HelR3MmxmUjRIQzFqVExHUDBkdjJGU2pKY1FF?=
 =?utf-8?B?Ujh2aTIrbnRxL1dUL2l2RlZlT09RODQ0S1pCMVJKV3JSVDFibXJYci8rVXR4?=
 =?utf-8?B?Y0dNZWlMR1k0c1BrQWd1ZG54N0xUYXFjUlJBVzZGeGE4RTFMbFJJZkJ5Nncr?=
 =?utf-8?B?dVJMTHZaY2lZd2FFZEdDMllZbXFIVjdINVE1OWRkTzZJQVBkNlZWYmtPZVI1?=
 =?utf-8?B?MHBScys5SWNLdzY0VGVYQi9VZVpKY1ZDWUQyYVRSR1FaNmhBS25iOWkxN3po?=
 =?utf-8?B?SmdQbkl6N3dVTExVeGR0ekpMUDdBZ0dzb1ArRmJ0RHpxNlMxSUtmdUtIUVhG?=
 =?utf-8?B?SDdnV0VWSlpmOGpGeTNUN2lpUk5hQXB6cUhTUTlaOTVJMDJDZ3ZjZFdQdS9r?=
 =?utf-8?B?ZTVYK002Y1lNcUc5QldOWkNIbU1NRWNxOVFzZ283OG1xNzNWQTYrby9Pcmkz?=
 =?utf-8?B?Vmg2a0pCNGUvcUoxRE1aWFlEOVJvOVh0dU0wSjVRTUNsTStaOEpQNTJiMTNr?=
 =?utf-8?Q?BAwcPOb2mVNnyzAsO3pYET4VGZnetXezMpUw1uT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13686aa6-258c-458b-d32e-08d8ed59db5f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:42:26.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhWfqSW9zQCKIEUAdnUNqE+nJWgQH38uozfW5xK7KVUZiL+LIVnVFmv0RtVq2YnNRzU/JU16iHXYyOFRMnZxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3352
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Roman, Christoph

On 3/22/21 1:41 AM, Peter Zijlstra wrote:
> On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
>> The locks acquired in free_huge_page are irq safe.  However, in certain
>> circumstances the routine update_and_free_page could sleep.  Since
>> free_huge_page can be called from any context, it can not sleep.
>>
>> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
>> new routine update_and_free_page_no_sleep provides this functionality
>> and is only called from free_huge_page.
>>
>> Note that any 'pages' sent to the workqueue for deferred freeing have
>> already been removed from the hugetlb subsystem.  What is actually
>> deferred is returning those base pages to the low level allocator.
> 
> So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
> should be in cma_release().

My thinking (which could be totally wrong) is that cma_release makes no
claims about calling context.  From the code, it is pretty clear that it
can only be called from task context with no locks held.  Although,
there could be code incorrectly calling it today hugetlb does.  Since
hugetlb is the only code with this new requirement, it should do the
work.

Wait!!!  That made me remember something.
Roman had code to create a non-blocking version of cma_release().
https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/

There were no objections, and Christoph even thought there may be
problems with callers of dma_free_contiguous.

Perhaps, we should just move forward with Roman's patches to create
cma_release_nowait() and avoid this workqueue stuff?
-- 
Mike Kravetz
