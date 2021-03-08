Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D9330796
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhCHFia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:30 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29728 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234437AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: 51dfd57fe2414212929178fe85ab042f-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8wfkttZWnAB7Hd6T18TTA6CIkBDIjHNqeULAiw9i5QI=;
        b=FXMYMMQxzcJe8gL27jHTGxZkBOksqof9tuIQC0nwH5qlmUc3d6zuhQxIq3oZmaFK0gLgYFxfZQHpZOKqHDW8tsAgV+Kp2WxBB9noQ0vEQ+LSeMXxyK8JDTqI7f/nuufQ3w4ayYZbvl7eKIcJ0Mlum7Sl2vcSyvqx/SSaOFWCcQ8=;
X-UUID: 51dfd57fe2414212929178fe85ab042f-20210308
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 559027942; Mon, 08 Mar 2021 13:37:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:50 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:50 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v4 08/12] arm64: dts: mediatek: mt7622: harmonize node names and compatibles
Date:   Mon, 8 Mar 2021 13:37:41 +0800
Message-ID: <20210308053745.25697-8-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 74EEB831D98E506BC6192B49CC99B1B66B241134E7177A9A45771D99F371AFA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NDogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSB8
IDkgKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIy
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpDQppbmRleCA3
YzZkODcxNTM4YTYuLjg5MGE5NDJlYzYwOCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ3NjIyLmR0c2kNCkBAIC03NDIsOCArNzQyLDggQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQogCX07DQogDQotCXUzcGh5OiB1c2ItcGh5QDFhMGM0MDAwIHsNCi0JCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ3NjIyLXUzcGh5IiwNCisJdTNwaHk6IHQtcGh5QDFhMGM0MDAwIHsNCisJ
CWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIyLXRwaHkiLA0KIAkJCSAgICAgIm1lZGlhdGVr
LGdlbmVyaWMtdHBoeS12MSI7DQogCQlyZWcgPSA8MCAweDFhMGM0MDAwIDAgMHg3MDA+Ow0KIAkJ
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQpAQCAtODc3LDggKzg3Nyw5IEBADQogCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAl9Ow0KIA0KLQlzYXRhX3BoeTogc2F0YS1waHlAMWEyNDMwMDAgew0KLQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KKwlzYXRhX3BoeTogdC1w
aHlAMWEyNDMwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjItdHBoeSIsDQor
CQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KIAkJI3NpemUtY2VsbHMgPSA8Mj47DQogCQlyYW5nZXM7DQotLSANCjIuMTguMA0K

