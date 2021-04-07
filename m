Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB6356EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbhDGOhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:37:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7227 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232791AbhDGOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:37:29 -0400
X-UUID: 1a14094a131744f9a4ba853018bf1189-20210407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HVFoeCxFeSmvJk3GvtJboV3PR4TTvxxrZdUgsEvyBqg=;
        b=V4t+o36fiY0WTXP3coOXuUG7GP+nBoLdcNi8wzMGnolaZIc/OxcvAtLx/1U6A2deBjDI2qCkfetVEIrG5ltTqvTLGRdew43kBwjq+G3U0jMT/uBWAYYNRl2sZ1yKEk3to+9VS/cAa43/hLHhuSNyAi+E7fXAoN4hmTcVOpwawC8=;
X-UUID: 1a14094a131744f9a4ba853018bf1189-20210407
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2036019314; Wed, 07 Apr 2021 22:37:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 22:37:02 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 22:37:01 +0800
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
Subject: [PATCH] drm/mediatek: force hsa hsa hfp packets multiple of line num to avoid screen shift
Date:   Wed, 7 Apr 2021 22:36:56 +0800
Message-ID: <20210407143656.2574-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 04143E2A032602C99B68E1021BC15E0AF3D5F349C78BF14AFD651C4F6CAF72E12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGJyaWRnZSBjaGlwIEFOWDc2MjUgcmVxdWlyZSB0aGUgbGluZSBwYWNrZXRzIGVuZGluZyBh
dCB0aGUgc2FtZXRpbWUNCm9yIEFOWDc2MjUgd2lsbCBzaGlmdCB0aGUgc2NyZWVuLg0KDQpDaGFu
Z2UtSWQ6IElhMzI0YWQyOGZiZmY1NDE0MGZlZWRiOWExZDZiZmIyYjI0NmQwNDQ3DQpTaWduZWQt
b2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMTIgKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQpp
bmRleCBhMWZmMTUyZWY0NjguLmU4MjVhODA4NjJkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHNpLmMNCkBAIC0xOTQsNiArMTk0LDggQEAgc3RydWN0IG10a19kc2kgew0KIAlzdHJ1Y3Qg
Y2xrICpoc19jbGs7DQogDQogCXUzMiBkYXRhX3JhdGU7DQorCS8qIGZvcmNlIGRzaSBsaW5lIGVu
ZCB3aXRob3V0IGRzaV9udWxsIGRhdGEgKi8NCisJYm9vbCBmb3JjZV9kc2lfZW5kX3dpdGhvdXRf
bnVsbDsNCiANCiAJdW5zaWduZWQgbG9uZyBtb2RlX2ZsYWdzOw0KIAllbnVtIG1pcGlfZHNpX3Bp
eGVsX2Zvcm1hdCBmb3JtYXQ7DQpAQCAtNDk1LDYgKzQ5NywxMyBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQogCQlEUk1fV0FSTigi
SEZQICsgSEJQIGxlc3MgdGhhbiBkLXBoeSwgRlBTIHdpbGwgdW5kZXIgNjBIelxuIik7DQogCX0N
CiANCisJaWYgKGRzaS0+Zm9yY2VfZHNpX2VuZF93aXRob3V0X251bGwpIHsNCisJCWhvcml6b250
YWxfc3luY19hY3RpdmVfYnl0ZSA9IHJvdW5kdXAoaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRl
LCBkc2ktPmxhbmVzKSAtIDI7DQorCQlob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSA9IHJvdW5k
dXAoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUsIGRzaS0+bGFuZXMpIC0gMjsNCisJCWhvcml6
b250YWxfYmFja3BvcmNoX2J5dGUgPSByb3VuZHVwKGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUs
IGRzaS0+bGFuZXMpIC0gMjsNCisJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgLT0gKHZtLT5o
YWN0aXZlICogZHNpX3RtcF9idWZfYnBwICsgMikgJSBkc2ktPmxhbmVzOw0KKwl9DQorDQogCXdy
aXRlbChob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0FfV0Mp
Ow0KIAl3cml0ZWwoaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hC
UF9XQyk7DQogCXdyaXRlbChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsg
RFNJX0hGUF9XQyk7DQpAQCAtMTA5MSw2ICsxMTAwLDkgQEAgc3RhdGljIGludCBtdGtfZHNpX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWRzaS0+YnJpZGdlLm9mX25vZGUg
PSBkZXYtPm9mX25vZGU7DQogCWRzaS0+YnJpZGdlLnR5cGUgPSBEUk1fTU9ERV9DT05ORUNUT1Jf
RFNJOw0KIA0KKwlkc2ktPmZvcmNlX2RzaV9lbmRfd2l0aG91dF9udWxsID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKGRldi0+b2Zfbm9kZSwNCisJCQkJCQkJCSJmb3JjZV9kc2lfZW5kX3dpdGhvdXRf
bnVsbCIpOw0KKw0KIAlkcm1fYnJpZGdlX2FkZCgmZHNpLT5icmlkZ2UpOw0KIA0KIAlyZXQgPSBj
b21wb25lbnRfYWRkKCZwZGV2LT5kZXYsICZtdGtfZHNpX2NvbXBvbmVudF9vcHMpOw0KLS0gDQoy
LjI1LjENCg==

