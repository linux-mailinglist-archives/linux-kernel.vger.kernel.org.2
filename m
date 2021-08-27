Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784FB3F959D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbhH0H4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:56:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:50330 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244363AbhH0Hz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:55:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="217954592"
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="217954592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="576007016"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 27 Aug 2021 00:55:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 00:55:08 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 00:55:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 27 Aug 2021 00:55:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 27 Aug 2021 00:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCjqa6ryiE0yWqYGRkmA50RSg8ClS3FT+Hokd+AdQkva84mZxWPZXv6WeMInHMjxMJUHjTeebuf+IGttmWZzw2Cz6UilhmHyq9UtQDUThLRTjNMz/cXZBM+Gfc2UbYxmNhLlocjzi32oHD561Kd4q7aWkdPT4X1Lq6OSEYQMu2YrpBFCrSRm3cfJIk1V39PSN8hNygFqh61N5HnZcSYrzvz4KHOxXRF6HmPlJm0ErRX3JtYlQGpEj8no8499aGuOsXIQEgop8N55Ga/E6DQJbKNWqjepFAFiHYX8ktgxrnHKyrr9kEnxqI/YH9CaVZyZeViwVyCgT8YDzhwUi27lpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMmqTxN6HyGZ/pTg7lA8sOfndf12ISFvtD3KavhzmU=;
 b=APcGZ0+l38RRfxGv5hPIQlzQzC8ExGf+HwajpvAJPc2kYctEZhd4M0UnrsvEb3urgmjs+B5fg+kp27fJDtH+2x1x/kOKZKizPJZ20KnjBjEniMpIAnN0MwRE2FnCfvPpm/GFLWrlC0IPBIEHVEzbLpwHK/relei/z7KDk2G+CvgnqjSqBjVPp9z8jFJSZNaFvXAZFiMEi6ZjyIV/JOAd7uqqTYEZMTE9h0HhEJ49sgarfuTr56xI/4Y4hOUVmR2zKUVexyCUg/UCBwfgULe7vKYNmeYQwZg4LE3tdR6qMECEzq+usKmvL6QPU3DXoNue6uGD21obstGpJp0OpGfHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMmqTxN6HyGZ/pTg7lA8sOfndf12ISFvtD3KavhzmU=;
 b=vLKXVp52j3nZU4X6ePTHZRba6LOczGUh1EL29/VMpDg5VESwHI2fXvU1SNZb1hyP88ApVbWEy/V2nm/1hgGvONu5pZ2Dr7EX83u1ey1sbajlL+FzZZ4nctN4ycpFTTOYsydvKoXu6ozAupkWhQhUItN1hrkjJxGyFpG41eFj40k=
Received: from BYAPR11MB2661.namprd11.prod.outlook.com (2603:10b6:a02:c5::20)
 by BY5PR11MB4276.namprd11.prod.outlook.com (2603:10b6:a03:1b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Fri, 27 Aug
 2021 07:55:05 +0000
Received: from BYAPR11MB2661.namprd11.prod.outlook.com
 ([fe80::29ab:37cb:8f43:cd9f]) by BYAPR11MB2661.namprd11.prod.outlook.com
 ([fe80::29ab:37cb:8f43:cd9f%6]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 07:55:05 +0000
From:   "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: RE: [PATCH V2 3/3] arm64: dts: add initial device tree for Thunder
 Bay SoC
Thread-Topic: [PATCH V2 3/3] arm64: dts: add initial device tree for Thunder
 Bay SoC
Thread-Index: AQHXfSdUc5B0XBEUTEe+3UCDr3sM3qtabHqAgCy/a0A=
Date:   Fri, 27 Aug 2021 07:55:05 +0000
Message-ID: <BYAPR11MB2661594B0F0B87CE35CCB08E8CC89@BYAPR11MB2661.namprd11.prod.outlook.com>
References: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
 <1626758569-27176-4-git-send-email-kenchappa.demakkanavar@intel.com>
 <YQMHNX5cCBFdm7YK@robh.at.kernel.org>
In-Reply-To: <YQMHNX5cCBFdm7YK@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc32a15f-1a96-4126-6407-08d9692ffbc0
x-ms-traffictypediagnostic: BY5PR11MB4276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4276C1256513AB4B569091A48CC89@BY5PR11MB4276.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miWUth6Uwrh4Lnk8/N2wlPe/68NxTnZcMR67nZWfNNQTY2ou/DgwhsB+ms7kSNiHS26Y/9LwRtDCWxTbAd9aWM0AyY1XAaMhZ62/HxXhw16azh6LfpZguRNzb/b9h3w5JbJ+Quj4ApnxcZtQe/hQr004S3LzmdfpZmFoQ73GG/ZyqyTr1pLgEMGoXwcVfSSoS492aMV320p/Z3i3xJKtbfnjVZm/dyH8E+TCVQ14DuM1R6UG+huR7JYqG3aAc1vIFvWrN3V69s5Ig/drj1mdJC3czNM0+/qdVOyRGvuh2vCqhZ2QZTl8XJrklewsrqhMnzCfbVj9wNhiYrvIHVv7MvxFC0/ak62lAE0M9aBYaFpelYPjAWr3eJjbRRkPinnUZKrgm0LIch6B9MaqO1gMiibs91Xb6SwT/qEE7EPiKzWmfc+qKDGSeShJ18Hgy/Pp2iEYwyXopLUksOwAeFjs/vBWwyerP3ZmEnDEF0xxq+YUJ4t5fMcn1vxYJVrkvMgGzRy+nxXp3/q6y5oBcf+MRtQZ8jGmQzlnYxuteMNcrVrlWiLnIYQ4qyz+PJ59djGxXFytquYjxp8eswczvWf9lLBK2DJMUq0WjGIzSVworgsgbvwEXq+B0ni/4WnQnjUl4+gy/c120SBuVYu0oD5Q9I/tGaLLlLHsM+cSzA/2aQxO+siP7b7XjD2kAr04Ed80wY/+HdsWH5VnNKwevWFTKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2661.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(71200400001)(38070700005)(54906003)(6916009)(4326008)(76116006)(316002)(38100700002)(122000001)(86362001)(8676002)(7696005)(66476007)(66556008)(33656002)(55016002)(64756008)(66446008)(30864003)(9686003)(8936002)(66946007)(52536014)(186003)(26005)(83380400001)(5660300002)(55236004)(478600001)(6506007)(53546011)(2906002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JkBsPEMJ+3nOo6qdSzyuDwnAXKLzDop6T+IVXlbPNavwZQF0346pfOsj/lyJ?=
 =?us-ascii?Q?gHFRofBCjYN4wCqphYQ+eZrgQGOvpdSRFzTzHElXZ8na/JOnXPhIqGQBBwV/?=
 =?us-ascii?Q?xSG3+wDqLDTvKwrJvk5Ekh73/ouujz5a1vA0HuCdZ82hZp+18VoxQ8XkA6wH?=
 =?us-ascii?Q?GFpo8c4ggE4+2bwy4qeOVHUIReWP0/Zc5k8usgchpE4NmuY6gchKy4RBuAI7?=
 =?us-ascii?Q?580yIPGL6n1dnkNenPssWSJq5NMz+Ihtpw/p35DTW/EDHFNhuDRfUYn9ovXN?=
 =?us-ascii?Q?prVsFGx8oKFKT2e3SvfyGi5tWDE0bA2I0pqw1+TfiK/ryuyVnNpHNdz08C+x?=
 =?us-ascii?Q?AuCW/mnBV52E7BL0/YluANQuHhKm8G754C/O0pkMDFxcsFaHBf2DDbKCU7yp?=
 =?us-ascii?Q?C33LjZagB+K0cEiC3Wjp1aRnLSsEANA5QjN1/fo+cXW0wscno4M671Iu3hy7?=
 =?us-ascii?Q?fzqJrTy6fu5MrY++C8aZQQH6Ej4JB41bzkGK8ubzw7bzVQDvVwytc5hMic9S?=
 =?us-ascii?Q?6l5zt73RC5jG0UNevL1IVizJqQ+3NBkjlhEBcmvk4eauIkeksedqwVQRiD8p?=
 =?us-ascii?Q?DEx0Imej/BJF2ff37E3OfsNMdUxgzaA6RsKyDNKbfXGN49+6CB6x+Lf5opUR?=
 =?us-ascii?Q?jD570r1sS4CtjmIHj4fk5an9iK4fu9+XoJ+uUuDTUgFLF0NFidz5i60ayHju?=
 =?us-ascii?Q?tHmuGjYhhsa0HeV1f/x+jykaJCtQLl7duv2r3GpTJrdqk6jhfARxfnQLXfp1?=
 =?us-ascii?Q?EQnxp2XbIJikZDoGKPbpY/nIAoag6XuHfXFmjJT42ujtu7vrmU/63MHBNk2i?=
 =?us-ascii?Q?E9Cet7kVBava5gPWASbrFJovsaawNnu/WDRIiZbR2pG5sgxIs5pRFPMi20Ps?=
 =?us-ascii?Q?0P8IJwkUvSYaHdgXEWZog8h2Yu84DBiUgfUz81s3cQSKKDjUjWPD1icqjlUz?=
 =?us-ascii?Q?MG5h/AlyIK5wGT8iYZbd9IUBxKHB2LZItK2MNFZ4t3rTBEUgWp0lRF6Yragp?=
 =?us-ascii?Q?oW6Z/TxUrowk/5ozsDoXYyUw6D3HgSgfY4XVE2arPgOK2GW/3KGLMhvkzG7g?=
 =?us-ascii?Q?+PzOzx7Fujn0RDEVzkQHIdCgAg2I3QXoz9gUcmj790HG0VwDUWnOxLoR4wUB?=
 =?us-ascii?Q?3hKit9b+Ptnhz3vTUcQ6pSjJJHlO3YGqBHB2qCWjNDJIVZWiIW1U7fj2WjzA?=
 =?us-ascii?Q?cUrDpJ+4mKdVCZFavBBuIMo8JDIUzqekSYa4jofl0MhD+Zdc28K1W7UxeuUu?=
 =?us-ascii?Q?0+4I2LikZYuF/Y+P7wQrNdO1qatLGCSSY7JncM1eZb52cjLFRhhgqhZE9Ek4?=
 =?us-ascii?Q?sMgl7ypeLApPhT/BkYvmFXDL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc32a15f-1a96-4126-6407-08d9692ffbc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 07:55:05.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tphYf7CAwnYfjrEAPoElYySH+gE3oKH2IXrZs0+VYxPdN7QixqohIZkSD+3ytQB0BiqghLksty5KPrE6lwIWeFwkDNRRD1L8rJWO4cxmOXzQsQoCDI7d40GtiqiS5dsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4276
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your time in providing feedback.=20

Please find my reply in-lined below.

Thanks & Regards,
Kenchappa S. D.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 30, 2021 1:23 AM
> To: Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
> Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; dinguyen@kernel.org;
> Zhou, Furong <furong.zhou@intel.com>; kris.pan@linux.intel.com; Pan, Kris
> <kris.pan@intel.com>; mgross@linux.intel.com; Gross, Mark
> <mark.gross@intel.com>
> Subject: Re: [PATCH V2 3/3] arm64: dts: add initial device tree for Thund=
er Bay
> SoC
>=20
> On Tue, Jul 20, 2021 at 10:52:49AM +0530,
> kenchappa.demakkanavar@intel.com wrote:
> > From: "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
> >
> > Add initial device tree for Intel Movidius SoC code-named Thunder Bay.
> >
> > This initial DT includes nodes for 4 CPU clusters with 4 Cortex-A53
> > cores per cluster, UARTs, GIC, ARM Timer and PSCI.
>=20
> Make sure you run 'make dtbs_check' on these.
Sure. Will post clean patches in next version.

>=20
> There shouldn't be any dtc warnings and or undocumented compatible warnin=
gs
> at a minimum.
Sure. Will post clean patches in next version.

>=20
> > thunderbay-soc.dtsi   - Thunder Bay SoC dtsi file
> > hddl_hybrid_4s.dts    - Thunder Bay full configuration board dts
> > 			with 4 VPU processors
> > hddl_hybrid_2s_02.dts - Thunder Bay prime configuration board dts with
> > 			2 VPU processors (slice 0 and slice 2 enabled)
> > hddl_hybrid_2s_03.dts - Thunder Bay prime configuration board dts with
> > 			2 VPU processors (slice 0 and slice 3 enabled)
> > hddl_hybrid_2s_12.dts - Thunder Bay prime configuration board dts with
> > 			2 VPU processors (slice 1 and slice 2 enabled)
> > hddl_hybrid_2s_13.dts - Thunder Bay prime configuration board dts with
> > 			2 VPU processors (slice 1 and slice 3 enabled)
> >
> > Signed-off-by: Demakkanavar, Kenchappa
> > <kenchappa.demakkanavar@intel.com>
> > ---
> >  MAINTAINERS                                     |   2 +
> >  arch/arm64/boot/dts/intel/Makefile              |   6 +
> >  arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts |  43 +++++
> > arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts |  43 +++++
> > arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts |  43 +++++
> > arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts |  43 +++++
> >  arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts    |  54 ++++++
> >  arch/arm64/boot/dts/intel/thunderbay-soc.dtsi   | 243
> ++++++++++++++++++++++++
> >  8 files changed, 477 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
> >  create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
> >  create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
> >  create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
> >  create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
> >  create mode 100644 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 041f9a0..68317f0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1996,6 +1996,8 @@ ARM/INTEL THUNDERBAY ARCHITECTURE
> >  M:	Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> > +F:	arch/arm64/boot/dts/intel/hddl*
> > +F:	arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
> >
> >  ARM/INTEL XSC3 (MANZANO) ARM CORE
> >  M:	Lennert Buytenhek <kernel@wantstofly.org>
> > diff --git a/arch/arm64/boot/dts/intel/Makefile
> > b/arch/arm64/boot/dts/intel/Makefile
> > index 0b54774..767b74b 100644
> > --- a/arch/arm64/boot/dts/intel/Makefile
> > +++ b/arch/arm64/boot/dts/intel/Makefile
> > @@ -3,3 +3,9 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) +=3D
> socfpga_agilex_socdk.dtb \
> >  				socfpga_agilex_socdk_nand.dtb \
> >  				socfpga_n5x_socdk.dtb
> >  dtb-$(CONFIG_ARCH_KEEMBAY) +=3D keembay-evm.dtb
> > +
> > +dtb-$(CONFIG_ARCH_THUNDERBAY) +=3D hddl_hybrid_4s.dtb \
> > +				 hddl_hybrid_2s_02.dtb \
> > +				 hddl_hybrid_2s_03.dtb \
> > +				 hddl_hybrid_2s_12.dtb \
> > +				 hddl_hybrid_2s_13.dtb
> > diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
> > b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
> > new file mode 100644
> > index 0000000..f907ddd
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Intel Thunder Bay Hybrid HDDL Prime
> > +configuration
> > + * board.
> > + *
> > + * DDR 8GB + 4GB with vpu slice 0 and vpu slice 2  */
> > +
> > +/dts-v1/;
> > +
> > +#include "thunderbay-soc.dtsi"
> > +
> > +/ {
> > +	model =3D "Intel Thunder Bay Hybrid HDDL Prime Board";
> > +	compatible =3D "intel,thunderbay";
> > +
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
>=20
> Why do you have an alias to a disabled node?
Ok. Will remove this.=20

>=20
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@100A000000 {
>=20
> Lowercase hex on unit-addresses.
Ok.

>=20
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x10 0x0A000000 0x2 0x0>;
> > +	};
> > +
> > +	memory@1200000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x12 0x0 0x1 0x0>;
> > +	};
> > +
> > +};
> > diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
> > b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
> > new file mode 100644
> > index 0000000..01a3d4c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Intel Thunder Bay Hybrid HDDL Prime
> > +configuration
> > + * board
> > + *
> > + * DDR 8GB + 4GB with vpu slice 0 and vpu slice 3  */
> > +
> > +/dts-v1/;
> > +
> > +#include "thunderbay-soc.dtsi"
> > +
> > +/ {
> > +	model =3D "Intel Thunder Bay Hybrid HDDL Prime Board";
> > +	compatible =3D "intel,thunderbay";
>=20
> This should have a board specific compatible. Not sure if you need 1 or
> 4 though. If the VPU slice stuff is determined elsewhere then 1 is enough=
.
Since minimum dts will boot for both 4 slice VPU SoC and 2 slice VPU SoC, I=
 will start with single compatible string now.=20
Also minimum dts for 2 VPU slices are same, I will submit common single dts=
 for 2 VPU slice boards in next version.

>=20
> > +
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@100A000000 {
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x10 0x0A000000 0x2 0x0>;
> > +	};
> > +
> > +	memory@1200000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x12 0x0 0x1 0x0>;
> > +	};
> > +
> > +};
> > diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
> > b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
> > new file mode 100644
> > index 0000000..e31db16
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Intel Thunder Bay Hybrid HDDL Prime
> > +configuration
> > + * board
> > + *
> > + * DDR 8GB + 4GB with vpu slice 1 and vpu slice 2  */
> > +
> > +/dts-v1/;
> > +
> > +#include "thunderbay-soc.dtsi"
> > +
> > +/ {
> > +	model =3D "Intel Thunder Bay Hybrid HDDL Prime Board";
> > +	compatible =3D "intel,thunderbay";
> > +
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@100A000000 {
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x10 0x0A000000 0x2 0x0>;
> > +	};
> > +
> > +	memory@1200000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x12 0x0 0x1 0x0>;
> > +	};
> > +
> > +};
> > diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
> > b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
> > new file mode 100644
> > index 0000000..6529664
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Intel Thunder Bay Hybrid HDDL Prime
> > +configuration
> > + * board
> > + *
> > + * DDR 8GB + 4GB with vpu slice 1 and vpu slice 3  */
> > +
> > +/dts-v1/;
> > +
> > +#include "thunderbay-soc.dtsi"
> > +
> > +/ {
> > +	model =3D "Intel Thunder Bay Hybrid HDDL Prime Board";
> > +	compatible =3D "intel,thunderbay";
> > +
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@100A000000 {
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x10 0x0A000000 0x2 0x0>;
> > +	};
> > +
> > +	memory@1200000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x12 0x0 0x1 0x0>;
> > +	};
> > +
> > +};
>=20
> These all look the same, why do we need 4 copies?
Full dts will have VPU slice specific dts nodes. Since minimum dts for 2 VP=
U slices are same, I will submit common single dts for 2 VPU slice boards i=
n next version.

>=20
> > diff --git a/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
> > b/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
> > new file mode 100644
> > index 0000000..561ecea
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Intel Thunder Bay Hybrid HDDL Full
> > +configuration
> > + * board
> > + *
> > + * DDR 8GB + 8GB + 4GB + 4GB with four vpu slices  */
> > +
> > +/dts-v1/;
> > +
> > +#include "thunderbay-soc.dtsi"
> > +
> > +/ {
> > +	model =3D "Intel Thunder Bay Hybrid HDDL Full Board";
> > +	compatible =3D "intel,thunderbay";
> > +
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	memory@100A000000 {
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x10 0x0A000000 0x2 0x0>;
> > +	};
> > +
> > +	memory@1200000000 {
> > +		device_type =3D "memory";
> > +		/* 8GB of DDR memory */
> > +		reg =3D <0x12 0x0 0x2 0x0>;
> > +	};
> > +
> > +	memory@1400000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x14 0x0 0x1 0x0>;
> > +	};
> > +
> > +	memory@1500000000 {
> > +		device_type =3D "memory";
> > +		/* 4GB of DDR memory */
> > +		reg =3D <0x15 0x0 0x1 0x0>;
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
> > b/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
> > new file mode 100644
> > index 0000000..834200d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/intel/thunderbay-soc.dtsi
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2021 Intel Corporation.
> > + *
> > + * Device tree describing Thunder Bay SoC  */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +
> > +	compatible =3D "intel,thunderbay";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +	interrupt-parent =3D <&gic>;
> > +
> > +	cpus {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <0>;
> > +
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu =3D <&CPU0>;
> > +				};
> > +				core1 {
> > +					cpu =3D <&CPU1>;
> > +				};
> > +				core2 {
> > +					cpu =3D <&CPU2>;
> > +				};
> > +				core3 {
> > +					cpu =3D <&CPU3>;
> > +				};
> > +			};
> > +			cluster1 {
> > +				core0 {
> > +					cpu =3D <&CPU4>;
> > +				};
> > +				core1 {
> > +					cpu =3D <&CPU5>;
> > +				};
> > +				core2 {
> > +					cpu =3D <&CPU6>;
> > +				};
> > +				core3 {
> > +					cpu =3D <&CPU7>;
> > +				};
> > +			};
> > +			cluster2 {
> > +				core0 {
> > +					cpu =3D <&CPU8>;
> > +				};
> > +				core1 {
> > +					cpu =3D <&CPU9>;
> > +				};
> > +				core2 {
> > +					cpu =3D <&CPU10>;
> > +				};
> > +				core3 {
> > +					cpu =3D <&CPU11>;
> > +				};
> > +			};
> > +			cluster3 {
> > +				core0 {
> > +					cpu =3D <&CPU12>;
> > +				};
> > +				core1 {
> > +					cpu =3D <&CPU13>;
> > +				};
> > +				core2 {
> > +					cpu =3D <&CPU14>;
> > +				};
> > +				core3 {
> > +					cpu =3D <&CPU15>;
> > +				};
> > +			};
> > +		};
> > +
> > +		CPU0: cpu@0 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x0>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU1: cpu@1 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x1>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU2: cpu@2 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x2>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU3: cpu@3 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x3>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU4: cpu@100 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x100>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU5: cpu@101 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x101>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU6: cpu@102 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x102>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU7: cpu@103 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x103>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU8: cpu@200 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x200>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU9: cpu@201 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x201>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU10: cpu@202 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x202>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU11: cpu@203 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x203>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU12: cpu@300 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x300>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU13: cpu@301 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x301>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU14: cpu@302 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x302>;
> > +			enable-method =3D "psci";
> > +		};
> > +
> > +		CPU15: cpu@303 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0 0x303>;
> > +			enable-method =3D "psci";
> > +		};
> > +	};
> > +
> > +	psci {
> > +		compatible =3D "arm,psci-0.2";
>=20
> PSCI 1.0 has been out for 6 years...
I will update this after verifying our ATF supported PSCI version
=20
>=20
> > +		method =3D "smc";
> > +	};
> > +
> > +	gic: interrupt-controller@88400000 {
> > +		compatible =3D "arm,gic-v3";
> > +		interrupt-controller;
> > +		#interrupt-cells =3D <3>;
> > +		reg =3D <0x0 0x88400000 0x0 0x200000>,	/* GICD */
> > +		      <0x0 0x88600000 0x0 0x200000>;	/* GICR */
> > +		/* VGIC maintenance interrupt */
> > +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		/* Secure, non-secure, virtual, and hypervisor */
> > +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	soc {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +		dma-ranges;
> > +
> > +		uart0: serial@80460000 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x0 0x80460000 0x0 0x100>;
> > +			interrupts =3D <GIC_SPI 725 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-frequency =3D <50000000>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +		};
> > +
> > +		uart1: serial@80470000 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x0 0x80470000 0x0 0x100>;
> > +			interrupts =3D <GIC_SPI 724 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-frequency =3D <50000000>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			status =3D "disabled";
> > +		};
> > +	};
> > +};
> > --
> > 2.7.4
> >
> >
