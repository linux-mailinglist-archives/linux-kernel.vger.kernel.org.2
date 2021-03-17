Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B9D33E969
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhCQF63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:58:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38932 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCQF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:57:56 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12H5vIRx9005801, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12H5vIRx9005801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 13:57:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 13:57:18 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef]) by
 RTEXMBS01.realtek.com.tw ([fe80::6caa:5fa6:24e2:bbef%7]) with mapi id
 15.01.2106.013; Wed, 17 Mar 2021 13:57:18 +0800
From:   =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Virendra-Pratap.Arya@amd.com" <Virendra-Pratap.Arya@amd.com>,
        "Murali-krishna.Vemuri@amd.com" <Murali-krishna.Vemuri@amd.com>,
        "Flove(HsinFu)" <flove@realtek.com>
Subject: RE: [PATCH v3] ASoC: amd: add support for rt5682 codec in machine driver
Thread-Topic: [PATCH v3] ASoC: amd: add support for rt5682 codec in machine
 driver
Thread-Index: AQHXGbJkC0Gc83c14U+1dn6DmskorqqEr0SAgAFqJ4CAABV0AIABgDxA
Date:   Wed, 17 Mar 2021 05:57:18 +0000
Message-ID: <b691d681b07e4aaabb919278cb0379ec@realtek.com>
References: <1615824133-21553-1-git-send-email-Vijendar.Mukunda@amd.com>
 <efa02319-2abf-4fb9-efec-13b6279f3d78@linux.intel.com>
 <87f41e68-3158-38f8-5e84-270ab184691b@amd.com>
 <6bdef069-374a-d215-30a4-715e05304fc7@linux.intel.com>
In-Reply-To: <6bdef069-374a-d215-30a4-715e05304fc7@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.209]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAzLzE2LzIxIDg6MzcgQU0sIE11a3VuZGEsVmlqZW5kYXIgd3JvdGU6DQo+ID4NCj4gPg0K
PiA+IE9uIDE1LzAzLzIxIDk6MzAgcG0sIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOg0KPiA+
Pg0KPiA+Pj4gK3N0YXRpYyBpbnQgcnQ1NjgyX2Nsa19lbmFibGUoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0pIHsNCj4gPj4+ICvCoMKgwqAgaW50IHJldDsNCj4gPj4+ICvCoMKg
wqAgc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9DQo+ID4+PiArYXNvY19zdWJzdHJl
YW1fdG9fcnRkKHN1YnN0cmVhbSk7DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgIC8qDQo+ID4+PiAr
wqDCoMKgwqAgKiBTZXQgd2NsayB0byA0ODAwMCBiZWNhdXNlIHRoZSByYXRlIGNvbnN0cmFpbnQg
b2YgdGhpcyBkcml2ZXINCj4gPj4+ICtpcw0KPiA+Pj4gK8KgwqDCoMKgICogNDgwMDAuIEFEQVU3
MDAyIHNwZWM6ICJUaGUgQURBVTcwMDIgcmVxdWlyZXMgYSBCQ0xLIHJhdGUNCj4gPj4+ICt0aGF0
IGlzDQo+ID4+PiArwqDCoMKgwqAgKiBtaW5pbXVtIG9mIDY0eCB0aGUgTFJDTEsgc2FtcGxlIHJh
dGUuIiBSVDU2ODIgaXMgdGhlIG9ubHkNCj4gPj4+ICtjbGsNCj4gPj4+ICvCoMKgwqDCoCAqIHNv
dXJjZSBzbyBmb3IgYWxsIGNvZGVjcyB3ZSBoYXZlIHRvIGxpbWl0IGJjbGsgdG8gNjRYIGxyY2xr
Lg0KPiA+Pj4gK8KgwqDCoMKgICovDQo+ID4+PiArwqDCoMKgIGNsa19zZXRfcmF0ZShydDU2ODJf
ZGFpX3djbGssIDQ4MDAwKTsNCj4gPj4+ICvCoMKgwqAgY2xrX3NldF9yYXRlKHJ0NTY4Ml9kYWlf
YmNsaywgNDgwMDAgKiA2NCk7DQo+ID4+PiArwqDCoMKgIHJldCA9IGNsa19wcmVwYXJlX2VuYWJs
ZShydDU2ODJfZGFpX2JjbGspOw0KPiA+Pj4gK8KgwqDCoCBpZiAocmV0IDwgMCkgew0KPiA+Pj4g
K8KgwqDCoMKgwqDCoMKgIGRldl9lcnIocnRkLT5kZXYsICJjYW4ndCBlbmFibGUgbWFzdGVyIGNs
b2NrICVkXG4iLCByZXQpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4+
PiArwqDCoMKgIH0NCj4gPj4+ICvCoMKgwqAgcmV0dXJuIHJldDsNCj4gPj4+ICt9DQo+ID4+DQo+
ID4+IE91dCBvZiBjdXJpb3NpdHksIGlzIHRoZXJlIGEgcmVhc29uIHdoeSB5b3UgdXNlIGNsa19w
cmVwYXJlX2VuYWJsZSgpDQo+ID4+IGZvciB0aGUgYmNsayBidXQgbm90IGZvciB0aGUgd2Nsaz9U
aGVzZSBjaGFuZ2VzIHdlcmUgc2hhcmVkIGJ5IGNvZGVjDQo+ID4+IHZlbmRvciBhcyBhbiBpbml0
aWFsIHBhdGNoLg0KPiA+IFdlIHNob3VsZCB1c2UgY2xrX3ByZXBhcmVfZW5hYmxlKCkgZm9yIHdj
bGsgbm90IGZvciBiY2xrLg0KPiA+IFdlIHdpbGwgdXBkYXRlIGFuZCBzaGFyZSB0aGUgbmV3IHBh
dGNoLg0KPiANCj4gV2VsbCB0aGUgcXVlc3Rpb24gcmVtYWluczogaWYgeW91IGhhdmUgdHdvIGNs
b2NrcyBhbmQgb25seSBlbmFibGUgb25lLCB3aHkgZG8NCj4geW91IG5lZWQgdG8gZ2V0IHR3byBj
bG9ja3MuDQo+IA0KPiBBbHNvIHRoaXMgcGF0Y2ggd2FzIG1vZGVsZWQgYWZ0ZXIgdGhlIGRhNzIx
OSBjYXNlLCB3aGVyZSB0aGUgc2FtZSBvcGVuDQo+IGFwcGxpZXMuDQoNClRoZSBSVDU2ODIgY291
bGQgc2V0IHRoZSB3Y2xrIGFuZCBiY2xrIHNlcGFyYXRlbHkuDQpUaGUgYmNsayBjb3VsZCBzZXQg
dGhlIGRpZmZlcmVudCByYXRpb3MgKDMyLzY0LzEyOC8yNTYpLg0KSG93ZXZlciwgb25seSB0aGUg
d2NsayBvZiBEQUkgY2xvY2sgaGFzIHRoZSAucHJlcGFyZSBjYWxsYmFjayBmdW5jdGlvbiB0byBl
bmFibGUgdGhlIHJlbGF0ZWQgcG93ZXIuDQpUaGUgbmV4dCBwYXRjaCBzaG91bGQgdXBkYXRlIHRo
ZSBjbGtfcHJlcGFyZV9lbmFibGUoKSBmb3Igd2Nsay4NCg0KPiAtLS0tLS1QbGVhc2UgY29uc2lk
ZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
