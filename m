Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7367F34ECF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhC3Px7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:53:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24607 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231701AbhC3Pxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:53:44 -0400
X-UUID: 68dcdb3177154cbb8943de9739b3a6ed-20210330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4YzdudEdCk+lFWt6sVccaETJQnqeW12pie3L8oFD3r8=;
        b=b8N5ZisGvF8NSZNUCRYpyjEUynLH0+MBMiIzijPP/c5hDY3wT1hKfOITuBhDF+o9WEPfTCF2GBoIMrkm1I3Oy8y9gbI8OaD2jcsVWCBcVs2h2Y0EsGTERiw+S3NfxriQUMcERFvElofao0MoaEiK9M5rHK/VdJ2go+TU/x7sJkQ=;
X-UUID: 68dcdb3177154cbb8943de9739b3a6ed-20210330
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 941546127; Tue, 30 Mar 2021 23:53:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 23:53:33 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Mar 2021 23:53:32 +0800
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
        <rex-bc.chen@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 0/3] mt8183 dpi supports dual edge
Date:   Tue, 30 Mar 2021 23:53:27 +0800
Message-ID: <20210330155330.28759-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 062A074E46B29BE86D2FE9AEBA96F717ABFCF815EDBC8C4A66EF4BD7AC0730FF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFBJIGNhbiBzYW1wbGUgb24gZmFsbGluZywgcmlzaW5nIG9yIGJvdGggZWRnZS4NCldoZW4gRFBJ
IHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KSXQgY2FuIHJl
ZHVjZSBoYWxmIGRhdGEgaW8gcGlucy4NCg0KSml0YW8gU2hpICgzKToNCiAgZHJtL21lZGlhdGVr
OiBkcGkgZHVhbCBlZGdlIHNhbXBsZSBtb2RlIHN1cHBvcnQNCiAgZHJtL21lZGlhdGVrOiBjb25m
aWcgbXQ4MTgzIGRyaXZlciBkYXRhIHRvIHN1cHBvcnQgZHVhbCBlZGdlIHNhbXBsZQ0KICBkcm0v
bWVkaWF0ZWs6IGRwaTogYWRkIGJ1cyBmb3JtYXQgbmVnb2NpYXRpb24NCg0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxMDkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCg0KLS0gDQoyLjEyLjUNCg==

