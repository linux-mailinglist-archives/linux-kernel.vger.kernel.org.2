Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00773CD13D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhGSJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:13:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:33610 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhGSJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:13:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J9qePp020588;
        Mon, 19 Jul 2021 02:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=uPWyvy4YRyIeaCgpvYWF4iIv+HmNmhhEhMeQPIMpeYo=;
 b=Apbtd0EOyEOtHNfVi1lukGznu0ak7cHU+xpMmcVBrdlKQWSCOxJNFsbuV/UoIZLH7Qjl
 s0TGKGmUsuzlH9b6+EE7xRLJp2lSPDb9XQQAoPJJedCdp4oS7pvDEbD2fo3JjbL4R2ag
 dHSTWId+UpHk2AKFOI//HNduxx3hAkePVz6OaisBw/4R5okuLHJ86dc978qdxH5McR1G
 YKhHeuHKTxmd9ckSUBXZj3E//IWjGr0Z5enqWRwiIR3QNv3XYyM+V4t8R34AwFX84IAG
 0lSVA2NWTgLv3WO7dz1HopP9mqY+6LiamiFiCj5TR61iDEQkHrmAc/lgatw8Lo/zbqSG PQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39w4wsr85u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 02:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4RIiFJ7Cm3C6lnVqNq2h8fTkfarbY30YWiseh/9SWQQTB2I2YGpmJM6wybemYNUpnG4n8zB4pPyOAJFqe38v7y2YdGJnk/zhr6dmZQ4b2y7hgGYsJFGWfDe2jVVGoQk+mkJWLvAB+rUQ+ABVA/FN+B6uKpnOWJGh1MbgkIbuWkn9t+9LBKEAAsRu5brKXia3besMm+HS3Tlfa2+UNGSQLUQHEY9Zx0i8SIKZxm7KKZgekPiZOhRpfnCWmzLW9qZj5Pzzjsx4wyGElqQJZn6Cj78qvjyyXSojQF3j3dt5XoPP10O68B35Eft6ETpJkg5YO3hjIHsOtMwsh4NZ2gIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPWyvy4YRyIeaCgpvYWF4iIv+HmNmhhEhMeQPIMpeYo=;
 b=RwQrw2LYMxXL2qrRB+kAP6CCvO4AjRypzfeMfGFvh86hurn7Yc541tc0W6rcK6u6/BWyivWRSm6fXgnldjnntxyrYrTp8+3V9BcRbZYXIHR4V7/JtOtFgGwWvJ7U05TLdJugxqy9y86cKjCqJ5v8aMZ/klD/PFGLv031F9NFGKVOiPj2xzfYi4PPMiOXZQjoxmFvyejm7a1TjKY+JGMb9WBuUDfZySKQAdNHYpbyF1iSkubxkgxZ+7MVB7HabwTZFkq4LLExcXyxigRY9exFlCwc5lxfHrVUKBbopKTai8QrZqQAkHpig7lQE5uu9Y9tFVAr2LIz049ReHIssCbm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB8156.namprd02.prod.outlook.com (2603:10b6:8:1d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.24; Mon, 19 Jul 2021 09:53:37 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 09:53:37 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Topic: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Index: AQHXebZmBTPHtO67e0+5F2gnOfKvWatKFHUA
Date:   Mon, 19 Jul 2021 09:53:36 +0000
Message-ID: <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
In-Reply-To: <20210715201651.212134-1-peterx@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa285411-ff8d-448b-1145-08d94a9b1444
x-ms-traffictypediagnostic: DM8PR02MB8156:
x-microsoft-antispam-prvs: <DM8PR02MB81560446F582088A2A066322E6E19@DM8PR02MB8156.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nkvc7POMpz2+WD4orXL23VZXPu5bgnKlB1JZeeC7fRSaBWYMm8n9JTHbplBCCPN6Ax0DTO9ykPkE+rxn1coMZ509+3u5Lw6c31GE3TDyoR8/HRlEKb4o3HGGb9RbPd8uXkj2mFFXkJLFXhFPk4PTGK6ho1rT1whiEMKTAqNAg4iDoOqzUXVAgyTfu4A3aOsXNIoL0JZq/tM0XkmYcKmx0umacuw59QObst8hB9GdgqAiuP3kYncdUDYSs4ADwcq2maIJSPelPeWmNJpsImYfXbte7SA7QWWaOSNJAkgObqg60fWwb3Um8XKZAQtPklLGzBVbkhStId2kezLQx6pGcTE9jhPmNzBUMdflcn4NIRT/9yAaOr6OFz6TEinODQE8VOoFwJiih5e3/WKKMMSbwRtbBPSBRlINTAIU89CryWchVByNaJqd2jyKtpTiOVHbdSsKCtNtA1Hco8sUe9tP1S301UdWtVlJeIq+0OJLNmRr7JYgEnlTvPrfBmCYcj/tonfMMJ6yOqPgWxXlg4XlBqrgzyt9DuW+cTwXRJbb1pI9Niuti9Sh/u5jYqfGLAasyN041RaBqdjt84G4A5ZGTpBlGkZk26Reky4zz5d+ab9l+CyokYjxTYejMpAP72tUHzk7WzJqGGKWDhoNdByZvPLJHeHp2oI74eTLleO8KwL682LnyVbzGGj/QNQDM39fb0j9GwC0RcJDxN+PRyczbhLsp29vu8fv7oJ/mCQQvc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(6506007)(8676002)(7416002)(53546011)(44832011)(71200400001)(5660300002)(33656002)(8936002)(54906003)(316002)(6486002)(4326008)(66556008)(36756003)(6916009)(478600001)(83380400001)(186003)(86362001)(4744005)(2906002)(76116006)(2616005)(122000001)(38100700002)(66476007)(66446008)(64756008)(6512007)(66946007)(91956017)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LGVrnstNSzcFLUWq+SxYvkYzEnn1grUa9SJ/M7Vqj/DHbFHBe3ViyxUuHcl+?=
 =?us-ascii?Q?+GBPaPzvAtKKTRfjEEfORmYae6dHzVE3lpxrc3bjVcDW8uboTRy/CdKhaV/j?=
 =?us-ascii?Q?Df6/H6eIlZ6OoUAU0uDSofBBimoJLnWXYbh01/r0qTC6c3IO4PtyDNL+meJV?=
 =?us-ascii?Q?tly8PcW4+9O/OYJZVgmokGNbmfharpHjGVuXGYuz+KwmaONKo1+0nKjFYrtp?=
 =?us-ascii?Q?RtcCteQ9I772ths228eiHXaGYG8RwBNjkpwytl0YEEKS9R7hSD84N4yFRTS2?=
 =?us-ascii?Q?19vwPEkwup5FUwDhbcSYNhKcIn4fYjQqG5lHO+FOjDukWVb/9EPE+oADXBFE?=
 =?us-ascii?Q?0TmJK02orMFGqezLfAljaG2dFel2X5kRVsykCRiY5FGId1k4LfXDJu9xEseI?=
 =?us-ascii?Q?9yxg4kqkPJVnA27dB1QEgGb7bn6eM2baBbcy1IlKXswMpkafP/dlsDrOQWRD?=
 =?us-ascii?Q?mRC4in3hhqmDi8f/pBMpO/SUh9fEKBA3dYtRISz9TFG4Q5orgRoPhomsatYh?=
 =?us-ascii?Q?ofhOE03R/FwwKbEPZUrxj8rE1wFkZuKhX+s8zJe1E4eOnt56u1pUJB6OmoVZ?=
 =?us-ascii?Q?F5nwpAVcC0VFtP3Vg/S5rOtwAUbZ1FZR/TNOKXahiGlITGSviKSie+pHmKfO?=
 =?us-ascii?Q?xH/D70wc8ATlW49/AwSqGUNVF+BuAX0Yespt2J8vPa8x4rvJevP9bLypO4Qh?=
 =?us-ascii?Q?Is4rEc+UisSuBEpYB2QIKehqVQiWlrFCCGdIfJMe1vkR+5CbUiYG/au7La9C?=
 =?us-ascii?Q?2ogBo9zJ+G0RlkeCtoJ23bYZl22qVG4mwPZKwbfeZmh8crKBh+QLBEhYFjIj?=
 =?us-ascii?Q?eyjhxLA5d9VuIVswr5nXp82zk6Cut063F0jQK/hp40fiafhtM5Q6GRUmxfyA?=
 =?us-ascii?Q?z65sHNgetuujsXU2SMKROYeZU/sSKiGwzWVX4UXm5rGaAVlhwiLUY4x5QYhE?=
 =?us-ascii?Q?5Kt1Aw/CSagLQ9wWcAfx13MBdQy42MjoIhNpZ08ZfOmgR3ZEtdnv4ZjbV753?=
 =?us-ascii?Q?diqwSuhfj4gN/A61m6btKejb8hf70mM+1aHJtF5CFhQjCaxN58/gybvaTXYU?=
 =?us-ascii?Q?EEiCnvXVjWMwZIrdqzINUa8Osp41gd3KAQOUfg3QA5vm6uUu9eM6gPdWg0Dt?=
 =?us-ascii?Q?JUEjIhPOhnAADXpNefHt9pDZ8dz0pkHWVJHjewbc3Wrwg/UrFOYh85N8BOOg?=
 =?us-ascii?Q?uqqtzhvGaukFbKOWa4fQAPU1tQN7zEOBb2pWrbTTQIS9Bu2GeLzYDhgNu1KO?=
 =?us-ascii?Q?7PdpxkTDphlYwu53E0LuIYxQmRo7sIaQGvzznAiqtX9+KRcOa1EvxJfWdxb4?=
 =?us-ascii?Q?pihiCTo2cHyB0heOCPC7kkqIzRACx6auatLws50SWTHh71oEa7LQpiBPWm1l?=
 =?us-ascii?Q?Zjj4k7Fc1X+JERx+980Bu/Fkqf9q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12DC861D94B291489D41F7C441A61315@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa285411-ff8d-448b-1145-08d94a9b1444
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 09:53:36.8877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0Ukv6RCMGgf7o1Zh1e/479aGTM59EgyUdJLBz3r3olSEnTWkHLT5YdX7JagLMbg2MgxOK2/a5fy+kYNbQTz1VNOb/0cnYxC+wDjojCDVUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8156
X-Proofpoint-GUID: eIeoxIOSqt3vqtkw8LUZSFuLwpi60CVD
X-Proofpoint-ORIG-GUID: eIeoxIOSqt3vqtkw8LUZSFuLwpi60CVD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_02:2021-07-16,2021-07-19 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Peter,

> On 15 Jul 2021, at 21:16, Peter Xu <peterx@redhat.com> wrote:
>=20
> This requires the pagemap code to be able to recognize the newly introduc=
ed
> swap special pte for uffd-wp, meanwhile the general case for hugetlb that=
 we
> recently start to support.  It should make pagemap uffd-wp support comple=
te.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> fs/proc/task_mmu.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9c5af77b5290..988e29fa1f00 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1389,6 +1389,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct =
pagemapread *pm,
> 		flags |=3D PM_SWAP;
> 		if (is_pfn_swap_entry(entry))
> 			page =3D pfn_swap_entry_to_page(entry);
> +	} else if (pte_swp_uffd_wp_special(pte)) {
> +		flags |=3D PM_UFFD_WP;
> 	}

^ Would it not be important to also add PM_SWAP to flags?

Kind regards,
Tibi

