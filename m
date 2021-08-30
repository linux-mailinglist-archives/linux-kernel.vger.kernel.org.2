Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B963FBF81
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhH3Xk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:40:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:53172 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239087AbhH3Xk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:40:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218379546"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218379546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 16:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="466277515"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2021 16:40:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:40:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:40:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 30 Aug 2021 16:40:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 30 Aug 2021 16:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TexwxYwlg2Fvv8C+WA27Z0gvh+mz9bqj0jkRra+mznKgbItGMztOdZoVQ47JydoCrDKS91ZeyEhHUskps+yHv7dvNXCU1++Tln5YTQNOSNDVhGSgshf6UEa3EqJUNBY11WDrl62VLBarmy7o+yRDX3ydhLr1eQn9d518F7sHsDgA3lSP0EWku3+hC+3Uqb3JY4ZCcGbuxKlasR5D5ETkATIYG8rPDDfx+IIERcUcJjdQCGRxwWpChcJu93dEUBchh7COdKXuq5nk6kWqAftu8wgTI0iTP5NOZ7oLl3ydYNblfa6KAmSFVBPINZnJc/jQjsZboQuXRWtNyMFzcUW+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/LETG9Wj8eTvA8lOsxSFRnD6UQBJDE0OjgvdpylESE=;
 b=lztNRiCzSt3JPRSIonZrKxvX4gEGjSpXTLg8so4D/e2BY4sU9U5vx/H9eqmLvxQAc5gb5meWe7Ipa9whpdMAwrcGfMVV4b2kiUhsh35RTWFIPZ1c7BxVm9q91BqOo+QF12RSmgHznH5y0RZSJht0g0uevS8CFU5LYMbaO4iANhBrJgDJPkJQzo3pIbFNktSaGGajAfioiJm5F7JwrvGO/Ee5lDiocnh93T95l21yPktErxEKb25+8CppBOk494Fiz3wxGFIqfdAb1YgAYw5aEnfsocZb7rnFuMpFMJkOVknIPxM5xqbt44VRZgiehT49RPB+CpzEyfi/nUCznYzrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/LETG9Wj8eTvA8lOsxSFRnD6UQBJDE0OjgvdpylESE=;
 b=mpD1B099XBQT25DlFVJcNIkHHu2f8b+wLc5I9SFJV8/fYjA/JFquPFjsBbgjbC0RvGY5gOZNLh7Htwde5CAAIG91TfDMnU6nAzJNi9IeDv9AbHxVK31TmwwkYsM7qHJSaWR0rmxBXw8Hv9Cs+ftGXt6k0xJK6j9E0shXa6QbpdQ=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 23:39:58 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 23:39:58 +0000
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
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgADOwYCAACF+gIAAoc+AgAcvswCAAKzPAIASr2GAgABttoA=
Date:   Mon, 30 Aug 2021 23:39:58 +0000
Message-ID: <BB6FB28C-F350-4C3E-BFCA-EBA4384918F6@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com> <YRZDu2Rk+KdRhh1U@zn.tnic>
 <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com> <YRzSuC25eHEOgj6h@zn.tnic>
 <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com> <YS0QRWjuqh9ZzIGE@zn.tnic>
In-Reply-To: <YS0QRWjuqh9ZzIGE@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4185ea-253a-4694-4f1e-08d96c0f7a8b
x-ms-traffictypediagnostic: PH0PR11MB5077:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5077E760C7CEBAD8BE6EAE4CD8CB9@PH0PR11MB5077.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SHI0gOaXr23IPkdj18oHkGzdp3oFs1eU8ykl6zz0nRGrE8/7PWn+kIppkaPQeDp/bbCdqrp0B3FM7Ege3oPWQpkDDIV557IsozKdynyC8Fm4wUlCyDqsL+FLHHtZwKf1fMJTU1L6KSoO3V3LQQ8igf+NGjdlJ+s6DA/YRQg3Ot1TLTXr0K6mSqlfBdZkJ8QxQB2cvQ2YSxYilauuwLTaly4v+7ZXvWejGz6+LPR+/0ou0GvZ01KsAEO6YstmfhOo34x4DPV+L1v3rlq3hrDn7PVMnU5HisCj5++1pdyVKYoYNEQu7FpFnFOQLMZx7IXPjXKeGUHO5hUYNE5XzKcRoFE81sg9H+6BhGaN5F96b+1s2gm9ko/HXHMPdr2OTUQYYeG/xgezjj94Ot2r3JlojAVrecqCssjUBxQCh1z1ONlYnBgyOiQZ2AGT18hqOgotfX+E8c4Qq/Yfzh8qy71pk+kN7CZlWNav87i/Ng6fTSq8PVpD9Tbo0Wuviej9O8PIaG5QroKwvNxyvj1RD5++/ULBT3I8MAdyhTYAOcldG+qpiCUzmqKgMpsnBWTq27GTysAM0zVmum5lJ8gbPDmv6fv34ZDe3wpDaiDvJv4BWO8WX0LGcBjq/viBp+NxzkW8H4ORwH9p+KboFP+5TnDjpyKWWFUlwDqbE8hXL+b2T1+vP0t61bPO+3Es0yrCAV+eA8KdIiNiCdnlFQ5qEC/n7D4+L8rj1oMZGU6zcXr9kBMjPh7FlMOHOvXGIa6/h0STVBQKKGDGlyojMFBoYCp0IP6b3dtQjoCjx2ZB1uiSR6vXmudVZxeFWP+Fjy7z86H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(71200400001)(966005)(66556008)(66446008)(5660300002)(38070700005)(2906002)(6506007)(64756008)(53546011)(54906003)(8936002)(6486002)(76116006)(38100700002)(316002)(122000001)(8676002)(6512007)(4326008)(66476007)(36756003)(2616005)(26005)(33656002)(6916009)(86362001)(186003)(478600001)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0FUSUpRUGYzbHpkK2dveUVBUWxtejIrL1NPUEQvTnl4aGVySm5ubzVUaXZP?=
 =?utf-8?B?anZqdFJxSVF6bzZYRTR6NmptZUtsQTFQUjI5QUdvWGl2Vi8vWjk3T29xSjNJ?=
 =?utf-8?B?VzVYTFZYVmtEWnRNQWpUS2tjcUxhVjhxWmdCNzVwNzBWR3BVN2pRQzI1ZjRM?=
 =?utf-8?B?NU5lbUJlR1BJYXp6TE9Yd1BpZUxxVEFqK1VjU3czS1Q4bnAyS3ZCQ1p1MnJx?=
 =?utf-8?B?QWxoSEY4T1FGTUVBWVFmL295QVljWTM2eWxTaHc0U2dlOGRsWHVVczViM2pR?=
 =?utf-8?B?QWxTMHZwL2hBUXZOVnhOSWxucEt3VmdvWDBQTFZqTmFmWTYzTjRabUZ2d2p5?=
 =?utf-8?B?MVRNTGlzSlNXUEF5bG5MWlI5WlBTaWxkQVYzWnFBUUR5OFVyOWhLUjhNNUtF?=
 =?utf-8?B?OEtkc1RHN1NHeEtzSXhSRlJCTmg2Qks0STNQbEN0TlphYzdBOURtRGNoQU1w?=
 =?utf-8?B?K0tSenpDanRPUExvSklsaFpFcWZJZjh1bTY5Z0twL0EwdS9CdmI4S0hQdXg2?=
 =?utf-8?B?c216dXk1blJLSS9RUUdpRXozQ0tpYTFRdnk1TnUxak5DczRseHpaa1JzWnJJ?=
 =?utf-8?B?ejd4dnlsMExSYmkwVU5DRG1vL2hVOUxQT0U3WjYva0N1WUczWDFpWEdYV1Ux?=
 =?utf-8?B?MGJFTlcreCtxRmt0cEhVYVR4MlkrclMxZ090UVF6NDdCWkw0QkJEeTl1cU9E?=
 =?utf-8?B?cHVqZlJoLzFGSTlOb0huc0tFSzJsQjdMRyt6amovZExLcFVTZitMYVJhREcw?=
 =?utf-8?B?K0ZrTytTK3FZRXE3Mm9UbHdPRVpUSk1YVjljQXVjcHFTR1FFQ2RMZEF1bVZB?=
 =?utf-8?B?RTEvLzFzWFJueUYzcThVbUdqbGVzTTFRUDcyYW9TNDduSTdxQ3FNMEx6d0hM?=
 =?utf-8?B?Q1lDeEdQMnlCRS9GUVozcHZRcnZTOS9iQ2crNU5GTHlqc0grUjNVQTlsU0Rp?=
 =?utf-8?B?THA4QnROU0NrTk1sQVhDOVgzSkF1NXM1eGJJMVcwUjBjeWVnRkYxTGZ4b3VI?=
 =?utf-8?B?L1RpTGRsdEs3WW5rZHlmQnd1MVFMMllTSjFrTWM3bG9FaXFwdzAySEJUVG14?=
 =?utf-8?B?bjFPWTRvRzFKYW5rRjc2Mm9LNkN1c0hJbVp1L0hHWGNvdVd6RnVzL1BpYVB5?=
 =?utf-8?B?NlBPRkM5dkJ4bkMxdzhwV3MxSUpwUnZSekUvQ0pvdkYyeUJSTHBGS0NuTUd6?=
 =?utf-8?B?TUVvTE4zTmtrNUpUc0ZNUWYvOTNuV2R0ZXZ3aEtBZnQyL1hjeVB5cTNJMElQ?=
 =?utf-8?B?UUFwMXQvUys2UnEwQWg2Vlh6TzhYZ1JpUjhYTm1LSi9iK2N5WVB2NFVvWjFs?=
 =?utf-8?B?MXpsanZpQzlFSFIrY01WZ0hzYnozZmJEOGZ5NzNYMUYvNFJWVG15TGtkb1Zp?=
 =?utf-8?B?ekJJMHYvZzhHdGxOV0ZQRkxSc1VidVV2cG9Xdi9rYVltUjdLQXF3YmFLK1lx?=
 =?utf-8?B?dVNsNDRvUDRYQ25mOHJ5VVk3emR1SGJqZXpnU3B1RkVDLzhzaXgzTm1TMzNk?=
 =?utf-8?B?OHFLRjQ5SURacjBSUzA5NE55UjBoMlgveXhBTHQ5elpGRi80N0pXSFgrd1U3?=
 =?utf-8?B?ZVByN3U3OGdhR3NCeDNHc3RNdEN2QWwvWlh1TkcrRHVnR0RjZnhpQnhCRFd4?=
 =?utf-8?B?UGJYZUVITWtkcjRoZ1ZoaHcvRXlZdnZlWkRMZ0tsNTJBcEJqQkdBaDV1SEdK?=
 =?utf-8?B?ODNVOVhROFFNaHJyYS9jZzBKL2ZUcWhDbDRoRGFHeXhBZnVVN1ZFT3FjSFdW?=
 =?utf-8?Q?GeyDMHNtDkO5lXTqamIU+ll7tAiUiRU9wmvosYx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE11631E4628842AD321952D08CE05E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4185ea-253a-4694-4f1e-08d96c0f7a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 23:39:58.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LI3dHPPNAwlMxbghSYZI7hhzpX6WKiRLgJZzS3uaorhbKFRLloXFvheuaj9fdKJHbkLgyQ4pOxzFlnL41OYtrW/IgzAP6kaZkxPW0Ngm5hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDMwLCAyMDIxLCBhdCAxMDowNywgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAwNzo0Njo1NVBNICswMDAwLCBCYWUs
IENoYW5nIFNlb2sgd3JvdGU6DQo+PiBObywgdGhpcyBub24tY29tcGFjdGVkIHRoaW5nIGlzIG5v
dCBmb3Igb3B0aW1pemF0aW9uLiBTRE0gaXMgbm90IHF1aXRlIGNsZWFyDQo+PiBhYm91dCB0aGUg
bG9naWMgYmVoaW5kIHRoZSBub24tY29tcGFjdGVkIGZvcm1hdCAtLSBzb21lIHN0YXRl4oCZcyBv
ZmZzZXQgZG9lcw0KPj4gbm90IGFsd2F5cyBtYXRjaCB3aXRoIHRoZSAnc2l6ZSArIG9mZnNldCcg
b2YgdGhlIHByZXZpb3VzIG9uZSwgZXZlbiB3aXRob3V0DQo+PiA2NEItYWxpZ25tZW50LiBTbywg
dGhlIGxvb3AgaXMgb25seSBmb3IgdGhlIGNvbXBhY3RlZCBmb3JtYXQsIG5vdCB0aGUNCj4+IG5v
bi1jb21wYWN0ZWQgb25lLiANCj4+IA0KPj4gSXQgd2FzIHJlZmFjdG9yZWQgdG8gdXNlIGluIHRo
ZSBuZXcgaGVscGVyIHRvIGZpbmQgZmVhdHVyZV9ucuKAmXMgc3RhcnQgcG9pbnQuDQo+PiBJZiB0
aGUgc2l6ZSBpcyBhZGRlZCB1cCBoZXJlLCBpdCBpcyBub3Qg4oCYaeKAmSdzIHN0YXJ0IHBvaW50
IGFueW1vcmUuDQo+IA0KPiBMZXQncyBzZWUsIHdlJ3JlIHN0aWxsIHRhbGtpbmcgYWJvdXQgdGhp
cyB0aGluZywgcmlnaHQ6DQo+IA0KPiAgICAgICAgbnIgPSBmbHM2NChtYXNrKSAtIDE7DQo+IA0K
PiAgICAgICAgaWYgKCFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfWFNBVkVTKSkNCj4gICAgICAg
ICAgICAgICAgcmV0dXJuIHhzdGF0ZV9vZmZzZXRzW25yXSArIHhzdGF0ZV9zaXplc1tucl07DQo+
IA0KPiA/DQo+IA0KPiBUaGF0IEBtYXNrIGlzICJ3aGljaCBjb21wb25lbnRzIHJlc2VydmVkIGlu
IHRoZSBidWZmZXIuIg0KPiANCj4gV2hpY2ggYnVmZmVyPyBUaGUgbWFzayBiZWluZyBwYXNzZWQg
aXMgaW5kZXBlbmRlbnQgZnJvbSB3aGF0ZXZlciBidWZmZXIuDQo+IA0KPiBTbyB5b3UgbmVlZCB0
byBkbyBhIGxvdCBtb3JlIGV4cGxhaW5pbmcgaGVyZSBiZWZvcmUgdGhpcyBnb2VzIGFueXdoZXJl
Lg0KDQpZZXMsIHRoaXMgZnVuY3Rpb24gdGhhdCB5b3Ugc3VnZ2VzdGVkIHRvIHJlbmFtZSBsaWtl
IA0KY2FsY3VsYXRlX3hzdGF0ZV9idWZfc2l6ZV9mcm9tX21hc2soKSBoYXMgbm8gaW5wdXQgdG8g
ZG8gd2l0aCBhbnkgYnVmZmVyLg0KDQpQZXJoYXBzLCBhcyBEYXZlIHN1Z2dlc3RlZCBbMV0sDQog
ICAgIkBtYXNrCQlUaGUgc2V0IG9mIGNvbXBvbmVudHMgZm9yIHdoaWNoIHRoZSBzcGFjZSBpcyBu
ZWVkZWQuIg0KDQpBbG9uZyB3aXRoIHRoZXNlLA0KICAgICJjYWxjdWxhdGVfeHN0YXRlX2J1Zl9z
aXplX2Zyb21fbWFzayAtLSBDYWxjdWxhdGUgdGhlIGFtb3VudCBvZiBzcGFjZQ0KICAgICBuZWVk
ZWQgdG8gc3RvcmUgYW4geHN0YXRlIGJ1ZmZlciB3aXRoIHRoZSBnaXZlbiBmZWF0dXJlcy7igJ0N
Cg0KICAgIHMvbnIvbGFzdF9mZWF0dXJlX25yLw0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvYmI0OWZkYzktMjIyOC04YmQxLWJjYzUtN2M0OThkYWYwODg3QGludGVsLmNvbS8N
Cg0KVGhhbmtzLA0KQ2hhbmc=
