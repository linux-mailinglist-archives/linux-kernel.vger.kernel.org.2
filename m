Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0366D3D5133
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhGZBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 21:30:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47205 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230272AbhGZBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 21:30:52 -0400
X-UUID: bb83b93e7d30446a957bb5905b6ff50e-20210726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yslLm1vymujKFarhO3A6h6EAP8QMCCeSyOC9SgSoByQ=;
        b=HXEze7R926+axNQTFL/y9nSa870dUfBaUPsWrAFsSi8cRLwRgWT1nW+ANizDFX3toJ3lkfHvj1tohEgcw6lIHW6sraxyYcrfkImJtZUGb+ZgPevtp2RSGE98IMJyQFb0d3o0yj8foaG1m31qTlQhOeoHG9lIVWvvqxH1ayBbuEo=;
X-UUID: bb83b93e7d30446a957bb5905b6ff50e-20210726
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 892610681; Mon, 26 Jul 2021 10:11:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Jul
 2021 10:11:09 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 26 Jul 2021 10:11:08 +0800
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
Subject: [PATCH v3 2/2] dt-bindings: mediatek: add force_dsi_end_without_null for dsi
Date:   Mon, 26 Jul 2021 10:11:04 +0800
Message-ID: <20210726021104.80007-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726021104.80007-1-jitao.shi@mediatek.com>
References: <20210726021104.80007-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 57D432427D8170D0E97DD4E151E61F3C5A53BC80ABE18CDC438CC901559AF70F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBicmlkZ2UgY2hpcCB3aWxsIHNoaWZ0IHNjcmVlbiB3aGVuIHRoZSBkc2kgZGF0YSBkb2Vz
J3QgZW50IGF0DQp0aGUgc2FtZSB0aW1lIGluIGxpbmUuDQoNClNpZ25lZC1vZmYtYnk6IEppdGFv
IFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgfCA0ICsrKysNCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWssZHNpLnR4dA0KaW5kZXggODIzOGE4NjY4NmJlLi4xYzJmNTNmM2FjM2QgMTAwNjQ0DQotLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkc2kudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQpAQCAtMTksNiArMTksMTAgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncmFw
aC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29ubmVjdGVkDQogICB0byB0aGUgaW5wdXQgcG9y
dCBvZiBhbiBhdHRhY2hlZCBEU0kgcGFuZWwgb3IgRFNJLXRvLWVEUCBlbmNvZGVyIGNoaXAuDQog
DQorT3B0aW9uYWwgcHJvcGVydGllczoNCistIGZvcmNlX2RzaV9lbmRfd2l0aG91dF9udWxsOiBT
b21lIGJyaWRnZSBjaGlwKGV4LiBBTlg3NjI1KSByZXF1aXJlcyB0aGUNCisgIHBhY2tldHMgb24g
bGFuZXMgYWxpZ25lZCBhdCB0aGUgZW5kLg0KKw0KIE1JUEkgVFggQ29uZmlndXJhdGlvbiBNb2R1
bGUNCiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogDQotLSANCjIuMjUuMQ0K

