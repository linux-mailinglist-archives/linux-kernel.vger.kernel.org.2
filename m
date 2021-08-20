Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4A3F35CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbhHTVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:01:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232210AbhHTVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:01:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KKvMcS004681;
        Fri, 20 Aug 2021 21:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3EmYZUiWlhq8mfcKsXyr5iZIOiF7o5oDJ5gU4E54Vwk=;
 b=AwAU3805IWdpVbPLj5xDehSGMDMU9I5ik2MpmdJJjdK1SpwzXC8km2jfnKwwHmHQW/DF
 RoNJr8bxiX+Lsow7DNc7benXE0++1YbtKvRQk999CGzUQrkrRYQac47TQHwXwqkJMjrD
 /WM44jGxdJ0015A2GVz1imJrffEs7OiSowETsoxLpvd4fhmJb/giKP6IylyL2KW2lq1B
 oWzsIHP4UI9v4ao+RlcgK54nxGarLugfBFq5eLSpEiqPo4AaTt6ZB+DeII4cLwZcWAli
 TF+pvqIo14YfrB8SfPrJsY0GG/hRsNK1I+HKJ19UaV3AapYSiDvB1fAtBz8t1G6hulUC pQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3EmYZUiWlhq8mfcKsXyr5iZIOiF7o5oDJ5gU4E54Vwk=;
 b=Iwjy//ULqvCrpuy+8mypWWn7K2I5xTJ6uVfgYcTLh+USDHhdS6e8vBYJBvnDYOgY4TTo
 SM9Ct4Cx88pDjOwHmKrOGAiz89/9kI5hBM/9MuCGLW1W1z9TTf/IqdcyV1niYwc96Pui
 EJx74vA7+GBc56rlOjzo7YodZy9Oop69zMa1i7WJOXArOCe219eZJN5RvAdvWMkVZZgG
 XlrqOkCsRGtdl9lHuGFOFVTQvo6TYoVqRa9LELa/07p1YH+fZ5o1wUPqGGQ2BHDxycCJ
 hmKvWYlwRJ6Qs+KwjSYWGOruFu7vSO7CE7ITFcTr/6YM4Xc/e6iWgDQjYpAHfh+vWtJF tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs5ckj8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 21:00:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KKt9CB172539;
        Fri, 20 Aug 2021 21:00:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3ae3vp7ycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 21:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6thk0SSwL0aLlglGWh/JouCzNTEoOIo5LJjQvetIHlS9kVz2C2dEBEyrCy6JWFzyLi3XL6DfqS/Y7jQo3LHaRn3fiQx/j+86O5LpxjUJ/Lx0Hcs+tU1mDmiiDhdo4cLXfwRIx21akOQ7+yDDbFTdeqe2HI0z4yvrYNOaRx5G3vrmrHfxKsYIRCD93FSP2dIAiTkvOTBOzbif3RyF4xrF4fBJAE0hCpDWtcKSztorEUy4BzkVW8jY//kZYACeBs7qxOKHXLXkOwa1MGaVwUBnvT+G/VtAaWG743uIEabfH0wCcn9czeqzQ1cn+rLcsfjB28MPyKoMk6JoiSPGGvnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EmYZUiWlhq8mfcKsXyr5iZIOiF7o5oDJ5gU4E54Vwk=;
 b=NPGX+K0+862xIdLGvObWDyqpkX4GRbT/MlWICvdeK5ncxGXXAHPnn4uz3vynNBpEGwW1m0JHIOrIePWgLPPiANqye7x/z0Vsc3RNZ7kKG8Zq0nToYKWXejUKW5PvY9R6J6xzc3hlnlRAgNezlMmq+vq/DhLZ+bFXQe4PVP7kaFSd8Ba6JFSHL+lxKlaegMeBz3J06Zc9uZ3Y6uVV+7vVa+GVD702R3Jqmr5KACFSe3oystniiWeciuj2hAfJTdAjte+ndRDEcBwu3QYzPZcvQtJgGHSdv1a1R8Gamg63FdDEDdAIvT9Um+7flIM+m7f8HiV1kQF8u7iK4llQVeEvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EmYZUiWlhq8mfcKsXyr5iZIOiF7o5oDJ5gU4E54Vwk=;
 b=ITTAiqAtvtIgA6ZnAo5WF3z3w4DAO4p2NHhMKNM5kZ4MEzCMuqkdD7G3DH8MOSuuPBplT6086HHjGS4t2ux8NRpv83cVT3Wn4TIdn9/gcb3t2iMZply6gxn1wgAnzATA06z1O9chUNfRrZ9/xeyJIPZ7/v08/A8gNtPlt/T9Dlc=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 21:00:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 21:00:56 +0000
Subject: Re: [PATCH v2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
References: <20210811011056.770351-1-almasrymina@google.com>
 <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com>
 <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <49043787-853a-75d5-6da3-90529377bb30@oracle.com>
Date:   Fri, 20 Aug 2021 14:00:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 21:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccafe13c-38aa-4106-cc86-08d9641d9a8e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR10MB316097333D192F44239E74D7E2C19@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRxt5ufXDWtWLqdoX8jIOwwi+YDf1/QgqMLoKPbByNj4hmllBcylBPcA9+vAMJDkCQggL14mIx4DRj2SCQ3SqaxmhEomd2UyqqpVBv9l/k03RbxbrGf9h9wGhlYBiKd+T/qSVFtIjsIZFW5W/eNj/fiYwaQhO4GVF6U09bjg9PFXX4ZO1MSuW0YOLYqoPgRhHh8BoeHKyUqtaoO9Va8bb/Xj0Gr+MF1wzDhiD1GVF54c4bdqKjZZ7xD1V8J3VZqa1o4W1ZtP7+81rAqo+lIJbGDYtj253SrlzgNs/Zv0xLIGATFZZlZHpSD3pOMDYiW/TD3iTa1bJzms6vbE85qMI64JAjsF3DleOJbnuKiQGE/Y3DOq84beLSJ5uqjHz1uixor7ua3ZC2i000erqIGi/2P6nAYO5++M7V2NANG/lp7y7IqDnUlxfm5Hb4ouEzgtQVwmoTBVWdk3yefMU7T5UMuWr+t7eJTstidECpt1poZBJsIyODfIWJpEcZnQ9sMDN9ZIwMkoMDV8XRXGVq6Lmmsd0CuVgIXLLwAyjv5hCzcCT/m7WowuYiLDSxEGSYMzcMJEtidVUdCjkb2XxKOJ9yVkVGsEiUXyXor065kvjJXNiuDdXqzlboWwU8dfelcjK3OENxQypMXOmaHJV7xJu23xFQkjZ40C4axUy1O1MyC6FfPNw/bU6NSpGzZyWHl2Ouoqq/eus/GsEW5qv6j+iR+pNNojHH15Ni7vQ387GA7cxm880SH+C9XQHdg6CGX7VgFS4MPmBLppFN0kQB5/FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(66476007)(66946007)(5660300002)(478600001)(66556008)(8676002)(8936002)(6486002)(53546011)(2906002)(186003)(4326008)(83380400001)(36756003)(54906003)(38100700002)(2616005)(44832011)(31696002)(38350700002)(316002)(86362001)(956004)(26005)(6916009)(31686004)(16576012)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2J5WVhVN2gyQjB0V3JOUkJSU0VPU3lid3FaSEJPRDB4bFZ1Mmp1TFNYOXJr?=
 =?utf-8?B?Rmpkczd0bTk5NVZYY25YaUdUTDFTeWJJTUZsbWlwdTVlR1pKTE55dGdpaDhR?=
 =?utf-8?B?UGx2c1RQTzVJeVNzM0hjT3FFcElhUS84a1RWRWl3ajhHZWhPak1iNnhVVVlS?=
 =?utf-8?B?akFCbUN6a0ZKd05sWGZjM0VDM3NzMUJpV0Uxb0xzbko0NmpkVTNXTDlvemRU?=
 =?utf-8?B?TmdEUDVUdGs4Y2NVa2xDb2tlRXZxWXZ3Ty95ako2ZHQ4aHRkS0toVjIrNUpW?=
 =?utf-8?B?bjU1TWZ0MTV4NWtweEdxS0doTEd6OS9FMDVHbkRaZm5Nd1RTQm1sREV6NHUr?=
 =?utf-8?B?SGcya1dSSWdIQURLTWRBakJsUC9XeFlrOTZVdlNjYVFiTkdSTmNHcDRxOHBj?=
 =?utf-8?B?RFRnKzQ0a1pLKy93WkxHU0IxUzEyNmFqRGNQUmJ0ZDh0T2FCSUdHUTNhVFZX?=
 =?utf-8?B?Q3FwajhrdXc4N2t2SEFqeWZ5V3BVMklUS0x1eHE0NTlkZGRxVExNa1d5SUNT?=
 =?utf-8?B?VTIra2NnY09jN0tadldERDRzSFpHY1ByaG1yOVpudXJGNFAzWWZzVDgyejQ2?=
 =?utf-8?B?d1ZIVXhQVnhDKzRvc3g3TXFvd3VFbUtreWR0aXN6S25jaU94QzFhYjBRRGFm?=
 =?utf-8?B?ZzVGNHM0Tm9uaCtIeEVKVVo5TllLNkQvbFpIY2JCMzA5SEhIczlJWStadTRG?=
 =?utf-8?B?QmZ4bDhaL1VNcW05RHhkQTJlanpsMkNOcFNRSXhNcUZSQXRRdW9CR1R5UGdp?=
 =?utf-8?B?UmtRTEJnMWM4VGlUYXRQeE5zWUpoaURVaWExL1pXblVHSjFmRGx4T1ZOUHRy?=
 =?utf-8?B?QS9MN29MT2RMMUJOb1VmdmJ0QXRGYTVOL3FvSHdnSUFRVEFyNGl4a3AwcVBB?=
 =?utf-8?B?Y0IvcEgyZ0Z4V25iUUY3N2dhT2NBWVhWMncvdGFkSkN6S3dBalY0ZSt0ajFD?=
 =?utf-8?B?TnFoQ0FIYVZ2QWQ2WHRicjJmbnRjcDByUVlzWUx3QmJxdUo5dCs5K0F1Z0Ft?=
 =?utf-8?B?MnFlOHc5T09Yd1R6azlPZXN4d2MyNlJEVW14QUNjRjVrU3FOSlZxd1d4RkQw?=
 =?utf-8?B?ZThsaTVEMklaNjMrWXFtOG4yNWlvVjlOem45Q29DeVBzR3Bya0lCN091Vmxu?=
 =?utf-8?B?dHd1VXFBSkhmdHg1SlF5UDU0SXNSMDAzNFJWY3d3Wi9JLzZublZwN1lEWmRm?=
 =?utf-8?B?dldHbWU4WU5pM1JQMWRGOCtrTk81N3g2b1BjSXpNcE1CVEZlMXQyemVIckV1?=
 =?utf-8?B?SGRrQ3RQRHpQR2xjWWhIV2xGeXI5U0V5LzY2ODM0MnVrRXhGVGVFYzZWbytV?=
 =?utf-8?B?dVhKekZQcFF1L2JseUY2b1RqbjI0cVpoT1BwUG0vY1cxNFJjN1hIQVVnMEg0?=
 =?utf-8?B?VnpsVTJrS2RqYUd0a3J5bUNLZDI2eFJJOCtvNDRVejBHQjgwRGovTjllSmVE?=
 =?utf-8?B?b2ZucGpHLzVaWU45c0JVWCtSeDVNdGVtMllVL2ZTa0JOYXF2bi8vVjViZUFy?=
 =?utf-8?B?c1hOUHdiYkF0aTU2eWlwaE8zRm9kV0xraWJxbFYxZk1nWEZhZ21NM28wOFBh?=
 =?utf-8?B?MWM3TW8rMnRQUXZPY1R0RUZaSzZvWG9teWZrWnc2L1BxKzBGTFpFN0h1dVZh?=
 =?utf-8?B?cStobldaSDI0d3RtYjVLVmgvbnBJS1hPanUyMnNlNTNUdGE0SktsZHRaM1FB?=
 =?utf-8?B?VFdiUDUxbzhGbERETHVNRzZsVzlhVEo4SlVtOHBoY3RxYU1sQ1ZvSlZuUk5i?=
 =?utf-8?Q?iLWkE6UuDl/CufT6LKh1sPYqOsaTwyvA7q97Q3y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccafe13c-38aa-4106-cc86-08d9641d9a8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 21:00:56.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug4Dnd//aX7+i6vadJI0al7YzDVmPtdw7K5GwKqphNHusdEZS3vQYyh0oFuyjwt/3eWd+6baFm7NwlcnN9JOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10082 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200117
X-Proofpoint-ORIG-GUID: IouAi8KRqs2kgt7SGh0VetbLxzW_y7kC
X-Proofpoint-GUID: IouAi8KRqs2kgt7SGh0VetbLxzW_y7kC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 4:35 PM, Mina Almasry wrote:
> On Fri, Aug 13, 2021 at 4:40 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> Earlier in mremap code, this following lines exist:
>>
>>         old_len = PAGE_ALIGN(old_len);
>>         new_len = PAGE_ALIGN(new_len);
>>
>> So, the passed length values are page aligned.  This allows 'sloppy'
>> values to be passed by users.
>>
>> Should we do the same for hugetlb mappings?  In mmap we have different
>> requirements for hugetlb mappings:
>>
>> " Huge page (Huge TLB) mappings
>>        For mappings that employ huge pages, the requirements for the arguments
>>        of  mmap()  and munmap() differ somewhat from the requirements for map‐
>>        pings that use the native system page size.
>>
>>        For mmap(), offset must be a multiple of the underlying huge page size.
>>        The system automatically aligns length to be a multiple of the underly‐
>>        ing huge page size.
>>
>>        For munmap(), addr and length must both be a multiple of the underlying
>>        huge page size.
>> "
>>
>> I actually wish arguments for hugetlb mappings would be treated the same
>> as for base page size mappings.  We can not change mmap as legacy code
>> may depend on the different requirements.  Since mremap for hugetlb is
>> new, should we treat arguments for hugetlb mappings the same as for base
>> pages (align to huge page boundary)?  My vote is yes, but it would be
>> good to get other opinions.
>>
>> If we do not align for hugetlb mappings as we do for base page mappings,
>> then this will also need to be documented.
>>
>> Another question,
>> Should we possibly check addr and new_addr alignment here as well?
>> addr has been previously checked for PAGE alignment and new_addr is
>> checked for PAGE alignment at the beginning of mremap_to().
>>
> 
> I'll yield to whatever you decide here because I reckon you have much
> more experience and better judgement here. But my thoughts:
> 
> 'Sane' usage of mremap() is something like:
> 1. mmap() a hugetlbfs vma.
> 2. Pass the vma received from step (1) to mremap() to remap it to a
> different location.
> 
> I don't know if there is another usage pattern I need to worry about
> but given the above, old_addr and old_len will be hugepage aligned
> already since they are values returned by the previous mmap() call
> which aligns them, no? So, I think aligning old_addr and old_len to
> the hugepage boundary is fine.
> 
> With this support we don't allow mremap() expansion. In my use case
> old_len==new_len acutally. I think it's fine to also align new_len to
> the hugepage boundary
> 
> I already have this code that errors out if the lengths are not aligned:
> 
> if (old_len & ~huge_page_mask(h) || new_len & ~huge_page_mask(h))
>     goto out;
> 
> I think aligning new_addr breaks my use case though. In my use case
> new_addr is the start of the text segment in the ELF executable, and I
> don't think that's guaranteed to be anything but page aligned.
> Aligning new_addr seems like it would break my use case.

That is interesting.  I assumed there was hugetlb code written under the
assumption vmas/mappings were always huge page aligned.  I thought the
code would fall over quite quickly if vma was not huge page aligned.

Your use case/statement above surprised me.

So, I took your provided test case (V3 patch)and tried to make destination
address be non-huge page aligned: just page aligned.  In every case, mremap
would fail.  The routine hugetlb_get_unmapped_area() required huge page
alignment.  Not sure how this works for you?

> Aligning new_addr seems like it would break my use case. If you insist
> though I'm happy aligning new_addr in the upstream kernel and not
> doing that in our kernel, but if I'm not particularly happy with the
> hugepage alignment I'd say it is likely future users of hugetlb
> mremap() also won't like the hugepage alignement, but I yield to you
> here.

I am now a bit confused and do not see how this works for your use case?
-- 
Mike Kravetz
