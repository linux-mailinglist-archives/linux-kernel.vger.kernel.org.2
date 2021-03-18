Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC5340764
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCROFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:05:41 -0400
Received: from mail-eopbgr760044.outbound.protection.outlook.com ([40.107.76.44]:53223
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230159AbhCROFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngGaGi9u8bj6R5ZOVgViRDtM8Pgn7SONobdXg80gjHVVLgQlCptMiJhfMTyHoa96id7FM+siN+eVRohv55A2CjHaqvuwKTSV08b1hHOhK0ctspDYoe1/bBU8oR+eXM5MnGhmp4/PFMkIu7qIhBLfA76eNvyf9xh4yr1RQ0HhGeG2skndCmdHrDo2YSxAbscsvyGxDszTGcx5StfM1BsVXtoSe9+l2dkxV7YR59oYaARWhlibh2t63xAyfyruy+F9V+kabIcxDSHXaq65dyCWIqBSSBlsdt15sXJom9TVVjC+2lymCyrrwZ4dq5rEdmh23YWpIYVF+LzATuGCNHzOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtbAE8Kgf1RLJervB9EEv/2A9xnnAb+8lYkEb9Du44=;
 b=T0+bi98BawT+ispGKdEeKUmfB84cEqxjNoc/gSOWJl1SiSC3tMPJ/canIOFME6iV54O9INwGxysO/oTnSsh9p6GByhoqoF5BxOYyEZQzVzEbnCK0GfRadL1tZiLyHUs4YEGlBaNZ/2/DNvmQmXhoxyQ4tRKFTVFonN86aZQ3/1sR4M4z1OPb31hiQLTLoFoDN69YCn0R5hk6rgCIBPj+lXKSvZL0SsprZtQChg9CbntG9kgN9elv9TKx3O6ZJEbeIPdI8fIW91t1bHdAAUdqCR5q9Ci7awQN4A3+gwff2DdHs7rpL+gh7ES3CpHebfi7GHgPDH8fLkt4910xWNHESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtbAE8Kgf1RLJervB9EEv/2A9xnnAb+8lYkEb9Du44=;
 b=UJQkPB5LFzsELssjs8fdwV7ZeYmXgHKKVA4XiGDidqMUWxN6GGJNO0utg+cOLcWJNFKFdJYRd6YJGsLaDOJuAZEjNcfUlr04AFWiVlyNi2SRsATN46/MUxCMrilTTUdGr9FNordUn3//JzOo0jOz/Y7GiTtCqoU5kh78UVMrQjvR/31nywIY/Q2vTW+Y/om+IEIcdlrUOH1O3pBPdapOuvd4dfxt6TgDbOQRXG0JaAY6VNgxZmui3Cql9qOnZC3wV7HFl5/GyRmXTqBXGtHB9gsZa2PSyiO068VvDfJztoEPOxLyfHvXqYAYVrVsHDTV5On2gwKU7cUg56KXZUmRNA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 14:05:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 14:05:02 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        william.kucharski@oracle.com, vbabka@suse.cz, peterx@redhat.com,
        yulei.kernel@gmail.com, walken@google.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        thomas_os@shipmail.org, yang.shi@linux.alibaba.com,
        richard.weiyang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 3/6] mm/huge_memory.c: rework the function
 do_huge_pmd_numa_page() slightly
Date:   Thu, 18 Mar 2021 10:04:56 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <9BC36D5A-991A-41D0-A5CF-40A0E908E630@nvidia.com>
In-Reply-To: <20210318122722.13135-4-linmiaohe@huawei.com>
References: <20210318122722.13135-1-linmiaohe@huawei.com>
 <20210318122722.13135-4-linmiaohe@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6355BB75-14E8-424E-93BB-47A202237EC5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Thu, 18 Mar 2021 14:04:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e65ac9-7a3f-4881-3fb9-08d8ea16d2d9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500A34D922D1EC38FEB6DFEC2699@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkZU8DxxRyzsKvAXnBBehocVcBwRWnuIs2LDGMQtXbiu7HENmfMraA3wPgC6O+oitTHtwIkTb6keHpnhDl4ulaUnP810ilHv2XKwFXh/li00QL40Klpg7MELr6YrJEgLjg8cUJBaQq2WMTsBMQEKytUBdHd5/kFljcqw6djgUvERMqH/jccBSJyHEPTcwiJnSCL8NujBFJQMYWxoU1tc8X2yHJXzbGXblHVyu/FTrK1diwa42Ni29UEIN9/GUYGRvVvH2lY6Er2DiOnJAgRpyap4mr3ldVB7M6X9H3gQnAe35jNlejBcLrK/9MxfhzlgavGWdNhN9Cj6cg/GrqZnQ0D2VD3EthkhFctEddyJNhbc+zb785fCj52AFdXY9C7IdfaT2Ye/mMcOvy+l7l2k3r5ak/KZK/hh7p2l8110RBXaSIYcLBfLmuhvkFensKXwhLOI8D/E9dHemHZGRKwEz5OsD/yKQsiOPcbZ7RCIwhRz8V8ifUorg3cvwfWW8t/kJEqd8Rc3HJ53NbgmUfVuCoq9XWlcKWputK8Qj1sntjXd94gKYbjNdjPeFfLHU7wlMXVqHmcwa8mQgvMtzMpk1I7p/C64a9EdOOxE/75AHpDtCTkKVU04NaZDUR1F4rzYgJ+h2r2PDuhYhyNmdMNegXJ6bqMdxz08OW8j2jtPhCPj6FaLVtTseSHS+yACCW8N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(7416002)(33656002)(66476007)(6916009)(36756003)(86362001)(83380400001)(478600001)(66946007)(33964004)(6486002)(38100700001)(2906002)(316002)(8936002)(4326008)(66556008)(5660300002)(26005)(235185007)(2616005)(8676002)(956004)(16526019)(16576012)(186003)(53546011)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmNBeXZ3OUNvK0VMOE1VSDQ0bWFxSXRvUE1BRXg5R0R1OUI1NU9sM2ZLT1cy?=
 =?utf-8?B?SlJ1NFRMczB3OHBZeDNQSVVGdnU3UUJHWi9LUFVWeHJ4WHNkdGZZamxsZlRR?=
 =?utf-8?B?Y0dQNU9VbjBYNWNWN0dKcm90Rm5vZU1QSWdGUEpYMUFnNXBvMk4xK25rdVU4?=
 =?utf-8?B?QWovLzUrRXgyZ2t4VklWcy9WV05DR1FnaVF2akpVbXZNU3poUmdBcWZDRURD?=
 =?utf-8?B?VU55R2VtbDEwNUhzK2oxS3F6eks1S2RXQTlxaDV6ZVgrVm1ua1pRcTBhN3pa?=
 =?utf-8?B?VDdLcEVNN2dOOTdFTlF6enZ6dmVaLys0Y01Yd3VJeG13TVdMRVdYVFBNRU94?=
 =?utf-8?B?K21KbEZlcFdBOWVieWxkUlkrdGhKMW10YU1Hbnk5ZEdOeVFPOUNSOEtMaDJZ?=
 =?utf-8?B?cFVGcXpvc2RIZkJVbzNpaUVpbnl0Vk9xQVBCUVZlYWN6RGkxSnJpSmlZSmtl?=
 =?utf-8?B?MjBKR29YcVJXOFgyUHNzZzVSZ255clIwSVpjcUF6bXkyYjZ1aUtJNjNIOWti?=
 =?utf-8?B?L1Zla2M4M3ZGODNsWCt3ZlRLbDFWWGhRaS8zWWE2TEF0WWhJblMvTkVmQ1Mz?=
 =?utf-8?B?dUFROGtFYlIzQ2NJbExFZzlRQVpzazJPKytweDJPRHNXUExvWjRzYWNnU2tl?=
 =?utf-8?B?amhsdS9qakgrS1RkVHMzcTlLOXNlbUNyTlRJOU9rWjVKeFMwRG5WbEZiSnpv?=
 =?utf-8?B?UzYzNHVlYmVOeWNnOGFSejdHaDBSWTM2OHJVZ1NQYUFyRXdTOUtiRlg5NHBC?=
 =?utf-8?B?M21EYTU5M3doTXdYVGh4M1R2dmNiL0hyVGk2OVlZWVN2TC9WcVRRM21GOG40?=
 =?utf-8?B?d1F1elk0bGNjeFNLay9oNXlLUW1jQnc1cmVEUWZBRUZWK1lzeTlLakRPeCtP?=
 =?utf-8?B?aiswdStvWFR5cHpyMGIySUxURktuQ01rOVpXZnlSN3N4c1o2TVdmbm5vUG5Z?=
 =?utf-8?B?b3V4MC80RXVjTUVpcDFHbHlNRjVsbzNEay9WcVJYRjZCZFBXblhyM0R1Slcv?=
 =?utf-8?B?QUtaVktpN2VKMUlXTVBHODRJaG8wRTNaa0dpaUpnRnJHMElTMWR1ZGhadENy?=
 =?utf-8?B?bDFuZ0krazFvSjcxVjllc2pmb2Y4L3ZmRkNEL2ZLc1JhVUk4OG5wczBKNU5H?=
 =?utf-8?B?WnJ3dDFkbUpPOVZ3TTBDK0dORXNSSXVJaFMrRGdJWktaNXpPRWoyeDBxT1FW?=
 =?utf-8?B?SkJYZHoyTkFjZ2N1RU8vaThVbGdSaEZyQktTRThjcTQyVktVQmZzdEpic1BR?=
 =?utf-8?B?TW9ESWhBNWhNMEV6VGcwVG84SjRWNlB0TEhDdDh3VDg0a3J5SmpuM3hFaXgr?=
 =?utf-8?B?MHhJUXlyMWM0M1UxbllvYmFoQlkrSEwxZzlTMUcyZ2ZJUzlDWmRDaGZSdThh?=
 =?utf-8?B?UG40L1pybTZTWmMxTkVldTlhdnNnbTU0T2lpYUFwbFVOMkZ6S1M3WWpiemV3?=
 =?utf-8?B?cnJXVTVVS043LzJOUWhQZk4zNTdWTjVnbjF6a0J6RmRtN2E2UFNxemZ3aVZ0?=
 =?utf-8?B?ZTdxVm9oSTFCN1VGWWN0OEhtRlpjQjBPcEFhdHpFWWZPbVZsQ0dZR1BpLzZY?=
 =?utf-8?B?dmFPQmJqUGtHOFIyMnVzVHM3VzJNTlA3bGVXV0tEc1YxVkg0SWNkUjh1bFdi?=
 =?utf-8?B?VHV6ZWFLbERTbVdwWVJtckxFUHRsYjM1dDBveUgzTVRFUGdGVGQ2Q1hpTVY3?=
 =?utf-8?B?RVZQK3hTRDFGRTV4ZGVad1lEVEptS3dSNlhGTDBxRVgralRqeUtFbjlYZUZQ?=
 =?utf-8?Q?/SoFSD0UZ8FKdQgqZPN7F04O1/JfHWtzJqO7d9L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e65ac9-7a3f-4881-3fb9-08d8ea16d2d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 14:05:02.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kca0bc/40CDJTI4w4OzqSFHtUxJtr0PAaoqQeZ597Bp/sDoSZnoK08csgBOMdv/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6355BB75-14E8-424E-93BB-47A202237EC5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18 Mar 2021, at 8:27, Miaohe Lin wrote:

> The current code that checks if migrating misplaced transhuge page is
> needed is pretty hard to follow. Rework it and add a comment to make
> its logic more clear and improve readability.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_6355BB75-14E8-424E-93BB-47A202237EC5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBTXggPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKy5wP/A1JTw0AZu5FGBKZVxFxDu1BTgxRKMvpVNFQ
aBLzB1LYlVW6vXhbd7oApkRU0OqTNMrUkvAUOkIgR45NilnZ4p+c5DWvTuwMPk4o
HQz4nsjDHaOPwaKrd2pNoodEnQSjaRR3afLKju1O33NOp4AEsUeaQ84Ftkf9Cl+O
YFrflmMgMo8RoU9/rDy4ZHXgSAOdiFHvLUaoiXpXhYFv85cFFQoaJ9f0y3WM5UWy
CB4s4cZcfXcWXw8JvlCXhlXwBn+tehMUMoN4bbKIlw/rosKewkrgIYUhWv17jsyZ
0D5bQ56EurXpK1NaW5/m6BI4bTWFQxZjDxjnGTFIiXNw8obCdf8haglu/suf7wHS
lbeEzQnz8qHbqlFtYl6YeuyqpetcCkLrJe9MVp0CFAZhyf83E5KMbxdWDCalDW0m
PJNnTnxcezgv4ZOcEeYirXYUk9S92QGgkVXL+zlFIGIiGjv8f4RHvRS9rsVmZHAQ
zH9oecIhUm4yTV+hJHV3zH7IwIEmF5empJDuOFkltMJIgsPb8BqJfe1NzSkDeXcE
MIWKJe6hBm7v2DGQFGZuxYhebZdoVeVq/D1SMsRVbC9AN62CjJK57csqDEx+H3h6
4aQRYajxFs4VeX+vvNgBz39ZXfsKSA2BJndtk+FkzfEB/owkj2b9I2mW7n1sxpZu
OkRnmb2p
=6obZ
-----END PGP SIGNATURE-----

--=_MailMate_6355BB75-14E8-424E-93BB-47A202237EC5_=--
