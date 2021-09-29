Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011D541CD83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbhI2Uos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:44:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26210 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232957AbhI2Uor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:44:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TKakRR000553;
        Wed, 29 Sep 2021 20:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IuTu2eaHl9ZfD+PaJHEAagVZvoEZ28rphYk+rRtXX8g=;
 b=LHkN9tLMBHJ87AiOF+iI6CAOlmGI5aY25v1cVaQlF5mKbK9tOxNh+qgSN19g/kegMxA2
 tsM4Jo+n6Yx1nKNf77JqlOUxu3/aID0qFI3JOdtlGu0uXbksQyivFts8jw6PdFjc6pS+
 XQVyuSHSv7zsQydcRrayArGvOBfQ9lsqzICAFxhqO2Szt1dj6CIdJTS1fJJ8OV7T7RWq
 SPbAHG9Gt0iuExpX9QqohMsS8+JcNGJ9lYaoRnqb3FMcjMh8OHOAKE5nKhBE54/irNy+
 SXORVxsvVIV6jR1q6FywzaYpSsYIURxmu9clQyN7lKbvuzTcjhDH+eGUHuw/XXPR9cAO 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfkxbx2-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 20:42:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TJUW3q049458;
        Wed, 29 Sep 2021 19:34:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3bc3bkfqd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 19:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4KYXEylAsMsZduG35oYnFXGv77FjCc87DU9TtfCNmAyL0fuLhXB5TMAAB7xsst7PW0yvnUPAfktw+7n73kREt8hUjXhDfKmbCT2U/XwxLiHOtlj564rboNDKD1ZoANBfVQnVmpBQXr5bSbSZToy2jSqOi6fw5r8lZokvT3cjM8/GJgwzDpcs3baAGq25GdXKsf/WnMT3J9HoU8rAOurZC+xarVHX4yMWFD+vIr1h2mIDCp0qpEon80QXCZ7jNqn4IN6vtQ96zVoKL5jDQ0+zLd+dFe3FYAlIsDqSzQXZl7MhKwkTbwm5VWYAgP5tLL7mKsHhWUV8BESEfZs5afk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IuTu2eaHl9ZfD+PaJHEAagVZvoEZ28rphYk+rRtXX8g=;
 b=f2iIqE6irdmk8ygSpb6sHFMQdoqzSGDcUpGQJpVEe6NkWnPjp2ql+jT3Xw5skGt4QWBhl85YGkeAOr2SOcnxYFMwYIssCbBI/B12tyTcr2JVVQvIk1YAcuikgU2bU9NgI11tcuZCG3DaqczxcUEdUfD2ySf5m0JQuDsp4KPZBNY4pQa/hv6HVEoYM5AkY5GKqYIJbiyyO2jkl2ePZ2Dunh6ii5Z86WgYQbnWRPQt80hEdYwyMeZ6WyXkRS7TVppT43C0nZRmSoAGrzzAsVAr71y/I/q/+jomwfQRoxoMinNomdyI8b8IdyBGwtvrkA5Lrcez3VIHdwzjGocFD4TjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuTu2eaHl9ZfD+PaJHEAagVZvoEZ28rphYk+rRtXX8g=;
 b=vyS9j/Yzqcygfr4hdwmBGAxyuRx4pl/XXMxYeFW/CBNkMc2c66G3U7rDDVA2aOxV4U/S/2ZPpc5Tjjo4Lzv3HHzJ77m0PZ2TK1qERtk8tmgHlijBuPsPl+9il+KxAXAQDdHDVsLWEtPnhe7MYFcNMLXREjO7qpzRKWoh3peEpKQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2551.namprd10.prod.outlook.com (2603:10b6:a02:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 19:34:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 19:34:13 +0000
Subject: Re: [PATCH v2 1/4] hugetlb: add demote hugetlb page sysfs interfaces
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
 <20210923175347.10727-2-mike.kravetz@oracle.com>
 <4fcf5b61-8c01-0fa9-7541-afa755a81039@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <573d46b5-6285-0657-a729-3bfb0c2261ab@oracle.com>
Date:   Wed, 29 Sep 2021 12:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <4fcf5b61-8c01-0fa9-7541-afa755a81039@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:300:39::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR18CA0051.namprd18.prod.outlook.com (2603:10b6:300:39::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 19:34:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4f4e97-18d4-4b87-9836-08d983801ddb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2551:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2551DA7E37D935A69EB09DEBE2A99@BYAPR10MB2551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea4kdxoE/lyhuV+XalZAZIRAo2FCEN4Fj9MWF9ibZgykPyilcPMQrMgvbFmxdVk4ZmMF1E7jzu/mpZGBihfnskmVYhFS7xDLjX/a2Iu+OA41z5RZjqpzHAM8kUvhd7qpXWLWFkGNBgyISN6+997BzSXdkwLl1Glky4lFoKDzxi7vdEkJGs7JISz9NUzK9fhfhVwKW8s63udUSR7HzsMF866Pt9N/I13PdZTvX/18MReoc2Cd9Qqi6DeyoCGcuy2Bf9IdOVkpsNPayi6piAGMAaGyXCreq5MDJmOOeTRdzuo6Q/2EPKknOwXYd6nfYhZH+7y8WCiIRh3wkKbNEetzD7We8sf0bhaqj4OSyR0S95albvpnF19Smd/pfpKqz0TdYghZQdEtTRz7qByHbvGBJDyvuUY8uPCQUVvj5qLzx6gQgOQi6dkxLO4xz3+ncpJSoYt1hgFwOHd57/xWiltlG4/Ca3JBEDWXzUEdyP87mcywzQGkzdZZbfRvmD7fEE9lFKfGITOq4dNovL5kTKxcyJPLzqbAILCPtj7bOy56v+znqh3pq2RjcVU1BibwzcqzmU2miZyNvzzcfaPVYvtjX8gfU5CoI7U9fnzzlG23cpJjXr0ceGUVzSYdbKvoLXqms2GNnlaRialP9mEStsZnFtiiKlXYuywg/QqjJvzj4wVnY1uCJaXrjLlWh3RWqzIBdgJI7Pl5UqVgdg68e8xqcFk9bn/JHaSp8q2nIFhAWk+JVdoSZn+b0bCIwfMsF0YFPpkjI7YVzfCtENNZUkdqkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(8676002)(38350700002)(4326008)(38100700002)(86362001)(44832011)(54906003)(36756003)(66556008)(66476007)(6486002)(26005)(508600001)(956004)(2616005)(66946007)(8936002)(83380400001)(52116002)(5660300002)(316002)(31686004)(31696002)(2906002)(7416002)(16576012)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZubE9qaHJJdVMrTDdtRTQ2NGJmckN3KzczQ3h6aVRZNDc4enh6c1QxdU9B?=
 =?utf-8?B?NlFPVDB2Z3dtUDN6UTdSUG1KaHNPeTRkdzZ1VUEvZk1zQSt0SW5JL21RcW5X?=
 =?utf-8?B?cWEwNDREWmtKL3IwRDdqOGZzaUlMTG9MK3Z1K0d4QXBZOStwaDUrdFJKMkR0?=
 =?utf-8?B?YVJoTFdGT3dlNVBnWXI2MWRoQng4S2tGTGxCcVNlcWxMUnIrdnphbGtjTnNj?=
 =?utf-8?B?cWxkdzZvNmJudnJJS2xDQ2VvT1l0NzlwQUJ1bC9vRENuNEx5YnI3Rzk2bHlH?=
 =?utf-8?B?VTlLL3J3K0hkeTI2R1EyQ3hTWXJzZzQ1WXVPV3Fha3llVVc5alZYOE9kQUxx?=
 =?utf-8?B?NXMrWnlCRmZ0aTdNNUR6Mk92RXVPYjAvYWxKK0ZCUzVKS1ZhRVVXeVBsVWw4?=
 =?utf-8?B?TTl5Y2tuWmRVMWpuVHhhTSs0bjNwUXg3aWlrTWsvMVhjL1AxUHhlRU12ZXRp?=
 =?utf-8?B?RVpycFV3dG1KZ2Nsc0lrNTh4eG0zZTZtM0duWkRJVHN4SlE5akpJNVM2S2dp?=
 =?utf-8?B?SUgxVnhiR3BBQ2RwYUNkaW5oQkgwU2ppcDZCT0dUVUZsTC9xLzBSMFJTekY2?=
 =?utf-8?B?S1ROTUMrZjh3bGdMUWg4RGZ5aFlHTDZQWDZYTjR4TDFzN2lDMGF1VVhsb0M3?=
 =?utf-8?B?YkNmM01QNVdVQWVKZGJLVHRzellvOHZiM2t2UlNidDMyc3JMNEFoYlJyVDZG?=
 =?utf-8?B?MkZVMUJuY1Y5dDJRNmlDMk8zdUNDZzZvTlV6N0RPc2tGUkRXY0dicWxubDlX?=
 =?utf-8?B?NnVac3lURERlU3hmUXkyYnFGcEQwakszQlBLWEF3MG9jcUNKZjJPbGJHRnZr?=
 =?utf-8?B?VytmTk1Jak9lTmk2VGZva0FoUTNGS3pHNitZTXdsWWNqWnRnOE9SWFJFa2xo?=
 =?utf-8?B?bWhUcXhiZDhJRC96SWk1M01uZ2VwWkN3bFJFUFM3RlV5UktqVTRFTDdvWk1Y?=
 =?utf-8?B?dHhGWWU0a3A1b3lEaHNKVFRNRXh0SjFiNVdvbVNacy93SEMwQjlDdGFqbUY0?=
 =?utf-8?B?cm9tYUZZOXA2SU9zUnhrK1c2Y0tkN2oxZEs4UjQwWVBwbzFZQjl0T3dxaUlJ?=
 =?utf-8?B?Ukg5aHpwUVNMMGxleWNYcTlPUWEzMVJRQ0haT0R3TDk1RVpZcFBJVm9HTmNR?=
 =?utf-8?B?MmQ5cHRBL2R3cUdHUXI2VGUrNmxud2lNRW5GNlBvL1ZLL09nL3RHZXhXc3RN?=
 =?utf-8?B?c2J0TVFUTi9Ob3pXRTJDVXNvdlAxZVhKOHB2QjlHd3JXeEJ1UndqZGVPeGx5?=
 =?utf-8?B?RTJwd1VqUnQxdllkN1BSTkRPV0tpeDVQTW5qRzJieUxnN21kTitGTjBkN2ZW?=
 =?utf-8?B?NEMybWJoVVM2TSt0Y1BxYk8wc05XNXltWUwwRCtIdUNNT2RFZUkyWGhOZ05W?=
 =?utf-8?B?Zm8zaGI1dGNaV0dta0lNSm1XRStlSTFyRlJqTjJVa3lCajdHQ0NMZkdxQklF?=
 =?utf-8?B?dzFBZkZMbTd5ZHdkME5uVE1melBLTnlBT2c3UFZ2TDZNai9qQ1ZlUUpFNW9m?=
 =?utf-8?B?MW1OanBYeWgyMzdXUlFCOUtXMWpvY21nL1UxVXcrNEdoLzRKekVMeWxheG1M?=
 =?utf-8?B?b3NqTDYrZUNmdXdwODhHVXRCdnlDVVlvWk9sc05odVlBQmJDUFdabkZsRVQv?=
 =?utf-8?B?NllvSGY2akRSM0F5NmRiTHVZTGdVMzNCbHlBZ09sTU9QYmhOSjgxZ3lCN2Yr?=
 =?utf-8?B?eFZVejBjS1dKTmJBaDJSdmxOSy9SSDFCeW5YMU5vT1R4T3ZSRjA1amwwaGk4?=
 =?utf-8?Q?Y7k39sL7Yh2D3VVpLTh+EusWoVx/LvYhU8fiYac?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f4e97-18d4-4b87-9836-08d983801ddb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:34:13.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joTSHDBu1PAk/mFfN4btQpWxOPyRMNrEoU2hSLiV5Inhylcz8+wailxfSG4r7mRRxi7YLzYXVqwMt4AmxtGg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2551
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290113
X-Proofpoint-ORIG-GUID: EgKrhPbrwNANG9_d7nAPJ1LoVKm2cFrH
X-Proofpoint-GUID: EgKrhPbrwNANG9_d7nAPJ1LoVKm2cFrH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 2:28 AM, David Hildenbrand wrote:
> On 23.09.21 19:53, Mike Kravetz wrote:
>> +    spin_lock_irq(&hugetlb_lock);
>> +    if (nid != NUMA_NO_NODE) {
>> +        nr_available = h->free_huge_pages_node[nid];
>> +        init_nodemask_of_node(&nodes_allowed, nid);
>> +        n_mask = &nodes_allowed;
>> +    } else {
>> +        nr_available = h->free_huge_pages;
>> +        n_mask = &node_states[N_MEMORY];
>> +    }
>> +    nr_available -= h->resv_huge_pages;
>> +    if (nr_available <= 0)
>> +        goto out;
>> +    nr_demote = min(nr_available, nr_demote);
>> +
>> +    while (nr_demote) {
>> +        if (!demote_pool_huge_page(h, n_mask))
>> +            break;
>> +
>> +        /*
>> +         * We may have dropped the lock in the routines to
>> +         * demote/free a page.  Recompute nr_demote as counts could
>> +         * have changed and we want to make sure we do not demote
>> +         * a reserved huge page.
>> +         */
>> +        nr_demote--;
>> +        if (nid != NUMA_NO_NODE)
>> +            nr_available = h->free_huge_pages_node[nid];
>> +        else
>> +            nr_available = h->free_huge_pages;
>> +        nr_available -= h->resv_huge_pages;
>> +        if (nr_available <= 0)
>> +            nr_demote = 0;
>> +        else
>> +            nr_demote = min(nr_available, nr_demote);
>> +    }
>>
> 
> Wonder if you could compress that quite a bit:
> 
> 
> ...
> spin_lock_irq(&hugetlb_lock);
> 
> if (nid != NUMA_NO_NODE) {
>     init_nodemask_of_node(&nodes_allowed, nid);
>     n_mask = &nodes_allowed;
> } else {
>     n_mask = &node_states[N_MEMORY];
> }
> 
> while (nr_demote) {
>     /*
>      * Update after each iteration because we might have temporarily
>      * dropped the lock and our counters changes.
>      */
>     if (nid != NUMA_NO_NODE)
>         nr_available = h->free_huge_pages_node[nid];
>     else
>         nr_available = h->free_huge_pages;
>     nr_available -= h->resv_huge_pages;
>     if (nr_available <= 0)
>         break;
>     if (!demote_pool_huge_page(h, n_mask))
>         break;
>     nr_demote--;
> };
> spin_unlock_irq(&hugetlb_lock);
> 
> Not sure if that "nr_demote = min(nr_available, nr_demote);" logic is really required. Once nr_available hits <= 0 we'll just stop denoting.
> 

No, it is not needed.  You suggested code looks much nicer.  I will
incorporate into the next version.

Thanks!
-- 
Mike Kravetz
