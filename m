Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA10D430CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344821AbhJQWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbhJQWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 18:18:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F79C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 15:15:50 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 766C8891AF;
        Mon, 18 Oct 2021 11:15:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1634508946;
        bh=eFnsBx7nDy8zU155HehRFDHuGZyMTD45Zk4pg2rJj1U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=P6qyE1yQEvf3YOo+4cUmVv54nQ7vekHOWn9rBYvw6ZcjIefNd9JEU3Ly9GDaX4AzL
         frPSp7b7OJXZCbJBG54UN16WHO9ku8yyF1HVK74Ri6OP8iDZhGpTx9ozAQzYxdlnLL
         nn1fsLK4jUDIvy9gjUrHUgL7F7HolbU3y3vd//hj+/FdgeomKjuRD62xaHQxdQ2obv
         bAOOhaeHFLwEaCFapjnWF5wzZTHuyDYDcqhL6B71KDZ3ZXnarCBPrMYiXHeBiL+I8u
         VKszHuaurDjC5EZOhAitncbAUTBuWcF76fYoEcQJa0+zsw8sUH8znKcTCjtAa40yWZ
         582tXiCr98fUA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B616ca0920003>; Mon, 18 Oct 2021 11:15:46 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Mon, 18 Oct 2021 11:15:46 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.024; Mon, 18 Oct 2021 11:15:46 +1300
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
Thread-Index: AQHXu8/xz6pvHnosxU2x4OJ57Y3pG6vQMjUAgAbFTIA=
Date:   Sun, 17 Oct 2021 22:15:45 +0000
Message-ID: <ec1d0227-5423-58be-4c73-edebf10dc05a@alliedtelesis.co.nz>
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
Content-ID: <9A47793BFF89B946A00EA045BB1AA8A4@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=uiirlcVfgVXqUeRm5esA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNC8xMC8yMSAzOjUyIGFtLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6DQo+IEhlbGxvIENo
cmlzLA0KPg0KPj4gRW5hYmxlIHRoZSAyLjVHIEV0aGVybmV0IHBvcnQgYnkgc2V0dGluZyB0aGUg
c3RhdHVzIHRvICJva2F5IiBhbmQgdGhlDQo+PiBwaHktbW9kZSB0byAiMjUwMGJhc2UteCIgb24g
dGhlIGNuOTEzMC1jcmIgYm9hcmRzLiBUZXN0ZWQgb24gYQ0KPj4gQ045MTMwLUNSQi1BLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVs
ZXNpcy5jby5uej4NCj4gQXMgSSBhbSBub3Qgc3VyZSB0aGF0IG5leHQgd2VlayB0aGUgcHVsbCBy
ZXF1ZXN0IHdpbGwgYmUgYWNjZXB0ZWQgd2hlbg0KPiB5b3Ugd2lsbCBzZW5kIHRoZSB2MiBmb3Ig
dGhlIHNlY29uZCBwYXRjaCwgSSBhbHJlYWR5IGFwcGxpZWQgdGhlIG9uZSBvbg0KPiBtdmVidS9k
dDY0DQpPSyB0aGFua3MuIFRoaXMgcGF0Y2ggaXMgaW5kZXBlbmRlbnQgb2YgdGhlIHN3aXRjaC9z
ZnAgc28gdGhpcyBzaG91bGQgYmUgDQpmaW5lLg0KPiBUaGFua3MsDQo+DQo+IEdyZWdvcnkNCj4N
Cj4NCj4+IC0tLQ0KPj4NCj4+IFRoZSBNYXJ2ZWxsIFNESyBhZGRzIDI1MDBiYXNlLXQgYW5kIHVz
ZXMgaXQgaW4gdGhlIGVxdWl2YWxlbnQgZHRzaSBidXQNCj4+IGxvb2tpbmcgYXQgdGhlIGRvY3Vt
ZW50YXRpb24gZm9yIGJvdGggdGhlIFNvQyBhbmQgdGhlIFBIWSBJIHRoaW5rDQo+PiAyNTAwYmFz
ZS14IGlzIGNvcnJlY3QgZm9yIHRoZSBzeXN0ZW0gaW50ZXJmYWNlICh0aGUgbGluZSBzaWRlIGlz
DQo+PiAyNTAwYmFzZS10KS4NCj4+DQo+PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9j
bjkxMzAtY3JiLmR0c2kgfCA0ICsrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9jbjkxMzAtY3JiLmR0c2kNCj4+IGluZGV4IDUwNWFlNjkyODlmNi4uZTc5MThmMzI1NjQ2IDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRz
aQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaQ0K
Pj4gQEAgLTIxNCw4ICsyMTQsOCBAQCAmY3AwX2V0aDEgew0KPj4gICB9Ow0KPj4gICANCj4+ICAg
JmNwMF9ldGgyIHsNCj4+IC0JLyogVGhpcyBwb3J0IHVzZXMgIjI1MDBiYXNlLXQiIHBoeS1tb2Rl
ICovDQo+PiAtCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+
ICsJcGh5LW1vZGUgPSAiMjUwMGJhc2UteCI7DQo+PiAgIAlwaHkgPSA8Jm5iYXNldF9waHkwPjsN
Cj4+ICAgCXBoeXMgPSA8JmNwMF9jb21waHk1IDI+Ow0KPj4gICB9Ow0KPj4gLS0gDQo+PiAyLjMz
LjANCj4+
