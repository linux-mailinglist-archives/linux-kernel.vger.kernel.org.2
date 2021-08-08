Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685B63E3A48
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhHHMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 08:52:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40533 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231169AbhHHMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 08:52:48 -0400
X-UUID: 1f005c3ed4e0475ba224abbeefb6c475-20210808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eBKwn3UIs1bNPL1Ouc323k00v/xyunt4iMB9qsdRbMw=;
        b=rVMJGgCsyA88gF7b5OhhOWIqwIjQ+6k1ATXHjkbguR7ce5v2OcSI5FZKIMO/QL0yWNhEGAm61RsIqzMFVEfvOynMqVJGjkaZEVwp8oznE6QojEiy+LQeMh3jRtHmt30cOB4ZrYsOvNNFPhOeXAhIvzrhOLZwnEA5SvObzCQi/04=;
X-UUID: 1f005c3ed4e0475ba224abbeefb6c475-20210808
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 530120722; Sun, 08 Aug 2021 20:52:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 20:52:20 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 8 Aug 2021 20:52:19 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 0/3] seperate panel power control from panel prepare/unprepare
Date:   Sun, 8 Aug 2021 20:52:15 +0800
Message-ID: <20210808125218.63029-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DE77C0201CE914943298746E6C2A3EE716D29A464B218995FB944623E5021A742000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCiAtIEZpeCBudWxsIHBvaW50IHdoZW4gZHNpIG5leHQgYnJpZGdl
IGlzbid0IGEgcGFuZWwuDQogLSAiZHNpIG1tc3lzIHJlc2V0IiBpcyBpbXBsZW1lbnQgYnkNCiAg
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0
Lz9zZXJpZXM9NTE1MzU1DQoNCkppdGFvIFNoaSAoMyk6DQogIGRybS9wYW5lbDogc2VwZXJhdGUg
cGFuZWwgcG93ZXIgY29udHJvbCBmcm9tIHBhbmVsIHByZXBhcmUvdW5wcmVwYXJlDQogIGRybS9w
YW5lbDogYm9lLXR2MTAxd3VtLW4xNiBzZXBlcmF0ZSB0aGUgcGFuZWwgcG93ZXIgY29udHJvbA0K
ICBkcm0vbWVkaWF0ZWs6IGZpbmUgdHVuZSB0aGUgZHNpIHBhbmVsJ3MgcG93ZXIgc2VxdWVuY2UN
Cg0KIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvcGFuZWwuYyAgICAgICAgICAgICAgICB8IDE3ICsr
KysrDQogZHJpdmVycy9ncHUvZHJtL2RybV9wYW5lbC5jICAgICAgICAgICAgICAgICAgIHwgMzgg
KysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgICAgICAgICAg
ICB8IDI5ICsrKysrKy0tDQogLi4uL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5s
Ni5jICAgIHwgNzIgKysrKysrKysrKysrKy0tLS0tLQ0KIGluY2x1ZGUvZHJtL2RybV9icmlkZ2Uu
aCAgICAgICAgICAgICAgICAgICAgICB8ICAyICsNCiBpbmNsdWRlL2RybS9kcm1fcGFuZWwuaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAxNyArKysrKw0KIDYgZmlsZXMgY2hhbmdlZCwgMTQ4IGlu
c2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjUuMQ0K

