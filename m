Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC54346B62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhCWVwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:52:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:40094 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhCWVwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:52:00 -0400
IronPort-SDR: gDgNec6hQ01DOVlCcM3VaBwAIEj02C09LU/VBpu2r0bya4hJIDHGztgJOZ6ftiDAICMf/cnlkf
 KuwXlMX7TJjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187257752"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187257752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:51:59 -0700
IronPort-SDR: 91SJ7utf2yQbcKFDdKcAOMpCRXWK96qmtj26eQuwBR2ti23Nbw89wpEGLf2UbLDIPe/HVo/1uW
 I+NYbyATezQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="435720668"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2021 14:51:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:51:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 14:51:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 14:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ480P+OekrUci+YC8zwusKUPpiEnHXv32PQzZjyzqwiXcNY6hgB+1LAMKHLVzhu0dU0VixyrgDb7gEJp6X+ivJb7q9q3FqfB6ZwCvtiKrPUD3IZybFQomtSOkKXdeushOypOhdRTOrlQ30ZafEb7UHpU1bhuN+lDb1QMwkPc23zaeDmqlnWNmxi5Ir8haNKi/MeiSB+xNTbIZV0yCdG3B0CynFe14I7Ln6hb0WGA1wmefoDbFv8LrrZqvGQzIfc+qk2tDPVtHxk4vMrGm1lHxvF7pmS9r53omcR4hLL9u401oYddSVbPlwNJqA0drt8lWHFwq9XA1TuR+jBitqn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETwVWihT6BYkIWdmszAKw4WViG1tnaqEYwUwJM69KB0=;
 b=ie9OMiEL0VSLsGn2RGCwrtg7A4gQbmJuq/n1s565o8zPSbLKKnvou5bfrsOc7PgtEHeozCMni8VzbW4rmtEVxkOWzjnzTaqUeao/ZB/pfYKYewF0eLEenLvEAlVDc0lOb5yeE3JKIg8H8ur/9PqtlRlIDweuQW4b71fTGXEBFTIzAjGfBbRtcfE5Js/IwRFD/twJGY4oi0SN0Jc+VNOZsjLO60m2LYK7pyz34rXSrXAEy4kEekzbxXIMtDe2CGGudCU30DEAnbekoff0FlASBwdT3Pv9XYk+PJII1eWUR+l92c18Q3/m+zcDvCScVSXPo4LYQCDqEKx6RJPw5JMPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETwVWihT6BYkIWdmszAKw4WViG1tnaqEYwUwJM69KB0=;
 b=Sm/0EZweK0TyXvENfw3OeZVDVuFRaDX1lVMSwnMKrNJhFUYKqp+hJv7ExgE5lLVDMcZy0qd/8nrSJqRF73s2pNbK87EocB1jQeTKTFKju4myjvRgIr3NpBHjMVGiuKJKsOEUfhhXvHBpXIqmKuS0z8hCQf3bZ3g5kspfaTM66/0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 21:51:57 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 21:51:57 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 19/22] x86/fpu/amx: Enable the AMX feature in 64-bit
 mode
Thread-Topic: [PATCH v4 19/22] x86/fpu/amx: Enable the AMX feature in 64-bit
 mode
Thread-Index: AQHXCIQDd64PsUBkFkK3hgCHrUfWkaqNjmKAgAS+EIA=
Date:   Tue, 23 Mar 2021 21:51:56 +0000
Message-ID: <199E9DDE-C8C8-421D-99A8-4381A3E67498@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-20-chang.seok.bae@intel.com>
 <87v99la54i.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v99la54i.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459f6b11-f454-4552-4913-08d8ee45e138
x-ms-traffictypediagnostic: PH0PR11MB5046:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5046CC3DFDFDBCB0BAAD1CFCD8649@PH0PR11MB5046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRPQ53JPmXbY3zg9yn1Pc+kIVYR/6ZlxLtUv25uCz0YKZDsNYqXtZoaXkX6medLAZfslSeOwYYSsYzATw9T2KyHlS9VVdfIOBwCeil9aOS4dPpEg9i8GDbDWHKplCBoApXypV9+2NfQ4wk34FnvqpETarmC3+EySpT3kJgaAu9vKFKbENRmZGM3yJJNbGTHeKrgsSG9wQMYWeszcNjyIpXYCHVCj8joMiaigkO3jnWHnNbCcGxPqksu9AzVzlxQdTUN6t+AZTUs2boZ1f7bz7U25UdAnSztNq2k6xi5WrCB9R4LED858Cn402KhwJFQOszSqY8lcFTc3BmhPuLrh8UwQRV0nQmCJrZwTkr63DUE87DL1NDI+mQLNKxz2I7zBMxdJMLjXi1KVo2Ps4M0HDtc8WgbcEgncIbfaLzxtmThMULlUcDg2IFM7mpz9xft11LIBStF4J1bcZAWWJZ74qaPVrygbZ4x3veP851S8ZfWV2/lE7bk6+1JqP8+UwOAgp8rXcZ18fsv2CC0eM3nTKyzcBQbvGm9bcXKWZo0RuZmnOQzB/bsgvhMXsofnc7bZyywh7hVfLF3ChXRBAhB4gXukn3cdkD/oHYlJOxBjDSz78x1gwVPIXZVYJrmImAuKCZAZYQP9jr+yFL9JCm1QSfqSLsxERg3MbxrqdyLMevVNBK4SiUDM2ReBPtTdUprJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(6512007)(66446008)(64756008)(2906002)(66946007)(76116006)(33656002)(66476007)(83380400001)(86362001)(54906003)(66556008)(316002)(26005)(8676002)(53546011)(6506007)(186003)(478600001)(6916009)(38100700001)(71200400001)(4326008)(2616005)(6486002)(5660300002)(36756003)(8936002)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZGtxTHNCSTdoRjR2MS9jVnJnQzdoSk9wUjB2S0pJL3pGWSs0VmJsNXVpRlEy?=
 =?utf-8?B?bUZUM1hxNkxsU3J4Y3JHTGgzMUo0R296eVkwMjlhU3h6bFh2T1htYmlHbGZ5?=
 =?utf-8?B?MGMzUVlNZzZhaHZSWG9zQWNJZ29jMEFzQ0F5U09jMC9jZnRvSXgyTEoyZm5Q?=
 =?utf-8?B?Ynl3MFZic0FUSGd6Skd2NVMwK0FJUTZFK01iVFlnTEJzNDFTZ1Vqd0dFcTJz?=
 =?utf-8?B?UnlKSWU1RlRIbmxMZTFxeVdsN2g0Y3BUSHF6MUtxV3BQTWZSRmJGUCtpeU9m?=
 =?utf-8?B?U29taWxGN0VCOGtxYnVvdWNLSDdoWHF4UmJTYndCL2lvMnMrUXhXa0phQzBI?=
 =?utf-8?B?U1EwdEhYZEFmZ3RBdmxxU0xXbGg2cnBCL1p4dGtsa0NYRmxzRCtjWmNFcjRG?=
 =?utf-8?B?Z0NzQ2FWRi9XQnBjVzVhN25xWFpIQWtlZ1ZzU0g5cW9iQ29xUjBYZkl3eUtr?=
 =?utf-8?B?dXdVazd0KzZYdFdDUm1qRjMyOVRsdkhGVTJBWmFGNS9YbjhvWmZ0YlEvWGJa?=
 =?utf-8?B?eWkxYVBxRzdIdXJGN2hHUVQvOHNISHRxZ3FVakR3ajBJdStkNWZ2WVVEQ3dr?=
 =?utf-8?B?OXVSVTlhcHpGRnZyYVA5eFFWa2paVTNNcS8wSFR1RXdlb0dhRHZzRys5a2VS?=
 =?utf-8?B?TkgyanpPdFpXcWNmc3ZWcG9Qc1Rva0YxZGg4eUhhTGhOSUZ1U0Zrd3BSQWRO?=
 =?utf-8?B?a3pRdXhaUGtDTitRWm1sMmtRV1RjMXo0bFpvS3VMTjFIQjFwMWdBdit1VjVn?=
 =?utf-8?B?REpHTjJUZTFIQmw1dGxoS2w5SmdtYjQ0bFBOOTB4RzN2RVRGakQ0NnRHWWhx?=
 =?utf-8?B?RmhnMjFjUndLS1pWT3BiMitYVGRQdm5xeitoS09PemJiNG02YXp3V3VFRm5E?=
 =?utf-8?B?MFBuanFIK0JBRlM4d3p5WGpKMUV6c1M3Zmo2bkREeEhqeXA2Wm5UU05jQ1dv?=
 =?utf-8?B?M3RLQStXeStMZ2w5WEJSOUEzVEg4OEtDVUxKSk9iVFhIdEFiZTdLYWxUZXJ5?=
 =?utf-8?B?NzFRZHJlblN4b3lkaDdQaVhtREI3bDgzb2JZWXY2dlN4UkRpOUVFYlN0clBO?=
 =?utf-8?B?RjdmMTg4dDltTG5tMXJzQzJHM2puWlAzdWJ4d0pPcFJLV1RFNmVJWWJxcXJL?=
 =?utf-8?B?MWloTUZQUUY2eHRpUkJXTXFCakx4K2tiS3E4eU41RFozdEF3aEJpRVRuTWdl?=
 =?utf-8?B?UlVicGtOVXV3dmppQ25YU3FTOEIvK21LcEh1MXNOTUpkbW5VaEhPeHI5NGFi?=
 =?utf-8?B?U3N5UlRnUFdUY2xmLytLZllxc2doOWM4MEg2RFBIZzNpKzBpd1Q2NGNObEY2?=
 =?utf-8?B?b1lMMUU3Qkx3cWlpWWZwV3IycTFyZWJsL0dHcnMwR0dvNmszTWVDUG9HazU2?=
 =?utf-8?B?dVRhUWswb0dnMXoveUNVZ0l2ZVVjL0pNa3FkRXBrNUlYb1NhYi9zSFBCV0dl?=
 =?utf-8?B?ekR4NEdwZzlxM0lnN3VsSjJpRUxQV2t6MHhWTHc0cWZvS0l2Nmx5bmVBMFVL?=
 =?utf-8?B?aVozeEx6dHVaZW1WZEhSZTcvL3hrSzkxNkR5MURsSzF1QTRkUy82ODVYVmph?=
 =?utf-8?B?eHdSNVlwRUJKbnorNmdhWHpnNzFMSW1CTTJRaGxyYjJmT2VNbythR0I4Z0pS?=
 =?utf-8?B?QyttSWh4ZXFIOHYzMXpaNG1tUXpkWFJXN0ZGcEZYUTc3RExaT0dGcFBwd1lh?=
 =?utf-8?B?VDQ4SHpMRXppZzM3c3RNSk5MOUxibEJuKzJpODNNZk00d1Y0WVlCb09nTExh?=
 =?utf-8?Q?avkSMFtPG8Z+CX4HroM3jR7POQTOrFk7nY9SW+F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <891F7A9F6A613F49952ED62A6A4EE0DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f6b11-f454-4552-4913-08d8ee45e138
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:51:57.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyf5Gt29Z8JWnBVBgVyjE6UmxZuXQIW3Aw8e7h4cS4fYwyw4mSL33a858VJXNDBLdngDYEZnZBUYqLCNk9rQ420LN2+rg6Ygt8SibEGytFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWFyIDIwLCAyMDIxLCBhdCAxNDoyNiwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KPiBPbiBTdW4sIEZlYiAyMSAyMDIxIGF0IDEwOjU2LCBDaGFuZyBTLiBC
YWUgd3JvdGU6DQo+PiBJbiA2NC1iaXQgbW9kZSwgaW5jbHVkZSB0aGUgQU1YIHN0YXRlIGNvbXBv
bmVudHMgaW4NCj4+IFhGRUFUVVJFX01BU0tfVVNFUl9TVVBQT1JURUQuDQo+PiANCj4+IFRoZSBY
RkQgZmVhdHVyZSB3aWxsIGJlIHVzZWQgdG8gZHluYW1pY2FsbHkgZXhwYW5kIHRoZSB4c3RhdGUg
cGVyLXRhc2sNCj4+IGJ1ZmZlciBvbiB0aGUgZmlyc3QgdXNlLg0KPiANCj4gVGhpcyBwYXRjaCB0
b3VjaGVzIGFic29sdXRlbHkgbm90aGluZyBYRkQgcmVsYXRlZC4gV2hhdCdzIHRoZSBtZXNzYWdl
DQo+IGhlcmU/DQoNCllvdeKAmXJlIHJpZ2h0LiBUaGlzIGlzIG5vdCByZWxldmFudCBoZXJlLiBJ
IHdpbGwgcmVtb3ZlIGl0Lg0KDQpUaGFuayB5b3UsDQpDaGFuZw==
