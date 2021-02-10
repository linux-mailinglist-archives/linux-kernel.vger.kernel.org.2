Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C1316A06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBJPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:22:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29723 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231148AbhBJPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:22:36 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-58-L71bTu5bMWebATKm9fU25g-1; Wed, 10 Feb 2021 15:20:56 +0000
X-MC-Unique: L71bTu5bMWebATKm9fU25g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 10 Feb 2021 15:20:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 10 Feb 2021 15:20:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Garry' <john.garry@huawei.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "agerstmayr@redhat.com" <agerstmayr@redhat.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
Thread-Topic: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
Thread-Index: AQHW/5FHSHrwOv69RUGxaBJbWYvOE6pRgM3Q
Date:   Wed, 10 Feb 2021 15:20:53 +0000
Message-ID: <a2eb2a9066254093b50c3ed87171b902@AcuMS.aculab.com>
References: <20210210032447.2248255-1-Jianlin.Lv@arm.com>
 <5db96a5f-3749-7f54-15ce-27b932bcbca6@huawei.com>
In-Reply-To: <5db96a5f-3749-7f54-15ce-27b932bcbca6@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4gQEAgLTY5MSw2ICs2OTEsNyBAQCBzdGF0aWMgaW50IHJlZ3NfbWFwKHN0cnVjdCBy
ZWdzX2R1bXAgKnJlZ3MsIHVpbnQ2NF90IG1hc2ssIGNoYXIgKmJmLCBpbnQgc2l6ZSkNCj4gPiAg
IHsNCj4gPiAgIAl1bnNpZ25lZCBpbnQgaSA9IDAsIHI7DQo+ID4gICAJaW50IHByaW50ZWQgPSAw
Ow0KPiA+ICsJY29uc3QgY2hhciAqcmVnX25hbWU7DQo+ID4NCj4gPiAgIAliZlswXSA9IDA7DQo+
ID4NCj4gPiBAQCAtNzAwLDkgKzcwMSwxMCBAQCBzdGF0aWMgaW50IHJlZ3NfbWFwKHN0cnVjdCBy
ZWdzX2R1bXAgKnJlZ3MsIHVpbnQ2NF90IG1hc2ssIGNoYXIgKmJmLCBpbnQgc2l6ZSkNCj4gPiAg
IAlmb3JfZWFjaF9zZXRfYml0KHIsICh1bnNpZ25lZCBsb25nICopICZtYXNrLCBzaXplb2YobWFz
aykgKiA4KSB7DQo+IA0KPiBhIGdvb2QgcHJhY3RpY2UgaXMgdG8gbGltaXQgc2NvcGUgb2YgdmFy
aWFibGVzIGFzIG11Y2ggYXMgcG9zc2libGUsIHNvDQo+IHJlZ19uYW1lIGNvdWxkIGJlIGRlY2xh
cmVkIGhlcmUNCg0KSSdkIGdvIGZvciBlaXRoZXIgZnVuY3Rpb24gc2NvcGUgb3IgYSB2ZXJ5IHNt
YWxsIGlubmVyIGJsb2NrDQoobGlrZSB0aGlzIG9uZSkuDQoNCk90aGVyd2lzZSBpdCBnZXRzIHZl
cnkgZGlmZmljdWx0IGZvciB0aGUgYXZlcmFnZSBodW1hbiAob3Igb3RoZXINCmludGVsbGlnZW50
IGJlaW5nKSB0byBsb2NhdGUgdGhlIGRlZmluaXRpb24uDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

