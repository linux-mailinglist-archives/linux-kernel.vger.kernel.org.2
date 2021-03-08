Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B66330650
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhCHDTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:19:50 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:48225
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233893AbhCHDT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al5nBShBRTI1KD5Z7nTLevCQ4eMeAyOO0dSja8yyqkjKiyFavHsAgvX4jLXn32wwB+2t/cs+v7I9MDojmybnWRJS7yLtE15hy6Ie10g+GnazvX16zozzNGLuqkNz9CGeGKRywLrtZEfzWheBpvQpuGT61EBPOiqbwHY++SOQbgB6HJAk3IgJbG68ic8RxKiBlwESXZlZB0Hy675dBtPDzRm1tSuP/ilc37y+b0wana8zNcT9zNcU7kTx+h0hvKcFJC9gMQwDt/2X2gsv44uINGHqE5dW0/UHhVNyUalXHM/CzZfaZiR5kgOzrHz1Clk+/saV49lSiAeeOVmcgyUeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERaffs+lRqIPbHgHE93u2t7+PUZj/+VFL4caJesisfQ=;
 b=EU7eFN+RTQkLhXqillrejhYpIJSTPxg/1ws+drI92fR66zKbye/Bu+CqB4DvwYdkXPMGqF9nGpg27GeRl5fHVbPdlHyymzSv+LJlpZvuyKbiUhqrtUIcwmo0EyDXMIO+tdx6pRNLm506oU+YiZeiREiEhGE9OL3ZmjPx/VOUEkkhV3uamrttRsJMbJP934TD95kW6AUBaBj17eybRr0s6Sz2gvD2kdILlPgSZypXvX5D5P11jaHMQOqzo6FW7vUVhLa8b+2E3KXjE9cy0tlTDmZHKoH6YcbpjDcvo8DqmVAwCl7mCzZdcWGi9+o3GcIUxyE0qOQu/8kubPMUC6w8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERaffs+lRqIPbHgHE93u2t7+PUZj/+VFL4caJesisfQ=;
 b=Bs9tn9kxVoGnoqgU6Q5W2vEAlqCXIWEhHFwoFVbZvkVmWU1Aat4q0+Xf14qgeRh9B7x8IHE2tbTTbe7B6F3fdaFIgKAxILt1pCflQcxWfZ0eXr/t9XHNABr8K2m99iWd53hOLlVjnoJslFfbVfnW0xKVqo5rPu9gIp9fH6s+iJk=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (10.255.237.218) by
 MN2PR12MB4288.namprd12.prod.outlook.com (52.135.48.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Mon, 8 Mar 2021 03:19:16 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 03:19:16 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Oscar Salvador" <osalvador@suse.de>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Mike Kravetz" <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Date:   Sun, 07 Mar 2021 22:16:36 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <830F715B-82B4-4A13-861F-B3A89327F722@nvidia.com>
In-Reply-To: <20210304100002.7740-2-osalvador@suse.de>
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-2-osalvador@suse.de>
Content-Type: multipart/signed;
 boundary="=_MailMate_A947DA99-DA8C-43F3-A38A-774FB795CAA4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 03:19:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be77f4cb-62ac-4fdf-0992-08d8e1e0f422
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42881ECCD6D2413790EC92DDC2939@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaJ2CR4cOtgzoRUIIUpRRHNkZdP+OIYbZQehnJh303XGVVFfOGtKozfmZjXFmh3rEW9KCEBlHwQ1QeWpDF5hK996WrHzN9pakCobdo8xqU59uWY3GPnBhnnJVjP3mLmAios9B9LTmv21ycHLLOR6oW9RwVc0hp2UafKoO9SluDoU8n1YZWusC7GV3js8Ty8GjqnhGnWCEDtjm6ik0yB1NlXmjLj/j8BMo02LVoauDVwwtNEiGR+hUX2tx6fAF4G1rE72rtEQC0gYtcCXg7RNVlTpWNfhXYsCu67lCFKu6iz17E1D3nHDdQ8BF0eMLFrAvHAbk35ZQZlFHFkuxc1YPZV/SV6PSgYaTAWoPxbKDjB4UuvZ4gnfrTr2/ACySonvezl4bMs9S/zaxRDN/kAOT1EwosY4WyRpiN8/c2QVaWMAT6IfgnDc+w80Ls/SV74+pe7SksoyLZBrjPexeu0ahKXvhCJ3K2T3/VzhYzmB4n6G94xRJ4HYvPQiF/uTpSwqf/xj0p0RC+KSHpxQYCYVRyJz2t89iXxXfIjUSd263VAuzHGdZQk5L40w00qDQehrG3TfQMJLYZ4twXvwK81t7BgJ8qiV4mm/hFPda99dcak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(26005)(186003)(8676002)(956004)(16526019)(2906002)(2616005)(33656002)(83380400001)(53546011)(36756003)(6916009)(6486002)(6666004)(86362001)(33964004)(66946007)(66476007)(7416002)(66556008)(5660300002)(8936002)(16576012)(316002)(478600001)(54906003)(4326008)(235185007)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFMyM3VYZ3FqVUFONW55N2NHRlJabFcxL1Q3WWwwVGh1TkMrMzZiNVFyMEZl?=
 =?utf-8?B?V0IzRVhCd0t3ZmIwT2gxYzNuTExHcFdaUmFKZ1VSa2d5UG1tUUVEdE4xMnJP?=
 =?utf-8?B?SCtrMC9MYW5nUjh1OFZPMm51YlNwRXFtYUVlUmd3S3hGbVBIb3BqeEZnWEtH?=
 =?utf-8?B?SU1pUzNlL3kzckcrRnV1UEZ3ZVU0MzEyL0hQU1pPNk9qSCt5bEwxR01BR2ov?=
 =?utf-8?B?MjZIRVJLQUJYblNFS21JN084Mm1FbWZYOE1BcDUxQUFvdk5LMjZjNDZWNVJY?=
 =?utf-8?B?WDNMcGxRVit6Unp3aGkyNEhlSDQ5M05Mdy9VUStya3pTaTZmU284Q2l5Vi83?=
 =?utf-8?B?WlZOS241Z2R6dlI2WmhhWG1RckhQWVBFSjZkY2x3bmgyLzdhaVh6QXBXWUl2?=
 =?utf-8?B?L1QyaCttY2dORjZsZ3VtemFJOGtKeFd4MWV2UXk1dnFRMk01cFZtWnNKQkJ3?=
 =?utf-8?B?RVYrRFE2R1RDampqOGdDZEVsRGlPRkVrZkdUNmo5UzRheHhkaGxIUUMzU2Vk?=
 =?utf-8?B?bTVTbDc4MGREaGhLRnovekJhdVhtMTk0Z1ZTeEREVFBaUi80SEcwZENLVHhY?=
 =?utf-8?B?NTRRQmJLOVRFVUZnMXhIbENRemp1S2xZeHNocDhDeWRJTm15eENRcjFRMHdk?=
 =?utf-8?B?T0l2cDJRaDU1OXBJZEk2WkVBNGJoWkJEclViTUJQa2ZyZ2pTL2tTTWhWUFhq?=
 =?utf-8?B?KzdCV3g3QTBlZWFlcUROcE93bUttVit4NTBzZDJPZDRLalhPZjFPSUU1NjBL?=
 =?utf-8?B?S2gzdUhWNTl3Y2k0dktjU0k3azhVTDlDaVhxVjlWSWMxN0RwOHBoSlFNVUFE?=
 =?utf-8?B?eEIxYnpFMllrazJ2STNSSzZTV2krRnhRbHJ6RlhQdjF5UitYcVJPQ2JXY3VI?=
 =?utf-8?B?NXY1U09qa0ZhSzlsN2U5YU1peXgzNzFvNmtOWVBxWFljVUpKRGVUVTZPOHZI?=
 =?utf-8?B?TVBkS2JReXRRUDA0LzR6SFcxcDRTaU9KeTVackx3SnZXK0JGaVRER050dnNk?=
 =?utf-8?B?MVRVZkxRaUUwZW8rSmFGcUxZT3FXb2tpSFdaSXpEV0xVMnc2SmtjUVhMTHYy?=
 =?utf-8?B?Ny8rYWQyYW04bWNqdjliam9WL1VYbmYxS21zTjdIZEdYcHdpZlVaYWJOMTl6?=
 =?utf-8?B?MUt5V1o5MHBTa1Z0WStvWFFxU2dGcGtEYkZGSEZ6MGRJNFdjaFVQTVViVkdC?=
 =?utf-8?B?Y1ZKelI1SzgyUWxoQXdXR2JKekNoNEdmN0J0QW00bVJmVHdtWWU1SVFMSG9z?=
 =?utf-8?B?Nkd3UEtXT1VFRzVzckcrTkNQNmhxWitGaVNLbjNXdnBHbG5sRmtTbHFtREVO?=
 =?utf-8?B?ZS8vY0p2cGp1ZXcwbHd6Q1luMUlSeWtHMmtMcC91dmxMSFVxdzVzVUFJZFlk?=
 =?utf-8?B?UmQ4MWJ3N2ZkWHhNNnNubDRFQkRnQ1FFS21oMFhqWHB5MURrTDJJaGM3bktu?=
 =?utf-8?B?WEtGM3FsMjNnck82aWZWK3VXTm5BWlp1cFQyQUdmbTRsdGMwRzVFWlJoSGI4?=
 =?utf-8?B?bFFGaUlDMmUvVnJwbnVaWFVpc0RZS0psNzlieHJvcmNvWnJKdWlQdGVyd29T?=
 =?utf-8?B?dUd1aHBMb0E2T0N0RjRUT0ZxWktPYWhmSXd4R1FWc2QvcUZ0T2lLUmdBdHZG?=
 =?utf-8?B?VW15ak1paUQxTjlsWGlqYjRSby81b283WUZNOS9TS0MwbVJQd2R1YUVvRnpT?=
 =?utf-8?B?bWlNa0hGNTBQWFZnbTFvZGt6cU1xakZuZmxDWnZLb3hlQmtzRGlFU3JwSkJ6?=
 =?utf-8?Q?Ss+a/dRFy3RvmBe3F7fsJXf/bGx3kDvzXktjNg2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be77f4cb-62ac-4fdf-0992-08d8e1e0f422
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 03:19:16.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +itksXLeeIw3S8kHsgbhq5ESyzt2EkQQMoJewZJWutl3UiQSJbq4kvZRT2GdXx6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A947DA99-DA8C-43F3-A38A-774FB795CAA4_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2021, at 4:59, Oscar Salvador wrote:

> Physical memory hotadd has to allocate a memmap (struct page array) for=

> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
>
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.
>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
>
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
>
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section =
and
> map struct pages there.
> struct pages which back the allocated space then just need to be treate=
d
> carefully.
>
> Implementation wise we will reuse vmem_altmap infrastructure to overrid=
e
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gainin=
g
> a new field which specifies the number of vmemmap_pages at the beginnin=
g.
> This comes in handy as in {online,offline}_pages, all the isolation and=

> migration is being done on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn =3D start_pfn + nr_vmemmap_pages.
>
> In this way, we have:
>
> [start_pfn, buddy_start_pfn - 1] =3D Initialized and PageReserved
> [buddy_start_pfn, end_pfn - 1]       =3D Initialized and sent to buddy

+Mike for hugetlb discussion.

Just thinking about how it might impact gigantic page allocation like hug=
etlb.
When MHP_MEMMAP_ON_MEMORY is on, memmap pages are placed at the beginning=

of each hot added memory block, so available PFNs from two consecutive
hot added memory blocks are not all contiguous, separated by memmap pages=
=2E
If the memory block size is <=3D 1GB, there is no way of reserving gigant=
ic
pages for hugetlb during runtime using alloc_contig_pages from any hot
added memory. Am I getting this right?

I see this implication is documented at the high level in patch 3. Just
wonder if we want to be more specific. Or hugetlb is rarely used along
with hot-add memory.

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A947DA99-DA8C-43F3-A38A-774FB795CAA4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBFlxQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKt9oP/36doKSheBri0IljxXwwJTNIK+5JMggi0ff/
pLm0U7PuUBWRgfcKbkRqDEkiA+wMPai1n3+I76qUu49FLrXiSWoDJNGEmrP2rIk5
3zGv7IgvIkEPhod1m4gTtpYoDz/LyxTYtNRCnRnLmKN54yxkBh1d1aASAemw/OOg
mzMb9lV5Bi/c2A6tL1sUzpisWMqT9xysa7qtU47xGK8Kkd3kU/NdvFgX0pdBh+XD
Utx+f5ztno5W8tEtyykTKLtrNCB876dKTQM1fpUipVo2dFRGmSgZEFCU/PXuw4rX
vOXvBcL/kO4OntswavFRuxQXblv3mcSh3VWJgAnUZXxWs0pO6DKT4GGhGc+x4Bur
6y/yllObPq0KvF90lRWZsSvYhWlIioQdmFbDFmcRNWYl6PuDPCkxxwqZ6VuD3Qfe
DdT8XYFeHa8gfIHWZ7KSQKrx9guYVUY58HLfR3NrRXI86sHKvcbs1x2ivXy95lV1
dk0u6aBZEJuHqBs2vORDVbrROvduwJdq3uaZDVaIhTyMlhYOo1KIevRD/ggYGcc2
URhmfRDnXa6joovs02H1y9lHp7yyCltGzOIaecYA/Dl1fKH6PyDKjnMTnOT4k+zX
QkU0bZ9Xl+A9xieHIASU7vQieFvl/tAC0/oHLXF/TXR9+pDBbNF0/gX9vIyK49Q4
DiOWbROL
=G4i4
-----END PGP SIGNATURE-----

--=_MailMate_A947DA99-DA8C-43F3-A38A-774FB795CAA4_=--
