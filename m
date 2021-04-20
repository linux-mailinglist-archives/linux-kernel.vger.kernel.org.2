Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D52365A02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhDTN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:27:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41349 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232448AbhDTN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:27:06 -0400
X-UUID: 67b4741ee606471bb1f9e905ed906884-20210420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F/Ns6WIK2Dy0aPedbYy3llJMXtmG+SMNazBAvgRMihY=;
        b=o0UFIGtF7B5l+zpZ/eonUMjp4IyVrBz4SJ+o6C1z6gZde/pSxgrVv04K313rlg+ePenX7Dlg1KHOp9jf8PVjKNBIJJJ8KWRe84pjKGf9dWuDqGTJ++lgzPRMwQmg56W91edZA3uBAjqgKD0bLYzKZwpxs8qbs4Zbps07DkEuBCk=;
X-UUID: 67b4741ee606471bb1f9e905ed906884-20210420
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 369354208; Tue, 20 Apr 2021 21:26:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 21:26:21 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 20 Apr 2021 21:26:20 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 4/4] drm/mediatek: add dsi module reset driver
Date:   Tue, 20 Apr 2021 21:26:13 +0800
Message-ID: <20210420132614.150242-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420132614.150242-1-jitao.shi@mediatek.com>
References: <20210420132614.150242-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CDD0EDBC07D217E939DC5558E2076778B137CA9F9ABA7EDE162356D70FBDF6E02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVzZXQgZHNpIEhXIHRvIGRlZmF1bHQgd2hlbiBwb3dlciBvbi4gUHJldmVudCB0aGUgc2V0dGlu
ZyBkaWZmZXJldA0KYmV0d2VlbiBib290bG9hZGVyIGFuZCBrZXJuZWwuDQoNClNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCmluZGV4IDQ1NWZlNTgyYzZiNS4uMTEzNDM4ZGRk
NGNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KQEAgLTcsMTAgKzcsMTIgQEAN
CiAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KICNpbmNsdWRlIDxsaW51eC9pcnEuaD4NCisjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5o
Pg0KICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiANCiAjaW5jbHVkZSA8dmlk
ZW8vbWlwaV9kaXNwbGF5Lmg+DQogI2luY2x1ZGUgPHZpZGVvL3ZpZGVvbW9kZS5oPg0KQEAgLTE0
Myw2ICsxNDUsOCBAQA0KICNkZWZpbmUgREFUQV8wCQkJCSgweGZmIDw8IDE2KQ0KICNkZWZpbmUg
REFUQV8xCQkJCSgweGZmIDw8IDI0KQ0KIA0KKyNkZWZpbmUgTU1TWVNfU1dfUlNUX0RTSV9CIEJJ
VCgyNSkNCisNCiAjZGVmaW5lIE5TX1RPX0NZQ0xFKG4sIGMpICAgICgobikgLyAoYykgKyAoKChu
KSAlIChjKSkgPyAxIDogMCkpDQogDQogI2RlZmluZSBNVEtfRFNJX0hPU1RfSVNfUkVBRCh0eXBl
KSBcDQpAQCAtMTg2LDcgKzE5MCw4IEBAIHN0cnVjdCBtdGtfZHNpIHsNCiAJc3RydWN0IGRybV9i
cmlkZ2UgKm5leHRfYnJpZGdlOw0KIAlzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOw0K
IAlzdHJ1Y3QgcGh5ICpwaHk7DQotDQorCXN0cnVjdCByZWdtYXAgKm1tc3lzX3N3X3JzdF9iOw0K
Kwl1MzIgc3dfcnN0X2I7DQogCXZvaWQgX19pb21lbSAqcmVnczsNCiANCiAJc3RydWN0IGNsayAq
ZW5naW5lX2NsazsNCkBAIC0yNzIsNiArMjc3LDE2IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfZGlz
YWJsZShzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KIAltdGtfZHNpX21hc2soZHNpLCBEU0lfQ09OX0NU
UkwsIERTSV9FTiwgMCk7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG10a19kc2lfcmVzZXRfYWxsKHN0
cnVjdCBtdGtfZHNpICpkc2kpDQorew0KKwlyZWdtYXBfdXBkYXRlX2JpdHMoZHNpLT5tbXN5c19z
d19yc3RfYiwgZHNpLT5zd19yc3RfYiwNCisJCQkgICBNTVNZU19TV19SU1RfRFNJX0IsIDApOw0K
Kwl1c2xlZXBfcmFuZ2UoMTAwMCwgMTEwMCk7DQorDQorCXJlZ21hcF91cGRhdGVfYml0cyhkc2kt
Pm1tc3lzX3N3X3JzdF9iLCBkc2ktPnN3X3JzdF9iLA0KKwkJCSAgIE1NU1lTX1NXX1JTVF9EU0lf
QiwgTU1TWVNfU1dfUlNUX0RTSV9CKTsNCit9DQorDQogc3RhdGljIHZvaWQgbXRrX2RzaV9yZXNl
dF9lbmdpbmUoc3RydWN0IG10a19kc2kgKmRzaSkNCiB7DQogCW10a19kc2lfbWFzayhkc2ksIERT
SV9DT05fQ1RSTCwgRFNJX1JFU0VULCBEU0lfUkVTRVQpOw0KQEAgLTk4NSw2ICsxMDAwLDggQEAg
c3RhdGljIGludCBtdGtfZHNpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNl
ICptYXN0ZXIsIHZvaWQgKmRhdGEpDQogDQogCXJldCA9IG10a19kc2lfZW5jb2Rlcl9pbml0KGRy
bSwgZHNpKTsNCiANCisJbXRrX2RzaV9yZXNldF9hbGwoZHNpKTsNCisNCiAJcmV0dXJuIHJldDsN
CiB9DQogDQpAQCAtMTAwNyw2ICsxMDI0LDcgQEAgc3RhdGljIGludCBtdGtfZHNpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2
LT5kZXY7DQogCXN0cnVjdCBkcm1fcGFuZWwgKnBhbmVsOw0KIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
Z3M7DQorCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCiAJaW50IGlycV9udW07DQogCWludCByZXQ7
DQogDQpAQCAtMTAyMiw2ICsxMDQwLDIyIEBAIHN0YXRpYyBpbnQgbXRrX2RzaV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlyZWdt
YXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKGRldi0+b2Zfbm9kZSwNCisJCQkJ
CQkgIm1lZGlhdGVrLHN5c2Nvbi1kc2kiKTsNCisJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJf
aW5kZXgoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssc3lzY29uLWRzaSIsIDEsDQorCQkJCQkgJmRz
aS0+c3dfcnN0X2IpOw0KKw0KKwlpZiAoSVNfRVJSKHJlZ21hcCkpDQorCQlyZXQgPSBQVFJfRVJS
KHJlZ21hcCk7DQorDQorCWlmIChyZXQpIHsNCisJCXJldCA9IFBUUl9FUlIocmVnbWFwKTsNCisJ
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBtbXN5cyByZWdpc3RlcnM6ICVkXG4iLCByZXQp
Ow0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlkc2ktPm1tc3lzX3N3X3JzdF9iID0gcmVnbWFw
Ow0KKw0KIAlyZXQgPSBkcm1fb2ZfZmluZF9wYW5lbF9vcl9icmlkZ2UoZGV2LT5vZl9ub2RlLCAw
LCAwLA0KIAkJCQkJICAmcGFuZWwsICZkc2ktPm5leHRfYnJpZGdlKTsNCiAJaWYgKHJldCkNCi0t
IA0KMi4yNS4xDQo=

