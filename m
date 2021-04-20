Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32092365A07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhDTN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:27:18 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13776 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232524AbhDTN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:27:13 -0400
X-UUID: 959f53c016c34ab6838cafa57f8b35a2-20210420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x4PC10VWjynceWQKGlyruq1xHVfMHe0q+ks95eUDcMM=;
        b=h4Amvf4zV4EtMkX2uOL4XqdQaDatxwvRwb5ngk9VPSOOCnHO5ReevrLdvhAn5RpAgTGbB5wpolNxmbFt+WEr/9H2fsGIk2bu9IoBdpwuMGd208bbXNW7Etcr83p6wkRXEVwqERMWhDQH5gSKCjU6igqkGVGEemsietuXaU9M0dQ=;
X-UUID: 959f53c016c34ab6838cafa57f8b35a2-20210420
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1691856229; Tue, 20 Apr 2021 21:26:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 21:26:20 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 20 Apr 2021 21:26:18 +0800
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
Subject: [PATCH 3/4] drm/mediatek: fine tune the dsi panel's power sequence
Date:   Tue, 20 Apr 2021 21:26:12 +0800
Message-ID: <20210420132614.150242-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420132614.150242-1-jitao.shi@mediatek.com>
References: <20210420132614.150242-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DE26EABE28240C1980E352A0A7E176B5B54C70B4B01E7B5C108E2A0C6A821C082000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZSBkcm1fcGFuZWxfcHJlcGFyZV9wb3dlciBhbmQgZHJtX3BhbmVsX3VucHJlcGFyZV9w
b3dlciBjb250cm9sLg0KVHVybiBvbiBwYW5lbCBwb3dlcihkcm1fcGFuZWxfcHJlcGFyZV9wb3dl
cikgYW5kIGNvbnRyb2wgYmVmb3JlIGRzaQ0KZW5hYmxlLiBBbmQgdGhlbiBkc2kgZW5hYmxlLCBz
ZW5kIGRjcyBjbWQgaW4gZHJtX3BhbmVsX3ByZXBhcmUsIGxhc3QNCnR1cm4gb24gYmFja2xpZ2h0
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMTIgKysrKysrKysrKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KaW5kZXggYTFmZjE1MmVmNDY4Li40NTVmZTU4MmM2
YjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQpAQCAtNjE1LDEwICs2MTUsMTMg
QEAgc3RhdGljIGludCBtdGtfZHNpX3Bvd2Vyb24oc3RydWN0IG10a19kc2kgKmRzaSkNCiAJZHNp
LT5kYXRhX3JhdGUgPSBESVZfUk9VTkRfVVBfVUxMKGRzaS0+dm0ucGl4ZWxjbG9jayAqIGJpdF9w
ZXJfcGl4ZWwsDQogCQkJCQkgIGRzaS0+bGFuZXMpOw0KIA0KKwlpZiAocGFuZWxfYnJpZGdlX3By
ZXBhcmVfcG93ZXIoZHNpLT5uZXh0X2JyaWRnZSkpDQorCQlEUk1fSU5GTygiY2FuJ3QgcHJlcGFy
ZSBwb3dlciB0aGUgcGFuZWxcbiIpOw0KKw0KIAlyZXQgPSBjbGtfc2V0X3JhdGUoZHNpLT5oc19j
bGssIGRzaS0+ZGF0YV9yYXRlKTsNCiAJaWYgKHJldCA8IDApIHsNCiAJCWRldl9lcnIoZGV2LCAi
RmFpbGVkIHRvIHNldCBkYXRhIHJhdGU6ICVkXG4iLCByZXQpOw0KLQkJZ290byBlcnJfcmVmY291
bnQ7DQorCQlnb3RvIGVycl9wcmVwYXJlX3Bvd2VyOw0KIAl9DQogDQogCXBoeV9wb3dlcl9vbihk
c2ktPnBoeSk7DQpAQCAtNjYxLDcgKzY2NCw5IEBAIHN0YXRpYyBpbnQgbXRrX2RzaV9wb3dlcm9u
KHN0cnVjdCBtdGtfZHNpICpkc2kpDQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkc2ktPmVuZ2lu
ZV9jbGspOw0KIGVycl9waHlfcG93ZXJfb2ZmOg0KIAlwaHlfcG93ZXJfb2ZmKGRzaS0+cGh5KTsN
Ci1lcnJfcmVmY291bnQ6DQorZXJyX3ByZXBhcmVfcG93ZXI6DQorCWlmIChwYW5lbF9icmlkZ2Vf
dW5wcmVwYXJlX3Bvd2VyKGRzaS0+bmV4dF9icmlkZ2UpKQ0KKwkJRFJNX0lORk8oIkNhbid0IHVu
cHJlcGFyZSBwb3dlciB0aGUgcGFuZWxcbiIpOw0KIAlkc2ktPnJlZmNvdW50LS07DQogCXJldHVy
biByZXQ7DQogfQ0KQEAgLTY5NCw2ICs2OTksOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX3Bvd2Vy
b2ZmKHN0cnVjdCBtdGtfZHNpICpkc2kpDQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkc2ktPmRp
Z2l0YWxfY2xrKTsNCiANCiAJcGh5X3Bvd2VyX29mZihkc2ktPnBoeSk7DQorDQorCWlmIChwYW5l
bF9icmlkZ2VfdW5wcmVwYXJlX3Bvd2VyKGRzaS0+bmV4dF9icmlkZ2UpKQ0KKwkJRFJNX0lORk8o
IkNhbid0IHVucHJlcGFyZSBwb3dlciB0aGUgcGFuZWxcbiIpOw0KIH0NCiANCiBzdGF0aWMgdm9p
ZCBtdGtfb3V0cHV0X2RzaV9lbmFibGUoc3RydWN0IG10a19kc2kgKmRzaSkNCi0tIA0KMi4yNS4x
DQo=

