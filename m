Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEF43950B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhJYLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:44:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:21537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233190AbhJYLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:44:49 -0400
X-UUID: 4577476c31e343fe8032adcd60fde2fe-20211025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5Z+pVIUsnwczbSK4PAQNtN2qL8Rf6p3/4/bd0Nz7Kl8=;
        b=c+xauU6inVHKw+IUzOmb1CvG8W7jRQBoo8dKA1Cshc7thXUeBD3lOoH4aPKb7G+QMM5s4v2cEXvw3SlTyB3AZbBZ4sQmHpUH5GixA3vS2xPi0pkQ1iwl//yWqkCAxSKLwJ2u32iM+qurMF7Dgh6CjkZ1iRYMWHDuTA+U9zbsrDo=;
X-UUID: 4577476c31e343fe8032adcd60fde2fe-20211025
Received: from mtkmbs10n1.mediatek.inc [(172.27.7.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1606625707; Mon, 25 Oct 2021 19:42:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Oct 2021 19:42:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 19:42:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yun-Chien Yu <yun-chien.yu@mediatek.com>
Subject: [RFC PATCH] usb: xhci: skip re-check pending port event if hibernated
Date:   Mon, 25 Oct 2021 19:42:09 +0800
Message-ID: <20211025114209.4047-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiB4SENJIGNvbnRyb2xsZXIgaGliZXJuYXRlZCwgdGhlIHJvb3QgaHViIGxvc3QgcG93ZXIs
IGlmIGNvbnRyb2xsZXINCnN1cHBvcnQgUG9ydCBQb3dlciBDb250cm9sIChQUEMpLCBQUCBpcyBu
b3Qgc2V0IGF0IHhoY2lfcmVzdW1lKCkgYW5kDQpzZXQgYnkgaHViX3Jlc2V0X3Jlc3VtZSgpIGxh
dGVyLCBzbyBubyBuZWVkIGNoZWNrIHBlbmRpbmcgcG9ydCBldmVudC4NCklmIFBQQyBpcyBub3Qg
c3VwcG9ydGVkLCBkZXZpY2UgaXMgZGlzY29ubmVjZWQsIHNlZW1zIGRvIG5vdCBzZW5kIG91dA0K
VTMgTEZQUyB3YWtlIHNpZ25hbCwgbm8gbmVlZCByZS1jaGVjayBhZ2FpbiBhbmQgZHJvcCAxMjBt
cyBkZWxheSB0bw0Kc2F2ZSByZXN1bWUgdGltZS4NCg0KUmVwb3J0ZWQtYnk6IFl1bi1DaGllbiBZ
dSA8eXVuLWNoaWVuLnl1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1
biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QveGhj
aS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2kuYw0KaW5kZXggZjNkYWJkMDIzODJjLi5hN2EyYmY1YmMyMDggMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLmMN
CkBAIC0xMjM1LDcgKzEyMzUsNyBAQCBpbnQgeGhjaV9yZXN1bWUoc3RydWN0IHhoY2lfaGNkICp4
aGNpLCBib29sIGhpYmVybmF0ZWQpDQogCQkgKiB0aGUgZmlyc3Qgd2FrZSBzaWduYWxsaW5nIGZh
aWxlZCwgZ2l2ZSBpdCB0aGF0IGNoYW5jZS4NCiAJCSAqLw0KIAkJcGVuZGluZ19wb3J0ZXZlbnQg
PSB4aGNpX3BlbmRpbmdfcG9ydGV2ZW50KHhoY2kpOw0KLQkJaWYgKCFwZW5kaW5nX3BvcnRldmVu
dCkgew0KKwkJaWYgKCFwZW5kaW5nX3BvcnRldmVudCAmJiAhaGliZXJuYXRlZCkgew0KIAkJCW1z
bGVlcCgxMjApOw0KIAkJCXBlbmRpbmdfcG9ydGV2ZW50ID0geGhjaV9wZW5kaW5nX3BvcnRldmVu
dCh4aGNpKTsNCiAJCX0NCi0tIA0KMi4xOC4wDQo=

