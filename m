Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33F737B7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhELIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:31:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:56772 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhELIb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:31:28 -0400
IronPort-SDR: 2rcpmPbhACaaHFKgpkhbd0x1rdSy4p0593w9ihVZLR6ie0Kj2ZpxtnOp4wTFNJnD2LIYrFgSjl
 18XN/jDxTMZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179244156"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="179244156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 01:30:17 -0700
IronPort-SDR: CG4EaNFHmkWdk97NtG4D0YDUZ4hh49rqqk1TqR5Qt7G6cmRYYsgoeCSOjBtKd1nsEJPYUt3yQI
 q4Qu8ROQBlqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="469343239"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2021 01:30:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 01:30:16 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 01:30:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 01:30:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 01:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7tbOu1YSeaf9yEGNqf8iY4N7muUUkdnR2nmbqty8z1ZWpZ24Xk6oMAKSiNE1tn6PFhexpeSogRZay0qudoZEVNPYwH7c+MTgntTqQzfzKBv6ywVTfMiBABhLRlyHWPtM6237i8eGFE1lD805F9SZIqFrcdfwkGH18BY9ntr4xa2uxZ+2+96AueMi2HYzgyAKtwJkJbZeavYqcZjQXTlu19aupSymOelUmBuNojiM4vhwQeHr9EsHthclR0RBEPD7sGyt4Kwom3k+OGZE1QV8LQGr5vuetXsKMC6BBPkh399Bf7cPS4AOGmZ0C/S7IoMACvy9Yw6HNwkvglontLCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mClaDZXVYNb9z7kJeG36TiJnt2tUukQd1W6GrbK3zRQ=;
 b=bIOSgNMRaYXoVRcWA8WRS60q4xo61o8qqw5CT3HWcGH2nLabOJxyhtGhVAXE0SGro6dItIPj6LN9iPg4F6vHvTXSLkFM7TCgaey/6wuR16xtDAn2qk6MhwaLAfYoQcMzgjEF2248E+0ybYaNdafxOME8pO4RZtxK2F/9fmnwJAvxtrcUFKXXnj+cG/Au0mJ5Zh0ZM+KYV8E8uk/J2v7ANX0ITqsztiBj+0kBsfhbHCZLOTC+T8OWFIYhtox7vn7/BnyteXFQh8Q1PrezEzviydclrPAlMjz7cNrVcyptZL7Q0zBC/ublqK4/2GO7iHL7Sh4cJyhJnaktRjOcYDzRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mClaDZXVYNb9z7kJeG36TiJnt2tUukQd1W6GrbK3zRQ=;
 b=gfVYHfxpPXqGbBXy9Qa2lZ9kDoRVUsmjI9VLKaS5ZL7KhoEdcluX0kcVTvKRcv+MSUiVJaPRRatYc3NBb9Cj95Vo1rDl7fidO/wbLqlH4mRGyJRxXWCuFAIpFDWDjPovxCQkIXmahRPZMxleJ60wVxfjPfPEAYd3G1aWpAgp/ho=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1662.namprd11.prod.outlook.com (2603:10b6:301:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 08:30:12 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 08:30:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, "Will Deacon" <will@kernel.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
Thread-Topic: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
Thread-Index: AQHXRv00dlnt8+gkZUeuL5SpzFBldqrfgy2Q
Date:   Wed, 12 May 2021 08:30:12 +0000
Message-ID: <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
In-Reply-To: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 178d0292-f38e-468e-d205-08d915202924
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB166238CA3D7367B3F60326FE8C529@MWHPR11MB1662.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVHkesNaDtRODAMs+bCwiErEyrDCSg2QU50ssxZuOsZMNbU+9Ho759mzhIBIJWBYuaKSQA3MRaMsknWiiLZZTxlKYEtZmt1duLcvHNLTOiDAPIaSrUAM0Re2dHen7fnNrCSM8x5JerM1D7NY34517k0f2sk6GX76Th9edCylaA/XLUKCfniSKgK1FBW6PhGtsEKvvue6p2jsJSYzKVN5VtVZ/pV3CpFk2NXJd/Til+jq2pKjNxvlTEX6/GBifmFb91QozP5ody6iffbgT86jxOn5kuik4gr0HqC2aa939vhhrDwid5Jh9TYxS8kPEcGKZolh7xNthurPhdtrEGptblUw4mVd4fpBP2NBrU21Q1p04GnjN/TrgqWS+b/6EV7yKga0w0Ytq0TxgnknklTKuv2MY0NSlS0LiCWXzheotJgLiHk8JGIifRfz2C+XvlMTr9f0xzPVzU5Yx3lT0qo14/qOtdQLdL2rDMNHfVSI0Bq4Lj4gxJEABji51EVINCIXonlUDEaWGXiRgoxkWf1vU8E2lrynca17sYSEH8ca6DTCx3mMInBmvQLQTgHHNmSNSbYgNY4sb9A31JDHd78JXtqKpwYqDkAl8dbrUv1UK0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(55016002)(8676002)(66446008)(66946007)(64756008)(66556008)(66476007)(4326008)(71200400001)(86362001)(52536014)(54906003)(26005)(9686003)(478600001)(33656002)(2906002)(316002)(76116006)(186003)(83380400001)(8936002)(110136005)(7696005)(38100700002)(122000001)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YSHmWvYJuhATJVQKtpETuGE+xT8DcNiRZKCylNVWW1+vHpKiqvEkctI9qd7v?=
 =?us-ascii?Q?sDtNcgfFWlfQZ9lFzlEPuuCcHkC8mLwVqmpJvRSpBf69xZHArQXPKLfzEAfn?=
 =?us-ascii?Q?DeIBW5jWGAKK2oMAm338CkssOOve26+4t5upW6/aXxUwDRZxgZPok3TDQf9K?=
 =?us-ascii?Q?LmR+gAZFDzTd/BoaYUU3Glc4Q7epe3fmYYlSJNCSHVs8Gf5qWATJVQHAf/28?=
 =?us-ascii?Q?wwkCYiTIJ85XQo+rQRaMQ9zuF5UpFa4SysrwSmSdj1wDuyFMUI5FuX3Vy2wz?=
 =?us-ascii?Q?y/YvDDE1IY/fuGDqAqN5+f2vw61HrO8MX5xOCpOpqv9iee2XNjxHRtwb4kAn?=
 =?us-ascii?Q?SsIhsClJXQUhiW1dzQ8xwiC2qU+VZJLugs1ALjeqgNoMxKjb6IG+FNx5HdHc?=
 =?us-ascii?Q?22Vv9WCCuwXbD1dADkpEzjeR5c/ZVbXoqZ9/POlbg4PZljcaqwflo97a73wK?=
 =?us-ascii?Q?LjMhRRPzQlAQXchsC85f92fwMd/RZdeD46yEP2mkg28rJ7bfXKilvQfLM9e5?=
 =?us-ascii?Q?b682qsJa8vk91Vx4V10ye/KSRCzYMjrpiD8yM9gcBIyNNeCNUeZo2ymIUm1t?=
 =?us-ascii?Q?4EcEqK/W6dHqFZuomIjuAYVgRXfqd0Lc46lO7hY7rMKVyHuOqeu9OwFcydSW?=
 =?us-ascii?Q?Y6fYUtoARC5LNLmWzYl8p2IJWHEmqXkz1BpGyB3AQHeGO+VzQFTg5YigSFDx?=
 =?us-ascii?Q?DhoVxhiwsGEW03735cu8ltc1g5XwjpqhHKym1++7LYSfKVPopmoSRUdNLYgv?=
 =?us-ascii?Q?4bkqrC6V/tvwEKHT5h8RcMCGhqY0x8nwyCbaBDPeDDA40c8Y267q2OfUOWy3?=
 =?us-ascii?Q?swIOOd21egNwIk+yxhhZYKrLNxn2ArB9l0oHAOniSkjlxymevugBwqsqhO1n?=
 =?us-ascii?Q?DgfC1onhpGf0lISM08azPw37WwPkBmUVAGvu+EEpJzLOh81FJ3s7597KtKZY?=
 =?us-ascii?Q?qhq7hFKnWRCwqVwmljyMOxYlwF+e8mBEFTv+kgQDjiS6rNQ51qH7CzblBXsD?=
 =?us-ascii?Q?bUlIuRnjyoA8j5fVh9WdD/rS4gb1TNghI/TGAQE3DMzT6gzTOTFpACF10LBG?=
 =?us-ascii?Q?soQLOKTpr2ub6T6/SG75qcBV8luErJ889qVQxcX4nqp5aEcAoSFpkYEunmzs?=
 =?us-ascii?Q?gJMT6bGRZAmHmMlndqye32fV72S4wKAHVzujVLBxal8m5ZA6/Mqc9ZQ3LLld?=
 =?us-ascii?Q?rCGyJKvB8ptA8QSQ4mmCLk7qd2qvP0kV8+dGEoE+3noPYWa6L4pIMD3lLnMN?=
 =?us-ascii?Q?oLSmYoJOLRxGSbxB5NEF8AZII1+jtOycyDHI/aRoGbOB19zJuW7GqPDjVA/C?=
 =?us-ascii?Q?bactqh+SAf6/Y/sWxoDA++Rh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178d0292-f38e-468e-d205-08d915202924
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 08:30:12.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIJWyJf2nxurNqv1o9soiEZHvmy+HC11w171b1qzvLR/0jkEsaBLJUyJwyBL1Z36DHyXrGQg/q7jaJBBWyFrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, May 12, 2021 3:04 PM
>=20
> Current VT-d implementation supports nested translation only if all
> underlying IOMMUs support the nested capability. This is unnecessary
> as the upper layer is allowed to create different containers and set
> them with different type of iommu backend. The IOMMU driver needs to
> guarantee that devices attached to a nested mode iommu_domain should
> support nested capabilility.

so the consistency check is now applied only to the IOMMUs that are=20
spanned by a given iommu_domain?

>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f1742da42478..1cd4840e6f9f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4755,6 +4755,13 @@ static int prepare_domain_attach_device(struct
> iommu_domain *domain,
>  	if (!iommu)
>  		return -ENODEV;
>=20
> +	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
> +	    !ecap_nest(iommu->ecap)) {
> +		dev_err(dev, "%s: iommu not support nested translation\n",
> +			iommu->name);
> +		return -EINVAL;
> +	}
> +
>  	/* check if this iommu agaw is sufficient for max mapped address */
>  	addr_width =3D agaw_to_width(iommu->agaw);
>  	if (addr_width > cap_mgaw(iommu->cap))
> @@ -5451,11 +5458,21 @@ static int
>  intel_iommu_enable_nesting(struct iommu_domain *domain)
>  {
>  	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	bool has_nesting =3D false;
>  	unsigned long flags;
> -	int ret =3D -ENODEV;
> +	int ret =3D -EINVAL;
> +
> +	for_each_active_iommu(iommu, drhd)
> +		if (ecap_nest(iommu->ecap))
> +			has_nesting =3D true;
> +
> +	if (!has_nesting)
> +		return -ENODEV;

Isn't above still doing global consistency check?

>=20
>  	spin_lock_irqsave(&device_domain_lock, flags);
> -	if (nested_mode_support() && list_empty(&dmar_domain->devices))
> {
> +	if (list_empty(&dmar_domain->devices)) {
>  		dmar_domain->flags |=3D DOMAIN_FLAG_NESTING_MODE;
>  		dmar_domain->flags &=3D ~DOMAIN_FLAG_USE_FIRST_LEVEL;
>  		ret =3D 0;
> --
> 2.25.1

