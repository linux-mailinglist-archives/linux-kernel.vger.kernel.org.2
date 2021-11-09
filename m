Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5844A06A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhKIBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbhKIBDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:03:00 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94EC061767
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:00:15 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B5C0380719;
        Tue,  9 Nov 2021 14:00:13 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1636419613;
        bh=e0bP3nIVSd9VrtvE44Ts3w09F7YayuYRhigGstJdMXA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GeB4LHrPbpTYU6Bm0QfVJJtxZ7dPpF00J7WX7MukCQ5tziyXkaszWMn849lhwaGZl
         XY9LRA4LKNlGfkAA8tDlRch+rWPp1UzGko8HmjDEdB2os1J4GA9HrY2s1Y+Cy5P3aI
         BbFarRJi7XQlnjhYTFRehx+zPJnYoodswrfMYEp3kLWFWGWip4e5ghdoM3Y91DkZF5
         Y0+ei9cWUJVHKJpp3XtVnb4KfAGQrP6nS7y+0GntCcKIgOLBSPpaDPqvv24+iLdN9i
         MKtIEwtCBrojTlnhSfzdxu5dAjlYGIYNcjrOzs2+Vb09iRveyWl0HZln18LaPDxBk/
         Si6cgWdrU75kg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6189c81d0003>; Tue, 09 Nov 2021 14:00:13 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 14:00:13 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.024; Tue, 9 Nov 2021 14:00:13 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kostap@marvell.com" <kostap@marvell.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm/arm64: dts: Enable 2.5G Ethernet port on
 CN9130-CRB
Thread-Topic: [PATCH 1/2] arm/arm64: dts: Enable 2.5G Ethernet port on
 CN9130-CRB
Thread-Index: AQHXu8/xz6pvHnosxU2x4OJ57Y3pG6vQMjUAgCmGiQA=
Date:   Tue, 9 Nov 2021 01:00:12 +0000
Message-ID: <e2c41180-591f-5a61-e4a9-f526fcbe0abf@alliedtelesis.co.nz>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
 <87czo9dlkd.fsf@BL-laptop>
In-Reply-To: <87czo9dlkd.fsf@BL-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE1D04EDFA724429A363D775947CD29@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=VwQbUJbxAAAA:8 a=-iNIjB2dHVTFdqCtgxUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZ29yeSwNCg0KT24gMTQvMTAvMjEgMzo1MiBhbSwgR3JlZ29yeSBDTEVNRU5UIHdyb3Rl
Og0KPiBIZWxsbyBDaHJpcywNCj4NCj4+IEVuYWJsZSB0aGUgMi41RyBFdGhlcm5ldCBwb3J0IGJ5
IHNldHRpbmcgdGhlIHN0YXR1cyB0byAib2theSIgYW5kIHRoZQ0KPj4gcGh5LW1vZGUgdG8gIjI1
MDBiYXNlLXgiIG9uIHRoZSBjbjkxMzAtY3JiIGJvYXJkcy4gVGVzdGVkIG9uIGENCj4+IENOOTEz
MC1DUkItQS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNr
aGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IEFzIEkgYW0gbm90IHN1cmUgdGhhdCBuZXh0IHdl
ZWsgdGhlIHB1bGwgcmVxdWVzdCB3aWxsIGJlIGFjY2VwdGVkIHdoZW4NCj4geW91IHdpbGwgc2Vu
ZCB0aGUgdjIgZm9yIHRoZSBzZWNvbmQgcGF0Y2gsIEkgYWxyZWFkeSBhcHBsaWVkIHRoZSBvbmUg
b24NCj4gbXZlYnUvZHQ2NA0KDQpJIHB1bGxlZCANCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9nY2xlbWVudC9tdmVidS5naXQgdG9kYXkgDQphbmQgY2FuJ3Qg
c2VlIHRoaXMgcGF0Y2guIEFtIEkgbG9va2luZyBpbiB0aGUgcmlnaHQgcGxhY2U/DQoNCj4gVGhh
bmtzLA0KPg0KPiBHcmVnb3J5DQo+DQo+DQo+PiAtLS0NCj4+DQo+PiBUaGUgTWFydmVsbCBTREsg
YWRkcyAyNTAwYmFzZS10IGFuZCB1c2VzIGl0IGluIHRoZSBlcXVpdmFsZW50IGR0c2kgYnV0DQo+
PiBsb29raW5nIGF0IHRoZSBkb2N1bWVudGF0aW9uIGZvciBib3RoIHRoZSBTb0MgYW5kIHRoZSBQ
SFkgSSB0aGluaw0KPj4gMjUwMGJhc2UteCBpcyBjb3JyZWN0IGZvciB0aGUgc3lzdGVtIGludGVy
ZmFjZSAodGhlIGxpbmUgc2lkZSBpcw0KPj4gMjUwMGJhc2UtdCkuDQo+Pg0KPj4gICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMwLWNyYi5kdHNpIHwgNCArKy0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY3JiLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMwLWNyYi5kdHNpDQo+PiBpbmRleCA1MDVhZTY5
Mjg5ZjYuLmU3OTE4ZjMyNTY0NiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9jbjkxMzAtY3JiLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9jbjkxMzAtY3JiLmR0c2kNCj4+IEBAIC0yMTQsOCArMjE0LDggQEAgJmNwMF9ldGgxIHsN
Cj4+ICAgfTsNCj4+ICAgDQo+PiAgICZjcDBfZXRoMiB7DQo+PiAtCS8qIFRoaXMgcG9ydCB1c2Vz
ICIyNTAwYmFzZS10IiBwaHktbW9kZSAqLw0KPj4gLQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4g
KwlzdGF0dXMgPSAib2theSI7DQo+PiArCXBoeS1tb2RlID0gIjI1MDBiYXNlLXgiOw0KPj4gICAJ
cGh5ID0gPCZuYmFzZXRfcGh5MD47DQo+PiAgIAlwaHlzID0gPCZjcDBfY29tcGh5NSAyPjsNCj4+
ICAgfTsNCj4+IC0tIA0KPj4gMi4zMy4wDQo+Pg==
