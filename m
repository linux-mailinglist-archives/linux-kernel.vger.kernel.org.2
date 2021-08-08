Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D073E3A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhHHNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 09:41:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:64359 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231398AbhHHNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 09:41:47 -0400
X-UUID: e320f5f0132546dcb3a06609724e702b-20210808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zgXBVMkErYtlndRrYAcIE2/ctnIm3RbnsXLRy22+1gE=;
        b=K+PYnk2yOOkfzVsWTAy/Gje6uJKwCuOl0vipnP9nWYvTW+HWJbZTqTSJWFuIaCid4uUPrCJ3ekivtuo+W/iaAbJ/Dfz8Lomyyaa/PP7H6G/aw2cSjmNY/LOjjujwckPsPkt0rItvbvtcbBtQMfc6Gq2tlV8BDL2l1o3ptVlLcA8=;
X-UUID: e320f5f0132546dcb3a06609724e702b-20210808
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 218762132; Sun, 08 Aug 2021 21:41:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 21:41:21 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 8 Aug 2021 21:41:20 +0800
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
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 0/1] force hsa hbp hfp packets multiple of lanenum to avoid screen shift
Date:   Sun, 8 Aug 2021 21:41:16 +0800
Message-ID: <20210808134117.66798-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1EDDD48C2312284FBB3B3188A14DEC3EE95249394A56DDF90C90160F206A21302000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NToNCiAtIFJlbXZvZSB0aGUgYW54NzYyNSBkZXZpY2V0cmVlIGNoYW5n
ZS4gVXNlIHRoZSBjb21wYXRpYmxlIHN0cmluZyBpbnRlYWQuDQoNCkNoYW5nZXMgc2luY2UgdjQ6
DQogLSBNb3ZlICJkdC1iaW5kaW5nczogZHJtL2JyaWRnZTogYW54NzYyNTogYWRkIGZvcmNlX2Rz
aV9lbmRfd2l0aG91dF9udWxsIiBiZWZvcmUNCiAgICJkcm0vbWVkaWF0ZWs6IGZvcmNlIGhzYSBo
YnAgaGZwIHBhY2tldHMgbXVsdGlwbGUgb2YgbGFuZW51bSB0byBhdm9pZCIuDQoNCiAtIFJldGl0
bGUgImR0LWJpbmRpbmdzOiBkcm0vYnJpZGdlOiBhbng3NjI1OiBhZGQgZm9yY2VfZHNpX2VuZF93
aXRob3V0X251bGwiLg0KDQpKaXRhbyBTaGkgKDEpOg0KICBkcm0vbWVkaWF0ZWs6IGZvcmNlIGhz
YSBoYnAgaGZwIHBhY2tldHMgbXVsdGlwbGUgb2YgbGFuZW51bSB0byBhdm9pZA0KICAgIHNjcmVl
biBzaGlmdA0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDEzICsrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMjUu
MQ0K

