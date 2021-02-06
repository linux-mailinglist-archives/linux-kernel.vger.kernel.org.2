Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF73118DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBFCsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:48:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:63336 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhBFCgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:36:07 -0500
IronPort-SDR: y0Ht0xo+cqeL8TsysnVq3ZRNYx3GrnT4RscjUuQJPXfqai3wQgsAAy4L8c+sqztmXLsjVrhOJP
 tonK4nOfoAJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="161264630"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="161264630"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 17:26:13 -0800
IronPort-SDR: ZPttS5XTYaqOCRp7nDgUtyb7IYDuqdwSCq9XavjvJ4FTMvA0MvUZjCsPY8Nwudu9FE+0PPRuVL
 F2pnez3YiUVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="576894219"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2021 17:26:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 17:26:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 17:26:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 5 Feb 2021 17:26:12 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 5 Feb 2021 17:26:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRhmv5x4ozDg4fp25AglM53AlrU6Q79pePGsCrL+BzQE9ZgskX1WfqUHilwZtQq5tD3UdIS+W6DSkLfMzPSM8qhYyNoxZgI6fIDxboV3GvEpKLAkQhK1YLKnkR1CFakbYLUgXiGA+Almw2v7xi+n3HDBr8ZzCJm1GNzWtvzB39GkhhfVf+TUnjJON+HOvtBSzayMX/UVQF+yB+39jF/1L2m2oNuP25mnY3bCCYDOm6qZZL3jdw7KwWvhI6WvHnY7uQq/0QumuISetMmxtiauuMGH3U6FzwMSasiTSsCEGM2HbMjsGgava/ZytxsGCjY+fIge9OOPiZxuv6EPrkCjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az4/RchV44mFmaG2MDJS+Ui4UgRlfUmpLZvGGI/FowM=;
 b=E70VfvC2gUwrYGUzyVvWQsCDOAsnXo71gJnEeVGIN4nBRLdJATNIwuBatLONHboIDG9GB8tE6xX7YdFSOcFSCOZzTpL42dREQ4OxdF6rIq/k+NIJz00hTcs9+IZ1hExP8hugQbQabAols+z2Or7kPMpQ9zND7WytyvcKfmIq830dhbusY+n0I+FPGjEPIk+zdZUT+wmPCVYSO1HGzqgvPW/e6PE2+fW60RYqy9IzoVEnZetiHE34VsKOnpxr3y84Xq1y3v3pqfrmliTVK0THoGj+7OYA2t8paLe+du9skmgi2vRkHGxRANELKhsa8cTX8V2buUJiZrV7jO3V/9SUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az4/RchV44mFmaG2MDJS+Ui4UgRlfUmpLZvGGI/FowM=;
 b=LY8YZeyZR+AQpyrt6kIFpVrvXVpWihvWZsnMssdp9xT+801YHn0dR0j1vEk0SI/+/ihG0tKXiv3tcggqcWdGR09dSFUe+kX4JXdK8WOn2J377AOb0pPuDD9phDckHA3/vjUK3uKSb1J8SyhpPWIY/ttv7cEwA1azuXAap/yJpqs=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM5PR1101MB2282.namprd11.prod.outlook.com (2603:10b6:4:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sat, 6 Feb
 2021 01:26:09 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::69a6:7774:f8dd:8b6a]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::69a6:7774:f8dd:8b6a%7]) with mapi id 15.20.3805.026; Sat, 6 Feb 2021
 01:26:09 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>
Subject: RE: [PATCH 0/2] Add support for Type-C mux events without port
 partners
Thread-Topic: [PATCH 0/2] Add support for Type-C mux events without port
 partners
Thread-Index: AQHW+/hoInDc5VxFk0Wts02AOE7ogqpKTtEAgAAG2EA=
Date:   Sat, 6 Feb 2021 01:26:09 +0000
Message-ID: <DM6PR11MB39638EE96627E29C548C1DCAF6B19@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20210205195113.20277-1-rajmohan.mani@intel.com>
 <161257294393.387556.6550563862754358247.b4-ty@chromium.org>
In-Reply-To: <161257294393.387556.6550563862754358247.b4-ty@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07602ba5-9f59-46cb-508b-08d8ca3e2ebe
x-ms-traffictypediagnostic: DM5PR1101MB2282:
x-microsoft-antispam-prvs: <DM5PR1101MB2282A4D22E98F1239983ECDFF6B19@DM5PR1101MB2282.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ansyUnHbYY0pQ/l9vgaqR8c9Fg4lPdQsXpWIUfrJAKugzF7UUA1yf2rBo9yq6g+p8KOi9o4dB/3hv/QQ2wVvB0i/75M2wn7psPjrppR12w9ghly7veG5WR+dbXfgzhTfY/GspHyrnX4rZrVI9aHoIwxBSsMmM0NJnMH6DcWxZ0JOHCexg0P2w/qmEjR4oiiTHLOawyNXJK/q6PjUVr2Y4Ct1sqd8EWVK9ZyNi+nOxhVto4n9S4vqjw5GwevEt/igxvBepIWa8LS28CXLX8HaLwe1iwLaAVDya9SESU2C4pYCilyCeIwH+SbM7Mm1GPD1HJY4K0Y8x5Av9vJE8+fgTCm446AZGq+3vzX1w1nL3/Ojox7wLUUfPAiOzyPVhWzXpXjLIueUL+Eo3wted8RoXTNZGsbK7Oc16SwWv1nDU9+we6naw2SoS/o2q4Mi4yyHRORYB3hcKCGIspMby84tDlcL1IRBXn4nmT8wYe5IOgoP1DI0zzZusJkt0bUS02h2CxEaqG9lD8fwvunQNI5Jlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(346002)(376002)(136003)(366004)(83380400001)(33656002)(2906002)(5660300002)(52536014)(54906003)(110136005)(66476007)(66946007)(66556008)(64756008)(66446008)(316002)(71200400001)(76116006)(4744005)(7696005)(4326008)(86362001)(8936002)(9686003)(55016002)(478600001)(8676002)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z4uTChkjk8fGKYSFela9kNcDfRgPSMwwIm2f8J0Fn+atJ04f77C5hce1UV3T?=
 =?us-ascii?Q?DeH+/jRJZ8zUNcA13+yamnGF+BtiOSdKPZlEg3VuUdTgJm4U42ItuYN2syxA?=
 =?us-ascii?Q?VvhdLn9qbTMdbM39Rq1GDrDXlBSEgVtD5QBUJUjPwxgjeqbs6zWUwRPL17gp?=
 =?us-ascii?Q?SGztZsjBeFauKXZIoVuAEL73RmllN0MqZdhBaXX7+1Gp4iyClXifT9nfRpjf?=
 =?us-ascii?Q?HIvCLeW9ajrfm86GJcIxCcJp2IwOy0xZZDP4D+bEBI2Ar+ODuCjRBri/xUEq?=
 =?us-ascii?Q?t8QQ13IzChXitivLZNfVyRCwlOuqHGDlQU4rhcKC9EquhLDCWlvxnjR54FJE?=
 =?us-ascii?Q?ytH2F0jpKbisS2ipQYdSPPOiU3jxmFZTYt33hOlGGVxID6u3u/wVygK5fzS6?=
 =?us-ascii?Q?ixTqtKjQkQLyCQ0R7pXbzM36lPRwohdHaNNziIpYTVw1IXE8eFbYjTeV38K6?=
 =?us-ascii?Q?6UMsGEioSM8EHqez1HcTCBptTty66h3KHCqnyO9RqxXke3K+IqCqu9FWzIln?=
 =?us-ascii?Q?aR2J9+bLvhot2qNdykkUX1Z6+O1ZqRLj4R0PGfITwjJeeXRNP1Z0wXWDIpot?=
 =?us-ascii?Q?uz9dOaPmf4Nug+w0+l6MJeM5LC4Qgk52rB3B9CMBLf0/u2EiOGq/OT1d3Chk?=
 =?us-ascii?Q?ZqiOyMgymq8k9ImfS8kBXp5OesC8W0z42RnF3gnS7QerStLi3hkHJouMZ6CL?=
 =?us-ascii?Q?W7dD7Y85oc0Ag3uCaN5zzMVRAPIfwRCAUUzdXfGvsKpBNXD64SXQejOkpRD1?=
 =?us-ascii?Q?B8WuJu1D1g3Fc1UDa4y9rK6o9PBQRTHslQi1pUpDwK45KNLnmo4MqvxRH2IT?=
 =?us-ascii?Q?WAdqoxfC8M2qhZX001VdQzVHtvrMWyLoe/YUvLNslP9cB07HAOkvzquqcYMt?=
 =?us-ascii?Q?NCC1tPU/AAtaqrv3XViYNMfaRDV5UH98BPJoozQcAtcM/vQnuereRU+VLzSS?=
 =?us-ascii?Q?Lqx1J54FEDA8xZklN+dmteb6kjk7rmFcid6DV8MA3r5eca3P2FYKZiW11esZ?=
 =?us-ascii?Q?EqlnH2TqrUzVMgMZ7bOwiikkLsqhGd/6l/4qJxLIGHitUj7/dQfNftQQDQt8?=
 =?us-ascii?Q?EPpd713oFgW6dT+Z54sT8w3Or6jNaf3F4x0NeU69x8usuF4xMfkgAPPSIuhx?=
 =?us-ascii?Q?7dC6DwTpNxcbulqVMHPw+bUp7oMiJEiocAy3R2DogDXlJZTTmLXtHQGVB+Vu?=
 =?us-ascii?Q?c8z5V5ijuVW8mn7LIPChZsr25quMS2hMLGJ+KAnUgy9023loeXGMTWnDPvde?=
 =?us-ascii?Q?5DWFsue1r8Qe8RqH154ScSbVUuNlvW0sBOCpEvqt2zkxohjP20gL2ekLGAtk?=
 =?us-ascii?Q?aY/jTtU2jd+CCohZDDup8OVs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07602ba5-9f59-46cb-508b-08d8ca3e2ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2021 01:26:09.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dx0bPfwthXv5Y9U5Yk3+fvMabAZ5tM3CNxtKQZYRsprczHJVIF4C3UsOmeVjOMdNr/ykGfrwhpPp/vJUjFMjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2282
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

> Subject: Re: [PATCH 0/2] Add support for Type-C mux events without port
> partners
>=20
> Hi Rajmohan,
>=20
> On Fri, 5 Feb 2021 11:51:11 -0800, Rajmohan Mani wrote:
> > There are cases, where support for Type-C mux events is needed, that
> > does not have port partners.
> > Enabling communication to a retimer connected to an USB4 port, when no
> > devices are attached, is a case that requires support for handling
> > Type-C mux events without port partners.
> >
> > The following patches[1] are needed on top of the mainline kernel to
> > be able to verify these patches.
> >
> > [...]
>=20
> Applied, thanks!
>=20

Thanks for the quick review / follow up.

...
