Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3030539C24F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFDVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:25:47 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:37472
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229665AbhFDVZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jllgIIANSwypGgfiydVe2vVK75SRzL+kD/YBvDLSUeA3QkjggE5NA9XQ8m6TskAFvZ1UE9GJDNsen7klFn9LuIx9iz23kPXHh/OfvOFzU6usMIwOTYNSLzwcVpbrT88xXsK7eRbUgU0h41X3xOBaDQPjLAq5XfNNth4RIr36W9EiyTADlym8jtsIbMcEKkG1KvYYB4fcmJWqWdbqZd/4fVk+YViLjR36hxD8H4oFR9e8uQ/aLv7gNa9bny/fCkqBR+zqn8UuUIqF2KTrCWFwoiZnFiHCi+MzOxuwR0T6mlfW9ETnHtTOasNSZMU4E2sb3ecNPXp7R9xE+kV8QEYcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiAno8u0vIwj4LK7fmMGt7xf5m9ZMoxZl0huiVpyzdI=;
 b=bDVVV19arEFwnld2NN1jBomQ7ULoIWAFf4MIWBza25P/u6RUIWV8Kzix3yCBlwJkwHi+6IQFW0ctrCY7MgOJB8AZ7waevPDoU2moIZag6WbKjbtyAXy2KiUHnjwJsBEm74LqEHCdP4/iNV1hiQNnLPY2k83PEN4E4Kw1Qcc/l4CZ7xooxQHQfpyLwC+sEJeZPRkMjA8zdgPJV2IfyKC/oIbZoPM8/xAK8DeDCS6AJqKWPQ3146hx/q2IDaltntV9SuViEY1kUbt776A692kAN6HP7TLBZSBJhQs1Ol7UuAGrXyKhHsU2muWYl/YCzwTrNs9D1g5nVZPkdzMWrlz5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiAno8u0vIwj4LK7fmMGt7xf5m9ZMoxZl0huiVpyzdI=;
 b=fpG3Bx/G8e25yIlUUzLet3RD319iDkjepxPk0yTBAB/zhCfDy6xpOgEmOWTiWShAU9LqiG/Hmlt4OqKgGqTrRUjN5vHZZOkTBaEcHVssQFzqcFGmNdOdQ++Vi+JD+TwQHliNU4aUc2DUOt/Tdw3yYW8Y3hsPvTukwlnYvHpzU9GWnRQ++hsIiE0e2sD1EXhOOsb56bdHTibBTVVY8Wt6Ll6qyyWmFJOJinSHI6DFvm0fh+xFicSq/bTGEF73Xhq/kvtetkmjuFNir0wPusfNtbqKulu0m8e/Yy/xvymocIQl5EyNfObyIaPzYz/W8B3xVVDqqFPWoPWRUTzz/7tSWA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 21:23:57 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::ccd7:fb49:6f2d:acf2%7]) with mapi id 15.20.4195.022; Fri, 4 Jun 2021
 21:23:56 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     nao.horiguchi@gmail.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Date:   Fri, 04 Jun 2021 17:23:51 -0400
X-Mailer: MailMate (1.14r5809)
Message-ID: <DC3A8596-DC59-4B3B-8BA9-A0C2432552DF@nvidia.com>
In-Reply-To: <20210604203513.240709-1-shy828301@gmail.com>
References: <20210604203513.240709-1-shy828301@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6C4579B4-3DC9-41AA-BAEB-B1150B59805F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0404.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::19) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.80.67] (216.228.112.22) by BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Fri, 4 Jun 2021 21:23:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d3b4c48-4f12-4049-0f8a-08d9279f0fa1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915AE3537B0BDD1480F4A6DC23B9@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rsx8IIoGq2VNJlM63U0bw1CY/DvqKr2kkm3fGR2+Y2AysLe/FUircgbmJcjhtRpntfP7+1Wy78HZwmTCpJEPMQocbbYLOTUUxHexYkFSa4vwCdeqfFgn9IK6IdsMd4wgGfqRwXS+CMlvGxoL3N0wQAYDMM5lMIiWvLWrOFLZWxJWzuOVAhfjea64FvyFGjub9t98WdRVq/iw4fJNfTydYyks/bNn3kNSlSGntUfbHSQm3Ws8RfhTBbMuWe8PcS2yjD2ZyUQ2REeoJE5ydOXfpyUIDCy7+/p60S/maB1IkZx+Cu28sllMRYfYojJu9Ytve45smpfU9tCm0TIryL20qdipEOV4dYjC+IH88xYKZ8a9YcKuij/d5pe4+dwMBNEkyJ02ITEexOxxaX89YG5oooX5y7jIM2P3T0YZH/yJ9RcfIkDnpO3tdlFiuMQqjfD5kZuIXsPLeOPdZIrUHHuBgCOmW3Wc9IOBE/iz8V/mziAuH16jl61OKGxzJMP2Gh3g1ZibSbadK7NQ2CbuNYB1ZQT8gA9JbfC6u/ptPgF8WLQblsP9+oGaXe2zU8gd/bAsAVMmBZfTC1VszwPgBmEP6GieUAKy4+STBCniJ3IyhglQIqbgOBEGc+3vAP1a11vwAc3YShQfiHfNsj2kj7p9J0rx1ai6cFG9SWIOJ8WU5vJqVJgIDxp09ZM9mfvd6wO4q50NwYBMXgUhQUk8UKQ9DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(16526019)(21480400003)(53546011)(186003)(478600001)(26005)(8676002)(6666004)(6486002)(36756003)(316002)(6916009)(2616005)(2906002)(956004)(33964004)(66556008)(66476007)(86362001)(5660300002)(235185007)(4326008)(66946007)(8936002)(33656002)(16576012)(38100700002)(14583001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHZTeXRyWW40b1JlUTY4Uzh0bkZXV20vU0N1bXFZVjNYc0VuWVNGTjRTQ2pK?=
 =?utf-8?B?dzFNMThLdWEyUURWeHpYaVBKa3ZWUjlWNEhFY3JXSUFxbStFeGkyWEdJTmNj?=
 =?utf-8?B?Z25PWHZJSUx0enkxRDhGYktCWExrcHFJcnFpcUYvTGNXZEJ0SkF1K2krZnpj?=
 =?utf-8?B?ZCtqT09GelZmYUNoTDFFRHZmZm1WUElJamJsbU9JSVpyNHB1UUNva3VHWS8z?=
 =?utf-8?B?L3lOTE9wVHZJbzE2NUZHYldidjRjTVJHU05JejNlV1NYZzZaUVdQK3JISmhK?=
 =?utf-8?B?QXNLanA5eENzVnd5NlJJeEVzdW5saG1leUlkM2tidk5jZXZhUnZINk4yWlFT?=
 =?utf-8?B?aVlNV1QvdFAzT2cvT2tkZ1BxZFRtOFJvZzd4NU00M1pFeDB2a3ZuQW83OVNT?=
 =?utf-8?B?dUxOSzdEYkFkZ055aEs5Tmwvb1UyT1YvUXpRZUZMekFYb2ppRWhFZkpRLytD?=
 =?utf-8?B?MXc2SldJM0pXS21uTmlQVG4ya3NlWjRRMTJyenZnQzhxV3VBb0d0WlJrRXZF?=
 =?utf-8?B?QzR0aFJzUFdtdEZjNGpYVE8xQW1YQXpoeVZ5TWFqYllnZjkvQjQvVFRaTEZ3?=
 =?utf-8?B?VjV2c1VWZ0hxbFBPZHg3ZHJNU3V3Vy8vYzlLbUFVdncwYnZuU2xtSG4vbmtt?=
 =?utf-8?B?Nkt5ZWRZWXFOUTJpQjQ5L1IwVElOaHJpYVRoS1E3UVVPNm9uY2lpZGtEOHRO?=
 =?utf-8?B?RS9VbW9HSjFXUDlKOS9Gdi9seHBFZDhCM0xnQkFaSjJqZWlJRlNOTFZnejA3?=
 =?utf-8?B?blp2N3NqSWtPZ0FEblFXZGxvdGxYQ3FhdFlQaG45UlNEK3BORGpVeDNIc3ZR?=
 =?utf-8?B?dGZLdTJPVVVpTWZVNGx2M3pVZlB3L1BCMXhVMXJiUkVzL2tXMXhsWkhBdUpz?=
 =?utf-8?B?dFF0TStpSEloSnpzR09ndEhCWFVnSTdqZUdsMWVQRFN6VjR0Mm5XR2lqdjdp?=
 =?utf-8?B?NHExUDVySnN4RjhuUzZHZlFzTCtUY3ZpTHJicVlkb2xhSzF0aW5jdnZndUd2?=
 =?utf-8?B?S3dXVnBFVXFuOWxrLzVueENYZXNJWHJQVktBSlpocmpIenBvU3hvancxWG4v?=
 =?utf-8?B?VUpUMVRsMFZHb21CN201YzljbUNCNlkrSFhTVVNtRENaTVc0TzJTTzFHeWg2?=
 =?utf-8?B?eHhSR3pQOEFOL2ZyREdYUkU5Zi9GTGhOOCs0MGQ4NDBsTXhKbnhiUkR0ai9l?=
 =?utf-8?B?OGJmRmZDeEQwbjJ5VklTenRTajg0bnZtN2Q0dEhpSk40WGkxcWNnUGhPNUFk?=
 =?utf-8?B?ZXJEWXBVMWUwMGtNY0p4VHcxbU44QzB4NVlYTG9JWkFUckRwRVJFOXVhS090?=
 =?utf-8?B?ODRKKzVDNzlSTFVSeU55d1NadVRweVpEZDB3dkRnRjRGa3JBNzhqbERCbnBk?=
 =?utf-8?B?eTYvcWI0Ly9Cb1Racnk4VUxFdlJua2kwNDYvczBaNnRqZUZTVlhHYXV4MThC?=
 =?utf-8?B?ZUNubGNLbGg2YlhKMzNxQVJuaGp5Y2l2cWZiUGlhN1Z3RzZFa0tPZWV3VzNm?=
 =?utf-8?B?OU1VNWpuMjRhNlo4NmtGOUFpQTB5ZzU5U2R1TUlWUHErREtwYnh6REFKQklj?=
 =?utf-8?B?UStCeUVXcE9BYnpiWEtmV3phZ3MyVEJhZXNIck1CR0Q1OGEzSDVKV3JUSTVx?=
 =?utf-8?B?WThwQUd1dG1QOHFhaWRqMHNKcG0rSnN4aWowMXdqNEp3M3hUcmN6UmF2WEND?=
 =?utf-8?B?cDU2ak9pemhYYTlMV1BURFFCejBweTJyMlJsWlRGRGVGTGVLam5GWmhycUcz?=
 =?utf-8?Q?2QjDKeKNSsqraxF2KyWHZQPwgtFijarfk2dSPNG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3b4c48-4f12-4049-0f8a-08d9279f0fa1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 21:23:56.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deGbLStg1wYkxpyx8LokX+IKGjjLe91bT6hdtmjlj8nCwPhZp+lvqFgKEMLjvck3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6C4579B4-3DC9-41AA-BAEB-B1150B59805F_=
Content-Type: text/plain; charset=UTF-8; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 4 Jun 2021, at 16:35, Yang Shi wrote:

> When trying to migrate pages to obey mempolicy, the huge zero page is
> split then the page table walk at PTE level just skips zero page.  So i=
t
> seems pointless to split huge zero page, it could be just skipped like
> base zero page.
>
> Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> this case.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_6C4579B4-3DC9-41AA-BAEB-B1150B59805F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmC6mecPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKRbEP/3LwzUGXtUKyviACA9KB6FqBy4dTPpv5TBDd
0pD3NXi7AkQsh2GC9tRl0i3K5FGLuDRzNL5f1qnAGJ5yLzPvZgSHKaAbk3YRDvZ+
Vz64lTfIGd2i4mtU2j3yE300ZfyDbuCLPmynw4hA4zaTUD/HkzaoBEnMHhXiBwJz
Su21uuCjuAZ2CTc4Q6yWeStbYOuqRThs9K/YOP0+o4kIwnBciUOg57lAI2D+JEHT
Oh6bdB378+Te7vOSnbml1RBLDG3tNwnkR6ETqZIQ73KzY5BaKzrZ3GHqEVVc1RjK
GEig/y81zutHfpXUtHrFs+6qhsTGZbSPWLMgQEQp6JP5bjo6viZUT9DdIVSDBN9L
UUOagXYJ2U0MVZqK5mFvq0YoCJihlkJWO3kzWGFEv723MEUormY5tHi/YIT9sDfq
xK+UHiT6dPdKf4zC/Wn54QtISEi1MPsgJ7SIxOHv+r688vIwukBBU5RQh2SqtXXB
/Esb5uagkOAxOTteQoJykfEu8m3FH2iLlvYnF4smsITb+6iyNgwFpUBdEWnHV5yE
WOaaOFTXF+y0Tr/QutWR1j9A9svZaI+gkYkaotCcuIqX6q8mneQVNU7aY83hrbh9
DuzoKca08v4X2nOsHDfEBNCMc1v9s2vcmP1H+eUr7Kt1hSLCgxpD/c2br6jay1ji
4v3kQtWV
=/DFH
-----END PGP SIGNATURE-----

--=_MailMate_6C4579B4-3DC9-41AA-BAEB-B1150B59805F_=--
