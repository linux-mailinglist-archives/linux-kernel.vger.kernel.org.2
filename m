Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A0312472
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBGM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:59:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229536AbhBGM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:59:45 -0500
X-UUID: bfe2f688472a4d1eb5c8d70a79271b52-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QLNscCM4wsQMv3eq+zALW0d8AAKHMikMVrsEX23/lO4=;
        b=IP/PkTxSJosnvt3rv63Z+xL0zV/cLDpmRIKpX7QxFVVkOjwti/DXqC/m4WW1rcOqK08ucAuM9enjzH/oOM4gCmjRs/RFeP1n4NSwXIqm2BSckhJsqfg6CNIA/ZfmDzpaWEjTYuEsmTzF3FWDQqvrRZKBtaDSF0sBzV1ClaFbmN0=;
X-UUID: bfe2f688472a4d1eb5c8d70a79271b52-20210207
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1340075499; Sun, 07 Feb 2021 20:58:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 20:58:52 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 20:58:51 +0800
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
Subject: [PATCH 0/3] Add check for max clock rate in mode_valid
Date:   Sun, 7 Feb 2021 20:58:47 +0800
Message-ID: <20210207125850.155979-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A3BBACAF5CC47D71965CAB1DB8605E5CB53589E2F1F23802461841E15CEBCFD52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sml0YW8gU2hpICgzKToNCiAgZHJtL21lZGlhdGVrOiBtdGtfZHBpOiBBZGQgY2hlY2sgZm9yIG1h
eCBjbG9jayByYXRlIGluIG1vZGVfdmFsaWQNCiAgZHJtL21lZGlhdGVrOiBtdGtfZHBpOiBBZGQg
ZHBpIGNvbmZpZyBmb3IgbXQ4MTkyDQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlayxkcGk6IGFkZCBt
dDgxOTIgdG8gbWVkaWF0ZWssZHBpDQoNCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cGkueWFtbCAgICAgICAgfCAgMSArDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
YyAgICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMjUuMQ0K

