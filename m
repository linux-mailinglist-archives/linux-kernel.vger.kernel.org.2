Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6B37F145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEMC2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:28:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:11497 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhEMC2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:28:13 -0400
IronPort-SDR: vOGA1LQVaaCZn41ZgHm9jNKwj6tfKX3V0puEMxeybHHHVc2aIzJhpC/2mRjH2GhOgFCx9k9Dnz
 26s/AgdDHPvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="220836884"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="220836884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 19:27:00 -0700
IronPort-SDR: u9qh8SYHsEOoSekvxx8Al+RI7rOTbu5CNmUlgrw6YQZ36PAIt5/J9ai3bliqK35g5v9sxD8/Bf
 aPcGNzSvPVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="538127558"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2021 19:26:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 19:26:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 19:26:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 19:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI1sJ7tmaAbzMhEGPNl+WD6gOz39ngty/215zgFfj3+qOVOZ3VEXB7893VZNySN8hPNLNzrZ+BEd4VOY44RJqkkACPH/flfZ7ekFODiNhqUzGV0nUDLtwK2hcmBctzD9UwZHKuAWKZX7PoFlp8frbJUkiBiLD2PRQC0lad5znB+yVoPjNWwlS0gBiuZy/BCCTcwPV84FtTNbgaKc1D8izlCOBunYxHdrmkCGYcXD8kEfW5733fDkZdCNSznxROzprBwOT1F3N/NiqxcWEdGYyvGtYMxqhdU/5o287fXTJAm5Om1geZMiy79JOqGcPjz82DvD9v5r63HwI776FTEk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSpSk+v1uEN890hqGt1o6s8DCkT89oi17jFwmVQKY9E=;
 b=GthY6UbDdyxvMH+fzlQvI2KNQMm8fZyW5wbhMzIS+IBTLDnN1C0JBUEKllqN+VOsLIncOfSaxZz8cnkRrcwKPTwHGBGMBEr8WeS8Xo7VekeHH2TnlXoNNkEZyZ5k9S6JibbyyvS5CwFPxG2d1GAq47Vv8jIbrY4uXa0XRI4LX2FedaXbNReBPYvQxLXaUaz/O8HgUWOPANnjL8mR4tpOiqREocjpBi/09AC6XgVu1BhquqDV5wvAxF1Gg4bo8rPiOdGedTyfCsKsAtA0w5cVKvPNvNcv9FEguttB0+1jNGSjAT3E62b1W9k76cB2qXDpNQg6NLSJbwsSev9KXYajWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSpSk+v1uEN890hqGt1o6s8DCkT89oi17jFwmVQKY9E=;
 b=RhNPMAT76oTmucTltFTOD6jp49BLUxbF1llnyq8QgnITXHqZDFvmTgj4deCtKDN137+2uRS4MUbgdXg52q5/omCTP+wLWX38Ws6MKD59bO/376IOLiQzgFEuWCnGOzbC5YSMCBs7BNrJAEOOn5+c2hqVCNFL2w0Xw85arN54hEI=
Received: from BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11)
 by BN7PR11MB2546.namprd11.prod.outlook.com (2603:10b6:406:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 02:26:56 +0000
Received: from BN6PR11MB1875.namprd11.prod.outlook.com
 ([fe80::248b:7c7a:5ab5:ad0e]) by BN6PR11MB1875.namprd11.prod.outlook.com
 ([fe80::248b:7c7a:5ab5:ad0e%7]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 02:26:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, "Will Deacon" <will@kernel.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
Thread-Topic: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
Thread-Index: AQHXRv00dlnt8+gkZUeuL5SpzFBldqrfgy2QgAAzgwCAAPmVMA==
Date:   Thu, 13 May 2021 02:26:55 +0000
Message-ID: <BN6PR11MB187532A1AD69016E2AE0ECF38C519@BN6PR11MB1875.namprd11.prod.outlook.com>
References: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
 <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
 <2eb677d1-14d7-c1dc-6dd4-179c11c76b10@linux.intel.com>
In-Reply-To: <2eb677d1-14d7-c1dc-6dd4-179c11c76b10@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8088404-5735-426f-9dfe-08d915b69455
x-ms-traffictypediagnostic: BN7PR11MB2546:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB254635E9A8CC246C69971FFC8C519@BN7PR11MB2546.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPoOoAAF9Nqh9n4JKNDUwUG47krhJneSkG8rO//jb9GwpGzDNfvrzCHUPFt0RM0NR2nRZgDh5Q9RyjR1YnxIhIoXIS4ZJxFjzcGvPy0mUh8Nkb8YJQLIhhFu9uUGLDgLa+q5cYGRR9KGxlIGDSSJDJtfZZkaG03qGqlIPyQKPu7S9QoUsV0EuWwJMPwpQPvfCahf1da7Saja+l4quwZgbidti/IsvbUYEjGWKs1+7WtT65Maq/5qeLdxo3tv+1+irLYV/UK3oYKSRRin+7LOVKMuU8a4+WLmWundQdkm8GzMgyLqsMWx1PwLYRAnLSKhpM4RRkyh03lvz7dXoxe0qwD2i7U3lGO2iBhpF6ihn3N4TCJH+4v4fDLWwjPmpA+6NBIMLiIRvjN1lDtyQjq6AwINVWJ1qXkdXEdmKUgia9P6lyxgiFtS+xsVnOy2LbynSHvbW7MC+DmviAoNXnGgkYYoVakmxnD9W6CJ+lWcZonH/Yve76Y6ulnTcxJnczzXFywlOso1cCI8Evh0jKmGgQ6rfk/6V0cCeyEmaGO9OQbUjBtrnenWb6W4sD0KNzN19DLpcu8g1hZa62RDgeilzKx6MZB/uia3zFJMPpb4sbpA/9Dqzathllu+Y4/r8pFveaV9gxcC2cwpqofinhAHXfnhXgTILkOzWWB/ZOW2PSGfxgvnK/Rh1U8nfz8h9dO6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1875.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(110136005)(316002)(83380400001)(54906003)(55016002)(9686003)(966005)(71200400001)(478600001)(26005)(8676002)(8936002)(76116006)(52536014)(5660300002)(66446008)(66556008)(66476007)(64756008)(86362001)(66946007)(4326008)(7696005)(6506007)(33656002)(53546011)(2906002)(122000001)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ew7Y81Cj5Ya8V+lMx1r/91P2YFCdhKuHjKm81IyMJlh3LLul5pFa+4o5DwiA?=
 =?us-ascii?Q?eUTEYM4fIcElfY9Aq9waa0ubjx2pVTkcnnSk+aLYJBu2VfaVAewQg3sOFZPO?=
 =?us-ascii?Q?t4Wc56hrXJVnOUZLl/HRCPs2GwG7TSkKvVGGn616q61IXEM305v4rZybpoxt?=
 =?us-ascii?Q?Ccwe2uiFFGgTJzDZnN81YyAcp0nH5oInOk/mVKkpnOG6T50oGwFJyoTvsqKb?=
 =?us-ascii?Q?9MC7yQwx9miYa0obPZyXwz54UhZknxcTveXzcgyYCf8Dqhu85wfttU5t+PuV?=
 =?us-ascii?Q?QXsO5pQz2/YZaGpeIKWPousYYiFWGlo771bFBuLW1bFDyo0NeskwFj2EhsOP?=
 =?us-ascii?Q?FvUImioxabj3658NcGy8/1MfMs+qvuWbO40joNUON6kSCE37ydbgZ38PzJNE?=
 =?us-ascii?Q?zWiZXngJ4N6+nWf1r4tP6uPsNy1GVwOkZBD6XDVjwQedByvSoJy8GIwFgo1j?=
 =?us-ascii?Q?Mrzqlny5mlO/unqyDiOeN5ThU99FG0uCGUd+mShtTKIPDKOSYUQGDqY1N9uy?=
 =?us-ascii?Q?k4tVoF0sJvw85Q4Uz6V6eC8I8pt+v8xP0kYVZZeNZeBiW6poXuEt/JVWVicx?=
 =?us-ascii?Q?PL5tUCEzZs7njtBqEdE9aGjKClYJN5tCRFmxUF1/bCOlquPCxGjuIndpFhRk?=
 =?us-ascii?Q?FBbY1cWs/c1x3Fu2Km18xyPhx+45KlSju6hqD1z9REFaTdDlXhsWiBbkkTif?=
 =?us-ascii?Q?jesPfKLshtQJ3Tgph6sPOtbkNAOYrC01yQMH4O4lyKxexRqQ+39lpCeveliU?=
 =?us-ascii?Q?yOouhVohVhgep/kQmgHZuAqi/nY/0UeadR5Mq2iVSPQKGk+0aqG8ems0/9ex?=
 =?us-ascii?Q?cq2XajHPyb2EPZFpl+HXtJy1SmC+YW1xc5RJrP0Uq/PNi3pT/J+thM0bJP+Q?=
 =?us-ascii?Q?dID9RPQSYJ6kcSO28FYp9ZIa4Y/qazKvJfyFRR0Qp49e1uRM1m8gUYli5Lur?=
 =?us-ascii?Q?NyHBiUqEgEu4cyc9vE8vxGZpA7CRePsZC1WW2ZF1rYcwODWhLTTeNjgFTwHd?=
 =?us-ascii?Q?WiXLbor+rk1zxcUjqVR28swZ+E4WrKUUHcZ7PFZMKKBMpOJJwjMw7kMbQyR0?=
 =?us-ascii?Q?/M281zZf42P+G2WK2af0GY2LwyvScYBch+W3lfIsUbQlWXVWvapecJIqJV8V?=
 =?us-ascii?Q?qGX5liIr7gQdaRZwh+6HNtP/etykB68uQz1r+x7tP9CoLuevpWcsJwtcyR4S?=
 =?us-ascii?Q?Qsb/whJrQKjKYGA1dCiHk5zT8H8R66ZXArt58wiptPaaZ5ou7Gzl2HRA0EzV?=
 =?us-ascii?Q?PXDDHJMCwrolzFAmdVEG2c1MF0JzjMuN544SlALamr9UKwmzqvAoQIst+qiC?=
 =?us-ascii?Q?kp1BMcxXRfqrfSeVzvcaGNuk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1875.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8088404-5735-426f-9dfe-08d915b69455
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 02:26:56.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIR+nzYP+18kEgE3ppg/xqtMad4lYdALrMSSwHQWgEF2pgGdQRIVvWvIYF1pPO+FEwSIr+DWGxqI3nnupuD9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2546
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Wednesday, May 12, 2021 7:31 PM
>=20
> Hi Kevin,
>=20
> On 5/12/21 4:30 PM, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Wednesday, May 12, 2021 3:04 PM
> >>
> >> Current VT-d implementation supports nested translation only if all
> >> underlying IOMMUs support the nested capability. This is unnecessary
> >> as the upper layer is allowed to create different containers and set
> >> them with different type of iommu backend. The IOMMU driver needs to
> >> guarantee that devices attached to a nested mode iommu_domain should
> >> support nested capabilility.
> >
> > so the consistency check is now applied only to the IOMMUs that are
> > spanned by a given iommu_domain?
>=20
> Yes.
>=20
> >
> >>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
> >>   1 file changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >> index f1742da42478..1cd4840e6f9f 100644
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -4755,6 +4755,13 @@ static int
> prepare_domain_attach_device(struct
> >> iommu_domain *domain,
> >>   	if (!iommu)
> >>   		return -ENODEV;
> >>
> >> +	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
> >> +	    !ecap_nest(iommu->ecap)) {
> >> +		dev_err(dev, "%s: iommu not support nested translation\n",
> >> +			iommu->name);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >>   	/* check if this iommu agaw is sufficient for max mapped address */
> >>   	addr_width =3D agaw_to_width(iommu->agaw);
> >>   	if (addr_width > cap_mgaw(iommu->cap))
> >> @@ -5451,11 +5458,21 @@ static int
> >>   intel_iommu_enable_nesting(struct iommu_domain *domain)
> >>   {
> >>   	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> >> +	struct dmar_drhd_unit *drhd;
> >> +	struct intel_iommu *iommu;
> >> +	bool has_nesting =3D false;
> >>   	unsigned long flags;
> >> -	int ret =3D -ENODEV;
> >> +	int ret =3D -EINVAL;
> >> +
> >> +	for_each_active_iommu(iommu, drhd)
> >> +		if (ecap_nest(iommu->ecap))
> >> +			has_nesting =3D true;
> >> +
> >> +	if (!has_nesting)
> >> +		return -ENODEV;
> >
> > Isn't above still doing global consistency check?
>=20
> The logic is if nested mode is globally unsupported, return false.

why is this check required? anyway you already have the check when
prepare device attachment, and only at that point you have accurate
info for which iommu to be checked. This check looks meaningless
as even if some IOMMUs support nesting it doesn't mean the IOMMU
relevant to this domain support it.

>=20
> >
> >>
> >>   	spin_lock_irqsave(&device_domain_lock, flags);
> >> -	if (nested_mode_support() && list_empty(&dmar_domain->devices))
> >> {
> >> +	if (list_empty(&dmar_domain->devices)) {
> >>   		dmar_domain->flags |=3D DOMAIN_FLAG_NESTING_MODE;
> >>   		dmar_domain->flags &=3D ~DOMAIN_FLAG_USE_FIRST_LEVEL;
> >>   		ret =3D 0;
> >> --
> >> 2.25.1
> >
>=20
> Best regards,
> baolu
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
