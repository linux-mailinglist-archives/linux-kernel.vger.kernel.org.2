Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B83128BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBHB1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:27:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4994 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229537AbhBHB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:27:45 -0500
X-UUID: 67d6af9bb2444afe84f37a411d96c296-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JdQDlO+T4DbZd6v3vMyj8+I0/Y1thi8lltwrLzqd7hQ=;
        b=rRvliTVfc8H/Cexs5W3Jt17MJ2odYhX30zonYPWau+AnvZnW1j/YpYJhuwWF5eERx8D5KY35c3c8tnbwJ5BB2XEwXebpSBfV9+rC9fnRvuy5WeTOVDVPaAmNTaBakJ/WSf/4qM++idZCQxKrb+0GaJTwucKMp6ZHb+az2BVxEu0=;
X-UUID: 67d6af9bb2444afe84f37a411d96c296-20210208
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1975184914; Mon, 08 Feb 2021 09:27:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 09:26:58 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 09:26:57 +0800
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
Subject: [PATCH v2 2/3] drm/mediatek: mtk_dpi: Add dpi config for mt8192
Date:   Mon, 8 Feb 2021 09:26:52 +0800
Message-ID: <20210208012653.196060-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208012653.196060-1-jitao.shi@mediatek.com>
References: <20210208012653.196060-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1A52B9C584BF8F1430BD27141B5AA9D3249DE9E2176A586A5949BDC23F78D4582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDkgKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
CmluZGV4IGZmYTRhMGYxOTg5Zi4uZjZmNzFlYjY3ZmYxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcGkuYw0KQEAgLTcwMyw2ICs3MDMsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7DQogCS5tYXhfY2xvY2tfa2h6ID0gMTAwMDAwLA0KIH07
DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTkyX2NvbmYgPSB7DQor
CS5jYWxfZmFjdG9yID0gbXQ4MTgzX2NhbGN1bGF0ZV9mYWN0b3IsDQorCS5yZWdfaF9mcmVfY29u
ID0gMHhlMCwNCisJLm1heF9jbG9ja19raHogPSAxNTAwMDAsDQorfTsNCisNCiBzdGF0aWMgaW50
IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQpAQCAtODM3LDYgKzg0Myw5IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcGlfb2ZfaWRzW10gPSB7DQogCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRwaSIsDQogCSAgLmRhdGEgPSAmbXQ4MTgzX2NvbmYs
DQogCX0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWRwaSIsDQorCSAgLmRh
dGEgPSAmbXQ4MTkyX2NvbmYsDQorCX0sDQogCXsgfSwNCiB9Ow0KIA0KLS0gDQoyLjI1LjENCg==

