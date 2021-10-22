Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93200437DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhJVTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:08:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234180AbhJVTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:08:25 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MI1L9Y027916;
        Fri, 22 Oct 2021 19:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B3vksbmqLnuLOMQIZ2gsGxTMgTm093B4DGpiMer4Jfo=;
 b=DymGFe++uFC9gWhywv4ZZNhA292F1UxyZ2WCMyYWJfZUp72ZFm3ObFUiMt0OmNm6qgci
 XpE05jUhbwf0LhT6Posjo+UxKKypmEgfWvDR725iCPQFng+5+4Kdo2G3y3ShqCUcDUSV
 XJVyBzphIwlLWj1YGqg69YWylbd4fIClLPfpbU00euyPC7nvNbiUBm25xcy8eygblLJ8
 FW3BT7NjGAnPNDKrW6LjJOWn2m+ph5Mh5IplGR+hJwhGkZufgg1YDGxEbCRTrCHO18ic
 CaEp6VedqLOz2uOKWG2+kSnabEAYyqcOR56cMCRL4PmOHeqjzsmu5hMeTXBAG8D1gHu5 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3buta8axvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 19:05:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MIphLE049902;
        Fri, 22 Oct 2021 19:05:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 3br8gyd027-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 19:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIbjXG4zACWJZTBrT/EYOVLlHG2q5CIoe9hqFnIaDU8EdLQgW63DbKmOd3HYMtNhkqvsYO1HdYJfEUxC0ifSf8TxQ+4bkttWq4+uxMzCRc/38SZ7rLmnjtjDZpHVCZt2EG4os950P/zsEYrM0Obz0d7udd9Xl8hbuS8AYgOiLeJrjdP1rlLL8FEq/uxSGMYsWhRv0rDw60pizeF0QJ+FpCKe5elJs5/71V3zD+b4ffqDDmT14QqomolKVP6/HUQAHVvRjrsDxL93MuTBXZnZReuhxNplHHZrjLjvHQqpmLkcw4y8MC0ve8YTJsbMOqneh4KHZEzhIybmB2ep9BSkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3vksbmqLnuLOMQIZ2gsGxTMgTm093B4DGpiMer4Jfo=;
 b=ThohQt181bVByOYTAZF5q/wpnCOqd43gXC9kBaazY7Y9eIbv04rmMgmS8rwW5hDXvtD2EWQl7efTmrGXpIbzX3CdAwcAiC8hTWdyGgEwcwyBNsw8LM0zCEQLP5+bu9LG7v+u+axAJNq2UKR6D9IOzTV807mWyHsaRkJ0IFKz+/Q+jnackRplDhQu+HFrsdggPgmLrkZ5OLPEMoGlOdat3d9GWWO5eszdmMwawOhOIrsMNWu6BzCX2N2A183VzCA9J6fmfNoRmqbWMs18foKOPNGqU44FBu+z/H3o5dVrWd9z8J+J1i5Z5CQ/zJF50J4nYmUedAUcaIh6mg9J1CrkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3vksbmqLnuLOMQIZ2gsGxTMgTm093B4DGpiMer4Jfo=;
 b=p1E91mVgNIWEElHKxk25d3xi3/JBjaFFI87kzRBAw7GV0ZliudZXyDidgEoBY5EfMKig6aUj2qs44RjztJXK5xTg4ah91xSqnpxk6uVTpK/XbxmI4DQa+EdJCbfOR8Wa3s86JgHXcL8toG7XEcjNlM+3LoISp31wue79Jp62szk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3303.namprd10.prod.outlook.com (2603:10b6:a03:153::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 19:05:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 19:05:49 +0000
Subject: Re: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-5-mike.kravetz@oracle.com>
 <20211018075851.GB11960@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ddd1a08f-8001-c844-5734-16476ce34d5f@oracle.com>
Date:   Fri, 22 Oct 2021 12:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211018075851.GB11960@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:300:94::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR19CA0069.namprd19.prod.outlook.com (2603:10b6:300:94::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 19:05:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5a88d3-65fa-4648-bffb-08d9958ef5c5
X-MS-TrafficTypeDiagnostic: BYAPR10MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33034026A0ACB90097F00B26E2809@BYAPR10MB3303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCvqU2hvmM6WRZoMA2K2dK7LU7rvIK2j0HOss/foNwj2fhQJnFbsV2riKwrHtbM0tf8JIBNu2FJW1T8/BFq6pCtV2RRXBwhTsxmZ7BJQaRKj8l4XYFhlh2XdrW2m98bDpy3GHuIfP6n/egmwodNtTSw9cRtdQTFR1NGhJqlXcrrIAl50eY/hy4md7iuPORgrUeyBgLfn/PnRFWjwkFD1tmsOF5+sLMSWSNVSb11EudR6rQYZJNsYoIyG9K+458ZnXT9XsTd1e7RL6j4aZOVjmVFWea2tz0KuvPyyLi/0XmyouwD22HKVJml71zsE0T1DstKKOpktmhG9Vy5ORgEoTk7TC4BHS9IxlySbC+pI82fPJhi39Yc6d/rxV7R0f4ezXf/zAeZc3fItR731bNRsB7oyx8W3Zrf7IFbcSp9oodws/68P8bdX7gVDqJjTCR2PQF+YVFUqlnIvjS1hcYtQa/pafOLSUnXQqlCwuxNgSIOAR9VOIGp9pY5cMHPxXxrlJ4hobzZOB7KuoApneYN7nisCYZ2cQxzWLCIw3ddbFffwAqSA6Hes22GA660McMaWPP3x9OdWM2vN5rPER7YlfPbuqGst/nnAOUBc/CLM3zb08Nx2xohHX6uk4crYFa7g2o7AhqCBV6bJk4+2ReqHqiNnOeLX+hu9DEjML1gBGlMicTdNxVuUl2s0+mPBqASaH4LhpJHeQHPvvDcDmnNKxzInhPo9mxfbFRDaXRLqZKlmeyDjX+mic46TkAtxOYRVPZRwVMUdn/VsuWmUdxeQ2tfAbLCZwucrioaFkDPLywSRDePn1OBrd4P/KHjEodqYY00dChEMbMAxJFPyz46sUGDiQzBCS+t+ZOg4o6yrZrZ66RrMCIeLdBGurot0n567y8p27f9TezQz8NyaEU/u+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(38350700002)(966005)(38100700002)(508600001)(83380400001)(8936002)(2906002)(316002)(66946007)(54906003)(66556008)(5660300002)(53546011)(16576012)(8676002)(26005)(2616005)(6486002)(66476007)(956004)(31686004)(52116002)(44832011)(86362001)(7416002)(36756003)(4326008)(31696002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJmZFFlcWp4V0xnQXU5SGpVWnZoOWtHTkdkeUpZN1hicXllNi9VUHpheUUz?=
 =?utf-8?B?cmRBYWpua1YzcmVSOHMzZHNQUlRaQlVlQWhwMUtrRmp5ZTFtdWg1N1pmeVVx?=
 =?utf-8?B?TTBxWk1sVzIxbTI0N0pINEVoQlVTN3pGZ3hPM2FnVXR5dzhVRHN3SFJwNDJH?=
 =?utf-8?B?SUVwSWJGVFVQY3gyZXVtdnAzdUZoSmNRVkpraWdZUVdvTkdjNHY2SHNRbW5F?=
 =?utf-8?B?UGhKc0tCVzYzUHpLSTErSzVBUDdLRWI1T3JNKzJWQ2tENm1MVUlSbVBJTm9D?=
 =?utf-8?B?amN2R0JrcWVlUTlkbjdRVzBHSTNDV1ZnOUdqREJ5M3BrUHdydjAvdmpCcStV?=
 =?utf-8?B?ZHVsVGZHamNKT1AyblVDTkZ3VjU4TzlZMS9reUFGUjBSOEdPK2JKb0kzVWhD?=
 =?utf-8?B?OGJpRVdoYXQ3bDZXdUxTUDR6NURlbXZXUHRpUjcxbGRYL2VIR29oRkJWMFlT?=
 =?utf-8?B?VDJDaERJTzVnWlBUbFdQOVg1OEdIZGdZaWNIRVFmRDl4TEdoOFFzcmVCL1lp?=
 =?utf-8?B?MFNDSk9YZ3doR0pwK2dxRVMyeFAwT0VqRFNxT3d5YjRBNFY1Q3lqdCtRTUpw?=
 =?utf-8?B?d29iKzJ2VW9QVm44RUkwUkIycFZjd2twWkJ0aitPNG9ibEF1MmE3NHJ3OHd6?=
 =?utf-8?B?S3l1Sk5Ga0FFS0RmWDhOYXByQWswUlhwL1V4RzluSG82V0hiQUZqalRmREV3?=
 =?utf-8?B?Si9BOHA4WWV3SkhQYVVRcVU5MEVkS3V0NmFIR0RhMHFKL2RNVTdpNCtoMEJt?=
 =?utf-8?B?OUgvY1BhRFhTUGdyNnh4aUI0L3MySThXK1ArZWRGb1VGZ3NRbHZEUGFTdTIv?=
 =?utf-8?B?bmMrSjJBT2h5dzlGbDdabVJleVM4dDVtYjcvdVNQZmsvL2xJQncxSkgrZ2ZK?=
 =?utf-8?B?NWF5dTZ0M3cvdXdDZ3dLMS9FMENYV2lLNjViQ2V6aUsyb25sRWpSSkJZVWZ3?=
 =?utf-8?B?OFBjV0ZqMityK0dxVmY2RmtRalNNb1VyVEFSNk51ZnY0cHVzL0lkcVRiTFNV?=
 =?utf-8?B?UlNoZ3UvdE42R01nWEo3MEVYREttK3lnck5rL3AwT1pSU3ZLZGYwU29sYksr?=
 =?utf-8?B?L1RNbEJ0NzJuOEt3d0dsUXpLWSszcGZxckVyTjMvcGxjR016Zm1vNHVaYVUz?=
 =?utf-8?B?NmtyUE9FdU85cndDZFV1TW1IbmVWdW5hb240d2hWZGtNeCtETFlIZW1SS3lE?=
 =?utf-8?B?NTl4OEY5WkhjaW1PYXZwVU4zT3NZTWNrcTBmZUg4WUhtWkRudjNmN0orMm1r?=
 =?utf-8?B?UlFWNEFnTnN0REs5L0VnSi9OeTd0UkxRc3JXTnZBRDNCN3pjakNnTDZqYUQ5?=
 =?utf-8?B?OUtJc1BkUzBvUTA4c2JPTTd3SlY4ZGN2aXZwT09yUWdBSEdVTEY3citSVDQr?=
 =?utf-8?B?RzBXNjF2Nzg5TlNkazRnTDBJNWQvdU5PemJXY3lac0FCM0cxT0N3RUxGaHYr?=
 =?utf-8?B?ejlabyszeUllZ1dLYlMvcytTblE0STBLb2pxNjl5U1RFOXdHbTF3dGxFZklH?=
 =?utf-8?B?L1RqYWpWZFJMM1JQcERHanlnNlk2OUs4enkwcEs0ZXE3eUZ0aDl4UTZJRHdI?=
 =?utf-8?B?dkhLYUs2aG1VWCtNYnZ5a0FBTGRCcEI4VEwwYmphVVQvbWhyckt0RzBjZ2JH?=
 =?utf-8?B?RmZwQURwY24wbHlCZWlpdGtoSEZoVnFjNjVQTU9yMFNqRUFKOVdKVWV1S0ti?=
 =?utf-8?B?dnU4K2dubzZCcnEyb2c2RkQ1c2hVbEZocjY4T2tSTktiNTVjdENFZVc5UEZy?=
 =?utf-8?B?OGVJRWM2YjlqdGkwSlNDYy82RDdZK3FsRml1UEs4Skd2d3JTMXJTSGNMaWh2?=
 =?utf-8?B?U2NMa2FmSTgxOFV4SWRKQzZNREFLZEkvTnRoRmpGZHc3aWU3RlBQcFI0c1Fk?=
 =?utf-8?B?T3lkSWlDS2pOSFBPRmNCYkdBdGduaW9ta3FKWnU1ejNxUGdpZ2NyZmVRTTA5?=
 =?utf-8?Q?3rftIQDBqwL8PBB0btbMBjXhMncZg+g4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5a88d3-65fa-4648-bffb-08d9958ef5c5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 19:05:49.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3303
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220107
X-Proofpoint-GUID: aukRwU709phMj4XgX6KiCFQjHdtCpUq3
X-Proofpoint-ORIG-GUID: aukRwU709phMj4XgX6KiCFQjHdtCpUq3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 12:58 AM, Oscar Salvador wrote:
> On Thu, Oct 07, 2021 at 11:19:17AM -0700, Mike Kravetz wrote:
>> The routines remove_hugetlb_page and destroy_compound_gigantic_page
>> will remove a gigantic page and make the set of base pages ready to be
>> returned to a lower level allocator.  In the process of doing this, they
>> make all base pages reference counted.
>>
>> The routine prep_compound_gigantic_page creates a gigantic page from a
>> set of base pages.  It assumes that all these base pages are reference
>> counted.
>>
>> During demotion, a gigantic page will be split into huge pages of a
>> smaller size.  This logically involves use of the routines,
>> remove_hugetlb_page, and destroy_compound_gigantic_page followed by
>> prep_compound*_page for each smaller huge page.
>>
>> When pages are reference counted (ref count >= 0), additional
>> speculative ref counts could be taken.  This could result in errors
> 
> It would be great to learn about those cases involving speculative ref counts.
> 

How about if this commit message provides links to previous commits
describing these issues?  There are pretty extensive descriptions in
those previous commits, so no need to repeat here IMO.

The patch with an updated commit message is below.

From 10fcff70c809402901a93ea507d5506c87a8227d Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 22 Oct 2021 11:50:31 -0700
Subject: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines

The routines remove_hugetlb_page and destroy_compound_gigantic_page
will remove a gigantic page and make the set of base pages ready to be
returned to a lower level allocator.  In the process of doing this, they
make all base pages reference counted.

The routine prep_compound_gigantic_page creates a gigantic page from a
set of base pages.  It assumes that all these base pages are reference
counted.

During demotion, a gigantic page will be split into huge pages of a
smaller size.  This logically involves use of the routines,
remove_hugetlb_page, and destroy_compound_gigantic_page followed by
prep_compound*_page for each smaller huge page.

When pages are reference counted (ref count >= 0), additional
speculative ref counts could be taken as described in previous
commits [1] and [2].  This could result in errors while demoting
a huge page.  Quite a bit of code would need to be created to
handle all possible issues.

Instead of dealing with the possibility of speculative ref counts, avoid
the possibility by keeping ref counts at zero during the demote process.
Add a boolean 'demote' to the routines remove_hugetlb_page,
destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
boolean is set, the remove and destroy routines will not reference count
pages and the prep routine will not expect reference counted pages.

'*_for_demote' wrappers of the routines will be added in a subsequent
patch where this functionality is used.

[1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
[2] https://lore.kernel.org/linux-mm/20210809184832.18342-3-mike.kravetz@oracle.com/
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 21a9c353c2ae..bb724a393864 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1271,8 +1271,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
+static void __destroy_compound_gigantic_page(struct page *page,
+					unsigned int order, bool demote)
 {
 	int i;
 	int nr_pages = 1 << order;
@@ -1284,7 +1284,8 @@ static void destroy_compound_gigantic_page(struct page *page,
 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		p->mapping = NULL;
 		clear_compound_head(p);
-		set_page_refcounted(p);
+		if (!demote)
+			set_page_refcounted(p);
 	}
 
 	set_compound_order(page, 0);
@@ -1292,6 +1293,12 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_gigantic_page(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, false);
+}
+
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
@@ -1364,12 +1371,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
 /*
  * Remove hugetlb page from lists, and update dtor so that page appears
- * as just a compound page.  A reference is held on the page.
+ * as just a compound page.
+ *
+ * A reference is held on the page, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
-							bool adjust_surplus)
+static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus,
+							bool demote)
 {
 	int nid = page_to_nid(page);
 
@@ -1407,8 +1417,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	 *
 	 * This handles the case where more than one ref is held when and
 	 * after update_and_free_page is called.
+	 *
+	 * In the case of demote we do not ref count the page as it will soon
+	 * be turned into a page of smaller size.
 	 */
-	set_page_refcounted(page);
+	if (!demote)
+		set_page_refcounted(page);
 	if (hstate_is_gigantic(h))
 		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	else
@@ -1418,6 +1432,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
+static void remove_hugetlb_page(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, false);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1681,7 +1701,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
+								bool demote)
 {
 	int i, j;
 	int nr_pages = 1 << order;
@@ -1719,10 +1740,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 		 * the set of pages can not be converted to a gigantic page.
 		 * The caller who allocated the pages should then discard the
 		 * pages using the appropriate free interface.
+		 *
+		 * In the case of demote, the ref count will be zero.
 		 */
-		if (!page_ref_freeze(p, 1)) {
-			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
-			goto out_error;
+		if (!demote) {
+			if (!page_ref_freeze(p, 1)) {
+				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
+				goto out_error;
+			}
+		} else {
+			VM_BUG_ON_PAGE(page_count(p), p);
 		}
 		set_page_count(p, 0);
 		set_compound_head(p, page);
@@ -1747,6 +1774,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return false;
 }
 
+static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, false);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
-- 
2.31.1

