Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AE30A0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBADsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:48:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53203 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231126AbhBADss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:48:48 -0500
X-UUID: 5e1ee2eb50a74496b375a3ef7e447988-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ycki3f22lu0G/Y5pcD1WAXwXxWSc4abbISJZOTSNMNc=;
        b=pDOFhhxmjFLzOmwmHC4x9N38et/+Q01E1gSTzVtbD/xVJLLYDaoSXHkNsVS3sI1srpQ0GSORnxDwTEwdyvH3MBv+ELeNA98fRQUjHCZF9qvgP4cmRkLawcHYAjCffp6Vdr7HNcQnW61jSbxw6ws3DtrXsvP4NLROvku/oxEc4NY=;
X-UUID: 5e1ee2eb50a74496b375a3ef7e447988-20210201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1357974449; Mon, 01 Feb 2021 11:48:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 11:47:58 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 1 Feb 2021 11:47:57 +0800
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
        <shuijing.li@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/mediatek: fine tune the data lane trail by project dts
Date:   Mon, 1 Feb 2021 11:47:55 +0800
Message-ID: <20210201034755.15793-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C09D5F74431AB1B049045EEA52CC4FCA78AF2ACAE1755FA553EE30718D904CAA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBwYW5lbHMgb3IgYnJpZGdlcyByZXF1aXJlIGN1c3RvbWl6ZWQgaHNfZGFfdHJhaWwgdGlt
ZS4NClNvIGFkZCBhIHByb3BlcnR5IGluIGRldmljZXRyZWUgZm9yIHRoaXMgcGFuZWxzIGFuZCBi
cmlkZ2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMTAgKysrKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQppbmRleCA4YzcwZWMzOWJmZTEuLjZlNzA5MmZh
MmZlZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCkBAIC0xOTQsNiArMTk0LDcg
QEAgc3RydWN0IG10a19kc2kgew0KIAlzdHJ1Y3QgY2xrICpoc19jbGs7DQogDQogCXUzMiBkYXRh
X3JhdGU7DQorCXUzMiBkYV90cmFpbF9kZWx0YTsNCiANCiAJdW5zaWduZWQgbG9uZyBtb2RlX2Zs
YWdzOw0KIAllbnVtIG1pcGlfZHNpX3BpeGVsX2Zvcm1hdCBmb3JtYXQ7DQpAQCAtMjM0LDcgKzIz
NSw3IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfcGh5X3RpbWNvbmZpZyhzdHJ1Y3QgbXRrX2RzaSAq
ZHNpKQ0KIAl0aW1pbmctPmRhX2hzX3ByZXBhcmUgPSAoODAgKiBkYXRhX3JhdGVfbWh6ICsgNCAq
IDEwMDApIC8gODAwMDsNCiAJdGltaW5nLT5kYV9oc196ZXJvID0gKDE3MCAqIGRhdGFfcmF0ZV9t
aHogKyAxMCAqIDEwMDApIC8gODAwMCArIDEgLQ0KIAkJCSAgICAgdGltaW5nLT5kYV9oc19wcmVw
YXJlOw0KLQl0aW1pbmctPmRhX2hzX3RyYWlsID0gdGltaW5nLT5kYV9oc19wcmVwYXJlICsgMTsN
CisJdGltaW5nLT5kYV9oc190cmFpbCA9IHRpbWluZy0+ZGFfaHNfcHJlcGFyZSArIDEgKyBkc2kt
PmRhX3RyYWlsX2RlbHRhOw0KIA0KIAl0aW1pbmctPnRhX2dvID0gNCAqIHRpbWluZy0+bHB4IC0g
MjsNCiAJdGltaW5nLT50YV9zdXJlID0gdGltaW5nLT5scHggKyAyOw0KQEAgLTEwOTQsNiArMTA5
NSwxMyBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJCWdvdG8gZXJyX3VucmVnaXN0ZXJfaG9zdDsNCiAJfQ0KIA0KKwlyZXQgPSBvZl9w
cm9wZXJ0eV9yZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsICJkYV90cmFpbF9kZWx0YSIsIDAs
DQorCQkJCQkgJmRzaS0+ZGFfdHJhaWxfZGVsdGEpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfaW5m
byhkZXYsICJDYW4ndCBnZXQgZGFfdHJhaWxfZGVsdGEsIGtlZXAgaXQgYXMgMDogJWRcbiIsIHJl
dCk7DQorCQlkc2ktPmRhX3RyYWlsX2RlbHRhID0gMDsNCisJfQ0KKw0KIAljb21wX2lkID0gbXRr
X2RkcF9jb21wX2dldF9pZChkZXYtPm9mX25vZGUsIE1US19EU0kpOw0KIAlpZiAoY29tcF9pZCA8
IDApIHsNCiAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGlkZW50aWZ5IGJ5IGFsaWFzOiAlZFxu
IiwgY29tcF9pZCk7DQotLSANCjIuMTIuNQ0K

