Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4530E9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhBDCAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:00:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:50422 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhBDCAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:00:33 -0500
IronPort-SDR: V/kA2d6DYhxzlH1q/BJ0P3jNMdcV1KXKJu2wBeEOsgnaAfd5LTExOjpfTorjrK7UWKPYo7hMxz
 URd/K7JNqjMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="178592699"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="178592699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 17:59:49 -0800
IronPort-SDR: KAFf97/RPEnC6xskHmjCSeK74eTSGCQ9Wll58tSJz3qLbhat+uKhuWnX7hcbM7L58vwe4DQ/Ho
 b/2OvpjVOC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356986249"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2021 17:59:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:59:48 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:59:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 17:59:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 17:59:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z87nI/7p29ZjVbTePhXvffWf/KIsoQDXORGQVIdtpjpXC1qrUYuNerLELoMgQYjl//nlBQTdFhAizfUhGDmUUG98YdkO7BbZsfn2Ag8SFTBrcKcKkvXxwLzy76cDCiL2mmwRMzW4B9TABNcUXrSdCZ3zLE6z38VhdfPNUnt5ESTTcbrw8guF4Sng1B7XaPR0CSUmW+9WguYLa6Gb/z4QCL5bEl3E/r9xI/DJS5A/J9btBprXElcLQOAxugYEwkXZdK0VARh+EAixr3uy6MAh8D1AGEITqdz5awgjsM7f7qiIeH8SHEKSVJZyIly13UCjfAGygCO/jRpLdHgPgd/68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PrX0Yg66kj05Hp4JMjkdMgoXHlfGTTRWjkv1HTYY54=;
 b=KP4XzVPz2HDiCxSbY4BdeKN6K1gkLUBFaBsySXkVDdJE0BRq/qR6REpyVXaPfutG8gNStPIXnYxJx2t9xTqyqmA+pNrpgVSlSfcqsBCe2Efujb8JbwfBLXL7VGrdXbdP/y5GFtczFfqGmUhWcDYxRS63ehpk1B9CpmL/Td/LkpkBs0eikeq4YtOyYPWyfRLhpRQj+L9cI1aVGDU0vAVnxT3aKtEIUWu7D6uhAxo9NFcz/SOeCZQ586rwD0ImR5PzAye4+NgpVQw4U9HdcCuAkoQjjcXu/Tqpo059ex+240/9f9dg4oQALe7WQ+DYHPw9hEGt28OuNGWpGmJ2vlM+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PrX0Yg66kj05Hp4JMjkdMgoXHlfGTTRWjkv1HTYY54=;
 b=HnZjeTUCBUWzBTal4B+eyLUDo/ssqXPk/Bk55QIgyvDYk7mJqq2rc+WbDoePFnUawiNmm/zYx/NbB2kyxrEPvKUy2sAnszavYWxtZhjk3yO3hk9BJYhyVVHq9499pMpi6pQrr5FZG7TvlwdZYC3gWoPoNZ/TaK96Ur9mSKDjfQ8=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 4 Feb
 2021 01:59:43 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3825.019; Thu, 4 Feb 2021
 01:59:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH v2 3/3] iommu/vt-d: Apply SATC policy
Thread-Topic: [PATCH v2 3/3] iommu/vt-d: Apply SATC policy
Thread-Index: AQHW+hDo9+I47eJaj0qwgw7wJLyzI6pHOcZg
Date:   Thu, 4 Feb 2021 01:59:42 +0000
Message-ID: <MWHPR11MB1886133A35BA369F7EF3014A8CB39@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
 <20210203093329.1617808-4-baolu.lu@linux.intel.com>
In-Reply-To: <20210203093329.1617808-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6609eb13-96b9-4390-daf9-08d8c8b08a20
x-ms-traffictypediagnostic: CO1PR11MB5155:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB515516BA1DE8FFA0C2794C2C8CB39@CO1PR11MB5155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EGxtFQOja4Z/1ssZ2PRAYMzmxxMGj2K1dexi5pHUH4o46JX+NeF+ImhU45mmFzazqRWFWMVswG4HJAcvstY1RTKnHfz5VKl082w5LrM25fk8grm05qHZElM8gf9jYLYvv82Y3BVRfdfcXnRKPF1+OnjcI39xkg12rpIFPcP0/7Knw8OuwuIxz0dTrX8iVv46QjbwAPP/uudYWcQ88VceSvvpjtMvund6mfLGJhz8Jl5ohLmp5XALy+20pjVIcExOZg6QmPO9IBgk+4a/MHtdfIVgpclwcVtcAYyA0DTqnSk0gHRgT9Y6ApUIP+bYoNa9fBUuQ9Y3FeRWTua4yw8/N/5V0bukaRxEeqQW4q7NE5VOkPtLNjdX0aRGFbgrQ2FcaePfMZV5C61wQ4KeTpFoyQi8vxqgJNgZL9QCIsKjfu5kzmdxKI3B3OVKtXMXgEa1JQ1wuKOAI5Ry2PVMzyr2BVdWOO6I5u2TAJgf6Y7wR3uEz9m5FqTQPhltJ+qpsRsRug/Mr371UY8fMMY2HC06Df00C8Oi51NgGoVrSbZ/j5FsMs/t+7Uk4UbgJY6VcNZb+R+1ZZyaBEqT7QGBnU06VcEHE5qGDRBelvflFn7mNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(9686003)(33656002)(83380400001)(316002)(8936002)(110136005)(5660300002)(478600001)(66946007)(26005)(7696005)(71200400001)(8676002)(4326008)(186003)(6506007)(966005)(64756008)(66446008)(66556008)(66476007)(52536014)(86362001)(54906003)(55016002)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OG/Wx4ouPK6JmiolkXp1O0kwzuPeYQVJsoY+Iv9V4qVAwBIJKLV868oeZyjl?=
 =?us-ascii?Q?2E5isNWRumvFXbr8Lsv1AGaWW49TFWSgyBcp6RmI+DN8gyeuIDwmJAO9aTsI?=
 =?us-ascii?Q?QQ2KqUA4nlzTE4LYdzUAmzl3TMRwy10fgAN1hmHv34/SsvPhaMwMwHBoOLfm?=
 =?us-ascii?Q?6shc8j1SCpvDsXLPNk4axHhBsfH0Woh9XSLVDXUSf9GAiFl5BsXti3NF5rAv?=
 =?us-ascii?Q?J+o7fP9KzxyiF+pxPXD34CMgC3EJjwb9/Viu2s/iHT8uHRk6mJCb30ZzE+V7?=
 =?us-ascii?Q?djm9JPYBfXYav1rT4cxRkkIHES4rDFG9krLv6mkWEZHwXp7qBQJfPMQUF6r7?=
 =?us-ascii?Q?smli9/NJIYCnjaQ/LCtlxblCnJ+sapvxpN5HP25TuDFpXDk1CaQzPFf0XG1q?=
 =?us-ascii?Q?wbdOtVOj7IK6s7ldrJJ/iVxvYPowchHhzc2OH30ljpD8kLQaVcyOvKiR2/5s?=
 =?us-ascii?Q?+M8W3iqnZFJQ2KDbeZByKoWlrST3lN6Ey5pJ8QJ+CGOBN2UoGwXO+y3/x6KF?=
 =?us-ascii?Q?BIqn3wtR2kot1hZL5JWxy8MXMfCRCx6EM6F9QUwwV+1V3CrgxcT383Yf9T8u?=
 =?us-ascii?Q?qro8jvG+pxqT46Akwyz67P1lbgzu2Bn3Qn1+ddc+CG44sHC/I9AV3hleDQZ7?=
 =?us-ascii?Q?i05ZObflGaUx2ndFVHQGAdsx4Hu+ztMLTj//7172tL9GnNPDLiNqzxogGDVI?=
 =?us-ascii?Q?XSnopvJxc+LWBXeXsC4IapZ3QgijrzN5Nup/Vh1idsgJSLgrycsonJ004bW4?=
 =?us-ascii?Q?4miuCOnW+54d53WZEJBDuV06bYxSwGB7jZXIh1rUtJkFvCRbYZjMr6QmIds1?=
 =?us-ascii?Q?6uAT5DW6bdUZijAWCRu5QOVses5eCifH37ZxLOby4Ah+l+yo22tubYJwTPt/?=
 =?us-ascii?Q?oc+1EAipRx4ZEHUDFbRs1+lC69AhmHob0e2qpYpEy8V2iF0SGtq9/fuhk43P?=
 =?us-ascii?Q?tFhK1S1OSjiGKUC9/dTz/Elk9cOvHY+F9oWIxXv3IRPzOXasUxlGvKkOcPFb?=
 =?us-ascii?Q?ymNgT1PgC5OIw/0sTkmycEBkTRykTL0zU3DQxBEJPESmIa+PfKsuE2kY+iRL?=
 =?us-ascii?Q?rKk9gI2f/uoHgaQZXgggQxPzGMpBqLTtUYjIjm2H4507cNlCE0VzRIkh5Lp8?=
 =?us-ascii?Q?ge8dWFl8u3VCVVmA/58mzaVQ0KrPvzW3bkme+DRDbQRAH8ByAFV07dCEgIQ1?=
 =?us-ascii?Q?sV58Ur+CtWgied5hl5yOM85q9L/XMqKRwiXxvt4xpdymGXQDjgJaE29opnKT?=
 =?us-ascii?Q?HDXpSAm7wlc6UaaInwHyoJAq0a8v7wki+ybZ7O//0A0TOyFwj/5B9FUuIWuk?=
 =?us-ascii?Q?kOrhIlT18PD/70edjjb17KqI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6609eb13-96b9-4390-daf9-08d8c8b08a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 01:59:42.8364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYhxP7qcF2t5lJSpQ4x8m3PxdtftO2l/UiTzKyWgu9eTqzD5BKvt+ldfVVyaKERhtb127N1ua4BMNEFfyD6eUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Wednesday, February 3, 2021 5:33 PM
>=20
> From: Yian Chen <yian.chen@intel.com>
>=20
> Starting from Intel VT-d v3.2, Intel platform BIOS can provide a new SATC
> table structure. SATC table lists a set of SoC integrated devices that
> require ATC to work (VT-d specification v3.2, section 8.8). Furthermore,

This statement is not accurate. The purpose of SATC is to tell whether a
SoC integrated device has been validated to meet the isolation requirements=
=20
of using device TLB. All devices listed in SATC can have ATC safely enabled=
 by=20
OS. In addition, there is a flag for each listed device for whether ATC is =
a=20
functional requirement. However, above description only captured the last=20
point.

> the new version of IOMMU supports SoC device ATS in both its Scalable
> mode
> and legacy mode.
>=20
> When IOMMU is working in scalable mode, software must enable device ATS
> support.=20

"must enable" is misleading here. You need describe the policies for three
categories:

- SATC devices with ATC_REQUIRED=3D1
- SATC devices with ATC_REQUIRED=3D0
- devices not listed in SATC, or when SATC is missing

> On the other hand, when IOMMU is in legacy mode for whatever
> reason, the hardware managed ATS will automatically take effect and the
> SATC required devices can work transparently to the software. As the

No background about hardware-managed ATS.=20

> result, software shouldn't enable ATS on that device, otherwise duplicate
> device TLB invalidations will occur.

This description draws a equation between legacy mode and hardware
managed ATS. Do we care about the scenario where there is no hardware
managed ATS but people also want to turn on ATC in legacy mode?

Thanks
Kevin

>=20
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 73
> +++++++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..3e30c340e6a9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -872,6 +872,60 @@ static bool iommu_is_dummy(struct intel_iommu
> *iommu, struct device *dev)
>  	return false;
>  }
>=20
> +static bool iommu_support_ats(struct intel_iommu *iommu)
> +{
> +	return ecap_dev_iotlb_support(iommu->ecap);
> +}
> +
> +static bool device_support_ats(struct pci_dev *dev)
> +{
> +	return pci_ats_supported(dev) &&
> dmar_find_matched_atsr_unit(dev);
> +}
> +
> +static int segment_atc_required(u16 segment)
> +{
> +	struct acpi_dmar_satc *satc;
> +	struct dmar_satc_unit *satcu;
> +	int ret =3D 1;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
> +		satc =3D container_of(satcu->hdr, struct acpi_dmar_satc,
> header);
> +		if (satcu->atc_required && satcu->devices_cnt &&
> +		    satc->segment =3D=3D segment)
> +			goto out;
> +	}
> +	ret =3D 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int device_atc_required(struct pci_dev *dev)
> +{
> +	struct dmar_satc_unit *satcu;
> +	struct acpi_dmar_satc *satc;
> +	struct device *tmp;
> +	int i, ret =3D 1;
> +
> +	dev =3D pci_physfn(dev);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
> +		satc =3D container_of(satcu->hdr, struct acpi_dmar_satc,
> header);
> +		if (!satcu->atc_required ||
> +		    satc->segment !=3D pci_domain_nr(dev->bus))
> +			continue;
> +
> +		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i,
> tmp)
> +			if (to_pci_dev(tmp) =3D=3D dev)
> +				goto out;
> +	}
> +	ret =3D 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8
> *devfn)
>  {
>  	struct dmar_drhd_unit *drhd =3D NULL;
> @@ -2555,10 +2609,16 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev && dev_is_pci(dev)) {
>  		struct pci_dev *pdev =3D to_pci_dev(info->dev);
>=20
> -		if (ecap_dev_iotlb_support(iommu->ecap) &&
> -		    pci_ats_supported(pdev) &&
> -		    dmar_find_matched_atsr_unit(pdev))
> -			info->ats_supported =3D 1;
> +		/*
> +		 * Support ATS by default if it's supported by both IOMMU
> and
> +		 * client sides, except that the device's ATS is required by
> +		 * ACPI/SATC but the IOMMU scalable mode is disabled. In
> that
> +		 * case the hardware managed ATS will be automatically used.
> +		 */
> +		if (iommu_support_ats(iommu) &&
> device_support_ats(pdev)) {
> +			if (!device_atc_required(pdev) ||
> sm_supported(iommu))
> +				info->ats_supported =3D 1;
> +		}
>=20
>  		if (sm_supported(iommu)) {
>  			if (pasid_supported(iommu)) {
> @@ -3155,6 +3215,11 @@ static int __init init_dmars(void)
>  	 * endfor
>  	 */
>  	for_each_drhd_unit(drhd) {
> +		if (pci_ats_disabled() && segment_atc_required(drhd-
> >segment)) {
> +			pr_warn("Scalable mode disabled -- Use hardware
> managed ATS because PCIe ATS is disabled but some devices in PCIe segment
> 0x%x require it.",
> +				drhd->segment);
> +			intel_iommu_sm =3D 0;
> +		}
>  		/*
>  		 * lock not needed as this is only incremented in the single
>  		 * threaded kernel __init code path all other access are read
> --
> 2.25.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
