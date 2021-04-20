Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D28366207
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhDTWJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:09:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:7352 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234293AbhDTWJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:09:01 -0400
IronPort-SDR: KDd0qXxAvrMuBpg7uiKl1ylq+aQz/BC0r4WdKk2qvOVHMbCMz9KTD+AtP3O3WXlllyHsHSIwtP
 FlN1BmZFZfBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280930524"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="280930524"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 15:08:29 -0700
IronPort-SDR: AbdXMI07MSN1as6HPydFZL1Z+TG+x8eA8b0h03K1/FqPxNcd4SM/pPS4UARwW/gCNIXwc2Gd9s
 w8GtN5ug68wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="385524364"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2021 15:08:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 15:08:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 20 Apr 2021 15:08:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 20 Apr 2021 15:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ19VBmMkRKKqMn0aqr3O0j/3ekdB3DoG1F/xFWF9ikwH3c9o42qn5oL1BiT5OxvUTOuVs49KrElJ4pTVvP4SooqlSbz1h1oQPKCaXRoZrW7DZ3Itgl37t3Nsvd3D1utjVVvQaoHireqp9lucNJ7WDqcf9HqQiosSwzpYc3nICvs8BLbl+HfhCoQKbqyzoJGiBSzKEfpUWdz12sG+xrbjfrBkeWvPKm+6SzT76GYR+7HFrcyCOs4Vz9rl20opMqYcWajNvhFFh3IygVNs349BpyWJTID3rXWiQYtYTFfVaEvWZrDzRTt7MSOEorR43Ivg9wX4O5SRMBNXM3K7klH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTdbylxQ2Qs+AGeU3kfTTT+CvbLuFShYNi0bDfepGpw=;
 b=OLDDmGgVF8u82tqrs+udwIH9EsJtIgCT7rBA+zrKuVl+9dQuaZ8rM1jYfbLbXQZQth0D2keIWAK5mbV/pJju5HpKTHlLXiU7ZAF5I6NPYsuOEROklC9LOiIhrNXOuI7QPuQbtCxvxU/SKmVnF1ku43FULlSbA2O0NyyHN4QobWyWpmpid8kVi4H1zu/kjf0NtzzWUVmJoyA36opia/xt0aIovhqJvJp07PGCYUn6hoADKWkS90d50lJJA/aTDv0hJ0TpTtByQ8bgfdQI/kPSSYGceOLbtAZq8WaZDgm5aZrvrQ0pe62CnIL1gt+0O9KS7z1j6Qd3ZvR9382p2FaVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTdbylxQ2Qs+AGeU3kfTTT+CvbLuFShYNi0bDfepGpw=;
 b=d/TYRM397x/yUG8npw10Lfw9tCmD4sXA6Sw1uzfmhcBDaQWN9vNXy24n3/33twcPsCaw5vjyuRoSrSqVLLZ/yCu5Xv+feOg17QoESWkjUvnZBrwdB7ilJ8CyLbf7YBHkML5J0o0CEx229UX0zxLR9mvcV7va4UNK/BhkeSGEAzk=
Received: from CY4PR11MB1670.namprd11.prod.outlook.com (2603:10b6:910:e::22)
 by CY4PR11MB1864.namprd11.prod.outlook.com (2603:10b6:903:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Tue, 20 Apr
 2021 22:08:26 +0000
Received: from CY4PR11MB1670.namprd11.prod.outlook.com
 ([fe80::e9e0:54ab:6281:bfa5]) by CY4PR11MB1670.namprd11.prod.outlook.com
 ([fe80::e9e0:54ab:6281:bfa5%8]) with mapi id 15.20.4042.025; Tue, 20 Apr 2021
 22:08:26 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kelly, Seamus" <seamus.kelly@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 19/34] xlink-core: Add xlink core device tree bindings
Thread-Topic: [PATCH v6 19/34] xlink-core: Add xlink core device tree bindings
Thread-Index: AQHXAY25Omewg1v/EEm6NpW3jTJF9Kqxw5SAgAycXXA=
Date:   Tue, 20 Apr 2021 22:08:26 +0000
Message-ID: <CY4PR11MB16703EA2D146854AEF3A94F68E489@CY4PR11MB1670.namprd11.prod.outlook.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-20-mgross@linux.intel.com>
 <9fb59639-3745-33e7-e89c-c9fb75e9c7c4@intel.com>
In-Reply-To: <9fb59639-3745-33e7-e89c-c9fb75e9c7c4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8fc7f40-983c-4ccb-116d-08d90448d25e
x-ms-traffictypediagnostic: CY4PR11MB1864:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1864AC18F761485A46A4EA568E489@CY4PR11MB1864.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8potHdAmIh6i1UQHm7Z3i5hfrBNpV2CC/tt2aeppnzQRszGs+fDdvj728TWfB16dzJc/fpkRVsPm50RGdlX1wwuaCxkrrRswR7UyYARJucN9+GYfHjlgC489lGSFRpHfmPOvFoeRkQWeHHxH6X3kX/3QjizyUQWciLhmPtEb0zd2EgrJK1uAQvnEo0bOQ+tvrSfVn5dpy69shGn9keDCnTtWliTYGrRDWZkOh7C8Bua69xrOOGqE3hE7jWvdrofTx88f2BiimH20tBby8a42uvgYwiLRF9ZKFyAbNkAN2sJWRQ2jsx7ZIfG2vmVgDRC4IV6r/uq2TRp0tjPEy+YO1fk71zBlGkjwv0qgY3EmkgIjgXw27CxMG+ayqHx6LQ/hcgPF4xl9slKXP6yGMKglZ9DaAMDbUvLrZgR2G8LPvqyBVRQP1xyAj8fWiS8HYY/+EGF0MaXfZBN+OLhQbbFefTZMh4X0gQvG0HVcGO2NUDwUr/LGbjzH06VFFkNfzrtkYqkgXmn4P4X9rBWa9arHL79j8GfqnbCClqUmvuj38aMQInsiIQDrOxp48e10bYCk+Y5+7Lwkf8OTZePjTumzTRNavP2p/Ew35jBCL4iu4tSO1HNXacPSSteb5OIEoxsL4QmgyLysBFmg8VbNPMIebPVqJv5Df9ZArvHLh/qeQVdZ2kSazpP4rFlTGs7VJvwC56fYMoMXH6PO8wNOnAIUBNYJXCF2PBy5RY6OEdK/FSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(71200400001)(921005)(5660300002)(66556008)(64756008)(110136005)(33656002)(83380400001)(66476007)(53546011)(6506007)(7696005)(7416002)(4326008)(8936002)(52536014)(54906003)(122000001)(26005)(55016002)(186003)(86362001)(316002)(478600001)(66446008)(8676002)(76116006)(2906002)(66946007)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TmhGQThseGRja2xDMnhwelphZTl4enlMTzlqK1VSNkYxU0Y0MkRwbjd0NjMv?=
 =?utf-8?B?azkrajVEOTMvd2x1ZTN1T0tRaUFSUXZDQ00veUtUdVFJcGNJTVpmNHN2YXIr?=
 =?utf-8?B?a1JkeXlOdjJ4cGhXUTdwUjI0Q2xyZ21EWFRKSlVmek95Mlo5SE9rc1R6S1NO?=
 =?utf-8?B?NEI2NnhtcENXL091UXE2R1pJRlNNN2R6QkYrTUQ0S0dtWCt6QmVtMjBaSTZr?=
 =?utf-8?B?K2RwVWdEZ25MWDRITlE3eFJGWk5EMVl6OGNWazZ0YzErVzFBNExnOEl2M0Fp?=
 =?utf-8?B?SzQwdjUzZnhSQnZjd2RRUjZaanVHUzVNOEZGZ1J1L292V1g2c1RqMUcrbmtV?=
 =?utf-8?B?SzNYMGh0UktyRHRoL3BzL2NJUnpIZUZVaC9FQjBRZ0h5dnZQdVE3dHpBRFVu?=
 =?utf-8?B?R1QzNU96RVA1MDhoOHQzbXhWWjZXRkhOQW83c1cxL25aeUtXcnpZdDFYL3ls?=
 =?utf-8?B?dGl5QTMwb21LVHZ1NUNnMlJ4aGxwNlRFSkZMVVUySzBQeGRYbVJMMXBGTFBK?=
 =?utf-8?B?ZW9abVZzWVliQ25ET3p5aGUwalJtYks2S3lOaXdkTFdjZG5oNGlucml5SFE2?=
 =?utf-8?B?c1drc1BSZlVjWTZhTzd5UGo1OVFxMk1jamhaQ3VEeGQ1NjBBc1ZZT2JNUjZC?=
 =?utf-8?B?S3ZOekp0MjFneGFhTkZsM2FReHVjREJ5L1hRdE93RC82akNMeTlPN21nVnNp?=
 =?utf-8?B?MVNBaWJiS2EwM1dRUW1uSk9RNUFsNGNuT1ZvdUVTWklwRlJZQ0pldzhnOUVE?=
 =?utf-8?B?cStRRkdzeUtuYkpVSGRXZGM3QjNDTjZ6QndMZGF0Qk5KTFBSdlFMTHRtaWNX?=
 =?utf-8?B?cXhwY1Q5bTllRnBaMSsvYzY4aVpHVWdjNGt6bmd1T205c1ZZUytydk9pQ1lE?=
 =?utf-8?B?RHVnYUt6bTlLZURMOUY3dWdtSVdWVUI1dy8xY2N4VFdaRTRzNmhQL0hiZlFF?=
 =?utf-8?B?UldsYktVYkRkTnR1SUFNbG9uSU1zTlVNUktZcW52REljQ3hwS0ZLc1l4bFVL?=
 =?utf-8?B?MEhoK3F4UWVKemU1TU1oWVBsNHJxNHVpNDhnWFQ2NnJ3YU1UbTgrMTJZWEV3?=
 =?utf-8?B?dVM5MVJOWWcrTkxHVGF5N0g1RCt6aHkycFBxQkRURGdtcGt2bVZrWFVNLzBo?=
 =?utf-8?B?aHd1YXQ3MWtvMDlZM0wyUktZMllPUWNvWXhlTEVSaTRHZ1NQYlBqeGlwV1BH?=
 =?utf-8?B?Y0xjNGIxZXlUK3dSaTEvbWRCeGxIbEFNVFdFM3NlNEwwem9MS1FUdTlQQUQ1?=
 =?utf-8?B?akpPMjJUaktDaUtERlRxWFJheEY4RVFwNkI3SklCSzlWdDV2V29VVjg2K1FL?=
 =?utf-8?B?WGFXY2FPYlhIcmZZTEw1eTQ0c1E4dmdSRGFuZzJYMC91WnVGK2VaZFVxT1Mz?=
 =?utf-8?B?ZTU2dEZRSCtJY09BVDE4QVRrdEwyY2s2WUM1SzQ2SnkyQ1o4Y1JaRlMzYlIz?=
 =?utf-8?B?YmhyNU8wNTlzaWRDZGh0RVBpaVlkVHJTbVc3WVhCcFlTY0M2U3E0L3hJVGUr?=
 =?utf-8?B?Y0tpcis3UlVhUnNjTmFzN3RZc3pSNjlPeDMrdUJmaEc0aVNKd1QzSHFqWXZD?=
 =?utf-8?B?Zk5iVXBiWDYxMjhIYS9uTVAweWR0ditZNFRmUThJSkg1SDJxbGtKc2M4NEpv?=
 =?utf-8?B?Y2JNaGZkeUdLZjhmU0x5QVhHaFRreWNKOWU3VEI3eTA4dGNvejRqbFhRaWI0?=
 =?utf-8?B?MS8zdUxPaVZZc1piUXpFMHpiZmxxMlVqTmJXb1NwUFQ0bWR6YU1MWEFaZ3F1?=
 =?utf-8?Q?OYp5CuGdCYUW611Xhsa8RSxfp+Njxu0wiUEhhnj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fc7f40-983c-4ccb-116d-08d90448d25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 22:08:26.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjSAxepdFKs1L5kSkqRYHlElqvb4+ICd/Skdl8r04Hf8awIysIc3nrzlle9h0V3JatcxI4hhfo0cgfz0aBdlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1864
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMiwgMjAyMSAyOjMz
IFBNDQo+IFRvOiBtZ3Jvc3NAbGludXguaW50ZWwuY29tOyBtYXJrZ3Jvc3NAa2VybmVsLm9yZzsg
YXJuZEBhcm5kYi5kZTsgYnBAc3VzZS5kZTsNCj4gZGFtaWVuLmxlbW9hbEB3ZGMuY29tOyBkcmFn
YW4uY3ZldGljQHhpbGlueC5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBjb3Ji
ZXRAbHduLm5ldDsgcGFsbWVyZGFiYmVsdEBnb29nbGUuY29tOw0KPiBwYXVsLndhbG1zbGV5QHNp
Zml2ZS5jb207IHBlbmcuZmFuQG54cC5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZzsgamFzc2lzaW5naGJyYXJAZ21haWwuY29tDQo+IENjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBLZWxseSwgU2VhbXVzIDxzZWFtdXMua2VsbHlAaW50ZWwuY29t
PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NiAxOS8zNF0geGxpbmstY29yZTogQWRkIHhsaW5rIGNvcmUgZGV2aWNlIHRyZWUgYmluZGluZ3MN
Cj4gDQo+IE9uIDIvMTIvMjEgMjoyMiBQTSwgbWdyb3NzQGxpbnV4LmludGVsLmNvbSB3cm90ZToN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNl
KSAjIENvcHlyaWdodCAoYykNCj4gPiArSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiAiaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvbWlzYy9pbnRlbCxrZWVtYmF5LXhsaW5rLnlhbWwjIg0KPiA+ICsk
c2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjIg0K
PiA+ICsNCj4gPiArdGl0bGU6IEludGVsIEtlZW0gQmF5IHhsaW5rDQo+IA0KPiBJcyB0aGVyZSBh
IHNwZWNpZmljIHJlYXNvbiB0aGlzIGlzIGR1YWwgbGljZW5zZWQ/ICBJZiBzbywgY2FuIHlvdSBw
bGVhc2UgaW5jbHVkZQ0KPiBpbmZvcm1hdGlvbiBhYm91dCB0aGUgbGljZW5zZSBjaG9pY2UgaW4g
dGhlIG5leHQgcG9zdCdzIGNvdmVyIGxldHRlcj8NCj4gDQo+IElmIHRoZXJlIGlzIG5vIHNwZWNp
ZmljIHJlYXNvbiBmb3IgdGhpcyBjb250cmlidXRpb24gdG8gYmUgZHVhbCBsaWNlbnNlZCwgcGxl
YXNlIG1ha2UgaXQNCj4gR1BMLTIuMCBvbmx5Lg0KSSB3aWxsLg0KDQpJJ20ganVzdCB3YWl0aW5n
IG9uIHNvbWUgdGVzdGluZyBiZWZvcmUgbWFraW5nIHRoZSBuZXh0IHBvc3QuDQoNClRoYW5rcywN
Ci0tbWFyaw0K
