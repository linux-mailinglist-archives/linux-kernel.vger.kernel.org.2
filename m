Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A8375023
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhEFH1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:27:23 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7728 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233240AbhEFH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:27:22 -0400
X-UUID: 6027597d98074da1a90f4d09fb160645-20210506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PKCo5KDu2+MyV2fo3U49lafquNmsvewQjGTpnCl8jB4=;
        b=h+fBzqdXTQ8UvXU0FAhjnlU3e2nT7nW05VgOD0TkkE69TfM+hn+SBjs+8w7I09JY1eTZ5dFjTCA31NJk+d5C2Zp6K57y9Srcsw3gQVCEiqXrJIHEXV7WUWQ5J47z2fAe4zibricOZ91A4iLI3KElfb8G3xSSSWFXVp7JusWAKvI=;
X-UUID: 6027597d98074da1a90f4d09fb160645-20210506
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 895154488; Thu, 06 May 2021 15:26:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 May 2021 15:26:19 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 May 2021 15:26:18 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH] usb: dwc3: remove repeated setting of current_dr_role
Date:   Thu, 6 May 2021 15:26:08 +0800
Message-ID: <20210506072608.32320-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2C439D80F58E40FD8183C9D9B57B59720705FA2E6781ABE2D1FEF57C1D3205B52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHdjM19zZXRfcHJ0Y2FwKCkgYWxyZWFkeSBzZXRzIGN1cnJlbnRfZHJfcm9sZSBhcw0KRFdDM19H
Q1RMX1BSVENBUF9PVEcsIHNvIHJlbW92ZSB0aGUgcmVwZWF0ZWQgb25lLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL3VzYi9kd2MzL2RyZC5jIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2RyZC5jDQppbmRleCBlMmI2OGJiNzcwZDEuLjhmY2JhYzEwNTEwYyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHJkLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCkBAIC01
OTYsNyArNTk2LDYgQEAgaW50IGR3YzNfZHJkX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCiAJCWR3
YzNfZHJkX3VwZGF0ZShkd2MpOw0KIAl9IGVsc2Ugew0KIAkJZHdjM19zZXRfcHJ0Y2FwKGR3Yywg
RFdDM19HQ1RMX1BSVENBUF9PVEcpOw0KLQkJZHdjLT5jdXJyZW50X2RyX3JvbGUgPSBEV0MzX0dD
VExfUFJUQ0FQX09URzsNCiANCiAJCS8qIHVzZSBPVEcgYmxvY2sgdG8gZ2V0IElEIGV2ZW50ICov
DQogCQlpcnEgPSBkd2MzX290Z19nZXRfaXJxKGR3Yyk7DQotLSANCjIuMTguMA0K

