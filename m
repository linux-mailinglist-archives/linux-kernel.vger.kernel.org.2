Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E844BD53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhKJIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:55:26 -0500
Received: from mail.vivotek.com ([60.248.39.150]:57250 "EHLO mail.vivotek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhKJIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:55:25 -0500
Received: from pps.filterd (vivotekpps.vivotek.com [127.0.0.1])
        by vivotekpps.vivotek.com (8.16.1.2/8.16.1.2) with SMTP id 1AA8kL6Y011355;
        Wed, 10 Nov 2021 16:52:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivotek.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dkim;
 bh=o6OWrAMXOMRL7b2L/h0+gN2U4tPL7Uq9VeK68ThZvDQ=;
 b=AraZ7w2zqMag0SEC/HI0MXiIVHW8HH4Z5cHcPIF4mufyhuFgKKPN6dve9aBpae7xgFS4
 3bm8K882C05C7yAvXxDVtjmUPvYHcJplCgrzSXi/kF6yEaEP3GjPQITLFoo+JjoD01jk
 2YOHCF6jpv42duKI6ds9VXghRUoWjXpCstk= 
Received: from cas01.vivotek.tw ([192.168.0.58])
        by vivotekpps.vivotek.com with ESMTP id 3c87khr838-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 16:52:07 +0800
Received: from MBS07.vivotek.tw ([fe80::2027:4d67:6c01:78d8]) by
 CAS01.vivotek.tw ([::1]) with mapi id 14.03.0513.000; Wed, 10 Nov 2021
 16:52:06 +0800
From:   <Michael.Wu@vatics.com>
To:     <joe@perches.com>, <apw@canonical.com>
CC:     <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: checkpatch warns a symbolic link has not a newline
Thread-Topic: checkpatch warns a symbolic link has not a newline
Thread-Index: AdfV/ap0o7FQpZ4YSCGIdlNiqjhb1v//kwOA//9zhLA=
Date:   Wed, 10 Nov 2021 08:52:05 +0000
Message-ID: <5DB475451BAA174CB158B5E897FC1525D8B304C4@MBS07.vivotek.tw>
References: <5DB475451BAA174CB158B5E897FC1525D8B30486@MBS07.vivotek.tw>
 <1f8f989b9610bb558fc081c93b6e792c548ca76f.camel@perches.com>
In-Reply-To: <1f8f989b9610bb558fc081c93b6e792c548ca76f.camel@perches.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.134]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: gRzlKTIsZ7_SnZ8I5IwIySSzTACLSUaR
X-Proofpoint-ORIG-GUID: gRzlKTIsZ7_SnZ8I5IwIySSzTACLSUaR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-10_03:2021-11-08,2021-11-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lLA0KDQpUaGUgZm9sbG93aW5nIGlzIGEgZGVtb25zdHJhdGVkIHBhdGNoIHdoaWNoIGNy
ZWF0ZXMgYSBzeW1ib2xpYyBsaW5rDQpwb2ludGluZyB0byBhIGV4aXN0ZWQgZmlsZS4NCg0KZGlm
ZiAtLWdpdCBhL3Rvb2xzL2dwaW8vZHVtbXkuaCBiL3Rvb2xzL2dwaW8vZHVtbXkuaA0KbmV3IGZp
bGUgbW9kZSAxMjAwMDANCmluZGV4IDAwMDAwMDAwMDAwMC4uYWNlNGRmNjBiYWM2DQotLS0gL2Rl
di9udWxsDQorKysgYi90b29scy9ncGlvL2R1bW15LmgNCkBAIC0wLDAgKzEgQEANCitncGlvLXV0
aWxzLmgNClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KDQp0b29scy9ncGlvL2R1bW15Lmgg
aXMgY3JlYXRlZCBieSBjb21tYW5kICdsbiAtcyBncGlvLXV0aWxzLmggZHVtbXkuaCcuDQpzY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgcmV0dXJuZWQgYSB3YXJuaW5nIGxpa2VzIHRoYXQ6DQoNCldBUk5J
Tkc6IGFkZGluZyBhIGxpbmUgd2l0aG91dCBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQojMjI6IEZJ
TEU6IHRvb2xzL2dwaW8vZHVtbXkuaDoxOg0KK2dwaW8tdXRpbHMuaA0KDQpjb21tYW5kICdsbiAt
cycgY3JlYXRlcyBhIHN5bWJvbGljIGxpbmsgd2hpY2ggaGFzIG5vIG5ld2xpbmUgYXQgZW5kIG9m
DQpmaWxlLiBGb3IgYSBzeW1ib2xpYyBsaW5rIGNyZWF0ZWQgYnkgJ2xuIC1zJyBhbHdheXMgZ2V0
IHRoZSB3YXJuaW5nLg0KDQpJZiBzeW1ib2xpYyBsaW5rcyBhcmUgYWxsb3dlZCwgaXQgc2hvdWxk
IG5vdCBiZSB3YXJuZWQsIGlzIGl0Pw0KDQpCZXN0IFJlZ2FyZHMsDQpNaWNoYWVsIFd1DQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9lIFBlcmNoZXMgW21haWx0bzpq
b2VAcGVyY2hlcy5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTAsIDIwMjEgNDow
OSBQTQ0KPiBUbzogTWljaGFlbC5XdSinZKm+r3EpDQo+IFN1YmplY3Q6IFJlOiBjaGVja3BhdGNo
IHdhcm5zIGEgc3ltYm9saWMgbGluayBoYXMgbm90IGEgbmV3bGluZQ0KPiANCj4gT24gV2VkLCAy
MDIxLTExLTEwIGF0IDA2OjM5ICswMDAwLCBNaWNoYWVsLld1QHZhdGljcy5jb20gd3JvdGU6DQo+
ID4gSGkgQW5keSAmIEpvZSwNCj4gPg0KPiA+IEkgaGF2ZSBhIGNvbW1pdCB0aGF0IGNvbnRhaW5z
IGEgbmV3bHkgY3JlYXRlZCBzeW1ib2xpYyBsaW5rIHBvaW50aW5nIHRvIGENCj4gY2VydGFpbiBm
aWxlLiBJIHVzZWQgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgdG8gY2hlY2sgdGhpcyBjb21taXQg
YW5kIHRoZW4gSSBnb3QgYQ0KPiBXQVJOSU5HOiBhZGRpbmcgYSBsaW5lIHdpdGhvdXQgbmV3bGlu
ZSBhdCBlbmQgb2YgZmlsZS4gVGhlIHN5bWJvbGljIGxpbmsgd2FzDQo+IGNyZWF0ZWQgYnkgbG4g
LXMuDQo+ID4NCj4gPiBJJ20gY29uZnVzZWQgd2h5IGl0IHJldHVybmVkIHN1Y2ggYSB3YXJuaW5n
LiBJcyB0aGUgY29udGVudCBvZiB0aGUgcGF0Y2ggbm90DQo+IGFsbG93ZWQgdG8gY29udGFpbiBz
eW1ib2xpYyBsaW5rcz8gSWYgaXQgaXMgYWxsb3dlZCwgSSB0aGluayBjaGVja3BhdGNoLnBsIGNh
bg0KPiBtYWtlIHNvbWUgaW1wcm92ZW1lbnRzLCBzbyB0aGF0IHN5bWJvbGljIGxpbmtzIHdpbGwg
bm90IGJlIHRyZWF0ZWQgYQ0KPiB3YXJuaW5ncyBiZWNhdXNlIG9mIG1pc3NpbmcgbmV3bGluZSBh
dCBlbmQgb2YgZmlsZS4NCj4gPg0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiBNaWNoYWVsIFd1DQo+
IA0KPiBTZW5kIG1lIGFuIGVtYWlsIHRoYXQgY29udGFpbnMgdGhlIHBhdGNoIHRoYXQgcHJvZHVj
ZXMgdGhpcyBtZXNzYWdlIHBsZWFzZS4NCj4gDQoNCg==
