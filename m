Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9229E325741
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhBYUFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:05:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhBYUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:04:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PJxMNs162040;
        Thu, 25 Feb 2021 20:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7AJ5ouXe69HP7tfarYXqzmDOcTp18muJIlvn2iMRB+E=;
 b=MgfLVer1jKC1BhZI/XE4hQUG2EGyEO6HTnruL9EMqjywW/WvyqO7LEP9uROUkB45k4jN
 lLkn1frMJe9EKFQxoF889gWJ4tfJ2iIDAsLEiZHeyoQj0ewKeb8T1JUjyabHYwoDFLqU
 8DK99K5E2kiCZJorHJZCy2czizRaN4undiNQQQCkcadU1Tbw03zpDx2Q4dadCAx0vnpW
 14TltrXNRhemRvcOVG3L1smxJr9ejzU1rJojpRw82gNK1AXM6IKdb7nduAKGs/Wtpt8D
 st9G5a/CvuTF4Q7Eyny/sDxbR7ey4++JkS0dun8J0atIGjrXtk0/uFX84UNzsmvrqYxl bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsur7s71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 20:03:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PK0INb002098;
        Thu, 25 Feb 2021 20:03:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 36uc6uxkyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 20:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h13/1PQefcdVm+dOuZLExjIpQCDPRTY58OImJV/BE5ApgpiPvJRtXFmgbsjIF4os/7ruggQamMpOnjJImC8zxJzSZfhE3h9/BdfgOHxVVUTLac02cBgTBCKZS332WYvNIMCj5YaK+f98a7+6BkLUwhXCpWChIkPdaqUEtfRcu2T5kuhOOb4VgHVG4AO1wDxJAtctUQh1U/Q5tleZX19Y3/fORX0EJUE634lCQRvktcz4pHNVVT8SfCw3L/u1jc5u6dY+Rwtvex67PdvEdu0BXq1AqUa7jjgNjxMTriaL+4aRnUqgwTMT0fj40Mhq0S+u3IbLxK10yqHEwFkFslWonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AJ5ouXe69HP7tfarYXqzmDOcTp18muJIlvn2iMRB+E=;
 b=XXeZpcZqtOfZkUXz7vNFOEU8zVdoKp5vuHLmihxtXm5iqTB0P9W3msLL00zumsUpF1mezxTdFoZEg+UdMMa0jPBKvECbxl3HlbeNokQiYvsYA/y9Lr0JUievff3uvq8w0hgXJXMBiXAHPC8titgv8bwh2H9vIGKtJZ/cxsRpxh2cFmzl0pIJrUsK/FSekodnzBP0YJCtJJGIXAr5LnIytdigXdNfVvg7pBOd1a8yH7NpbTamL7Y8rUv+MN0UM9D+Lp0MzxoIA0jbSuJ3Zeokunoj1o0n7526kHYwOYDUVfUNJr2galf4h1GEB6Jn77yc8V0jEpjQUCClYgv3RjrFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AJ5ouXe69HP7tfarYXqzmDOcTp18muJIlvn2iMRB+E=;
 b=UTskvqqq7O+XK46Ri04MoDSZRvsTyeMn4sDZ/tugFqQWw72k5BGh2vnTSnXuR8+Iwf1+EHRFMRcn+bpaZ9+ix4Zzl8o6SUbASa1fHyOmZPuvRuhqEib3PrLqFs4GXJN7kH2FDXqS5/8LH0ZWWl+NwPypDSv6/JYnOzugpjMbXUc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:03:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 20:03:20 +0000
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d7f6176d-10d8-be8a-0b7f-70d0efcd321e@oracle.com>
Date:   Thu, 25 Feb 2021 12:03:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210222135137.25717-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0056.namprd10.prod.outlook.com
 (2603:10b6:300:2c::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0056.namprd10.prod.outlook.com (2603:10b6:300:2c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 20:03:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85524ebb-c30b-4e47-6a30-08d8d9c865ff
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4115B6D36FB210FE9703B1EEE29E9@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhUNbYe6CL0sil88YUUE5H+Yc6bneHydV5lnnykW07JfpuVsrSvHCjwJPs6ks9V8sUu0rvSDUyoTSS0MmqrBztbyC/eL+oOyZITKQbAFkIXAaCdznF+qkCvtaFb9LC0BDttM40pH9XzrJKZMVMw2jPRIk/U5pwRwXxsgOI8fo6C0jiAemRERNkQ+ngLUNrQnQjDzfnWAKY72jJzVy4/nV9qXFysHm1dMD7ZrQRwVIlOdZFYekU0Ty0MLJerBbdZtY0Aytp6MZf7GGQ6fBX2vVJzUzIrWkb73CTWIRabUd+y4nvrp2chyy9bRbpbLdESaP/UPT+tAYf8iuXEJpExCPUv9GDVbxUHHj2cmns4/Fv/W6yMVQ03GLu0dNAPV9mfnTzR5DHijtfab73kURbX6iQ10XnWUhAGzxpkxXAHoFi75Z2DPYA1a+Co2CptjUjY600+NZpRXYrXy4Sp0Ng+bxZt3jac0D/adbXEVSz95SDUORewSXtJFP3nnswsuiKhGANpmIZo9Jp0dtGUBXsc2z1ja78UfAHyGRO4RIlhvbemdAyMp2rFgU0u2YNovyl5KYlRZ4Fw4cIm29iUTlsxovA2Y2PbwW6hKYOZHrfNEmH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(86362001)(16576012)(31686004)(478600001)(316002)(53546011)(2906002)(8936002)(83380400001)(52116002)(8676002)(110136005)(54906003)(5660300002)(31696002)(956004)(2616005)(4326008)(66946007)(66556008)(16526019)(6486002)(186003)(66476007)(36756003)(26005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFdUKys3RkZMRkFaVTRISnlVUGlGOHJQcFVEZ2wzeWUyYVNCYnI3dWY2Sk5q?=
 =?utf-8?B?SUtKa052MlU4RWhhQ0lJVlV5Rk1GemVraVJiSTBhUmVBcUJqNGVrRVFGTW1U?=
 =?utf-8?B?dEJKTWJiNkdDc0hYU1VkMy96V2JYNzNVQktwYjJwT29mSG9jVElmTmpiSjM5?=
 =?utf-8?B?RVZiQkpaVFU4bFpxQ0Izb0RHU0lXTlVZV3cvaS9GZDlrY2dMbE5KZDBFcUVh?=
 =?utf-8?B?UncyeVY1aTJhQXY4ZjJXMVdZdFBFOHFOM1NEMkFsd3pPd25aMjZQZHBsTWFm?=
 =?utf-8?B?ZkFwVHQyWlFpWWZGVlgxVmtJT3FHa0xrakczeXdzVEt3RDRVZkZlMWw0dytG?=
 =?utf-8?B?N1N2SVplcUp1TDIycWthQllBU1cyeFF4S1N4V2drMEVPQnJzT2t3SytpbDk5?=
 =?utf-8?B?UHpuMHJZT095UmlsbWNrSUh5ODdXdEpNUmZHRDAydHBsYlgzeHA2bjBMdFEz?=
 =?utf-8?B?bmM5WkpQYURZWjNBdGtZaTRYeCtORVU2b3MydUQzQnFKb2xqRm9pdmlxR083?=
 =?utf-8?B?d2RBOHRNT21nT01SSGFDc21RN1hIdHVLOUZrb0VTa1lyQU03aC9WWW04K2dD?=
 =?utf-8?B?c1hpbTZSM2hYUys2dE91K2NFdlF5TVZTVXBRWkdrYkZjUklNVXJXRHdjS0hH?=
 =?utf-8?B?Y245ZEI0eTViS2JlQ0lhYzROTXVmVjBLWWw0bW1CWXhDSnZJbXkreU8rSmdM?=
 =?utf-8?B?NWd5dG1wbmp4K3RCckYwR1RhMHlpaVk0cXE1RU81TUFPcmtlMEdRa0hCazBJ?=
 =?utf-8?B?a1g0QTR1ZkhXT2NDMEFRYVM5ZjBmOXVaaTNjeU05T053bkdWejZKL2dLQ3Ux?=
 =?utf-8?B?TFFWQkRQZjEzTml5dXFaYjRIVENPWHluOTV5Z0U3VzZKR1VmRzk5b09xY2dL?=
 =?utf-8?B?MnZNcWZYUEErU2krOG5ZblpsU2xZV1J0a2VzZ2tCVktzOWZzS0lURStlSXhi?=
 =?utf-8?B?d1VFN3J1UDlzTkp1WnJGSVY2QURtcVQzSGV0QU81UGZqcTFHZ1NQZEJNbENs?=
 =?utf-8?B?Qk9YeW51cy9hVnNoR2NxSU1RMkg1WitucWhGb0dNaEplbWlxREp4QUJpQUtZ?=
 =?utf-8?B?VE5Qa0x6T2x3V1RyaUFDUWlVL0JOeGJvZ3ZlelVxUXZ5ZW9tOCsxU2NVdTVT?=
 =?utf-8?B?NVpyR3U0aEFPQzgxS2dhVEU5Qlp4aVdLVThPSkZYSWFoVkRHcWtkN3lNcUND?=
 =?utf-8?B?ZFZGa3IrS1ZMTU9XMXpZYTFVNHJIYTExc0VkVjJ3R1pMSkt6Y29ac3lOY0Z4?=
 =?utf-8?B?c0RjekVFZmdZU0haMFR6OFhYbCtvcGJVQXlKcU5Vak0zRGl4eGNkUEVPQkwy?=
 =?utf-8?B?Z1M1TXJHTVZRejJFTVZPMW5PeFZlcTlrTk5DVXQ2OTFxU3krUnRHUU0ramhW?=
 =?utf-8?B?dXNnUG54YUpwc1Z5Z3FsMGM2ZmFuU2t6WHcvNHFZWXlGM1NTdDdySU5rSGxo?=
 =?utf-8?B?eVJDaHRtZDQwU2F0K2ptQzlhVTZyeDZTR0JjNXhOL3RhbFhGTHpONjN3eVZz?=
 =?utf-8?B?cmpEMU9QRGxEZU1NVmVONkk1eWJud1pSMnZ1a05GakZTeHRwMm9Pc04zUTMy?=
 =?utf-8?B?MHd3NTJYbE5EVTc2TjFxTXJOQldIZ21HS0ZLS29mVHFnOE9aNEpOQStvNmlI?=
 =?utf-8?B?dFlUbDl5TlZlVmZmK2tpaEM1VW5NclVQUVRXRWduQUNZWm5WTHhuaWpMUzVD?=
 =?utf-8?B?NUZlK1VZb2xQQldEK3hSd2RTTWtVZWhveWpwVDVONFlISWtudldGdDFaVDI1?=
 =?utf-8?Q?war31p0ovc2S949gYttyzlE52MoXfK0M2fzHDsm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85524ebb-c30b-4e47-6a30-08d8d9c865ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:03:20.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcXw9BoqKZiR1BJdz0TCTvan9pQ2nYuLPm8pLwhh/nhsfOryAhSqotJ5QXSn9HPFAEsAyPN5QsYAsQY5djsmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250152
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 5:51 AM, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> All operations are being handled under hugetlb_lock, so no races are
> possible. The only exception is when page's refcount is 0, but it still
> has not been flagged as PageHugeFreed.
> In this case we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thanks Oscar,

I spent a bunch of time looking for possible race issues.  Thankfully,
the recent code from Muchun dealing with free lists helps. In addition,
all the hugetlb acounting looks good.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  include/linux/hugetlb.h |   6 +++
>  mm/compaction.c         |  12 ++++++
>  mm/hugetlb.c            | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 2 deletions(-)
-- 
Mike Kravetz
