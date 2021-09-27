Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8AA418D61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 03:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhI0BEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 21:04:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:57927 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230082AbhI0BEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:04:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="288046306"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="288046306"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="615587889"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2021 18:02:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:02:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:02:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmHk6Wm6j5qib98fiDxmlbf6eUgllvHJdMSmaBem5YyjEDaHZaVZrjLEAMK7aMwTo5mHrm9mef1+1GuJkAlMEDRSy092M+6yZgxUtpqapjy9sjWb93+mu5AXCetYVxCLA79ocG5h/QqaMI3npwSZ6Vypv1Kg36wJ05GfYWxvAxNvlXGs67uGIIdi7R5qe5eVANt66cF6/40h+BTopzV2jYUjb0vAUK5ggqaWH0yxv3RdlAFfdgglO44ryJITyQZKza+frt8foKUEFnE90YEpAceHlLx2GqzFQ5FwR35iaQz4GcSibc0LbzY1eu8pQU7C1brVZhTkSBwVL073VbHYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3XG79LU++m1qPUBHsw9T+s2Mpm5vohCIKxbxs5bPbBY=;
 b=KX0zN5n2SD7ZGRlrT2aqwOBaitXND6NgaxQxeeXjo15764Bl24wQnCxQ5NXBjYHFfzLSXg1pYFmXHRMznJ7nEk9ApEc61IhVbxZVVKSNT72w+ULaWY4k+Aaw69VQ3xlKegZ8S9En+8R3qjFRNaAzCmSrouyDWm27axiGKKntnhI6o/2LwjWXDC+r2VjHck4kUCWOfmbqCKuTRGz/P3TE86HKn+lC3phN6ABoTpLq3JYpjuBhWAZ03Of5wT119Ea+b8aGmlVnxYfV7GQ38Tv/OKf/BnoFuy/+ThWBk/16qCKN4g96yIz5Ez2NswM3pmyZfweEzkb1ceXEFpIfCnpSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XG79LU++m1qPUBHsw9T+s2Mpm5vohCIKxbxs5bPbBY=;
 b=iOusUQPfBN+xJBW847ztSpHPiAifrcjso7i8TFxz71fRnlVHYZLR9y2k8Fyq+KPbls36yRuICUXf23eq1H/d6wrE3t+35fkBUKYgMAUFy3U2KqccFMW/Iy+Mfyl38Nt1r/ex2Th0+FOONbREjd+kPH3wT2seWUYsLD+ufrsvKZA=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 01:02:39 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:02:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Thread-Topic: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Thread-Index: AQHXssyKNHKFF+SoUEuTrYz6UpswLau3EQxw
Date:   Mon, 27 Sep 2021 01:02:38 +0000
Message-ID: <BN9PR11MB54339C8E99C6DE37CDF7CE588CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-2-baolu.lu@linux.intel.com>
In-Reply-To: <20210926114535.923263-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba8c8dc-6788-40c4-656a-08d981528065
x-ms-traffictypediagnostic: BN9PR11MB5420:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5420F7B1C2EC51B7B5FB66198CA79@BN9PR11MB5420.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtCjUBAfPBs1Ajtw24cuCSHM8rC65A/d8/uKPW5dGzmMtIgc7otn8c3Z7Ld13jEOpYk5QI5yvCRYNqLVv+yJKpY8Q+i2gnWdJKKfI8aAmDhjiKNUHVEAEGLJLlh/y5b+z9FIOvHv9vSoaDgD59IZrJ7J96Q/435ivRVwAtJyrG0mWSf2YfrGaFc24vytrQ5gv9ZoR97Po/h1LDLtgZZi4I/KTMg23TvNlLCw7crxKYs/a/MUF7eKoydVTTN/sthrj9v70OFkEnkG3PhObguPgMf/Pk2bCj9LpCixPzuaVy7LtcVXVzzeOBMi7XtLjpsjaArbPKt9Hz9ipMJlOQ/yCGRLF19LJIYTTQIcEJIInJUa/XrTEs5IzQDkW6OqJrtxVRwHCLdySAy0O98uSS0iXlcjP/+U3+bVrdfwizhongi9MHKJyCt0xLL0cNWMbvP0Tbn8eXW/ANoj2YOttesJ3um7w/hKU1xCWhObmMYOBTxAIMSk3bz/ADZSuWhIlXbxM4czxIbv15W7AkDsRQbug1AM2ahEMsAo8rl5DGzQEeyYLrnB0W6qgp+aDTVDn9zuZUbrEqZcaADNDOAseZMxaScZeikbS97trQwMDAsj75dRfPvMtrQ8BGgi2nNQUZsKHZD+b9PB0h/mXoIPwN4nVdpTp7Ykhm3DL1JEia7gHhTsf5ggznxDBdFnHhX72BO/TUklEEvSHwZ9UaIIAda8nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(66476007)(66556008)(64756008)(38100700002)(66946007)(9686003)(33656002)(38070700005)(55016002)(2906002)(5660300002)(7696005)(122000001)(52536014)(508600001)(26005)(186003)(110136005)(8676002)(8936002)(86362001)(71200400001)(83380400001)(4326008)(76116006)(54906003)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3cMXrFq7tAZRl/woxCwojrazth4Wfqr/w9Knp4NbZ3ePGq7jqrDNdNIEnFM?=
 =?us-ascii?Q?0PmuVL8qL/ujS2+Wo9CWSZxbpaJMmtMDMqTw4arB/hCHY0WEabbBmXvvSuGS?=
 =?us-ascii?Q?SHn8VycLp7DenLQsGikx5pueUIobUKGIGdRsC1wbheLlmHJF4XT3teBe2Zj5?=
 =?us-ascii?Q?/f6ImSVhYLH8fWEGkcQ/sLsKspMNzaORYA8n3Tx6Exo7b8pxuEG2kzr/fu+8?=
 =?us-ascii?Q?jqvHVV719jDugENJKo5iuJN/IqTYfqEFPJMf+9mWtoUgnEPoXBMc+mNBr2bc?=
 =?us-ascii?Q?ABwICDPJ4TMRItT3n/MRmBFVBWDRRMiedTZY0ryjXJTZitXPkO/Cmqo59VJL?=
 =?us-ascii?Q?MxtOcImzzQRBh4Vzs2BxSwmqJWtf1M4DORr+HZZ+jDKXGVRJEpkppPOcOzsp?=
 =?us-ascii?Q?Z2sAsTU1gfO39rvOU0DC44Ex8FTS7djyRTNRuLms/3jTlo7wbOH6jE2yqiiv?=
 =?us-ascii?Q?vT0SJ1yjiEtJU+7/flRwTDopeRxY/yvbo7zpOMkMGe5WXAF+M2mjxG/BegU1?=
 =?us-ascii?Q?Eejjk3/7vAxPh/UK+NsymHIol/Gym5KiN2Ie9FzncobYnjJxocjfe8Xwsguh?=
 =?us-ascii?Q?HIAqzvlD46YnENoVkesU5AOrBFrxMs22vanHmERvqsXC3njm0OBr2XYqKFnz?=
 =?us-ascii?Q?KQkHtLlos/fvcO19SDhNFutoLV7uso8fXLH7kkUZm18ZlV39nuEISQYxMrvl?=
 =?us-ascii?Q?O1xwJHhs7lce7wvsHle9XdQfQLU21C1fx5IlUHfXaKEBy3ThoD4/EnGf17FS?=
 =?us-ascii?Q?7iYSqhw0LlCSRTD+AjxE6t1aPo/+KzNlJOOSAlrRyCZWoRTuYgRJZQG6eTNI?=
 =?us-ascii?Q?XXUsDP4AigdkXmHTtCcQRHEyZtNAxpjFO7X6nH7V45jMIOiF25xQ1bJA2b2i?=
 =?us-ascii?Q?0dsRBYSORjkiIe4vKYVkFPvwBOjXGZ85BoFnpmzdNWxSZ3RLs1x1xVXb49ww?=
 =?us-ascii?Q?7o8+N2meJ6JXHLzMGfezMmuWDDWaieq5nPQEmQaq1OkOOJWnD+4ZiWQh/UYG?=
 =?us-ascii?Q?g/OB5WBPfnN6YSq3rzSUFhsUClIGq7XzQNJhGNrmb/3OEU5DifPvP5/pjcNg?=
 =?us-ascii?Q?DK+bG5T7hYBgSHm7JJNcRd4V3b4194upXqg07w5okxdBvYJhYEjyHSxahqrB?=
 =?us-ascii?Q?ro0JNnNSyPN2yuYuPD/oIKQwvqu4Q4cHj5orhv208r9VeaG8xa9h6680DjbG?=
 =?us-ascii?Q?+H1NSZPHfvhYxSvSsiwmTk0ALNKRr1N9fQqsFDkTODQgAVUrTfrp2zjRkhq5?=
 =?us-ascii?Q?QGwYe01RgBcezXGNfzXRWZ9egzKyDf/xoe2cBRrQVAIBWRPo0IyAIxBci/s5?=
 =?us-ascii?Q?5rVvDOmewK4QvC0Eat9GSgrF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8c8dc-6788-40c4-656a-08d981528065
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:02:39.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AV19qAS4tKglTTIETIMbKmMoIYruHjiKkMd5Fyl3yBenbfKX/1sd51icxv9QE5tzdziJ/nyfND+y8tUejY3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, September 26, 2021 7:46 PM
>=20
> The iommu_domain data structure already has the "type" field to keep the
> type of a domain. It's unnecessary to have the
> DOMAIN_FLAG_STATIC_IDENTITY
> flag in the vt-d implementation. This cleans it up with no functionality
> change.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  include/linux/intel-iommu.h | 3 ---
>  drivers/iommu/intel/iommu.c | 9 ++++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4bff70c26416..c24bdf5a9285 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -517,9 +517,6 @@ struct context_entry {
>  	u64 hi;
>  };
>=20
> -/* si_domain contains mulitple devices */
> -#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
> -
>  /*
>   * When VT-d works in the scalable mode, it allows DMA translation to
>   * happen through either first level or second level page table. This
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b0076f54f5f4..dc2030d014e0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -528,7 +528,7 @@ static inline void free_devinfo_mem(void *vaddr)
>=20
>  static inline int domain_type_is_si(struct dmar_domain *domain)
>  {
> -	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
> +	return domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY;
>  }
>=20
>  static inline bool domain_use_first_level(struct dmar_domain *domain)
> @@ -1996,7 +1996,7 @@ static bool first_level_by_default(void)
>  	return scalable_mode_support() && intel_cap_flts_sanity();
>  }
>=20
> -static struct dmar_domain *alloc_domain(int flags)
> +static struct dmar_domain *alloc_domain(unsigned int type)
>  {
>  	struct dmar_domain *domain;
>=20
> @@ -2006,7 +2006,6 @@ static struct dmar_domain *alloc_domain(int flags)
>=20
>  	memset(domain, 0, sizeof(*domain));
>  	domain->nid =3D NUMA_NO_NODE;
> -	domain->flags =3D flags;
>  	if (first_level_by_default())
>  		domain->flags |=3D DOMAIN_FLAG_USE_FIRST_LEVEL;
>  	domain->has_iotlb_device =3D false;
> @@ -2830,7 +2829,7 @@ static int __init si_domain_init(int hw)
>  	struct device *dev;
>  	int i, nid, ret;
>=20
> -	si_domain =3D alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
> +	si_domain =3D alloc_domain(IOMMU_DOMAIN_IDENTITY);
>  	if (!si_domain)
>  		return -EFAULT;
>=20
> @@ -4639,7 +4638,7 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
>  	case IOMMU_DOMAIN_DMA:
>  	case IOMMU_DOMAIN_DMA_FQ:
>  	case IOMMU_DOMAIN_UNMANAGED:
> -		dmar_domain =3D alloc_domain(0);
> +		dmar_domain =3D alloc_domain(type);
>  		if (!dmar_domain) {
>  			pr_err("Can't allocate dmar_domain\n");
>  			return NULL;
> --
> 2.25.1

