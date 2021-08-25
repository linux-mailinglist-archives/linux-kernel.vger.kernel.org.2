Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22DB3F7ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbhHYQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:36:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:13224 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241082AbhHYQg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:36:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="303140562"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="303140562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="643580265"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2021 09:36:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 25 Aug 2021 09:36:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 25 Aug 2021 09:36:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 25 Aug 2021 09:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTtHLiyzm8rwAEP9rrJz/MOoZqR6ah45NdcayjSEZGuTBkt3mDYkwrnwNUlQQDzG+oJCcTyQKqevQo0xE1uwBS6X4N8t5NC5UcvoNmSl3u2iDwZ+sj+MJimm9t+cuxcM0i/7qFEmnkD6o6Ge5EzygePxAK2RNeNC22Ybkda/HUF+Qbf7iLgNS+yKeJ7SqgOBbAabjSctY84iZowD433e29WaYhrJqlbvZpRwyy1WRy+BKpgtGivYMStgI2uIS73xPliwdBDmtPaELS8qpr6BnFRVeUiJnV2mDOqb6lcPQQRwB2FiY+XlS3afkYlYPsaDwFCZ92ePpQfg71woLLRGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYBgRLfpZ6iEB/li/RlmDxhzZOpAfH8gUP3nhaSDFjY=;
 b=M25rGCSegND8BpKJGemUkZaAHlu7XvJxMP74Rc04nHuKFSIOR2bBaQ2YzhyrL+GtpZAg29AGNeld00Yy9IUyRokgmbRLkmphKWt0DM1P0Idlhm0L+bcD6INuxa5OjuYPfTMJe9/+4IrEJ8Akyb3pXOE+lb3Du+6NAVycB7OG26C0ziiy4jBE5kDj17h3JSbY59ksFkbjZP+EPBUEps7jXQqBdkE7ZEUlTDCWvdZ6RBUtayZPBTOeajcHXu89PHZbWyfvYoZZxTXZRiOljHgjlor+Ibe1+CHHqniFGh2uG8A24CTEaAuzccd81jrI2dkimgPSdWAk95471jJivRaHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYBgRLfpZ6iEB/li/RlmDxhzZOpAfH8gUP3nhaSDFjY=;
 b=rcva3wM7Wjb67KH0TcY10D7zW90XfZVFtn9LRbV5r5kcjT9aVgYSdtm4EpAvYOA+eUzZaoNbUUp6m+TrQb8ZG9clenZhiIEkQGCcIVg4z/F+uYbw+kuJ6Xnwfj1Gwgm1Um1h+g6AbgiuhciZeNhZJm00/uhMqG/t/XAT0muYhmw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 16:36:08 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 16:36:08 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 15/28] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Topic: [PATCH v10 15/28] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Index: AQHXmcpsnr/lih8iMUiYUlBv6geHyKuEawUA
Date:   Wed, 25 Aug 2021 16:36:08 +0000
Message-ID: <D7EECF81-A701-4579-9775-481BB88F6D54@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-16-chang.seok.bae@intel.com>
In-Reply-To: <20210825155413.19673-16-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b98d7261-3ede-4690-fbef-08d967e670ca
x-ms-traffictypediagnostic: PH0PR11MB4775:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4775BBBC247E832D5B33797CD8C69@PH0PR11MB4775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xw2v70o+GBfejg3A4HvEtP8OPcB2jCrap0TGqpVQlYzBCwTJ4iI/qf431WckLEgy8ANlZaRSvtqLpUg6sGK+IjCXQ0uzqFi+i/EqUm8sv7kLAFobetndDD7ltmEv2p+cFuLjCCivDwbxxGtVWZ1gvGl9fPKVM8RI9ZOCSMgSkIZ0znheRpD5LixmTmgguF4JhUXwJYTd+KhH1XfZv2Y0e/PBKpMpzEiaxalyTgqFHYgYJhHRH72LFzstD7JP9HxxwOP5R0B8vVBnbV+npSN8FpnlggZY7odF/UygtWQ1ec+3wxqXe1LrAzG43qAngUy5NSgdXkDbIDRn4Pnd5gBT4dB/NBrVbjrRBbt2AUIrGmrvodtP0FqH2Ygrr1vsNkZfEeHI53Qj7EHr0MfLzwFZTPMUgambEFFuHzcj0o0mDvynfcvklygAddqgb2+wFCGy2wN1QrPq3GN6Baq3NTfJoOooEfvDg/7NAZ8hGxS+7fve9jFVniB8eBg07bfrcfmkOEMxyo333V2l4/dSUpwqxJM80AXoqZ17JVNCQqP4wK8pP8etji9dibzOGUqsWs8X7TH3AzbTVNi5QfGHSL6FVpvfyI8xt/ptmfMQ9NGYbgsd+JI4sGhiCTZVNTh4JQ5T2L/DPvB/SNbHTBFHRtUQ2A4PykJaRBhwaKIgmh5r1Klfsvwun4LekjheSY3KBTj9FzYBcmX3qe7BiwcxjQmM71Oo5FHKopw3MBVCEnX4VKyTkDjkc5RfHXxKT5uT/KgZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(26005)(54906003)(478600001)(33656002)(316002)(38070700005)(110136005)(53546011)(122000001)(38100700002)(2616005)(6506007)(8936002)(6486002)(66556008)(71200400001)(76116006)(5660300002)(66476007)(36756003)(66446008)(66946007)(64756008)(2906002)(83380400001)(4326008)(4744005)(86362001)(6512007)(8676002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgkvOGw+0H1QKpck9FeS6/RTZ8csHnxkyx245NXSmzT2+5rfQ19YXMvL8RIg?=
 =?us-ascii?Q?nXcJsa2GEwtFRL+1PxxWq+EUt2iaW2d9v01Fwr1OWwDJhsWrRpPAROdsFMjs?=
 =?us-ascii?Q?90mh9BZJ/+1nngvNFmFT+LiKsc2FYajvFd1XETDhMIbTqx3hj2TmyreEB5so?=
 =?us-ascii?Q?64dABvHmS8rr3UwTO8BKWTU8Zrmulg9FDFIbkAwts9fDXVpmN8z4j0auYykt?=
 =?us-ascii?Q?dw+6x6/WzOC+iG9Muv2vMBL/Feo+2J/57sAQF4VFFvMG3onKINXeXNSermgt?=
 =?us-ascii?Q?c+gSlFLitHyepR18T28AlDbhmjhWwkpXsG0EdvHiaAuoJp2t60g7UGmxCYHf?=
 =?us-ascii?Q?FCJBhXiiPvEkX/lxB5xVKGsaLY2LzGWdhva2gl7YZoWEWX6Ht/hAB2/ZStpp?=
 =?us-ascii?Q?u9FIfsV5QR8n9YhL+8FA0L2uLUhwdwHB1+ZkaYAxmCO1Vw8g4+dfxZOoft21?=
 =?us-ascii?Q?fKMlsSsEF1WzLQzI38Ji5vH0MJp0/nYl1axsP/3ILZ559QESFlpoFr1p7PyK?=
 =?us-ascii?Q?isiAn1G4+HnZosBRah9SRutsfffZDY+yTK9LJNP8iiAEq1eMsGC/6XDRd0+D?=
 =?us-ascii?Q?hFGH2ajns2heiwPNZQE9/7ZNGYW/lw/htEMK5YFDxYUW5KERUgEO7Pk2Plzh?=
 =?us-ascii?Q?QutWOYD0RqMgUygN0/mJrI3skYsN+bTbgvGwKxp9D+Dvm1QVnhIs2LFgmTZW?=
 =?us-ascii?Q?PrGrl1LSF8KgkMYC5N8g2+qIaMISRFldg017lnznSW+3WYpX/dwj6f7NUR+4?=
 =?us-ascii?Q?spu9OH5m/QkrsXgCDZSC2j09POJ0o60oUdCYo/7ufXZEctsrmyrttzPHdSyT?=
 =?us-ascii?Q?XteZuuGN4ssa6y+RMosLi0Bke/guJT1tM20a/qsIW8+93lRBvrBD6iEokVHK?=
 =?us-ascii?Q?W1dtGpQXX8q5pLOIFkPL8gDcwS0+ZyQF/YAjBIziyWcl6aVDH9R0FuAKOkP3?=
 =?us-ascii?Q?fU5Ohc6/mG0kzCZbWqOOx9n7ujMVaH51cfearEYHzX6orh+lzLkH6bZmyRQP?=
 =?us-ascii?Q?sG1Z4r5ZuhGzrZOEQUjeN/My4hzd3vnEMl9MbelZj0q4CYM3nCgbV3GvrSPG?=
 =?us-ascii?Q?H9Wfyhssku6m+sYf48Dm92o7CSebU6oYg74Uh4tenXI179aB1EmMgQh+KFJ5?=
 =?us-ascii?Q?dXrp47r6AxSAZfK2NIYKnJZ9oqjtjgAMHsCvXpOPvmH8iCwl+KqNp9Bb82aj?=
 =?us-ascii?Q?MhGwmCyCZVqG7UJf1IqDFHvcGDJWV8NQEzkB4oe5+8Mx+fZsjuJtuV8HNzGS?=
 =?us-ascii?Q?tISSW3dd6ixl87GvW3D4S+nszOPMkb6VYYJtGyMSaxiD22JTKj101/TJmp7u?=
 =?us-ascii?Q?kiGxioIU686pC1lcETKHENN2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2024D366742E74FA6ED57B7853BBC18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98d7261-3ede-4690-fbef-08d967e670ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 16:36:08.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8guNgviBgpLdHYftntgWizShEm9zWc2TPgZgFUstrzyhBkdrBXQnrxN0JiVLIXx5nTtgTVdntIRCK/1A4ee5gmogIusbKC1QNZS8fb4tBy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2021, at 08:54, Bae, Chang Seok <chang.seok.bae@intel.com> wrote=
:
>=20
> +	/*
> +	 * @state_perm:
> +	 *
> +	 * This bitmap indicates the permission for dynamic state
> +	 * components, which should be the same in a process.

Sorry, with my last minute changes, the text needs update. At least,
    s/, which should be the same in a process//

> +	 *
> +	 * Always reference group_leader's value via
> +	 * get_group_dynamic_state_perm() as it readily represents the
> +	 * process's state permission.
> +	 */
> +	u64				dynamic_state_perm;

Thanks,
Chang
