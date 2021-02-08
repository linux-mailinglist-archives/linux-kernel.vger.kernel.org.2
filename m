Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B400E3128BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBHB14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:27:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21290 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229618AbhBHB1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:27:46 -0500
X-UUID: f78ce9460e154e3cadc416e0717d58e6-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L7LVdcpjTRLx50fmWNOp80798p9i+Ih9lUss/NrthBU=;
        b=jbuL3gDRN8TAtpCnbYDvSQT3QMuzPwyMioWlcJpdnU4xN4FwO3MMoFSY4vTmW8S7M45h4EYbLOGTFF/HxJ47fxl+rEh/LAs7e4dgaFZdNWrsmsERIDYJKRu3EGk/eDzCka0DOqTd6LXrBCgBDW054XEmShOa0x6PyAEth2W1xNs=;
X-UUID: f78ce9460e154e3cadc416e0717d58e6-20210208
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2156666; Mon, 08 Feb 2021 09:27:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 09:26:59 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 09:26:58 +0800
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
Subject: [PATCH v2 3/3] dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi
Date:   Mon, 8 Feb 2021 09:26:53 +0800
Message-ID: <20210208012653.196060-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208012653.196060-1-jitao.shi@mediatek.com>
References: <20210208012653.196060-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B649D45953B1C84CB86819603152F0DA615BE01E44E72C18E594A859D23335072000:8
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

