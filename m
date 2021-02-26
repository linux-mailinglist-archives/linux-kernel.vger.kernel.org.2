Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8C325CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBZFBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:01:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:3350 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhBZFBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:01:52 -0500
IronPort-SDR: glmBWjdXDGKkkqOZdH8Zc4anoRqY11xp0FIbz7nOMoWWHB1cQF9akKNKKlhizg1s6UfmobVAiZ
 kg9v9WY8XXMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="165641726"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="165641726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 21:01:09 -0800
IronPort-SDR: MwUHK9Y/FNDbll/XnPZ49GjXvdQWmatbO8ziam9+t6CxyKyRwggiv877l1ZAgxmteTO0Igfd2+
 A3yoEK9AEBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="516384038"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2021 21:01:09 -0800
Received: from bgsmsx602.gar.corp.intel.com (10.109.78.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 21:01:08 -0800
Received: from bgsmsx604.gar.corp.intel.com (10.67.234.6) by
 BGSMSX602.gar.corp.intel.com (10.109.78.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 10:31:06 +0530
Received: from bgsmsx604.gar.corp.intel.com ([10.67.234.6]) by
 BGSMSX604.gar.corp.intel.com ([10.67.234.6]) with mapi id 15.01.2106.002;
 Fri, 26 Feb 2021 10:31:06 +0530
From:   "Gupta, Anshuman" <anshuman.gupta@intel.com>
To:     Colin King <colin.king@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drm/i915/hdcp: Fix null pointer dereference of
 connector->encoder
Thread-Topic: [PATCH][next] drm/i915/hdcp: Fix null pointer dereference of
 connector->encoder
Thread-Index: AQHXChjJmIv7gDW21UG5hJXtQsGn1Kpp5AuQ
Date:   Fri, 26 Feb 2021 05:01:06 +0000
Message-ID: <acbf924a09544030966f95c750b1bfa7@intel.com>
References: <20210223191909.16682-1-colin.king@canonical.com>
In-Reply-To: <20210223191909.16682-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.223.10.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAy
MDIxIDEyOjQ5IEFNDQo+IFRvOiBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFAbGludXguaW50ZWwu
Y29tPjsgSm9vbmFzIExhaHRpbmVuDQo+IDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwuY29t
PjsgVml2aSwgUm9kcmlnbyA8cm9kcmlnby52aXZpQGludGVsLmNvbT47DQo+IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IEMs
IFJhbWFsaW5nYW0NCj4gPHJhbWFsaW5nYW0uY0BpbnRlbC5jb20+OyBHdXB0YSwgQW5zaHVtYW4g
PGFuc2h1bWFuLmd1cHRhQGludGVsLmNvbT47DQo+IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5p
dG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIXVtuZXh0XSBkcm0vaTkxNS9oZGNwOiBGaXggbnVsbCBwb2ludGVyIGRlcmVm
ZXJlbmNlIG9mDQo+IGNvbm5lY3Rvci0+ZW5jb2Rlcg0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZSByZWNlbnQgY29tbWl0IDZj
NjNlNmUxNGRhNyAoImRybS9pOTE1L2hkY3A6IE5vIEhEQ1Agd2hlbiBlbmNvZGVyIGlzJ3QNCj4g
aW5pdGlhbGl6ZWQiKSBhZGRlZCBhIG51bGwgcG9pbnRlciBjaGVjayBvbiBjb25uZWN0b3ItPmVu
Y29kZXIgaGVuY2UgaW1wbHlpbmcNCj4gdGhhdCBpdCBjb3VsZCBwb3RlbnRpYWxseSBiZSBudWxs
LiAgVGhpcyBtZWFucyB0aGF0IHRoZSBpbml0aWFsaXphdGlvbiBvZiBkaWdfcG9ydCB2aWENCj4g
dGhlIGNhbGwgaW50ZWxfYXR0YWNoZWRfZGlnX3BvcnQgbWF5IGNhdXNlIGEgbnVsbCBwb2ludGVy
IGRlcmVmZXJlbmNlIG9uDQo+IGNvbm5lY3Rvci0+ZW5jb2Rlci4gRml4IHRoaXMgYnkgb25seSBh
c3NpZ25pbmcgZGlnX3BvcnQgYWZ0ZXIgYSBudWxsIGNoZWNrIGhhcw0KPiBiZWVuIHBlcmZvcm1l
ZCBvbiBjb25uZWN0b3ItPmVuY29kZXIuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiRGVy
ZWZlcmVuY2UgYmVmb3JlIG51bGwgY2hlY2siKQ0KPiBGaXhlczogMzZlNWU3MDQyYjIwICgiZHJt
L2k5MTU6IERvbid0IGZ1bGx5IGRpc2FibGUgSERDUCBvbiBhIHBvcnQgaWYgbXVsdGlwbGUNCj4g
cGlwZXMgYXJlIHVzaW5nIGl0IikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNv
bGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCkxvb2tzIGdvb2QgdG8gbWUuDQpSZXZpZXdlZC1ieTog
QW5zaHVtYW4gR3VwdGEgPGFuc2h1bWFuLmd1cHRhQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2hkY3AuYyB8IDMgKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9oZGNwLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2hkY3AuYw0KPiBpbmRleCBhZTEzNzFjMzZhMzIu
Ljc1MjVlYTMxNzY2YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9oZGNwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9oZGNwLmMNCj4gQEAgLTIyNjAsNyArMjI2MCw3IEBAIGludCBpbnRlbF9oZGNwX2VuYWJsZShz
dHJ1Y3QgaW50ZWxfY29ubmVjdG9yDQo+ICpjb25uZWN0b3IsDQo+ICAJCSAgICAgIGNvbnN0IHN0
cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpwaXBlX2NvbmZpZywgdTggY29udGVudF90eXBlKQ0KPiB7
DQo+ICAJc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmRldl9wcml2ID0gdG9faTkxNShjb25uZWN0
b3ItPmJhc2UuZGV2KTsNCj4gLQlzdHJ1Y3QgaW50ZWxfZGlnaXRhbF9wb3J0ICpkaWdfcG9ydCA9
DQo+IGludGVsX2F0dGFjaGVkX2RpZ19wb3J0KGNvbm5lY3Rvcik7DQo+ICsJc3RydWN0IGludGVs
X2RpZ2l0YWxfcG9ydCAqZGlnX3BvcnQ7DQo+ICAJc3RydWN0IGludGVsX2hkY3AgKmhkY3AgPSAm
Y29ubmVjdG9yLT5oZGNwOw0KPiAgCXVuc2lnbmVkIGxvbmcgY2hlY2tfbGlua19pbnRlcnZhbCA9
IERSTV9IRENQX0NIRUNLX1BFUklPRF9NUzsNCj4gIAlpbnQgcmV0ID0gLUVJTlZBTDsNCj4gQEAg
LTIyNzQsNiArMjI3NCw3IEBAIGludCBpbnRlbF9oZGNwX2VuYWJsZShzdHJ1Y3QgaW50ZWxfY29u
bmVjdG9yDQo+ICpjb25uZWN0b3IsDQo+ICAJCXJldHVybiAtRU5PREVWOw0KPiAgCX0NCj4gDQo+
ICsJZGlnX3BvcnQgPSBpbnRlbF9hdHRhY2hlZF9kaWdfcG9ydChjb25uZWN0b3IpOw0KPiAgCW11
dGV4X2xvY2soJmhkY3AtPm11dGV4KTsNCj4gIAltdXRleF9sb2NrKCZkaWdfcG9ydC0+aGRjcF9t
dXRleCk7DQo+ICAJZHJtX1dBUk5fT04oJmRldl9wcml2LT5kcm0sDQo+IC0tDQo+IDIuMzAuMA0K
DQo=
