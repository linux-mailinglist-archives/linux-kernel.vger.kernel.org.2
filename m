Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF783559DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbhDFRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:00:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:51337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244335AbhDFRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:00:26 -0400
IronPort-SDR: G6wfDRzCp3YQhPghdUJ5jSX5OhzTiLd4XrTvv7skceQOWoX2GK4mLETcA9yBHAlZ+oyrI1tQeh
 7ITjU+CfRr4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180244174"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180244174"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 10:00:18 -0700
IronPort-SDR: Bi4XXDjYUHkQcLs60b4dkVume3SIafGVc/aGNsWyBvPdshVaM0KfkOV4EM/x77F51gaCRhtAik
 4uu8uQ2Dhf7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="447913574"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2021 10:00:17 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:00:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 6 Apr 2021 10:00:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 6 Apr 2021 10:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URkREPaQwq1ayqiULjWGfkDgTFAePNVMf5FBxBcJHotPYaAo+vYmtzY3niAUwOO/NL9xeGVzULjgS64KU2CAMqbSlr0DCoQG6YH9ZqH/nUAdmowUTul539D4hmKCzssdu1YgUmGOJAnPDmCN/P+KETGrH2Pn7LAIBRCFdVqKd5vvb+LWL+hF7o3mBr9ynyux8Pi5FnBO2U7660x/grGFNW/oKbYPn6xepNRdgT7peOzL/zQjJW4+Cu8omhmrXOUJ0w+U+ciNm7Bw8wK/L2PBy3aIYSvT9w5x7EnwWjMKTFGS5XvZIzFF+etBurOAFWCBcANShCCMPQbcccm5vBt0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRyNxrGYgx5hdvoO7WcMFsDW+HM1Yv12Fvyilru3BL4=;
 b=WyFtE3qdBz8BEelFeBlZ7YMuaDYYi2FkRvSRQXGkRXUGapJCcq/fqb+kY8J9ZPg+lIP8LPBPiwYjZfbFKqUoaf+Ug5SpUkkOSU4/YNltv5WX0rVlTkPjOMXWlFayzyzOPVeRoF8WsuPZOa91t4ZSjkveCUNA2hZkoWaZAzgJIEnd949B3vYjDKKNCFOdRcuh7F7JfoN07jUKfy2fZqD6RhazxcJQuZGrlZG1BKTSOVhSFHy9F1cKlJ/QsfM3u4ZjtKbg8eTUxvn3NbLevNN+KqNRhfyRK288cvG43j85uP9ky34fPjk1DSzUt3cDM6z7cGInCwMTdbDLO8P9Pa38vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRyNxrGYgx5hdvoO7WcMFsDW+HM1Yv12Fvyilru3BL4=;
 b=XtGd6qKF3XzH+l0205gOpcnQbldhPlB7Hld781fuUF7iGYv3jNSKnWWLfEU3uhfJZNJGWTv0qFhvQL4JpqL6lariN8SWmyZXATu0x+tXvIhN+Il5/KN/0UCiwaLU8Y+Q29AoHRiCdxE5ITntj7S15eLrnHH1HX8f7HrqnMwElfM=
Received: from DM6PR11MB3993.namprd11.prod.outlook.com (2603:10b6:5:19c::10)
 by DM5PR1101MB2268.namprd11.prod.outlook.com (2603:10b6:4:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 17:00:08 +0000
Received: from DM6PR11MB3993.namprd11.prod.outlook.com
 ([fe80::460:f79e:577:f515]) by DM6PR11MB3993.namprd11.prod.outlook.com
 ([fe80::460:f79e:577:f515%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 17:00:08 +0000
From:   "Corona, Ernesto" <ernesto.corona@intel.com>
To:     Paul Fertser <fercerpav@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v29 0/6] JTAG driver introduction
Thread-Topic: [PATCH v29 0/6] JTAG driver introduction
Thread-Index: AQHXKufVV6kHcwtW80SH2VUQMGUC1qqnfUgAgAA5GZA=
Date:   Tue, 6 Apr 2021 17:00:08 +0000
Message-ID: <DM6PR11MB399360880403A83FFECD597D8B769@DM6PR11MB3993.namprd11.prod.outlook.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20210115104635.GA2971@home.paul.comp> <YGxgfFBUr6eHJ1Qi@smile.fi.intel.com>
 <20210406133420.GY10267@home.paul.comp>
In-Reply-To: <20210406133420.GY10267@home.paul.comp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [187.189.154.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60ba6048-1d0f-4415-ecbb-08d8f91d6f47
x-ms-traffictypediagnostic: DM5PR1101MB2268:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB22684CB5578955EFC21667FD8B769@DM5PR1101MB2268.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5meAibbpnMvin3KtzD96C6dNKMi1AEeAA7Df3lTztvONMIOjJ7KjuJYNmVzRnj5m2nlb5R2D3GT9NtRNBOm63QESJEnXzIIbKN0IYbxy0Tj5qatV7Ajm7CA80Oa+jePDDim5KYFQPlMQ1CLRuuYPt1sj7cfKyj4VcllQdY3DnK2seu2zIM0qJHToO6XHQBqN52EvXJMOuLbpGs+bgUO9u7G2SLZgu9t5AVrWr9S0aQrsWouZFAo0nHLuG1b8i3LVJOXTj4V9NySxrHcsVdkouwg57IwUzaL4OZH6lGnueEWEZNBzhI2wVRQDPRsEwPNdO9n1SZbS0mHG3Xjzkn69ddqJdUX10aGdq3TsURjzzQJZaLxsEQgDth//GWe3zzbCH/M9EkGWx0UyHzzBO+i2aHdw9Bc7iyPKp+LBV2PdobYd25N9mJu8u4nU9wucFOIIjrCFYDQk/e+aE0HSFSKcmWzkKfiEz18GlcypGYjeXJMlTFge1z6Q/d8ufn8/BEIrEfV9A3Pv+eBS/Nm7tMHwDtwZv8Hjg30GqmbxSuUafT0FSher/Crh6ppq2UIo7VD+9zPjCwWG/z2xeVTR6kJJZi41PmconMZI/8Gq+JDPMlSSJMB40hKyyJSTV2OcVHE4lEI0KVj946ccDbk3xy+JsdLOxcpKdsoxSX/rXq2ep83+YHZjOvEXwOJgN4nqqK/zD5jbprmlAao6iyVJYZsBXzZ9dgKkVGYMYIbIXrofmjl9+UazR8cPBNZmst2ADXM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(478600001)(5660300002)(53546011)(7696005)(64756008)(316002)(2906002)(6506007)(66556008)(52536014)(4326008)(83380400001)(66946007)(4744005)(26005)(66476007)(8676002)(33656002)(38100700001)(186003)(71200400001)(66446008)(8936002)(9686003)(76116006)(6636002)(86362001)(55016002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NtxBXXVobjQOBNkkN8pIetZfHxpX/XO95YdKq00SZbZdj+y+GzGNhrMg8NPI?=
 =?us-ascii?Q?cJ97vtGKnmP/5LyJsCBsXVnqVIS2qLxtnBXJmP/cpNDQCG1zdz9SWcxNofnr?=
 =?us-ascii?Q?LkGYnU0zsKCAdJt+jb+xPSTCwAjgWgotZb4CsZ2OccCZeWidhnqB/RF68juM?=
 =?us-ascii?Q?B128v4rLmRAt1w+pMn144pzgoHYic5urr1D+cvcY48c/4Wy78B0MiBoA9/5S?=
 =?us-ascii?Q?3xLYBrDgKtGU4/tb5LwM9oavMv8AigS+8T+eWfZFpqHQsq5I66QeVkSpsAwH?=
 =?us-ascii?Q?zHsgw1wDab/MAG8zbsN1K3IN+Ni6bQlsZUrk3P2JVkEhifhEvVb7VgEEATq2?=
 =?us-ascii?Q?vkm4R3ZxILGi5EM8O8Q6vQSOYAdJdKCrf9a+gSudunB9H6yXz1zF+Rk20lwP?=
 =?us-ascii?Q?H0cyPvvef15TSKPN2NFxAthgPAape7XCpx3FGTkZ2K0yS4fhlQFX60WneL1s?=
 =?us-ascii?Q?0usRpRqlrVe43HgV2PMEGMFH2jUcsPEKEhSRKE44sAjBwJasU0wEDOka8Syq?=
 =?us-ascii?Q?+F12rNs9rjSJuRHCLgsVacDspGWvFVeEgIfyD4gBXZhIqC/Ix4fIn6xa2Smt?=
 =?us-ascii?Q?Uj+H7sTQYzn4GaDxazq2k6jqHZH0zkVwO1Gsmlh3bJuwoYiigYRdqIur7MkV?=
 =?us-ascii?Q?XCQgsmq3WRwyvMtZtGNwtCjoy2gvP15Mke8j+nEo4MCtLpP4mfzKrwdy9JGn?=
 =?us-ascii?Q?X1gILPYeuzZT7Zg1A3tq7YAg2ALcKNH/fqUK8WtE1Yhcmjx0fFUhzCIahGtD?=
 =?us-ascii?Q?HgYbg6a1E3ZE+y6aLMHnCpAc9tWURBvp4tokVirkhsu+VZpiTu/qbFSVMEaD?=
 =?us-ascii?Q?Kx31lFr6Xidc5ISiWZg7x3etOf21ZFpnWGWzefHB6c5EpcCtP1S5KHAxOAja?=
 =?us-ascii?Q?AmZQOrCrL+YNDxP8nVFg76rz4rmkjo0blcQvKhXd9CQPf8uomTXPGU503n7s?=
 =?us-ascii?Q?qSYXfwINnxdgnLcG2vkkmj96lu7R/GLVw1cGCgGfDDHi5vdBuZ1+E/FNnijI?=
 =?us-ascii?Q?gewNqiNrGN+q7Az783ZefFrzNTuBeRHWt+IYPyR8a1KaGu0ZsH748jcpRVy9?=
 =?us-ascii?Q?gdVoFYso+iZoptTvj3cKCwqjXJbnQrCoG/LeeAmUPzB7IYf/xVMazjQGLXXL?=
 =?us-ascii?Q?lZBSo/pWcFuXnF1f7MwQVAGY0tEuMVyCR48RuGVy7oaJ3Vu/dN/q8HVkHOAB?=
 =?us-ascii?Q?TB73dqGDAcKjUV6KE15ABmg7R7rGmAZajdrbDyqZwMzpWrMplnSAe/ZIzzGv?=
 =?us-ascii?Q?fpugcE8DhcoJV9OlHzNZVSB/vAP81KO2Oxh+h38yjeIVflqHgFju/Qze47UB?=
 =?us-ascii?Q?P4NQVW6y8mFsaE2Lus3+2Rx7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ba6048-1d0f-4415-ecbb-08d8f91d6f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 17:00:08.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEfnPVFy8tJkzidcl42U0ffLvQZ9PXiX1Im9XicazRRGU+Ogd4xpNiKVFypvd6W01JuyCGj7OKUZouWmgJkZ295VwfUPzS4061IIn1SvSWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2268
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Paul is right. We already have a v30 and now after Paul's feedback we are d=
oing some changes in preparation for v31.

Regards,

Ernesto

-----Original Message-----
From: Paul Fertser <fercerpav@gmail.com>=20
Sent: Tuesday, April 6, 2021 8:34 AM
To: Shevchenko, Andriy <andriy.shevchenko@intel.com>
Cc: Corona, Ernesto <ernesto.corona@intel.com>; linux-aspeed@lists.ozlabs.o=
rg; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; lin=
ux-doc@vger.kernel.org
Subject: Re: [PATCH v29 0/6] JTAG driver introduction

Hi Andy,=20

On Tue, Apr 06, 2021 at 04:22:04PM +0300, Andy Shevchenko wrote:
> On Fri, Jan 15, 2021 at 01:46:35PM +0300, Paul Fertser wrote:
> > I have to note that the current v29 version of the series is broken=20
> > in several aspects:
>=20
> Is it correct that this series is actually abandoned so far?

I have an e-mail from Ernesto sent on 10 Feb 2021 stating they're going to =
continue the work.

--
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
