Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749EB334383
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhCJQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:47:23 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:46881
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhCJQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:47:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1GBKEcHYHWMh8c1aqVER43W6lF+0KYkqZgKbQjxiLU2531aymSm2CsBZ+phvAaxUJFkZU1hsuOqXrswHHnQI7WJlzf8L3hvBIrZwKi238zChW2+kxR3KAm6Yfy/uYNUKTK7gzzRX6gjpkfhErTLlJ8Lqt24Mt6TxJ5mGUwgYZlaeuFSSdBEkJSBF0RbQ2VDrcSk+83FAPlCD7C1UscY7fKNtfPkPmsq9QnivqbB0uvle/xjJyXsSizXKmNYdFoXZzGRkgf8vfM8QGXoOtL8Xn2Kr6lzHcOnrx3W6LB5wzCd0aAKtIKqip9WsY81KOd1dVrkIYCcFyYUFJEalvqvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a1vaQb/RdK3XRCL+QOFmquPTCxw5/3uDF4GgWQ5iW0=;
 b=R2xgGFrJgHyruKCruLZZqGgcwkZ4OKdwXbZLoOzadppOsMBCewjG1593imPq39FNIFPdCNW5l4TsKA+UCDCxfkUHOACc6JSD3ym0coXCMtD0p7BzWfzTctpRgYVWZu+tXgFS9d5iabPYdBMvRRNDNRLfKmK+aOAGM3+CJACB/8/Rmz1+eZJvaVVczb1/PKDq24RkoFxQjru+QrPvf/SKiVTBLvSLxso/MVLwNQkSqw/ZNhiY49EwfmOVO6e+mUopQHCmlXZ0kgIm7lEUNVsCTku5+DgmKCR0dT7iqV1Mio9iYThwbgeuAc8FB0N7h0NaZ5hJbdI+D3CRIff6urZ1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a1vaQb/RdK3XRCL+QOFmquPTCxw5/3uDF4GgWQ5iW0=;
 b=igIvRaBKaXPf2J8cWHflTDcMewcgRLJQxWeeNNLYyKRctmLBcV4/RPei8YPs6NlYdypjzfVPydtOQvaFZVQFukw2YusEkE1AlkST/aRypeptOsBhn0P6mJRXTznzl66rgzJD+qRy4iDL9Pmp4gq1qpCQ6BdU4b5YThFYEVWm7ILc5vG0nvSp42v8wWlUM1bNzL+MlkxbxeAhAbNleOeVJflxFjhVc2qZ5GZ4j18w4S1yzUo3TYYPNB8Iz4+03WUGDlGgx2MIz8qeradViV2VA4AWFMg0xkgHJ1IwhtErfLHKKdHOPswhzRHnaC1iMD8x7kYg1IA1LEqbfMkYtEiRZw==
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 10 Mar
 2021 16:47:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 16:47:02 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Mike Kravetz" <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David Hildenbrand" <david@redhat.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        "David Rientjes" <rientjes@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Date:   Wed, 10 Mar 2021 11:46:57 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
In-Reply-To: <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_1399212A-7829-4687-8D3E-2776E311E7E6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.49.51] (216.228.112.22) by MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 16:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c356fe-78a2-4658-b621-08d8e3e4213d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB375908A90526BF67986B944CC2919@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ztEc6QG3vhPRNuoGfMiys0dqDM84bSFpKQS1wsQmSGa0l9nuOyXU8QCzQWlkNkhphGHiAU853Q6GXFGCo4NVBm/t02pW31jts4+TgQOpHQiscf4ump2GpSYxgw4yQyYFPcyfZbQ0uAT8l71h73hjLHvgr8Ie4nQmXzQv73hibRf2yKrFnBQglPvYIt6qyrdhEmYlQ+JUlxojg++4G8sk5ahZpmpofdwh9b9aF5NMJJy1CxBRqwpPklS4E6iFUB+4mPDd42Zs0MVViXNZroLTXkD8P+XTQYtwQv28slavFO6OEGK6sBwiaJHyZRWByUypqsypQSlHeN7SvWONVHf3pqe/lIT3Ugt/G1+JR0pdzYxLuLrZ/VFlYAApf16In5nnhUZ32bqGUjUmJpMnpYWWWA9se4MTvOdToSBMoGqKdp8wSmC1YfiFq4m7XKPavY+T0XlyT+gMq3pY4wsbdn48TjnZU28pUgx53VxS21vh6MLuZtE97UEvf5XDkaHn1JUrd4ZC4bjv2QowFSSblUrY8DbIIr5fu1KflpnOxsAi7wDg+ySG8qMKGm2gLx75LBY/Oz4f+UBjWv07+v5KA6wgwRgFgvoI6adRoD2Lfqvp/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(8936002)(16576012)(36756003)(66476007)(478600001)(8676002)(66556008)(83380400001)(956004)(86362001)(6666004)(53546011)(33964004)(6916009)(66946007)(6486002)(5660300002)(4326008)(16526019)(186003)(54906003)(316002)(26005)(2616005)(33656002)(2906002)(235185007)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1dFblF3aWUwWjZkUldMbWJjV1FOWmZTTG9yU0JRZVF3c0lORzVRcC9UTC8z?=
 =?utf-8?B?ZDdWbGNLZzRJU29oakVwVDNsZWw1UkJCR0M3WmxpbXV4NjY4a1RJcGNIamlG?=
 =?utf-8?B?N2FiVWtqSlU3OHhhZGJVY01JSUtvc1FBQmc4TlY3K1Fha2ZYRDg3WWZkbXB1?=
 =?utf-8?B?dDh4NTlwRGFSMktGTXVhMkdtRHNiWnZQeXVqK2Z4cWZmTnNUMTBNalJCSG5s?=
 =?utf-8?B?WjZXVjJIaHFXWjQzMWhMQzNYRmtCUHQxOGlSYXh0cERUa1B4VXBJcVRXbFcr?=
 =?utf-8?B?R3g2djB6NGhFR0twUktnQ3E2MkVKYVF3cFBFVU1oSmZ1THdma0lnTktRdkRI?=
 =?utf-8?B?N2VybkgycjVpR0hLM1U5TlJ4L3VCdEEwSFFwSkZyZ2llZW9jbFlqZlRyS1Ix?=
 =?utf-8?B?aWxhNkVrdlp5endJRFd6aFc2SU1TSTNDN09jRU1WbXd5NHg5alZ3UkREWDJF?=
 =?utf-8?B?S2VCczlJVEhuZTREbHJKVGNJZnQ1SWo3aDNyYjVXWXEzY0RpdnBqZzlhZ2oy?=
 =?utf-8?B?ek1Jc2J0Y01DUUV5cEN0eGdnVXdUT1NGVTlkbDFudDVndEZMUVBISjZIcjhF?=
 =?utf-8?B?bFVwdGl3MEFIaEhEeXZRbU5qekM4MlRONEEzM0RiVWhZQzFwMFY1bWRjbWs2?=
 =?utf-8?B?VHQ3c01QaHZNNFl3dWEwL1oxQmt4cFFISWFTRG1IOFFML2lVdzk5bTQ4eFBs?=
 =?utf-8?B?VEllVGl1b0RCYzQxYnVBT0dpakgvc1Q4M3VhT0wyd1NpbEVyWnNRNTJOalpy?=
 =?utf-8?B?YWZOL0pPT01rMWpEU0dEYTNMSGtnQkVlNHcyMEFrSWFBOEVrak5JbEN5QVF6?=
 =?utf-8?B?Y3p1U2lGN0ZEaDZSYlpxaUxjbXNXcm9UTEN4UGdFKzRiTi94clVpaEtYdThu?=
 =?utf-8?B?S1lBSlB5U2M3U045VFRMVk1hS3hqbktLOEh4VEZhSG9JZVlWY0pieVQrcU5m?=
 =?utf-8?B?dDlZWnd1alFaN3I2U1ZlK0l5WEt0VkZRcG4xVmVqWEpYeThHU2ZGdVZaQ1la?=
 =?utf-8?B?cjVBbGV4VlJoRzNwLzJEMXFDQlpHRGhlVDdiYllBU2JIZmY4c2NKVEVVLzdz?=
 =?utf-8?B?QWhaVVZyb01uUngvaWw0aW5RMm9PSWtSWWcrOWh6b3Y5MkY4ZGUzWitWZmRl?=
 =?utf-8?B?STllTzdUWThoUjFIcnl6M0JqclR3cS9BMUFCT3ZFeGFIZ0lmZWJ1YnRTVC9U?=
 =?utf-8?B?cGRRcVA5c053cXpaYWM5dDBxSk84ckFXWmRWeWJaUFhWWldYditVRHhtYk8v?=
 =?utf-8?B?WngzeXlVYjlDK3QxSlhWeFN3VTlBbDN1VldxU2xsajRYbXErTXRiRi9CSVdF?=
 =?utf-8?B?RGtqanZGRnE1ZE1RR0hYV2l1WDJRKzJheFkzUVY0TEk2R1AzVGFvVHh3Znla?=
 =?utf-8?B?ellidzYrRU1WOEVyamxmKys0UEpsUVZNVnNQUTZtVkJMMndLNm1ZaHVhL0Zt?=
 =?utf-8?B?SktUN0NCa0RIVHN0emhxYm9YTGE1L2dOWlhlTzR5Q3R5U3Z1elZORzJYYXA1?=
 =?utf-8?B?eUhCRFY0NVA2YWFDeVBPR25xRzZGQ2N3ck9KTk0xWVVMYU9iTmRzWTN2MHpr?=
 =?utf-8?B?TytSbEpsT1RtREdDYWxlMlAxbEFjTWYyRFNGQkNzMUl4bkNTV2xlQ1MrOTlw?=
 =?utf-8?B?S0ZSbVNrS2FBbnE5eWNuYWFEMEpTYWRzRnlVTmN3eWRtMUxid2hjWTBzMWpE?=
 =?utf-8?B?eFpCWkpRMmNpMlR3V0kzeCt0VzlFQThxNDB5SklramY1UU1FR1Erd1ZMci9r?=
 =?utf-8?Q?4E8GATRGPwIbifRsBhsGFyOsgXK8XwlUxFJPbhA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c356fe-78a2-4658-b621-08d8e3e4213d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 16:47:02.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8tV/b0KtlGHnIHTsqj6uOkMCvNKrz+qPt+TEOFxPJiSx1+yRc6iMSFy0uysATPi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_1399212A-7829-4687-8D3E-2776E311E7E6_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Mar 2021, at 11:23, Michal Hocko wrote:

> On Mon 08-03-21 16:18:52, Mike Kravetz wrote:
> [...]
>> Converting larger to smaller hugetlb pages can be accomplished today b=
y
>> first freeing the larger page to the buddy allocator and then allocati=
ng
>> the smaller pages.  However, there are two issues with this approach:
>> 1) This process can take quite some time, especially if allocation of
>>    the smaller pages is not immediate and requires migration/compactio=
n.
>> 2) There is no guarantee that the total size of smaller pages allocate=
d
>>    will match the size of the larger page which was freed.  This is
>>    because the area freed by the larger page could quickly be
>>    fragmented.
>
> I will likely not surprise to show some level of reservation. While you=
r
> concerns about reconfiguration by existing interfaces are quite real is=

> this really a problem in practice? How often do you need such a
> reconfiguration?
>
> Is this all really worth the additional code to something as tricky as
> hugetlb code base?
>
>>  include/linux/hugetlb.h |   8 ++
>>  mm/hugetlb.c            | 199 +++++++++++++++++++++++++++++++++++++++=
-
>>  2 files changed, 204 insertions(+), 3 deletions(-)
>>
>> -- =

>> 2.29.2
>>

The high level goal of this patchset seems to enable flexible huge page
allocation from a single pool, when multiple huge page sizes are availabl=
e
to use. The limitation of existing mechanism is that user has to specify
how many huge pages he/she wants and how many gigantic pages he/she wants=

before the actual use.

I just want to throw an idea here, please ignore if it is too crazy.
Could we have a variant buddy allocator for huge page allocations,
which only has available huge page orders in the free list? For example,
if user wants 2MB and 1GB pages, the allocator will only have order-9 and=

order-19 pages; when order-9 pages run out, we can split order-19 pages;
if possible, adjacent order-9 pages can be merged back to order-19 pages.=



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_1399212A-7829-4687-8D3E-2776E311E7E6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBI+AEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKnP8P/2lTcUc+45/ebedHLg5FWb7WfGju7miyPnOT
Tc8hvstWTlZxLMVZvoSJkoyUwD7VHh5eGkNmlwa5kjgjgA6axGzKE6xpc2xGQoQV
d4POb15cq7GdPdGTbSVVjtTDtx1/uIPwtGQlkuQ9Orp1cz7oSGAnpxtFXHDTEsiJ
bXohMe+KCc3RGma2n/fnJBfPqlM2GeoS3TPbdvU8Ndr2Xb/lTr5k5q1UFalPRkYM
hK3t6593xANho50YA02Et3qdbmBEsIWyGWAYR2+X5Ze5Qhg5P/tSbNIWWgHkuB2U
jEw4nEBBamWcGIZi2ddI57zs9Bt5pilQXyhAI7YzleLbmaFJUC/hhvNsYENsFfkI
U+cymdaybv4uQZeVOBfSZw0FnI7ENczlilXx/znaNnkW8nGVK17d4rASyL8MToDT
OWgZWaGFvvP9n6yehJJ9Ds9w5jWtEsaHiScUgkKzw7bDY5MmmUjquMEnt2y1Q2rr
FhYYwC0IZuN/DD4OO5+UkzXFLoCDEZluO/p2/LRo/JSEm/ZS+m5gNiUFLab0220p
vnA/8q8Wr5fVIFfzmVLPtys4/zRFtgMPKu+YkAY1NvTLSkfP6F3+nNNK0Ba8bplc
RoDNM2Oz3QIDbMSjD/535xQHuXOfIUzVNYa/gIXbqq0uSOti5oTsqa4slQu9SGVo
PT3Qi9BI
=B1cQ
-----END PGP SIGNATURE-----

--=_MailMate_1399212A-7829-4687-8D3E-2776E311E7E6_=--
