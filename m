Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078B330A272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhBAHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:06:40 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231657AbhBAHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:22 -0500
X-UUID: e1ce72e9ddf04dae9d3e60da15232cf4-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NY1W/kQBVjtqVQr6v8QyJ2pN9lwi3z3HRZ5XDKcsi3g=;
        b=U7/3odXZkXvNhrHT4yzrcz2wJsE7EVNy1wlU7hGpdZuTC6CAhkZOX89IOLeI7YGLsKTlyY+B0Fs7a+u2jQ3hUvsbeDN5nyIxMhMFFgrNeFwIfFNlZxzk/wzXbndDskweu7FOCfMv6ItSZfn9OJkCudX50H59pE/Gqmi3of5K5YA=;
X-UUID: e1ce72e9ddf04dae9d3e60da15232cf4-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 609392235; Mon, 01 Feb 2021 15:00:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:29 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v3 12/16] arm64: dts: mediatek: mt7622: harmonize node names and compatibles
Date:   Mon, 1 Feb 2021 15:00:12 +0800
Message-ID: <20210201070016.41721-12-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F2B5DF19662B597862356DDB44749FC6B251F8E195D46EDB226D8B4AB2F58C982000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8g
Y2hhbmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSB8
IDkgKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIy
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpDQppbmRleCA1
YjllYzAzMmNlOGQuLjRjZmEwOWIwY2EzYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ3NjIyLmR0c2kNCkBAIC03NDAsOCArNzQwLDggQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQogCX07DQogDQotCXUzcGh5OiB1c2ItcGh5QDFhMGM0MDAwIHsNCi0JCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ3NjIyLXUzcGh5IiwNCisJdTNwaHk6IHQtcGh5QDFhMGM0MDAwIHsNCisJ
CWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIyLXRwaHkiLA0KIAkJCSAgICAgIm1lZGlhdGVr
LGdlbmVyaWMtdHBoeS12MSI7DQogCQlyZWcgPSA8MCAweDFhMGM0MDAwIDAgMHg3MDA+Ow0KIAkJ
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQpAQCAtODc1LDggKzg3NSw5IEBADQogCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAl9Ow0KIA0KLQlzYXRhX3BoeTogc2F0YS1waHlAMWEyNDMwMDAgew0KLQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KKwlzYXRhX3BoeTogdC1w
aHlAMWEyNDMwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjItdHBoeSIsDQor
CQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KIAkJI3NpemUtY2VsbHMgPSA8Mj47DQogCQlyYW5nZXM7DQotLSANCjIuMTguMA0K

