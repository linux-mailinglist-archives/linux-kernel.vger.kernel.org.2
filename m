Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B13051CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhA0FOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:14:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:45471 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234634AbhA0EpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:45:15 -0500
IronPort-SDR: MYTyxOFcgIHTX+yvIS5zcioOrF6Mm5uR4RXsQ+7IK6J+kSAjUrwXZ9cHtJc0RSVcqAxVouYGyz
 GKErxyITQxeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="176507317"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="176507317"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 20:44:33 -0800
IronPort-SDR: ajlsfAKiLgHZRA04eCh8u7EsJF/XreHxgucBI2rVS3bAaYrYsWoi0vAAicYpS1aDLVCz4XeBcX
 tQTGXKEbTgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="350878475"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2021 20:44:33 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 20:44:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 20:44:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 20:44:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxFRMWjwKGWyehTN245hJxQyrUOTqBa0a5ajHJZM/nF+7oWjLVnPAi/5V0ee3G2PjplHktjLLCWo/DsSmUZfSakjgseN/4P93MXBvzn4G7zpU6PZjtajwnCpTIo3CyyZ7LFJ0/51Ltbqa8iE8bPVV1IiKneQ2mHknHhr5+2PAfNTL2UPYWIpixI5tZCJGM8H2WNeF36yV+bz4hjyRmzt4CH9wT3V1wC9EXqn8qQt91Co8gCYGhzscEHytHQJhs+QyPFNNLQKDEBmCmAxD6MjscOrQjoBJhGxpdPKYWgTWW7l1GeZeUlCYgadp11dAyXLTEKv/CKfg6MappZNSuQa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDV8kY5XHcQaCPAABsCRLMh4Iq1vJvpAJrSUHbpt+h0=;
 b=EYcWtFBUw+YCHb6dWYLZVWfsAfsGT0FAZUJtU4IvVqVBHZqObVOX5WFw/lzt+sLJMSh6VfeMUJ1dq5KUxzuRfWJgXUHwzDYQf1N+akeethzUOZ+kYwc4F6pbWNKcRvEjSgn4wJWLuiuJ1cqNORFAOa/3mwYlrqBaTmH9x5ypSoTZ2vSeFC3gSITSlv+D8ftWPv/W5RnEZBUhg8b+brBJ1uDJZtdPQE6nQTumvue7DOvTgnni8nvUZOHmZsIFkYlM4U67ZBTeRwtkATPXHpO7GRHkfxqAJ9bhmhC2IWcuDOlc+BOXYupJdLdjqbGrnrzw8xufe4mkkAbH4igrk3qPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDV8kY5XHcQaCPAABsCRLMh4Iq1vJvpAJrSUHbpt+h0=;
 b=WwGr8GInfjk1Fa6H131xcrqexGMjOJBl2su4v1rxzz4m+vs0rm0lbLC731LNavtQG6SS+5IotafQLWSDzZrEvm1TCGn8gERsUA+SgDDxFFwrgzWa/7XpY8e+jxO83d3++MygUJIjm+nPknmK/5NQnfRXT8aj+nNnEeneWYMe5d0=
Received: from BL0PR11MB3234.namprd11.prod.outlook.com (2603:10b6:208:65::14)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 04:44:19 +0000
Received: from BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835]) by BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:44:19 +0000
From:   "C, Udhayakumar" <udhayakumar.c@intel.com>
To:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C@linux.intel.com" <C@linux.intel.com>
Subject: RE: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Topic: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Index: AQHW5gTl099PmuE5tkyFIEjInFJNy6ojmUQAgBWBXoCAAeWD4A==
Date:   Wed, 27 Jan 2021 04:44:19 +0000
Message-ID: <BL0PR11MB32343590D551F39AA8D5323DE2BB9@BL0PR11MB3234.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com>
 <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
 <20210125233935.GA13745@linux.intel.com>
In-Reply-To: <20210125233935.GA13745@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.43.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b94e0d76-92d1-41d0-81ba-08d8c27e3598
x-ms-traffictypediagnostic: MN2PR11MB4552:
x-microsoft-antispam-prvs: <MN2PR11MB45529933DADC62FCB7EA68A4E2BB9@MN2PR11MB4552.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqeKRGUvf84v4IH6/uDf2G58kPhh/5jvS/0MAYyRwaw8XVQ2qpDPfC92z9QvWEsfiVUZ6vivhZ1muxnGdonsN4F693WeOMaRCGTrUc4+Ovvk5kP8dZgh8zwLdX6OCoqyRDtnl7+v3vChGwaIl3fVqj7VDxnc7sRW6YW1qWSWU50oVG7RQ/VLXc65CO4ALKjBG435mobtcU6BbyxOExwcGXO0TTiVKlsGhLIAjsjMQYzrVc3gBfBrNQFa+oEZq42tpGHSet4BZuntxDZMkQFnymQyqVmxEzExVSbQh3ZrYyUrhpn5g18VhDd7ymIJDNPWD12MPWOXczHO2036Y25NnbQWz1mnXRu0epDzod5kncKxVpTf0r3qw4nYsF2XcAt/kWp26SIvvBB8c3Po+RNM2/nhhvYN96kUEj2/98TmkXidHc+B2x1XjTM+gP2n009n7b5bCZLIsUHP41Pv/UB2Hr2GzpXezDP9fZRE/ksQABC7XYE/KgOJyCQkrhkAIsSCNfFTlMvGjOlngaaA92Cp8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(6506007)(86362001)(7696005)(71200400001)(53546011)(2906002)(8936002)(54906003)(478600001)(33656002)(110136005)(5660300002)(4326008)(83380400001)(52536014)(76116006)(186003)(55016002)(9686003)(26005)(316002)(66446008)(7416002)(64756008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SZnSgh/UePp8jh2D3eT7iL5Fd1dg6LpojAIhZEnwYCD94Z6B0nLzzMWqP6kJ?=
 =?us-ascii?Q?KLDeQwsFpb16Og6euajSHTzwdju9tEeOwxRfxA5QY/nWHeswYwgUZzxqSmpX?=
 =?us-ascii?Q?zYlsFmcCQ7akVc5ovl7xL4t4DtGryCnnpAvAcvexDBtcntcK7EisIV7sXTnH?=
 =?us-ascii?Q?BKJHtTqmq0sAYNaEXpvDbxtzOdOMnMenrhqpy+1RlJeRzmiX5j6f0kqzD8PU?=
 =?us-ascii?Q?w2SlDNziLGkWuR+WscfWNHlHrRfQ8hrHTz+UrlnIvF/Cxq+ibVAcpA22b9p0?=
 =?us-ascii?Q?3BY2NfN6h7lBX+YkAuSvBSznlIh6wX0dx23pUKDmVphzrubLpLsoGcwaracp?=
 =?us-ascii?Q?PUckTifYsOlJUfSo8SeXho91BzO5v+wMIwHxSZy7LuNvhc8SfvXJ4p1cLnsF?=
 =?us-ascii?Q?szNQ1kyyGVOR/V7JbDL6r+tvW0jBjTYSQAmisHEdNVNcXbMgmpFw4ihsqhB9?=
 =?us-ascii?Q?Kzm3P/ryxdOzPWx9uKmAX3+wXhjo945sfNSMAqhjGS2Zo2r6jLXAr23USMoe?=
 =?us-ascii?Q?QZFbDVPPq5ZWEaWM4Qdrzwt5FLvxXpf6z1K1Srs+7POMzALhQiPEJzDhmGJZ?=
 =?us-ascii?Q?VW/coFcoNc2Ax5Ske+spKddQHJkK2PNZ4fbaRAgQbVThytFYJ03Za1U4CU/L?=
 =?us-ascii?Q?9rSj8jWHYnA+l5ddHW7Au/5U8fHlemjybF/zbOnl+f+8Qo4INyleGWhZeZPj?=
 =?us-ascii?Q?MdA4F8KJgYr3ew6nTSeBBhlg9Hjs2G9MJgRPh7xG/fGFfIgQMVQXc7nkB/Gp?=
 =?us-ascii?Q?bD1OkDE0v5pTBHRtORWBCdoYUho4314z/QGd7IByDSPMmQK22+Di/ZWXTX2u?=
 =?us-ascii?Q?fLOqbYOWMEnwMU85lNJSx0x6EJ/5bqyoo27fDM9n5l93skVYWsCDQFeC4yAf?=
 =?us-ascii?Q?yAiD1qOIA3ux50FPF8yvDVIX+rc8wkCFqXmkfVc+lNFNBqXArWmmgsXcrytN?=
 =?us-ascii?Q?kT1Pwq3fI+8y3Ua8wFoW+MHpkU0Irr6KOV6v363A6kIiEIfLD5TyZhTfwwhH?=
 =?us-ascii?Q?4zZEwdmBDlfedvHucdK2qi2e8IbI1OwsuOhc/E3XrPvLTs3og02lwZOarTie?=
 =?us-ascii?Q?36olScHP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94e0d76-92d1-41d0-81ba-08d8c27e3598
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:44:19.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQXQN8LR7hgcLEa5seN34pOCJ6N5hntKHsWyiqN9lh1tW91ZemqsTGhApts2HNivTEG0ZiiJnKcQu2cK0+xigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 11, 2021 at 11:15:06PM -0800, Randy Dunlap wrote:
> > On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> > > diff --git a/drivers/misc/intel_tsens/Kconfig
> > > b/drivers/misc/intel_tsens/Kconfig
> > > index 8b263fdd80c3..c2138339bd89 100644
> > > --- a/drivers/misc/intel_tsens/Kconfig
> > > +++ b/drivers/misc/intel_tsens/Kconfig
> > > @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
> > >  	  Say Y if using a processor that includes the Intel VPU such as
> > >  	  Keem Bay.  If unsure, say N.
> > >
> > > +config INTEL_TSENS_I2C_SLAVE
> > > +	bool "I2C slave driver for intel tsens"
> >
> > Why bool instead of tristate?
> Becuase the I2C driver depends on a file scoped global i2c_plat_data
> instanciated in the INTELL_TSENS_LOCAL_HOST DRIVER
> (intel_tsens_thermal.[ch])
>=20
> Udhaya, would you care to comment further?
>=20
> --mark
>=20
As Mark mentioned above, i2c_plat_data from intel_tsens_thermal.[ch] will b=
e used by tsens_i2c client driver.
>=20
> >
> > > +	depends on INTEL_TSENS_LOCAL_HOST
> > > +	select I2C
> > > +	select I2C_SLAVE
> > > +	help
> > > +	  This option enables tsens i2c slave driver.
> >
> > 	                            I2C
> >
Will update in v2 version of patch. Thanks for feedback.
> > > +
> > > +	  This driver is used for reporting thermal data via I2C
> > > +	  SMBUS to remote host.
> > > +	  Enable this option if you want to have support for thermal
> > > +	  management controller
> >
> > 	             controller.
> >
Will update in v2 version of patch. Thanks for feedback.
> > > +	  Say Y if using a processor that includes the Intel VPU such as
> > > +	  Keem Bay.  If unsure, say N.
> >
> >
> > --
> > ~Randy
> >
