Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043A3EBA01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhHMQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:27:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhHMQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:27:02 -0400
X-UUID: 594c94b2845b4de4bdda7d6b30014193-20210814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Fmj94kKyC76Gj81A4sW5VrTf4W9B0Rq9Rw24Ubfs3gM=;
        b=S1VOwjNkPlVY6mejB+yaaXSL8JW7YUYOvnHM2yjrTkyDxoXt2sS+WbuiWuHOzIT8DSrrUcBcMmgL/sZaUEkIN1mGTLzLdT3Vnu0qk1kwMHcacYJLdfU6kTyaohsmbOH/JSlnyyYAs8YfWCHtaLx58UqvLxS1XCGQfaMJ4MSsGLI=;
X-UUID: 594c94b2845b4de4bdda7d6b30014193-20210814
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1734543056; Sat, 14 Aug 2021 00:26:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 14 Aug 2021 00:26:18 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 14 Aug 2021 00:26:13 +0800
Message-ID: <3c120b7278481229031c02bf140901738bffcbb8.camel@mediatek.com>
Subject: Re: drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:41:
 warning: passing argument 1 of 'thermal_cooling_device_register' discards
 'const' qualifier from pointer target type
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Sat, 14 Aug 2021 00:26:13 +0800
In-Reply-To: <202108131536.fI3monk1-lkp@intel.com>
References: <202108131536.fI3monk1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTEzIGF0IDE1OjE5ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgUnlkZXIsDQo+IA0KPiBGWUksIHRoZSBlcnJvci93YXJuaW5nIHN0aWxsIHJlbWFp
bnMuDQo+IA0KPiB0cmVlOiAgIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0X187ISFDVFJOS0E5d01nMEFSYnchMXlHaHlaMnpjZ0RTQVpJbnlGQ3BUV1FxN3dtMEtLN013
b1lXS0VNRV9EcmF5ZmNZZnhoNGk5ZG51ZlZOOUMtYyQNCj4gICBtYXN0ZXINCj4gaGVhZDogICBm
OGU2ZGZjNjRmNjEzNWQxYjZjNTIxNWMxNGNkMzBiOWI2MGEwMDA4DQo+IGNvbW1pdDogMzRiODc3
ZDk3MmJlYzhjYmYzOTdhNTczOTMzMTc2NzJjZjkyOTk2ZiBtdDc2OiBtdDc5MTU6IGFkZA0KPiB0
aGVybWFsIGNvb2xpbmcgZGV2aWNlIHN1cHBvcnQNCj4gZGF0ZTogICA4IHdlZWtzIGFnbw0KPiBj
b25maWc6IHg4Nl82NC1idWlsZG9ubHktcmFuZGNvbmZpZy1yMDAxLTIwMjEwODEyIChhdHRhY2hl
ZCBhcw0KPiAuY29uZmlnKQ0KPiBjb21waWxlcjogZ2NjLTkgKERlYmlhbiA5LjMuMC0yMikgOS4z
LjANCj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gICAgICAgICAjIA0KPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MzRiODc3ZDk3
MmJlYzhjYmYzOTdhNTczOTMzMTc2NzJjZjkyOTk2Zl9fOyEhQ1RSTktBOXdNZzBBUmJ3ITF5R2h5
WjJ6Y2dEU0FaSW55RkNwVFdRcTd3bTBLSzdNd29ZV0tFTUVfRHJheWZjWWZ4aDRpOWRudWVZbG1q
ZEskDQo+ICANCj4gICAgICAgICBnaXQgcmVtb3RlIGFkZCBsaW51cyANCj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdF9fOyEhQ1RSTktBOXdNZzBBUmJ3ITF5R2h5WjJ6Y2dE
U0FaSW55RkNwVFdRcTd3bTBLSzdNd29ZV0tFTUVfRHJheWZjWWZ4aDRpOWRudWZWTjlDLWMkDQo+
ICANCj4gICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnVzIG1hc3Rlcg0KPiAgICAgICAg
IGdpdCBjaGVja291dCAzNGI4NzdkOTcyYmVjOGNiZjM5N2E1NzM5MzMxNzY3MmNmOTI5OTZmDQo+
ICAgICAgICAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1aWxkIHRyZWUN
Cj4gICAgICAgICBtYWtlIFc9MSBBUkNIPXg4Nl82NCANCj4gDQo+IElmIHlvdSBmaXggdGhlIGlz
c3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcgYXMgYXBwcm9wcmlhdGUNCj4gUmVwb3J0ZWQt
Ynk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gQWxsIHdhcm5pbmdz
IChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+IA0KPiAgICBkcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmM6IEluIGZ1bmN0aW9uDQo+ICdtdDc5MTVfdGhl
cm1hbF9pbml0JzoNCj4gPiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L2luaXQuYzoxMzQ6NDE6IHdhcm5pbmc6DQo+ID4gPiBwYXNzaW5nIGFyZ3VtZW50IDEgb2Yg
J3RoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXInIGRpc2NhcmRzDQo+ID4gPiAnY29uc3Qn
IHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLQ0KPiA+ID4g
cXVhbGlmaWVyc10NCj4gDQo+ICAgICAgMTM0IHwgIGNkZXYgPSB0aGVybWFsX2Nvb2xpbmdfZGV2
aWNlX3JlZ2lzdGVyKHdpcGh5X25hbWUod2lwaHkpLA0KPiBwaHksDQo+ICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+DQo+
ICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkxNS9pbml0LmM6NzoNCj4gICAgaW5jbHVkZS9saW51eC90aGVybWFsLmg6NDA3
OjM5OiBub3RlOiBleHBlY3RlZCAnY2hhciAqJyBidXQNCj4gYXJndW1lbnQgaXMgb2YgdHlwZSAn
Y29uc3QgY2hhciAqJw0KPiAgICAgIDQwNyB8IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0
ZXIoY2hhciAqdHlwZSwgdm9pZCAqZGV2ZGF0YSwNCj4gICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH5+fn5+fl5+fn4NCj4gDQo+IA0KPiB2aW0gKzEzNCBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gDQo+ICAgIDEyNwkN
Cj4gICAgMTI4CXN0YXRpYyBpbnQgbXQ3OTE1X3RoZXJtYWxfaW5pdChzdHJ1Y3QgbXQ3OTE1X3Bo
eSAqcGh5KQ0KPiAgICAxMjkJew0KPiAgICAxMzAJCXN0cnVjdCB3aXBoeSAqd2lwaHkgPSBwaHkt
Pm10NzYtPmh3LT53aXBoeTsNCj4gICAgMTMxCQlzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2Rldmlj
ZSAqY2RldjsNCj4gICAgMTMyCQlzdHJ1Y3QgZGV2aWNlICpod21vbjsNCj4gICAgMTMzCQ0KPiAg
PiAxMzQJCWNkZXYgPQ0KPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVyKHdpcGh5X25h
bWUod2lwaHkpLCBwaHksDQo+ICAgIDEzNQkJCQkJCSAgICAgICAmbXQ3OTE1Xw0KPiB0aGVybWFs
X29wcyk7DQo+ICAgIDEzNgkJaWYgKCFJU19FUlIoY2RldikpIHsNCj4gICAgMTM3CQkJaWYgKHN5
c2ZzX2NyZWF0ZV9saW5rKCZ3aXBoeS0+ZGV2LmtvYmosIA0KPiAmY2Rldi0+ZGV2aWNlLmtvYmos
DQo+ICAgIDEzOAkJCQkJICAgICAgImNvb2xpbmdfZGV2aWNlIikNCj4gPCAwKQ0KPiAgICAxMzkJ
CQkJdGhlcm1hbF9jb29saW5nX2RldmljZV91bnJlZ2lzdA0KPiBlcihjZGV2KTsNCj4gICAgMTQw
CQkJZWxzZQ0KPiAgICAxNDEJCQkJcGh5LT5jZGV2ID0gY2RldjsNCj4gICAgMTQyCQl9DQo+ICAg
IDE0MwkNCj4gICAgMTQ0CQlpZiAoIUlTX1JFQUNIQUJMRShDT05GSUdfSFdNT04pKQ0KPiAgICAx
NDUJCQlyZXR1cm4gMDsNCj4gICAgMTQ2CQ0KPiAgICAxNDcJCWh3bW9uID0NCj4gZGV2bV9od21v
bl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9ncm91cHMoJndpcGh5LT5kZXYsDQo+ICAgIDE0OAkJCQkJ
CQkgICAgICAgDQo+IHdpcGh5X25hbWUod2lwaHkpLCBwaHksDQo+ICAgIDE0OQkJCQkJCQkgICAg
ICAgDQo+IG10NzkxNV9od21vbl9ncm91cHMpOw0KPiAgICAxNTAJCWlmIChJU19FUlIoaHdtb24p
KQ0KPiAgICAxNTEJCQlyZXR1cm4gUFRSX0VSUihod21vbik7DQo+ICAgIDE1MgkNCj4gICAgMTUz
CQlyZXR1cm4gMDsNCj4gICAgMTU0CX0NCj4gICAgMTU1CQ0KPiANCj4gLS0tDQo+IDAtREFZIENJ
IEtlcm5lbCBUZXN0IFNlcnZpY2UsIEludGVsIENvcnBvcmF0aW9uDQo+IA0KaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVya2l0dHkvbGlzdC9rYnVp
bGQtYWxsQGxpc3RzLjAxLm9yZ19fOyEhQ1RSTktBOXdNZzBBUmJ3ITF5R2h5WjJ6Y2dEU0FaSW55
RkNwVFdRcTd3bTBLSzdNd29ZV0tFTUVfRHJheWZjWWZ4aDRpOWRudVY5RGIzaGQkDQoNClRoZSBj
YXVzZSBpcyANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQUJEQUZDQUItOERGNS00MUE3
LUIxRTAtNDk1M0E5QkYzMkIzQGdtYWlsLmNvbS9ULw0KDQo=

