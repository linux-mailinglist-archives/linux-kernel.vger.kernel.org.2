Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4156930A27E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhBAHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:07:29 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13874 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231497AbhBAHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:19 -0500
X-UUID: 37f98667429e4ab6ae913c44e52a2865-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Bd8l4G2LY0u37vbwlfs2iAFYNk0GIiKolBFcqwX+DZI=;
        b=Yr6R3GOGVc7tNYIIfpkHfcqt7Sknt0lTAWtQCwZ2psa1728+TlO1R1MJW0pU56sP6NIpZrvaznbn67CxP+nirtLHkxlDiNS/OLkMZjmonTq7PnyiqqB1ez1BBmLrcu55tR9sB7VvXZzuj9GkydDnbq8KAYnlSTDD2zP6DFCBiWE=;
X-UUID: 37f98667429e4ab6ae913c44e52a2865-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1417821758; Mon, 01 Feb 2021 15:00:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:28 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:28 +0800
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
Subject: [PATCH next v3 09/16] arm64: dts: mediatek: mt8173: fix dtbs_check warning
Date:   Mon, 1 Feb 2021 15:00:09 +0800
Message-ID: <20210201070016.41721-9-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2B2B695D09D3B34BD965E8267EFA80E4FF5DCD7C69CFA1DFC76D2779A0622B7A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGVzIG5hbWVzLCBjb21wYXRpYmxlcyBhbmQgcmVtb3ZlIHVudXNlZCBwcm9w
ZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8gY2hhbmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cyB8ICA0ICstLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE3My5kdHNpICAgIHwgMTMgKysrKysrKy0tLS0tLQ0KIDIgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTczLWV2Yi5kdHMNCmluZGV4IDZkZmZhZGEyZTY2Yi4uMGNlODFj
NGZlODFlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMt
ZXZiLmR0cw0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0
cw0KQEAgLTUxNiwxMCArNTE2LDggQEANCiAJZXh0Y29uID0gPCZleHRjb25fdXNiPjsNCiAJZHJf
bW9kZSA9ICJvdGciOw0KIAl3YWtldXAtc291cmNlOw0KLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiLCAiaWRfZmxvYXQiLCAiaWRfZ3JvdW5kIjsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsNCiAJcGluY3RybC0wID0gPCZ1c2JfaWRfcGluc19mbG9hdD47DQotCXBpbmN0cmwtMSA9IDwm
dXNiX2lkX3BpbnNfZmxvYXQ+Ow0KLQlwaW5jdHJsLTIgPSA8JnVzYl9pZF9waW5zX2dyb3VuZD47
DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE3My5kdHNpDQppbmRleCA3ZmE4NzBlNDM4NmEuLjc1MDQwYTgyMGYwZCAxMDA2NDQNCi0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kNCisrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kNCkBAIC02MzEsNyArNjMxLDcgQEAN
CiAJCQkjbWJveC1jZWxscyA9IDwyPjsNCiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5
QDEwMjE1MDAwIHsNCisJCW1pcGlfdHgwOiBkc2ktcGh5QDEwMjE1MDAwIHsNCiAJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE1MDAw
IDAgMHgxMDAwPjsNCiAJCQljbG9ja3MgPSA8JmNsazI2bT47DQpAQCAtNjQxLDcgKzY0MSw3IEBA
DQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQotCQltaXBpX3R4MTogbWlwaS1k
cGh5QDEwMjE2MDAwIHsNCisJCW1pcGlfdHgxOiBkc2ktcGh5QDEwMjE2MDAwIHsNCiAJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE2
MDAwIDAgMHgxMDAwPjsNCiAJCQljbG9ja3MgPSA8JmNsazI2bT47DQpAQCAtOTI2LDcgKzkyNiw3
IEBADQogCQl9Ow0KIA0KIAkJc3N1c2I6IHVzYkAxMTI3MTAwMCB7DQotCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxNzMtbXR1MyI7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
NzMtbXR1MyIsICJtZWRpYXRlayxtdHUzIjsNCiAJCQlyZWcgPSA8MCAweDExMjcxMDAwIDAgMHgz
MDAwPiwNCiAJCQkgICAgICA8MCAweDExMjgwNzAwIDAgMHgwMTAwPjsNCiAJCQlyZWctbmFtZXMg
PSAibWFjIiwgImlwcGMiOw0KQEAgLTk0Myw4ICs5NDMsOSBAQA0KIAkJCXJhbmdlczsNCiAJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOw0KIA0KLQkJCXVzYl9ob3N0OiB4aGNpQDExMjcwMDAwIHsNCi0J
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMteGhjaSI7DQorCQkJdXNiX2hvc3Q6IHVz
YkAxMTI3MDAwMCB7DQorCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiLA0K
KwkJCQkJICAgICAibWVkaWF0ZWssbXRrLXhoY2kiOw0KIAkJCQlyZWcgPSA8MCAweDExMjcwMDAw
IDAgMHgxMDAwPjsNCiAJCQkJcmVnLW5hbWVzID0gIm1hYyI7DQogCQkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAxMTUgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCkBAIC05NTUsNyArOTU2LDcgQEANCiAJ
CQl9Ow0KIAkJfTsNCiANCi0JCXUzcGh5OiB1c2ItcGh5QDExMjkwMDAwIHsNCisJCXUzcGh5OiB0
LXBoeUAxMTI5MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtdTNwaHki
Ow0KIAkJCXJlZyA9IDwwIDB4MTEyOTAwMDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2VsbHMg
PSA8Mj47DQotLSANCjIuMTguMA0K

