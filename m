Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC0312475
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBGNAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 08:00:07 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:3342 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229851AbhBGM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:59:47 -0500
X-UUID: 5a8d102add0542f1a2fdde87b9cdec01-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Qe6O892szdbAWcO7abqUMhQWVuX9nF3nwsJXbrXDxXc=;
        b=TeHLz2NDEfGqri9ZE79IQutcTn7Ylwqh3dwH/qCFOAPBDJugM/xOboGmAzaj/5s3xnZpPfj3k1Gut55BhiahT7+GhdGDRyCw8hkSecCtv+RgQYZyjrYEmWYE0U9aA+iv5ARpobivzNUiZjlxirM2Cry0v1j8/c8rOYFYd42BURQ=;
X-UUID: 5a8d102add0542f1a2fdde87b9cdec01-20210207
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1826985674; Sun, 07 Feb 2021 20:58:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 20:58:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 20:58:53 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 2/3] drm/mediatek: mtk_dpi: Add dpi config for mt8192
Date:   Sun, 7 Feb 2021 20:58:49 +0800
Message-ID: <20210207125850.155979-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207125850.155979-1-jitao.shi@mediatek.com>
References: <20210207125850.155979-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7A297E675B1E143E27AE19EB26FAFFEB39CD7B7945EDE3B6CFC4DE5A9CEAEF092000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDEwICsrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBp
LmMNCmluZGV4IGZmYTRhMGYxOTg5Zi4uYjc5MDVmM2Y0ZDFiIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcGkuYw0KQEAgLTcwMyw2ICs3MDMsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7DQogCS5tYXhfY2xvY2tfa2h6ID0gMTAwMDAwLA0K
IH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTkyX2NvbmYgPSB7
DQorCS5jYWxfZmFjdG9yID0gbXQ4MTgzX2NhbGN1bGF0ZV9mYWN0b3IsDQorCS5yZWdfaF9mcmVf
Y29uID0gMHhlMCwNCisJLmR1YWxfZWRnZSA9IHRydWUsDQorCS5tYXhfY2xvY2tfa2h6ID0gMTUw
MDAwLA0KK307DQorDQogc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KQEAg
LTgzNyw2ICs4NDQsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHBp
X29mX2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kcGkiLA0K
IAkgIC5kYXRhID0gJm10ODE4M19jb25mLA0KIAl9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5Mi1kcGkiLA0KKwkgIC5kYXRhID0gJm10ODE5Ml9jb25mLA0KKwl9LA0KIAl7IH0s
DQogfTsNCiANCi0tIA0KMi4yNS4xDQo=

