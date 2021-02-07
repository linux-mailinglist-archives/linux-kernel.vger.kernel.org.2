Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75736312471
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBGM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:59:46 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34418 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229561AbhBGM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:59:44 -0500
X-UUID: 483e0078c4c3490fab7db8ed8071f27d-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L7LVdcpjTRLx50fmWNOp80798p9i+Ih9lUss/NrthBU=;
        b=PRbtn8Hiyu5FLamNeYgtrjCXz9QtbOo2TreFXUvc3ip6FHN3WzGeVhwx1GjtjLUD6p1XA2dZG/N35fpHv0gQav4VplUCi3HpinluD6fFFsZKxknZ95NKPQ6rDjpQ30d/QLauv9lgDfrrEobzBqv082WHaGmMLHMl77C+z3uuGcY=;
X-UUID: 483e0078c4c3490fab7db8ed8071f27d-20210207
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 832873051; Sun, 07 Feb 2021 20:59:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 20:58:55 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 20:58:54 +0800
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
Subject: [PATCH 3/3] dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi
Date:   Sun, 7 Feb 2021 20:58:50 +0800
Message-ID: <20210207125850.155979-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207125850.155979-1-jitao.shi@mediatek.com>
References: <20210207125850.155979-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ADCE432E9AA4311298B6578DD086A0B75C13822F160FB763BD36126E4111F30A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNvbXBhdGlibGUgIm1lZGlhdGVrLG10ODE5Mi1kcGkiIGZvciB0aGUgbXQ4MTkyIGRwaS4N
Cg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0t
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGku
eWFtbCAgICAgICB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHBpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KaW5kZXggNmNkYjczNGM5MWE5Li4y
ZjU2NmYxOWU2ZTAgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwN
CkBAIC0yMiw2ICsyMiw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgLSBtZWRpYXRlayxtdDc2MjMt
ZHBpDQogICAgICAgLSBtZWRpYXRlayxtdDgxNzMtZHBpDQogICAgICAgLSBtZWRpYXRlayxtdDgx
ODMtZHBpDQorICAgICAgLSBtZWRpYXRlayxtdDgxOTItZHBpDQogDQogICByZWc6DQogICAgIG1h
eEl0ZW1zOiAxDQotLSANCjIuMjUuMQ0K

