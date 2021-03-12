Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8D3387C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCLIkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:40:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35863 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232417AbhCLIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:39:49 -0500
X-UUID: 71576485641142e5aa9ab042a458adeb-20210312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ooolB54WEfgbIJQeSEoMg6RBJbHlc/MSHt7sIJf1I14=;
        b=dtgSGVVf2N0DxciA1yLPF8jCfRPP1t8MKi1K4RMRuB1gHARw6Nx4baw4XlQhkEWqQhvL6SDIEHez8Ng3GO/hmnghHDSaXVKoyvVO1nWVOb0dqTxz8uhVDJkvBawdpkAIsbcQJxox1qtjsrp3TPjbhlcxSGhBp6Wa1bjStIVK9YE=;
X-UUID: 71576485641142e5aa9ab042a458adeb-20210312
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1216615318; Fri, 12 Mar 2021 16:39:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar
 2021 16:39:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 16:39:38 +0800
Message-ID: <1615538378.26498.8.camel@mhfsdcap03>
Subject: Re: [PATCH][next] usb: mtu3: Fix spelling mistake "disabed" ->
 "disabled"
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Colin King <colin.king@canonical.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Mar 2021 16:39:38 +0800
In-Reply-To: <20210311092529.4898-1-colin.king@canonical.com>
References: <20210311092529.4898-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 487E2A8EC44F9185C890BAA7B2219ED185BF448F8161F73B2E49435334052B482000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTExIGF0IDA5OjI1ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhl
IHZhcmlhYmxlIHUzX3BvcnRzX2Rpc2FiZWQgY29udGFpbnMgYSBzcGVsbGluZyBtaXN0YWtlLA0K
PiByZW5hbWUgaXQgdG8gdTNfcG9ydHNfZGlzYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
b2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL210dTMvbXR1M19ob3N0LmMgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL210dTMvbXR1M19ob3N0LmMgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jDQo+
IGluZGV4IGM4NzFiOTRmM2U2Zi4uNDFhNTY3NWFjNWNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9tdHUzL210dTNfaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0
LmMNCj4gQEAgLTEwOSw3ICsxMDksNyBAQCBpbnQgc3N1c2JfaG9zdF9lbmFibGUoc3RydWN0IHNz
dXNiX210ayAqc3N1c2IpDQo+ICAJdm9pZCBfX2lvbWVtICppYmFzZSA9IHNzdXNiLT5pcHBjX2Jh
c2U7DQo+ICAJaW50IG51bV91M3AgPSBzc3VzYi0+dTNfcG9ydHM7DQo+ICAJaW50IG51bV91MnAg
PSBzc3VzYi0+dTJfcG9ydHM7DQo+IC0JaW50IHUzX3BvcnRzX2Rpc2FiZWQ7DQo+ICsJaW50IHUz
X3BvcnRzX2Rpc2FibGVkOw0KPiAgCXUzMiBjaGVja19jbGs7DQo+ICAJdTMyIHZhbHVlOw0KPiAg
CWludCBpOw0KPiBAQCAtMTE4LDEwICsxMTgsMTAgQEAgaW50IHNzdXNiX2hvc3RfZW5hYmxlKHN0
cnVjdCBzc3VzYl9tdGsgKnNzdXNiKQ0KPiAgCW10dTNfY2xyYml0cyhpYmFzZSwgVTNEX1NTVVNC
X0lQX1BXX0NUUkwxLCBTU1VTQl9JUF9IT1NUX1BETik7DQo+ICANCj4gIAkvKiBwb3dlciBvbiBh
bmQgZW5hYmxlIHUzIHBvcnRzIGV4Y2VwdCBza2lwcGVkIG9uZXMgKi8NCj4gLQl1M19wb3J0c19k
aXNhYmVkID0gMDsNCj4gKwl1M19wb3J0c19kaXNhYmxlZCA9IDA7DQo+ICAJZm9yIChpID0gMDsg
aSA8IG51bV91M3A7IGkrKykgew0KPiAgCQlpZiAoKDB4MSA8PCBpKSAmIHNzdXNiLT51M3BfZGlz
X21zaykgew0KPiAtCQkJdTNfcG9ydHNfZGlzYWJlZCsrOw0KPiArCQkJdTNfcG9ydHNfZGlzYWJs
ZWQrKzsNCj4gIAkJCWNvbnRpbnVlOw0KPiAgCQl9DQo+ICANCj4gQEAgLTE0MCw3ICsxNDAsNyBA
QCBpbnQgc3N1c2JfaG9zdF9lbmFibGUoc3RydWN0IHNzdXNiX210ayAqc3N1c2IpDQo+ICAJfQ0K
PiAgDQo+ICAJY2hlY2tfY2xrID0gU1NVU0JfWEhDSV9SU1RfQl9TVFM7DQo+IC0JaWYgKG51bV91
M3AgPiB1M19wb3J0c19kaXNhYmVkKQ0KPiArCWlmIChudW1fdTNwID4gdTNfcG9ydHNfZGlzYWJs
ZWQpDQo+ICAJCWNoZWNrX2NsayA9IFNTVVNCX1UzX01BQ19SU1RfQl9TVFM7DQpSZXZpZXdlZC1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MgYSBs
b3QNCg0KDQo+ICANCj4gIAlyZXR1cm4gc3N1c2JfY2hlY2tfY2xvY2tzKHNzdXNiLCBjaGVja19j
bGspOw0KDQo=

