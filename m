Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41F630D36C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 07:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBCGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 01:33:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:56755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230072AbhBCGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:33:41 -0500
X-UUID: d7b7657db9344063ab2ef54e71c4a222-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=avkqul/hJQ/XrEB+TAwmq5gAEcanSQm+jDT5myaH9Qk=;
        b=WGGbyHKZkydmfhqUuqXgRDvsqbwm8oQatdtEp4LsWQC8cHMhoDS4AcPdr3xWdUPqXdHE5L1TOBBz9X9QcqA1X+kHCEYizdsQlnDS2kvqpFa2gaktS6AbR58ozDx2/w74yWb60q+ylA0IscK59fAhMzMjUJVFaNxxk1XGqfqHMpw=;
X-UUID: d7b7657db9344063ab2ef54e71c4a222-20210203
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1565704411; Wed, 03 Feb 2021 14:32:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 14:32:46 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 14:32:45 +0800
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
Subject: [RFC PATCH 2/3] usb: xhci-mtk: modify the SOF/ITP interval for mt8195
Date:   Wed, 3 Feb 2021 14:31:58 +0800
Message-ID: <20210203063159.11021-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210203063159.11021-1-chunfeng.yun@mediatek.com>
References: <20210203063159.11021-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0FA1531C6694A62EFDE4D90B1C8DFA06C11E33CB4DF011C1C11CBC09E44189482000:8
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
Lnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCA2
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDYzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1t
dGsuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KaW5kZXggOGYzMjFmMzlhYjk2Li40
NTY1MWIyYmEyYjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KQEAgLTY4LDExICs2OCw3MSBAQA0KICNk
ZWZpbmUgU1NDX0lQX1NMRUVQX0VOCUJJVCg0KQ0KICNkZWZpbmUgU1NDX1NQTV9JTlRfRU4JCUJJ
VCgxKQ0KIA0KKy8qIHhIQ0kgY3NyICovDQorI2RlZmluZSBMU19FT0YJCQkweDkzMA0KKyNkZWZp
bmUgTFNfRU9GX09GRlNFVAkJMHg4OQ0KKw0KKyNkZWZpbmUgRlNfRU9GCQkJMHg5MzQNCisjZGVm
aW5lIEZTX0VPRl9PRkZTRVQJCTB4MmUNCisNCisjZGVmaW5lIFNTX0dFTjFfRU9GCQkweDkzYw0K
KyNkZWZpbmUgU1NfR0VOMV9FT0ZfT0ZGU0VUCTB4NzgNCisNCisjZGVmaW5lIEhGQ05UUl9DRkcJ
CTB4OTQ0DQorI2RlZmluZSBJVFBfREVMVEFfQ0xLCQkoMHhhIDw8IDEpDQorI2RlZmluZSBJVFBf
REVMVEFfQ0xLX01BU0sJR0VOTUFTSyg1LCAxKQ0KKyNkZWZpbmUgRlJNQ05UX0xFVjFfUkFORwko
MHgxMmIgPDwgOCkNCisjZGVmaW5lIEZSTUNOVF9MRVYxX1JBTkdfTUFTSwlHRU5NQVNLKDE5LCA4
KQ0KKw0KKyNkZWZpbmUgU1NfR0VOMl9FT0YJCTB4OTkwDQorI2RlZmluZSBTU19HRU4yX0VPRl9P
RkZTRVQJMHgzYw0KKyNkZWZpbmUgRU9GX09GRlNFVF9NQVNLCQlHRU5NQVNLKDExLCAwKQ0KKw0K
IGVudW0gc3N1c2JfdXdrX3ZlcnMgew0KIAlTU1VTQl9VV0tfVjEgPSAxLA0KIAlTU1VTQl9VV0tf
VjIsDQogfTsNCiANCisvKg0KKyAqIE1UODE5NSBoYXMgNCBjb250cm9sbGVycywgdGhlIGNvbnRy
b2xsZXIxfjMncyBkZWZhdWx0IFNPRi9JVFAgaW50ZXJ2YWwNCisgKiBpcyBjYWxjdWxhdGVkIGZy
b20gdGhlIGZyYW1lIGNvdW50ZXIgY2xvY2sgMjRNLCBidXQgaW4gZmFjdCwgdGhlIGNsb2NrDQor
ICogaXMgNDhNLCBzbyBuZWVkIGNoYW5nZSB0aGUgaW50ZXJ2YWwuDQorICovDQorc3RhdGljIHZv
aWQgeGhjaV9tdGtfc2V0X2ZyYW1lX2ludGVydmFsKHN0cnVjdCB4aGNpX2hjZF9tdGsgKm10aykN
Cit7DQorCXN0cnVjdCBkZXZpY2UgKmRldiA9IG10ay0+ZGV2Ow0KKwlzdHJ1Y3QgdXNiX2hjZCAq
aGNkID0gbXRrLT5oY2Q7DQorCXUzMiB2YWx1ZTsNCisNCisJaWYgKCFvZl9kZXZpY2VfaXNfY29t
cGF0aWJsZShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxtdDgxOS14aGNpIikpDQorCQlyZXR1cm47
DQorDQorCXZhbHVlID0gcmVhZGwoaGNkLT5yZWdzICsgSEZDTlRSX0NGRyk7DQorCXZhbHVlICY9
IH4oSVRQX0RFTFRBX0NMS19NQVNLIHwgRlJNQ05UX0xFVjFfUkFOR19NQVNLKTsNCisJdmFsdWUg
fD0gKElUUF9ERUxUQV9DTEsgfCBGUk1DTlRfTEVWMV9SQU5HKTsNCisJd3JpdGVsKHZhbHVlLCBo
Y2QtPnJlZ3MgKyBIRkNOVFJfQ0ZHKTsNCisNCisJdmFsdWUgPSByZWFkbChoY2QtPnJlZ3MgKyBM
U19FT0YpOw0KKwl2YWx1ZSAmPSB+RU9GX09GRlNFVF9NQVNLOw0KKwl2YWx1ZSB8PSBMU19FT0Zf
T0ZGU0VUOw0KKwl3cml0ZWwodmFsdWUsIGhjZC0+cmVncyArIExTX0VPRik7DQorDQorCXZhbHVl
ID0gcmVhZGwoaGNkLT5yZWdzICsgRlNfRU9GKTsNCisJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFT
SzsNCisJdmFsdWUgfD0gRlNfRU9GX09GRlNFVDsNCisJd3JpdGVsKHZhbHVlLCBoY2QtPnJlZ3Mg
KyBGU19FT0YpOw0KKw0KKwl2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIFNTX0dFTjFfRU9GKTsN
CisJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFTSzsNCisJdmFsdWUgfD0gU1NfR0VOMV9FT0ZfT0ZG
U0VUOw0KKwl3cml0ZWwodmFsdWUsIGhjZC0+cmVncyArIFNTX0dFTjFfRU9GKTsNCisNCisJdmFs
dWUgPSByZWFkbChoY2QtPnJlZ3MgKyBTU19HRU4yX0VPRik7DQorCXZhbHVlICY9IH5FT0ZfT0ZG
U0VUX01BU0s7DQorCXZhbHVlIHw9IFNTX0dFTjJfRU9GX09GRlNFVDsNCisJd3JpdGVsKHZhbHVl
LCBoY2QtPnJlZ3MgKyBTU19HRU4yX0VPRik7DQorfQ0KKw0KIHN0YXRpYyBpbnQgeGhjaV9tdGtf
aG9zdF9lbmFibGUoc3RydWN0IHhoY2lfaGNkX210ayAqbXRrKQ0KIHsNCiAJc3RydWN0IG11M2Nf
aXBwY19yZWdzIF9faW9tZW0gKmlwcGMgPSBtdGstPmlwcGNfcmVnczsNCkBAIC00MDcsNiArNDY3
LDggQEAgc3RhdGljIGludCB4aGNpX210a19zZXR1cChzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KIAkJ
cmV0ID0geGhjaV9tdGtfc3N1c2JfY29uZmlnKG10ayk7DQogCQlpZiAocmV0KQ0KIAkJCXJldHVy
biByZXQ7DQorDQorCQl4aGNpX210a19zZXRfZnJhbWVfaW50ZXJ2YWwobXRrKTsNCiAJfQ0KIA0K
IAlyZXQgPSB4aGNpX2dlbl9zZXR1cChoY2QsIHhoY2lfbXRrX3F1aXJrcyk7DQpAQCAtNjU1LDYg
KzcxNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyB4aGNpX210a19wbV9vcHMg
PSB7DQogI2lmZGVmIENPTkZJR19PRg0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IG10a194aGNpX29mX21hdGNoW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLXhoY2kifSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUteGhjaSJ9LA0K
IAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay14aGNpIn0sDQogCXsgfSwNCiB9Ow0KLS0g
DQoyLjE4LjANCg==

