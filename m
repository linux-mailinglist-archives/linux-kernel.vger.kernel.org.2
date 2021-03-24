Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E9347DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhCXQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:44:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40704 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbhCXQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:44:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGf0ii137958;
        Wed, 24 Mar 2021 16:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uHabbloj8Na+6/YaHgHRSziqZN6xkhYxqmPjoNaD1/w=;
 b=NCeJi+D1bQjQWytH5UV1T73WVwgDXDBNgZlazyN+OiHlTi1hVHJdr4+SdgDjLhV541jF
 TFeNRvLGHIXy3F747CYPn3jpsboz4nwEoEwb1Jl1uFmceHBVmYarFHFNB51vA8ZNf0FL
 xD2NfN1QACKScqz79di7ngT09cap3ZIIJzg9g+sWEgl5LhviLvxCjGsKIimCM7hX8/R4
 fXp5OAEWSDj0RnraZvNKZ2Qr7BPl+dPLKQxVn+6ukVgeMGByJuh0Q+f5vBCwh+bud01V
 msMlDK3WfTjSMthgOjAnZ4Nbp+4ncr3v7WFZIHTIprDLbDwhAigpVbRkRT7QGlCYANwB 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbkjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:43:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OGeSGj125637;
        Wed, 24 Mar 2021 16:43:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 37dty0tdy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 16:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEHUCWVUA+N//oqUfp/5/IkiQDC+2mqBsXM2yhaCfWer1R3VdFWxXXcCpJTGS+/1v2B9PGnmIUiww7xg89RMbOVkrT6TTCQG7lhqR6GnA0SBA1dEyAyWTuAly3zX2Hkueogp2qNi8cgl17gsWH8S9QRjTiWTqZJwh4CZG5++SNPYIsdr74VDwt7B1UkTjKJrH7x8vKlC1xMW+9QVhw0JWyeBKIZqsH1omfCPWGt39ocHLvqQznQjt6P/wwox79148/Re07i4wW12an4bqDCTteXxDxZCjUrFL2tZvgV0a8xdo+4lR2e46ShnT3I0pwlaVHiPfeIOhT8SndBZaOgQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHabbloj8Na+6/YaHgHRSziqZN6xkhYxqmPjoNaD1/w=;
 b=g/FXG9vC+lgGAyIeXySFF+j/IAzigT7Jvk2o2GKonBubUZyTVu+QVy0qf+vBBg96271LN76WLNN6Em3GMCR3GcS5B2921ZRRgRm44DGkNLnYgSYuFSV+crBNA1WO00aNsr7cUZkcbHB2MDcK3yXmDnmnsjX/H48sWDuqN8H4OAwAQVbFGn3Bif+SQuMiZ/9ht7+w4/JnRMpOd5Pvb0NG5Hlax1ePTu6JVj/n5sh1MW2dTX4qhqe2zbwiD1eowmIr8H6C6AlyoCWtzcAoH2TdpsH/ZMAW2xqfpu+lXJYowCgqwSjl9UCHjVUwcME92ajTMC0yH6GZgS5pEQNsykm0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHabbloj8Na+6/YaHgHRSziqZN6xkhYxqmPjoNaD1/w=;
 b=feu5l0CkP+RocaqnDBZCNTaH9b38mb8G3oqbhvlPKw/i6ErnaQ1+KWhPT4B4VmEwpsfDw7gFXuNajhCnvjPYW4PnRIl42DEWupRHGExTNL8XDPp1zCCR5VKXN9AeurroGAMIf7csESBKvEIJJDaUY4c+Lx9ObALTbIcYTSZ3kKM=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 16:43:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:43:53 +0000
Subject: Re: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping
 hugetlb_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-3-mike.kravetz@oracle.com>
 <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
 <a7d90d58-fa6a-7fa1-77c9-a08515746018@oracle.com>
 <YFmd3d5B2VT4GkiG@dhcp22.suse.cz>
 <YFmgPkTzZY6Ocj6X@hirez.programming.kicks-ass.net>
 <YFmjVNnnHHpyxqKe@dhcp22.suse.cz>
 <52db15d1-4ed1-6c3c-b638-6efdccf6e62e@oracle.com>
 <YFr6A927XhhiciFj@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7f1f3c92-725f-0cc9-3dc8-420c4e9c96ec@oracle.com>
Date:   Wed, 24 Mar 2021 09:43:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFr6A927XhhiciFj@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR2001CA0001.namprd20.prod.outlook.com
 (2603:10b6:301:15::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR2001CA0001.namprd20.prod.outlook.com (2603:10b6:301:15::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 24 Mar 2021 16:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1e292f5-3fbb-4952-e556-08d8eee4025f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43564761FD9A7AAF2BE8A530E2639@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1HU5065v0QldMaPA94oo205pa1vOXb7/GUp2QRkugnoHqHIdLhEfEDfZHniP20abn0n5kukGNIH+TL6Ysyirap+x4MjxRMehKuPCXeytw/chnz7UdfE3QNreyI6RIg6xh647rDl9epdORzuBZMgZS0+23rxU1L2zoANtXY3CAZojzUfVWVsVnVVKm/LSYGO4y9ygmvZz0NQ7Nv8XGAdwfUmN0TLVijNQPgpVKQYUp2+0FD7pM4ytN/yYLuGt8OLeHErohnhHj1tnHRc3QaFlbyWVgjUu7MTzYqyab5p4HgrI02C2y7PWkycwtl4PRz9pJJLelmHqRVqqfWjqL4G+JmX/mjT7YU7dn3xFMZaCJH4t60FC42HPhkBGKNobuyhx6cMfkwZ51hxBmhphNmFyK0OiDhJYfUg9iAh/FHN3oUyQRdUnTYlm5QJ39IUdsevhPdjOd/UO0+/V1KLyDsTPi5lyum1NEdjFahWXSurciWmmi1adzpozvCvZMywA96jiykxv+PGTmAvQ1CwnddzpwYWrzWC47qv61Lh/BSGzjjfrEomA8SElhQhclgc7WTJ8bGbsaPy4+vpsc/lk/7HtUK9VCPcNO6EBcjropue4/ACgHtOwiNrok4Mxb4hFYmw/PmoUcfI9dHaCyc7SXJm/NsrQHGCMs7GBd0w2FxQf8xBOpQ6c0snSOXLVn0s/jMqRdf+is4jorqj43Au7sv9Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(4744005)(956004)(5660300002)(83380400001)(2906002)(6486002)(16526019)(53546011)(8676002)(52116002)(31686004)(2616005)(7416002)(8936002)(478600001)(66476007)(66946007)(36756003)(66556008)(31696002)(16576012)(86362001)(54906003)(6916009)(38100700001)(26005)(4326008)(186003)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mm1oUCtlVUpoa2J1dmtkc3NVc2pxWDdQcE9zOTlCcnpXam9Cbjk1cGg4eEo2?=
 =?utf-8?B?Nm1Qay9mdVRWelUzS3NKcklzQjFqRzVzaWRSTmVVTlhQaCsxZnJiT0Z5ZXN0?=
 =?utf-8?B?U0RVUGttOFhpdGE3T0JKMmlnK1pVandmNS9ocEpjSThCUXE5Tjg5TW8vUWow?=
 =?utf-8?B?OExLbVM2QVc2d3NCSXgrSllqN0EzL2IrYTV0N1pST21nanpHT0hwNXdvSTdn?=
 =?utf-8?B?QWRCa2t3enh3dVcxQng2L1dPNWs4cVdCRkY5RXZmNnRtOW9teXNrY2hKWkVq?=
 =?utf-8?B?YUQvSHpyRW5zZm5GdVRwT2RIbmpVenE2R2JhUTBnMWZXZWlDS0N0VU5oYjNR?=
 =?utf-8?B?TGJ3akZiNDQrZkd5cGVrMDdPeURvUjJlOFVrcFhKOVVDVVZkeUo0bENyM0lC?=
 =?utf-8?B?T3gwaDFPbyt2Z0xqL085MndQWVcvcmN1OWp6V0JWZUFFd1QwY2VQaUlLUEtG?=
 =?utf-8?B?cktzK1FIUWt6anVjNFFvb0lIMXoxNTdReWhOWFhXaXFqUzhaNThKWXo3Uiti?=
 =?utf-8?B?YWx4K1ZHZUYwWnFLcVVrYmRmOTlnVXFyaDVBZmd4eGVwSG5Jdjk4RWlRZUg4?=
 =?utf-8?B?RGhsQXdaK0dER1BLdEtvejR0N2FwN2pkek9CNGhITWRFVmRkSzllWllJU1A5?=
 =?utf-8?B?ek1NN3IxSG9peVV6dVphMkp0dG02OTFPUnBtTXl0Qk8wMEVHZjd2MzRqVjBV?=
 =?utf-8?B?bWl6RE9BNDQ1bjhpN295THdUUFVRRVltaVkzVjRnZDFYc1ZMZWVSOWhsb29q?=
 =?utf-8?B?S1ZBVjNKdGRWTzVqU21idUhvb1B5aVIrOTMrU2crQmY0QXh4VHZnL29Tajky?=
 =?utf-8?B?WHlMdFRsRWcvcFloUHFnM3hwRDJaTTRYbHYveWNjSk9BVEErUmttQ09OWlhl?=
 =?utf-8?B?ZXFyV29Bc0JXcS8rRnJwZW43TE5ZNDcwYjd3bHEzNzdIVVIzY3hMb3BSS2cx?=
 =?utf-8?B?M1JtcTE0TGlFcFFsQ2RhVm9KTGNKMTZIZEdBMXp1bkQ5VUVneDk1Wk04RHNK?=
 =?utf-8?B?U3VFTThFdnA1ZTViOGJRS0dkL3NodEEwRUNTWkZwWHJ5Uk84T01MOUFaZWlj?=
 =?utf-8?B?ZFF0OHY4a3I5Y0c3c1l3cDloV3FmelpwdjZxNm1KajdoTnVZQkp4Skp6YmFT?=
 =?utf-8?B?OG9Gc2ViUEgxVGRZVjFpUGFtZVBXY1h2T2xYbmFrbVl2bnVjbUExVmIzc0oz?=
 =?utf-8?B?bzhmOFlPTWVzUjJFTytqRjErSVJma29BdGRkcEluaS9lcHNrWEVEQkI1TDR2?=
 =?utf-8?B?NHlJVnJIaU5UM3kyc1o2Zk12ME1XZ3lwdnJlelVOcFpyQ1FrY2FoVWdEc05W?=
 =?utf-8?B?Y0dqWTg1KzFjc2wvUy9TSTBGZXd3S01ZMXJ5N3VQeTgySDQ4Uy9tTU5IQ2ls?=
 =?utf-8?B?a0ptRU4wdVY2VzRFUUtUUHVkNHAxVGZ1WkxYUlBHcll0RTlnZkpHcWhRTytT?=
 =?utf-8?B?V0VnYjczTlhYeXBkdnZCTTdLOHMrdEs5UFYyeEcwRnRxRG9Fak5JeVpnUmo4?=
 =?utf-8?B?dno3OXJzSFhaazh3R0NqdzRxK01KeG1VSWY3SUo2dE0zNStBSmhZQkNUVFJp?=
 =?utf-8?B?QVdueVF6Z3BnVWExTEYyU2ozcG16anhIQ1ZSWVJ0T3lpa1NqZTdMR1dIR2tR?=
 =?utf-8?B?bklpTk1WOU80K1ZRbTZRTlduWnY4OGhualhhSjYyQlJaWHI1aFZWTk9IOE14?=
 =?utf-8?B?ZDBwR0Y0NEswL2MzM2R5SkdXa1p4azBVN29HUzJmSWYwek1tRzZsNm9UTzly?=
 =?utf-8?Q?Cy5xfbG9jSF89c3e3TJVIThgiyJMuGn7Sk+cAyn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e292f5-3fbb-4952-e556-08d8eee4025f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:43:53.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOfhDNJApsgwgoOO+g5HIVPXtViCFrFXnN91C3tyWP0IzCHyr+GaMAlxC6T0+nEwbUyR0/Q74XrJtf+nJEbf4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 1:36 AM, Michal Hocko wrote:
> On Tue 23-03-21 16:18:08, Mike Kravetz wrote:
> [...]
>> Here is another thought.
>> In patch 5 you suggest removing all pages from hugetlb with the lock
>> held, and adding them to a list.  Then, drop the lock and free all
>> pages on the list.  If we do this, then the value computed here (min_count)
>> can not change while we are looping.  So, this patch would be unnecessary.
>> That is another argument in favor of batching the frees.
>>
>> Unless there is something wrong in my thinking, I am going to take that
>> approach and drop this patch.
> 
> Makes sense
> 

I still think this is the way to go in this series.

However, Muchun's "Free some vmemmap pages of HugeTLB page" series would
likely want to drop the lock for each page as the free operation may
fail.  So, we may end up back with one lock cycle per page.  That is
something that will be discussed in that series.
-- 
Mike Kravetz
