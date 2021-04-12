Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB91F35C4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhDLLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:22:43 -0400
Received: from internet2.beckhoff.com ([194.25.186.210]:49457 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbhDLLWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:37 -0400
X-Greylist: delayed 898 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 07:22:36 EDT
Received: from 172.17.2.171 by Internet2.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey256); Mon, 12 Apr 2021 11:07:15 GMT
Received: from ex01.beckhoff.com (172.17.2.168) by ex05.beckhoff.com
 (172.17.2.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Mon, 12 Apr
 2021 13:07:15 +0200
Received: from ex01.beckhoff.com ([fe80::8caa:afd3:30d9:a097]) by
 ex01.beckhoff.com ([fe80::8caa:afd3:30d9:a097%7]) with mapi id
 15.01.2242.004; Mon, 12 Apr 2021 13:07:15 +0200
From:   linux-kernel-dev <linux-kernel-dev@beckhoff.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
Thread-Topic: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
Thread-Index: AQHXL4BPaMnkOe6iy0OPHOeVEHiMsqqwj5SAgAAEPYCAAAOjAA==
Date:   Mon, 12 Apr 2021 11:07:15 +0000
Message-ID: <7af45968aa0f0909ba39eeac3b7fa4947b6e38a6.camel@beckhoff.com>
References: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
         <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com>
         <f406a5a6c6bfe0e458925821b6830e9dc5a151c1.camel@beckhoff.com>
         <CAHp75VcKYc4BWCM_8Zm7NONceAm2BbhTgDKOweu-qM9yLUHUJw@mail.gmail.com>
In-Reply-To: <CAHp75VcKYc4BWCM_8Zm7NONceAm2BbhTgDKOweu-qM9yLUHUJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.136.117.151]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9106C733814243A1A60051293D54E5@beckhoff.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW8sIDIwMjEtMDQtMTIgYXQgMTM6NTQgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToN
Cj4gQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQ0KPg0KPg0KPiBPbiBNb24sIEFwciAxMiwgMjAy
MSBhdCAxOjM5IFBNIGxpbnV4LWtlcm5lbC1kZXYNCj4gPGxpbnV4LWtlcm5lbC1kZXZAYmVja2hv
ZmYuY29tPiB3cm90ZToNCj4gPiBPbiBNbywgMjAyMS0wNC0xMiBhdCAxMjo0MyArMDMwMCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMTI6Mjkg
UE0gU3RlZmZlbiBEaXJrd2lua2VsDQo+ID4gPiA8bGludXgta2VybmVsLWRldkBiZWNraG9mZi5j
b20+IHdyb3RlOg0KPg0KPiAuLi4NCj4NCj4gPiA+IEknbSBhZnJhaWQgaXQncyBhIGJpdCB0b28g
bXVjaC4gSXMgdGhlcmUgYW55IGd1YXJhbnRlZSBhbGwgdGhlIGJvYXJkcw0KPiA+ID4gYmFzZWQg
b24geDg2IHdpbGwgYmUgQmF5dHJhaWwgb25seT8NCj4gPiA+DQo+ID4gU29ycnksIEkgZ3Vlc3Mg
SSBzaG91bGQgbWFrZSB0aGlzIGNsZWFyZXIgaW4gdGhlIG1lc3NhZ2UuDQo+ID4gQWxsIGJvYXJk
cyB3aXRoICJDQnh4NjMiIGFyZSBCYXl0cmFpbC4NCj4NCj4gRXhhY3RseSEgQW5kIHRoaXMgc3Vw
cG9ydHMgbXkgaWRlYSB0aGF0IHRoaXMgc2hvdWxkbid0IGJlIGRvbmUgbGlrZSBpbg0KPiB0aGlz
IHBhdGNoLg0KPiBBcmUgeW91IGd1YXJhbnRlZWluZyB0aGF0ICphbGwgeDg2LWJhc2VkKiBib2Fy
ZHMgcHJvZHVjZWQgYnkgeW91cg0KPiBjb21wYW55IHdpbGwgYmUgQmF5dHJhaWwgb25seT8NCj4g
QWJvdmUgdGVsbHMgdGhhdCB0aGUgYW5zd2VyIGlzIHJhdGhlciAibm8iLiBTbywgSSB0aGluayB3
ZSBjYW4ndCBhcHBseQ0KPiB0aGlzIHBhdGNoIGluIGl0cyBjdXJyZW50IGZvcm0uDQoNCkFsbCBi
b2FyZHMgd2l0aCBETUlfUFJPRFVDVF9GQU1JTFk9IkNCeHg2MyIgYXJlIEJheXRyYWlsIGJvYXJk
cy4gV2UgZG8gcHJvZHVjZSBvdGhlciB4ODYgYm9hcmRzIGJ1dCB0aGUgZmFtaWx5DQppcyBleGNs
dXNpdmUgdG8gQmF5dHJhaWwuDQpJIG1pZ2h0IGJlIG1pc3VuZGVyc3RhbmRpbmcgaG93IHRoZSBt
YXRjaGluZyB3b3Jrcy4gRG9lcyB0aGlzIG1hdGNoIGFueXRoaW5nIG90aGVyIHRoYW4gQ0J4eDYz
Pw0KDQogLm1hdGNoZXMgPSB7DQogRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQmVja2hvZmYg
QXV0b21hdGlvbiIpLA0KRE1JX01BVENIKERNSV9QUk9EVUNUX0ZBTUlMWSwgIkNCeHg2MyIpLA0K
fSwNCg0KSSBjYW4gc3dpdGNoIGl0IHRvIERNSV9FWEFDVF9NQVRDSCBidXQgZXZlbiBzdWJzdHJp
bmcgbWF0Y2hpbmcgd29ya3MuDQoNCj4NCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFu
ZHkgU2hldmNoZW5rbw0KPg0KDQpCZWNraG9mZiBBdXRvbWF0aW9uIEdtYkggJiBDby4gS0cgfCBN
YW5hZ2luZyBEaXJlY3RvcjogRGlwbC4gUGh5cy4gSGFucyBCZWNraG9mZiBSZWdpc3RlcmVkIG9m
ZmljZTogVmVybCwgR2VybWFueSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhSQSA3MDc1
DQoNCg==

