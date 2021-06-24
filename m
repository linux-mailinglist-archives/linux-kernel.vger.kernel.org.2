Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF143B2441
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFXA3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 20:29:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbhFXA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 20:29:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O0Hgvw024521;
        Thu, 24 Jun 2021 00:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A+Kg3NKFuCRXUcUKiwQoogv4HKbViDrAO3+Yh1vgito=;
 b=IvstXP7LcfGjikixoPVLnmaoYFOOva/M+v7YCJygQK7trBe0cUbemKAJ35bKrkRwrc8G
 1PgHMtuzDK53JQqs9gtuSw2DY4bZaEYlss+cwURSFzXwQJnzAhR2jdHBgptGJIkmW2z0
 Z6Vb4IcUJzyViKpSVCKt5AqO8XOLY4V0SD+Eq1syl+iAmu7lfKSk0bx8ubiYnOYIoJnZ
 s0QZoOvAsVU8ae1/ibVpN2O/+1fYII1FpBWiouF7ioMCUKCknFxpfH+NTUhMiBinksSa
 icizmK9aQUjhCzgorcbgOb2slBMKlPJqyYlZtwJkMG3sbPJaqTmSIqzTEiukw1a2vent 4A== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39byjyj5k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 00:26:33 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15O0QWo5083123;
        Thu, 24 Jun 2021 00:26:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3020.oracle.com with ESMTP id 399tbv8kmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 00:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9UHZ28136xRwNaaPvLbOqgFVSeiihQ/13kqqSRKp1qjLRpZRPD999vMGy4S8SXAYsKT277rFtOaJBBs768GIVfToCoaAyy9XavUMI7og/mNPJT6UgPGAwnL+PCAs8oOUzS+41/oOUJ/8Je8oJQpZYg+0krqa54P7bZk4Faw5qTZ9GWXdZRvEV9wyKahuFPo5vPyJLwDBj4HmdCOxEYjIY4h93rvMTFO6ee121CaGCpPpT6hK5t9axFjWswXb3NV15H/wQXfJxOnBfld049axl4pFSgGJ02sIGZPCaRtoKVrtBoP3LEazaFx7qkYxeiv5t3JDxRdTI7DokVp07B6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Kg3NKFuCRXUcUKiwQoogv4HKbViDrAO3+Yh1vgito=;
 b=eXlqDa7RrYX4Z4XKVVUogL/q799LV5Jvn2MGtWaPG1dFA6w1O6vSmisTxYCfci0PVWEpYjhzqQ5HjYZE0kBOTcJDu4Op7b5XYl5347XctvfRrjmGhvoINCacTCu38bfMOImlVFO29WxMsACl0ZrM0wddeL8TC0sCzCrn3KoXDOtoslRHtYLPxsbjn+/ezfwZQBXI0acFODnjrx2diECG01GoSzIOaXkiL6ogShxQvbsD8OAQN+gKM6NSAW5KisUdAGv5doGmkrctAwIZJQw5sk3Z6cLfoMRWNxTCuDP7VtwDAbhr4XgK+TzdmmhCbBivxlmIFoe7qGjHnyEsW7JcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+Kg3NKFuCRXUcUKiwQoogv4HKbViDrAO3+Yh1vgito=;
 b=LZzlcmLt4kK40UMetMgaXtSEnCvKNu25lUosbtyZQV02BuWqyMge+dr+PD6fdCTQyTg56f/8NEFgnuTORNgzlhnRyjRbko5Oy9Wdeegy3PkEwM3hJ+5O18nlwJn8KEt37UxOKI7/daK89UN7Qwle24KF782vumQ0DpZvKuQMBrk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5423.namprd10.prod.outlook.com (2603:10b6:a03:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 00:26:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 00:26:30 +0000
Subject: Re: [External] [PATCH 2/2] hugetlb: address ref count racing in
 prep_compound_gigantic_page
To:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210622021423.154662-1-mike.kravetz@oracle.com>
 <20210622021423.154662-3-mike.kravetz@oracle.com>
 <CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <39674952-44fc-8386-39b7-9e0862aaa991@oracle.com>
Date:   Wed, 23 Jun 2021 17:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 00:26:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc82e1a-523a-49ce-a2c1-08d936a6b63a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5423:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5423388242EAD716902D8732E2079@SJ0PR10MB5423.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IzlF2rXHS/nqgvCvhQDnNFmsAKU5RqLDKExg7IHYiiMfyh/SLwAGGHcFMimiVxlD6gteYCQ3tbMjYQbU82NaIMax2n7am4xR3eekWdPDaxPgavlSZYXQvus+3IJHc7Dv/TWjbGJqKB1ZVHqQP6suSJt3Q2CqXNdKQEHzpo+w5OOJl4z42spWibJ1sUlk3WnJ6vkOsIQFNdL7exOQYzXz6be/LWT6LtSww6yNf4H1JLTOJdyCaqehIa1KDVEe1w1KbP568Q6iGAcvojG+nKdz00DF40qiinrym6ewyDseVdTjAW3WuUxkqK/LpbfPJVMSeaQcmJ9vpP8ZRk835spNKndWeELR/ECI+u4xIT1Sv2FF5DwQ+A/M9ehrAEcZsPNT1IPTf8idKiv4yk2DYnh8Q2vama1i1MJgphg6CV17ZVP85gTb3c+nwj8r83PQxEcNtu5BPXiIJ3e21d7rmxQWLhbTe0YxQw9v9Y+U//w6YOYyFLuYAHpblPGMh2a/W8C6VoGcPWhvKEYuul86Wb5fChoceY9NSuA/Bim/RKV2C6BonyM9Zk72kiFpQ5tHghKeeMmESYMrmOjc1qujFnEudzhipUnnzdeeEOYPJrKGn+TajG0q5vTGbX//hbobW3299jWYPPd6BHqQA1kPY0hDDvUS3oc620eQE+EDogaCORDoTaQSAsyrzHRy5FT+tC5yms1HQqrD060hJC7xVrocw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(376002)(366004)(66556008)(66476007)(66946007)(26005)(16526019)(186003)(53546011)(2906002)(8936002)(478600001)(6486002)(38100700002)(7416002)(83380400001)(54906003)(31686004)(8676002)(110136005)(86362001)(38350700002)(956004)(31696002)(2616005)(4326008)(52116002)(5660300002)(36756003)(316002)(16576012)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5VQ1RLUExRaytqVTY0RTJTeCtKbGpTZDVWNVJmVTlaeXFibmd5U3pGUUR4?=
 =?utf-8?B?eVZrZ2xFd1pTMGdrbEozVDZYSXhKeXNLRzJHN0hWYktRTDZuK0tnNjRoTDdv?=
 =?utf-8?B?L2ZjUmZ1SGNoei84c2F6a1I4TWxqYU1DLy9GOXRTazMrZnE3dmovVzVqbFFX?=
 =?utf-8?B?ZHNJa3J5Z0pMUlpwQmdFYUFERk1QUXNXZWROeTFWMjNBN0RnNTBhUUIzT0tn?=
 =?utf-8?B?UTNHeW5UMndEYjBxUFdGVWpwTCtnQ09xTHdVVmtlKzE1c3RVSFY2ckJtb1Mv?=
 =?utf-8?B?MXpOOFZmaXEzOHZucXZUZTdyRTlGb0EwMC9wQ0ZDU1VMWmdUekk0MnVYWTFO?=
 =?utf-8?B?aDh6TEJvd21rUlVDb3pqdnlEeDE1UXlTQ2hNdmNtZW5qWXBVeTliRnFaWHZI?=
 =?utf-8?B?RGxiTkcwcmJKWTZVcEZyZ0Q5aE5NT0RoOHlpZElRbmNFTElyRkxHRXVJWVpS?=
 =?utf-8?B?c1VDdlROZGFRV0FqNGZkOGhaOVdzSk4zdktkdGtYUTU5cFlrZmp6L3hDRkpy?=
 =?utf-8?B?NzdKZUgzRjZjT2ozLzYyd3NBNmkrbUQvdjBEMmd0a0hnbFJmWSttRUNGdXM3?=
 =?utf-8?B?RUdkQlcyTUFFTERkeWVYamJjYXZ2WXFWaXNmY3QxbVRsOVlITDAreWFMUVh0?=
 =?utf-8?B?SGNqSGxuNS8vOG9FOFZGdEc1aXQ0Z3ozWFhrVTRWbGVQR3gwU0JGUkQ0ZTI5?=
 =?utf-8?B?c3VTbFUxVU9PaDZZd08rSVdnbVVGT1VobzE2M2FhMkVCUUtNZjJDcldtcDh1?=
 =?utf-8?B?bnRwN2NrSVNpRnpQZmJWSHI0SW5adHRoVXNUNU9RaFZOdjB3NUlKcTRsSzBw?=
 =?utf-8?B?OWoxRFJIbUNCVkk3bE1HUlhhcVp6QXgyeUxRV0NhSGRZaFFYVjlVMU0wZmto?=
 =?utf-8?B?M2t2UEZZckdMYzg2VDJ3OUpjbFZyNGluVGN1MHF6VXp0VUxVUkh6VFl5NjFW?=
 =?utf-8?B?K0FmWHo5Z1Q2RnRpb2YwdzRETm5kVTFNOUFSbXRkd0lrb2VMSTNTQTFQM3J1?=
 =?utf-8?B?cERmOE5lTXY0Y1lVRXZMQWRzencxdzBZdXhjclRHaGxlOEpSZDhaSEJiRUtl?=
 =?utf-8?B?dlJCY2VuUmN2NlUvdVMrS0wwdStIcnMxSURkc1hRemcrM2laVWVjcnVtWVVW?=
 =?utf-8?B?NkZuVDRqKy8yU0xoZkQ0Q0RrY2orb3BJb2RUbklJSjI0dGxxOWN6SzI1Q2dm?=
 =?utf-8?B?M0hmV3lSczYrdE5xaTRVWDNDYmhtOVIwMFd0Unl6cWZmRHIxNDJOM2lZTHhT?=
 =?utf-8?B?V3pTV3hlYzBVcFVCN01qUHNBanRMc0pXVFVYajJWTTNpREdYV2diUkV2L2RC?=
 =?utf-8?B?c0JRUFQvVVNESnl6SlhqbHBHQzBWK3lkMzN5UWFoNXRZOWZSMUhyREJ2SzhM?=
 =?utf-8?B?dEtVUjZPdVhzN0tad3VHODdVNWdwS2wwYk1TM3F5Vng1QmsvQWZhaHppempF?=
 =?utf-8?B?VmdraXFEdTZvTDNLUFBpWUJicXRwUy9lMTRSYk5nNzdqZHJCNFV0WE5yS2dI?=
 =?utf-8?B?MzIzcHV6d0ptVUV6TDdsTEJWWFpqbFdBZkg2U0Y4WVhsNmFMS2J2eThmWC9V?=
 =?utf-8?B?YWRXYVNvcEdhSkFWczJzUlc2LzlJOTFweWF2N3YrWEZaUEEwYzEyTHpuQjQv?=
 =?utf-8?B?bVg1eDFsMHJlSndTTHplZitld2QxT3p5cEljeEZtRjk0TUZsUEtRc0NQNmtk?=
 =?utf-8?B?ZnpvSTNraVF1cUNzQ0JFeHhpc2UvWUFrYlBwYzJaSkdFeFdqV2I5R25JTytV?=
 =?utf-8?Q?jGA0WG3F7l2iU/LnJ+gnsztRafVYu91Ro5GnMW6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc82e1a-523a-49ce-a2c1-08d936a6b63a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 00:26:30.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqsWXCp24R0ITiFDqyaq7XHLfWhwDvNooZQB9MG8my6LcwxHpvlhggLMgT3Lbi/FK8KEbs1v1oA/L9LG7Mzonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5423
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240000
X-Proofpoint-GUID: n1RML2SEZE4iF9MNOoVTKmDsF9cEJKjS
X-Proofpoint-ORIG-GUID: n1RML2SEZE4iF9MNOoVTKmDsF9cEJKjS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Naoya

On 6/23/21 1:00 AM, Muchun Song wrote:
> On Tue, Jun 22, 2021 at 10:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> In [1], Jann Horn points out a possible race between
>> prep_compound_gigantic_page and __page_cache_add_speculative.  The
>> root cause of the possible race is prep_compound_gigantic_page
>> uncondittionally setting the ref count of pages to zero.  It does this
>> because prep_compound_gigantic_page is handed a 'group' of pages from an
>> allocator and needs to convert that group of pages to a compound page.
>> The ref count of each page in this 'group' is one as set by the
>> allocator.  However, the ref count of compound page tail pages must be
>> zero.
>>
>> The potential race comes about when ref counted pages are returned from
>> the allocator.  When this happens, other mm code could also take a
>> reference on the page.  __page_cache_add_speculative is one such
>> example.  Therefore, prep_compound_gigantic_page can not just set the
>> ref count of pages to zero as it does today.  Doing so would lose the
>> reference taken by any other code.  This would lead to BUGs in code
>> checking ref counts and could possibly even lead to memory corruption.
> 
> Hi Mike,
> 
> Well. It takes me some time to get the race. It also makes me think more
> about this. See the below code snippet in gather_surplus_pages().
> 
>         zeroed = put_page_testzero(page);
>        VM_BUG_ON_PAGE(!zeroed, page);
>         enqueue_huge_page(h, page);
> 
> The VM_BUG_ON_PAGE() can be triggered because of the similar
> race, right? IIUC, we also should fix this.

Thanks for taking a look at this Muchun.

I believe you are correct.  Page allocators (even buddy) will hand back
a ref counted head page.  Any other code 'could' take a reference on the
head page before the pages are made into a hugetlb page.  Once the pages
becomes a hugetlb page (PageHuge() true), then only hugetlb specific
code should be modifying the ref count.  So, it seems the 'race window'
is from the time the pages are returned from a low level allocator until
the time the pages become a hugetlb page.  Does that sound correct?

If we want to check for and handle such a race, we would need to do so
in prep_new_huge_page.  After setting the descructor we would need to
check for an increased ref count (> 1).  Not sure if we would need a
memory barrier or some other type synchronization for this?  This of
course means that prep_new_huge_page could return an error, and we would
need to deal with that in all callers.

I went back and looked at those lines in gather_surplus_pages

		zeroed = put_page_testzero(page);
		VM_BUG_ON_PAGE(!zeroed, page);
		enqueue_huge_page(h, page);

They were first added as part of alloc_buddy_huge_page with commit
2668db9111bb - hugetlb: correct page count for surplus huge pages.
It appears the reason for the VM_BUG_ON is because prior hugetlb code
forgot to account for the ref count provided by the buddy allocator.
The VM_BUG_ON may have been added mostly as a sanity check for hugetlb
ref count management.

I wonder if we have ever hit that VM_BUG_ON in the 13 years it has been
in the code?  I know you recently spotted the potential race with memory
error handling and Naoya fixed up the memory error code.

I'm OK with modifying prep_new_huge_page, but it is going to be a bit
messy (like this patch).  I wonder if there are other less intrusive
ways to address this potential issue?
-- 
Mike Kravetz
