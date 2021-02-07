Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C92312474
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhBGM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:59:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35657 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229562AbhBGM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:59:45 -0500
X-UUID: 0dedf375d7e64c299f0d6356f2f19682-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=a310sQCUgDOdkn7zckKGWmxpMKVjRJUxcAXM3gBCOzs=;
        b=RGqreRw9mprX/j4W47Zfg6TY/gGhBDJbTPv1OqerSXImXNrGes3XJrMmThCzkF83YMKp/d4YEloZe6IxA1CgXwzMteTR7WMKaEpkdkG5wU966Z8JTJpO/51//P9WOG8JNO3a6CjTAWpy0+QFunuv2PKZbhA/NG8sWGAdbqhsO1Y=;
X-UUID: 0dedf375d7e64c299f0d6356f2f19682-20210207
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 991204185; Sun, 07 Feb 2021 20:58:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 20:58:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 20:58:52 +0800
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
Subject: [PATCH 1/3] drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
Date:   Sun, 7 Feb 2021 20:58:48 +0800
Message-ID: <20210207125850.155979-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207125850.155979-1-jitao.shi@mediatek.com>
References: <20210207125850.155979-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C54BD919B85FF8900CD6F4AF46479ECE6B27F0B8370B8FE00BFC5F265680C9362000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBlci1wbGF0Zm9ybSBtYXggY2xvY2sgcmF0ZSBjaGVjayBpbiBtdGtfZHBpX2JyaWRnZV9t
b2RlX3ZhbGlkLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRl
ay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMTcgKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCmluZGV4IDUyZjExYTYzYTMzMC4uZmZhNGEwZjE5ODlm
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KQEAgLTExOCw2ICsxMTgsNyBAQCBz
dHJ1Y3QgbXRrX2RwaV95Y19saW1pdCB7DQogc3RydWN0IG10a19kcGlfY29uZiB7DQogCXVuc2ln
bmVkIGludCAoKmNhbF9mYWN0b3IpKGludCBjbG9jayk7DQogCXUzMiByZWdfaF9mcmVfY29uOw0K
Kwl1MzIgbWF4X2Nsb2NrX2toejsNCiAJYm9vbCBlZGdlX3NlbF9lbjsNCiB9Ow0KIA0KQEAgLTU1
NSw5ICs1NTYsMjIgQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9icmlkZ2VfZW5hYmxlKHN0cnVjdCBk
cm1fYnJpZGdlICpicmlkZ2UpDQogCW10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShkcGksICZkcGkt
Pm1vZGUpOw0KIH0NCiANCitzdGF0aWMgZW51bSBkcm1fbW9kZV9zdGF0dXMNCittdGtfZHBpX2Jy
aWRnZV9tb2RlX3ZhbGlkKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQorCQkJICBjb25zdCBz
dHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSkNCit7DQorCXN0cnVjdCBtdGtfZHBpICpkcGkg
PSBicmlkZ2VfdG9fZHBpKGJyaWRnZSk7DQorDQorCWlmIChkcGktPmNvbmYtPm1heF9jbG9ja19r
aHogJiYgbW9kZS0+Y2xvY2sgPiBkcGktPmNvbmYtPm1heF9jbG9ja19raHopDQorCQlyZXR1cm4g
TU9ERV9DTE9DS19ISUdIOw0KKw0KKwlyZXR1cm4gTU9ERV9PSzsNCit9DQorDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBkcm1fYnJpZGdlX2Z1bmNzIG10a19kcGlfYnJpZGdlX2Z1bmNzID0gew0KIAku
YXR0YWNoID0gbXRrX2RwaV9icmlkZ2VfYXR0YWNoLA0KIAkubW9kZV9zZXQgPSBtdGtfZHBpX2Jy
aWRnZV9tb2RlX3NldCwNCisJLm1vZGVfdmFsaWQgPSBtdGtfZHBpX2JyaWRnZV9tb2RlX3ZhbGlk
LA0KIAkuZGlzYWJsZSA9IG10a19kcGlfYnJpZGdlX2Rpc2FibGUsDQogCS5lbmFibGUgPSBtdGtf
ZHBpX2JyaWRnZV9lbmFibGUsDQogfTsNCkBAIC02NzMsMTcgKzY4NywyMCBAQCBzdGF0aWMgdW5z
aWduZWQgaW50IG10ODE4M19jYWxjdWxhdGVfZmFjdG9yKGludCBjbG9jaykNCiBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxNzNfY29uZiA9IHsNCiAJLmNhbF9mYWN0b3IgPSBt
dDgxNzNfY2FsY3VsYXRlX2ZhY3RvciwNCiAJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KKwkubWF4
X2Nsb2NrX2toeiA9IDMwMDAwMCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rw
aV9jb25mIG10MjcwMV9jb25mID0gew0KIAkuY2FsX2ZhY3RvciA9IG10MjcwMV9jYWxjdWxhdGVf
ZmFjdG9yLA0KIAkucmVnX2hfZnJlX2NvbiA9IDB4YjAsDQogCS5lZGdlX3NlbF9lbiA9IHRydWUs
DQorCS5tYXhfY2xvY2tfa2h6ID0gMTUwMDAwLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7DQogCS5jYWxfZmFjdG9yID0gbXQ4MTgzX2Nh
bGN1bGF0ZV9mYWN0b3IsDQogCS5yZWdfaF9mcmVfY29uID0gMHhlMCwNCisJLm1heF9jbG9ja19r
aHogPSAxMDAwMDAsDQogfTsNCiANCiBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCi0tIA0KMi4yNS4xDQo=

