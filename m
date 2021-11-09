Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7907F44A001
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhKIA4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhKIA4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:56:01 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB5C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:53:13 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F34F980719;
        Tue,  9 Nov 2021 13:53:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1636419188;
        bh=MbEImmMvNRigKskabLb75rlla0bXlUamTdNYdy6SOJM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GGDmvhgLup1dhq+FreEyZuIdJ/ka1sSiHUsV1v6/0CEEBGQRN8udXjtPGM5CIy5Pn
         jbJ7kxdBPfovdy2A6LNQz9rat82DIytOhV7ELd85ICn79DAN55H4IKUiNNlLtuh1nT
         Mqxwz25ZyF0VxJaxJjQ+2vF2/jeoDe0Uv5r+hratJLk0YZQiKCrlxMbpM5OjWayAhu
         TSxXIk1UDg91vMDfwam5YMG0PytKUd7hIz4feq+9fo+QSwC0fYcwDf1uirL2nASqzL
         scq9aaqC8+YHreSFSxtZRrkentHQ+jBONutYifzQz2HHySqaaZPpayC5NFHz7v6E9a
         GiELd2FYNeYUQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6189c6740001>; Tue, 09 Nov 2021 13:53:08 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 13:53:08 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.024; Tue, 9 Nov 2021 13:53:08 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm/arm64: dts: Enable more network hardware
Thread-Topic: [PATCH v2 0/2] arm/arm64: dts: Enable more network hardware
Thread-Index: AQHXw70vJ5ycklHEVU65gyB9DuI/yqv5pumA
Date:   Tue, 9 Nov 2021 00:53:07 +0000
Message-ID: <c3090ad7-3427-8e97-9536-caaa1f04b84c@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C549275BD148C04B8F970386AB7FBB79@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=jYDJZq7GXZI51NWTFi0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAxOC8xMC8yMSAyOjEyIHBtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBU
aGlzIHNlcmllcyBlbmFibGVzIHRoZSBTd2l0Y2ggYW5kIDIuNUcgRXRoZXJuZXQgcG9ydCBvbiB0
aGUgQ045MTMwLUNSQi4gVGhlDQo+IGNoYW5nZXMgYXJlIGJhc2VkIG9uIHRoZSBNYXJ2ZWxsIFNE
Sy4NCj4NCj4gTm90ZSBHcmVnb3J5IGhhcyBhbHJlYWR5IHBpY2tlZCB1cCB0aGUgMi41RyBFdGhl
cm5ldCBwYXRjaCBmcm9tIHYxIHNvIEkndmUgbm90DQo+IGluY2x1ZGVkIGl0IGluIHYyIG9mIHRo
aXMgc2VyaWVzLg0KPg0KPiBBbHNvIG5vdGUgdGhhdCBpZiBhbnlvbmUgdHJpZXMgb3V0IHRoZSBT
RlArIHBvcnQgb24gYSBjb21wbGV0ZSBDUkIgc2hpcHBlZCBmcm9tDQo+IE1hcnZlbGwgdGhlIGNo
YXNzaXMgcHJldmVudHMgdGhlIGVqZWN0b3IgZnJvbSB3b3JraW5nIHNvIHRoZSBTRlAgd2lsbCBn
ZXQNCj4gc3R1Y2suIFRha2luZyB0aGUgYm9hcmQgb3V0IG9mIHRoZSBjaGFzc2lzIGFsbG93cyB0
aGUgU0ZQIHRvIGJlDQo+IGluc3RlcnRlZC9yZW1vdmVkLg0KR2VudGxlIHBpbmcgb24gdGhpcyBz
ZXJpZXMuIEkndmUgaGFkIGEgcmV2aWV3IGZyb20gQW5kcmV3IGZvciBwYXRjaCAyIA0KYnV0IGhh
dmVuJ3QgaGVhcmQgYW55dGhpbmcgZWxzZS4NCj4gQ2hyaXMgUGFja2hhbSAoMik6DQo+ICAgIGFy
bS9hcm02NDogZHRzOiBFbmFibGUgQ1AwIEdQSU9zIGZvciBDTjkxMzAtQ1JCDQo+ICAgIGFybS9h
cm02NDogZHRzOiBBZGQgTVY4OEU2MzkzWCB0byBDTjkxMzAtQ1JCIGRldmljZSB0cmVlDQo+DQo+
ICAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaSB8IDEzOSArKysr
KysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMzkgaW5zZXJ0aW9ucygrKQ0K
Pg==
