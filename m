Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037533EB23F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhHMIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:06:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:23023 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239708AbhHMIGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:06:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202683923"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="202683923"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 01:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="470022128"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2021 01:05:02 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 13 Aug 2021 01:05:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 01:05:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 01:05:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 01:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMVjy2ZvRFDnCOUs4Pi3T6PIWjs/W/WRymkKUaKHSfVIqLR546WAfvw1Ox8DNhck0dDSQZaQx6YIYezmRp3fC5Lo72WcJjnbzMT1kA8VAL7ODE5V4jzi7UxFB8dWV00spnLlmTXMdciFKdbs4+bceQVGrAOcYVlqsr+iv6cibx0eWGuHfqWKjzC1TR++bjzRAIr4kOxeu3w6lBl248IMGbvejql+0yRdrlILmMk5vJvghy3I2UZlFsYgPfQjAiv2xDk/ADilRQLXCRPJ/OmPBR4Bzyd3nWR6/cKzKluJoHl8nUkRt3LepVbIb/RUQjL2M6mo4gmuHdeQknEakpt+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9BGOrGRVxZlIIZsIFrVlYNxp2qWXl5CWV22vAn3FKY=;
 b=oQYPRTSaLbfCqmzziaYRZ4l5e+yeoUMjNlTShHjG4co/TlXMCosGUunaWOJQ1Lja6fku2Kdj5l54lF+6L12YyAlI09rlNT+zvnQiZIeIDiE3fYMEuT79A++2QdT8mxg2kB4WOfn8F2Ifbz9f0qsCoGIgElZ1rgnzP6VDMmsvs2WlfTQZrjJAig0KU7x/5okizEPbDYcWcSGfQh9akN7nfBdgKpX/bIyyMJD7IiNfzKGEHWGXV0YoVe7gORbLoFgqMdFMx6IvcZshe0SviJK8tI+WBbCbuenOQI+44hciSaP685XFnyTpd9AJUz8QffxBo0P9ig6YZixFoKt16uUGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9BGOrGRVxZlIIZsIFrVlYNxp2qWXl5CWV22vAn3FKY=;
 b=EboWjIiLBUHUnFIL1e7myTMaLE3HUNY5gWUKgZjdbJ/OzqdGSmWMnyiKtxtg02VecP0+6SGdRYd0e7L2O+P1vkheDOrxwwK+1ec7T31e5NhhsgA8762VGc4YPjvutKkxcH+g+S5wHF8UbEel6dOqnX3yAMMTTmC7S5SIogUFszY=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 08:04:54 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 08:04:54 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgADOwYA=
Date:   Fri, 13 Aug 2021 08:04:54 +0000
Message-ID: <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
In-Reply-To: <YRV6M1I/GMXwuJqW@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d2337b5-dd51-4973-e54c-08d95e3108cb
x-ms-traffictypediagnostic: PH0PR11MB5078:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB507825897DD7939C44D6C94DD8FA9@PH0PR11MB5078.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/NKBr2WWeTcPb34WHqFqiR+CqWz6PSzM3AeNATUaUt2FnyMT0cciTp4V7Q/UmZDansgSuATgJ5uX6fjpv5az0ms82v75toYBX2UOqaDTG1J360qqinVdyXVUCCB1uPEIwxtbqACV/qfssitGsPU759ZpHH55zYC/WeA3hMsV7yVocKR74LrBwxFUSCIQ1fnEHCNOBQ/dsNeJEzqXWMJCvWQqa2YObLZUi+l/n838nY/dCWiVZQtwS0b22MqJDjkWMMk81rC3DCyF2D7kJxHIxYj5eO77G+jOxLG2AtPHTsWsfBr1AmVIq9OAY5HFQPJkJKyawLRx5YV80rqb0UT0F/CICKnhz94FkmbvBBRihjR5qUTzuiEHYu/24TQvqM8eKIIEACTJMHBz3I2bYLb6wvT3vXtiDvWpG7XJhZT04bi3EkQ+/jpy+dIukN4VB+DS97THHBmKZTxCASVhOyU7mu/W+/E/qUJWGCJk47ZVH+XJQjPeQ0BbmkfCiYgBIqNAJJAtGEzRnmnpDH5Zm1RquUGCJzOc8Rq4VDYWPWkLykyLa5Qwonx5KyPuI7HRKm2AOMymAlgq0HEFadCFIu3D+QlGFl/U6qROBAqTftteZANy59DASe0KNMwBHXg6iTPmPyhqIbUTkeJLuBFCf20+KrUMaNOSujosX7moQRpUgy7LtkA5BT2kUATi9tC30g1UZqZuhg1XoSVKuJsziGW6lEQS4QCKCib0GTkUJyAlHOhjtCaahsMeXoyhVyJ9lm1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(478600001)(53546011)(26005)(6506007)(8936002)(8676002)(33656002)(6486002)(6512007)(5660300002)(38070700005)(186003)(2616005)(2906002)(83380400001)(66946007)(66446008)(64756008)(66556008)(66476007)(6916009)(54906003)(316002)(86362001)(38100700002)(71200400001)(122000001)(76116006)(4326008)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1J0aDZxbmpnZWJUVTJNRGc1Z3JTbTVxN3hqeVZqSW1Zc3ZEeUpsRHpFY1N6?=
 =?utf-8?B?NHp2SGNqOWFVMk9SOXROd0tSNVVLRzJaamJ1R040TXJZWHNDZEo3UmJneDVr?=
 =?utf-8?B?ZjN1TDJBbEQ5TlFVSWcwSEczNW4ydmJnV01MVkJobW9jV3BHc293RjNmZmtP?=
 =?utf-8?B?c0d5WEp2eWF4Nnl5RWpBSXBCdkhiNkhUalNNOTUrYU1Ddnd5TERIN0Nta3lL?=
 =?utf-8?B?UkhDU2F6UHgyR0ZzY0JjSXc4c2hNcnlBajd0dVp0SFduWEJ3Um9ZYTh1aUxy?=
 =?utf-8?B?d2VidVo4L3RMTDJJYU1xNFVNdmZxd01wQmY3dk9PZldTb2E4b0swaHNDWkdy?=
 =?utf-8?B?ZVFmdnFycmFSdmFpTWI1cWxCUU0xTnkxdWpHUFFkNFlGLzd0QUdjL2dwSk9v?=
 =?utf-8?B?RlZsWE5vZTlHZDFKNy9oOWtVQ09XbTgvWmtmcjdmREpBenptZEdxQk1pbW1n?=
 =?utf-8?B?cnV1NXk0Zlp3K1BuQm9EcCtKSENmbGZRWnpVeWY0QUpGOWxMYzdSRHFkUnF5?=
 =?utf-8?B?a00reU0xYng1Wkd2eEVmOGdESmNyZ3RlMS9EWmppSVJ2bnlIeVI4R1BHMEhK?=
 =?utf-8?B?K0EvczBBQW1ZUWNmV2RUYXUrK29rb3FhOXBhZGVUWEU2QU5pazZ4bkEzSmNj?=
 =?utf-8?B?cjJzWE03Q2lsekl1bjZwckVMNi9RR3pvL0pja2xIWmtORUY4bjVqanlKZncr?=
 =?utf-8?B?VlFTYzZLekd4bVBtT3FveVdwTThBekdhZ21BaVE1TXIzQ2w1SGw3NUVDK2hw?=
 =?utf-8?B?dmx1THNYNThhYW1Bd25tMmtrN0U1S2R0VVlTQStxSTN4QlozQ09hOWIxRTUv?=
 =?utf-8?B?OENjcU1vVmxTN3NYLzVCZTNYNXRtR1pVcUJUaFhoci9uckJBVTdsVHhKNU5u?=
 =?utf-8?B?UnJyL09LMFB6ZEdiSGVoMFpFaCt1ZllacUQ1WllTbFIxRkVxaysxanFMbWF2?=
 =?utf-8?B?RHhwMXFUdTU4NDRYVlk3YWQ5VVRoNkRNNitQTUlxZEF4NXQva0FhblNiazhm?=
 =?utf-8?B?UzQ0UmxNQm5HZ0xIMEhkM3JCOGxCY25XYW5qbjVMTm0rYWkyWWlBemFNQkcr?=
 =?utf-8?B?NDBleTAyeFRmNTVubDdlVGJPWXhtY1FNZVNwK2l6SVdYbEZIcWVzanBWQ0tl?=
 =?utf-8?B?d29pQmhqSVkzMFB3dmRTS1hjdWVDVDFWSDIvaFBqaWc3NHg4dncrSzlNMmI1?=
 =?utf-8?B?Q0o0cDVxZ2cxLytaeDlhYUZmRmlmNUZHd3VLVW51VzBMVGtDYlZEdU5CdVNP?=
 =?utf-8?B?RDBXRmgrZlZFOFNqZ2JrWDY0RE0zTVpYbEFMTVFoUlg2bU4xbGthanl2NlQ2?=
 =?utf-8?B?NmVuRzJnUnhkNmh5bEI4WThhWDA5cW1Hd1Y0eXBNZGIrTzd1Kzd0YkVmQmps?=
 =?utf-8?B?Wml0cWhQc0dISE5ldGt4YW4ya1l3bVFtTlNQTTZPcWRyV0hzUGtINjVMR2ly?=
 =?utf-8?B?ZWIrQlZOajMxSGw4cnU0QUkxbHJ2Z3loelFXSUQ1cnl0TC84Z0tNakkrMXlk?=
 =?utf-8?B?VUVueEwvaEZtVEptTjQwVEljbk9QYmVBZkJjd1FzWkxLeXhXOW80YVJ6V2lo?=
 =?utf-8?B?OUUyaTF0YW00UE1hV3BLT3hTOS9leHpTb1U3dVlib1hXSWEwT0RWUmQxS0FC?=
 =?utf-8?B?TTA4YVVOVEd1M1hRQ1ZaS1lodElhMzNpOUp1UUh3L2xMb292NVdmYlZ0andE?=
 =?utf-8?B?TUlaTHdneW9lam1VREt1UGlFZjdVTTdndnUycDQwSGRXeFlZMTFlb0lYa1VI?=
 =?utf-8?Q?6OJJmkkgu+OncwerfXyI6vWpZpGqQc70N3eMUdS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C3FC38D0F4B754E9F7C84A73D4516D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2337b5-dd51-4973-e54c-08d95e3108cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:04:54.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuGw8uGOoLuK3lnwE8ZZwtivm8BElbF1SkKYXR763AwHt8exvtypgfkJtLVeOjn96lV1MfSvfnSxEg2hHDTD8WdZbb6UxLXA0ouWsRPuUNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDEyLCAyMDIxLCBhdCAxMjo0NCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCAwNzo1OTozOUFNIC0wNzAwLCBDaGFu
ZyBTLiBCYWUgd3JvdGU6DQo+PiANCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RyYWNl
L2ZwdS5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90cmFjZS9mcHUuaA0KPj4gQEAg
LTg5LDYgKzg5LDExIEBAIERFRklORV9FVkVOVCh4ODZfZnB1LCB4ODZfZnB1X3hzdGF0ZV9jaGVj
a19mYWlsZWQsDQo+PiAJVFBfQVJHUyhmcHUpDQo+PiApOw0KPj4gDQo+PiArREVGSU5FX0VWRU5U
KHg4Nl9mcHUsIHg4Nl9mcHVfeHN0YXRlX2FsbG9jX2ZhaWxlZCwNCj4+ICsJVFBfUFJPVE8oc3Ry
dWN0IGZwdSAqZnB1KSwNCj4+ICsJVFBfQVJHUyhmcHUpDQo+IA0KPiBMYXN0IHRpbWUgSSBzYWlk
Og0KPiANCj4gIlllcywgYWRkIGl0IHdoZW4gaXQgaXMgcmVhbGx5IG5lZWRlZC4gTm90IHNsYXBw
aW5nIGl0IHByb2FjdGl2ZWx5IGFuZA0KPiBob3BpbmcgZm9yIGFueSBwb3RlbnRpYWwgdXNhZ2Uu
Ig0KPiANCj4gV2h5IGlzIHRoYXQgdGhpbmcgc3RpbGwgaGVyZT8hDQoNClRoZXJlIHdhcyBubyBj
bGVhciBwYXRoIHRvIGVtaXQgdGhlIGVycm9yIGNvZGUgYmVmb3JlLiBJIHRob3VnaHQgdGhhdOKA
mXMgdGhlDQpyZWFzb24gZm9yIHRoaXMgdHJhY2Vwb2ludC4gQnV0IG5vdyBhIHNpZ25hbCBvciBh
biBlcnJvciBjb2RlIHJldHVybiBpcw0KZXN0YWJsaXNoZWQuIEkgc2hvdWxkIGhhdmUgcmVtb3Zl
ZCBpdCBhbG9uZyB3aXRoIHRoZSBjaGFuZ2UuDQoNCj4+ICsgKiBAbWFzazoJVGhpcyBiaXRtYXAg
dGVsbHMgd2hpY2ggY29tcG9uZW50cyByZXNlcnZlZCBpbiB0aGUgYnVmZmVyLg0KPiANCj4gYXJl
IHJlc2VydmVkPw0KPiANCj4gV2hhdCdzIHRoaXMgbm90aW9uIG9mIHJlc2VydmF0aW9uIGhlcmU/
IFRoZSBtYXNrIGlzIGRpY3RhdGluZyB3aGF0IGdldHMNCj4gcmVzZXJ2ZWQgaW4gdGhlIGJ1ZmZl
ciBvciB3aGF0Pw0KPiANCj4gTG9va2luZyBhdCB0aGUgdXNhZ2UsIHRoYXQgbWFzayBpcyBzaW1w
bHkgc2F5aW5nIHdoaWNoIGNvbXBvbmVudHMgYXJlDQo+IGdvaW5nIHRvIGJlIHNhdmVkIGluIHRo
ZSBidWZmZXIuIFNvIGFsbCB0aGlzICJyZXNlcnZlZCIgYmxhIGlzIG9ubHkNCj4gY29uZnVzaW5n
IC0gZHJvcCBpdC4NCg0KT2theS4gSSByZW1lbWJlciB0aGlzIOKAnHJlc2VydmVk4oCdIHN0YXJ0
ZWQgZnJvbSBhIGNoYW5nZWxvZy4gV2l0aCB5b3VyDQpjb25mdXNpb24sIGxldCBtZSBhbHNvIG1h
a2Ugc3VyZSBhbGwgaXMgcmVtb3ZlZC4NCg0KPj4gKyAqDQo+PiArICogQXZhaWxhYmxlIG9uY2Ug
dGhvc2UgYXJyYXlzIGZvciB0aGUgb2Zmc2V0LCBzaXplLCBhbmQgYWxpZ25tZW50IGluZm8gYXJl
DQo+PiArICogc2V0IHVwLCBieSBzZXR1cF94c3RhdGVfZmVhdHVyZXMoKS4NCj4+ICsgKg0KPj4g
KyAqIFJldHVybnM6CVRoZSBidWZmZXIgc2l6ZQ0KPj4gKyAqLw0KPj4gK3Vuc2lnbmVkIGludCBn
ZXRfeHN0YXRlX3NpemUodTY0IG1hc2spDQo+PiArew0KPj4gKwl1bnNpZ25lZCBpbnQgc2l6ZTsN
Cj4+ICsJaW50IGksIG5yOw0KPj4gKw0KPj4gKwlpZiAoIW1hc2spDQo+PiArCQlyZXR1cm4gMDsN
Cj4+ICsNCj4+ICsJLyoNCj4+ICsJICogVGhlIG1pbmltdW0gYnVmZmVyIHNpemUgZXhjbHVkZXMg
dGhlIGR5bmFtaWMgdXNlciBzdGF0ZS4gV2hlbiBhDQo+PiArCSAqIHRhc2sgdXNlcyB0aGUgc3Rh
dGUsIHRoZSBidWZmZXIgY2FuIGdyb3cgdXAgdG8gdGhlIG1heCBzaXplLg0KPj4gKwkgKi8NCj4+
ICsJaWYgKG1hc2sgPT0gKHhmZWF0dXJlc19tYXNrX2FsbCAmIH54ZmVhdHVyZXNfbWFza191c2Vy
X2R5bmFtaWMpKQ0KPj4gKwkJcmV0dXJuIGdldF94c3RhdGVfY29uZmlnKFhTVEFURV9NSU5fU0la
RSk7DQo+PiArCWVsc2UgaWYgKG1hc2sgPT0geGZlYXR1cmVzX21hc2tfYWxsKQ0KPj4gKwkJcmV0
dXJuIGdldF94c3RhdGVfY29uZmlnKFhTVEFURV9NQVhfU0laRSk7DQo+PiArDQo+PiArCW5yID0g
ZmxzNjQobWFzaykgLSAxOw0KPj4gKw0KPj4gKwlpZiAoIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVS
RV9YU0FWRVMpKQ0KPiANCj4gY3B1X2ZlYXR1cmVfZW5hYmxlZCgpDQo+IA0KPj4gKwkJcmV0dXJu
IHhzdGF0ZV9vZmZzZXRzW25yXSArIHhzdGF0ZV9zaXplc1tucl07DQo+IA0KPiBGcm9tIGFsbCB0
aGUgc3VwZXJmbHVvdXMgY29tbWVudGluZywgd2hlcmUgYSBjb21tZW50IGlzIHJlYWxseSBuZWVk
ZWQgaXMNCj4gaGVyZSBidXQgdGhlcmUncyBub25lLg0KPiANCj4gV2hhdCdzIHRoYXQgZG9pbmc/
IE5vIGNvbXBhY3RlZCBzdGF0ZXMgZW5hYmxlZCBzbyB0YWtlIHRoZSBvZmZzZXQgYW5kDQo+IHNp
emUgb2YgdGhlICpsYXN0KiBzdGF0ZSBhbmQgdXNlIHRoYXQgYXMgdGhlIGJ1ZmZlciBzaXplPw0K
DQpZZXMsIGVhY2ggc3RhdGUgb2Zmc2V0IGluIHRoZSBub24tY29tcGFjdGVkIGZvcm1hdCBpcyBm
aXhlZCBpbiBhIG1hY2hpbmUNCnJlZ2FyZGxlc3Mgb2YgUkZCTS4gU28sIHNpbXBseSB0YWtlIHRo
ZSBzaXplIGxpa2UgdGhhdC4NCg0KPj4gKw0KPj4gKwlpZiAoKHhmZWF0dXJlc19tYXNrX2FsbCAm
IChCSVRfVUxMKG5yICsgMSkgLSAxKSkgPT0gbWFzaykNCj4gCQkJCSAgXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eDQo+IA0KPiBUaGF0IHRoaW5nIGxvb2tzIGxpa2UgYSBHRU5NQVNLX1VMTCgpIHRoaW5n
LiBVc2UgaXQ/DQoNCkxvb2tzIGxpa2UgSSB3YXMgbm90IGZhbWlsaWFyIHdpdGggdGhpcyBtYWNy
bzoNCiAgIGlmICgoeGZlYXR1cmVzX21hc2tfYWxsICYgR0VOTUFTS19VTEwobnIsIDApKSA9PSBt
YXNrKQ0KDQo+IEFsc28sIHdoYXQgaXMgdGhhdCB0ZXN0IGRvaW5nPyENCj4gDQo+IElmIGEgbWFz
ayB1cCB0byBuciBBTkRlZCB3aXRoIG1hc2tfYWxsIGlzID09IG1hc2s/IQ0KPiANCj4gWW91IG5l
ZWQgdG8gZXhwbGFpbiB5b3Vyc2VsZiBhIGxvdCBtb3JlIGhlcmUgd2hhdCB5b3UncmUgZG9pbmcu
IFdoeQ0KPiB0aG9zZSB0d28gc3BlY2lhbCBjYXNlcyBpZiB5b3UgY2FuIHNpbXBseSBpdGVyYXRl
IG92ZXIgdGhlIGV4dGVuZGVkDQo+IHN0YXRlcyBhbmQgYmUgZG9uZSB3aXRoIGl0PyBFeGNlcHQg
bWF5YmUgdGhlIGZpcnN0IHR3byBzcGVjaWFsIGNhc2VzDQo+IHdoaWNoIGFyZSB0cml2aWFsLi4u
DQoNCnhzdGF0ZV9jb21wX29mZnNldFtdIGNvbWVzIGZyb20gdGhlIGNvbXBhY3RlZCBmb3JtYXQg
d2l0aCB4ZmVhdHVyZXNfbWFza19hbGwuDQpJZiBmZWF0dXJlIGJpdHMgYXJlIGFsbCB0aGUgc2Ft
ZSB1cCB0byDigJhucicsIHRoaXMgcmVjb3JkZWQgb2Zmc2V0IGNhbiBiZSB0YWtlbi4NCg0KQnV0
IGl0IG1pZ2h0IGJlIGJldHRlciB0byBzaW1wbGlmeSB0aGlzIGh1bmsgZm9yIHJlYWRhYmlsaXR5
LiBJIHN1c3BlY3QgaXRzDQpjYWxsIHNpdGVzIGFyZSBub3QgdGhhdCBwZXJmb3JtYW5jZS1jcml0
aWNhbC4NCg0KPj4gQEAgLTg0OCw2ICs5MDgsOSBAQCB2b2lkIF9faW5pdCBmcHVfX2luaXRfc3lz
dGVtX3hzdGF0ZSh2b2lkKQ0KPj4gCWlmIChlcnIpDQo+PiAJCWdvdG8gb3V0X2Rpc2FibGU7DQo+
PiANCj4+ICsJLyogTWFrZSBzdXJlIGluaXRfdGFzayBkb2VzIG5vdCBpbmNsdWRlIHRoZSBkeW5h
bWljIHVzZXIgc3RhdGVzLiAqLw0KPiANCj4gTXkgY29uc3RhbnQgcmV2aWV3IHF1ZXN0aW9uOiB3
aHk/DQoNCkV2ZXJ5IHRhc2vigJlzIHN0YXRlX21hc2sgc2hvdWxkIGJlZ2luIGFzIGFsaWduZWQg
d2l0aCB0aGUgZGVmYXVsdCBidWZmZXIuDQpmcHVfY2xvbmUoKSBzZXRzIHRoaXMgZm9yIGFsbCwg
ZXhjZXB0IGluaXRfdGFzay4NCk1heWJlOg0KICAgIOKAnE1ha2Ugc3VyZSBpbml0X3Rhc2vigJlz
IHN0YXRlX21hc2sgYWxpZ25lZCB3aXRoIGl0cyBfX2RlZmF1bHRfc3RhdGUiDQoNCj4+ICsJY3Vy
cmVudC0+dGhyZWFkLmZwdS5zdGF0ZV9tYXNrID0gKHhmZWF0dXJlc19tYXNrX2FsbCAmIH54ZmVh
dHVyZXNfbWFza191c2VyX2R5bmFtaWMpOw0KDQoNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBhbGxv
Y194c3RhdGVfYnVmZmVyIC0gQWxsb2NhdGUgYSBidWZmZXIgd2l0aCB0aGUgc2l6ZSBjYWxjdWxh
dGVkIGZyb20NCj4gDQo+IFRoaXMgbmFtZSBkb2Vzbid0IGV2ZW4gYmVnaW4gdG8gdGVsbCBtZSB0
aGF0IHRoaXMgZnVuY3Rpb24gZGVhbHMgd2l0aA0KPiBlbmxhcmdpbmcgdGhlIHhzdGF0ZSBidWZm
ZXIgd2l0aCBkeW5hbWljIHN0YXRlcy4gSG93IGlzIHRoZSBjYWxsZXINCj4gc3VwcG9zZWQgdG8g
a25vdz8NCg0KSG93IGFib3V0IGVubGFyZ2VfeHN0YXRlX2J1ZmZlcigpIG9yIHJlYWxsb2NfeHN0
YXRlX2J1ZmZlcigpPw0KDQo+IA0KPiBBbHNvLCB5b3UgbmVlZCB0byBtb3ZlIGFsbCBwb3NzaWJs
ZSB4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMgcXVlcnlpbmcNCj4gaW5zaWRlIGl0IHNvIHRo
YXQgaXRzIHVzZXIgZG9lc24ndCBoYXZlIHRvIGRvIGl0LiBJJ20gbG9va2luZyBhdCB0aGUNCj4g
Y2FsbHNpdGUgaW4geHN0YXRlcmVnc19zZXQoKS4NCg0KVGhlIHF1ZXJ5IGlzIGludGVuZGVkIHRv
IGNoZWNrIHdoZXRoZXIgdGhlIHhzdGF0ZSBidWZmZXIgaXMgZnVsbHkgZXhwYW5kZWQgb3INCm5v
dCAtLSBubyBuZWVkIHRvIGVubGFyZ2UuDQoNCklmIHRoZSBidWZmZXIgaXMgYWxyZWFkeSB0aGUg
bWF4aW11bSwgdGhlIGNvZGUgdG8gcmV0cmlldmUgWFNUQVRFX0JWLCB0aGlzDQpjYWxsLCBldGMg
c2hvdWxkIGJlIHNraXBwZWQgdGhlcmUuICANCg0KSWYgdGhlIHF1ZXJ5IGlzIG1vdmVkIGhlcmUs
IEkgZ3Vlc3MgdGhpcyBjYWxsIHNpdGUgY29kZSBiZWNvbWVzIGEgYml0IHVnbHkuDQoNCj4gVGhl
IG90aGVyIGNhbGxzaXRlIGluIGV4Y19kZXZpY2Vfbm90X2F2YWlsYWJsZSgpIHNlZW1zIHRvIG5v
dCBjaGVjayB0aGUNCj4gZHluYW1pYyBzdGF0ZXMgYnV0IHVzZXMgb25seSBYRkQuIEkgZ3Vlc3Mg
SSdsbCBwYXJzZSB0aGF0IHByb3Blcmx5IHdoZW4NCj4gSSBnZXQgdGhlcmUgYnV0IHJpZ2h0IG5v
dyBJIGhhdmUgbm8gY2x1ZSB3aHkgeW91J3JlIG5vdCBjaGVja2luZyB0aGUNCj4gZHluYW1pYyBt
YXNrIHRoZXJlLg0KDQpJbiB0aGlzIGNhc2UsIEkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gbW92
ZSBpdCBpbiB0aGlzIGZ1bmN0aW9uLiBCdXQgbm90DQpjbGVhciBob3cgd2VsbCBhZGp1c3QgdGhl
IGFib3ZlIGNhc2UgeWV0Lg0KDQo+PiAraW50IGFsbG9jX3hzdGF0ZV9idWZmZXIoc3RydWN0IGZw
dSAqZnB1LCB1NjQgbWFzaykNCj4+ICt7DQo+PiArCXVuaW9uIGZwcmVnc19zdGF0ZSAqc3RhdGU7
DQo+PiArCXVuc2lnbmVkIGludCBvbGRzeiwgbmV3c3o7DQo+PiArCXU2NCBzdGF0ZV9tYXNrOw0K
Pj4gKw0KPj4gKwlzdGF0ZV9tYXNrID0gZnB1LT5zdGF0ZV9tYXNrIHwgbWFzazsNCj4+ICsNCj4+
ICsJb2xkc3ogPSBnZXRfeHN0YXRlX3NpemUoZnB1LT5zdGF0ZV9tYXNrKTsNCj4+ICsJbmV3c3og
PSBnZXRfeHN0YXRlX3NpemUoc3RhdGVfbWFzayk7DQo+PiArDQo+PiArCWlmIChvbGRzeiA+PSBu
ZXdzeikNCj4+ICsJCXJldHVybiAwOw0KPiANCj4gV2h5Pw0KPiANCj4gV2h5IG5vdCBzaW1wbHk6
DQo+IA0KPiAJaWYgKGZwdS0+c3RhdGVfbWFzayA9PSBtYXNrKQ0KPiAJCXJldHVybiAwOw0KPiAN
Cj4gCS8qIHZ6YWxsb2MgKi8NCj4gDQo+IAkvKiBmcmVlIHRoZSBvbGQgYnVmZmVyICovDQo+IAlm
cmVlX3hzdGF0ZV9idWZmZXIoZnB1KTsNCj4gDQo+IAlmcHUtPnN0YXRlID0gc3RhdGU7DQo+IAku
Li4NCj4gDQo+ID8NCj4gDQo+IE91ciBGUFUgY29kZSBpcyBhIG1lc3MgLSB5b3Ugc2hvdWxkIHRy
eSBub3QgdG8gbWFrZSBpdCBhbiBldmVuIGJpZ2dlcg0KPiBvbmUgd2l0aG91dCBhIGdvb2QgcmVh
c29uLg0KDQpPa2F5LCBtYXliZSBnZXRfeHN0YXRlX3NpemUoKSBpcyBvdmVya2lsbC4gQnV0IEkg
dGhpbmsgYSBzYW5pdHktY2hlY2sgbGlrZQ0KdGhpczoNCiAgICBpZiAoKG1hc2sgJiBmcHUtPnN0
YXRlX21hc2spID09IG1hc2spIA0KICAgICAgICByZXR1cm4gMDsgDQoNCj4+ICsNCj4+ICsJc3Rh
dGUgPSB2emFsbG9jKG5ld3N6KTsNCj4+ICsJaWYgKCFzdGF0ZSkgew0KPj4gKwkJLyoNCj4+ICsJ
CSAqIFdoZW4gYWxsb2NhdGlvbiByZXF1ZXN0ZWQgZnJvbSAjTk0sIHRoZSBlcnJvciBjb2RlIG1h
eQ0KPj4gKwkJICogbm90IGJlIHBvcHVsYXRlZCB3ZWxsLiBUaGVuLCB0aGlzIHRyYWNlcG9pbnQg
aXMgdXNlZnVsDQo+PiArCQkgKiBmb3IgcHJvdmlkaW5nIHRoZSBmYWlsdXJlIGNvbnRleHQuDQo+
PiArCQkgKi8NCj4+ICsJCXRyYWNlX3g4Nl9mcHVfeHN0YXRlX2FsbG9jX2ZhaWxlZChmcHUpOw0K
Pj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiBXaGF0IGhhcHBlbnMgd2l0aCB0aGUgb2xkIGJ1
ZmZlciBoZXJlPyBJdCBzZWVtcyB3ZSBsZWFrIGl04oCmDQoNCk5vLCBpdCBpcyBzdGlsbCBwb2lu
dGVkIGJ5IGZwdS0+c3RhdGUgYW5kIHdpbGwgYmUgZnJlZWQgaW4gdGhlIGV4aXQgcGF0aC4NCg0K
VGhhbmtzLA0KQ2hhbmcNCg0KDQo=
