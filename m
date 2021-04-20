Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB94365A04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhDTN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:27:13 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46817 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232453AbhDTN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:27:07 -0400
X-UUID: caceb05b186b46009969db505458c8e8-20210420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q1Yw7il2MClM4mQcrsnzuY1x1dqtCZCR9HbDGp8SKAI=;
        b=f3Fo92J5a+C5ZrVaQ8lZ0Awr10s3MGFx96ETF+J0WbxEwWHtaxh43fLLmHQb0Uads9bOEdVa3+FCcHwYMnjpz/6GZ5cLnL74HB/goT7MrSOypS1Rm1/VCWu/A57KktXy/4I3hYJ2mpeHJ8Vr+J8rBcwPnBYpB0CVDK/G4xYcEnU=;
X-UUID: caceb05b186b46009969db505458c8e8-20210420
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1876854650; Tue, 20 Apr 2021 21:26:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 21:26:18 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 20 Apr 2021 21:26:17 +0800
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
Subject: [PATCH 2/4] drm/panel: boe-tv101wum-n16 seperate the panel power control
Date:   Tue, 20 Apr 2021 21:26:11 +0800
Message-ID: <20210420132614.150242-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420132614.150242-1-jitao.shi@mediatek.com>
References: <20210420132614.150242-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 45751ACB09465B252BD553B0B387AFEC38F4F85E73F60BF298E6246B4BC675732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VwZXJhdGUgdGhlIHBhbmVsIHBvd2VyIGNvbnRyb2wgZnJvbSBwcmVwYXJlL3VucHJlcGFyZS4N
Cg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0t
DQogLi4uL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jICAgIHwgNzIgKysr
KysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyMiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1i
b2UtdHYxMDF3dW0tbmw2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAx
d3VtLW5sNi5jDQppbmRleCBkYjlkMGI4NmQ1NDIuLmRjNDkwNzlhNzRkMSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMNCkBAIC01MCw2ICs1
MCw3IEBAIHN0cnVjdCBib2VfcGFuZWwgew0KIAlzdHJ1Y3QgcmVndWxhdG9yICphdmRkOw0KIAlz
dHJ1Y3QgZ3Bpb19kZXNjICplbmFibGVfZ3BpbzsNCiANCisJYm9vbCBwcmVwYXJlZF9wb3dlcjsN
CiAJYm9vbCBwcmVwYXJlZDsNCiB9Ow0KIA0KQEAgLTQ4OCwyMiArNDg5LDEzIEBAIHN0YXRpYyBp
bnQgYm9lX3BhbmVsX2VudGVyX3NsZWVwX21vZGUoc3RydWN0IGJvZV9wYW5lbCAqYm9lKQ0KIAly
ZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIGludCBib2VfcGFuZWxfdW5wcmVwYXJlKHN0cnVjdCBk
cm1fcGFuZWwgKnBhbmVsKQ0KK3N0YXRpYyBpbnQgYm9lX3BhbmVsX3VucHJlcGFyZV9wb3dlcihz
dHJ1Y3QgZHJtX3BhbmVsICpwYW5lbCkNCiB7DQogCXN0cnVjdCBib2VfcGFuZWwgKmJvZSA9IHRv
X2JvZV9wYW5lbChwYW5lbCk7DQotCWludCByZXQ7DQogDQotCWlmICghYm9lLT5wcmVwYXJlZCkN
CisJaWYgKCFib2UtPnByZXBhcmVkX3Bvd2VyKQ0KIAkJcmV0dXJuIDA7DQogDQotCXJldCA9IGJv
ZV9wYW5lbF9lbnRlcl9zbGVlcF9tb2RlKGJvZSk7DQotCWlmIChyZXQgPCAwKSB7DQotCQlkZXZf
ZXJyKHBhbmVsLT5kZXYsICJmYWlsZWQgdG8gc2V0IHBhbmVsIG9mZjogJWRcbiIsIHJldCk7DQot
CQlyZXR1cm4gcmV0Ow0KLQl9DQotDQotCW1zbGVlcCgxNTApOw0KLQ0KIAlpZiAoYm9lLT5kZXNj
LT5kaXNjaGFyZ2Vfb25fZGlzYWJsZSkgew0KIAkJcmVndWxhdG9yX2Rpc2FibGUoYm9lLT5hdmVl
KTsNCiAJCXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+YXZkZCk7DQpAQCAtNTEyLDYgKzUwNCw3IEBA
IHN0YXRpYyBpbnQgYm9lX3BhbmVsX3VucHJlcGFyZShzdHJ1Y3QgZHJtX3BhbmVsICpwYW5lbCkN
CiAJCXVzbGVlcF9yYW5nZSg1MDAwLCA3MDAwKTsNCiAJCXJlZ3VsYXRvcl9kaXNhYmxlKGJvZS0+
cHAxODAwKTsNCiAJfSBlbHNlIHsNCisJCW1zbGVlcCgxNTApOw0KIAkJZ3Bpb2Rfc2V0X3ZhbHVl
KGJvZS0+ZW5hYmxlX2dwaW8sIDApOw0KIAkJdXNsZWVwX3JhbmdlKDUwMCwgMTAwMCk7DQogCQly
ZWd1bGF0b3JfZGlzYWJsZShib2UtPmF2ZWUpOw0KQEAgLTUyMCwxNyArNTEzLDM5IEBAIHN0YXRp
YyBpbnQgYm9lX3BhbmVsX3VucHJlcGFyZShzdHJ1Y3QgZHJtX3BhbmVsICpwYW5lbCkNCiAJCXJl
Z3VsYXRvcl9kaXNhYmxlKGJvZS0+cHAxODAwKTsNCiAJfQ0KIA0KKwlib2UtPnByZXBhcmVkX3Bv
d2VyID0gZmFsc2U7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgaW50IGJvZV9wYW5l
bF91bnByZXBhcmUoc3RydWN0IGRybV9wYW5lbCAqcGFuZWwpDQorew0KKwlzdHJ1Y3QgYm9lX3Bh
bmVsICpib2UgPSB0b19ib2VfcGFuZWwocGFuZWwpOw0KKwlpbnQgcmV0Ow0KKw0KKwlpZiAoIWJv
ZS0+cHJlcGFyZWQpDQorCQlyZXR1cm4gMDsNCisNCisJaWYgKCFib2UtPmRlc2MtPmRpc2NoYXJn
ZV9vbl9kaXNhYmxlKSB7DQorCQlyZXQgPSBib2VfcGFuZWxfZW50ZXJfc2xlZXBfbW9kZShib2Up
Ow0KKwkJaWYgKHJldCA8IDApIHsNCisJCQlkZXZfZXJyKHBhbmVsLT5kZXYsICJmYWlsZWQgdG8g
c2V0IHBhbmVsIG9mZjogJWRcbiIsDQorCQkJCXJldCk7DQorCQkJcmV0dXJuIHJldDsNCisJCX0N
CisJfQ0KKw0KIAlib2UtPnByZXBhcmVkID0gZmFsc2U7DQogDQogCXJldHVybiAwOw0KIH0NCiAN
Ci1zdGF0aWMgaW50IGJvZV9wYW5lbF9wcmVwYXJlKHN0cnVjdCBkcm1fcGFuZWwgKnBhbmVsKQ0K
K3N0YXRpYyBpbnQgYm9lX3BhbmVsX3ByZXBhcmVfcG93ZXIoc3RydWN0IGRybV9wYW5lbCAqcGFu
ZWwpDQogew0KIAlzdHJ1Y3QgYm9lX3BhbmVsICpib2UgPSB0b19ib2VfcGFuZWwocGFuZWwpOw0K
IAlpbnQgcmV0Ow0KIA0KLQlpZiAoYm9lLT5wcmVwYXJlZCkNCisJaWYgKGJvZS0+cHJlcGFyZWRf
cG93ZXIpDQogCQlyZXR1cm4gMDsNCiANCiAJZ3Bpb2Rfc2V0X3ZhbHVlKGJvZS0+ZW5hYmxlX2dw
aW8sIDApOw0KQEAgLTU1OCwxOCArNTczLDEwIEBAIHN0YXRpYyBpbnQgYm9lX3BhbmVsX3ByZXBh
cmUoc3RydWN0IGRybV9wYW5lbCAqcGFuZWwpDQogCWdwaW9kX3NldF92YWx1ZShib2UtPmVuYWJs
ZV9ncGlvLCAxKTsNCiAJdXNsZWVwX3JhbmdlKDYwMDAsIDEwMDAwKTsNCiANCi0JcmV0ID0gYm9l
X3BhbmVsX2luaXRfZGNzX2NtZChib2UpOw0KLQlpZiAocmV0IDwgMCkgew0KLQkJZGV2X2Vycihw
YW5lbC0+ZGV2LCAiZmFpbGVkIHRvIGluaXQgcGFuZWw6ICVkXG4iLCByZXQpOw0KLQkJZ290byBw
b3dlcm9mZjsNCi0JfQ0KLQ0KLQlib2UtPnByZXBhcmVkID0gdHJ1ZTsNCisJYm9lLT5wcmVwYXJl
ZF9wb3dlciA9IHRydWU7DQogDQogCXJldHVybiAwOw0KIA0KLXBvd2Vyb2ZmOg0KLQlyZWd1bGF0
b3JfZGlzYWJsZShib2UtPmF2ZWUpOw0KIHBvd2Vyb2ZmYXZkZDoNCiAJcmVndWxhdG9yX2Rpc2Fi
bGUoYm9lLT5hdmRkKTsNCiBwb3dlcm9mZjF2ODoNCkBAIC01ODAsNiArNTg3LDI1IEBAIHN0YXRp
YyBpbnQgYm9lX3BhbmVsX3ByZXBhcmUoc3RydWN0IGRybV9wYW5lbCAqcGFuZWwpDQogCXJldHVy
biByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgYm9lX3BhbmVsX3ByZXBhcmUoc3RydWN0IGRybV9w
YW5lbCAqcGFuZWwpDQorew0KKwlzdHJ1Y3QgYm9lX3BhbmVsICpib2UgPSB0b19ib2VfcGFuZWwo
cGFuZWwpOw0KKwlpbnQgcmV0Ow0KKw0KKwlpZiAoYm9lLT5wcmVwYXJlZCkNCisJCXJldHVybiAw
Ow0KKw0KKwlyZXQgPSBib2VfcGFuZWxfaW5pdF9kY3NfY21kKGJvZSk7DQorCWlmIChyZXQgPCAw
KSB7DQorCQlkZXZfZXJyKHBhbmVsLT5kZXYsICJmYWlsZWQgdG8gaW5pdCBwYW5lbDogJWRcbiIs
IHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCWJvZS0+cHJlcGFyZWQgPSB0cnVlOw0K
Kw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGludCBib2VfcGFuZWxfZW5hYmxlKHN0cnVj
dCBkcm1fcGFuZWwgKnBhbmVsKQ0KIHsNCiAJbXNsZWVwKDEzMCk7DQpAQCAtNzQ5LDcgKzc3NSw5
IEBAIHN0YXRpYyBpbnQgYm9lX3BhbmVsX2dldF9tb2RlcyhzdHJ1Y3QgZHJtX3BhbmVsICpwYW5l
bCwNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9wYW5lbF9mdW5jcyBib2VfcGFuZWxfZnVu
Y3MgPSB7DQogCS51bnByZXBhcmUgPSBib2VfcGFuZWxfdW5wcmVwYXJlLA0KKwkudW5wcmVwYXJl
X3Bvd2VyID0gYm9lX3BhbmVsX3VucHJlcGFyZV9wb3dlciwNCiAJLnByZXBhcmUgPSBib2VfcGFu
ZWxfcHJlcGFyZSwNCisJLnByZXBhcmVfcG93ZXIgPSBib2VfcGFuZWxfcHJlcGFyZV9wb3dlciwN
CiAJLmVuYWJsZSA9IGJvZV9wYW5lbF9lbmFibGUsDQogCS5nZXRfbW9kZXMgPSBib2VfcGFuZWxf
Z2V0X21vZGVzLA0KIH07DQotLSANCjIuMjUuMQ0K

