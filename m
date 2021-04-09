Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4A35917F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhDIBeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:34:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5682 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232967AbhDIBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:34:17 -0400
X-UUID: f9ec6726a810486ca8487a393e0a7ffe-20210409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QlQV/IjGGqn8yZBn7TzzTKt2J3XWX4ZDL0hPjNElmPk=;
        b=XO4qE+DO9QylqmUgxDWhuDixTsvO9ot0/QhlwC20bPZrypM/ZZcXOsSitQgMDjZQCPdbkFSI3HHtKbOV6FTlHRRpM4QGRGIYMPsyltZyUWoYo42MT4uCq66rfxS041mZW5AZAJcZJIsL/xL3cK2qBZiWuUtTT9QI5XvqiBOWpIA=;
X-UUID: f9ec6726a810486ca8487a393e0a7ffe-20210409
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 531900260; Fri, 09 Apr 2021 09:34:03 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 09:34:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 09:34:00 +0800
Message-ID: <1617932040.12105.11.camel@mhfsdcap03>
Subject: Re: [PATCH v2 -next] phy: phy-mtk-hdmi: Remove redundant dev_err
 call in mtk_hdmi_phy_probe()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     He Ying <heying24@huawei.com>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <kishon@ti.com>, <vkoul@kernel.org>, <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Fri, 9 Apr 2021 09:34:00 +0800
In-Reply-To: <20210408115530.15673-1-heying24@huawei.com>
References: <20210408115530.15673-1-heying24@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FB4F945084C6864C1700CE1A8C0D5AD93A629F8E0CEFB464A6F6F98223C2952B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTA4IGF0IDA3OjU1IC0wNDAwLCBIZSBZaW5nIHdyb3RlOg0KPiBUaGVy
ZSBpcyBhIGVycm9yIG1lc3NhZ2Ugd2l0aGluIGRldm1faW9yZW1hcF9yZXNvdXJjZQ0KPiBhbHJl
YWR5LCBzbyByZW1vdmUgdGhlIGRldl9lcnIgY2FsbCB0byBhdm9pZCByZWR1bmRhbnQNCj4gZXJy
b3IgbWVzc2FnZS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2Vp
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGUgWWluZyA8aGV5aW5nMjRAaHVhd2VpLmNvbT4NCj4g
LS0tDQo+IHYyOg0KPiAtIFVzZSAncmV0dXJuIFBUUl9FUlIoKScgaW5zdGVhZCBvZiAncmV0ID0g
UFRSX0VSUigpO3JldHVybiByZXQ7Jy4NCj4gDQo+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHkt
bXRrLWhkbWkuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstaGRtaS5jIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pLmMNCj4gaW5k
ZXggODMxM2JkNTE3ZTRjLi44YWQ4ZjcxN2VmNDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGh5
L21lZGlhdGVrL3BoeS1tdGstaGRtaS5jDQo+ICsrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstaGRtaS5jDQo+IEBAIC0xMTksOSArMTE5LDcgQEAgc3RhdGljIGludCBtdGtfaGRtaV9w
aHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAltZW0gPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAgCWhkbWlfcGh5LT5y
ZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCj4gIAlpZiAoSVNfRVJSKGhk
bWlfcGh5LT5yZWdzKSkgew0KPiAtCQlyZXQgPSBQVFJfRVJSKGhkbWlfcGh5LT5yZWdzKTsNCj4g
LQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IG1lbW9yeSByZXNvdXJjZTogJWRcbiIsIHJl
dCk7DQo+IC0JCXJldHVybiByZXQ7DQo+ICsJCXJldHVybiBQVFJfRVJSKGhkbWlfcGh5LT5yZWdz
KTsNCj4gIAl9DQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KDQpUaGFua3MgYSBsb3QNCj4gIA0KPiAgCXJlZl9jbGsgPSBkZXZtX2Nsa19nZXQo
ZGV2LCAicGxsX3JlZiIpOw0KDQo=

