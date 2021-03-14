Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACA33A878
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCNWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:13:21 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:9078
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhCNWMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGL1FzWam0J6ZbRWtBbjx0itGm4USjOE7dHbexYIIf4DcIe+VK+0M1awrgf1B1rtfpD6hVF6EJH+Lf20Bnmd6Tz++LQHhmONmMS+ZRcpCgUIStB6jKj/E1QpqJTRXUdPB9G5nMs1g4cyvDoc1MRnPggb3KXPVa/ZLmcUCrA0Zc4BbKPwJAWh+FsfWLJmBM88S2l/k0vRxVP4wy7qDKg6psxnAKZkt7kqeMhRcHHg84CeTqnakND611jPQNc8Zt6VcwGkOZtJ8I1omVO32C6KAdTrrZn/jCCiT4ZJCs58IfahIntUkPhM0A/WWk5WtgkXVBmFk5tvyndAI3YrY0iSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67p+EHGMgAZiEzCmwBMLq+iNMNLeMndK/kSfYC8j93Q=;
 b=b6axzU33eo6C40mlZvTqIkRRAEu+m5HNPsNkfVx4UDP4wi/uDisKQ5kC5gZXrhhmyslJoqODtcL4LnRm0+1HStKoKqQ3scdIzPkAd8SLPmHxk+Gjws9Ppn6p0vTEb7cQUNaZDQUHx7wNqs86lBhp79aaLTmxo7VAVCMwzl873zke9tzGcj3rcbgrjuTNQe8D89voyunkV2nTXkKOwrsrbb3D69l8yZ+u+y3+OzuV+wqVnB++k0UC8zBdSjHFRpCnkTGkRb7sgO1d9sCUrPdo7O8ZYDpvt4YxuZfKGGIN0KFgQs9Fp2/Ba91TlWx/Rwt0+Ipsj1coXNTYB2QjyKFw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67p+EHGMgAZiEzCmwBMLq+iNMNLeMndK/kSfYC8j93Q=;
 b=JIrJ0dwPaA+ldSgAUyS1qkPOPB4YqZIntcWc0P+fyWxp1Cs/5D4JlwHkXhi9UmKjkQi6g4SY73bw7c3HqGqvGwyDmdkLWhyUg1USZgQtAPuPAmKFOKxyU3Yu2BaBucS/tbHlK30IuMBNwrAOeK3bjM99H/+AQr5BYQZtqEsQCedJiBktVnKwJdFQZsc1no1sjBjPivfMH9sBl7sEYqqcpz8q51ULRdGNkjGX79NxnY7MkvTQJhbkdpxzimplP5Q6ATX1mkaWf4Aug6jIs8FVtKgSJK18BfXm5FGmwOD5tavmTDLnutsXm8gcqHQfQzdteTuolWslHFKBvJuhaK7XLw==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sun, 14 Mar
 2021 22:12:51 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 22:12:51 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yu Zhao" <yuzhao@google.com>
Cc:     linux-mm@kvack.org, "Alex Shi" <alex.shi@linux.alibaba.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>,
        "Roman Gushchin" <guro@fb.com>, "Vlastimil Babka" <vbabka@suse.cz>,
        "Wei Yang" <richard.weiyang@linux.alibaba.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Ying Huang" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 06/14] mm, x86: support the access bit on non-leaf PMD
 entries
Date:   Sun, 14 Mar 2021 18:12:42 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
In-Reply-To: <20210313075747.3781593-7-yuzhao@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_54EDEA4A-74DC-4AD1-91D6-7A41064D4D84_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by BL1PR13CA0231.namprd13.prod.outlook.com (2603:10b6:208:2bf::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13 via Frontend Transport; Sun, 14 Mar 2021 22:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532a5515-5fd3-4517-3cd5-08d8e7364ec3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44065D9D4D78D867244DD5EEC26D9@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpKiUj12zWeilUC3bSEF8eXMHrmF7DiSLFvnuP85k/7HRaD4y1xzcz0giU5JBVqLuEHbyP+qTePTGrd6VG92WYvC0lZGySPu/3JDef4JqM3RHr/2G/OVS2TqxIAFy2jeC2a2kB0Lj2MMos8c7O7Mjo5mg41A1hw7I5XNl/4cOLoxk3yt+4aM/sXNDTgILoZgrkKQuq8yRvYfDs1xmtc/Nqp/qzBUjTi5BDd33TfpmJAM79ggwsV02e0uyenoWFAAb95a2DWCuTvN+g0wNFt5C5CGsm/WxktCCoIEpQIjKZkGypHt6A4dgGuUoIk0g62VyjsRU5NHyELanCOKsDVVlslNnjAjSISDo5an3N73d6n/HBIOTOTWMCQvwbkEHmGOYRGXUFP60QYoj8U2+Dl1Sk6TsGAPnbkzhwfsUah3hiZs2TpjT1MU1hjq+vj+RzC3HhZEzEV+aPzmnsIAkMyrTgb1m3lo0ZDiqqu2G8jbXa8z8Rg2yybyl3ewWt15BiP44w0zZ+2Y3eoZZkP0Jsrb1TYLVHDcj/ChkNgL6UWxUYhMWsrYvZHXPaLzPmIT1CYRDQRbwsLBtvfMrKmvjRmdkVMbCAUIBhrOHILYXmea+5K59VgcXQK9L+9u326pR6ZV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(53546011)(2616005)(2906002)(26005)(478600001)(33964004)(5660300002)(6916009)(7416002)(6666004)(8936002)(54906003)(6486002)(235185007)(66476007)(8676002)(316002)(86362001)(956004)(66556008)(16576012)(186003)(33656002)(16526019)(83380400001)(36756003)(4326008)(66946007)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTdxV0QvQ1hZQ3NsYnZzZExvQjR5WTFZK2dpWmNDa1JwQWdOdjEvSUU5bjFl?=
 =?utf-8?B?UFZmZlBpcXI5bE5tbVMzSmJmN0hiMjFweFZ3Uk9jZDhNaUZZajNkMWFpbFFE?=
 =?utf-8?B?U2x1Z05jTnBic2hmSi91R0ZLWXUvMjZqdjY4ekt5VzE0bHlCenp6bVAvWStl?=
 =?utf-8?B?M1VHL1cyWGtQR2xDNzR1V2Q2WFBvQ09rUS9tWXFyYUdzZjBsbmxNMU5lYUhS?=
 =?utf-8?B?cDh3UjFwMzZGZGFMNHhoK2lzbHJvWG1yUyttclVncXVuNCtPditlRnVCcmlJ?=
 =?utf-8?B?QSs5QWttZE5ITHNGTlFmZkNvZktTRW1oTWlxSHNQNk44aWNNSW5QWmNFdGpE?=
 =?utf-8?B?K0xDY0xheDdUV0p3K2owVjhISVhpTFB3NW1GNTc2WEF6ZzNLVlEzM1RRNlNv?=
 =?utf-8?B?R0VCWmE2NTYvVUFsNlo4S2lQOXFCbjU0by9ZUE9RdmN6ci9BMTNxTGJjSCs3?=
 =?utf-8?B?TjMwVHc2b0Nua0YzeTZrczFhYk0wZFM2RTlKQWtzNi82YkhCTXRHYVVJSVdt?=
 =?utf-8?B?RUpYZ3A1YXJGSmphUndjU2RYV0xOYkxmUFh6dURnRE9Gd285aVZCVmF1QWNO?=
 =?utf-8?B?Z2c1cU42MHJsMlRsbnZsVE1OQkNDZ08yd1ZMc2NXQkdEbGFPS3huLzBodld1?=
 =?utf-8?B?UUFyd1lsTDZJdDBZSlh4OFdGaTdKOGlPVDNHczNPUVVLOENGUVRRRkN2UEti?=
 =?utf-8?B?b0pob3QreC9OT2RvTXBaYXdMdHZWbmNMQ3lDK3ptNCtGd0lGT0xWY0JrUlFs?=
 =?utf-8?B?L05WMjE1eXZxeGVHcGVDd05kQjNnVGZjUGRxMDNDSERqVXB2ZXpreHZLQ3NO?=
 =?utf-8?B?dUNtczhNTExXS24xNjRSam1MaElHeis5emdNYnVEanEzY3hiU25PbzR3NVRv?=
 =?utf-8?B?V1IwU0dQU2RBVzhUWmNXcXE2aG9TaWVaMmZIU2psc0NVVVBPa2szS2xTQzh2?=
 =?utf-8?B?LzJMU01sRGVjZzJKUThzaGlNKzhTWUtOVlc0MVJzVGdkbUNUQ3JPSXQ4VUlK?=
 =?utf-8?B?cVg3N2h2bmp4cWtLWU1PK2YzSllvM0NXQzlVY3NLVnBYS1ZKY3oxYWYraG9i?=
 =?utf-8?B?Z2ZLbU1qaTVsRE5tb2RncWVJM2ZXTktEQnFBWVFaMUtONUtWMW9Rc0hTUWhw?=
 =?utf-8?B?Q2lYbU1SYy9FZkNrVFVaaUZGTHFTOWxVakY3SkFBR3lyS0srdjZUMWM4cnJB?=
 =?utf-8?B?TkcrUzdtbHNvS01aNExKSGpuRWN5eVZabm1tL1lpRk8wc29hdVoydFpSYnF4?=
 =?utf-8?B?eFFXRGkvMTZ2eHNLckpUdEdmZHY3amFBTzEvemRGTjhuNTNJS3J3VWVmVE5L?=
 =?utf-8?B?UjBSTzgrdC9YSkh6MS8zTXhoVTlXQVRhQXd4ZGNnbTl3cGU2dTFlMFdod1Rz?=
 =?utf-8?B?cmkwUklobGlwMklXcGZGMlozQ001bXpRRFJrN3ZES1hodW5RdTFlL3JNS3Nl?=
 =?utf-8?B?bkp4WFE1cG5BQ24vL2FQM0g5azljZS9wdDEzdDgxZXNDMjRqNUc4b01UK1p1?=
 =?utf-8?B?RkxDRktxM3BkU0dESkExd0NWeVZwWDFOYjZnaTFCY1QwSUVjaGQyRFB1Tkp2?=
 =?utf-8?B?MzBwR04xY09zU2V4RXI5SC96aTRuY3ViRm95MmNQQWZKcko5TmcxZmxRZGNJ?=
 =?utf-8?B?cVB5OGZ1M1M0NHd4VnVGVDRraFRzbGg1K05UOFMvTTV6b3FRTHI4WWNvN0NG?=
 =?utf-8?B?VzduKzNpUjAzdnJFY05qQlB5R0JLM1pWTWtPSGpOWktveWt1UFdNN0ovRnha?=
 =?utf-8?Q?8KqdsCoCP/RsExAmknVCNvoZXw05DaKbDMchP4Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a5515-5fd3-4517-3cd5-08d8e7364ec3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 22:12:51.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93uPYXypkmu0RG78uhBJHnDo1FM6OhUjwiqtFvat4jLpdBWvpMZC3+FaMuz04fHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_54EDEA4A-74DC-4AD1-91D6-7A41064D4D84_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Mar 2021, at 2:57, Yu Zhao wrote:

> Some architectures support the accessed bit on non-leaf PMD entries
> (parents) in addition to leaf PTE entries (children) where pages are
> mapped, e.g., x86_64 sets the accessed bit on a parent when using it
> as part of linear-address translation [1]. Page table walkers who are
> interested in the accessed bit on children can take advantage of this:
> they do not need to search the children when the accessed bit is not
> set on a parent, given that they have previously cleared the accessed
> bit on this parent in addition to its children.
>
> [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
>      Volume 3 (October 2019), section 4.8

Just curious. Does this also apply to non-leaf PUD entries? Do you
mind sharing which sentence from the manual gives the information?

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_54EDEA4A-74DC-4AD1-91D6-7A41064D4D84_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBOilsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKerkP/iB1nUSTR7vLSPtlfXP3ax2DfPP7dRSQ88mo
dEw2mvD6tw44cYGJay95OFPJ8UdFprlWOv0Qk3Lj9/NVwlMW8B+ZUkXeOmI2yoty
eEen/YgTnQBcK3YnxnRno6347HWRW1YjGZ9DEhlM0CRkBktugT9r4Qgl3PqDmEz7
NFa6JJUEY93GmYfMja1B8ERthXsTtap7BImAzEL5LqlXbSOkR5TSC7kO/5mGOSHm
/xed4n6vcpazJxOLEhgAAMKKiNwRlgVvUw592zjNkF64YtQD0o462DUu+M7NNB7G
s2OeiO1tvCo75aXLEHIxAxoW6Q6E6q/R/LM+QOFMzpjfMwYL4e0ZoWe6mIdM+3yA
G4gslVEHZ0rsG64dJ3sU0nz5UU1rwh7zyaKYhG0ge69w3Ch8CnlgG1SZP7J/l4+f
+cUC/7zi9seQ/GMH9cnNFxit6cq3QCq+5nqmDkKBF5iLecqCFYpI7WsLLa0ZoG0y
HqLlsfZlaep+6LV4DC5eaK1ApoXjldWO1H0DA4r2GEvk0enIHewzH0ZxAeACQSrI
VkyL9uM6/m/0rC13sNB+vrDIwUaEb0bbN0bBu26Jq0UDH9LukTBTkUfaFKhxEFkE
RZbNy2ZW4Ypq32caDEQZUfFRbTIJwhpAJ6wALCEZJJ3c65hRV4O3irVlZxYMi1le
KyotKxsP
=itOY
-----END PGP SIGNATURE-----

--=_MailMate_54EDEA4A-74DC-4AD1-91D6-7A41064D4D84_=--
