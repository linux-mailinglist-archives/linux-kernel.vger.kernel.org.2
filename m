Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8084260F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhJHALJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:11:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33224 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJHALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:11:06 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5B1DB8364F;
        Fri,  8 Oct 2021 13:09:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1633651750;
        bh=o+tCSs/+XgX7duxDGS+jDPziBNUduKDJTbVYMKVhKdg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=xFA5vNHPmLgyJ6fFiPITmcd/ykEfb3eWxwgoX5emJpWw3Vfek/FYPVGqXtuMcqAhV
         rbkUGpMfiAm+HzM1RkdaSHS05Egvv5PDnJmVTJ3+GPtWR2VTKo8obOy1G1r/1hRAZp
         kV75CXob9Qk3IGUoqYZCU8pOazvm0DVJfnHk6qw0Az6qnLLeP6XK966Ru2LYGyHMYW
         M6gBlKAqEuS0jcBjp9FaIh0NNQqfZfspZHQ1CiaFemNi74chXZGeYlid9Gv+UBfay4
         PbfWkGhcEWSQswVCgwWi6+1h2BhJXeTkLgVJTUToHpfsfZChIIAGrP2ZI745cOKmMi
         r6WQxjw8rURtA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B615f8c260001>; Fri, 08 Oct 2021 13:09:10 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 8 Oct 2021 13:09:10 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Fri, 8 Oct 2021 13:09:10 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device
 tree
Thread-Topic: [PATCH 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device
 tree
Thread-Index: AQHXu8/xpr8D9xBVhU6GStr9e4qSTqvHWwGAgAAE34A=
Date:   Fri, 8 Oct 2021 00:09:09 +0000
Message-ID: <62e8a697-666c-03ae-cc06-0a51e3ff09c0@alliedtelesis.co.nz>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
 <YV+IDzEdYuy+s/Ak@lunn.ch>
In-Reply-To: <YV+IDzEdYuy+s/Ak@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <569C0D12029BF742BAFBAC56500DF41B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fKRHIqSe c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=2hjJiiMcJP_LUDu2wcIA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMC8yMSAxMjo1MSBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQoNClNvbWUgcmVzcG9uc2Vz
IGJlbG93Lg0KDQpOb3RlIEknbGwgYmUgb24gbGVhdmUgbmV4dCB3ZWVrIHNvIEknbGwgc2VuZCB2
MiB3aGVuIEknbSBiYWNrIHRoZSANCmZvbGxvd2luZyB3ZWVrLiBUaGF0J2xsIGFsc28gYWxsb3cg
c29tZSB0aW1lIGZvciBhbnkgb3RoZXIgY29tbWVudHMgdG8gDQpjb21lIGluLg0KDQo+IE9uIEZy
aSwgT2N0IDA4LCAyMDIxIGF0IDEyOjA2OjE5UE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6
DQo+PiBUaGUgQ045MTMwLUNSQiBib2FyZHMgaGF2ZSBhIE1WODhFNjM5M1ggc3dpdGNoIGNvbm5l
Y3RlZCB0byBldGgwLiAgQWRkDQo+PiB0aGUgbmVjZXNzYXJ5IGR0cyBub2RlcyBhbmQgcHJvcGVy
dGllcyBmb3IgdGhpcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJp
cy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBUaGlzIGlzIHRh
a2VuIGZyb20gdGhlIE1hcnZlbGwgU0RLLiBJJ3ZlIHJlLW9yZGVyZWQgdGhlIHBvcnQgZW50cmll
cyB0bw0KPj4gYmUgaW4gYXNjZW5kaW5nIG9yZGVyLg0KPj4NCj4+ICAgYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaSB8IDEyNSArKysrKysrKysrKysrKysrKysrKw0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTI1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaSBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY3JiLmR0c2kNCj4+IGluZGV4IGU3OTE4ZjMyNTY0
Ni4uMTcxZjczOTQ5NDhlIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2NuOTEzMC1jcmIuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2NuOTEzMC1jcmIuZHRzaQ0KPj4gQEAgLTE4NSw2ICsxODUsMTMxIEBAICZjcDBfbWRpbyB7DQo+
PiAgIAlwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+PiAgIAkJcmVnID0gPDA+Ow0KPj4gICAJfTsN
Cj4+ICsNCj4+ICsJc3dpdGNoNjogc3dpdGNoMEA2IHsNCj4+ICsJCS8qIEFjdHVhbCBkZXZpY2Ug
aXMgTVY4OEU2MzkzWCAqLw0KPj4gKwkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLG12ODhlNjE5MCI7
DQo+PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0K
Pj4gKwkJcmVnID0gPDY+Ow0KPiBJcyB0aGUgaW50ZXJydXB0IG91dHB1dCBjb25uZWN0ZWQgdG8g
YSBHUElPPw0KWWVzIGl0IGFwcGVhcnMgdG8gYmUgY29ubmVjdGVkIHRvIENQX01QUDI4IGFsdGhv
dWdoIHRoZSBjb21tZW50cyBpbiB0aGUgDQpzY2hlbWF0aWMgc3VnZ2VzdCB0aGlzIHdhcyBhZGRl
ZCBpbiBSZXYgMS4zMCBvZiB0aGUgZGVzaWduLiBJIHRoaW5rIHRoYXQgDQpjb3JyZXNwb25kcyB0
byB0aGUgYm9hcmQgSSBoYXZlIGJ1dCBtYXkgbm90IGNvdmVyIGFsbCB0aGUgYm9hcmRzIG91dCAN
CnRoZXJlIGluIHRoZSB3aWxkLiBJJ2xsIHRyeSBhZGRpbmcgaXQuDQo+DQo+PiArDQo+PiArCQlk
c2EsbWVtYmVyID0gPDAgMD47DQo+PiArDQo+PiArCQlwb3J0cyB7DQo+PiArCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+PiArCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+PiArDQo+PiArCQkJcG9y
dEAwIHsNCj4+ICsJCQkJcmVnID0gPDA+Ow0KPj4gKwkJCQlsYWJlbCA9ICJub3R1c2VkLXBvcnQw
IjsNCj4+ICsJCQkJcGh5LW1vZGUgPSAiMTBnYmFzZS1rciI7DQo+PiArCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+IFdoYXQgaXMgbWVhbnQgYnkgbm90IHVzZWQ/IERvZXMgaXQgZ28gdG8gYSBo
ZWFkZXI/IElzIGl0IG5vdCB3aXJlZCBhdA0KPiBhbGw/IFlvdSBkb24ndCBuZWVkIHRvIGxpc3Qg
YSBwb3J0IGlmIGl0IGlzIG5vdCBhY3R1YWxseSB1c2VkLiBTbw0KPiBtYXliZSB5b3UganVzdCB3
YW50IHRvIGRlbGV0ZSB0aGlzIHBvcnQgYWxsIHRvZ2V0aGVyPw0KPg0KSXQncyBjb21wbGV0ZWx5
IGRpc2Nvbm5lY3RlZCBzbyBJJ2xsIHJlbW92ZSB0aGUgcG9ydC4NCj4+ICsNCj4+ICsJCQl9Ow0K
Pj4gKw0KPj4gKwkJCXBvcnRAMSB7DQo+PiArCQkJCXJlZyA9IDwxPjsNCj4+ICsJCQkJbGFiZWwg
PSAid2FuMSI7DQo+PiArCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRjaDBwaHkxPjsNCj4+ICsJCQl9
Ow0KPj4gKw0KPg0KPj4gKw0KPj4gKwkJCXBvcnRAOCB7DQo+PiArCQkJCXJlZyA9IDw4PjsNCj4+
ICsJCQkJbGFiZWwgPSAibGFuOCI7DQo+PiArCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRjaDBwaHk4
PjsNCj4+ICsJCQl9Ow0KPj4gKw0KPj4gKwkJCXBvcnRAOSB7DQo+PiArCQkJCXJlZyA9IDw5PjsN
Cj4+ICsJCQkJbGFiZWwgPSAid2FucDkiOw0KPiBEbyB0aGVzZSBuYW1lcyBjb3JyZXNwb25kIHRv
IHNvbWUgbGFiZWxpbmc/IEV0aGVyIHRoZSBjYXNlIG9yIHRoZSBzaWxrDQo+IHNjcmVlbj8NClRo
ZSBzaWxrc2NyZWVuIGp1c3Qgc2F5cyBQMS1QOC4gSSB3YXMgdGVtcHRlZCB0byByZW5hbWUgIndh
bjEiIC0+ICJsYW4xIiANCnRvIG1hdGNoIHRoZSBvdGhlcnMuIEkgY291bGQgYWxzbyBjaGFuZ2Ug
dGhlbSBhbGwgdG8gInBOIiBvciAicG9ydE4iIGlmIA0KcHJlZmVycmVkLg0KPiAgIHdhbnA5IGlz
IGFuIG9kZCBuYW1lLiBJcyBpdCBjb25uZWN0ZWQgdG8gYSBoZWFkZXI/DQpQOSBpcyBjb25uZWN0
ZWQgdG8gYSBTRlArIGNhZ2UuIEkga25vdyB0aGVyZSBoYXMgYmVlbiBzb21lIHdvcmsgb24gdGhl
IA0KYmluZGluZ3MgZm9yIHRoYXQgd2hpY2ggSSBoYXZlbid0IGNhdWdodCB1cCB3aXRoLiBBZ2Fp
biBJIGNhbiByZW5hbWUgDQp0aGlzIHRvICJsYW45IiwgInA5IiBvciAicG9ydDkiIGFzIGRlc2ly
ZWQuIEJ1dCBwZXJoYXBzIEknZCBiZSBiZXR0ZXIgDQpvZmYgdG8gbm90IGluY2x1ZGUgdGhlIHBv
cnQgYW5kIGp1c3QgbGVhdmUgYSBub3RlIGhlcmUgdG8gc2F5IHBvcnQ5IA0KbmVlZHMgdGhlIHNm
cCBiaW5kaW5ncyAob3IgSSBjb3VsZCBnZXQgdG8gZ3JpcHMgd2l0aCB0aGUgYmluZGluZ3MpLg0K
Pg0KPj4gKwkJCQlwaHktbW9kZSA9ICIxMGdiYXNlLWtyIjsNCj4+ICsJCQkJZml4ZWQtbGluayB7
DQo+PiArCQkJCQlzcGVlZCA9IDwxMDAwMD47DQo+PiArCQkJCQlmdWxsLWR1cGxleDsNCj4+ICsJ
CQkJfTsNCj4+ICsJCQl9Ow0KPiAgICBBbmRyZXc=
