Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55FE357C34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhDHGOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:14:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49476 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229552AbhDHGOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:14:22 -0400
X-UUID: c9a6fe7c5d9e47ef80b6c11c7ee23e54-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Iqf9QrO8MkLePhv/L1kye+La4KwF/Sa5szZLfVp1vXE=;
        b=uGrvtnauESL2DpUU+LgMHmqNVvwxI7irXCMz56ZHlZaAQdjmzv6iVWhoKWkHUkrYVakMPQdRLJ97ycgVHthbObDIFZAqodj9QLsEm1GWklSt4vTLsRVvuk/Y1mVmLwJkH4w0k7Mg0t/u+5YbTluR1so90+g2ELBdILbpJKFRGxc=;
X-UUID: c9a6fe7c5d9e47ef80b6c11c7ee23e54-20210408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 428261006; Thu, 08 Apr 2021 14:14:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 14:14:09 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 14:14:09 +0800
Message-ID: <1617862449.8874.16.camel@mtksdccf07>
Subject: Re: [PATCH v2 6/6] soc: mediatek: devapc: support mt8192
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Date:   Thu, 8 Apr 2021 14:14:09 +0800
In-Reply-To: <f52189e3-26b2-fd44-7059-f3bf0f79fbae@gmail.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
         <1617259087-5502-6-git-send-email-nina-cm.wu@mediatek.com>
         <f52189e3-26b2-fd44-7059-f3bf0f79fbae@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hdHRoaWFzDQoNCk9uIFR1ZSwgMjAyMS0wNC0wNiBhdCAxNTo1NSArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDAxLzA0LzIwMjEgMDg6MzgsIE5pbmEgV3Ugd3Jv
dGU6DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gQWRkIGNvbXBhdGlibGUgdG8gc3VwcG9ydCBtdDgxOTIuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiAN
Cj4gTG9va3MgZ29vZCwgSSdkIGxpa2UgdG8gc2VlIERUUyBmb3IgdGhpcyBhcyB3ZWxsLCBhbHRo
b3VnaCBJIHVuZGVyc3RhbmQgaXQNCj4gZGVwZW5kcyBvbiB0aGUgY2xvY2sgcGF0Y2ggc2VyaWVz
LiBQbGVhc2Ugbm90ZSBzbyBpbiBlaXRoZXIgYmVsb3cgdGhlICctLS0nIG9yDQo+IGluIGEgY292
ZXIgbGV0dGVyLg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQoNCkkgd2lsbCBhZGQg
ZGV2YXBjIG5vZGVzIGluIERUUyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNCg0KPiAN
Cj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jIHwgMTUgKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1kZXZhcGMuYw0KPiA+IGluZGV4IGFmNTVjMDEuLmE1YzE1YjUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jDQo+ID4gQEAgLTI1MSwxMSArMjUxLDI2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhIGRldmFwY19tdDY3NzkgPSB7
DQo+ID4gIAkudmlvX3NoaWZ0X2Nvbl9vZmZzZXQgPSAweEYyMCwNCj4gPiAgfTsNCj4gPiAgDQo+
ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhIGRldmFwY19tdDgxOTIgPSB7
DQo+ID4gKwkudmlvX21hc2tfb2Zmc2V0ID0gMHgwLA0KPiA+ICsJLnZpb19zdGFfb2Zmc2V0ID0g
MHg0MDAsDQo+ID4gKwkudmlvX2RiZzBfb2Zmc2V0ID0gMHg5MDAsDQo+ID4gKwkudmlvX2RiZzFf
b2Zmc2V0ID0gMHg5MDQsDQo+ID4gKwkudmlvX2RiZzJfb2Zmc2V0ID0gMHg5MDgsDQo+ID4gKwku
YXBjX2Nvbl9vZmZzZXQgPSAweEYwMCwNCj4gPiArCS52aW9fc2hpZnRfc3RhX29mZnNldCA9IDB4
RjIwLA0KPiA+ICsJLnZpb19zaGlmdF9zZWxfb2Zmc2V0ID0gMHhGMzAsDQo+ID4gKwkudmlvX3No
aWZ0X2Nvbl9vZmZzZXQgPSAweEYxMCwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kZXZhcGNfZHRfbWF0Y2hbXSA9IHsNCj4gPiAgCXsN
Cj4gPiAgCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktZGV2YXBjIiwNCj4gPiAgCQku
ZGF0YSA9ICZkZXZhcGNfbXQ2Nzc5LA0KPiA+ICAJfSwgew0KPiA+ICsJCS5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi1kZXZhcGMiLA0KPiA+ICsJCS5kYXRhID0gJmRldmFwY19tdDgxOTIs
DQo+ID4gKwl9LCB7DQo+ID4gIAl9LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiANCg0K

