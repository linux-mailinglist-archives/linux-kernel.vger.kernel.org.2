Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA044349773
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCYQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:58:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCYQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:58:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PGu6Z4074878;
        Thu, 25 Mar 2021 16:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=b5NigpWTCkQkO1w8IqqQC91syuL+93uNH9nankE80Bo=;
 b=xzrSlf9+v7rD3aWh2lHpOSR8182VS+XI7mxCRsS+1a3toMZjY51lWwy5mkfGY7iwrMnW
 lRamrUiDwL0955rcEhScmSekAXTUjyKmeX1XxAGA0YXHcwgOqLDIJmRKSqk4mOiizBAD
 s3sJCwppju5o/8f6NvOK33C9y2c5hoKlhzbefY1zgUK8SRVXuMy6rjLD2EZVpCkeYOUX
 nqmI1YPRTwEEYGfC71wCNuPwbDmSZNWJbpBwjFOMeXbYQaPHL5Ja3t3kAmKloJaloLjQ
 swt11JYwjQiprQAx4O1Huj1qM3+E8Y+h2aOpPBCmuZscJIIRjAF5n1GfGxQ+pFCRYe/L RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8frf203-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 16:56:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PGt2eW195696;
        Thu, 25 Mar 2021 16:56:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 37du01e2he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 16:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDIx2dcz503t2fIl6vmejmqJXQ6TK/CGrOgyoVHqV1lYHJtfIqjVXo1qm0x3+rO3MRtTjPVyU08VfU7TZOy9NNJNt8T2puSq97gFuiz6xzCPwykH0kqNO/lvGM7YpneyZ1AImjuphn6D4RwJSp2MsvpCsZhKLHnlxpd+9MengYPfeQUekaXfwuUTRP5nOeH8LdgMq0O/eHY2VgT0UaAIdETZ9ivr707VubXlA875MnXbQCoe75+Yg93daENzaxYwvTb9u2idzWoP3kd5fHW0s0KKhSD9sbYGjfBVpq7U4CvSw7HqsM7jsVV3ixSrdPWpvcyuQzW+XvddZ1HG4253YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5NigpWTCkQkO1w8IqqQC91syuL+93uNH9nankE80Bo=;
 b=Cuibf2mSdL9HDZlxh3DdP3pnTL9kqnx6PWe/HeDDA2aqvWGZFpkZXUqrPGaLvWZ7Ai4XXrW0GTSsgr6J6YBz7oz1bBiSX8lYqUlrmXO/XLWAVi1dYRU0dnxh5x/RhD4bOyp/ewWR2NNBI02i9zR/k03gff/j2DT8eV55lP6LKQqFGbZHhXHlMMKD2R/4Q9gfRmuTXTg6f//tcHg6RpVwEwYkSr8JjFReIZrEKGW146Aj+v3gSKc5vHOwrr/DMRuECbo/pd9QyahAt334FQMoV1Z5DiCHAUhfbufPAechSf5bOIBTizkZpQWWODAAnYsituatxLoWmD1RvhIvB+HAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5NigpWTCkQkO1w8IqqQC91syuL+93uNH9nankE80Bo=;
 b=eHlQvKpzeKzOJqVxlG3KAAp1N39BqmegKyKQexStBZeUovBrwdwTmqJgXlKsfCddfKT/sYg+if+wr+yFn7+zcPcYg8XrypwKBnRsgKsmFLBGNzzphb1SgTlQFebPzPesJypkpZ+7F+19H/d241AZNSPoM0J78z+N41gG457gpLU=
Authentication-Results: lge.com; dkim=none (message not signed)
 header.d=none;lge.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 16:56:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 16:56:38 +0000
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
Date:   Thu, 25 Mar 2021 09:56:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0051.namprd22.prod.outlook.com
 (2603:10b6:300:12a::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0051.namprd22.prod.outlook.com (2603:10b6:300:12a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 16:56:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94c1978-2921-4065-2424-08d8efaef4d9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4736:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4736C6B0529DE45E36C42405E2629@SJ0PR10MB4736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHpHzgsSYGEkT/Un0KrCT7xVq06os2R2LW1cvjfHWeoKC4Jz5/QcF8tdAJ7i9Lhj25yEkQsyuersSm+v+RZm6LWH/ZKwusETarrlrRHDmsH8RMLrQpOqL+DDvsPN1rdxvOUPEbq8GLTnr2ayaXEgf9TvSutLRjwkrpgz3w/m9K3Gx7LGPkUhl1tnuoTupR8x0dfELu+oTWZfXoC9AHvs9OkIz+I/oidSpZbuqZCIvS6GJLPCVIY2ueIbShSzzahmmiXEEegzk/xKv9tOODEOao+dIK1u/86ONyb7oyqLT5bL/0jS7UqO/IevnyQ1cAvnABC607+bgZqFql6gb1aAIe9wnP0/fPVTjz2msh0ZSJTAaI82TgrGt4SIT5/AtL2g5BBvMDGOHr7KsmTkRXm7jRyUK9aZDgvwVH0KBKo5f6I91s1jxx9BkwXNGZAeGaTA96P2IuzmrTZQRFn2IdK9tZssByVysndL3ch/scdHUga4Pp/FVBrIeyZAb3ZMIwzYWzxzBRWEcIlVaCdxLBI0fHMiqxenwtS3SR7UYx2IVQAd78yZiZkxjJWeHuAGK6uesXOBNIsfuDKC3jkDg8mOnPsuw2JCkXHe8LbhJ0UQiS4HbMp2fJdybrEnB4o4YbPZYyrdQJGV6fE8CSdAOYPIkTdHxGE9Cge/q0M7T3odk9rZfRoMNMBxcZTDMBuUSvSaBabdk4ZCLoaEMUYpsjOxDEBR/K7ShH9JIvNiaaPdVMUeECFBvTMWr8hx+2tR/P3yPAeBaTV/HdHydUzW847HQD3uFha9Z60v0bNm1E7348M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(346002)(136003)(54906003)(66476007)(31696002)(5660300002)(66556008)(66946007)(52116002)(2906002)(16576012)(316002)(110136005)(4326008)(86362001)(38100700001)(36756003)(7416002)(83380400001)(956004)(8676002)(8936002)(53546011)(6486002)(966005)(26005)(16526019)(44832011)(2616005)(478600001)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RTJsYUZTc0NPclRZUy8rSDIzSDRtdXEzUHFJSmlyYTRRcE1FZFV5T0lmVXgw?=
 =?utf-8?B?RDUzT2ZwckVMUlhVS25Fd0lyL0pteFpMUWlZZkdUcThiOWtTL2t0bW9NL2xh?=
 =?utf-8?B?T0FiR2lBUTZMSzZJME5KTWFGYWtkSGZiSHpoeHRMQVdaS2RGbk9hNy9tNXJY?=
 =?utf-8?B?MXlaNnVCVFcwQ254cnp3d3BacjRQZmprYlVCdytDUFE3OU9zSE5PQTVtNGI3?=
 =?utf-8?B?ZFl1THhKSWVrR2RTWGU0L0doUFM1ejlzMUJBd2sza1l5NDJoT21OZXFtemxN?=
 =?utf-8?B?VTVMYm41ZlJWbTZ2QjJoWHBlaThvSjNBYWpISS9CeEhZck5aOGFzQ0NsWWpH?=
 =?utf-8?B?ZnhhbjgrcFl6WjdEajdGbmJRODlLUjRTRXF2azVpQ1BMeWxtMUc0NTdCLzN2?=
 =?utf-8?B?ZFdicGV3c1J0Z2hLNk9zMUJBMW14b0RqRjJpVVk4Q2paSzl5R3Y1bUdKREFo?=
 =?utf-8?B?THk2QkJQMUZzN2N4VjhxWnVtMXIzK1p5YVJod0tDSk9lTXVkTFJ1VzFWQ1Jt?=
 =?utf-8?B?ajRwRVZJMldEaU9aQkg3NVUxZUJ5a2VvdzEyRjhYTWJ5bVhGZWdwOGVabk9t?=
 =?utf-8?B?OThMY2lzdGRHa255ZC9yN003c2VRSWp5QVlLdEtPdG1tVHpMREVmcEtqQk9O?=
 =?utf-8?B?a21obFZSTjJHMkJRWUgvMHU1RGk2UUZ3MlczL0gvSnBQSWxYY0x4cmFoaVdB?=
 =?utf-8?B?d0VZcVJNcCs2WHpkMTdXNXBsbEZRRnFoWndWZmhBd2xzQlRqN2NRK01IVkdt?=
 =?utf-8?B?alFWQWsycVNLYnBtUlRCSG9OV3pjMGx3eXM4NDJLcG0rMHVQK1lCTTh1ZVpY?=
 =?utf-8?B?WHFiYW5qaFA2eUoxOVZSV0JKeTZUVDR2NGZPS1B6akVHcHp1TjR6YVh0cCta?=
 =?utf-8?B?YTJ4QUJrZk9zVzRUYldKNDB5WmZ0UFlnbllwMXpaeFkrK2lZbmdjRzlnY2ds?=
 =?utf-8?B?SnVvT3BnVyt3aUdmeW0yUEN5all5U2NjM0gxM0c4WC9mSHZsQ3dGblhlTFNp?=
 =?utf-8?B?R3UvaFpSZG9Na0RPRmlETXdoMmR6Uk5OWkEwN0FhZ2NpdHc0bHd1L3BqdzJD?=
 =?utf-8?B?eGJqNzRmRHZDNnFaTWtHTC9ZTUlXZHZncnNoRlhLR3dEQU13ekwvQkxra1pk?=
 =?utf-8?B?QUp4OTBnV2UycmNOTlFSc1RIdnZjK0ZwK1htbm9KR21LdTNwTnB6d1BOOUtW?=
 =?utf-8?B?bVR2aHdjUHdwbExaRTMyTUtxZVU1OTdxZUp4ZTVOSDlqbDd5QU1FaGp4S2c2?=
 =?utf-8?B?MHNMQlI2TEFlQnU3U29TVnY1dUdXZlNKSFRTY0xrRWEzM05lNXZ6YTFrQ1dY?=
 =?utf-8?B?aXdSSGppcTh4SThFS2lXMHA0cmkzSS82N0J0YjJJYmU3TVNpKzhhakEvRXVU?=
 =?utf-8?B?dE5SV2ZlUEdjZUdBTnJqWUNyUVEwa3psS3FLZU44N0FYNWhueTdxYzFkQVg1?=
 =?utf-8?B?d1k3dHF4RXhNNDJMcFljMlJuZUEra1hmRWszMGJwZWoxTGhUMjVMUFB3OHpz?=
 =?utf-8?B?ME9ZQXM2UHc0c3kwdzlWZEhVMGtaQnA0NVpWYlZzNzd3VEQ2Vm5uSEpodjhV?=
 =?utf-8?B?WlpLZXZndGEzdW9uNVZ4REdhNFI5WDQ5Tk9NR1FPL2tXV1pUQ1l0eHNzYWFp?=
 =?utf-8?B?Tm5SSHBsVnVNN3ZwUWFCQjV5UUNtaGtibkFrQzM4N3Zpa2ZpQkNkc3ZxWVJV?=
 =?utf-8?B?b3FsNUpxTXozemptdTZrT3FXSTBsZUJncXRSNzhNTkJrNGp5MkE0enBYdWRk?=
 =?utf-8?Q?wvG+sIsG3v9Pk/iHxRp6iPexhumh/SPu8wWGIlO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94c1978-2921-4065-2424-08d8efaef4d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:56:38.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq0I36amZxmT2RRMsJXkgRHNfQaJQCFw7/UCWznhpyE8HCNGV2wJXyUgnOFSuEcT91cpgAZHLR20udmsS6X69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 3:22 AM, Michal Hocko wrote:
> On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
>> On 25.03.21 01:28, Mike Kravetz wrote:
>>> From: Roman Gushchin <guro@fb.com>
>>>
>>> cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
>>> It makes it a blocking function, which complicates its usage from
>>> non-blocking contexts. For instance, hugetlbfs code is temporarily
>>> dropping the hugetlb_lock spinlock to call cma_release().
>>>
>>> This patch introduces a non-blocking cma_release_nowait(), which
>>> postpones the cma bitmap clearance. It's done later from a work
>>> context. The first page in the cma allocation is used to store
>>> the work struct. Because CMA allocations and de-allocations are
>>> usually not that frequent, a single global workqueue is used.
>>>
>>> To make sure that subsequent cma_alloc() call will pass, cma_alloc()
>>> flushes the cma_release_wq workqueue. To avoid a performance
>>> regression in the case when only cma_release() is used, gate it
>>> by a per-cma area flag, which is set by the first call
>>> of cma_release_nowait().
>>>
>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>> [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>
>>
>> 1. Is there a real reason this is a mutex and not a spin lock? It seems to
>> only protect the bitmap. Are bitmaps that huge that we spend a significant
>> amount of time in there?
> 
> Good question. Looking at the code it doesn't seem that there is any
> blockable operation or any heavy lifting done under the lock.
> 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
> the lock and there was a simple bitmat protection back then. I suspect
> the patch just followed the cma_mutex lead and used the same type of the
> lock. cma_mutex used to protect alloc_contig_range which is sleepable.
> 
> This all suggests that there is no real reason to use a sleepable lock
> at all and we do not need all this heavy lifting.
> 

When Roman first proposed these patches, I brought up the same issue:

https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/

Previously, Roman proposed replacing the mutex with a spinlock but
Joonsoo was opposed.

Adding Joonsoo on Cc:
-- 
Mike Kravetz
