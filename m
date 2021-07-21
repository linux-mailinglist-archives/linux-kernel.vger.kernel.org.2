Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAE3D1985
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhGUVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:18:58 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:37952
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhGUVS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcxAW+PqtqE0l7lU7LGZmVg2w2gFHmVLBUmyUoEVcYocsrIS90J+qFtYV8gsXjRdCykU5o8ju4Ckh2El02oTXYl01s+2mcKJkT1DcooLfFgvbPypzZeggVfB32rRPHl5pmEb6x2+v2l55OoVAGDThtccI40Ux8s8MHbRYxOLag/bk7Fr8wyAnWV9e3vCYrU2QM5b0+77ZgN8OlOzZMHHulKnWVYHIf9lV7B7q+8Lc6cdVP9H7XTR5vStQJcVvtd9POYMauNEmnheJPYq8mltAS4pbrdjtSHRCM3UJm6s+L205FKBVuB3jupNm/ujbDZF9L9agA1wnJQbIk0xBq6HOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4ix9oElFPeWdoIhoGLKDXmjqX8n/a26sSdxSwlafkM=;
 b=oeuOcwLdftheHp2XXJUM9yR98LdRzIQC2b57zzBGFP2k+3CE6sfdQNPueVoNn8VKfmANP6DmXdyludBaBwbXkAMQzE7C1/rJUzlaCcHy3Frtv/80jC89J7IG1eEJNuWuvA99GnNbzaGZ/p5jQXcKNMv24vauGGZfTc+udozwnqi6DadQIuinIXkyAcaSGh5L3z0LwvTVyhGse/eeL7zrOPgn55tGDEfE6GPgv+UDdDehtnL95SB1zCC90xxpYmXhpM8XMwRxxpFS3zn8Q67TDeU5NbmyK3ToJlTDOHQF9TV8B8BBzsWHmKbK0SNhJtych3eVGXC2acIgRwLpvjnkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4ix9oElFPeWdoIhoGLKDXmjqX8n/a26sSdxSwlafkM=;
 b=D9HomfB3YXvixeHuVL9CpTTrmMxhpBUYdEDkmnahlpDmW5miIAxxPvoz9+/KHoO/rweS8uQc+/0OaC8UShL25WbSfTY+NzGwP+MctMhw+MWYm0oe2fyeziNBDfJ98y4sXEDm1rCoV+OIflPPNF1aCBxI8XN6dadHUwHLBki/u44tB5CgbXdbhHdP+YjEj6PXsFnydy8PdbYZMskTunKOYAeRw01RwtB+XXoJfgDNjuDyV/1Qc6Yp/8ieMyt1KpBD+DLLXxgb3nyMO4zVP/yAmZ4BKdBuRFQAoaL5bYqvklvmBocpZRiyLbLkORKR+SpdOQAtdgI6lm6KcI7dIhOJ8w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 21:59:32 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 21:59:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Date:   Wed, 21 Jul 2021 17:59:26 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <7EAEE493-E29A-4175-BB1A-7E18C282A776@nvidia.com>
In-Reply-To: <59a92898-4a8a-05d3-5f75-1f8defb6feda@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-8-ying.huang@intel.com>
 <43A1CB83-6127-427F-94AF-40CE1B283BE1@nvidia.com>
 <59a92898-4a8a-05d3-5f75-1f8defb6feda@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_885EA7C4-8FE2-4049-88BF-9C555BBA1D68_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.55.80] (216.228.112.21) by MN2PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:160::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 21 Jul 2021 21:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dda48520-51cd-4f83-3b17-08d94c92d20d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44726414E88C9FCBE439BE86C2E39@MN2PR12MB4472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oKac3mBb6ah/fGtNM24QMDJtY1Q22/n6y/T6BmV7sRPxRKpY+jbD/H8JhhxWoYWkwEB9z2GgEzFz8KchkAZDsdOwNG90+jz3pw9dXODpSFsSqIPKc6iqaUCPgxaVLBuZnO9EtGPsjE2DVYnqvHoj6dlL8mTgKf7KSgm/0Jz9tgSZkEVfO+zHBMN+UUCHVA9m+HibEhK2gtsVDiBj+afwoc9hcQQu8f3lG1WQO6BYrT73j3TA/cNshhGPpXT5KCweJ4recERa5+Yh56ghKGV46HjvKZp7xJXaqv0bDEkqhEcuGthp+xBluwzMisaSjb8MyLIcfsW5cuMxWaGwFjtS9yh5R3QFZyQpEjOIdfDQNdFOtInQ8OBt72IqmjXxMZTVcNQYEj00AVjslilUe6EpFjr0eFVCg8TGCjykIWMXa1o2RIDkw4UKpEoEMPF4znA9ouwPazvlhdXJpoHj2rPZO/MDQ/t7Ruz+iFxFrjDRPwY06kIROep79aTfWsynO08nyV1k+5i4yQvcJmkSvEBAmozETR4BkF1ioGbAZg5zrFyDpLNPIF7is77cM/CxHR/fOzlonF01fg6quYtDKVWxpkjrN0lz3qrthmPUTxqOfMI/DUIhtEQ0rXUaZUPUzGmIcaWIakvW5XwJK1FUNYWV97lb+ejI3N5y8HLGSiWxgXsGbBYrNoW90dadwS3VuM7CyuFJpL7U3gQ14kHZhNjreEFC8m9C77bgB6AR+o2b9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(235185007)(66476007)(5660300002)(7416002)(33656002)(26005)(478600001)(6486002)(33964004)(66946007)(4326008)(38100700002)(186003)(6916009)(2906002)(8676002)(956004)(86362001)(53546011)(36756003)(2616005)(66556008)(54906003)(6666004)(8936002)(316002)(16576012)(21480400003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NyYkt1b0tVNkdjNHM3Q25TOW1DVGlaSVhkUTNRT0Z4RW1QR2V0WUtjZ1FX?=
 =?utf-8?B?T2p3NFcrRU95N21rckMyS2F6U3BwU0hTaVlWVURVVGRtcU00VDdhcVlHcjQ3?=
 =?utf-8?B?cTFPYWg3dkg0Um9ubXQyZUZuT3ZIUVZVVzVoSTJYYVJreGdOeElvSTdTNTdi?=
 =?utf-8?B?KzYxWlo2dTEzZVRRVmtadUdqSFdZcFM2bFNvVlFwR3JtRUVjeFFBWEFBSkd3?=
 =?utf-8?B?alZZN0YwN0tyVU5pNW9BRFVrWXRoVTllbmpWOHR5MXRVSFZBbXFVVVJxZURz?=
 =?utf-8?B?aURMd3hNTHVIWjZYTWJRZWYrWFZEUVR2Q1M5d2orSkNqd2N5TWowdVlFQW1O?=
 =?utf-8?B?RW5RZzJjNGlXcjNRTEp2b0twRVVuN1V3ampIZ0czbEJHOGI4MzFrM2NpT1Jm?=
 =?utf-8?B?dDlJWnZ4UTJ3dG11eWxudCs5bEJkS1FKMHEzcUJqdDBhT2RnbzZDNWRBclNR?=
 =?utf-8?B?Y1cyVzdzck1uV3pHYlpEOFpVQjVWVWFpZGNJRDRqUVhiRDlpRTYyZEQwNlFY?=
 =?utf-8?B?TUo3OVlOSmtMZVRRYnRiY3FlcmRQek1GZU05T2JmYUhpbk9CaWp4V0Z6Zjds?=
 =?utf-8?B?ZU01dUdVVVRCLy92VXJ4VVF1T2RzZjdta3l6VEZERGV5R1MzUEd6cFhKbUtu?=
 =?utf-8?B?R2p2dElZTUVaT0xVYko2emMyREZoVU5vMnZOODIrZUZvamwyYUppZ0sweDNW?=
 =?utf-8?B?M1lxelgyRE1SVVlCaWxzc0ZhYTgzdzQ5bDE3TGpybjZrWG9MM1c0WXZVczdl?=
 =?utf-8?B?akhodzY3aUIzSHVwSEI1VGhGUndaM00rcDRlbDJ2RDVETFl2TG9uVTF6WFVC?=
 =?utf-8?B?M1NERFdid2JadXNUWFZWTVlsLytobDlvUXpIYWMvWXpqMEtNa1IwbFl2Z2pD?=
 =?utf-8?B?QlpFWDdUTVBIU3U5VmVvOGlVeWJSUkJ1Ymh3Mzc3S2V6UkdHS3FZS2MvT3JF?=
 =?utf-8?B?RjYxYWlSQzRzY0poclRzb0oxOFo5WXoxNVR6NjM4dmVUeUNEUzF4UDZZWndE?=
 =?utf-8?B?Q3dtRmRvR29VSXkweWVEUFNHZndTUEUrYStXRVRpNVQrblpEa1dBNDZXUjBS?=
 =?utf-8?B?WkpsdkZVVDVBUDZXODc3a040TTRTajZ2N2t6NVhFSS83MjhJNlVidTVqUVFI?=
 =?utf-8?B?UEI0U3V1ZGdUK1E0Wk95eXQzeG91M3RtOWF0R0pZUkhoWEhOejBzSDhjaGRC?=
 =?utf-8?B?K2FYRmhkdVVkcnc4L093bGs3KzJFTHdXWkN3UWhiS3hpUnZjUzVaNVVUSHVR?=
 =?utf-8?B?eFFrZW9yaWxTc0J3L3NBcTJHKzZyUEZsZEtsS3dGMDNzWkxRK0lIckwxUzN2?=
 =?utf-8?B?dnlBMDRxQU00K0ZJbEpRSkhnaXJOU3JQUExJWWpTWWREeEsrUXVGY1lGYkJG?=
 =?utf-8?B?Q3A3ZlFNWElvR3ZOQStJU3pjOWw1YlM4ZlRXUnBFOGhQckVzUHFwT3loZ2ZT?=
 =?utf-8?B?MEdrd3A4SVd4QWorOXZJYUxxaFlycW4wNCtUL0Q3OWxHMjI5dHRqVm9kZE91?=
 =?utf-8?B?YmxCTi85c3NUdVM2dzV6M2NsTWJ0RHBMbEkrdG8wQzVDTVoxOXZrSlY2S2ZS?=
 =?utf-8?B?QTNMdjZmMXBlb1QxeC9mMUsxM2FEMVhweEVtOS9HVHRZL2xIVzNaYjZuWnkx?=
 =?utf-8?B?SkJOc2J2WjlYUjNvL29FaG83L2pKR29uSFord2NKN1ZVK0h5RzNtSTNuK3VB?=
 =?utf-8?B?Q25kbk9rT05tTWhaaEtZdWJ5NWtoOVk3UDh2RmROVnhsZlNyOFY5bUU0bUs1?=
 =?utf-8?Q?b33TC4U66UHC6baibdAVzOJXzB8FZ2GkAphMEMe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda48520-51cd-4f83-3b17-08d94c92d20d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:59:32.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trw98/jpPKCOmfRnKxOzNjq8lqi4fIcieGhDRVJReOcMHW0YLmwsiGXdZpGec6Us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_885EA7C4-8FE2-4049-88BF-9C555BBA1D68_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2021, at 17:58, Dave Hansen wrote:

> On 7/21/21 2:38 PM, Zi Yan wrote:
>> On 21 Jul 2021, at 2:39, Huang Ying wrote:
>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>>
>>> Global reclaim aims to reduce the amount of memory used on a
>>> given node or set of nodes.  Migrating pages to another node
>>> serves this purpose.
>>>
>>> memcg reclaim is different.  Its goal is to reduce the total
>>> memory consumption of the entire memcg, across all nodes.
>>> Migration does not assist memcg reclaim because it just moves
>>> page contents between nodes rather than actually reducing memory
>>> consumption.
> ...
>> Should this be folded into Patch 4 when can_demote() is
>> introduced?
>
> I guess it could be.  But, it's logically separate since it has its
> own justification which is rather discrete.
>
> I think it's best to keep it separate.

Sure. I am OK with it.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_885EA7C4-8FE2-4049-88BF-9C555BBA1D68_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmD4mL4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBOQQAJZeAsGxD5mvxqGH2ZQWs2qBylzF9+X6M2TC
ym86xEPtqTJj/EFk2xPm7CFjSk4PoxKyjOTOwj7x9gfUqCA/yPAFF6pmhi/3HiIG
wzdrmzWdtzBjNY0hW9WbDSKBB0G6yKvTNKXZn9NumsnFy3WDAm8DRpoGngu+NL7f
d/acU/oY/odAvcrtI72gXvkojTGC/QQ0xI1bLipDV3OcVKWf0ECQLnQiDnMT1/0G
GVRH7sjY3dmuZ73J8ezagc+gPoW1yzoDaKeNi4l56YeDt5+Qm2ckYt2WEu5+E1Gz
pNupJZ0ikkmbtBCYXbbWUTcWh0vjnnHPC/VsvVVsE1ohlKUTmhfNISVmnqCTVkGx
HJ+Ram5heyfRgiNqxi9KDCkfj/lHYs+6KlEZYF1DzfSzJa6kIf+zMMfHCYZNezsp
Dm9CUVx5JjO53bDdIQSe+tX+bba/Qdd6fIwbqCC0A2F4sdMEQ7GKLoyjjf3iLw1A
e7En3h3ca1dGrwPruYGM6CjQK7nKZfldXYuEJbbFNNO9CQFXWjdg2FAlgV0bzfwq
hGABCJFwScFQMN6eG84wLJcrH7P97yK5LaxnRF9b3WKVbi9SRso9R9n8AVaFKyfk
8nSZJxD+pRLYG5Vl1WZ9vh/PJG6+3FY9auzt1SiQTvOKBzJvEwMvV8oILJLPMwxB
XX91qmgB
=hu+M
-----END PGP SIGNATURE-----

--=_MailMate_885EA7C4-8FE2-4049-88BF-9C555BBA1D68_=--
