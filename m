Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1958A3128CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBHBnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:43:19 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229537AbhBHBnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:43:15 -0500
X-UUID: 455e940b5e0745df95ea443f54b6e5be-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L7LVdcpjTRLx50fmWNOp80798p9i+Ih9lUss/NrthBU=;
        b=f+CXlWN8Ee7rjqdoVHEFgyCYfy+hFn+IxtReM1NQLrDgd8lkI/F/X18x6w1wkSYaTpvz83xM6wpFs2mzI5pOQ3GgEnqVn6xvZfOejb+bnWdeMWadJ84z6YDVh9ptBlc3TSuX6BmgCF9ie0PLcfcOPWJpMgcl1H/DcKMF1lI/0aQ=;
X-UUID: 455e940b5e0745df95ea443f54b6e5be-20210208
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1956988484; Mon, 08 Feb 2021 09:42:31 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 09:42:27 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 09:42:26 +0800
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
Subject: [PATCH v3 3/3] dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi
Date:   Mon, 8 Feb 2021 09:42:21 +0800
Message-ID: <20210208014221.196584-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208014221.196584-1-jitao.shi@mediatek.com>
References: <20210208014221.196584-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D77FDA8D3AF38948613CEA8B5F6EF3C680E866C31445EDC383CC20160DE788D02000:8
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

