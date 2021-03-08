Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ACF330799
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhCHFig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:38:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:26064 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234419AbhCHFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:38:02 -0500
X-UUID: b78ddf32959a43b3b2441d0c93471a78-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xiK75etj9DmiKoQLrPrie0KN9SKOuWl4w4F5RiOHtYo=;
        b=BKqMmtbd/m15HcWyFtdIYxeSOFci1k0v6le3Fg1vzluyul8TyPUJ7jJvI8KmO1QM2xNDSZ+9JGMn+xkvmK2fVLYYISB2lrpmjC1/isYSmrkjoQJzWp5GWyUcKWF2Ks4Kmvn/c/3W6FjMeF1wzyGgkP0/h2M7fV9WDKS0AUovoLM=;
X-UUID: b78ddf32959a43b3b2441d0c93471a78-20210308
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1281030574; Mon, 08 Mar 2021 13:37:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 13:37:51 +0800
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
Subject: [PATCH v4 09/12] arm64: dts: mediatek: mt8183: fix dtbs_check warning
Date:   Mon, 8 Mar 2021 13:37:42 +0800
Message-ID: <20210308053745.25697-9-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 322C98B94CE6078B86382F4B8B5AE479148476144B2D5EC7669AA5C533025DDA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGUgbmFtZXMsIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CnY0OiBubyBjaGFuZ2VzDQp2MzogcmVtb3ZlIHByb3BlcnR5IGNsb2NrLW5hbWVzIHN1Z2dlc3Rl
ZCBieSBDSw0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kgfCA4ICsrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpDQppbmRleCA4MDUxOWExNDVmMTMuLjg4ODJkMzVhYzZhYiAxMDA2NDQNCi0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCkBAIC04ODAsNyArODgwLDcgQEANCiAJCQly
YW5nZXM7DQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCQl1c2JfaG9zdDogeGhjaUAx
MTIwMDAwMCB7DQorCQkJdXNiX2hvc3Q6IHVzYkAxMTIwMDAwMCB7DQogCQkJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLXhoY2kiLA0KIAkJCQkJICAgICAibWVkaWF0ZWssbXRrLXhoY2ki
Ow0KIAkJCQlyZWcgPSA8MCAweDExMjAwMDAwIDAgMHgxMDAwPjsNCkBAIC05MjMsMTEgKzkyMywx
MCBAQA0KIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQl9Ow0KIA0KLQkJbWlwaV90eDA6IG1p
cGktZHBoeUAxMWU1MDAwMCB7DQorCQltaXBpX3R4MDogZHNpLXBoeUAxMWU1MDAwMCB7DQogCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbWlwaS10eCI7DQogCQkJcmVnID0gPDAgMHgx
MWU1MDAwMCAwIDB4MTAwMD47DQogCQkJY2xvY2tzID0gPCZhcG1peGVkc3lzIENMS19BUE1JWEVE
X01JUElEMF8yNk0+Ow0KLQkJCWNsb2NrLW5hbWVzID0gInJlZl9jbGsiOw0KIAkJCSNjbG9jay1j
ZWxscyA9IDwwPjsNCiAJCQkjcGh5LWNlbGxzID0gPDA+Ow0KIAkJCWNsb2NrLW91dHB1dC1uYW1l
cyA9ICJtaXBpX3R4MF9wbGwiOw0KQEAgLTk0NiwxMSArOTQ1LDEwIEBADQogCQkJfTsNCiAJCX07
DQogDQotCQl1M3BoeTogdXNiLXBoeUAxMWY0MDAwMCB7DQorCQl1M3BoeTogdC1waHlAMTFmNDAw
MDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXRwaHkiLA0KIAkJCQkgICAg
ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
LQkJCSNwaHktY2VsbHMgPSA8MT47DQogCQkJI3NpemUtY2VsbHMgPSA8MT47DQogCQkJcmFuZ2Vz
ID0gPDAgMCAweDExZjQwMDAwIDB4MTAwMD47DQogCQkJc3RhdHVzID0gIm9rYXkiOw0KLS0gDQoy
LjE4LjANCg==

