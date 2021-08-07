Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F328B3E32F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhHGD3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:29:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230236AbhHGD3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:29:11 -0400
X-UUID: d19d9935f1cd465da03a7f1738c18c11-20210807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BmNE7y7NrgqM2Smwx4znez/paXuFyhXlFjgphUZwtrM=;
        b=kJW9NCfRc2FGgqvn73VZXjzPGV3vYmZYiM1g5SsiQMY5jf14WhohV6m0vqUEFacrsZvJxC/Gg85w0wjAsjDe7CE0zICGFlxfQGHNbRRxAoWPcwj+8+ms0dCLe1VLzOf2A7IwQcbPrWjgcs0wN8P3pb/lGMW7OD480ZZqyNEWyGA=;
X-UUID: d19d9935f1cd465da03a7f1738c18c11-20210807
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 843724746; Sat, 07 Aug 2021 11:28:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 7 Aug 2021 11:28:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 7 Aug 2021 11:28:51 +0800
Message-ID: <1628306931.11590.0.camel@mtksdaap41>
Subject: Re: [PATCH v10 4/5] spmi: mediatek: Add support for MT8195
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Date:   Sat, 7 Aug 2021 11:28:51 +0800
In-Reply-To: <162827215909.1975443.852277412377742323@swboyd.mtv.corp.google.com>
References: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1627972461-2627-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <162827215909.1975443.852277412377742323@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgMjAyMS0wOC0wNiBhdCAxMDo0OSAtMDcwMCwgU3RlcGhlbiBCb3lkIHdy
b3RlOg0KPiBRdW90aW5nIEhzaW4tSHNpdW5nIFdhbmcgKDIwMjEtMDgtMDIgMjM6MzQ6MjApDQo+
ID4gRnJvbTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+
IEFkZCBzcG1pIHN1cHBvcnQgZm9yIE1UODE5NS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
ZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBNaXNzaW5nIFNpZ25l
ZC1vZmYtYnkgZnJvbSBoc2luLWhzaXVuZy53YW5nIGhlcmUNCj4gDQoNClNvcnJ5IGZvciB0aGUg
bWlzc2luZy4gSSB3aWxsIGFkZCBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCg0KVGhhbmtzLg0KDQo+
ID4gLS0tDQo+ID4gY2hhbmdlcyBzaW5jZSB2OToNCj4gPiAtIE5vIGNoYW5nZS4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9zcG1pL3NwbWktbXRrLXBtaWYuYyB8IDkwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygr
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwbWkvc3BtaS1tdGstcG1pZi5jIGIv
ZHJpdmVycy9zcG1pL3NwbWktbXRrLXBtaWYuYw0KPiA+IGluZGV4IDk0YzQ1ZDQ2YWIwYy4uMGMz
MjA4MDFjOWQ1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BtaS9zcG1pLW10ay1wbWlmLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NwbWkvc3BtaS1tdGstcG1pZi5jDQo+ID4gQEAgLTM0OCw2ICs0
MjcsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbWlmX2RhdGEgbXQ2ODczX3BtaWZfYXJiID0g
ew0KPiA+ICAgICAgICAgLnNvY19jaGFuID0gMiwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgcG1pZl9kYXRhIG10ODE5NV9wbWlmX2FyYltdID0gew0KPiANCj4gVGhp
cyBpcyBhbiBhcnJheSBvZiB0eXBlIHBtaWZfZGF0YS4NCj4gDQo+ID4gKyAgICAgICB7DQo+ID4g
KyAgICAgICAgICAgICAgIC5yZWdzID0gbXQ4MTk1X3JlZ3MsDQo+ID4gKyAgICAgICAgICAgICAg
IC5zcG1pbXN0X3JlZ3MgPSBtdDgxOTVfc3BtaV9yZWdzLA0KPiA+ICsgICAgICAgICAgICAgICAu
c29jX2NoYW4gPSAyLA0KPiA+ICsgICAgICAgfSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRp
YyBpbnQgbXRrX3NwbWlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
ew0KPiA+ICAgICAgICAgc3RydWN0IHBtaWYgKmFyYjsNCj4gPiBAQCAtNDQ0LDYgKzUzMSw5IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zcG1pX21hdGNoX3RhYmxlW10g
PSB7DQo+ID4gICAgICAgICB7DQo+ID4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10Njg3My1zcG1pIiwNCj4gPiAgICAgICAgICAgICAgICAgLmRhdGEgPSAmbXQ2ODcz
X3BtaWZfYXJiLA0KPiANCj4gbXQ2ODczX3BtaWZfYXJiIGlzIG5vdCBhbiBhcnJheSwgc2VlIHRo
ZSBjb250ZXh0IGhlYWRlciBhYm92ZS4NCj4gDQo+IEhvdyBkb2VzIHRoaXMgd29yaz8gSGFzIHRo
aXMgYmVlbiB0ZXN0ZWQ/DQo+IA0KPiA+ICsgICAgICAgfSwgew0KPiA+ICsgICAgICAgICAgICAg
ICAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtc3BtaSIsDQo+ID4gKyAgICAgICAgICAg
ICAgIC5kYXRhID0gJm10ODE5NV9wbWlmX2FyYiwNCj4gPiAgICAgICAgIH0sIHsNCj4gPiAgICAg
ICAgICAgICAgICAgLyogc2VudGluZWwgKi8NCj4gPiAgICAgICAgIH0sDQo+ID4gLS0gDQo+ID4g
Mi4xOC4wDQo+ID4NCg0K

