Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095413088F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 13:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhA2MOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 07:14:01 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232308AbhA2MF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 07:05:58 -0500
X-UUID: 7c0016b7855c4e9f92a32cf201cd6bdd-20210129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CLobLn6bICgFMKKKwjHAF6jHqoEhPtYplivFdZU9Cuo=;
        b=tUz0C18Qqo50VIU3GouO3nXqmzL1YNxF6nXELK2PH4mPlCN+KEfE2n1tNafUERoKy/W3RJcsCJt+VVDJ1eaFwfUb3NOGzRgjgBKDMUppBLWZ4Tye6oBGTcJc+VRvVzhNJ2iXErSBFpVIeWy0neiHoKreIPWamlGAjF67Iff2Nkg=;
X-UUID: 7c0016b7855c4e9f92a32cf201cd6bdd-20210129
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 128826079; Fri, 29 Jan 2021 16:21:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 16:21:40 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 16:21:40 +0800
Message-ID: <1611908500.31184.6.camel@mtksdaap41>
Subject: Re: [PATCH v4 4/8] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for
 multi-layer usecase
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Fri, 29 Jan 2021 16:21:40 +0800
In-Reply-To: <20210129073436.2429834-5-hsinyi@chromium.org>
References: <20210129073436.2429834-1-hsinyi@chromium.org>
         <20210129073436.2429834-5-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9B9506A6240F53003C89395367A3003479BD04D05EB24A63E0EEDC54AE4EC96B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIEZyaSwgMjAyMS0wMS0yOSBhdCAxNTozNCArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IGVuYWJsZSBPVkxfTEFZRVJfU01JX0lEX0VOIGZvciBtdWx0aS1sYXll
ciB1c2VjYXNlLCB3aXRob3V0IHRoaXMgcGF0Y2gsDQo+IG92bCB3aWxsIGhhbmcgdXAgd2hlbiBt
b3JlIHRoYW4gMSBsYXllciBlbmFibGVkLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3Fp
YW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNp
bnlpQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMgfCAxNyArKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMNCj4gaW5kZXggZGE3ZTM4YTI4NzU5Yi4uOTYxZjg3ZjhkNGQxNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtMjQsNiArMjQsNyBAQA0KPiAg
I2RlZmluZSBESVNQX1JFR19PVkxfUlNUCQkJMHgwMDE0DQo+ICAjZGVmaW5lIERJU1BfUkVHX09W
TF9ST0lfU0laRQkJCTB4MDAyMA0KPiAgI2RlZmluZSBESVNQX1JFR19PVkxfREFUQVBBVEhfQ09O
CQkweDAwMjQNCj4gKyNkZWZpbmUgT1ZMX0xBWUVSX1NNSV9JRF9FTgkJCQlCSVQoMCkNCj4gICNk
ZWZpbmUgT1ZMX0JHQ0xSX1NFTF9JTgkJCQlCSVQoMikNCj4gICNkZWZpbmUgRElTUF9SRUdfT1ZM
X1JPSV9CR0NMUgkJCTB4MDAyOA0KPiAgI2RlZmluZSBESVNQX1JFR19PVkxfU1JDX0NPTgkJCTB4
MDAyYw0KPiBAQCAtNjIsNiArNjMsNyBAQCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgew0KPiAg
CXVuc2lnbmVkIGludCBnbWNfYml0czsNCj4gIAl1bnNpZ25lZCBpbnQgbGF5ZXJfbnI7DQo+ICAJ
Ym9vbCBmbXRfcmdiNTY1X2lzXzA7DQo+ICsJYm9vbCBzbWlfaWRfZW47DQo+ICB9Ow0KPiAgDQo+
ICAvKioNCj4gQEAgLTEzNCw2ICsxMzYsMTMgQEAgdm9pZCBtdGtfb3ZsX3N0YXJ0KHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gIA0KPiArCWlmIChvdmwtPmRhdGEtPnNtaV9pZF9lbikgew0KPiAr
CQl1bnNpZ25lZCBpbnQgcmVnOw0KPiArDQo+ICsJCXJlZyA9IHJlYWRsKG92bC0+cmVncyArIERJ
U1BfUkVHX09WTF9EQVRBUEFUSF9DT04pOw0KPiArCQlyZWcgPSByZWcgfCBPVkxfTEFZRVJfU01J
X0lEX0VOOw0KPiArCQl3cml0ZWxfcmVsYXhlZChyZWcsIG92bC0+cmVncyArIERJU1BfUkVHX09W
TF9EQVRBUEFUSF9DT04pOw0KPiArCX0NCj4gIAl3cml0ZWxfcmVsYXhlZCgweDEsIG92bC0+cmVn
cyArIERJU1BfUkVHX09WTF9FTik7DQo+ICB9DQo+ICANCj4gQEAgLTE0Miw2ICsxNTEsMTQgQEAg
dm9pZCBtdGtfb3ZsX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBtdGtfZGlz
cF9vdmwgKm92bCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgDQo+ICAJd3JpdGVsX3JlbGF4
ZWQoMHgwLCBvdmwtPnJlZ3MgKyBESVNQX1JFR19PVkxfRU4pOw0KPiArCWlmIChvdmwtPmRhdGEt
PnNtaV9pZF9lbikgew0KPiArCQl1bnNpZ25lZCBpbnQgcmVnOw0KPiArDQo+ICsJCXJlZyA9IHJl
YWRsKG92bC0+cmVncyArIERJU1BfUkVHX09WTF9EQVRBUEFUSF9DT04pOw0KPiArCQlyZWcgPSBy
ZWcgJiB+T1ZMX0xBWUVSX1NNSV9JRF9FTjsNCj4gKwkJd3JpdGVsX3JlbGF4ZWQocmVnLCBvdmwt
PnJlZ3MgKyBESVNQX1JFR19PVkxfREFUQVBBVEhfQ09OKTsNCj4gKwl9DQo+ICsNCj4gIH0NCj4g
IA0KPiAgdm9pZCBtdGtfb3ZsX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGlu
dCB3LA0KDQo=

