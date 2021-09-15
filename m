Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2C40CF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhIOWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:32:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231969AbhIOWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:32:56 -0400
X-UUID: f3196c0ae63f4b62806365649775f9df-20210916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wd4AHgRylyyah26OepnTFpZldLYrIb0DmjPk2ihhdak=;
        b=TIuaieUwd0oD14bV/ChZMbED+oJn67CUmwXf1hyJlun23wR0g+BfUpiTdv8wgQQrBLzv9DSQduD9sMmNCWJW0S0C3JzJCQ1yNe671zxOWbIFC7DyaA6UNf9ShelJEuJFfghEgP25uQ4X97CwR9LrnRW8Joy6FmqXYmC5cEJEnBw=;
X-UUID: f3196c0ae63f4b62806365649775f9df-20210916
Received: from mtkcas32.mediatek.inc [(172.27.7.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 985539400; Thu, 16 Sep 2021 06:31:32 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Sep
 2021 06:31:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 16 Sep 2021 06:31:24 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 0/3] force hsa hbp hfp packets multiple of lanenum to avoid screen shift
Date:   Thu, 16 Sep 2021 06:31:14 +0800
Message-ID: <20210915223117.7857-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 101387587980953D686CCAE49E93230E7C3CB646B0F487D43AC92405D5FD9DC02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NjoNCiAtIEFkZCAiYm9vbCBoc19wYWNrZXRfZW5kX2FsaWduZWQiIGlu
ICJzdHJ1Y3QgbWlwaV9kc2lfZGV2aWNlIiB0byBjb250cm9sIHRoZSBkc2kgYWxpZ25lZC4NCiAt
IENvbmZpZyB0aGUgImhzX3BhY2tldF9lbmRfYWxpZ25lZCIgaW4gQU5YNzcyNSAuYXR0YWNoKCku
DQoNCkNoYW5nZXMgc2luY2UgdjU6DQogLSBTZWFyY2ggdGhlIGFueDc2MjUgY29tcGF0aWJsZSBh
cyBmbGFnIHRvIGNvbnRyb2wgZHNpIG91dHB1dCBhbGlnbmVkLg0KDQpDaGFuZ2VzIHNpbmNlIHY0
Og0KIC0gTW92ZSAiZHQtYmluZGluZ3M6IGRybS9icmlkZ2U6IGFueDc2MjU6IGFkZCBmb3JjZV9k
c2lfZW5kX3dpdGhvdXRfbnVsbCIgYmVmb3JlDQogICAiZHJtL21lZGlhdGVrOiBmb3JjZSBoc2Eg
aGJwIGhmcCBwYWNrZXRzIG11bHRpcGxlIG9mIGxhbmVudW0gdG8gYXZvaWQiLg0KDQogLSBSZXRp
dGxlICJkdC1iaW5kaW5nczogZHJtL2JyaWRnZTogYW54NzYyNTogYWRkIGZvcmNlX2RzaV9lbmRf
d2l0aG91dF9udWxsIi4NCg0KSml0YW8gU2hpICgzKToNCiAgZHJtL2RzaTogdHJhbnNlciBkc2kg
aHMgcGFja2V0IGFsaWduZWQNCiAgZHJtL21lZGlhdGVrOiBpbXBsbWVudCB0aGUgZHNpIGhzIHBh
Y2tldHMgYWxpZ25lZA0KICBkcm0vYnJpZGdlOiBhbng3NjI1OiBjb25maWcgaHMgcGFja2V0cyBl
bmQgYWxpZ25lZCB0byBhdm9pZCBzY3JlZW4NCiAgICBzaGlmdA0KDQogZHJpdmVycy9ncHUvZHJt
L2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMgfCAgMSArDQogZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYyAgICAgICAgfCAxMCArKysrKysrKysrDQogaW5jbHVkZS9kcm0vZHJtX21p
cGlfZHNpLmggICAgICAgICAgICAgICAgfCAgMiArKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKQ0KDQotLSANCjIuMjUuMQ0K

