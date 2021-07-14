Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221863C89E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGNRmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:42:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16968 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhGNRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:42:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EHVdFa025090;
        Wed, 14 Jul 2021 17:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZmeMa7ikU94hRUUofGchda7lP5acn311dIT6mo+2mAE=;
 b=V1mBkHvecodbmSq+Q7jcfBhdGjETylu2Mr1klLCUvbMX+XOU3lYoC47cN3d5g23oWKfS
 paY8QMec1d3d+i6szbPCpMl99SIIvG1CiM8vPRfXoi6u5wxhdz06ZyjTgnrEVNMRkA1k
 lUZsnJZ7r9VIGvdkpJ5BWkX2BzVhxxG4Wy8Svopsv92NAok4UMGX2+xGSKnTCUOWWFB+
 gd27ahSRdv7fA/Zv+Kb0lVilf31nXnY5GMfSH/r/4/mDhMQdqAw0PkL76DAIW2PX+aVe
 FD/grC0854e+ir3hQeiRLHhz+f/4ifqN3pkW3u7anu6ziX/b2JlErC67STxRG/5e9JBP bA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZmeMa7ikU94hRUUofGchda7lP5acn311dIT6mo+2mAE=;
 b=AhP9dd6d1vNYLZj+eIef+RxTTeuVtvHbdQG49d9ctbmNIHELOFnz3KrdZCgCSM2afsIR
 yx5vvu0wdkb+BlNWbd3MHpD0z1nM6Dq+9UfXveHDnNmJc2nzIEUI62PzZd/YJN2LJRFg
 UMD40NFpxfP3Cqb6ZsF0hPF1yfICh0+JSqfi6/TAPIGjggghvE5atRBHy5SaZUBQWIKG
 hiXCvjRBUWqfUV6cCe05NrVqrDR78aKU/HyT3VyFpRy4j2srMNp5Vlsi3niiQCx6Uvjv
 gqHoMZQ7THFJOdbmtOjBgncBLqLnT8aCFLOEfXwpwXtQmLB1LmHgdSt5Pq9wYvC8Et5J UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39sbtuk0ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:39:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EHYk5Q096790;
        Wed, 14 Jul 2021 17:39:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3020.oracle.com with ESMTP id 39q3cfsdte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeVmDrRseOoT8Ds/CXMr8kY59jEpOTOEY4JZfsMEAqbvhuSwEBJLZlmv5zMvp56x2DMBrf6M/YtY0IFjKU6zP0UGwWMAB9X/+S+qK02oBoN/RbV2o75nAoNip7Xpgs+aRalmtIvWrpWK8iKVOe/XzXKvt4d3HkCyPWpxbel0qnhZJ0RiFfH7nG3haUQA3/W7Cen4u11KYqn3jAJde4UZ6iZ2V3VAjAifo/Fx3XE/6VgBoqGZyaOU5cJXECx6BWgEmLorzaS3bNnk46ctskBhkRtm76tjvfwWKQQGDUmI1uO8PHOsebpSQmhhEoIwtpOjWriszotPYOvT6OFkj2NR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmeMa7ikU94hRUUofGchda7lP5acn311dIT6mo+2mAE=;
 b=k6a7DeIaVXQZO6d8xTgEtwi1+2hUHMCipqQcTLRqNXRx9h7VmVhN4MBJyQGjkzT+tzf7Izd7acQHVSnAAilqhtslfjHULGzCGnCcelrwIWk4S0YJk3YkMEecgiXK9RWWb75lmKxzksIQ3hDr/kRSsYxrtMOz/l3QzUyGiVOo9rpbU3j45qPF3fa8926zbmu7oXayulk1/W+z4L/RnLAr5yN5+qnuZqwE6/hjPzxa86N+Czx5hOt8UR/fTz6xnLLXfDZQd3CoeZurHskVlvfiYuvrJ2EsBAF9VsC0eY+vSVL//draoTHuQM6Na8D6gK6jC65C6OQm+qV9usM3hHLjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmeMa7ikU94hRUUofGchda7lP5acn311dIT6mo+2mAE=;
 b=r80ZO73cBRxIuxWqSn3Qbx9AT6TgTjmA6ZnPiqm9Ci6fcDqYJbNVtjFomH4GQZ0xecwgFbaP+PMvZwKu+whepgSCg82TfYCp67WkZpu6YtoxcxcO98k2/2bOZdAzPgtiSzyphipPWTZ9D6plzVWl2Gb+FSJJuWS3/VYd5tcLCqk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3686.namprd10.prod.outlook.com (2603:10b6:a03:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 17:39:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 17:39:27 +0000
Subject: Re: [External] [PATCH 3/3] hugetlb: before freeing hugetlb page set
 dtor to appropriate value
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
 <20210710002441.167759-4-mike.kravetz@oracle.com>
 <CAMZfGtWvGZZ1VaPzZbEro7nYCHS6tGCL5kYm3ArSQ5b5E0-o5g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6c38223b-83f4-ef7d-68d7-27c0f6ae6359@oracle.com>
Date:   Wed, 14 Jul 2021 10:39:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtWvGZZ1VaPzZbEro7nYCHS6tGCL5kYm3ArSQ5b5E0-o5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 17:39:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730ec1e5-c50a-42c8-dbcf-08d946ee540e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3686:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3686F9A14B56FF37C3E8EEF3E2139@BYAPR10MB3686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:369;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6u1lVr2Krf+NgAKSa1AMlcbFILfnYfDUqe8DuNxQ9sqTw0C1wBiexGXCOiV46nN+714JVu7GuwbJtKmyNuVd6iBoAkir745IbkGoiheZ54O6CAF73GqRx6ryMkkrZVpGPecsNbTXCAjIuyKGeClBo803I9TT+kApYteRj6Z1nUSxxulmThCPDHEI5q3Qhd2RCKqq9Jl5UqRrbrn5lsyx1OxsRDXPIYHyGYLYTnv03+gELMoPBaKTxZ6T7SpCVl4nad5H3Cr/EZFYi0XEKEk4ViSKQBZj2d+tW0cen+fXvpWR9oXca6t9CgYZvqJixaRvVn/i7HWrrHP87A9A2jOO6s/aJLWbNjGzX2jvpZlrvO/Kdc8gKux/vgVRvI5c3WPsHIO7uhB6PCKpJ0kvaDSwhe9Nh772NTWEo4kuhUk67vUaT/O1Mtu1kR4ohg42GXrOfeGGZ1Hia1zyC/HgdBBxXguEl5luR3hA/uUJ+BYwh/bLtMj8kXesRDtDs7U3FTumhcWdJ4L4NSESFToKLPCE5FYS/U38wDNd1hpTUEMKHp5N4o8/HJik5sPq4z6suxcscstBYVBLcurbLOzYbiLSaYNCgT+hTw1DlIPrJHEvrH+fo+Tj+d21J9GYAhXs/g37GbDxNqvNlszUltHNEwkDeQ1EzKtTEkZJKCN+rhyfdwxSFX1wvjvywCddLSMchx0MPQait1vD+BjnKhgcXcYuyVuZIvnIufdB+vhwhFWcAjWmIgQbn9zPkU2OKIozNmhecXyYylloWwTMRwU7EitBIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39860400002)(376002)(316002)(52116002)(8936002)(54906003)(2906002)(31696002)(38350700002)(8676002)(6916009)(38100700002)(7416002)(16576012)(31686004)(6486002)(53546011)(26005)(186003)(86362001)(4326008)(44832011)(478600001)(956004)(66476007)(66556008)(66946007)(2616005)(5660300002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1QVmJDdWtJejBtWi85bGZNZ2JVcVpydHpyZWNRTzNURkEwZDZJUVU0aXFH?=
 =?utf-8?B?QjhWck9EVGl3M3YrV3BjcnBKNEtPdEdiZUttUjJhYXZDU2h4cU5zN3Rqc2dU?=
 =?utf-8?B?a0ZrT1hUU09pWFJQakZTM2g2MVVkRnk0dTYvTnorWmVSNExwYytkcURyOEFy?=
 =?utf-8?B?aFVzSzQ0d3JqTUVuTkN4WThHK1hCS1c0Tkp6R1hnVmRKNXRyTHlweUVCR0Rs?=
 =?utf-8?B?TEhxYkNlYW03WDB5S0k5a2JuM0VNV21sQ1FzdDZhYnhjS2tNTDRGSWlROElH?=
 =?utf-8?B?bi9WWWo5cDVMUEtBUVVOSzdzNUNFakhwTkZXa2g5UjQwNmlPTGNOaTM3dFV4?=
 =?utf-8?B?eWwzRFZjc3dNM3Z4Vy9xbTFFald6QUNMTkIxVFIxNEMrOW44U3l4ZmxaV09J?=
 =?utf-8?B?UHdkY09tQTVHclB1cDhCdlJVLzRjZm9PL0wxeTZ4a04yN1ppdEdJVGJhWUpl?=
 =?utf-8?B?SW1IYTNEbzFwOHVxdzJ0anVYeVVzSW9xNW1jMXpEcDMxUnQrQ1BvUTdHVzdx?=
 =?utf-8?B?QTZZNy9QWTM0TTRnS3VyekZJdHFXMDU2ZktlSVR3cnJTa3RCY3ZnK2lsT0ps?=
 =?utf-8?B?RnM5L3A3SUNqdGRVdm9mbVhyUDljNjhhMk11bWpvYnpxUkc0V0FBUWpBOCtV?=
 =?utf-8?B?UmcyMHpWOXZvbzAxUHp2WGdob0dHb1VwZlhTcllVTGdCelg5T1ljSjAydU5C?=
 =?utf-8?B?cVg5ZTkxU2xKQmRxeGdPazFTbDBtdnNrYWtvMVljY0JMUHFEdldBN2g4bnli?=
 =?utf-8?B?bEV4S0VmaEFZUVQ4VmhyYmVmbEkrTnZJSUp4TXp0UGcwK2NzcmFwN3lOa1Rs?=
 =?utf-8?B?OTRaN2pxZERvTUdjSzlEZSszVFBOVjhPS05tK0c2REZkZ1g5ck9zMFBNUS85?=
 =?utf-8?B?dXFNZk1wTWloTUlLZ1JzeWFSUTZoQVNwakpxVWl6NkV4WlArdGhSd1JEV2U1?=
 =?utf-8?B?WHVOblJEQW1NVHdFWk93MDRwT2xtMFlRbnJNWWJ1WHJDTU1TKzJyV3ZlS1VT?=
 =?utf-8?B?NEhCYTU2cFoyeEZkOXFPa25abXZpMjBxN0Vld3VydW9XOTdvVXBpbXo3d09h?=
 =?utf-8?B?dDkvOWVzZy9GU0NUbDd4allhVXFHNG9ESHVPeEVSMS9XdEpLV01MVXh6amV0?=
 =?utf-8?B?SWRQVFBPVnBYdVMrUEgrOHpQZW82M2hLQmY4NzFXWis1ZDFESUJFYjNJd04v?=
 =?utf-8?B?NDlDaEY3b0tzd0ZEUnVMYk1ERTRlS0JWclJib0hoNWFQZW1sTTRvamxrQTMr?=
 =?utf-8?B?OGE2Mm1hWmdxT3lsL3RySkp2c0ZqNCtjc3hKZHFWeFNBSlVpZk43VFAwc1ZH?=
 =?utf-8?B?d3JKYnhNTWFEYmNnVlBPdk4wdGQrVk5ZZFcvQ3hzZGoxaXZHVTdBbWRybTdL?=
 =?utf-8?B?VVA2WC8yMy9GLzRDNHRNRXBZTWdzYmRZb3UrU2FjZlRUV3Q2cjBld1NGQkNS?=
 =?utf-8?B?WE1uTzlJSHJtZDdQU056dG5vdlRWeDRVaFY1OWk3SFNoVTNMZlY2dHlsOHQx?=
 =?utf-8?B?S21tNHVra2dqc1A5S0JESWZGTjdJMEdmVjUraUxxd1YraWdsdTVxWkMvV1lx?=
 =?utf-8?B?VE8vaGorSlRHT0VaT3lTUzAvRm1ha05wQWt6YWk0YUowWk1IZ3VBM1QzaEVU?=
 =?utf-8?B?Ujh0ZzZvVCtkTUhvaXdiakRDcm9mZjJZdXJrcGIzYXFVNGtHTTAyTHdva2g1?=
 =?utf-8?B?SGdpbnZvazB6d1VIUGRsVnR0NVI2d25vSXVNVXFkaExjWnhLUkplamlYU2R6?=
 =?utf-8?Q?gHu86y/Kn4oRxJaQmoU+S3IMHnAVQA5a3lyKBeB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730ec1e5-c50a-42c8-dbcf-08d946ee540e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 17:39:27.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUB8Gr9T2HLhNlONcm/RwRh19vYgpt1WkxpJYftVBPg6gntO/0bG54MckbOdtxCswPYIJ0nG8CZGIQH07jFcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3686
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140105
X-Proofpoint-GUID: 0F8cg50Zl1U1SjzwpVWN5q3A0z8TMMjA
X-Proofpoint-ORIG-GUID: 0F8cg50Zl1U1SjzwpVWN5q3A0z8TMMjA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 3:57 AM, Muchun Song wrote:
> On Sat, Jul 10, 2021 at 8:25 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> +       /*
>> +        * Very subtle
>> +        *
>> +        * For non-gigantic pages set the destructor to the normal compound
>> +        * page dtor.  This is needed in case someone takes an additional
>> +        * temporary ref to the page, and freeing is delayed until they drop
>> +        * their reference.
>> +        *
>> +        * For gigantic pages set the destructor to the null dtor.  This
>> +        * destructor will never be called.  Before freeing the gigantic
>> +        * page destroy_compound_gigantic_page will turn the compound page
>> +        * into a simple group of pages.  After this the destructor does not
>> +        * apply.
>> +        *
>> +        * This handles the case where more than one ref is held when and
>> +        * after update_and_free_page is called.
>> +        */
>>         set_page_refcounted(page);
>> -       set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>> +       if (hstate_is_gigantic(h))
>> +               set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>> +       else
>> +               set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> 
> Hi Mike,
> 
> The race is really subtle. But we also should remove the WARN from
> free_contig_range, right? Because the refcount of the head page of
> the gigantic page can be greater than one, but free_contig_range has
> the following warning.
> 
> WARN(count != 0, "%lu pages are still in use!\n", count);
> 

I did hit that warning in my testing and thought about removing it.
However, I decided to keep it because non-hugetlb code also makes use of
alloc_contig_range/free_contig_range and it might be useful in those
cases.

My 'guess' is that the warning was added not because of temporary ref
count increases but rather to point out any code that forgot to drop a
reference.

BTW - It is not just the 'head' page which could trigger this warning, but
any 'tail' page as well.  That is because we do not call free_contig_range
with a compound page, but rather a group of pages all with ref count of
at least one.

I'm happy to remove the warning if people do not think it is generally
useful.
-- 
Mike Kravetz
