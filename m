Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D130A09A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhBADhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:37:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231329AbhBADg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:36:59 -0500
X-UUID: 1fe32742a3e04c2eb613901de8360bf4-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lV9sztj0bOR1mpfuMBzE2yn9ENlNQzM/EV6eUZYNWTI=;
        b=oqCBRZChQTHaMFts7/2My2kM+6zbL9hq8NJEmguCI8k8yS1CPr1HPfqRhAiDeuuuuw2KGRdJW9zEkk7SNIBd2J+t+lkuhpIgzh+THD1cUyl2prBAow/MjMdcczOGRvfN9+zDZNdIfyXrsGKyIYOTCORa0zms10+2QD7wd2feWFs=;
X-UUID: 1fe32742a3e04c2eb613901de8360bf4-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1182609983; Mon, 01 Feb 2021 11:36:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 11:36:08 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 1 Feb 2021 11:36:06 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 1/2] drm/mediatek: dsi: Fix EoTp flag
Date:   Mon, 1 Feb 2021 11:36:02 +0800
Message-ID: <20210201033603.12616-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210201033603.12616-1-jitao.shi@mediatek.com>
References: <20210201033603.12616-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B12375E8C98A95FD60633FF578880AE2365CEDD3A88E4093A3A168535352E61D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29DIHdpbGwgdHJhbnNtaXQgdGhlIEVvVHAgKEVuZCBvZiBUcmFuc21pc3Npb24gcGFja2V0KSB3
aGVuDQpNSVBJX0RTSV9NT0RFX0VPVF9QQUNLRVQgZmxhZyBpcyBzZXQuDQoNClNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCmluZGV4IDY1ZmQ5OWM1MjhhZi4uMmJjNDZmMjM1MGYxIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYw0KQEAgLTQwMSw4ICs0MDEsMTEgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9y
eHR4X2NvbnRyb2woc3RydWN0IG10a19kc2kgKmRzaSkNCiAJCWJyZWFrOw0KIAl9DQogDQotCXRt
cF9yZWcgfD0gKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX0NMT0NLX05PTl9DT05USU5VT1VT
KSA8PCA2Ow0KLQl0bXBfcmVnIHw9IChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX0VP
VF9QQUNLRVQpID4+IDM7DQorCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9DTE9DS19O
T05fQ09OVElOVU9VUykNCisJCXRtcF9yZWcgfD0gSFNUWF9DS0xQX0VOOw0KKw0KKwlpZiAoIShk
c2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX0VPVF9QQUNLRVQpKQ0KKwkJdG1wX3JlZyB8
PSBESVNfRU9UOw0KIA0KIAl3cml0ZWwodG1wX3JlZywgZHNpLT5yZWdzICsgRFNJX1RYUlhfQ1RS
TCk7DQogfQ0KLS0gDQoyLjEyLjUNCg==

