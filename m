Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866053A5F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhFNJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:45:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44350 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232744AbhFNJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:45:36 -0400
X-UUID: 2280b04b37d64c36a56d8f194ed1c122-20210614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2A1f6XDFYkwNi91DySc3Su3T4fsohrPpjEGF06tNFnQ=;
        b=SBUeaOmz+99G+xVqEAXLyeMecqXktYYNXnqyV1pCb4fjdhH6ppbkCx4mUJf3m0l3fGnKJesr3wTrpQt/R7Csy2wgD1gSVt3ukNjj5e05noFfdKyjdH4Zc68gu8vt7iLFK2ylo6vS4drZfX0q2vqj4qfFnVpfryXnt3L2UGDzfJM=;
X-UUID: 2280b04b37d64c36a56d8f194ed1c122-20210614
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 527362104; Mon, 14 Jun 2021 17:43:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Jun 2021 17:43:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Jun 2021 17:43:29 +0800
Message-ID: <d23e965b271fea96b75bf72b888eb281e514237e.camel@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: pwarp: delete confusing comments
From:   James Lo <james.lo@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Mon, 14 Jun 2021 17:43:29 +0800
In-Reply-To: <20210611111307.29038-1-matthias.bgg@kernel.org>
References: <20210611111307.29038-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFuayB5b3UgZm9yIHlvdXIga2luZCBhc3Npc3RhbmNlLg0KDQpNYW55IHRoYW5rcw0KSmFt
ZXMgTG8NCg0KDQpPbiBGcmksIDIwMjEtMDYtMTEgYXQgMTM6MTMgKzAyMDAsIG1hdHRoaWFzLmJn
Z0BrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5i
Z2dAZ21haWwuY29tPg0KPiANCj4gQ29tbWVudHMgc3VnZ3Vlc3QgdGhhdCBNVDgxOTUgYXJiX2Vu
X2FsbCBhbmQgaW50X2VuX2FsbCB2YWx1ZXMgbmVlZA0KPiB0bw0KPiBiZSBjb25maXJtZWQuIEJ1
dCBhY3R1YWxseSB0aGVzZSB2YWx1ZXMgYXJlIGNvcnJlY3QuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6
IEphbWVzIExvIDxqYW1lcy5sb0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRo
aWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+ICBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQo+IGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQo+IGluZGV4IDk1MmJjNTU0ZjQ0My4uMTE4ZWI0YWNk
ZWI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMN
Cj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQo+IEBAIC0yMDQ3
LDggKzIwNDcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBtaWNfd3JhcHBlcl90eXBlDQo+IHB3
cmFwX210ODE4MyA9IHsNCj4gIHN0YXRpYyBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUgcHdyYXBf
bXQ4MTk1ID0gew0KPiAgCS5yZWdzID0gbXQ4MTk1X3JlZ3MsDQo+ICAJLnR5cGUgPSBQV1JBUF9N
VDgxOTUsDQo+IC0JLmFyYl9lbl9hbGwgPSAweDc3N2YsIC8qIE5FRUQgQ09ORklSTSAqLw0KPiAt
CS5pbnRfZW5fYWxsID0gMHgxODAwMDAsIC8qIE5FRUQgQ09ORklSTSAqLw0KPiArCS5hcmJfZW5f
YWxsID0gMHg3NzdmLA0KPiArCS5pbnRfZW5fYWxsID0gMHgxODAwMDAsDQo+ICAJLmludDFfZW5f
YWxsID0gMCwNCj4gIAkuc3BpX3cgPSBQV1JBUF9NQU5fQ01EX1NQSV9XUklURSwNCj4gIAkud2R0
X3NyYyA9IFBXUkFQX1dEVF9TUkNfTUFTS19BTEwsDQo=

