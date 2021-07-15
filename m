Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE23CA4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhGOSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:05:50 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:37600
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232014AbhGOSFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzrzigodcM8TJ95AOKxZjIDCjKa8WwkBT1qYwahuG5NekAUsuGdB7LEsEEvPki6efZNUv+FJZopm9HrxrDgSh1bsueurj3BZXyyHPYl9TUJu9HYS+qjB0biDjH6PP8Ww/ajtq4WrHMSow48o4I/HhhoOwNMBeFu06WEqPyBnO/261Ov+pV9YwHqw4+DzDbL0Txf/+Ljg4Lsg3R2jUAGaXQ7HL9GNMmnrnyPfTu/Kl2QCwaF5lkXwb9tJkpGQemyStB1RWvxvrdbe1eF8jlbAUPXYIYCOGvt87kfDOs+IUjImZ87Hw8+en68bxyAgLB+5H45FJw1sptIFpJbvE0cASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uc9p6zrSHhCPvYNMWyQFqF4RF7abHHsxfJEnutSoN8=;
 b=C06ihgSalIK1wwnnnPvQBBAkRlAZr43R4f7Of5qlWo1Y5sllX2WfHSdneCGRIf96hYUHqej6ut4pTG25XrJrmwmR2g+/HdFcZcg/oCplIbYfkF/UncEZ0I+pH1MGC6Ab+onpye2z44DOknQsuHMzxvPISPerV8FIaqusKdZV+jPdSut581ykBbT9qjND0laWgQ0XTsFUvoF6O9k6YkdwfZ9TeqTEb2spv+d4+U8uaNgu3QuGz+uIqH7yBI1xf5aIA33MPOEx9jUDeW6nknxbOk/uXWOvGdR1iARQ0Bb9UKByRnaQnSgeX7QEktzz8CSw5c4jFgDMP8VgwG3QgVhRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uc9p6zrSHhCPvYNMWyQFqF4RF7abHHsxfJEnutSoN8=;
 b=t9WgmW35EG1vIvXpwvf8izil9RVndLMTeC1nq+TL3hOpLfmYXCNcB+nwhb+EJTciFaHS174Jp3NOCvorgmQImzSWV1fRjs2iOJ96NDaopWHwGTs3MBs7bVYsVoqp53/4BFVDUF/KCgI+ZHwGQdJFqoHjaQqkTQ4R5nStNpO7nnzKXHSQ5YhbU1VVQddI4cwcxs7Cr5LGFDoXjjDVhwIAw7isiK/BLNjHkXfluZcJovu6m4iDYyIvc3i0eVVqavfsetbQ/YNIMLW/+e2d0x0ConELol/RtjBk/zfh8WCaHEaY2Eh4K/Te0IVglzNP07+lCJNFEkm3mvXR0v+cTYD8Tw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 15 Jul
 2021 18:02:54 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 18:02:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        osalvador <osalvador@suse.de>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -V10 3/9] mm/migrate: enable returning precise migrate_pages() success count
Date:   Thu, 15 Jul 2021 14:02:48 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <ACF5FE3A-FD50-4BFF-899D-B1AA3B02F83F@nvidia.com>
In-Reply-To: <20210715055145.195411-4-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
 <20210715055145.195411-4-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C447C6DF-6C15-4619-9F80-BC6F694F513F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Thu, 15 Jul 2021 18:02:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1704269c-764a-420a-2491-08d947bac4e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4831C14393E3B9CC82E01003C2129@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tczJvgTAtaZ30KYMsm8+i+VM68+gwDmDIkC4bCttktmK4D2PDg3XncQipzgWhrgB6EzjtmLwMUfYZyv8QaM+0pDdNjGoY5yABjOFPnS2jje3W+PXYJSWE9fPKyQhHTEM3kmbWea4yB+sAbAL7Fh6HnNNhsRUBmgjiqWjJ4FnxH822qKS0noVk03u+iQUdy0YmoKGyje+8lTPc56D7Qk9PKwzTLBBufwmgQxfYame4iciTHxRZSlZB7QqAgAx+V1xuT6cpIZO5lMc6+qLotAxOkuiOKe/a5yyOrApJ11dc7Z2wwaKiJ2RGrP3r84ddYurv2mEjbKl1nNLpZsVCpBHAtLx+zH5jIU5Rjk73+KKW7lqwkJG3kl94KKR17CNYsF7PtkwOpB7GbBjbRDohqAo3k1OFzYEjYBy3bgJ0gwm4Bozem3OX7ivs91aTd7gclmH3zw3303BzN8puqBmfV/FD8WjC/1Jnn/Fy1eyHyrxkto6b9eGSeQoPx76tQqfFn9col1/gJ3qR7XT2IqNUHkRHWEUXSQhVTpaia6ycXEzx9mMhAYPimCExA9+YL0z6y01jXgoLAvPf4J9rfCl0tRueAtasDpgcH4gz9ya+GdYtnKOJbMQG2fvzDS4a5cvfWLWZ0SAq71SerHJEFZ9WPo5FNnIQi2Zdx/3K2j6ebvr1uFShKq3veSZi0qevUtvkXpVZbdTR5v5sImxP8xpaR9j/pgSELthu5O/Z9wi650PVcJefUaqL/gNp9Q+BD46okny
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(2906002)(8676002)(8936002)(83380400001)(21480400003)(38100700002)(36756003)(33964004)(54906003)(7416002)(4326008)(186003)(6666004)(16576012)(26005)(66946007)(956004)(86362001)(2616005)(235185007)(5660300002)(316002)(33656002)(478600001)(6486002)(6916009)(66476007)(53546011)(66556008)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVCOXU0QzNWNEpTUUQ5Wm1EMmhVOEVzd2UybU1JbzVxOHJwajc0anFwSnFw?=
 =?utf-8?B?ZDg3dkFES0hadmRuaVMrdEVvM1U5U2s3ZXhOamNvdW9WRkNMblYwcW00RjV6?=
 =?utf-8?B?eUtIYkMwOU9JR3BISWVxOC9Ua2tXRTFkZzZybFFtVDN6S0t6TVFlL2x2Vzlt?=
 =?utf-8?B?M3JnWUlraXVBTUVXNFVaYUZEWE43SWorcEhjMGZiN21sMmtwWGtOSW9GSlVl?=
 =?utf-8?B?cGNQbTdHQVRXdzZwUW5XdnBucEY1RHhaRCtXVlg1bW4rajQ2UXJSUXVqa3FK?=
 =?utf-8?B?cjlmeVZ3M3JMS2MrU3Y1Z2NsbGh4STNjNk5kdFRpR1Q1dUtFZmxTZVVhUHNP?=
 =?utf-8?B?RjNRc0o3Z3RhMm5WMWttWnlaRHQ5eGVZZ3ZJbFdpa01mSTNTQVFUc1l0a2t2?=
 =?utf-8?B?NkVqRHhGNzFvb284L0pTV0NoVUhFVjM5eHBMNWd6YVh3TVZPYlJOMUNCQlVI?=
 =?utf-8?B?RE5SNEdaT2J2TVRNRzRHUkNPTUFuUGlwaDJZR1hyNHQrTTk2Tm15bzhpR0lv?=
 =?utf-8?B?STQ3ek04SHVPTjFBcXhkeWpXNnVwZTlaK0xYTk5GcHdHY0oxN2xqREZ6TEJn?=
 =?utf-8?B?S0dtUGd4WUthOW5qbExOWUJFS1ZmaEhMTEVid2VUVjc3YUlJaHZtSVAvYnc4?=
 =?utf-8?B?WnYwREc2MUVISE90WFp3RyswUjRFVW54SnBvdGwyWEViVWZVMEFwSklodCtC?=
 =?utf-8?B?QzFPaVdjTGRJd28zWFdsbVVuTWxTTWcvRG4wQy83YjVyYnNGWGpxYTh5TmxK?=
 =?utf-8?B?VU9yQTZ2R3BEZy9JRFF0Q2lVZmJsTzMzUk51OHNuNnI5bytQK3BSQTVVT3Va?=
 =?utf-8?B?c2haNDBTdXhYRUZINWJ1WmtuL1BHT3ZqSy9BaXJtR1YxemFST0M0NnFLbjFN?=
 =?utf-8?B?Y21vT1htVW1PV2FtMklZSGdGelBUcFV0Q0p0cEplWnkrRk94RFJyZXJ3cS9z?=
 =?utf-8?B?emZ5bTJpVVcwTVhDZURMV3p1SjBXRHA3MVFjN2F4OEVNOTNvYWVaWHVVaDI3?=
 =?utf-8?B?VXZKYlRIZWxrN2ppZ0lrN3czWjkyV3poMEFGVXE0NndwNWV1WHVBZ1NZeUhO?=
 =?utf-8?B?MnVYNzVnOHlWRGhyK0Y4THNzb3l3TmlBbFhqZ1hFNzRNc0pHaTBxUGl4Tk9I?=
 =?utf-8?B?S1I4RDh2YUdmZEFORkZSN0dORUI3Mm5ObTRWb0NscVRHTkwxdndtUFJUYm91?=
 =?utf-8?B?RUlHU1JLZXNTdm9ITC9tYmFEY2p2a09YTlR2bHBKLzJ5OEx1bk5NRHlQc240?=
 =?utf-8?B?SWNIRzdPbHNvaEdsaUhEVGhhN2VRL2N1OEhFWWhnVkZrNlJ6dkQzYTZKQUxa?=
 =?utf-8?B?RUpaOHhCOWxMVW1XdkZFaWZZengrM2QxWDZ1SEswQUdXZ0Y2ZG9IbXJ0am9S?=
 =?utf-8?B?WEpDcEFmQlc3NDEweENLaFBFUTl0OFhrZXNITXlNODEwdnBCTSsvdk5pak0w?=
 =?utf-8?B?K09SZGlpVVA5YXdObFd6L2E3by80Wmg1cGlMbS9uQ3MyS0dNQisxZjdGSUlH?=
 =?utf-8?B?SE12QThGSi9hOStoS3NvQ3c4Mnd6WjJmMFN4VVFzY1F2OCs1cVNMMS8va0Nn?=
 =?utf-8?B?K2NnRHhTanZBN1FMTE96Y3BOa1IvMjNBZVJyMnBGbHk1M2lkYmZIT1ZLM3N2?=
 =?utf-8?B?YUJ5dytreEFaV2p2UzZhaThhdk1Ec1c1b3hPRWJEQzMwYmk4MzhYNnJlTDdr?=
 =?utf-8?B?d1FYY0plSW1kNE4rQjI1RkdHQnVLWkY1eGNjaGZCZzRzWXcrY1o4bmNtMkYr?=
 =?utf-8?Q?G0SCNSVUQ/xaqx4sg1t+U+szbRKtAQw99EkhJJb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704269c-764a-420a-2491-08d947bac4e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:02:54.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ifvyBUmAifBhhdcMiRbhDL/7s/+/k26w1XXuYKsmxqM1nD7oEjrmVymbTSmVgx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C447C6DF-6C15-4619-9F80-BC6F694F513F_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15 Jul 2021, at 1:51, Huang Ying wrote:

> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Under normal circumstances, migrate_pages() returns the number of
> pages migrated.  In error conditions, it returns an error code.  When
> returning an error code, there is no way to know how many pages were
> migrated or not migrated.
>
> Make migrate_pages() return how many pages are demoted successfully
> for all cases, including when encountering errors.  Page reclaim
> behavior will depend on this in subsequent patches.
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: osalvador <osalvador@suse.de> [optional parameter]
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
>
> --
>
> Note: Yang Shi originally wrote the patch, thus the SoB.  There was
> also a Reviewed-by provided since there were some modifications made
> to this after the original work.
>
> Changes since 20210618:
>  * Reword some bits of the changelog/subject
>  * Allow callers to pass a NULL 'ret_succeeded'.  This ensures that
>    callers don't have to declare and pass a dummy variable.
>
> Changes since 20210302:
>  * Fix definition of CONFIG_MIGRATION=3Dn stub migrate_pages().  Its
>    parameters were wrong, but oddly enough did not generate any
>    compile errors.
>
> Changes since 20200122:
>  * Fix migrate_pages() to manipulate nr_succeeded *value*
>    rather than the pointer.
> ---
>  include/linux/migrate.h |  5 +++--
>  mm/compaction.c         |  2 +-
>  mm/gup.c                |  2 +-
>  mm/memory-failure.c     |  2 +-
>  mm/memory_hotplug.c     |  2 +-
>  mm/mempolicy.c          |  4 ++--
>  mm/migrate.c            | 11 ++++++++---
>  mm/page_alloc.c         |  2 +-
>  8 files changed, 18 insertions(+), 12 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_C447C6DF-6C15-4619-9F80-BC6F694F513F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDweEgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK5FIQAKPLAA4E268qshh7ebT+Rl0it0iMVFtKA/xE
GLhff3qbIP+GcJRlfVQjR2L/kvGwL7bHki5gUky2TjMGMAQ1caGwOL961KcKVHAj
qGOtGvb4F6nM4YHtvqD++BDMKOilbiMlbRYFryGHSaIxtgacbtwRPQWJi7S5Vk5/
G3jH6/9gJ8ruK8ugdg/zChYVRT6AuX1LCgWBk5Qrwmxw11TLUO3aFW0wByyZPhL/
AVFQsYgBHNg5zg25Gim5odc5vRfqAQb1ygKPvYAbmSjUifORoZPknDnD5q1rT+xT
RAdELZIoqRAO9K1V8+vUqdIARlt4uuMPbwl00W200+CVQdLj7hmAWoML765leyr3
NiH+Oh9wH4Ls4kgTc5xm1eBdKVAT8+oUrhxXXsgbaFsZ4/9PWRupZVzgH0A0tPnc
NVcLnxnHmfkVmWxLZDUukga7DDMEVbG4+M+va3+OwE1/F6SAr9zfiwZknv3qMKH+
fTqanmZxaIpvFhKVWBui+UQijEJjCZam7OAZkk58RSHqXKK0/SQkDdrwnhf4O2Aa
JCu/F+ceADkfTdJ91mzyQVLHU6xgsndRjUyYMDbMk6BZamlH9btSDk49MirJOzhD
9g4LioaGFEcMPTxp05Au7Clkig4Z1AiiPsL7e7OLHa487Roj6ZFRuRRCLRNe3nt2
3WwQlvYt
=WJM1
-----END PGP SIGNATURE-----

--=_MailMate_C447C6DF-6C15-4619-9F80-BC6F694F513F_=--
