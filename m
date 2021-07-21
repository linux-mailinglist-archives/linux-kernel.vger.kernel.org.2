Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FEB3D18CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhGUUav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:30:51 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:8837
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229545AbhGUUau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5KN5lsTFW1vyJLDdLDjVPw77hoe5Z1T1gN236AsOE6Meur/XE9IbUGJVVcmeoJsmlED7NBd8HTnnaOnspDxOXANB0nkEuVR6di2W42vnJyJ06AMGqnhv3k25K2pheZzYgGeumh+IpbxF88y2VCwo1C6lxeZeYDlBRAUmNDErNZvNTo7738d5DFqwlbpWK4w/bT0z9nzUMbNeUVk6S2sOh53MMIBU0jAaYKU0eRzSX1ncYZalVI8oAuajtTmDcrzTQGBY6QRvraJqv2xcnaDqYvlHhwSXk+L1ZfjQMICg2Zi3fbSGdXjJkt0pH1gmbLbL8kqJKCMSR8pK3ZhBCiftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgvS183g+tNU3r00+MLjBQW8AUKus7oATLb2FpBcTS0=;
 b=UmGQxhyniosRUhzrQOZgyq0b5dTiJiHR8ES6h1kNupmsNI1ahGPrh77XsiDdtDJnOJXBJ30o0G1+iHHvR6GynaFlslzmf7waKYyZKusWNULKOzBe6MzBso/zYjw198MfiAA4rbWLHQ+6nqu7LTCXXy+7os52JGGyCyP7bWuOOgiYC/HCAooiM//tIFNnqO9+5V5JNXkbbnMSRUsDIQFVQqGJwgYP/m3LNVRPr3dkXX8+QpHgUsw0zr3p3QAeZAIoh/CHWD2cPzk9TJdstjp2aHTtiz7ZYTk4ZEa/c7aXHGtbboNnCZ/MtAdniJz9FD7MR8DYS5Z9iOJEhamY151HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgvS183g+tNU3r00+MLjBQW8AUKus7oATLb2FpBcTS0=;
 b=QE6S9jd7oQf+C/yszvzJ6nC6EXmsqTgECefKPtW5kcRc6DTEZnTIuxYqK9c73iVqKzB+Swy7EfG4SmR/3uAgvMLadumPbTUN41M9WO6SejoPPAfAmouPtJEep7Knkn5lymK9gc78cirKdYErLSYn2le/2OiEVX6gTH10n9oHmsVG+ok+jECzKLlz6Qp9k5ePeOVdAmjXVE73XbjMupbJX0iB1BkOw1kbOl3UXueNAZ/BJ+69+KhqP0xicN/aP0du0Ha77ctgElwBe2n/DxGMF4XL0DLElx+GxTk1NgaxrdHcZ15O+fA+sRgpvyzKnJDZ+7DMPTzpMBmd2u56kAbA7Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 21:11:25 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:11:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -V11 4/9] mm/migrate: demote pages during reclaim
Date:   Wed, 21 Jul 2021 17:11:19 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <CB92E029-2471-4B99-B80F-EE63B2D7135B@nvidia.com>
In-Reply-To: <20210721063926.3024591-4-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-4-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0EE8932A-2694-4A6D-8000-5306977F2645_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0029.namprd22.prod.outlook.com
 (2603:10b6:208:238::34) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by MN2PR22CA0029.namprd22.prod.outlook.com (2603:10b6:208:238::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 21 Jul 2021 21:11:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9271e310-6c83-4cfd-f94d-08d94c8c194e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44235D19EAC796798F4188A3C2E39@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ6ghXLq1wEBz3zoAr23QAYPNn12oxKFdFCngojLXnE0SvdcJ+nOgnsnJk31GyP4U37t4WtR1kHBVSOcwpNa0PizXO2MfbAPXHi+OlDLFrnpJs29rh9hef3NqUcazP72b/DzC9y410L5F/AfS2JHwwYc5ojzx5KrP0EoFvu9459BxwAApR1ZW376gh8OsM1CFddjHyzX8AG3DStxLom1Pc9B4cLME0gESBv/5OmtcVLSUV+yLpL3Wf9ZYYVISXdlx3u+xpLyqXQesOdsthHd2GbsGVBMUe84RMGHLLt1jFBMCzV9I7zekPmaz9q/BHVYpHZFHt2juqps2v7ReQKwMSE/Ku5PMHdGqfUrW15IteQuBL3gIi4JqJUDVXdc/t+pCNTsi5qgvGcgHnVL4gYyD7TOB4IBZ5twYtSlWUWrp/G8eET1fUrrybYCOiGphNIrD0DjgrI0TcSV7SwI1Nj96hIZRVir0t5Koz+IG37SMI4vlfRkkG2f+E5bF8IZ7/b43eoGOFv12SYfbXvV5XMB+jA94H9r3aLmaQPHHP5gh+7T8+q0TH7N+If30zvftzobucZpYGyxpcRJ1LdV+2mjNaa//TTwxrehf4Iyg8DcgYPtcXckCcEcmk6JWFN27Z3PbNN60P+/0CjWpVz+JAhu3lnxFtyQpjtEMTJxwDyvnVbBsy08vgwke7BWA9sruaKzSrVXb0tRgiQ72ae3co7MT63RGSk5s8W/mYuy4iH4jrJkIBGitGOpObbMXGqTnI9wGocoF/+2ihMFPzZzXBHhDXpyz8bABTYmYEXIvERZN5ahjoJP5AE2dfbgThsNTgEH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(966005)(6486002)(21480400003)(2616005)(54906003)(6666004)(6916009)(8676002)(8936002)(36756003)(66946007)(66556008)(66476007)(478600001)(86362001)(83380400001)(16576012)(53546011)(38100700002)(7416002)(316002)(5660300002)(26005)(186003)(4326008)(2906002)(956004)(33964004)(33656002)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpzTmNsRVhPMG5iTHZPNnlBanZCU2NIRkdwb1NxditsdlB6ZURHZi9QSlpL?=
 =?utf-8?B?V2ZIVFpsWFhWVW5tVnBSY2NOOEI3bjhySFVzQ0pTaDI4YlZ4aThIQVN4Tk5B?=
 =?utf-8?B?ZmtaS0hmQlFSTGhybHgrYWd4MVZTbXA0MmNJdFZKSDl6Rlducnp4L2N0WW5v?=
 =?utf-8?B?cTN0ZzB4YUFCMmQzVVgySXBPOEFHL2cxVWRvbG9ReUNRSWhhU1ZGZUcxMjd5?=
 =?utf-8?B?MW5jRUR2MDVvTnMzRkZBeEphZERkZFRIOFh6NUtlckdPMXl3ZWtCbVptbVBB?=
 =?utf-8?B?RWtqeFlNb1YvYkFNWHB5ZWVnWXBPRHJhWnp4LzZRMUVSV2dLaHI3VXFmdEE2?=
 =?utf-8?B?TVBoQUhGeEw5aTlYeDFUTmdlTVdiemVRNGc2aTdzdG1pVithTGtmVUlhaFky?=
 =?utf-8?B?UjhkNlFrVmxPVEZJamJXRy9hSEIxcjY5M092ZmU1WU9Ia0F6Z3M5dDFrMjVQ?=
 =?utf-8?B?RTl2RUFyQ1FYbEFIVTFESGwwZWs1K29vVHNPZ1MwbzA5bE1jTnVwdmYrNHR5?=
 =?utf-8?B?KzNzZU4rM2s2b2tyTTl3QmlsdE5jM1BiMXc2cnhHemNXamloYVA2UFpIQjVZ?=
 =?utf-8?B?WmVFWCs5M0ZUUGYrb3lvS2pUSitMaUROeHdPUHU3NTBLS2RoZ1J0VmxQWVBR?=
 =?utf-8?B?SUcxbEw0YmJkb01JN1ZUWUE1U09LakkyQjRDZThTM1pna3QxcnZzekJObmhi?=
 =?utf-8?B?THcxVmVDQmhTZVNtbEUwVXZaSFZmbU5jS3FicXozcUFFU3VqR3d5TXk0c3Mw?=
 =?utf-8?B?SVhnNEFXeGQvUHdLVlE5bVpMK1BFZlMxanpmOE1QeE43MnQ5aWRSM1ozVmJQ?=
 =?utf-8?B?RGNzVU5jZk9McFViVFJMbkRCNXU0QXRLRzE1Qk5zM0hGMUl6T1E5UU5STFll?=
 =?utf-8?B?TWlCK3U4d09sUW82WGVrQ3ZKcUVLd1g4dDJ3aHVoTUhoRCtVOGFPZVdUVjMy?=
 =?utf-8?B?MFYya0FmWVg5ZjhGT25FcjNrSXRYNVBlZEhyWVBrYjBpVjhydVVkbWlSNXNN?=
 =?utf-8?B?L2M4bkUxU0xKMFhvU1p4YzdpSXZpcWtBTlc2dk52T3BNR2FxZ2h2OFV2UTh2?=
 =?utf-8?B?eC9HTGlFUFRTemtGblc3bXFRdzJubDBaVDNSU2tGR2tWRlgyNXh0dUtsVEUx?=
 =?utf-8?B?dEJsck53bnhOVDZqTmU1OXpvNjFFWXdQK0dzNlAzOGViMDBlSXhNUzRZOUht?=
 =?utf-8?B?UDY5VWJTZnErQUgyT0JmMkhkR0RTdTYvVUZuTitnOGJLMERBd250WjJrZFRi?=
 =?utf-8?B?TTUyQUpndDR1R2kxMlVkcTlxWkRkWnFZSnpabjZsMlJFbW9FSGp2NGNWVjlj?=
 =?utf-8?B?NkVxa1QzMTQ1RFQyS3RWNS9XSlA4NjQzYXJKMUMwUVNmdjRtQXVJT3JmeTFO?=
 =?utf-8?B?T05QS0E2bVFhQTZyTGV4V3NkUDFyN2NLeFJtUHo2K3FNUmJUVGNKbXRDSmxp?=
 =?utf-8?B?THVONjZ5Ykg3eGNHZFE0SjB4M0hOZzNFd2pVZGIwTlFxZUZ4ZDlqZzA2a3Nx?=
 =?utf-8?B?RUVUSzRLQnlKNDFLbFZpaDhCWCtzeFQ1UzY0V3NKbFZXODVLL1VaTG9KcDBP?=
 =?utf-8?B?dnA1VisyOEZ4UWRHcDZOOEk4UXBkVzA2VjB4Ly9TZWhxZE9tT2ZseFFoejVX?=
 =?utf-8?B?L0pyMnY5UjNGOWZQOG5iOFdESlc1VmJDUnBGdWtxR2NURmNPTmZEejVWd3o4?=
 =?utf-8?B?ZmtNcllxVUh4ZU4vRkhoeUpDaXV6YXdBZHpaYndreUlCR0JaK2hxdmM5akc0?=
 =?utf-8?Q?aYvb5e9a96EJxFaIUk9R61hzRBDfOUm+YXtB9mJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9271e310-6c83-4cfd-f94d-08d94c8c194e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:11:25.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOjhygTD6jqqvaQFYGRbizhPKPyNjVkGhiLh5ColG7Q9+gexTF+V7J97MmiXTrvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0EE8932A-2694-4A6D-8000-5306977F2645_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 2:39, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> This is mostly derived from a patch from Yang Shi:
>
> 	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-y=
ang.shi@linux.alibaba.com/
>
> Add code to the reclaim path (shrink_page_list()) to "demote" data to
> another NUMA node instead of discarding the data.  This always avoids t=
he
> cost of I/O needed to read the page back in and sometimes avoids the
> writeout cost when the page is dirty.
>
> A second pass through shrink_page_list() will be made if any demotions
> fail.  This essentially falls back to normal reclaim behavior in the ca=
se
> that demotions fail.  Previous versions of this patch may have simply
> failed to reclaim pages which were eligible for demotion but were unabl=
e
> to be demoted in practice.
>
> For some cases, for example, MADV_PAGEOUT, the pages are always discard=
ed
> instead of demoted to follow the kernel API definition.  Because
> MADV_PAGEOUT is defined as freeing specified pages regardless in which
> tier they are.
>
> Note: This just adds the start of infrastructure for migration.  It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-5-ying.huang@inte=
l.com
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Wei Xu <weixugc@google.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/migrate.h        |  9 ++++
>  include/trace/events/migrate.h |  3 +-
>  mm/vmscan.c                    | 85 ++++++++++++++++++++++++++++++++++=

>  3 files changed, 96 insertions(+), 1 deletion(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_0EE8932A-2694-4A6D-8000-5306977F2645_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4jXcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKN4sP/A3a75oibyf3dRoCp+FlADwxCH1emeQEtlEZ
azlMElLfQ6bZ17wPnYTefB4Q6hcM3xwyGcW812FFNNhWBiELg90AkS6emwpOQeY9
rgwo/20QJUyEhdT2sm3WklcLaoD+/2UwTxVB+Pb4xqY1tQnqtMuMX3SUuC6+CP3Z
VL1BuO/yDLQ4iXqdw9RDirU64S35N4fI10cOwhb5Uzs5+4q6OX7CIw0Z9X0XPwmZ
Bd195DEtTZ1Tofqlti0Xd9w71Dfhb9BlXVQtMDBXl0I+Mf4bqYlkF2C7FDLzw4A/
nA4mwcNq967inlVyi/KlfWWzpSMP7t1puj1kixXU+ZnNTKDIKDPyaoIdIWM/531h
PUz/KhrprenirdxUXePbjrHF5A9jzP98HCPf/QTVH8nwsIW8vtO9B9ltrK/IGKqH
JmWCL95/cXJQg4iRHdP+Wcp5haBaa1jol2gqA8WQrgDJXKeqCXbmqG6PXokU98pH
3U7Im5E/+VKWUWvx1Dbcvzgs7oMdiBzwCQQb2iusRv4ntQlriPvURrkGVz+VoPce
m5zzEYybLDP3bILoJ/zZUAYOtSmmeKiG9So0c6xciKZPh7wZw9j3o0sJ4D/pPkdZ
yd9vMt6Sbm9Auqw9sFFJENxPe+8zFfHLm8v8QsQrSWIPxF9d1bCsmBawTsw0na2E
4+3TrulJ
=KURz
-----END PGP SIGNATURE-----

--=_MailMate_0EE8932A-2694-4A6D-8000-5306977F2645_=--
