Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE944367F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKBTcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:32:54 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:48480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229616AbhKBTcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h54oh/cNX9zxb5LaDvn7FCrXORFnRJ8vjAWKmfeFOTZPS5CEZ3QeISqUoqeOYOnpXHW06NOqlpv/RsXHipdrsbwWV6yhkdE3SgDJ1Dk4Q+uwFDLbIrZV5qjk0HgIm7HUXOek+YI90K5HpLRb7WatEzEAKhcv3nXZj76jJKu73N3ZH4dZ3p7hgD5nllA2kZGEMyEhbkbifHWq/ku4FscVAKwWlckugTUqrrLB/V+V2g4Zgk6++Sbg+02suH0Oo21nNZNGw2F/C88dfmwJ0/YzMMoRmcvM+hKPN7bvaMCa9XLQFVhDQBRupfokV922s8hwGrJYA9DX+e9GSK+WNfpN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEYeHb5Y2Zq2geRetXrxX/RAt9WcOJrFcjYizZFkf0A=;
 b=Hl4Ax0isVZ8gXYykYdcCURuHsjujU4mve+F7UH0N6V7kImhdhuXt/Iws9XXVOI9+LgAdFnZ8BjCdOWhrzS+2zimurmvijN1iiPQO+EEcfIV95G+4PASeQ1lxhlYe23IcpiUjlQQu8IYey2R5vc4XBEJ+zVRMGosukCb+nz6S3qxlRWkL4cxK531N2zvw/w047oXrFQiTM6FfaKlBMsZDgK3Cyq9i7IRiHofv76jVFW6HLUpfyLkOVA+JPGoQkU5zo1uAhWnHwo2E56IayEElxqHMfUbNLPqf0EdDENxvDmrzJ/lYmQrL87wvZYzcSozkttF7GhQuMIdCn7oQF6Wrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEYeHb5Y2Zq2geRetXrxX/RAt9WcOJrFcjYizZFkf0A=;
 b=bDSP8Kj7Tvj/+iqq4D7FEmoo8qSFC0pj4vXw7j+cWZK9J5J2F/9r3N0bSpuJ1uXI2J9y8poP4FJfBEo5O50xmss9rcJ4f98A/+i2z8sBX+hjNbN5YCDLE2d12TdNeKTrm4iAe65vAqNYWaYs9GYTPwSpuM2qBAMM1zWqfZv0ajO8DD4d1vj7csaHyz6RdB/L4JOKWPHWPtG9Z6nMUV7gVvjLKyDP3KznxKUokqTp8UNQEdGNoTlUaoH2bIsfO/REBxFaEcpAVUfVMu3+wP+6ybYfaj3afK9y3UhbDHH2Fm/W5T1H8dSiBpkeWq/ymQJy1kOZ3BLNaNIAsx9X/8bZ4g==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4800.namprd12.prod.outlook.com (2603:10b6:208:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 19:30:14 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 19:30:14 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: Correct the hugetlb migration stats
Date:   Tue, 02 Nov 2021 15:30:08 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <7E44019D-2A5D-4BA7-B4D5-00D4712F1687@nvidia.com>
In-Reply-To: <7f45b2c8-fd2c-345a-ec6c-43b8b1c06de1@linux.alibaba.com>
References: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
 <677EF981-F33E-4002-AA38-DD669C319284@nvidia.com>
 <29aa9c6e-7191-71bb-d8a3-e2695b18fa3e@linux.alibaba.com>
 <D32BF8D1-E6E0-4535-B8C6-1F05842DB672@nvidia.com>
 <7f45b2c8-fd2c-345a-ec6c-43b8b1c06de1@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3C95D817-0615-4DEF-93FA-6602125788CA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:2d::37) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.57.172] (216.228.112.21) by BL0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:2d::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 19:30:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2237a52c-cafb-4ae4-363b-08d99e37313a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4800:
X-Microsoft-Antispam-PRVS: <MN2PR12MB480071C5DF0892A3303C8F14C28B9@MN2PR12MB4800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPW9+w+PRhkTZCiUpjjDqLclmXFN9Hnu01ISlv1pwTnCFDCM3A9DBvjdIEl314z/R3VZRo13ShL7v8HqJkZe0Ks7DZgxMJU5sGdqBKwMj+44SlUgAYIyVLBy/koOdoVsNsI6LK/bEOG2tVYLnKEmv+mudTKarlM3Q11zIFtZ0TRI53ZlNBQgxqHNGswrnKRnfGy8iCDcTm1a2M5ZqLKCMTD4cmHZ3xfibqMOEDO4JVlBr7oV7EFqGDjNCPB/D5qcqhOPj+J2jwEOhKrmpYHR9Z8odb4hnWBc7cauYORwg5u5Z77fVMF4P/X/ExZczs1G9YTUFI6dnPPV/opQq4dF6GvPx+wuDo0LZ+gNjmN5HmlZSMznof9v9NNMKR9RdLGw3I3Ap/t7cB4WdtKAnRYG8RY8cBkckcgolq8cyyB2l3ENT//KG5f8E8HMW+i7U2QDSV9qvAouwtxRFcAk/k+EygLfW+wDIeT3V6Za56491dzQr69ue8hMQ54e6M8GBh9JtffIbZhjufr5lhtuCcjbqnTeyUxVTav5ItYdEUosbEPPhO/41OzPMfTKHx9SA1K0nFlJVMnCOIIVIDC5NQ0axgjjZ46COCHDf03HhfWsgxm5yWLKC8LxZTi+7oVSNLX8nCX82PlDz+TmvtTF+UmjjsSMXMjBc3V4kyHe3Y9LeNh/g09gP7hJNT8ZmWmf3CsUnFYjhwY2ziE0uCBjPkjUcE/aFGLNdyV4unJuQmKl1nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(235185007)(66946007)(4326008)(33964004)(16576012)(5660300002)(53546011)(26005)(66476007)(66556008)(2906002)(21480400003)(186003)(86362001)(36756003)(956004)(2616005)(6486002)(33656002)(8676002)(508600001)(6666004)(8936002)(6916009)(38100700002)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVc0WVpVMEFYTEFuOTZxeWFURlNVUkdPbXZOTEk4YitrNTVYUXMrRnhtYmJy?=
 =?utf-8?B?VGdDbEpXNElqWHMxeE94T3BLTFh6QVM1STI3YmtTMU9LY00wQTdBY0E5bkxD?=
 =?utf-8?B?dS9vU2hRaVV2d08rNnl2bnh3NTByTkFoVGp5ajBlODlxTmdEaUY4Lzc1cFpM?=
 =?utf-8?B?MVNtaHlaV0U5TWdjNURPRGNyajNacGZBaHVhQS9jdG00MGNySnlRVUxsdUlL?=
 =?utf-8?B?Nm5wb1ZJODZueGVnWkxiaWhuWWlwbDFjRGFua0tZR3YxN3JIeFVBZzcraUtj?=
 =?utf-8?B?c2ViMm5zNkNzMG82SCt6cXV4dzN2Q1JwSFZ5WDlOUy96YUJpdEg0blNseUx3?=
 =?utf-8?B?TEFZUFl6YVVyOXY1WHR2dm5IaThTTkcxNWRrZU1wcFZuM1dtSVZYK3REdWpS?=
 =?utf-8?B?REZRa3kzQ2l1ZXcxcElVVDhEN0lteG9BSkJlNHNYSVpQSzdsT3MyTGh0MFhL?=
 =?utf-8?B?aTZVcFgzRjNJRzRINitvbHk0bDR5MGV0QnVSaUE0bzRvdlllZmdxbW41Vk9u?=
 =?utf-8?B?ZHMrUEJ4L3N2VXRqZ296dUV3ZHI1alZBUGhlamkvenNKbnkwb0MxTmQ0R2Ez?=
 =?utf-8?B?cHRHa20weWpjSVpTUHlmZXAxS2VSL1ZzNWNwZEZET3NZY1drcHBHK0doY1Qx?=
 =?utf-8?B?NEFmL1VrdHlhVWJmUXIyV1N1QS9Ua1VIVE84TkxrOEhDaXYzd3dZV3pCRmdh?=
 =?utf-8?B?ZEZDZGRVREsycVBwR1VrYmRXV0NUcHNXeXRPNE5mYkVXcFNjcUJSdjJSaW9Q?=
 =?utf-8?B?a3R1cXlXN0NLV3RWbm9iRk9YT1VYSUg5bFBCZDJ5dlI2bVBDU0ZtVERlSnhF?=
 =?utf-8?B?RzdzMTIrSFQwM0V2THF0aGh5WDgzQU1mT1JWYk5ESXdJeUpNUXp6dGsvK3ZQ?=
 =?utf-8?B?eTlpR3hpeDdMY2lFTFJ5Z2poOXJSR21aemdBdklLajJRZW54SGRmUGhQWkRV?=
 =?utf-8?B?dHRnYi84eHNOSmJRUHNkaTd0andVS0VoODJxNER6KytIcjg5YUpuOVZxUVZZ?=
 =?utf-8?B?Q0ViNlN3cmJ5czd6QmxUUWNJMEFKRWJKMHMxajBEemVTTVZQcDZVcG00Mmda?=
 =?utf-8?B?NjNaWGZpVUc3ZG50YmM0YTBvcXZqaTM4UlNjVkpxNlFSQlltU1VqNUdhcnBv?=
 =?utf-8?B?MUYxb3JaMnd4UytKVmdkS2gwOFpiczRna0sxVFJYdjZDdXdtZFVrWjZIaEl4?=
 =?utf-8?B?QnFvTXE3bTV6RG5xQW1WVkNJK3R5Y2ZpalZGaDREZUxXdmxwTlJDY2JjTXhX?=
 =?utf-8?B?RE1sQlN4NVdqQnlMREZiNCtBZUo3djhkSGUxNVRjRk9MQnQwNnZvOFd5NDQr?=
 =?utf-8?B?bERVbW9WbzlPbUtDYXNhcm9mZFJaRGw2TVRDTDlFUTZ3Tjg0eWtMMWhXbDNk?=
 =?utf-8?B?T2F3bHY4b2RKZFA1bzJHVS93c0tYWXB4WGh2dTF3Q3dkOWQ4VDBjQmtyQXRF?=
 =?utf-8?B?dzRJdVJlcFpzcC9nTlNyTTUwSEhHS3VwZllWODk0TjFNUzgrdTB6RUVRdDda?=
 =?utf-8?B?aSsyblh1cmVOUmVKZ3YxZktBR2tQS1pPdTl4SGM4Vms3emVIV1NKTE1XYlpT?=
 =?utf-8?B?dEhOZTRoNmJjVDJSUWtMN3JDWXFQNWFZVmQwT0ZpNnRiTmRRbXBpNjAwWHhF?=
 =?utf-8?B?YlBCNFVtdmZJNDZHbVo3WlkxMWtmd3NiUEhESHQzRWwreE15UVk0QWFHZjVB?=
 =?utf-8?B?MTF4bjZuZHRwQ2ZjbTNOcCtvWlRjam5hRTJPTXdOdDBlZnFXSWl3NU42V0Qw?=
 =?utf-8?B?cmR4Qldlc3ZOb3MwTFRUUkxIbXlqUks2eEVhbVoyVCtKcVp1U2tlNHN2Y1pC?=
 =?utf-8?B?N2JkUWJBc3k1UmtTeEliT1VZTDE1V1V1b2x2eE5jclVGYWUwZ044S0dyZ1Fs?=
 =?utf-8?B?MFRBekloRjVaYVN4cDRyem5DM0dEa2Z3bStOTytmeWpLcnlzL0g0Wk9kRHAv?=
 =?utf-8?B?QzIreEtRQUpXQkt6TVRKSk8yamhpZ1ptaDBsRCtYYVh0NnIyeWtUekd4a2Jx?=
 =?utf-8?B?d2R6V2xPaWd0RDNqaE1iaUZZZkNFSy90YkNUUStTRlYwd0ZzVVEvMnpSQkhk?=
 =?utf-8?B?c0dZbHM2eG9UNk5OVjB4TTczbVRxR0FzZU1RMGZhb1VieTNKZ2tlcm1FdHpy?=
 =?utf-8?Q?WGDc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2237a52c-cafb-4ae4-363b-08d99e37313a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 19:30:14.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCd8JekqezMIuPh67rlNxh6o8IQTo2JcFbCJ0+K65tUXX7dvaz1u+mfzBXHoK6Ux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3C95D817-0615-4DEF-93FA-6602125788CA_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2 Nov 2021, at 2:08, Baolin Wang wrote:

> On 2021/11/1 23:12, Zi Yan wrote:
>> On 1 Nov 2021, at 2:54, Baolin Wang wrote:
>>
>>> On 2021/10/29 23:43, Zi Yan wrote:
>>>> On 29 Oct 2021, at 3:42, Baolin Wang wrote:
>>>>
>>>>> Now hugetlb migration is also available for some scenarios, such as=

>>>>> soft offling or memory compaction. So we should correct the migrati=
on
>>>>
>>>> hugetlb migration is available at the time if (PageHuge(page)) branc=
h
>>>> is added. I am not sure what is new here.
>>>
>>> No new things actually, sorry for confusing and will update the commi=
t message in next version.
>>>
>>>>
>>>>> stats for hugetlb with using compound_nr() instead of thp_nr_pages(=
)
>>>>> to get the number of pages.
>>>>
>>>> nr_failed records the number of pages, not subpages. It is returned =
to
>>>
>>> I also think nr_failed should record the number of pages, not the num=
ber of hugetlb, if I understand you correctly.
>>>
>>>> user space when move_pages() syscall is used. After your change,
>>>> if users try to migrate a list of pages including THPs and/or hugetl=
b
>>>> pages and some of THPs and/or hugetlb fail to migrate, move_pages()
>>>> will return a number larger than the number of pages the users tried=

>>>
>>> OK, thanks for pointing out the issue.
>>>
>>> But before my patch, we've already returned the number of pages succe=
ssed or failed for THP migration, instead of the number of THP. That mean=
s if we just move only 1 page by
>>
>> Ah, you are right.
>>
>>> move_pages() and if this page is 2M THP, so move_pages() will return =
512 if failed to migrate, which is larger than the page count specified f=
rom user.
>>>
>>> if (err > 0)
>>> 	err +=3D nr_pages - i - 1;
>>
>> I am not sure this is right for user-space.
>>
>>>
>>> On the other hand, the stats of PGMIGRATE_SUCCESS/PGMIGRATE_FAIL shou=
ld stand for the number of pages, instead of the number of hugetlb. Also =
for hugetlb migration when memory compaction, we've already counted the n=
umber of pages for a hugetlb into cc->nr_migratepages, if the hugetlb mig=
ration failed, the trace stat of compaction will be confusing if we retur=
n the number of hugetlb.
>>>
>>> trace_mm_compaction_migratepages(cc->nr_migratepages, err,           =
                        &cc->migratepages);
>>>
>>> So I think the stats of hugetlb migration should be consistent with T=
HP.
>>
>> It makes sense to me.
>>
>>>
>>>> to migrate. I am not sure this is the change we want. Or at least,
>>>> the comment of migrate_pages() and the manpage of move_pages() need
>>>> to be changed and linux-api mailing list should be cc=E2=80=99d.
>>>
>>> I don't think we should update the comments of migrate_pages(), "Retu=
rns the number of pages that were not migrated" makes sense to me if I un=
derstand correctly.
>>>
>>> For the manpage of move_pages(), as you said, the the returned non-mi=
grate page numbers can be larger than the numbers specified from user if =
failed to migrate a THP or a hugetlb. I am not sure if we should change t=
he manpage, since the THP already did, but I can send a patch to update t=
he manpage if you think this is still necessary. Thanks.
>>
>> I am not sure changing manpage would help the users of move_pages() af=
ter
>> think about it again, since users might not know all the THP and/or hu=
getlb
>> information	when they call move_pages() and they just pass a list of N=
 pages. >
>> I just wonder if we could fix the rc value of migrate_pages to return
>> the number of {base page, THP, hugetlb} instead, so that move_pages()
>> can get its return value right.
>
> IMO it will break the usage in other places if we change the rc value o=
f migrate_pages(), for example, the page migration when doing memory comp=
action as I said before, which will expect the number of normal pages. Me=
anwhile the THP page can be split into normal pages during migration, so =
it will not be consistent if we return the number of THP.

You mean the above trace_mm_compaction_migratepages()? I checked all migr=
ate_pages()
callers and none of them cares about the actual number of non-migrated pa=
ges, except
do_move_pages_to_node() and trace_mm_compaction_migratepages(). The forme=
r expects
the number of before-split-and-not-subpage pages, whereas the latter expe=
cts, like
you said, the number of base pages.

>
> Changing the return value of migrate_pages() will make things more comp=
licated, and I am not sure whether it is worth doing. Any suggestion? Tha=
nks.

How about 1) fixing migrate_pages() to return the number of before-split-=
and-not-subpage
pages, and 2) replace err with nr_succeeded (you can get it via *ret_succ=
eeded in
migrate_pages()) in trace_mm_compaction_migratepages()? As a result, user=
-space move_pages()
will be fixed and trace_mm_compaction_migratepages() gives a
different but correct number as you want (you can still get nr_nonmigrate=
d =3D
nr_migratepages - nr_succeeded).



--
Best Regards,
Yan, Zi

--=_MailMate_3C95D817-0615-4DEF-93FA-6602125788CA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGBkcAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKKUYP/RBVVY9mK8EPiUuyt6vfgUyfvMDwOoh1pajB
6VdaC+qI6mLWaoND1qjxNRRKqxEyW+SEpKJVTM6nxVakBZWJqdckITCnc4Z9hQvZ
DjYFo67ecBAuaAZ5Y86Ml9QPF9ohemiOdyJV/XqQaZ1hz4SQxNojuMG8tbrLREQf
6eRs46N8V7WI1Guh2QqEU8gBRp8gQCOv7P0k8W95IbsZS7QCZUvz57c2yZ+bmZlB
qsupR+vu1X7qLQlR7JxNy1Ppb4mKTL08kIktsrNoFVNQw6bWLIaRE38GaaxIeOhp
qPqBtr8Pv+HMEXE5/ns0zf+Z4sDAXJZTP0wtHh4LlewQmxrEhq8tkzfF3HRqhuxA
nRwt99AG69wn5mriUWbH/HUCrLphQ5qD5jjY2n/oliqyC+TmhWYQjoz8nHSiav6k
kCmg3S7xIvJ2LWLdPKDQ/Sdy2Avq/MR6pSCmGda7wY+rGiHyIdne9LCKAEwvuLkY
b6sXEUbc0xIAPRqAKjGk/Ug+0y5C9Efnbal1FTERji2huYotbuZaKIDZCiDfJde9
t07AQiO0mV96K7jCcY9Ll6qEMB7vNGU5gLsyx5IUm8hJXwY3CcS7thqX8Q3q7BUs
kAOCAUf2H29uucT10l38y5GFL5ff8F7HZ96JZaaZA159FSQvgPk9NofxEAdjWNvd
GppwKQ09
=gAG6
-----END PGP SIGNATURE-----

--=_MailMate_3C95D817-0615-4DEF-93FA-6602125788CA_=--
