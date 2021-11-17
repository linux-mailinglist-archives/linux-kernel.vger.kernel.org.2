Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47481454373
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhKQJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:20:35 -0500
Received: from mswedge2.sunplus.com ([60.248.182.106]:36028 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230077AbhKQJUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:20:34 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(23395:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Wed, 17 Nov 2021 17:17:39 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 17 Nov 2021 17:17:33 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Wed, 17 Nov
 2021 17:17:34 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX238mhlfgsNm33Ee3rATIDuuJJqwG5BIAgACK7QA=
Date:   Wed, 17 Nov 2021 09:17:34 +0000
Message-ID: <b7c8ac630615417cbf3e62e165067918@sphcmbx02.sunplus.com.tw>
References: <1637131687-23000-1-git-send-email-tony.huang@sunplus.com>
 <1637131687-23000-3-git-send-email-tony.huang@sunplus.com>
 <YZTDCG6bTjh7BoUH@kroah.com>
In-Reply-To: <YZTDCG6bTjh7BoUH@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBncmVnIGstaDoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBH
cmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBO
b3ZlbWJlciAxNywgMjAyMSA0OjUzIFBNDQo+IFRvOiBUb255IEh1YW5nIDx0b255aHVhbmcuc3Vu
cGx1c0BnbWFpbC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXJlay5raWVy
bmFuQHhpbGlueC5jb207DQo+IGRyYWdhbi5jdmV0aWNAeGlsaW54LmNvbTsgYXJuZEBhcm5kYi5k
ZTsgV2VsbHMgTHUgp2aq2sTLDQo+IDx3ZWxscy5sdUBzdW5wbHVzLmNvbT47IFRvbnkgSHVhbmcg
tsDDaKtwIDx0b255Lmh1YW5nQHN1bnBsdXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIv
Ml0gbWlzYzogQWRkIGlvcCBkcml2ZXIgZm9yIFN1bnBsdXMgU1A3MDIxDQo+IA0KPiBPbiBXZWQs
IE5vdiAxNywgMjAyMSBhdCAwMjo0ODowN1BNICswODAwLCBUb255IEh1YW5nIHdyb3RlOg0KPiA+
IEFkZCBpb3AgZHJpdmVyIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVG9ueSBIdWFuZyA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4NCj4gDQo+IEFsb25nIHdpdGgg
ZXZlcnl0aGluZyB0aGF0IEFybmQgc2FpZCwgb25lIG1vcmUgdGhpbmc6DQo+IA0KPiA+ICsjZGVm
aW5lIElPUF9LREJHX0lORk8NCj4gPiArI2RlZmluZSBJT1BfRlVOQ19ERUJVRw0KPiA+ICsjZGVm
aW5lIElPUF9LREJHX0VSUg0KPiA+ICsjaWZkZWYgSU9QX0tEQkdfSU5GTw0KPiA+ICsJI2RlZmlu
ZSBGVU5DX0RFQlVHKCkJcHJfaW5mbygiS19JT1A6ICVzKCVkKVxuIiwgX19mdW5jX18sIF9fTElO
RV9fKQ0KPiA+ICsjZWxzZQ0KPiA+ICsJI2RlZmluZSBGVU5DX0RFQlVHKCkNCj4gPiArI2VuZGlm
DQo+IA0KPiBUaGlzIHNob3VsZCBqdXN0IGJlIGRlbGV0ZWQgZW50aXJlbHksIHVzZSBmdHJhY2Ug
aWYgeW91IHdhbnQgdG8gc2VlIHdoYXQgeW91cg0KPiBrZXJuZWwgZHJpdmVyIGlzIGRvaW5nLg0K
DQpPSywgSSB3aWxsIGRlbGV0ZSBpdC4NCg0KPiANCj4gTm8gc2luZ2xlIGRyaXZlciBzaG91bGQg
aGF2ZSBzcGVjaWFsIGRlYnVnZ2luZyBtYWNyb3MgbGlrZSB0aGlzLCB1c2UgdGhlDQo+IGtlcm5l
bC13aWRlIHN5c3RlbSBwbGVhc2UuDQo+IA0KPiBUaGlzIGRyaXZlciBjb2RlIGNhbiBnZXQgYSBs
b3Qgc21hbGxlciBhZnRlciB5b3UgbWFrZSB0aGVzZSBjbGVhbnVwcy4NCj4gQWxzbyBiZSBzdXJl
IHRvIHVzZSBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgdG8gcmVtb3ZlIHRoZSBpc3N1ZXMgdGhhdCBp
dCBwb2ludHMgb3V0DQo+IHNvIHdlIGRvbid0IGhhdmUgdG8gc2F5IHRoZSBzYW1lIHRoaW5nLg0K
PiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
