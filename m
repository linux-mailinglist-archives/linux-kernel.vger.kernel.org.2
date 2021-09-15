Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD5D40CF51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhIOWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:33:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232618AbhIOWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:32:59 -0400
X-UUID: b44dc5c443b9423796d0a00d17b6e1f6-20210916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rjEz5Kn3VIz46kt9NukJ6kGABo04SufkfAzoukdeg8Q=;
        b=RhbvMA+AJcEEF4Aej3pVcq52b4Yd2eL96+utJk2fnPcmhaDfcjVzr7Y0L1yLIbdZNV3L0Uz3fnqxMggTrfP2+cH2nqeBfS4UyWZB3OzRcvdRfvB3Xy6zuphv+aFgZdibWJoxv9ON3kAwhdQgE+R0UuTViDy5+ZuIb7aH+Q0djHM=;
X-UUID: b44dc5c443b9423796d0a00d17b6e1f6-20210916
Received: from mtkcas36.mediatek.inc [(172.27.5.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 340433354; Thu, 16 Sep 2021 06:31:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Sep
 2021 06:31:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 16 Sep 2021 06:31:25 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 1/3] drm/dsi: transer dsi hs packet aligned
Date:   Thu, 16 Sep 2021 06:31:15 +0800
Message-ID: <20210915223117.7857-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223117.7857-1-jitao.shi@mediatek.com>
References: <20210915223117.7857-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1BE109D5F6ED7D38BAD44844D97596ED11FAC3A3FB224F4D54CF33DC5EFFFBF52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBEU0kgZGV2aWNlcyByZXFpcmUgdGhlIGhzIHBhY2tldCBzdGFydGluZyBhbmQgZW5kaW5n
DQphdCBzYW1lIHRpbWUgb24gYWxsIGRzaSBsYW5lcy4gU28gdXNlIGEgZmxhZyB0byB0aG9zZSBk
ZXZpY2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQotLS0NCiBpbmNsdWRlL2RybS9kcm1fbWlwaV9kc2kuaCB8IDIgKysNCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fbWlw
aV9kc2kuaCBiL2luY2x1ZGUvZHJtL2RybV9taXBpX2RzaS5oDQppbmRleCBhZjdiYTgwNzFlYjAu
LjhlODU2Mzc5MjY4MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9taXBpX2RzaS5oDQor
KysgYi9pbmNsdWRlL2RybS9kcm1fbWlwaV9kc2kuaA0KQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdHJ1
Y3QgbWlwaV9kc2lfZGV2aWNlX2luZm8gew0KICAqIEBscF9yYXRlOiBtYXhpbXVtIGxhbmUgZnJl
cXVlbmN5IGZvciBsb3cgcG93ZXIgbW9kZSBpbiBoZXJ0eiwgdGhpcyBzaG91bGQNCiAgKiBiZSBz
ZXQgdG8gdGhlIHJlYWwgbGltaXRzIG9mIHRoZSBoYXJkd2FyZSwgemVybyBpcyBvbmx5IGFjY2Vw
dGVkIGZvcg0KICAqIGxlZ2FjeSBkcml2ZXJzDQorICogQGhzX3BhY2tldF9lbmRfYWxpZ25lZDog
dHJhbnNmZXIgZHNpIGhzIHBhY2tldCBlbmRpbmcgYWxpZ25lZA0KICAqLw0KIHN0cnVjdCBtaXBp
X2RzaV9kZXZpY2Ugew0KIAlzdHJ1Y3QgbWlwaV9kc2lfaG9zdCAqaG9zdDsNCkBAIC0xODksNiAr
MTkwLDcgQEAgc3RydWN0IG1pcGlfZHNpX2RldmljZSB7DQogCXVuc2lnbmVkIGxvbmcgbW9kZV9m
bGFnczsNCiAJdW5zaWduZWQgbG9uZyBoc19yYXRlOw0KIAl1bnNpZ25lZCBsb25nIGxwX3JhdGU7
DQorCWJvb2wgaHNfcGFja2V0X2VuZF9hbGlnbmVkOw0KIH07DQogDQogI2RlZmluZSBNSVBJX0RT
SV9NT0RVTEVfUFJFRklYICJtaXBpLWRzaToiDQotLSANCjIuMjUuMQ0K

