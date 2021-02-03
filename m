Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6830D779
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhBCK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:27:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36954 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233694AbhBCK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:27:35 -0500
X-UUID: 109044f3a5c24026a4f5930e4b0eaccf-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qJXyUkhTG3EiVikkkhafwsut5EHurgvUe+hMMeVXd64=;
        b=dnXVX1CYwJ4CMKrJYba4h/XDMwcANiwlJNop0YS7rA8ksPjSd55Yfm2RU5+Bw/82EJmsTGnOU8bnwRh3GBrzS0rOvzxdJ9iA8DTPuBGI8P7PP/cK62joq/xd1efg4pWLFzoNoLGesHCBDw9Sc0S136Lh17jGLgbpJ5D9/588zWo=;
X-UUID: 109044f3a5c24026a4f5930e4b0eaccf-20210203
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 328501113; Wed, 03 Feb 2021 18:26:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 18:26:46 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 18:26:46 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH v2 2/3] usb: xhci-mtk: modify the SOF/ITP interval for mt8195
Date:   Wed, 3 Feb 2021 18:26:41 +0800
Message-ID: <20210203102642.7353-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 69C95C417298EC51AE23FB6CAB8FFF25126E6644A83787837E3078CAF3F85B592000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgYXJlIDQgVVNCIGNvbnRyb2xsZXJzIG9uIE1UODE5NSwgdGhlIGNvbnRyb2xsZXJzIChJ
UDF+SVAzLA0KZXhjbHVkZSBJUDApIGhhdmUgYSB3cm9uZyBkZWZhdWx0IFNPRi9JVFAgaW50ZXJ2
YWwgd2hpY2ggaXMNCmNhbGN1bGF0ZWQgZnJvbSB0aGUgZnJhbWUgY291bnRlciBjbG9jayAyNE1o
eiBieSBkZWZhdWx0LCBidXQNCmluIGZhY3QsIHRoZSBmcmFtZSBjb3VudGVyIGNsb2NrIGlzIDQ4
TWh6LCBzbyB3ZSBzaG91bGQgc2V0DQp0aGUgYWNjdXJhdGUgaW50ZXJ2YWwgYWNjb3JkaW5nIHRv
IDQ4TWh6IGZvciB0aG9zZSBjb250cm9sbGVycy4NCk5vdGU6IHRoZSBmaXJzdCBjb250cm9sbGVy
IG5vIG5lZWQgc2V0IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBmaXggdHlwbyBvZiBjb21hcHRpYmxlDQotLS0N
CiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCA2MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyBiL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuYw0KaW5kZXggOGYzMjFmMzlhYjk2Li4wYTY4YzRhYzhiNDggMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGsuYw0KQEAgLTY4LDExICs2OCw3MSBAQA0KICNkZWZpbmUgU1NDX0lQX1NMRUVQX0VOCUJJ
VCg0KQ0KICNkZWZpbmUgU1NDX1NQTV9JTlRfRU4JCUJJVCgxKQ0KIA0KKy8qIHhIQ0kgY3NyICov
DQorI2RlZmluZSBMU19FT0YJCQkweDkzMA0KKyNkZWZpbmUgTFNfRU9GX09GRlNFVAkJMHg4OQ0K
Kw0KKyNkZWZpbmUgRlNfRU9GCQkJMHg5MzQNCisjZGVmaW5lIEZTX0VPRl9PRkZTRVQJCTB4MmUN
CisNCisjZGVmaW5lIFNTX0dFTjFfRU9GCQkweDkzYw0KKyNkZWZpbmUgU1NfR0VOMV9FT0ZfT0ZG
U0VUCTB4NzgNCisNCisjZGVmaW5lIEhGQ05UUl9DRkcJCTB4OTQ0DQorI2RlZmluZSBJVFBfREVM
VEFfQ0xLCQkoMHhhIDw8IDEpDQorI2RlZmluZSBJVFBfREVMVEFfQ0xLX01BU0sJR0VOTUFTSyg1
LCAxKQ0KKyNkZWZpbmUgRlJNQ05UX0xFVjFfUkFORwkoMHgxMmIgPDwgOCkNCisjZGVmaW5lIEZS
TUNOVF9MRVYxX1JBTkdfTUFTSwlHRU5NQVNLKDE5LCA4KQ0KKw0KKyNkZWZpbmUgU1NfR0VOMl9F
T0YJCTB4OTkwDQorI2RlZmluZSBTU19HRU4yX0VPRl9PRkZTRVQJMHgzYw0KKyNkZWZpbmUgRU9G
X09GRlNFVF9NQVNLCQlHRU5NQVNLKDExLCAwKQ0KKw0KIGVudW0gc3N1c2JfdXdrX3ZlcnMgew0K
IAlTU1VTQl9VV0tfVjEgPSAxLA0KIAlTU1VTQl9VV0tfVjIsDQogfTsNCiANCisvKg0KKyAqIE1U
ODE5NSBoYXMgNCBjb250cm9sbGVycywgdGhlIGNvbnRyb2xsZXIxfjMncyBkZWZhdWx0IFNPRi9J
VFAgaW50ZXJ2YWwNCisgKiBpcyBjYWxjdWxhdGVkIGZyb20gdGhlIGZyYW1lIGNvdW50ZXIgY2xv
Y2sgMjRNLCBidXQgaW4gZmFjdCwgdGhlIGNsb2NrDQorICogaXMgNDhNLCBzbyBuZWVkIGNoYW5n
ZSB0aGUgaW50ZXJ2YWwuDQorICovDQorc3RhdGljIHZvaWQgeGhjaV9tdGtfc2V0X2ZyYW1lX2lu
dGVydmFsKHN0cnVjdCB4aGNpX2hjZF9tdGsgKm10aykNCit7DQorCXN0cnVjdCBkZXZpY2UgKmRl
diA9IG10ay0+ZGV2Ow0KKwlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gbXRrLT5oY2Q7DQorCXUzMiB2
YWx1ZTsNCisNCisJaWYgKCFvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJt
ZWRpYXRlayxtdDgxOTUteGhjaSIpKQ0KKwkJcmV0dXJuOw0KKw0KKwl2YWx1ZSA9IHJlYWRsKGhj
ZC0+cmVncyArIEhGQ05UUl9DRkcpOw0KKwl2YWx1ZSAmPSB+KElUUF9ERUxUQV9DTEtfTUFTSyB8
IEZSTUNOVF9MRVYxX1JBTkdfTUFTSyk7DQorCXZhbHVlIHw9IChJVFBfREVMVEFfQ0xLIHwgRlJN
Q05UX0xFVjFfUkFORyk7DQorCXdyaXRlbCh2YWx1ZSwgaGNkLT5yZWdzICsgSEZDTlRSX0NGRyk7
DQorDQorCXZhbHVlID0gcmVhZGwoaGNkLT5yZWdzICsgTFNfRU9GKTsNCisJdmFsdWUgJj0gfkVP
Rl9PRkZTRVRfTUFTSzsNCisJdmFsdWUgfD0gTFNfRU9GX09GRlNFVDsNCisJd3JpdGVsKHZhbHVl
LCBoY2QtPnJlZ3MgKyBMU19FT0YpOw0KKw0KKwl2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIEZT
X0VPRik7DQorCXZhbHVlICY9IH5FT0ZfT0ZGU0VUX01BU0s7DQorCXZhbHVlIHw9IEZTX0VPRl9P
RkZTRVQ7DQorCXdyaXRlbCh2YWx1ZSwgaGNkLT5yZWdzICsgRlNfRU9GKTsNCisNCisJdmFsdWUg
PSByZWFkbChoY2QtPnJlZ3MgKyBTU19HRU4xX0VPRik7DQorCXZhbHVlICY9IH5FT0ZfT0ZGU0VU
X01BU0s7DQorCXZhbHVlIHw9IFNTX0dFTjFfRU9GX09GRlNFVDsNCisJd3JpdGVsKHZhbHVlLCBo
Y2QtPnJlZ3MgKyBTU19HRU4xX0VPRik7DQorDQorCXZhbHVlID0gcmVhZGwoaGNkLT5yZWdzICsg
U1NfR0VOMl9FT0YpOw0KKwl2YWx1ZSAmPSB+RU9GX09GRlNFVF9NQVNLOw0KKwl2YWx1ZSB8PSBT
U19HRU4yX0VPRl9PRkZTRVQ7DQorCXdyaXRlbCh2YWx1ZSwgaGNkLT5yZWdzICsgU1NfR0VOMl9F
T0YpOw0KK30NCisNCiBzdGF0aWMgaW50IHhoY2lfbXRrX2hvc3RfZW5hYmxlKHN0cnVjdCB4aGNp
X2hjZF9tdGsgKm10aykNCiB7DQogCXN0cnVjdCBtdTNjX2lwcGNfcmVncyBfX2lvbWVtICppcHBj
ID0gbXRrLT5pcHBjX3JlZ3M7DQpAQCAtNDA3LDYgKzQ2Nyw4IEBAIHN0YXRpYyBpbnQgeGhjaV9t
dGtfc2V0dXAoc3RydWN0IHVzYl9oY2QgKmhjZCkNCiAJCXJldCA9IHhoY2lfbXRrX3NzdXNiX2Nv
bmZpZyhtdGspOw0KIAkJaWYgKHJldCkNCiAJCQlyZXR1cm4gcmV0Ow0KKw0KKwkJeGhjaV9tdGtf
c2V0X2ZyYW1lX2ludGVydmFsKG10ayk7DQogCX0NCiANCiAJcmV0ID0geGhjaV9nZW5fc2V0dXAo
aGNkLCB4aGNpX210a19xdWlya3MpOw0KQEAgLTY1NSw2ICs3MTcsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgeGhjaV9tdGtfcG1fb3BzID0gew0KICNpZmRlZiBDT05GSUdfT0YN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfeGhjaV9vZl9tYXRjaFtdID0g
ew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My14aGNpIn0sDQorCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXhoY2kifSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdGsteGhjaSJ9LA0KIAl7IH0sDQogfTsNCi0tIA0KMi4xOC4wDQo=

