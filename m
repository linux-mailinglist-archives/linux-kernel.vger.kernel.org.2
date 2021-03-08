Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3533079B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhCHFij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:39 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49810 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234440AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: 0af98bc63fe74663bebca4e8ec7fefbe-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vUt83uaZ74x8mpNOiTRiaG9i+zb+gwMOmWmUWAk1WqA=;
        b=LmBU+Ahv1fzn2N/z58g1w8aByttfALlLZJSKP1qGvKh+HxcQdeKXWik7fYxdr2CoaWGcx7wYW1GamT1IeOuKJQlhcnwhKyIIWDCfFJ/NiI3177I1sK4LjASwuyMar4hewfDZlPdUL28m+ysYflaNkXsVzlYpWq7iDavdH6hrU4o=;
X-UUID: 0af98bc63fe74663bebca4e8ec7fefbe-20210308
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2087347591; Mon, 08 Mar 2021 13:37:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:49 +0800
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
Subject: [PATCH v4 06/12] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Mon, 8 Mar 2021 13:37:39 +0800
Message-ID: <20210308053745.25697-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9F71C23802741888ED7DB20ACE42FC0D014A0D0F4C738FF44BFF78955D8412FF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcuDQoNClNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjJ+djQ6IG5v
IGNoYW5nZXMNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNp
IHwgOCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Mjcx
MmUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQppbmRl
eCBkYjE3ZDBhNGVkNTcuLmE5Y2NhOWMxNDZmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210MjcxMmUuZHRzaQ0KQEAgLTgwNSw3ICs4MDUsNyBAQA0KIAkJcmFuZ2VzOw0KIAkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCXVzYl9ob3N0MDogeGhjaUAxMTI3MDAwMCB7DQor
CQl1c2JfaG9zdDA6IHVzYkAxMTI3MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDI3MTIteGhjaSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8
MCAweDExMjcwMDAwIDAgMHgxMDAwPjsNCkBAIC04MTgsNyArODE4LDcgQEANCiAJCX07DQogCX07
DQogDQotCXUzcGh5MDogdXNiLXBoeUAxMTI5MDAwMCB7DQorCXUzcGh5MDogdC1waHlAMTEyOTAw
MDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAi
bWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KQEAg
LTg2OSw3ICs4NjksNyBAQA0KIAkJcmFuZ2VzOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAN
Ci0JCXVzYl9ob3N0MTogeGhjaUAxMTJjMDAwMCB7DQorCQl1c2JfaG9zdDE6IHVzYkAxMTJjMDAw
MCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTIteGhjaSIsDQogCQkJCSAgICAg
Im1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8MCAweDExMmMwMDAwIDAgMHgxMDAwPjsN
CkBAIC04ODIsNyArODgyLDcgQEANCiAJCX07DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBoeUAx
MTJlMDAwMCB7DQorCXUzcGh5MTogdC1waHlAMTEyZTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYy
IjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoyLjE4LjANCg==

