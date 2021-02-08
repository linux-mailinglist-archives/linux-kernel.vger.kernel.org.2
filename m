Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FC3128BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBHB1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:27:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:17632 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229537AbhBHB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:27:42 -0500
X-UUID: d549e7448dd746728b0d92fa4c801ba1-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sl//92WDlRI2iEMumUvSdGMbgPdcEp2dTyyazCq87oA=;
        b=MmAcPged8+tE2u5qb47KIkPBmuauPKQd/N6Cv4ZrKdsJVlARb/Bi/tHwdXpNo1c+CaYgcnONmxMhJm9Ogf4j/5nBukuhxpGhCVrTZTzoQEgoWcrfcdWFbizCBk2JKU2sjZQqnD6JELdn6EvYdjG7VBGCiUKfm0TDENdc0TM1qVs=;
X-UUID: d549e7448dd746728b0d92fa4c801ba1-20210208
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1766470181; Mon, 08 Feb 2021 09:26:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 09:26:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 09:26:55 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 0/3] Add check for max clock rate in mode_valid
Date:   Mon, 8 Feb 2021 09:26:50 +0800
Message-ID: <20210208012653.196060-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 389C30CDCE24BD49C6B921257EB9C1BAB2683597C6C1DC3A254BBE6F08A763CF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCiAtIGZpeCBidWlsZCBlcnIuDQoNCkppdGFvIFNoaSAoMyk6DQog
IGRybS9tZWRpYXRlazogbXRrX2RwaTogQWRkIGNoZWNrIGZvciBtYXggY2xvY2sgcmF0ZSBpbiBt
b2RlX3ZhbGlkDQogIGRybS9tZWRpYXRlazogbXRrX2RwaTogQWRkIGRwaSBjb25maWcgZm9yIG10
ODE5Mg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWssZHBpOiBhZGQgbXQ4MTkyIHRvIG1lZGlhdGVr
LGRwaQ0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgICAgICAgIHwg
IDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgICB8IDI2
ICsrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykN
Cg0KLS0gDQoyLjI1LjENCg==

