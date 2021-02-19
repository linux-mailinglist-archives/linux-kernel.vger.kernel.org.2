Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57231F50B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBSGTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:19:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:20421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBSGTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:19:51 -0500
IronPort-SDR: Ga/SX4T5QCllIvG3l8pbotyA1jXIyzqIshXIaoQBpfGOBH8WC8Z+uXFbU+C04y/Jou3iLBeiRC
 JxNHDvdITWhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="183817567"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="183817567"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 22:19:11 -0800
IronPort-SDR: zYSZBu03p/8DCZsF1eeTZnLiwzxes4j0LDZo/HnU3mzYdCuJwWArWtlhZ7QC5ksvl0T8leBlg7
 MGuzjcIzN6mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="400875191"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 22:19:10 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 22:19:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 18 Feb 2021 22:19:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 18 Feb 2021 22:19:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCeekaDrqnIQH712/v78GtGixXUaQhBD8DJ1OE75vwv93c/fySohIHDM1+fTL/zATQX8kAOB4aHJcV1x5QlM4vqafTrNJx91UJ1rUpgmUa9Oyctp/4K6xdmiQMi44mgff+cNKA1voygTq5iuSbSd841cNbfJHdI6h5Ck6X4S10/unEjErEibm0CqloAcalB1Ef+BY3ilmgzdAMPJX6LEjY007LIvTfb/CRxTHd7VnAa6CGO0YzTvcTHdMR4ml5IIqW0q7+B7yFqWC/kVPJFThQf8+nBM6Gb6rFedKQ61A+MGOoVmVkzcVzjRekIAL02XambhKvlDgufGjG8moxvQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn7FkvS7tWvmc8tx2a1g0YZHjk/pyH9zAC/h0uQpYxQ=;
 b=L/vWQRgboMnUH9kHzE+j43RhnmNjkd/yUUHyc38/CVBrVOgxqT4tRURmdfO+qpSEqvmuhSr7aw4wAGtRHE095aLIpova7L9PH5WaYce8zo8QP0VXNFfW/GJa+4AWRmq6cRUhuaJ6ycx45QhLGtQ6t6wWOuNiRdXLLtXMG2QOKfANvEBWMcIcoM1ssJa0W2SPeky3lRfg6k5dZPVJYd+4g+7X//mo4lqRhMczU3zipCc/g+VJiJT0SJyRbZ8NpUQ4P6ryDXZQ1JUHe85Xf+7TiqPnYGIPnW/qAatCqtoKhDMjIogztDs7SZAJrjGtNZPYNIz3ITyAdU7swHM07mDuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn7FkvS7tWvmc8tx2a1g0YZHjk/pyH9zAC/h0uQpYxQ=;
 b=EukOnRlv6+EYG24OHX9rWw1Y9fZCDmLN7euKUNTEQJSJb5CJ2EMDKnQ3Wwn9/qXcgAueIBow/YcCyumq0lCWfWnVulV6hM28TTpR7zf/JfBml+8CgclDGWT36rgscaY1KG+Q4FaleztlNQQMinw78NFKMQy4PJCQwxITtsxRD3c=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 06:19:05 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3846.044; Fri, 19 Feb 2021
 06:19:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Thread-Topic: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Thread-Index: AQHXBoTVNqb9bp0o3EmwFylJcNjAwKpe/2uw
Date:   Fri, 19 Feb 2021 06:19:04 +0000
Message-ID: <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3d4d88d-cf5f-4a0a-4590-08d8d49e41fb
x-ms-traffictypediagnostic: CO1PR11MB5044:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5044655554B72E7F58289D6E8C849@CO1PR11MB5044.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FX7I1ytWAcskSHLdb4AluUYYbBILIifhXoBj64QJtAiLbqieRQHVxGfe5FX7cnyWd0etsvqY8WDGIFXSVFT6Fy09K4lbEX7saUa7QSE8GHFDvy/6OgXTmEuWIJG7KwisVH8qaMFcKUfTLFymFyPxNyX5yWIyQ4bvW4T4YlG2her/jl9v17CSFp0HpovVMIPQwBHBPQ5QOOxGsTg+mECvHDPEDVw4jnQ62T7SoozGZSb1kJoLkebaRt5Nj2V89iZ1myMfcyA7tppDgJvJmphGM6vCZ0zWtqM1PlWh3RKMDnP56XG2vRyhWK6QstUtWju7nZ9bnI4Rjf3hOGmzVrCatr4CEMEpc3Z8Ju5x9N9sxmBML3ahCmsgOjSOiVjGDb6onxSXuqYNOi8J+maVhSY1IH5mCcSelGAOxUkAqQE6t7ZQ7k1Xo94kIB/Emit4LNUHKzjd1CGaoWJNtJGLlt4oDi3mhsxJuqUdtUjHTHLB/0a4sG+Lv2R8xMH7HQgbuNqzsB1trqVRTiEgPROmQbcKcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(86362001)(186003)(33656002)(66556008)(4326008)(26005)(55016002)(316002)(7696005)(54906003)(478600001)(110136005)(6506007)(64756008)(76116006)(9686003)(71200400001)(52536014)(2906002)(8936002)(66946007)(66446008)(66476007)(8676002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EBsYzc1natoQPLL3jfmx8ZLM4kkQ2UnvYuRCy9jDDeTGrkKN4LK07gGlNFDU?=
 =?us-ascii?Q?L/fQnfL7yb7u8aFXaxxZoQS39xpkVMcdPU4zX0rrbG5BYS8ncAfdJ5PSi/Pq?=
 =?us-ascii?Q?VL93/57qB0u98c7qUb5L5d81Y0fZao4ivux41CYqgMBSH2KKy2QtWbSS/OCZ?=
 =?us-ascii?Q?6ZiOqtiNNTbgLSFa8fxWmV4xvCDyaVQk5wAV+sS1hv5fCI/4rpdk3LvKo7bT?=
 =?us-ascii?Q?Pi6HNqegFXXmlIBUenuojOmanV9GoyKxOSv0smrSqPxYkAW5iNklSp2j1x3U?=
 =?us-ascii?Q?er9PktLRbyOvICRNEdMJkyk7WbA20pj1eRRHdWfW6eHujcfCvdru64KCX3oQ?=
 =?us-ascii?Q?/JTs+YomLeaOCpNO/KQdpGbNXbA5skSaEIo+ndx2r2c8sUn41phvw6Foqfff?=
 =?us-ascii?Q?1ha7UpUuTFwnl2MGC58QJU5ImdhmoKZo4oI0cA6+7D26+QIvlGMdNZfyq08a?=
 =?us-ascii?Q?13pYyqdGxOgsPSqiCxOxy3TuuW5vkVIg1fFwwpfs97jsr3SwshfS/TzSX0Ah?=
 =?us-ascii?Q?VZymNRxxR0gy/FP+F/qM7v0Of6BD5duk0pYslP9ByiO25obCwfLQrOivf2EU?=
 =?us-ascii?Q?tjry8pkeMzhStXJeLTyhpA+R5zXlKXEnNYjyPCYq4FdQCw98VPPhH4FDLtdK?=
 =?us-ascii?Q?87ka0naRO7fNU9DE0dkfQX9Xmk8SuJr0CAoNkFq45ST7wzE2tk9hF7g3OxoV?=
 =?us-ascii?Q?mbs5melunfJGVE9lDfCjQsgMkbTecGNRrlOIqWsbFE2yHjeqplWcMJ+GKZ1O?=
 =?us-ascii?Q?gbJGo/vIiLNpLhaSPZwaXsGDqCpmdKcqyQOeg7xckJXKIWh7VHUmpgIgpUiZ?=
 =?us-ascii?Q?puvv5AJTnq7nyIvoFd3saLlJ9ZkB7siC1Jg6IyyH9ukoHN6P1uHxbX/eVOph?=
 =?us-ascii?Q?3ePNToji9lQTfIJGnvPmQY3hL9JV4QrAqLrKmfO832yYXk1xNBFnZ6p/nQvx?=
 =?us-ascii?Q?6ri5GCk7C+8cG9ed5ftmmiDC+mFa961/TKGKxRHscKbClcVIOR8AfAEo4HUc?=
 =?us-ascii?Q?qhmIx00/+8iXCZLJQlOG5e1V3CbGHPPk50vw12IDyyKByNIPFz8of9rf3HGn?=
 =?us-ascii?Q?l7KuN91waVq5g1VzsZkfDK98qCuAdFu7lYzntaQLr5mPSnOg0sLMuZX/b9rr?=
 =?us-ascii?Q?nKEcMrGPE1q/KJ4EYzmSkJElGuBw93wHtOwn+8lixIISrrpx/SaX1pidx7M6?=
 =?us-ascii?Q?zjKLkj0k++gLfg93QcQI039rnOyRt0BVr3NyW33zS7lDqU2MgsKzXYjeGorM?=
 =?us-ascii?Q?PF0SqnptBVrnbISgJt1Mp68lBFQHWNS5QgS95YgbDF+/ZjnsO0ewr7uo7SVa?=
 =?us-ascii?Q?IkTHYSdV7nEywDseWVniqbai?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d4d88d-cf5f-4a0a-4590-08d8d49e41fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 06:19:04.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: didz2X7Ce2qHji/LwZeIOJ8Ce3rC+jbSGo/XLhZltswNb2M/zk87xownPpoeAVrWGC3fHG4hIoaBsEFViWDttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Friday, February 19, 2021 5:31 AM
>=20
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In guest supervisor shared virtual addressing (SVA), write-protect
> should be honored upon guest bind supervisor PASID request.
>=20
> This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP bi=
t.
>=20
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 5 +++++
>  include/uapi/linux/iommu.h  | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0b7e0e726ade..c7a2ec930af4 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct intel_iommu
> *iommu, struct pasid_entry *pte,
>  			return -EINVAL;
>  		}
>  		pasid_set_sre(pte);
> +		/* Enable write protect WP if guest requested */
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> +			if (pasid_enable_wpe(pte))
> +				return -EINVAL;

We should call pasid_set_wpe directly, as this binding is about guest
page table and suppose the guest has done whatever check required
(e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an additional=
=20
check on host cr0.wp thus is logically incorrect here.

Thanks
Kevin

> +		}
>  	}
>=20
>  	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 68cb558fe8db..33f3dc7a91de 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
>  #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write
> through */
>  #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem
> type enable */
>  #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level
> cache disable */
> -#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
> +#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect
> enable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
>  	__u64 flags;
>  	__u32 pat;
>  	__u32 emt;
> --
> 2.25.1

