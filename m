Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9F3A48AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFKSc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:32:26 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:12896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229753AbhFKScY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz9QTeK/51V44KMwsPY2QTgP2aTHBNU2yHPOMpfVwiyiuNHOaVCT8EkArK4gU7L9AnewapaU+LFBG9fL195YAcPQDh25Zv7uKXGP0iieUyJKAkFccZzXy5mRRVGIY7Tvik5U40aXPKUU0ZcanXYK5gqz4peMQvYJTYhZMcRoepHDmCjjOoI6TZbPiaWQrXSmmTmFfiiqwUOSyS05aPudv6FCiEnhf72PjoX6PKnVDa3P/7JS3KQL6vFF9euIFKgReFSuA9Ksb/57YWsBkCYvI7mEhmcwoVOW5FEc3AHHOB0LQDY7lxQuUMp51mGtDxjidN5uad2VgTmREpVgOkD6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmYp6AxKY21kVqxh8QywAE5SuK/vIOiOMt7I+5EfNLM=;
 b=g6Wn9eq6ve4MlapwYA9QgW/wbW9TcFF0cMafTpQ0FYlXV2NS4O6SBXg3PRRz6fikD2cuJpvrRDZ8z5QFf9SwepsHj2Df0Fg1xX11P+WjyLFOOezg3l2WSY3AzhCowyckTx1u3LfSR8yJU8Oa3yTrpjArjuFUMSUGJR666cJ0PPHPmN3kUhT8QTY4AueOe5dZNPUlvyHBc2UeXys23APOtqiqolOI7ZbdkDT+utuaPhxGe22IlpoV8rx8AV6rZdsvBC2EGJ8E7X7QQhTe+8NaPi1ctKHyBcgdzvFwqoedpmapqp6czOG5+kH6qNH4O+cMV9oFgTBJ4tKySCST5cE1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmYp6AxKY21kVqxh8QywAE5SuK/vIOiOMt7I+5EfNLM=;
 b=aBHLdrWXmSthVMVUJrX1SvTTk8lEuMQbuXvf46jOI8OK+5S5DCXxkNqwR6vkhsjjOMdQREihTuhgYo/9xkJdyMS9U2RPXput1g3LkWT8102yAzyH3VDqT6eA0Qc9SFpg1n5dieRlQVzSeqSNatAa7jYoX0+0NN+hXbVP3iddVDwPfY9nKZeRjKrMQPn0pt6dy/2Ehmj41KaC4ava7lTUGBuuTdT1O8yo3XyTn3MK6W9c587a+Q+MR/40HJHN9vWgNkTT/YE/evEYkZGOTdKX3ixD3hzFHGihSCGG9qsT+yH01uaLvsuymG2DLcni5AgnW6JuEPwp5I/VToWHFayk8w==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 18:30:25 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::d05:4bca:ea51:15af%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 18:30:25 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Will Deacon <will@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Thread-Topic: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Thread-Index: AQHXXa+J5wsxx82rEEuAly1r38xpAasOomQAgAB2fqA=
Date:   Fri, 11 Jun 2021 18:30:25 +0000
Message-ID: <BY5PR12MB3764CB9BBC42426B67537563B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
In-Reply-To: <20210611104524.GD15274@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4caf8f9-3bc5-4c36-0de3-08d92d06fb12
x-ms-traffictypediagnostic: BY5PR12MB3730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37308985932AFB936CB625B4B3349@BY5PR12MB3730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26SQbDPz8y7+tXv7fe72fHEQzysTm21F5260IiipP5NedlZCS9WXDdh30QcO3gR/XJT0hqMvRwvYEeigLlUwuNVEPG0PdK8kv9YXIRwhSWGDGX+HLq9pCQRJdnYKxrjgdPtutAAFJu83RX/z2xF5dfjRo/oJd/HLlv3txtYKBm/2mzKf5eu1G8JQaYj7St63zkhGh/tOZWOBmedyGpgZU7VcSrVGGcuMXsL3Gkyp40J5lC/+gHpZfYL0dzGsc2jyPWeA78AirGh3SYblCzpOMud+YCb+h2AZYLznHvyM0eJkSwHyAlU3pSlEO/ytNKtx8MlRwMb1k1tLAKsZBDl+9OgzheRSk7veqIdkmE61ywd4mAHUGaCX6UZ60Xmx/y9bKXdMcXXPkoak0nhuwOjmySRtrKlUVjTFguQC33ikylOm9cX4KeNXSfRx7XMRYCmw7J97v+xZHOFFXF8ikIoIU5sH4A2nCL/tR5U6VdANdhKpQqnmn53gTV7qJFFSUNW4gbX1Id9blmaD0/oJH08rgLWlEFzbOI+2XvkzxKQ3L+d9v7vGjzpHhXerX330lCFrUmZZ2rA12mfGmKdNE9rvcRybbEYvpy72hMlHCKqbvoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3764.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(8676002)(478600001)(8936002)(26005)(5660300002)(6506007)(38100700002)(110136005)(2906002)(83380400001)(52536014)(66556008)(86362001)(76116006)(7696005)(55016002)(4326008)(64756008)(66476007)(71200400001)(33656002)(66446008)(66946007)(6636002)(9686003)(316002)(122000001)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1VLjEx9rx1acZ/avB8Hrx6TE3pNjXGbxK7sotgqaDCQB5vPYMZGee0G5zBj6?=
 =?us-ascii?Q?8WW2huM4cdlHKjJjK2x6Jj+BawTsnwiobixUYUyZKdJnrKda+yLrFOz6Uca6?=
 =?us-ascii?Q?L/zYjSxOPB69zqD/gI0LxJkwGDzqXkLVg3x40/PrnSxlJIo1lZojQRkfXCAb?=
 =?us-ascii?Q?kBAFkqE5hAP0eitItHqEQhRkpX/ESRuiqFX5gQ24fLqzR6eCgtcR68ttMaWY?=
 =?us-ascii?Q?gLm8F/PGLoQk48VoKY4zOmcQ+KHXGaBoQrJVHUTwTUzfDEqgUjwzRMZ+luDM?=
 =?us-ascii?Q?hosv3CDQq+3yODjOjoAK6poJMxjagRTy06N1OwAJForhX/YlDkI17hha/d+n?=
 =?us-ascii?Q?Mll4EzKCCZm6gP2IkUKZJZHjojuWmwcSUrF+qziC8ZXnWXm14uLZMoSRFg1c?=
 =?us-ascii?Q?4Wlbh783vOWEA86uvNwCj5hR21/+on3c+xxFZfdgL/ZKsWEf+fYjrg7t1pIQ?=
 =?us-ascii?Q?6d0uQK+BN5sQGyc08aAwoQ+a5b6/+5UJAAv8qBKd28EDzLS5YYXvEX/WHN9g?=
 =?us-ascii?Q?neR0PNJEvp+Ai6kcZ/YovFLgrkqAitxUODa9m6gqnPItj67dsYCG81WbSI9w?=
 =?us-ascii?Q?IFZgj1DFdYNvN3cVqYUbhhXdBeBxWSN06bgohXk4/00sJR1OpoX+hjYm0zQF?=
 =?us-ascii?Q?pVoKTxiA6uOpLMYK9Livnv8K9Nytu/vxu0ZkPSZzuXklreHuWy8err/ml3G4?=
 =?us-ascii?Q?YyXEl/yYWm2FDwszgKJre8MWi/lLm2X3GN1u/CFx2h1Qk/XTbeFrPeRnhvpM?=
 =?us-ascii?Q?fa2L00gkGJ2vZEkOs+CvwUBWkPY3tjClNRUD8aofP/AhNgWZdxSrCBWHCpsg?=
 =?us-ascii?Q?7ITQ8sTXJqgGsLAIOiXD1dEHETQCMM+vgSw6s0IHomRmu4MkrZ+XX/C2fJFA?=
 =?us-ascii?Q?JUJoz8t/dHsYrJo0E2go2NNz6a10uxbTtLi2RYHVSXvB1rCtut6k4LBzf/wd?=
 =?us-ascii?Q?Q3Z4oYMpxMDCLDEBje4ZH9fh83/SzaxhHQQIAHh7PxlZgdYNVL+OBnlL/GXo?=
 =?us-ascii?Q?qc6f3YyCbsSgL0MLFbLU4XCn3WjhoCAZhJXF6J77lhNRufOTK77n52xbrJ/u?=
 =?us-ascii?Q?e5UWWgFvKxwkUMDP38js1v/tFelzKVEngcFfDuQChS1gzaJmiei9ON/4TC/V?=
 =?us-ascii?Q?FY1oc8c66iC95EJXirupArndx4E4aub0ZWnGissHi1nT0iDpmk3+/uPsqtcD?=
 =?us-ascii?Q?k1PjZ5AscwRUEk6POj1r4Zld8qq5pDCNHeBt7sB8pMOvMLKbVkmjI9q+lzTS?=
 =?us-ascii?Q?AIgdkq6qh40q71r5k5Cl8mUDH7XZ21Rn4FHHF1Ndh11A1J++OxkN0aE1UjBu?=
 =?us-ascii?Q?MwBn6aMEa82rY2qMk/pTDCr/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4caf8f9-3bc5-4c36-0de3-08d92d06fb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 18:30:25.2825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHInlFzFfG04BXhquXeyflYB5n8lDkH7nYHk1ellh6lxSZ+lC6Hl6Vv1sKckafBXpKcVF0YBj9EJKgRI6wd3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     mutex_lock(&group->mutex);
> >       iommu_alloc_default_domain(group, dev);
> > +     mutex_unlock(&group->mutex);
>=20
> It feels wrong to serialise this for everybody just to cater for systems =
with
> aliasing SIDs between devices.

Serialization is limited to devices in the same group. Unless devices share=
 SID, they wouldn't be in same group.

> Can you provide some more information about exactly what the h/w
> configuration is, and the callstack which exhibits the race, please?

The failure is an after effect and is a page fault.  Don't have a failure c=
all stack here. Ashish has traced it through print messages and he can prov=
ide them.

From the prints messages, The following was observed in page fault case:

Device1:  iommu_probe_device() --> iommu_alloc_default_domain() --> iommu_g=
roup_alloc_default_domain() --> __iommu_attach_device(group->default_domain=
)
Device2:  iommu_probe_device() --> iommu_alloc_default_domain() --> iommu_g=
roup_alloc_default_domain() --> __iommu_attach_device(group->default_domain=
)

Both devices(with same SID) are entering into iommu_group_alloc_default_dom=
ain() function and each one getting attached to a different group->default_=
domain=20
as the second one overwrites  group->default_domain after the first one att=
aches to group->default_domain it has created.

SMMU would be setup to use first domain for the context page table. Whereas=
 all the dma map/unamp requests from second device would
be performed on a domain that is not used by SMMU for context translations =
and IOVA (not mapped in first domain) accesses from second device lead to p=
age faults.=20

-KR
