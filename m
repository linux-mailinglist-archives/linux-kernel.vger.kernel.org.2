Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8C33077D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhCHFiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:17 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29728 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234289AbhCHFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:00 -0500
X-UUID: 3f62d69b001047acbccf1685eb5501cf-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M43plPAlJu0dIq9N1qVljuhme6bwHRp+zmB6OUheLr0=;
        b=XmG2IaKdu7KE27DfBxWG2NqFwMe7qiUnJENU3v8awszDes/dzGD3LRpkbj3LhdvPuQF3Yq2iuC1Kz0+TZja1L1dXk5bNLG+8dKhujXg9BqOlU+XLLcZz/RC5jqoHF/aDVvXNA5S4yMqK2cJtYSfMbu2Hk4g9lqdo7iTXzSbrIEY=;
X-UUID: 3f62d69b001047acbccf1685eb5501cf-20210308
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2135380876; Mon, 08 Mar 2021 13:37:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:50 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 13:37:49 +0800
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
Subject: [PATCH v4 07/12] arm64: dts: mediatek: mt8516: harmonize node names and compatibles
Date:   Mon, 8 Mar 2021 13:37:40 +0800
Message-ID: <20210308053745.25697-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 935F5C00A7322E8CAB4DB261B1E7BC0B77011C37FC0CA73782C288BA4BCDDE242000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmc6DQogIGhhcm1vbml6ZSBub2Rl
IG5hbWVzIGFuZCBjb21wYXRpYmxlczsNCiAgYWRkIHByb3BlcnR5ICJ1c2Itcm9sZS1zd2l0Y2gi
IGZvciBjb25uZWN0b3IgZGVwZW5kZW5jZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NDogbm8gY2hhbmdlcw0KLS0t
DQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDg1MTYuZHRzaSAgICAgICAgIHwgOSAr
KysrKy0tLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL3B1bXBraW4tY29tbW9uLmR0
c2kgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODUxNi5kdHNpDQppbmRleCBiODBl
OTU1NzRiZWYuLmJiZTVhMTQxOWVmZiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4NTE2LmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4NTE2LmR0c2kNCkBAIC00ODAsNyArNDgwLDcgQEANCiAJCX07DQogDQogCQl1c2IwOiB1c2JA
MTExMDAwMDAgew0KLQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXRrLW11c2IiOw0KKwkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4NTE2LW11c2IiLCAibWVkaWF0ZWssbXRrLW11c2IiOw0K
IAkJCXJlZyA9IDwwIDB4MTExMDAwMDAgMCAweDEwMDA+Ow0KIAkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSA3MiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KIAkJCWludGVycnVwdC1uYW1lcyA9ICJtYyI7
DQpAQCAtNDkzLDcgKzQ5Myw3IEBADQogCQl9Ow0KIA0KIAkJdXNiMTogdXNiQDExMTkwMDAwIHsN
Ci0JCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay1tdXNiIjsNCisJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODUxNi1tdXNiIiwgIm1lZGlhdGVrLG10ay1tdXNiIjsNCiAJCQlyZWcgPSA8
MCAweDExMTkwMDAwIDAgMHgxMDAwPjsNCiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjEwIElS
UV9UWVBFX0xFVkVMX0xPVz47DQogCQkJaW50ZXJydXB0LW5hbWVzID0gIm1jIjsNCkBAIC01MDYs
OCArNTA2LDkgQEANCiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJfTsNCiANCi0JCXVzYl9w
aHk6IHVzYkAxMTExMDAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRw
aHktdjEiOw0KKwkJdXNiX3BoeTogdC1waHlAMTExMTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4NTE2LXRwaHkiLA0KKwkJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHkt
djEiOw0KIAkJCXJlZyA9IDwwIDB4MTExMTAwMDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQogCQkJI3NpemUtY2VsbHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9wdW1wa2luLWNvbW1vbi5kdHNpIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9wdW1wa2luLWNvbW1vbi5kdHNpDQppbmRleCA2M2ZkNzAwODZiYjguLjdk
NzM4ZjAxY2Y4ZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvcHVt
cGtpbi1jb21tb24uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9wdW1w
a2luLWNvbW1vbi5kdHNpDQpAQCAtMTg4LDYgKzE4OCw3IEBADQogJnVzYjAgew0KIAlzdGF0dXMg
PSAib2theSI7DQogCWRyX21vZGUgPSAicGVyaXBoZXJhbCI7DQorCXVzYi1yb2xlLXN3aXRjaDsN
CiANCiAJdXNiX2NvbjogY29ubmVjdG9yIHsNCiAJCWNvbXBhdGlibGUgPSAidXNiLWMtY29ubmVj
dG9yIjsNCi0tIA0KMi4xOC4wDQo=

