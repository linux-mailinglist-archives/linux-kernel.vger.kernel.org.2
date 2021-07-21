Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB53D194E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhGUU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:58:18 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:51680
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229597AbhGUU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:58:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3P66cibWR6PN9Hatt3Cyn+3DlJHynmgpNjyOKrYPfzYKR4siYoAaS6wIn0/pifcdw1/AJ1oSb8SuxB7UioJKmOz7CAXIV7TCj5T2puhwMXSvOWuQzXAW9nukx64biMnRy3R5MQubNo4czcw305ba0ku77iF/t8Ow8KccTPYoqLSjDKdgKhClIuqv/pY34zig8ixpYjy0/0ozzUhZrlLjaOQoGNqhiy59f2YTebjTkK0Ujf9sxzjerXuLBmtq6qJtZRapO2i0zA26Fc1NdQVexO+hby/evmeox0tQ4I247BBBx6BCixYkKQwtbdOpAtqER1oEY/cph43Tm+r4HPTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybxPnST5HuEFuD1BlDX7aqWGQqMruSdLkSlZeHMM01M=;
 b=kEKDUWA4tlF7PQ80eCQGUt8AVw2ojacynguczy1ss+GfmQ1bklheVDYsB2CKLo7MM25MtC0iGBrBKooxLLEc8UR3KCzumeevlQjmOqNO6akrKI9cmk4U+uZ2rrIuSbqL/h5087Toz2t2yMNFmskqIsOV8uAuryHtzjIQLcGuqJt0ilfg8gBh+yzb1ektQOWNIZrlPIDUaYkw86jl8oDPpyR3qPAnCQ3imCwe62ULhMd+qTVbV/IomQMANt7yojKlsUQule8fYTwfBWpcF6NJSQgGsvbn40ebNSGM7DZbGUzVHq0NuZvv9x4I+o1X/oYfeDBIXJXANCLnZWNGgY4XOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybxPnST5HuEFuD1BlDX7aqWGQqMruSdLkSlZeHMM01M=;
 b=Tu5ZT248dTPDaHExb2MawW7mVyE10UNukzsos3/9Y2ungN04SFKEGyg3vh5I8xpr4AlIlnzymQLjx0OqwhHWgacUvvKNc02ATXIzIpwp6/6EweT3fq4EjKx2uKbconmQVNbPD4Jtl6UdWuPqv0gZL2EraEYKAlxgFnfEhQXpUz584rcCpdN+HULDb+Ss6yj7OY0Z5JZ6Y8EwmCesYjFOpp18mEWeeqytASjSQxil85agM5h3s3CcAfTCWR24CmfENUSc838hpKHzREhagNhGtflBSpSj9Kx2UaVitW6806QZrKJdhNh5aS33Grl/IpVES5c8S09mWWQXSsvV/QKv2g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Wed, 21 Jul
 2021 21:38:51 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:38:51 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH -V11 8/9] mm/vmscan: never demote for memcg reclaim
Date:   Wed, 21 Jul 2021 17:38:45 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <43A1CB83-6127-427F-94AF-40CE1B283BE1@nvidia.com>
In-Reply-To: <20210721063926.3024591-8-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-8-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B1EDC7E6-C631-4573-8A8E-31071A42A683_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0370.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by BL1PR13CA0370.namprd13.prod.outlook.com (2603:10b6:208:2c0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Wed, 21 Jul 2021 21:38:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee5c375-269a-43c5-6452-08d94c8fee8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40806443FCFF5BF1171329C1C2E39@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/G5Q7u8bHgblgq1lbPkFmdldev5NXrutVaIVTI6CCZQhctwMfKOrqCYgpZEt6meronbfMB6KBHYKOfBxmTNe+/4jw1coGXTNPyFGkvb0xvenm1r1xnF2n3mk+qfRJsC8BVxLFNoAVgJAoopo92IlnP06B+6fEtqMLmoqDy1efRRvzuMm9tmXSQLQ2thgEp25ggEpRXQiLA35WbD+54cxG+J+h4agIohu57rgZG0k0qgyqM+A6YYewfEF19an6GOlC8ppThFYupkBTElTmRDd5mr8AxeXa/qXulFw0WykgYnXJcDKXbQ6vN4ELHOjH3Cwte1k1dC4OMav+6rvtQQvbcAaC3Cg89k2MWJ+CcEcIWKfH7E0xfgm+W6sbV9R1V8kmblL9v3bx5dUNBSe61ar+JQJD+WUvlCZUNhP85DFp86ikfwwMbDbQpM/INJXxncnJDyDlageM8d3TN5IOEsuuaPIrrSs0WIObt+wquaQP/glOXRadZMqm0pSgzkUrelQpjVB+A3QABnIa692WyEoYW21wYXMiq8BRBnLkKa3ogLfOQwFaq8KHA/4l4vjvzEq9dmJwp3ProqfOdgM0EZSni7hL73d0cV9Jhras5TwYYgGbtU4J2zNo33XywsKKmKaKsZn8YxW4k3UaT5WCXyVg4pHEAvog4XyonDIS+fGcIH6ygokrxPp9fI/VbWBy1G7ZWiKa/jLJyIuVMGBT+28//VvGyOFmyU1D/x/FoIGV/Rv03agu4kBEKVbpmY1IBsCrs3txSdoDKmd2ndERnNXKOFe8zi+Gjyg0S488qegAiglN55lPSGjDgo8mKrMKpW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(33656002)(478600001)(16576012)(38100700002)(8936002)(5660300002)(6666004)(2616005)(8676002)(36756003)(966005)(83380400001)(7416002)(235185007)(53546011)(6486002)(54906003)(66476007)(66556008)(6916009)(4326008)(186003)(26005)(316002)(21480400003)(2906002)(66946007)(33964004)(956004)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlB4NzFxdlU3OTBwZkhwN25SRFZFNlFLWTZkMzI1dWJPdnJqeDRyajQ3dHhZ?=
 =?utf-8?B?QW1hd3kvTmNtbVQweFNWUnFOc3Bjcjk2ejArektzcmhFWWhjemdTWHBBVVZJ?=
 =?utf-8?B?U3FZR0FtTFM4NGVFK1JidFdsaXRwTDlhQysyUVh5OHZJOVhBWXIyeE9Memg5?=
 =?utf-8?B?YXMvMWhDQXhnV2tZNTVnK0NDdUx1R3RHa2IxWVg4K0JEWVdNaU5DRVMwSTJa?=
 =?utf-8?B?amhEb3FmNmZUVkgrWE8rSUl2bGxld3pQVGVwdlcrWTNZR0xrYVZYbU9pWk5x?=
 =?utf-8?B?NDdOZXNlR3FNanRWT1hSTW9BSzgrNGxYODhkRzFmL3BhbmxnRG4valU1ZXps?=
 =?utf-8?B?clFjeC8zNCt4dnptd3U1TUt1WEFRTzdyQTF1RWN5YTF3ZUFlYm4rbnA4U3c4?=
 =?utf-8?B?MzJ4Wk9aNXgvOUJ4UEg4RWFZSmlLcXZCOHcwemdDRXJRa3RjdzB3Q2tHcHVl?=
 =?utf-8?B?dXpDa0pQdzZxRmRYYU1CdDU5bUZxK2xQNW11VllqN1g3MnNveThSZEZHNy9C?=
 =?utf-8?B?QzhpbnZvb1RMekZ0UU42RUo4dzQrNldrVlR5cGJUQ25zL0xUNFgxMm9UK1VG?=
 =?utf-8?B?NVd0V1V4b2xjeE55YVh6cUNrWFlEd3JweUczM0M0VFJtWDJMMThoM3EvWHB5?=
 =?utf-8?B?YVFSZkVPa05yWFNteEJxSzNmSW0xT3RBT3FYMVhpcUl4RkEvaUdUV013QWxx?=
 =?utf-8?B?NVdsbGR1NG5YcW42RXFQY2FNaDZTUWRORnlIU2VVd09sK0JoeUNrck5BV2VI?=
 =?utf-8?B?Vnk1SjRmMFcwUzV0a1djZEFyVkpOWWhaanpUS3kzWEhaSVJqWUQ4ckNESUY4?=
 =?utf-8?B?dm40cTI1R1d2SU4wRXZJakdHdmcvK3J1NVgraEM0TzVjUXBtM3VWSVJGQmFx?=
 =?utf-8?B?aS9jSEhQaXN1bGhYeXlCeTIvTklnaEl5Ynd4WDlqT1VhelZrdUV5aUFRTU1Q?=
 =?utf-8?B?Zk9SYWpSUDF3Tkt3LzVtZS92N0VybmJFcE5iaUQrVFpRTUNlMkVPRmErQitw?=
 =?utf-8?B?d3FWOGVMYUpxQlFCN3lEc1huZ2RkZzBzZjNiNG1aWnQ2Z3BBUC9jbnk1amFp?=
 =?utf-8?B?eU1KZm9vYk9aS2tuL1VSaDdtR0RCSzZHT2drdjVZQjV2Q1FrQWpETXRwei9v?=
 =?utf-8?B?U25xUGtRbFVGR1dPT0lLQStzOVhreEZobDZ0dXhIQmhVU1lBaCsyUk5tWFFv?=
 =?utf-8?B?WjlYWUx2RHpzcktRcUhLcFBnM1FFMHRqZEV1RlV6T3A2TGxscUlDQnloRklB?=
 =?utf-8?B?MXhOaTlSbDhvK3FnRnhLQTFGRmtSWUZKMmVFNGxZWit5em1NcngxTzRZMndW?=
 =?utf-8?B?VFBWWGpmSVgvZVh4bDNqQVBOQjlaWllHK1JTMnhMekdZc0hEY2RRK0FRT0Zl?=
 =?utf-8?B?UzYyQVlPUDZIRzlicFZYZHdEQ0N0NGR5d3lsdWFNQWN6M0h0aHJENW5yRXA1?=
 =?utf-8?B?cVF5YTFqbU9QUXBLNmFVMUlBeDdYQk52M043dEREMjBwdG5hWjdLN0lpcllL?=
 =?utf-8?B?Qjc3eDBSaXE0MkUrMGpocjZpZlh4SS9sVitqeEs3YWdrMlVtSXloN1RvSmNU?=
 =?utf-8?B?ZGhYbTA4RVpjcW1TK0FxZTRlcUxtTGdQMHlPRW80VjAzRXpNOVBWLzMrbzBQ?=
 =?utf-8?B?Y2UvSW9nc2hyK1h5TWh3V1pZeEpOTm45MEtmR3l5emZpV05mVGdUWXlqSnNZ?=
 =?utf-8?B?Yml2aElrYzdISXdLU0dQS1IwblUxajljckxQbDFydnhTd2tITTROdnQwdkxS?=
 =?utf-8?Q?Sedltu4Lm11rtQ6SqMzLjMKc2u7erME14s+oU9+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee5c375-269a-43c5-6452-08d94c8fee8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:38:51.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9TLUb4efa1QNTlgWMi4pjtg/TWOihkfeKRLFn1Jer+Bjz9U1MiAwy/XmjZ23tGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B1EDC7E6-C631-4573-8A8E-31071A42A683_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 2:39, Huang Ying wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Global reclaim aims to reduce the amount of memory used on a given node=
 or
> set of nodes.  Migrating pages to another node serves this purpose.
>
> memcg reclaim is different.  Its goal is to reduce the total memory
> consumption of the entire memcg, across all nodes.  Migration does not
> assist memcg reclaim because it just moves page contents between nodes
> rather than actually reducing memory consumption.
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-9-ying.huang@inte=
l.com
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>.

Should this be folded into Patch 4 when can_demote() is introduced?


=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_B1EDC7E6-C631-4573-8A8E-31071A42A683_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4k+UPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKe0AP/jOB76epG49N+ZXkWbO0t1lefDjP4xMpskDs
nAadE7nCZqRk/+n33Py6My7xghHq3mWrVdv0cdiWKzipdbf8adcXzhzJTGgtwCuH
uXpybOf5OweYCTMl+Y8AAqXYWoZgjoN6AzNL0omqmsRDhaqJIeCF1zg2tABjewIA
xwa7rmf9cexlpRMW8PmiXTYXLG01BfNDO12o6Jv87jU60594dMWB6kvs8XT/5PLP
SbXWazkifQqXRC9ynBNYkFEOu7becUNJC+Kyu/r6YSDhXilZndYan5uNnpVTUVa6
ACAHHXvi4n/td/Se4WpHbGR5rmlxYKhLexi4mo47F3svBlxqDMWKCVh9oVT3LtBZ
bWmV86paT8Vn5Ye4Y67CTocJdRlGW+eH4uRZdkUrPElACDzF7lQWPCPMkqIT+L1B
gRVz6nV2ssFCy5NCpNAbBge2XxVTBOPI8Cl4xM9DP9uJGY4+CACHWLz1M0JRCyTm
fSF6uEWIE8GOYwKobm5YK5O4KPtHCUZFQSYKbiMzbJ5xVCXIFh/w4P3BAgSeXDBe
PSAA0J07Rfq9E3O5ee/GzjS8UDHOs3q/OUr6HdAX9aawhQiTL0Iwo12Jn6DIvkTV
H4CO0ATXuME9haWSiGlgZPwbofeWlk4kEnK/L/xi5N4iUiuWF/UMbJ6EZMXq8whh
BP0f2pcD
=Y3mk
-----END PGP SIGNATURE-----

--=_MailMate_B1EDC7E6-C631-4573-8A8E-31071A42A683_=--
