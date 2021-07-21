Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1ED3D18D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGUUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:34:58 -0400
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com ([40.107.212.80]:48021
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229764AbhGUUe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfAAaU6tunjNRlsUrevD+pNY32xEDnf1OZTw4RhP1mdayOcZEFiodKBy8ovAVuW0FgZ4jsC3GHsAA1XIprwoISqgomduoCM8oyfnKaMjm9GwrQnXC0p/Hb/EUimuHl/2MOnYD/RGXr0XmZYwJEb74hIU5sez2KQm/XbNu/gWc8sZ5gbonhGx9QC1syo33mf+PBdNSpJho+H566dyJveCdx1CQfJSio4boQL9AQU9H842vDpPCc64JfouRTW0bKk37unhhj97uj6M+UFHk6HmTz1YAyhhUNC5Il4crAvqBxOeOe+DbxQ0CdBA4by7k6A7o3u70Wu628aAjgpeuHbFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4upZfoqlA5nOOrM4qFtsexv2i01AUHSahH31s1e25k=;
 b=fPw9WvDUlWIHj0O3SyywdxHo62Qmrfv7bCWm1ehAhd07/OIEsKIuEsR0m+ryjtEP6eAt2J/H454bXeoY363wo4p99u6TI54NqpNqcQZb8zUW1f6MyXxw6/KXUM5rVQsrnETVGbNfvEMKBu/m1V8U8u8uRmiuZBBmBPl6KS944/3tGQ5Nf6e6/2ceCoOB9nHW/HU4HeTIZ8SX/TnwgYgFuDqek+dRx0ybkraCVB7N/wxPG7LBlEakziKPp8JoXPeE+CDV3vyy7sv+yHUhtl3p/E9EJtdqD6HLz0X2JjGna/RjQtBWyeF/I6HvZ5J6S0T3lbLS+b0rGyJxyCOUr2ybKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4upZfoqlA5nOOrM4qFtsexv2i01AUHSahH31s1e25k=;
 b=AJ8nnt2WmmrRnsNwHK0EexEbZd+IYteGZViSNeevzlcfQCESV8BcEiaR9BQT2TRgfwOGLglZeDQ5L98/ggMqTzeal+yee9QSGjRmbx4nDIIN9PYMifQ311/VWxOzT6yvojxrZXVCZmzvhKq8kSUWCv3GwIffleDR+EO7oHqs09S3BEFrALBaLahz8ZSbVSS07NelyWXrBCKAIunhlgJaUhFYVGMTQP82L5TH0iLMAtclk0BFpJlbSlkBKQk8TrONbE7Exk69PXlselFnygQjzVfHx9qX8j9OUu8L8Sn2GL+qplJOR3EbgpBIglZvnET1LTAtTRi/ZdPGUMuO56PkjQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 21:15:31 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:15:31 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V11 6/9] mm/vmscan: add helper for querying ability to age anonymous pages
Date:   Wed, 21 Jul 2021 17:15:25 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <0D3C3C4C-C25A-484F-A486-0C2ED5737578@nvidia.com>
In-Reply-To: <20210721063926.3024591-6-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-6-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DC768998-427D-4856-853D-8B884CC14133_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 21 Jul 2021 21:15:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b97b3d-ff06-4543-219e-08d94c8cac10
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376C476808777F6E3750F19C2E39@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hpQ3ocXzfj3b5ReQtT8C+oXm47IYLRP8s1SF03kPpJyZ6ZPv+JENsaN9JIVhd93z0LMNKyz0OVeY9ylZeK4C8n4jsTyYxfwyf2yDM/a8VwKf9BvczuF2SlnfZSuMcUUPdNHGNC8CTesF6dJvz4o4WxnSOJdrSMZAtqZ3AtEzgI5OslqRpL+I5A76xx9lKwtY78qP4DyWRLfj5e2YpqrcylsnrWB2NFypNvVRCZHT0cWVJ4QqllcJaCDyUv6v5oIIeM3FyitED0xc50KxlCxsnk4MJkBirWReyraT9mTkOWdT3c4H6ly8i2/36u1XVs0yWR0y4sdSybeCxfNUhQIQpnb+8fN0bCi7xxWrSlwD8yPNXN5/xaGzGkbAenp9nzN0GXbGmdvRa/gVHWSoOc6tyHjeBgqzUP6PcKbRP/u9e9wNWm0x2PNp+Ry39/fe6YP4nXfrufk0yHHlRzefxsZHCdZdd/LSDq580KyQtRu/DPEjvOG2N9Ryz1YjSBJIVpeAfcJOhqRucDWeGFU/+nr7e5luNX0C44FSSe09zJpYEJ4BSU7If9YNUz9hTAlNaA5gbtph3DO/YcagX5Ao1E/hJgEUCQICwxWBp0WQnHfipnY6kGtD/KViV4gNeMoCp9IraATG+54S/1FKktt1Zv/d8vcAmPN9OsOSuzUDvAfa0L3/+mmPxBw79sV3JVx4PKQckAIVtn79p+3CRADty+InTO3QjLePVPEVSTwAEHorNBGlBy/mREGGSu6Ljz9E0U49Sbuy8NLLK13KfO2ys6aTAO0gMcg+R4TU3ObEdoML7W9zDrtsodShOJSiQZVEhca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(966005)(6486002)(2616005)(54906003)(6666004)(6916009)(8936002)(8676002)(21480400003)(36756003)(66556008)(66476007)(478600001)(66946007)(86362001)(83380400001)(16576012)(53546011)(38100700002)(7416002)(316002)(5660300002)(26005)(186003)(4326008)(2906002)(956004)(33964004)(33656002)(235185007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3llMGc0ZlkzTUxEUU1sdDdaOFovWDduZER5VXlKSUNSa0I0bE9uaE4yT2My?=
 =?utf-8?B?bWsvTmZ0QkdDa0R3NU9qejdEbVhwY05kM2lVYTIwd0F1UHMzcEY1NXJ3aGVD?=
 =?utf-8?B?MnBrcThCcy9oTHk4ajh0clBBSVZSRjl1MlZTTEhPMEVYV2tNNkJyUHYwcmVo?=
 =?utf-8?B?ODdtTkFmUE1tc2tnS1FNMm1kNlhpSEVlOCt0Q2ZzTmEyK0F4UG1DeFN0Sncv?=
 =?utf-8?B?cTRsdmtKa0NzOW00NDBoVE9obngwaFRuRUFIRnFFa0NnZUQ1YmJEa3FkQ0Nq?=
 =?utf-8?B?OC8wWUgrYWpWYXZKYVJlNEVJUGhYd2JsRitSakkxMDdrb0FTUExIWnBLeTRU?=
 =?utf-8?B?S3p0VWFlU0pnZ29lVURUWW1zRVhLVXVwS3cwR1lUSGlxRUxITUpJWVVWRGJo?=
 =?utf-8?B?YUl2N205ZWFIbXZ0NS9DMy9wR29nbkNSdG5FWHgwRWxLMDlpeFFyeWc3SHlV?=
 =?utf-8?B?SWh1UkEvVithUmRQQ0IyRWRpMlRvT1ZuUFRneG45aXFNNFVDQVd4TUlnYXJv?=
 =?utf-8?B?M0lHU08rZHR4UmlrbVBNMzc5S1V2em5ZeWpvd0tSU3ROVFdPQXl6UzFLaVBo?=
 =?utf-8?B?dzRzaGIwSGhOMUhCeTFUK3h2akFDVmQ2c29pQmFiK25iQmtxZmhjQnZEUStw?=
 =?utf-8?B?dUZQVGVEcDZ5SVlKZzhnUDJvZ0lkSGFkME5mSzQ0S3JLeE5IZ1E5NHJwUFpx?=
 =?utf-8?B?clBOZi9pdDNUeTIwZnpJaHQvWDBuSkcySDJLbmpzbnA3OVhBYjF2ellUVm9P?=
 =?utf-8?B?SHdkd1hXNGVMYi9PZGhabGE1Q3NjSXVyWFJSOXFDd3E2SjBPSkVBWXQ5Mm43?=
 =?utf-8?B?UUNtTzR0OWVySnRnMmJ2MzYwdnp5S05wTGI4YXQ0aG9qRHpKZkIvempTaVdm?=
 =?utf-8?B?cGZuZnRPUUJkZlF3dTRvWWhXTDd2cFBnK3Z4SExxRVVneTlHQVpXYWl0WVlY?=
 =?utf-8?B?VVk5UllkUEhhWFpGT0dsQVh6UzRoVmwrbDRjbFFtN2w3ZlE0RUV2VGpxNGdL?=
 =?utf-8?B?R2x4djUwOHNBNkZuWmV5dDVicFlRRzFFdXpZYm0xRDNydjNGc21JUkpMQ0h1?=
 =?utf-8?B?dEhlQVBvZlZ0a1RhdGdTOTg2RjdjNFRtV3o3cXhKSWpBSnlNZi9CR0k4cUJZ?=
 =?utf-8?B?K1ZmcG01VkJDTUJENWYzcm0vNm5DMlo2dWpoNkJUVHg1WmxjU2luTDVhRm1E?=
 =?utf-8?B?RzNsQjZPeHROWVYrS000TTZyNXpYb2dUQXVKZXVzUnl6aUhVZUE3czJOWi9W?=
 =?utf-8?B?bVhTajN4QjZ3TzVTeEJGUnFzMWs0TmFwUEMyZG5lb0ZlVWdPcVMyWThKQUVF?=
 =?utf-8?B?QWNnUGFXQkQzUFJDSkVsaHRLRVAvSEcyOFUwREFnU04zMTdUYjB5RHJvQUIx?=
 =?utf-8?B?NGlub1o4TWtBbG1IajZCZzh4MDRNT0dySlNiZUw5ZmZVRFJ2aTJZelk2KzVu?=
 =?utf-8?B?NTNpWkJTQ1FPcElqOHNLaGdWWS9sTHE0K1VCdml0VnRreEhwcGZRcmE5dHNU?=
 =?utf-8?B?c0xaZU5tWWxjNmVvSEFGTVNrdjNvb0pNRkdXYjJIRWs4Z3cwOUJsdzdrZExv?=
 =?utf-8?B?UzlnMnNpYjlFWitmUk51bE82TVROZzZzaWk3N0tJNVQxMzBmTytyTlVpcmN1?=
 =?utf-8?B?cFJpRDcyWGxpNkc5dUY5KzlJRTh4YXMzT040ZkJRTWZGWEZEU21wVnRYSUxT?=
 =?utf-8?B?VUJ0M1J4eVU2VlFPZnlUNW9qTTIwSEhBdk9HSmcybzdKR05PTXNGRzA0SThD?=
 =?utf-8?Q?SDwzuZ8pM4RLgnTwbrNvn1rxAjGiDlRVo+aBULb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b97b3d-ff06-4543-219e-08d94c8cac10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:15:31.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkoL8MalEhDWvEWQyclqiuggQpU1oQp7R+X7YyxOHEsjEHyI7Gg/RCHmf0g0WAAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DC768998-427D-4856-853D-8B884CC14133_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 2:39, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Anonymous pages are kept on their own LRU(s).  These lists could
> theoretically always be scanned and maintained.  But, without swap, the=
re
> is currently nothing the kernel can *do* with the results of a scanned,=

> sorted LRU for anonymous pages.
>
> A check for '!total_swap_pages' currently serves as a valid check as to=

> whether anonymous LRUs should be maintained.  However, another method w=
ill
> be added shortly: page demotion.
>
> Abstract out the 'total_swap_pages' checks into a helper, give it a
> logically significant name, and check for the possibility of page
> demotion.
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-7-ying.huang@inte=
l.com
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Greg Thelen <gthelen@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_DC768998-427D-4856-853D-8B884CC14133_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4jm0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKkmkQAIrbS8M+mdUtWz9H8bz/ciFdYY0c3wcYpbUy
MbIrUMy5v54ovyJSekDARCOlq9Db3CMCzkbRhunSG9jVT/1qFBMbY6g4mp1ZF39e
OSr0jkONfvMuRMz41acvAr+xaB1nqxQuLjYtzgQW9COIBAJrpSmeMkYacV8NvKqX
hcUaX+9In33xyNxd9QJUeAnn3MZswzsN1drMChZUg0vo70ow24R64o6OVbbdnixn
Z/d+JKVbb/pqbIg57N2BTX5IZK0acZlvyyw8U6ntN7EMLreLh0UdtuHZVzBd1w+m
gnReqZjrqIFqVFlD2HB+v51mFg00I/YlpeMGNfAepxzheYaeyfW00XACxrxcWRZW
94QWBU2L2C2SZLaJHC75s90dAC+fXxNxqYBRexjm9+8IsEreEdj0AwVaMDHr5XJt
CKKnfJ7YSXKlxlvUYBFyx21ljSXg8aDWZzDBbOyrjBBgNZhLl3uk+PZyTDBx/8jT
+1YpljPw7ndM0oj99rm4hKlOVMMr3JD0AciC06CLAmXEX8MCiCrfgOeNdzG+A/fx
h+1LKwAg2KAFTx97xYq52MKUvqNJ9qGqRa8Vvap6ufV4FEvGlB05lvSSwuF+AsAy
VWQLMa8QrJupZfKXjenzRwvdCuot7bgtZe9r/3DeEHPacKsIfpFLpiT9rH+TEgCb
PyGHYvWf
=oejz
-----END PGP SIGNATURE-----

--=_MailMate_DC768998-427D-4856-853D-8B884CC14133_=--
