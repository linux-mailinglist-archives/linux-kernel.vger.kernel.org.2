Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829F34C1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC2Ci2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:38:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230209AbhC2CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:38:08 -0400
X-UUID: c454a20bfbdf47bf898bc1848c9f2b44-20210329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VdVEz2wKHTnKSOp+VNzzGg9amBOswHbORRfeY500MUo=;
        b=fm3bM6vF4lwuCzzIbz8jKvVOJIbhL1VMSKkyzPqTuU6+aXxsXo0GUyn4cMCQGmWqFYnjogFb5DOjEctNzPcaMvDN0c+XpFXX9WCyNDDyVDiIHcq2AYpaJm7XUEmio/WH7EDTMcfp0bt7yCWnjY0I+hQNtYFE5AfL7fx7SLZzPOQ=;
X-UUID: c454a20bfbdf47bf898bc1848c9f2b44-20210329
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1172350892; Mon, 29 Mar 2021 10:38:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Mar 2021 10:38:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Mar 2021 10:38:00 +0800
Message-ID: <1616985480.26412.4.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Neal Liu <neal.liu@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <Jackson-kt.Chang@mediatek.com>
Date:   Mon, 29 Mar 2021 10:38:00 +0800
In-Reply-To: <1616771454.300082.3384056.nullmailer@robh.at.kernel.org>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
         <1616771454.300082.3384056.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpJIGp1c3QgZm91bmQgdGhhdCB0aGVyZSBpcyB0aGUgdW4tbWVyZ2VkIGRlcGVu
ZGVudCBwYXRjaC4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1t
ZWRpYXRlay9wYXRjaC8yMDIxMDMyNDEwNDExMC4xMzM4My03LWNodW4tamllLmNoZW5AbWVkaWF0
ZWsuY29tLw0KDQpJIHdpbGwgYWRkIHRoaXMgdG8gY29tbWl0IG1lc3NhZ2UgaW4gdGhlIG5leHQg
dmVyc2lvbi4NCg0KVGhhbmtzDQoNCk9uIEZyaSwgMjAyMS0wMy0yNiBhdCAwOToxMCAtMDYwMCwg
Um9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIEZyaSwgMjYgTWFyIDIwMjEgMTU6MzE6MTAgKzA4MDAs
IE5pbmEgV3Ugd3JvdGU6DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5j
b20+DQo+ID4gDQo+ID4gVG8gc3VwcG9ydCBuZXdlciBoYXJkd2FyZSBhcmNoaXRlY3R1cmUgb2Yg
ZGV2YXBjLA0KPiA+IHVwZGF0ZSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBOaW5hIFd1IDxOaW5hLUNNLld1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sICAgfCA0
MSArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRp
b25zKCspDQo+ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRf
YmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vy
cm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IC9idWlsZHMvcm9i
aGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbDogcHJvcGVydGllczp2ZXJzaW9uOmVudW06IEZhbHNl
IHNjaGVtYSBkb2VzIG5vdCBhbGxvdyBbMSwgMl0NCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4
LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVr
L2RldmFwYy55YW1sOiBwcm9wZXJ0aWVzOnNsYXZlX3R5cGVfbnVtOmVudW06IEZhbHNlIHNjaGVt
YSBkb2VzIG5vdCBhbGxvdyBbMSwgNF0NCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4LWR0LXJl
dmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFw
Yy55YW1sOiBpZ25vcmluZywgZXJyb3IgaW4gc2NoZW1hOiBwcm9wZXJ0aWVzOiBzbGF2ZV90eXBl
X251bTogZW51bQ0KPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91bmQgaW4gZmlsZTogLi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLmV4YW1w
bGUuZHRzOjUxOjE4OiBmYXRhbCBlcnJvcjogZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5o
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ICAgIDUxIHwgICAgICAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KPiAgICAgICB8ICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gY29tcGlsYXRpb24gdGVybWlu
YXRlZC4NCj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmxpYjozNDk6IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLmV4YW1wbGUuZHQu
eWFtbF0gRXJyb3IgMQ0KPiBtYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLg0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjEzODA6IGR0X2JpbmRpbmdfY2hlY2tdIEVycm9y
IDINCj4gDQo+IFNlZSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wYXRjaC8xNDU4Njg3X187ISFDVFJOS0E5d01nMEFSYnchelptam03NExl
ZWU4by1lYVFVQl95SFl2aC02Nmc4OFJnam96dl9lY1Nrd1cteWZvN0dfYzlvNi1wMEpsRmZzdDNW
SSQgDQo+IA0KPiBUaGlzIGNoZWNrIGNhbiBmYWlsIGlmIHRoZXJlIGFyZSBhbnkgZGVwZW5kZW5j
aWVzLiBUaGUgYmFzZSBmb3IgYSBwYXRjaA0KPiBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBtb3N0
IHJlY2VudCByYzEuDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19j
aGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3Vy
ZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6
DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hl
Y2sgYW5kIHJlLXN1Ym1pdC4NCj4gDQoNCg==

