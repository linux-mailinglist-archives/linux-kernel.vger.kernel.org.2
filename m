Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0834DD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC3BGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:06:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56250 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230202AbhC3BGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:06:40 -0400
X-UUID: db084fc00fb74977aa5c34dc16a2e480-20210330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eIwgc0r+QIYxa5BYwiIyGnWzADT9Ny1eTWElVufgXQA=;
        b=R+ERG0/MSmU6Ql4mz3kIyZLwLgD4NgH/0VznsLh+ODR3M7+aPeDjvhfCNTQkYJfK/hZJfQgcXs1DPLjWMnnJ1pJR4VDjYIZKnf3jtyxDfcjaAtgcJztlLbk3sdbuOVbg80RsWsz8LD1Fta9uydz5nk2GC3zLCIOrjodBD17O09g=;
X-UUID: db084fc00fb74977aa5c34dc16a2e480-20210330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1520473993; Tue, 30 Mar 2021 09:06:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 09:06:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 09:06:35 +0800
Message-ID: <1617066395.9554.12.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <nina-cm.wu@mediatek.com>
Date:   Tue, 30 Mar 2021 09:06:35 +0800
In-Reply-To: <8417423c-0462-f3af-b3a0-2af638850d51@gmail.com>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
         <8417423c-0462-f3af-b3a0-2af638850d51@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hdHRoaWFzDQoNCk9uIE1vbiwgMjAyMS0wMy0yOSBhdCAxMzoxNiArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDI2LzAzLzIwMjEgMDg6MzEsIE5pbmEgV3Ugd3Jv
dGU6DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gVG8gc3VwcG9ydCBuZXdlciBoYXJkd2FyZSBhcmNoaXRlY3R1cmUgb2YgZGV2YXBjLA0KPiA+
IHVwZGF0ZSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
aW5hIFd1IDxOaW5hLUNNLld1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sICAgfCA0MSArKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
bWVkaWF0ZWsvZGV2YXBjLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gaW5kZXggMzFlNGQzYy4uNDg5ZjZhOSAxMDA2
NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlh
dGVrL2RldmFwYy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KPiA+IEBAIC0yMCw5ICsyMCwyNyBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICBlbnVtOg0KPiA+ICAgICAgICAt
IG1lZGlhdGVrLG10Njc3OS1kZXZhcGMNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxOTItZGV2
YXBjDQo+ID4gKw0KPiA+ICsgIHZlcnNpb246DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHZl
cnNpb24gb2YgdGhlIGhhcmR3YXJlIGFyY2hpdGVjdHVyZQ0KPiA+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBlbnVtOiBbMSwgMl0N
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHNsYXZlX3R5cGVfbnVtOg0KPiA+
ICsgICAgZGVzY3JpcHRpb246IFRoZSBudW1iZXIgb2YgdGhlIGRldmFwYyBzZXQNCj4gPiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAg
ZW51bTogWzEsIDRdDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICANCj4gPiAgICByZWc6DQo+
ID4gICAgICBkZXNjcmlwdGlvbjogVGhlIGJhc2UgYWRkcmVzcyBvZiBkZXZhcGMgcmVnaXN0ZXIg
YmFuaw0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gPiArDQo+ID4gKyAgdmlvX2lkeF9udW06DQo+
ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIG51bWJlciBvZiB0aGUgZGV2aWNlcyBjb250cm9sbGVk
IGJ5IGRldmFwYw0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvdWludDMyLWFycmF5DQo+IA0KPiBUaGlzIGNhbiBhbGwgcGVyIGNvbXBhdGlibGUgRFQgZGF0
YSBvYmplY3RzIGluIHRoZSBkcml2ZXIuIERvbid0IGFkZCBuZXcNCj4gcHJvcGVydGllcyBoZXJl
Lg0KDQpJIHdpbGwgdHJ5IHRvIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uDQpUaGFua3MN
Cg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiAgICAgIG1heEl0ZW1zOiAx
DQo+ID4gIA0KPiA+ICAgIGludGVycnVwdHM6DQo+ID4gQEAgLTM5LDcgKzU3LDEwIEBAIHByb3Bl
cnRpZXM6DQo+ID4gIA0KPiA+ICByZXF1aXJlZDoNCj4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiAr
ICAtIHZlcnNpb24NCj4gPiArICAtIHNsYXZlX3R5cGVfbnVtDQo+ID4gICAgLSByZWcNCj4gPiAr
ICAtIHZpb19pZHhfbnVtDQo+ID4gICAgLSBpbnRlcnJ1cHRzDQo+ID4gICAgLSBjbG9ja3MNCj4g
PiAgICAtIGNsb2NrLW5hbWVzDQo+ID4gQEAgLTUzLDggKzc0LDI4IEBAIGV4YW1wbGVzOg0KPiA+
ICANCj4gPiAgICAgIGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCj4gPiAgICAgICAgY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktZGV2YXBjIjsNCj4gPiArICAgICAgdmVyc2lvbiA9IDwx
PjsNCj4gPiArICAgICAgc2xhdmVfdHlwZV9udW0gPSA8MT47DQo+ID4gICAgICAgIHJlZyA9IDww
eDEwMjA3MDAwIDB4MTAwMD47DQo+ID4gKyAgICAgIHZpb19pZHhfbnVtID0gPDUxMT47DQo+ID4g
ICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxNjggSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4g
PiAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfREVWSUNFX0FQQz47DQo+
ID4gICAgICAgIGNsb2NrLW5hbWVzID0gImRldmFwYy1pbmZyYS1jbG9jayI7DQo+ID4gICAgICB9
Ow0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL2FybS1naWMuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9j
ay9tdDgxOTItY2xrLmg+DQo+ID4gKw0KPiA+ICsgICAgZGV2YXBjOiBkZXZhcGNAMTAyMDcwMDAg
ew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWRldmFwYyI7DQo+
ID4gKyAgICAgICAgdmVyc2lvbiA9IDwyPjsNCj4gPiArICAgICAgICBzbGF2ZV90eXBlX251bSA9
IDw0PjsNCj4gPiArICAgICAgICByZWcgPSA8MCAweDEwMjA3MDAwIDAgMHgxMDAwPiwNCj4gPiAr
ICAgICAgICAgICAgPDAgMHgxMDI3NDAwMCAwIDB4MTAwMD4sDQo+ID4gKyAgICAgICAgICAgIDww
IDB4MTAyNzUwMDAgMCAweDEwMDA+LA0KPiA+ICsgICAgICAgICAgICA8MCAweDExMDIwMDAwIDAg
MHgxMDAwPjsNCj4gPiArICAgICAgICB2aW9faWR4X251bSA9IDwzNjcgMjkyIDI0MiA1OD47DQo+
ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE4NyBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9ERVZJQ0Vf
QVBDPjsNCj4gPiArICAgICAgICBjbG9jay1uYW1lcyA9ICJkZXZhcGMtaW5mcmEtY2xvY2siOw0K
PiA+ICsgICAgfTsNCj4gPiANCg0K

