Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F243EDDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhHPTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:23:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:56740 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhHPTX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:23:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="196189652"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="196189652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 12:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="423665096"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2021 12:23:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 16 Aug 2021 12:23:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 12:23:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 12:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3+qTkI27FE8Bx0lzVc8AIevdJSymwoarn5i+cEejz5VuJGbpAbjMErVtT7kF5Y+TSAYo/ds8OdvlolxjdRYdCDom9VKIRFlgfV/N1KWj3WXeiDvZCR6ct4JFJzaJTDFRFsanVNxL42l0kQvMgqCO123acPYK9Is3H8euS30EwjgJ6JEIItsqhWkyLri80Y0+fecYet1eUTS0qZ4VJCXRtX78Eq6B8pFrG1/ibyCCaZHzPRByCLS2p29eB37EgLd4T+ybT3Vi0zBsZfLjLfs2F+8FY5CSLM8UbfsRKUUkcU1bfKSOboGZAWh/QvwZ0z01hPi8lstZYup4LhiO9WymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8yjoWsMbePFHhZsd+WzZyw9rsh69dzOUthrXJggdIY=;
 b=gOAuuyQ+1ahPbx1r6V7+NHKpAWRU8f02eC55KbWUFUnVPPJqWSHyC1s6J2oI0V2BLifW2HQnq2lgn0Q+YrayRlaWAKUaMMHyId10WjZmlJUfGMuuyN3ROik5c5+lVsnKg2JT87X7iAaq/Fa6Jfti8XXa1y3zbfnyhDg5B6Ua66oYzG0W5r5MQ0BBZk215eJ+XgKu2GqCi8TnH3tpHUx0TOwXt8eeyCzI87CgNn2b0cv9IZ/6kElQzFCDbUIKQqEB3UJtpPer45dY0wHv9AxKOxryVoZ1feJdpql9zge52fJZ2g9NcFLjMbZeDz7W8r1/admMb6TXHg0bRvr2Ed5ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8yjoWsMbePFHhZsd+WzZyw9rsh69dzOUthrXJggdIY=;
 b=IQj6xGzcGRSQFnR+GGMz8yUMHTriSQkTKI/9QHKexTdIz5ERNmXcF+CiJifBIsMAGFz9rmmrpkYf3Zu81BvRoKLIics34jjLM7bjXBZijuH5ximF9BkrVj4iuLipQw5Whn3CGHrtKeQSmtjYBW7BVvvEVnI0ZTe0l2fjzThRtgo=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 19:23:21 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96%8]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 19:23:21 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "De Marchi, Lucas" <lucas.demarchi@intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Subject: RE: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Topic: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Index: AQHXenI9Mxf5qZez+Uqb+eZuFtjmaKt2lesAgAAcTfA=
Date:   Mon, 16 Aug 2021 19:23:21 +0000
Message-ID: <MW3PR11MB45230D40F51FAB5C5A4E0FCBF2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1626459866.git.gayatri.kammela@intel.com>
 <b2cb6b10b75445acceab3030c3a9aa585e7c7b65.1626459866.git.gayatri.kammela@intel.com>
 <20210816173738.oxndqtq6uaql7sz7@ldmartin-desk2>
In-Reply-To: <20210816173738.oxndqtq6uaql7sz7@ldmartin-desk2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa5cc58-3f86-46a6-192c-08d960eb4f3b
x-ms-traffictypediagnostic: CO1PR11MB5185:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5185E4157BB97B0F27E15319F2FD9@CO1PR11MB5185.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9b3O2OnnN8AthbknGheBA4V2yGzLy20PYfM2Lt327DYqN5cQ2avuvXlP2fhHcGqK+NkAIASxTzaJxJ+7kVIZolgFunokqbC0CZ579l6+nft+k5Nzj0XyMW1Gr4UfGTsuzrQJcjF6LbqSzfu9fSZwLdet+iVnLTAeaiPe4M/F7UNBXGh1a5E9DkzORrt6gaplVagGXTUqEzdfX+f4f6uRcjRg0HIrxc1eg4FY42vRsCvdjxdzyLL7v9lD6hmD0bHgnqGSxmZSd+weRRTGdyRr14gPzIrGeWxfFIMb2FrfUYYQztqk90yymdJu7SPPL82XTNM9j0DAGJaZFRVhv6pDa/kx/3J1ZbKYuaKtDi8kqnxIDBfWXrg/OZ6X3Uggn2GvOjUo6pB+qoswDhbHFEkJx1dwe1DqenxwEvJQwEApEfA6vCTDmn40++ljaUKN2HU6KxRnKEPr8SvfOspWoTkEbyPShXuDfRjuzUuLZT3tbqSwU4vJP8+oE9pOJuZyRlPtfzgCE29qIv61dVUX3wUe/hSygcg1djhInxVaZUJyxtkL+rGW3J9+HADCVQ7u2SOkIv1QBj+HLZGcR26VzQb7Lc+pnZC4Gy1yuTu7nF73F3G9umXUi3y8VgqoY+cxIKTz5SRk1xm90Lnnde7Jz34715kRT8t9hG09ZGVUp7qg5swRYXBE1ZQAdXOWzFVDQk9PUPa6NP6KQHsyGs6YUiiqzCL3ccZ6Hc3UpULbZZTKvRlg6Zuno1U2dBGmey56Y+hvr+JzkDDiWgbtYuyVKj+YbnnhOfHykNsD0Htpxzx2ug8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(71200400001)(7696005)(55016002)(122000001)(83380400001)(6636002)(38100700002)(8936002)(478600001)(4326008)(9686003)(66946007)(66446008)(26005)(2906002)(53546011)(5660300002)(52536014)(33656002)(966005)(6862004)(6506007)(38070700005)(8676002)(7416002)(54906003)(186003)(66556008)(316002)(76116006)(66476007)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?++GoxoKTMmdgIn/GO2Qe9Z98KD9yirK24xWt7iMWiV6VNQ0s7yrTAaSWzgFp?=
 =?us-ascii?Q?jHICQ84OpbUgUQgsnSlqhLi5hVeqK06e+oQf2T0hgPlHOVd3TfW0QdyZpi2J?=
 =?us-ascii?Q?eV73XkZRZA6Mt40hjzXaBRuyf9I4BWex+ydvjIO+vCq0+fHeoSg3IwRc+a5f?=
 =?us-ascii?Q?o4gMqaJxzLhwvWl14VaLxfFfUOBklOd6LMwes3MmQww0rCnInrJ+Gf2FxKBE?=
 =?us-ascii?Q?sTrOXo5L669THS+Mg2dsxHkAnOBFXvaKPOjf8i8p/O8JOl/hgbo30T7hf+u3?=
 =?us-ascii?Q?J1UWTgmSgNKH6LbQ3GlXdL7OEE+I+8wwDxUXsQn+gRDEu/8dEBvl7/0gAUar?=
 =?us-ascii?Q?GkuKbVaLi0SKsCBfHpBeh05RdfMDCcMGapC0prgCHJu7/IoGTTIGp0hqy0ww?=
 =?us-ascii?Q?2v7suNf46LWgB1PKkCxOFYZ9nPnkBO7dkbhKpEatTVVjT0uyomtO3Ne/s25z?=
 =?us-ascii?Q?9k/nHDOI1ifiUII46ZFXGdTBkxnzlfMgc6LdBqdZsBRmlztNo/cUgrIuv1Qc?=
 =?us-ascii?Q?woDN3/f5PPbNhfSmDQFdUp4bOK0Ub3LltXBP1Cc888CZdy253pkH2PQ8OMgA?=
 =?us-ascii?Q?K9oCVofqTbglbjYEQpR4/A49aW/a81TJtpQGlFNGyCm+5kLYkTbjkLqpKEux?=
 =?us-ascii?Q?iZ8VgvkHao6zhEIAG0JAcsBfQS+ogymI+5jFS75fuVZPv7PxBzPgoeJyu2Lv?=
 =?us-ascii?Q?BzThakt3kcSD6VWHPAemkagBI0S9be675WDlYL+l3TpQZMvK2vAhFjD9yr4d?=
 =?us-ascii?Q?Kqh8IvlkBbaXJEuPtLbr5iRLp02crWx/8sbQNAmX/BISGrw2t+kLY02lYfOk?=
 =?us-ascii?Q?F8EVkxbHNixgWqSLecbPzm6HuYPQ8Xh393BwngZS7I/pIiD4BJfCCZijyfjR?=
 =?us-ascii?Q?QeyanB103fupWW5hJCrLuEgkEmr/JJ3tmzxvqjYotEzzAhlB4bzbq2F27nc2?=
 =?us-ascii?Q?dcsWAk4clCL+lNrNKD3nMm1jAkJBizC6hGKnMetnqvpgHR27WeoI8c2ppZ16?=
 =?us-ascii?Q?8VtWi5mNNXApH4t9tM24hlnBTZ+fR3TiWYSUAksPLDAuC8C+Ax/Jkxgdc9WQ?=
 =?us-ascii?Q?SgyD8MjmQbDraXV37M1iT5O2rbuEfxRxGrarglyTT5aVeRUn61PiPwaRlGuJ?=
 =?us-ascii?Q?UcEFfUsaxpKts6SwsQf/qLtyG7pgnLy9UNmsXHbozXL96hlQlbGQOazSQh23?=
 =?us-ascii?Q?lk8epb1wjxCpzMcbWq6490Fh6F8m5dVKD5IVD8nka8dh9i2j4Ed5crWHEYEQ?=
 =?us-ascii?Q?rH2JOaBI6qN4j8Ea1tdiKNTjg71S8NMe6f9oi8aNF8TlmuNQ66Q/KTVNt0dc?=
 =?us-ascii?Q?baI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa5cc58-3f86-46a6-192c-08d960eb4f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 19:23:21.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4mXo2kXN784RtnzqIFk+8yRH4nObFZm09+Kr9z+z2G0SRUvyDgJkNGdPfobne1sKNW6bvfjuThN1AbVjzbnbSaNPxTzL7utlsbidErxybo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: De Marchi, Lucas <lucas.demarchi@intel.com>
> Sent: Monday, August 16, 2021 10:38 AM
> To: Kammela, Gayatri <gayatri.kammela@intel.com>
> Cc: platform-driver-x86@vger.kernel.org; mgross@linux.intel.com;
> hdegoede@redhat.com; irenic.rajneesh@gmail.com;
> andriy.shevchenko@linux.intel.com; vicamo.yang@canonical.com;
> Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; Box, David E
> <david.e.box@intel.com>; linux-kernel@vger.kernel.org; Mashiah, Tamar
> <tamar.mashiah@intel.com>; gregkh@linuxfoundation.org;
> rajatja@google.com; Shyam-sundar.S-k@amd.com;
> Alexander.Deucher@amd.com; mlimonci@amd.com; Andy Shevchenko
> <andy.shevchenko@gmail.com>
> Subject: Re: [PATCH v5 1/5] platform/x86/intel: intel_pmc_core: Move
> intel_pmc_core* files to pmc subfolder
>=20
> On Fri, Jul 16, 2021 at 11:38:33AM -0700, Gayatri Kammela wrote:
> >As part of collecting Intel x86 specific drivers in their own folder,
> >move intel_pmc_core* files to its own subfolder there.
> >
> >Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> >Cc: David Box <david.e.box@intel.com>
> >Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> >Cc: Hans de Goede <hdegoede@redhat.com>
> >Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> >Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> >---
> > MAINTAINERS                                   |  2 +-
> > drivers/platform/x86/Kconfig                  | 21 ------------------
> > drivers/platform/x86/Makefile                 |  1 -
> > drivers/platform/x86/intel/Kconfig            |  1 +
> > drivers/platform/x86/intel/Makefile           |  1 +
> > drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
> > drivers/platform/x86/intel/pmc/Makefile       |  5 +++++
> > .../{intel_pmc_core.c =3D> intel/pmc/core.c}    |  2 +-
> > .../{intel_pmc_core.h =3D> intel/pmc/core.h}    |  0
> > .../pmc/pltdrv.c}                             |  0
> > 10 files changed, 31 insertions(+), 24 deletions(-)  create mode
> >100644 drivers/platform/x86/intel/pmc/Kconfig
> > create mode 100644 drivers/platform/x86/intel/pmc/Makefile
> > rename drivers/platform/x86/{intel_pmc_core.c =3D> intel/pmc/core.c}
> >(99%)  rename drivers/platform/x86/{intel_pmc_core.h =3D>
> >intel/pmc/core.h} (100%)  rename
> >drivers/platform/x86/{intel_pmc_core_pltdrv.c =3D> intel/pmc/pltdrv.c}
> >(100%)
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 6c8be735cc91..c5d610885bf2 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -9477,7 +9477,7 @@ M:	David E Box <david.e.box@intel.com>
> > L:	platform-driver-x86@vger.kernel.org
> > S:	Maintained
> > F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
> >-F:	drivers/platform/x86/intel_pmc_core*
> >+F:	drivers/platform/x86/intel/pmc/core*
> >
> > INTEL PMIC GPIO DRIVERS
> > M:	Andy Shevchenko <andy@kernel.org>
> >diff --git a/drivers/platform/x86/Kconfig
> >b/drivers/platform/x86/Kconfig index 7d385c3b2239..cae72922f448 100644
> >--- a/drivers/platform/x86/Kconfig
> >+++ b/drivers/platform/x86/Kconfig
> >@@ -1184,27 +1184,6 @@ config INTEL_MRFLD_PWRBTN
> > 	  To compile this driver as a module, choose M here: the module
> > 	  will be called intel_mrfld_pwrbtn.
> >
> >-config INTEL_PMC_CORE
> >-	tristate "Intel PMC Core driver"
> >-	depends on PCI
> >-	depends on ACPI
> >-	help
> >-	  The Intel Platform Controller Hub for Intel Core SoCs provides
> access
> >-	  to Power Management Controller registers via various interfaces.
> This
> >-	  driver can utilize debugging capabilities and supported features as
> >-	  exposed by the Power Management Controller. It also may perform
> some
> >-	  tasks in the PMC in order to enable transition into the SLPS0 state.
> >-	  It should be selected on all Intel platforms supported by the driver=
.
> >-
> >-	  Supported features:
> >-		- SLP_S0_RESIDENCY counter
> >-		- PCH IP Power Gating status
> >-		- LTR Ignore / LTR Show
> >-		- MPHY/PLL gating status (Sunrisepoint PCH only)
> >-		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
> >-		- Low Power Mode registers (Tigerlake and beyond)
> >-		- PMC quirks as needed to enable SLPS0/S0ix
> >-
> > config INTEL_PMT_CLASS
> > 	tristate
> > 	help
> >diff --git a/drivers/platform/x86/Makefile
> >b/drivers/platform/x86/Makefile index 7ee369aab10d..43d36f8c36f1
> 100644
> >--- a/drivers/platform/x86/Makefile
> >+++ b/drivers/platform/x86/Makefile
> >@@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)
> 		+=3D intel-uncore-frequency.o
> > obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+=3D intel_bxtwc_tmu.o
> > obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+=3D intel_chtdc_ti_pwrbtn.o
> > obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+=3D intel_mrfld_pwrbtn.o
> >-obj-$(CONFIG_INTEL_PMC_CORE)		+=3D intel_pmc_core.o
> intel_pmc_core_pltdrv.o
> > obj-$(CONFIG_INTEL_PMT_CLASS)		+=3D intel_pmt_class.o
> > obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+=3D intel_pmt_telemetry.o
> > obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+=3D intel_pmt_crashlog.o
> >diff --git a/drivers/platform/x86/intel/Kconfig
> >b/drivers/platform/x86/intel/Kconfig
> >index f2eef337eb98..8ca021785f67 100644
> >--- a/drivers/platform/x86/intel/Kconfig
> >+++ b/drivers/platform/x86/intel/Kconfig
> >@@ -18,5 +18,6 @@ if X86_PLATFORM_DRIVERS_INTEL
> >
> > source "drivers/platform/x86/intel/int33fe/Kconfig"
> > source "drivers/platform/x86/intel/int3472/Kconfig"
> >+source "drivers/platform/x86/intel/pmc/Kconfig"
> >
> > endif # X86_PLATFORM_DRIVERS_INTEL
> >diff --git a/drivers/platform/x86/intel/Makefile
> >b/drivers/platform/x86/intel/Makefile
> >index 0653055942d5..49962f4dfdec 100644
> >--- a/drivers/platform/x86/intel/Makefile
> >+++ b/drivers/platform/x86/intel/Makefile
> >@@ -6,3 +6,4 @@
> >
> > obj-$(CONFIG_INTEL_CHT_INT33FE)		+=3D int33fe/
> > obj-$(CONFIG_INTEL_SKL_INT3472)		+=3D int3472/
> >+obj-$(CONFIG_INTEL_PMC_CORE)		+=3D pmc/
> >diff --git a/drivers/platform/x86/intel/pmc/Kconfig
> >b/drivers/platform/x86/intel/pmc/Kconfig
> >new file mode 100644
> >index 000000000000..b4c955a35674
> >--- /dev/null
> >+++ b/drivers/platform/x86/intel/pmc/Kconfig
> >@@ -0,0 +1,22 @@
> >+# SPDX-License-Identifier: GPL-2.0-only
> >+
> >+config INTEL_PMC_CORE
> >+	tristate "Intel PMC Core driver"
> >+	depends on PCI
> >+	depends on ACPI
> >+	help
> >+	  The Intel Platform Controller Hub for Intel Core SoCs provides
> access
> >+	  to Power Management Controller registers via various interfaces.
> This
> >+	  driver can utilize debugging capabilities and supported features as
> >+	  exposed by the Power Management Controller. It also may perform
> some
> >+	  tasks in the PMC in order to enable transition into the SLPS0 state.
> >+	  It should be selected on all Intel platforms supported by the driver=
.
> >+
> >+	  Supported features:
> >+		- SLP_S0_RESIDENCY counter
> >+		- PCH IP Power Gating status
> >+		- LTR Ignore / LTR Show
> >+		- MPHY/PLL gating status (Sunrisepoint PCH only)
> >+		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
> >+		- Low Power Mode registers (Tigerlake and beyond)
> >+		- PMC quirks as needed to enable SLPS0/S0ix
> >diff --git a/drivers/platform/x86/intel/pmc/Makefile
> >b/drivers/platform/x86/intel/pmc/Makefile
> >new file mode 100644
> >index 000000000000..e0182e10a035
> >--- /dev/null
> >+++ b/drivers/platform/x86/intel/pmc/Makefile
> >@@ -0,0 +1,5 @@
> >+# SPDX-License-Identifier: GPL-2.0
> >+#
> >+
> >+obj-$(CONFIG_INTEL_PMC_CORE)	+=3D core.o
> >+obj-$(CONFIG_INTEL_PMC_CORE)	+=3D pltdrv.o
>=20
> is the module rename really intentional? If so, it needs to be renamed to
> something else as just calling it core may conflict with other equally ba=
dly
> named modules.
Hi Lucas! Yes, the module rename is intentional. Thanks for reporting the i=
ssue. This issue has been addressed in V6. I have just sent the V7 https://=
patchwork.kernel.org/project/platform-driver-x86/list/
>=20
> 	error: the following would cause module name conflict:
> 	  GEN     .version
> 	  drivers/misc/c2port/core.ko
> 	  drivers/platform/x86/intel/pmc/core.ko
> 	make[2]: *** [Makefile:1417: modules_check] Error 1
> 	make[2]: *** Waiting for unfinished jobs....
>=20
> This builds for me by restoring the previous module names
>=20
> -----8<------
> diff --git a/drivers/platform/x86/intel/pmc/Makefile
> b/drivers/platform/x86/intel/pmc/Makefile
> index e0182e10a035..9bfe8ab8fd64 100644
> --- a/drivers/platform/x86/intel/pmc/Makefile
> +++ b/drivers/platform/x86/intel/pmc/Makefile
> @@ -1,5 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
>=20
> -obj-$(CONFIG_INTEL_PMC_CORE)	+=3D core.o
> -obj-$(CONFIG_INTEL_PMC_CORE)	+=3D pltdrv.o
> +obj-$(CONFIG_INTEL_PMC_CORE)	+=3D intel_pmc_core.o
> +obj-$(CONFIG_INTEL_PMC_CORE)	+=3D intel_pmc_core_pltdrv.o
> +
> +intel_pmc_core-y		+=3D core.o
> +intel_pmc_core_pltdrv-y		+=3D pltdrv.o
> -----8<------
>=20
>=20
> Lucas De Marchi
>=20
> >diff --git a/drivers/platform/x86/intel_pmc_core.c
> >b/drivers/platform/x86/intel/pmc/core.c
> >similarity index 99%
> >rename from drivers/platform/x86/intel_pmc_core.c
> >rename to drivers/platform/x86/intel/pmc/core.c
> >index b0e486a6bdfb..f9de78b08e5d 100644
> >--- a/drivers/platform/x86/intel_pmc_core.c
> >+++ b/drivers/platform/x86/intel/pmc/core.c
> >@@ -31,7 +31,7 @@
> > #include <asm/msr.h>
> > #include <asm/tsc.h>
> >
> >-#include "intel_pmc_core.h"
> >+#include "core.h"
> >
> > #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-
> ff13b2508972"
> > #define ACPI_GET_LOW_MODE_REGISTERS	1
> >diff --git a/drivers/platform/x86/intel_pmc_core.h
> >b/drivers/platform/x86/intel/pmc/core.h
> >similarity index 100%
> >rename from drivers/platform/x86/intel_pmc_core.h
> >rename to drivers/platform/x86/intel/pmc/core.h
> >diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c
> >b/drivers/platform/x86/intel/pmc/pltdrv.c
> >similarity index 100%
> >rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
> >rename to drivers/platform/x86/intel/pmc/pltdrv.c
> >--
> >2.25.1
> >
