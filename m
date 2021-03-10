Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F3334540
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhCJRhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:37:17 -0500
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:28097
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229828AbhCJRgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXH+tdvleWuM3ERuWnnhTMB/Wxfwq47f0HLO4F8dLRT1/Y+a17UmPspYr2owlBDbIdHvpvb/ONKmc5kZygtId3rAAmVyrvz6zj/B28ynHLc/+QbObUYFIpeuoX3i9MvS5OFhqYUvW3CrYv5jcmmtdCmbeOgifUuLyJ2PpKmPyE1cht/Fch2s23YmBtLfb/mnj8OgSKikcq1pBPys/ZWCChEV3kwXtAY6UDAuLnPhLKfq97x7xjbs+aJSG3KouBxk3CN0nd9kvhUv6S/Wf5z2XfIqBo+W3wbjLYImdUtl62CEZesAW8OKCj9O72BrD9jZzfv2ySoqsW+UvlRK0u+FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/AlS8Qurf2luSCffRUawgjqkE+z693dtjDqEmHASM=;
 b=VgEWOfS1tDJU19uDOvXgHk4JxL4nUlUfRhQ/Nxy3RAx49R/hc3AMu6IcAOIAaLlbZzXuvIwDx7ZrpIPRMAE3qdozYXl1ez8YXKt63pQloflmOT/R8Lt5Jkt1D3tX20bl2w4tKJW0zbH+KkpbM3MyImosrLXMKq9nw4qBIdbwZdn0i/+xQMXDMhZwvkuIiIdRIm0e4hguNBL15GCyJw/0zPAtLJ1v+6IhQJFqkU4yBLU0p1HpJSWtQH+nfioYZmwqaZv7NOGO/9vVt9s/i0a86uAVyHw56tuO+/RYlHhv7fgamddFHyAzMSNiej9B0T0n0qmWlPW6J1gIhMi6ITlcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/AlS8Qurf2luSCffRUawgjqkE+z693dtjDqEmHASM=;
 b=Zo6wZsgXojpIuEqk63qLLYjp5T1DdkUHIEmaTZJQ/rtocEWX1U/NLhwbo2gbN3lY+kUF/8E04F3zPPZRGlW02W8RsXCBDiy+LCn1QxaMpIyDIS6wKh81j65QNnSiYHaFwlCCALAxLDufNJyIeByWITdpRZsoKk+SJZJPQ1ArzV/RBDSLulsmyIBvlR5jScKgoMp7GJeQH1REMnTVvvpPSY/MMHINqww5NU33I5xk3yELbrlqy0PhBin11cCVwWp9XbYmo5lArJTXh5xfx3x/sA46/7AV9YokYw/i3Q9kKWDyd28rxU2hzDYg3ceTqdBTysfKdISnbGAa8UUjoGobWQ==
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 17:36:47 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 17:36:46 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Mike Kravetz" <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David Hildenbrand" <david@redhat.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        "David Rientjes" <rientjes@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Date:   Wed, 10 Mar 2021 12:36:41 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <FD17A9A0-D8D5-4F08-9C90-C8C65F9E94EE@nvidia.com>
In-Reply-To: <YEj8QwPAvZe5QhsC@dhcp22.suse.cz>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
 <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
 <YEj8QwPAvZe5QhsC@dhcp22.suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_168BDEE1-DEBE-4AD1-9F8B-1730A2FC44BE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.49.51] (216.228.112.22) by MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 17:36:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad08a773-b89f-4228-9194-08d8e3eb1418
X-MS-TrafficTypeDiagnostic: BL0PR12MB5009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5009048220E70D4898B22028C2919@BL0PR12MB5009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0RGRc8gWpDzwKdoMpv2FnqNEgCSh9F6eocjdocrYu4SISk52VGkwFRyG7Tyd1HnVPD9fmxYTNO9pLIePklrgV/eVmilGBbCY0+TIVOR2I/UcvRRRD78+Auq3IvEl7yTcRNaRKjoK8gnLltO+mVU+Xydk4FtISS889bz7sLBddvKsKo7gJWoLcoJvK7gnPTvHrUEWPCsCllsKkMI+GxqHQ6jSLFOPSa/Ne0UmwgHVBTJH1EzqBrUe3mv2nzHC1x8xhJr7Mz7rjQ1iMoNoomihFYrDnB0lPuzphV5haFBqwwzNiLseEfyu8vpj2SKO/P1fRP4KwM24TezlszdVm4Nx+B/qJqLSrjTzpC1aVcYvIU20CezYI/vbGTWU7Q6kdKbX6Kv7CPVTxH9bc5vDy0ZyAeMtyM5Cr2bBAaFo9lI+7jOrHuSYueYGeRaL8h4cmYn6p13wvQF0+4oxpu15aaqT+ixdVZyUj0/96WaCi2yv7Apu5tN6vV52KWLgUPk6KzzhgrYxL2TCRzjPabN70MtNx1lDUkHJ5gXUK/X/jNzohFTnagTUBfVHxiXtYlyBdIZld99FwGEYZ1+R0xA0Tokj1njS6xpxOCfyvrGpe+Z6FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(2906002)(6486002)(53546011)(6916009)(66946007)(33964004)(478600001)(66556008)(8936002)(6666004)(5660300002)(16526019)(186003)(26005)(33656002)(8676002)(4326008)(235185007)(66476007)(83380400001)(86362001)(16576012)(316002)(956004)(2616005)(54906003)(36756003)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVZaRzRjY1Zxcy9oYml0OVBsenpyYnFTSVROeFJ5NGpBVlhEUEdqSzNpUnlx?=
 =?utf-8?B?dFVpdWVqTVp6SlNWeHgvQSs2Wmc1VURhS0sxOXhPNGE3b1RwTUxHbzJiWGRD?=
 =?utf-8?B?Uk91bWZxZzE0MWMrc0thUm9DVWFYVTZ0M2dHSyt0cDgwZlJKNGU0L1dvN0pk?=
 =?utf-8?B?NXJlNzRoQTZaaEhPM0FBRmQ2U3RYSHNwd0lVMURxcVpjOWozclloNEtqdnVj?=
 =?utf-8?B?Y2NXSHI4VFVyeWJweGxmcXRnY0x0Z1VKeWlHMURCTmhIcWpNempVVlMwcnp4?=
 =?utf-8?B?UFdGMVpBOU9oRFZFWE9RWGtsRFgvRkpPQUNraG9MYVB5N1Nmbm52aEltKy9S?=
 =?utf-8?B?ZWtUQ3BDYTNiTXVsc2YxVXZDT2RQQU1pdThsSUZGQkRFR2g0bytKYkV5Nngv?=
 =?utf-8?B?TmZIL3g5TkQyV3psdFZMZVp6cjVOb0UrLzFINEdmTTB1VWdkMFp0QzZKSnN4?=
 =?utf-8?B?a3NLSWdXVURVWXEvd3Z4VTdTRVpVeVhSUUpoa21oUWFmYlhRWTc3b1dqZm1Y?=
 =?utf-8?B?c29xMy9ZNUcyTVJvREMwcmI3Y3RqSDBhTmFwRGpjMFZzM0pvZ3YzaXcvVTVD?=
 =?utf-8?B?UXNOcUZYRzI5RHV5bjFxVm4xdTVseDFXR1doKzJmU0FSTllYYjNZa2grMVJS?=
 =?utf-8?B?TkFrRmp5Qlh3Y2l1NUVNUTNGbnVFMXZFOEZsRm5lQlRUOXdpaWozYzJhdmpQ?=
 =?utf-8?B?c2g0bURRN1lmdG1wbmRnQmNCWW1jTTNhWUpNVG1CMGcxMGFkTXVPcjhZNmFO?=
 =?utf-8?B?UUZPMzdSMmNDMkw4ZDROU0FpS0VCTGtNMmlOWW5OUmF3c1g3b1BBWWtUc3JY?=
 =?utf-8?B?MFdqSUladkdaQjJYS28va3Q4QU1INjYwZ0kxK3pXN2V1OFVvQXErbGhGbEQz?=
 =?utf-8?B?dVpQVWVxSGR0WlFGVm96QnFaRmhuUW13S0VQVVB3c1M0TFFxZGtmcUZFOFBE?=
 =?utf-8?B?Q1Rhd2dFbGlJRFJFb2lhM1JzdVNqWXNOazkxdnFTMUtISVZZYW9oaUQ2UHd3?=
 =?utf-8?B?RXdSVEl5M2xRQTA4dk9CQ3I2SXF4UGI4K0ZCRlMyN3NJUkFHUzBQUHNkTmpZ?=
 =?utf-8?B?Wk5jbHhOU0JFVm9wZjBQUnowdGVIN1lPczYzcFh1UzRZRTZiUUFlb1RQa3dz?=
 =?utf-8?B?eUJQdlRxWmdENEpiSW5OT3ZPQmxwL1FvREpHYno1ZVhzTjh0Q2wwNmI1YnVU?=
 =?utf-8?B?YzFrQjI4ZU1uNnJ5SFJMZHd2anhTMW9MRjM2THpIYmZTV0pRdXhVSmpiYkx1?=
 =?utf-8?B?NHRlMlUwYmdDcDFoRDhrRURZUXhsUDZSZHdDV2J5eWNpaDJ0cy96YWVXOG1D?=
 =?utf-8?B?UG5kWC9ITGhwSWlhMHlSSjcxMStSUlhiTDdBd0hpUTI1bEJxbk5VVkxkOVJY?=
 =?utf-8?B?VEhIVFZ5ZmtSWW9adkl5NUdsT3hoSVI5aUFNNGtjK0hBZDlXaFh6NE9vTGU0?=
 =?utf-8?B?alJKNG1GeVREd1VWb3BScGRQWGxtVVFaVlBZZWMyMUpuZUI4ZG1LRVpySGF0?=
 =?utf-8?B?TlRBV09YU0ZjNzlpeGdPTnBUWWNuUmtPTUFtZWM1b2I4U0VzdFRvajd5aEdq?=
 =?utf-8?B?RGVXR0pVOTR1YzB3ZkRtd3p1cXVxNjJuditCa3JFMDNDSW9ESGtIYUxOSlhM?=
 =?utf-8?B?d285QkxYb3kwNE1XcXFBVmIyUUFxTWdVdjBuMVVTWG1QcjljczN3Q1padGhH?=
 =?utf-8?B?ZTBFSy83blFjVWpzcVU2cXUrdUU1ZjRnNmpXRkh1cUtxOHVnNW1jZm5RWVhs?=
 =?utf-8?Q?s6PvBjigMVNpqtL9xCc5syoTyFoOtT6/Gin8nDn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad08a773-b89f-4228-9194-08d8e3eb1418
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:36:46.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfsNuDaA3/3f/AK5xwskTWdRH/PrWScOORpYBFRq6GumyPOpasI7QudKXn9v6sAx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_168BDEE1-DEBE-4AD1-9F8B-1730A2FC44BE_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Mar 2021, at 12:05, Michal Hocko wrote:

> On Wed 10-03-21 11:46:57, Zi Yan wrote:
>> On 10 Mar 2021, at 11:23, Michal Hocko wrote:
>>
>>> On Mon 08-03-21 16:18:52, Mike Kravetz wrote:
>>> [...]
>>>> Converting larger to smaller hugetlb pages can be accomplished today=
 by
>>>> first freeing the larger page to the buddy allocator and then alloca=
ting
>>>> the smaller pages.  However, there are two issues with this approach=
:
>>>> 1) This process can take quite some time, especially if allocation o=
f
>>>>    the smaller pages is not immediate and requires migration/compact=
ion.
>>>> 2) There is no guarantee that the total size of smaller pages alloca=
ted
>>>>    will match the size of the larger page which was freed.  This is
>>>>    because the area freed by the larger page could quickly be
>>>>    fragmented.
>>>
>>> I will likely not surprise to show some level of reservation. While y=
our
>>> concerns about reconfiguration by existing interfaces are quite real =
is
>>> this really a problem in practice? How often do you need such a
>>> reconfiguration?
>>>
>>> Is this all really worth the additional code to something as tricky a=
s
>>> hugetlb code base?
>>>
>>>>  include/linux/hugetlb.h |   8 ++
>>>>  mm/hugetlb.c            | 199 +++++++++++++++++++++++++++++++++++++=
++-
>>>>  2 files changed, 204 insertions(+), 3 deletions(-)
>>>>
>>>> -- =

>>>> 2.29.2
>>>>
>>
>> The high level goal of this patchset seems to enable flexible huge pag=
e
>> allocation from a single pool, when multiple huge page sizes are avail=
able
>> to use. The limitation of existing mechanism is that user has to speci=
fy
>> how many huge pages he/she wants and how many gigantic pages he/she wa=
nts
>> before the actual use.
>
> I believe I have understood this part. And I am not questioning that.
> This seems useful. I am mostly asking whether we need such a
> flexibility. Mostly because of the additional code and future
> maintenance complexity which has turned to be a problem for a long time=
=2E
> Each new feature tends to just add on top of the existing complexity.

I totally agree. This patchset looks to me like a partial functional
replication of splitting high order free pages to lower order ones in bud=
dy
allocator. That is why I had the crazy idea below.

>
>> I just want to throw an idea here, please ignore if it is too crazy.
>> Could we have a variant buddy allocator for huge page allocations,
>> which only has available huge page orders in the free list? For exampl=
e,
>> if user wants 2MB and 1GB pages, the allocator will only have order-9 =
and
>> order-19 pages; when order-9 pages run out, we can split order-19 page=
s;
>> if possible, adjacent order-9 pages can be merged back to order-19 pag=
es.
>
> I assume you mean to remove those pages from the allocator when they
> are reserved rather than really used, right? I am not really sure how

No. The allocator maintains all the reserved pages for huge page allocati=
ons,
replacing existing cma_alloc or alloc_contig_pages. The kernel builds
the free list when pages are reserved either during boot time or runtime.=


> you want to deal with lower orders consuming/splitting too much from
> higher orders which then makes those unusable for the use even though
> they were preallocated for a specific workload. Another worry is that a=

> gap between 2MB and 1GB pages is just too big so a single 2MB request
> from 1G pool will make the whole 1GB page unusable even when the smalle=
r
> pool needs few pages.

Yeah, the gap between 2MB and 1GB is large. The fragmentation will be
a problem. Maybe we do not need it right now, since this patchset does no=
t
propose promoting/merging pages. Or we can reuse the existing
anti fragmentation mechanisms but with pageblock set to gigantic page siz=
e
in this pool.

I admit my idea is a much intrusive change, but I feel that more
functionality replications of core mm are added to hugetlb code, then why=

not reuse the core mm code.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_168BDEE1-DEBE-4AD1-9F8B-1730A2FC44BE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBJA6kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKG2kQAI/LGOKnNiz/TPOgzoFzqjfaDZH8CE7ZvnlI
FfLWI/JZrer3SA8eutyEe7Yj7aGbSjfm8vejdQrmJZWjag5eC1aErjfxRiAUHJ11
YKVHqBfswgt/G9F+v7L913LFOoSeRqUARiISDCru9ezVXNLWWdIqj3BQide39/Am
b7YK828hAAgOfDSUYmZlls06wwyyUo7kbu0AiWjz1osk7pe+wP/OLU/ocd+M633V
JvT9mWAQp3vgxDrZ870USCT6gKlFzqMrniWWAzJzXqzHokoVLnXJxtXLoSBoPFFW
w65jb6rzkkd9GXX0jlECI8GLly73ouxsNmagSndkjBP06Oq7TUPqT/Rt+g4bUO8z
GIJDTTy9Xy4vGIX8XjpENKkd30wzIdld4BeqD05PSi3b5kT+12rxWS5TMFIPcKNE
gd3EwpDfCfAnKbrDxC35M5XbNprFPz0w8uVvIER+AkFCpyYkpYJ15jvlfs1e7iW2
uIWotXjUXBioR6G8KPOsXPPOS65CFbM6Ccn3hLoqP1pAHMsImHjSYuzod9gRcWsG
PGRjr1HRdmsKtkKKrqy86p2VA6EQLbxq8Pngwka24FWLfNcMGEyc0kXHMBNn9OXy
Ps/KiDnidiXrGDfG41SDzfsYr7f0kJCCAATReRkK8CYxbmOYuyQnBs9Q4SXQCoa1
JfCA1xAL
=/w1F
-----END PGP SIGNATURE-----

--=_MailMate_168BDEE1-DEBE-4AD1-9F8B-1730A2FC44BE_=--
