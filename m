Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF73D18FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGUUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:40:53 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:43744
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229749AbhGUUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVSmr1fqEWMCvAW5uUths2VZ1k1MPfsKehH4yfryGCc1t4iT8RPtG5WHHbOdQJqD8Drh6Y13OG5XvoDGdIZcD7MEaoVUDmEF5IJJ0XCaZMLT6te/exHyAV55IAc1dqldZtntca7uAIyYtYNV/Ye30PKw4oHPH7dszYVxLasPVPpJbHOXEOqWfeCt6+ld10wIwdCP4pj4gvzOVG83IWwNI9wyMpe2rSLhrmDsnqUwERlRLpBTPbT5/OOpK2wesd0d4nVHmF6gvTYCOsp0mQdes5e0GMGeYW7xPBaP9f/464ml5cCLs7rsTzD45P6T+DtsjuI0UZun+DBfS98+ncI6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuYd6wdZYvHgbrGJYEOvy3p7h7bWQ5Vc0JGsJNPXwrQ=;
 b=j0iACJhrZeczlRT6u3uJlwLyGaWPJK0RALVUD19uWEQk/Ok8N/w1ytTJcqsHBklplylYLDf1DMW58qelkKy+cJqt6cOPq50dvtS5D4ZjnKLHKAWZbW+tnSAfBF/MCN6CaJLfJvnBLT6UMc5XCBasTcZjhv4UT86FBc3R0bc4So4hl397lHK1kAA+ef9hLx2tXGq3SvZkee+NS6E8l5KsZ69mk+M/nwzsrQzK3GJoATSUcqLaV/JHHlkKjUdNif/eb2j1XIto8qpv5jj3+cRGwT3DLlbkGYFUPARIDpXCvYmUheKK4omgBJ1jlMexBKps3K7fGibo4xtDfBtbg00w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuYd6wdZYvHgbrGJYEOvy3p7h7bWQ5Vc0JGsJNPXwrQ=;
 b=KJakeKiPDPcvFzgb4b5ht0Ob9lfZ8dMVP9GIcP+fXrHoVs0WS8zXoSUTdpqyiGztIpJQ5rnDf7og2HY+4LW6FEKTNF5u55A6AgiGHMg74EuV70mCbzPSpaE/22MLG9EPv29Osb617B/lJThGlRx4tZvHss7Fu8ZamlecGt7lAsImj6nLrw4fz10zuwWiYGXmtL5hvVACnfSDeDrK+RU9vwmCebiPAcp1RuHc0x3iu5vU9ApqEuCLnwpBrHunSLYC3eIDoiF5zIbsFePUj8FV8TTHRcokqh7csqsegCYEcClNCFYmT+TREcHsgfSXgCaTchtDxcTesRuqdl9t3cyd7A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 21:21:26 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:21:26 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V11 7/9] mm/vmscan: Consider anonymous pages without swap
Date:   Wed, 21 Jul 2021 17:21:20 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <43FA897B-ABFC-4C52-8DFD-8BAF992BD0D4@nvidia.com>
In-Reply-To: <20210721063926.3024591-7-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-7-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BF9DAD1B-67EE-4C3B-9EE0-C3C40EC9816C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:208:23e::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Wed, 21 Jul 2021 21:21:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f19d3676-1a25-4bf5-9daf-08d94c8d7f4c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB249913EECE144C297A359594C2E39@BL0PR12MB2499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h1UoAGM3xesWWI8ytbB0VTX0ZIX5Be9XV+sFw4PsETI6Sn8RN4pOjAyNv9LGGQYVfbwoNkFGvK5Phr+qYy7BX/WZTJtfjT2byeWgPb886YaZA1PUtM2+R3B06hsXEyW4k/1HCOOk0VexUZblvdbCoeRp0Qc0omkJso4sgsBG4f2QaPdDYCKqnR4rukPLFcBYw35R3mHRWC3A+Ytd7e5gKYaMFenCYGHwWTV9u8Z03jhlz60AGu3GbDQGinXWpaYd3uqAZ5I8gnfwllWp8ZNr0uKTCPwS0VR7isCzDy5xW1ie4PHjzpazKRr07rWKKNxptWav4rmG8WynmZ0OOsv+thvBQdCBU4zYzJ9NJ/v/XPV68D0Yte5jjCdSGCvQ/ZSaOrSvCfvsmVWOkbGmL+9FA2zX7hSS+XbkqZqyqiobm1aU24v5UPPqHGDRoQ2OXvoM9CFAQ9N9Cj3QGVep15BFnPlkIjey55hKqC4EuJDP4cisoq6/qXttS3CRdp6eU8bci9kxMgyne28A1F8El+zv70Vqr9aE+3R9t2SkE4lZXET1GLWi2LYC5+ftteH3kWr393mwvc0QzuBhO1ocMuCf5jf9yQtuGwTLunk/PFHL0/F8zk1oHBz7fzIEQUF+XfJOQt+azZS9Vc/shiRTr7KmWt+AhR9L0I4mNOuqKiOxphQ9zasTaDtYab0gf2icVBPdG31UuS+puskjxa6EDju2mmTG1UShK8LTzQEgdCi9ilGL4Zv5Vk3qqoC9y7Wa/0WF0An+pnVLcIOhSabLpjD6UnUhZtIM7Eue6SJ0dLlGA7jLB0ri3hJ6dR/ED9s7tT5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(33656002)(83380400001)(38100700002)(86362001)(478600001)(2616005)(26005)(956004)(54906003)(186003)(4326008)(966005)(7416002)(6486002)(66476007)(21480400003)(8936002)(66556008)(8676002)(16576012)(36756003)(6916009)(66946007)(235185007)(2906002)(33964004)(316002)(53546011)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1PVDc5aDVQU2xGL0VrS2tHeWZScWdWaDdhd3IvcEIwMTViamt1MlNPMDVv?=
 =?utf-8?B?dWFXQ0ozNys0OXpPUCs5amFkOGhMYmVoL0RxSmgyVnFMQk1VM3hrL0R2aEdX?=
 =?utf-8?B?RjQxeWk0TFlnQ1c5Z2ZJT0VHSG80RTRmaEJnTzJTNGUzazc3R21nUXhWeEpI?=
 =?utf-8?B?ZUZSenhvbDRPWEUrbVVOSEZJN1FqYlZidTN0YU1RcVk5WkpOOUpaU0kyZ2lo?=
 =?utf-8?B?WnNzUDFhYzJZcTZZOTFsUElsV0dUYTIvbWJEMXFPcUNXUHlMMTMxRGd4eEVJ?=
 =?utf-8?B?YkZrYlRqZVd3ZnUycHNoN3RsVEI0Wno3bStEVnpmVHc1aVZLQ1lxa25TVnBW?=
 =?utf-8?B?UnpxaGVwZThLVTFhK0p1Q0Z0TFhsRSsxK0tDUDFWM08wK2R6UWdCbWVvWGhI?=
 =?utf-8?B?NzNQM2RvVy9tNFp0TXJtZXAyNENDdzk2WUJCUTJzOUh3WmljTHliWnBUa2s0?=
 =?utf-8?B?aWVuTkxkSURrY05NNHhsUXRUdWFCR25wbnZ6ajBuR2pLVTFiVEt3enNaTzBK?=
 =?utf-8?B?YVpoQVRKUG5EWGNnckdyRTVBZjVlMWR6Y3FrQVMzTzZJMkgydUlvV09Fd3lY?=
 =?utf-8?B?MnhHK2MvZXZrWmU1WnY2TzFBc2pFVlZjSTkxckhPWWpnaENlZTZCU21PVlda?=
 =?utf-8?B?bVAyakxpSWR3Sm9HR0tBR2t6OWJTRVZSK0JvVEdSbFZwc0plbEt0SzB3Nk9x?=
 =?utf-8?B?a0dvN1VpclhrdndvVXV6cEd5ZmVWbmRkRWtoaW1ONk5PWjdWYTgxK21Wdkov?=
 =?utf-8?B?d3NzbVU2Yi91Zk5rSTkvYWVwUkpjNWhLTFMrQllQclAvSGVzZVFrN2VJd2ZY?=
 =?utf-8?B?RHhpMXQwUWpyTGltL09XV0k2SEZsN2FlM3hrTUZrSXRMdDJkSXV1aU0vYW44?=
 =?utf-8?B?VEJvdFVWUDRpSEhhUkY5dVRJcHV0L0VHeWJTOVZWcmNUTUg4cnAwU2RBM1hV?=
 =?utf-8?B?M0MyNmJMR3N5TUdUcC9vTFFTZjNNeWFjWm5nQ3lnaGQ0SUp2ekxXTnhMSFhN?=
 =?utf-8?B?WkNkb2UrN01OeUVQejBPR3VUZFNoeDlEa21OQzdRYTBxM2RFbmQxVURneVFz?=
 =?utf-8?B?OGtOM0ZJODNUUTZoZGtkZjZLSWdoc2p2Wm1hSkN1bGVOcjlXYmM1dEkvOWJp?=
 =?utf-8?B?d3NxUlhtZjhxaU12eFZLdElkSFQvUTlJOVFrV2pLSVJiaEliNHVjVVlaeWl4?=
 =?utf-8?B?VTltODBuYXZsUWNORnBiK2lzakNCTDBEYmxGb29rb0l0aFB1bS9nak9DWUx1?=
 =?utf-8?B?SWY0dVF4VUZZcFJOL0djZGZVZ3d3NFo1MXh5bHNRcWdqdk9BTlJBNlFSZ3NK?=
 =?utf-8?B?Rnpyam5ycHFPTXpoT1dKL0cwNno4MUVLM3RFakpUM0czS1FtQUttZmVPS3VS?=
 =?utf-8?B?bCt3eVFhckNxTUhoWEdUdHRKTktaaTNybWhSYmtsNXh2MjR1MmF6Z1FxOXgy?=
 =?utf-8?B?ZVVLVGw2VUF1NE01RG93WXNXWXpqenBwSmFvY1BGV2E0cnp5cXljNS9hMzBM?=
 =?utf-8?B?YTlKK2hOU0FuT1kvUERSSFptV3ZEV09UeEduekhiQ3YzZysxbit5VndtTWVO?=
 =?utf-8?B?UWtFM3NFWWhwVnB6WG9EcnYveWRXMitlcWNKZTlTeXBpb2tqaUNZdmNPWXpF?=
 =?utf-8?B?amZ3UG1GSFQ4S2xKNUNualRDZHNsTWxOT2d0bFdkTTFBRTZNNGY4Y0svN2xC?=
 =?utf-8?B?alp2cEhQNVRxOHo5T3NSQXp1RXdTQ1NmTGRscEt6RExiN0ZqK2QxRDYvOVRa?=
 =?utf-8?Q?b/JcrHiici49GdPsAGc0UhWjH6rH7dkY8HOrcjS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19d3676-1a25-4bf5-9daf-08d94c8d7f4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:21:26.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoOwmmvpOh2EOfOoY6agRtHIp8O2VjAAvdbvo55Q6xEJ2R+y+kPSyjDexV+gwPM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BF9DAD1B-67EE-4C3B-9EE0-C3C40EC9816C_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 2:39, Huang Ying wrote:

> From: Keith Busch <kbusch@kernel.org>
>
> Reclaim anonymous pages if a migration path is available now that demot=
ion
> provides a non-swap recourse for reclaiming anon pages.
>
> Note that this check is subtly different from the can_age_anon_pages()
> checks.  This mechanism checks whether a specific page in a specific
> context can actually be reclaimed, given current swap space and cgroup
> limits.
>
> can_age_anon_pages() is a much simpler and more preliminary check which=

> just says whether there is a possibility of future reclaim.
>
> Link: https://lkml.kernel.org/r/20210715055145.195411-8-ying.huang@inte=
l.com
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_BF9DAD1B-67EE-4C3B-9EE0-C3C40EC9816C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4j9APHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKCnkP/142QRxKYp0cxnJob46hPecYeinp/YiDrmoi
JeiocVqCVW3FKctVffrfIcVh2FR1AfJfDHGfxhzx3N3FnCocDTINbHTFzxN9pxFY
+Q9k2rMyKXSJh96y68o0cqyRklSpEYT62XTizVD0MhKJYSpqvndq/cexFoDTnlRw
TzLtNHFg7hDqiI3v62Yj6xnoQAZLMZbRJ+rCpdzK51j4RZ+Kc6WqtF9zSI2yCtcY
eRgUdAzVO3bdFMIgijgN4WFMGvYmD5zej8CNzlMGQS5jbHKKJLARV+emGiFYaQzQ
OxQ6LtQkUfwruYql8t4h113iw3UmvXZh3ukPqZWOHkeFagaGaQi2CnwthFaaoWnt
KnHIOGW8c33CTv/g7dHYFFwt0rDW5qo6wFnWNrdZlnGn6AgqLHpOao5H6/PJwlhH
HxlUD/ekU1xLtZSUzFWky8gJHv0jHST/1zY1+KDN3IFpbRzmHp4jn4Wr4xcLAfyx
wISUDnbFl4gpanyMZFbvcO7sVBWLxE8zuqB224Y8JD7nNuEdLVCnlb7MdhsfXh16
pf36TvBcU8Cla4QWgVHvpP+DDYDcEYahLI7e0UeQ/198SqBKzWEoiHZAr02Zy4AB
HZ+zbk+E4d9KcPrK1y74yRkzSL2wb7pNueAJigfnxFGE1Lpk+JI4DgWtlUJog1IB
hKF94YiK
=ALFk
-----END PGP SIGNATURE-----

--=_MailMate_BF9DAD1B-67EE-4C3B-9EE0-C3C40EC9816C_=--
