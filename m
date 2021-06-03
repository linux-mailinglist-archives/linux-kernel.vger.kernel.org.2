Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF45399F29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFCKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:43:35 -0400
Received: from mg.richtek.com ([220.130.44.152]:49620 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCKne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:43:34 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(4358:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 03 Jun 2021 18:41:43 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 3 Jun 2021
 18:41:42 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Thu, 3 Jun 2021
 18:41:42 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Topic: [PATCH] regulator: rt6160: Convert to use
 regulator_set_ramp_delay_regmap
Thread-Index: AQHXWFw5/k6L4YuRIk+OmEhH2dJ5iKsBjWCAgAACLwCAAAOxAA==
Date:   Thu, 3 Jun 2021 10:41:42 +0000
Message-ID: <1622716902.1034.15.camel@richtek.com>
References: <20210603093809.1108629-1-axel.lin@ingics.com>
         <1622715641.1034.5.camel@richtek.com>
         <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
In-Reply-To: <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACA42394E8AB749B001CD1B3C94FF60@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBjeV9odWFuZyjpu4PllZ/ljp8pIDxjeV9odWFuZ0ByaWNodGVrLmNvbT4g5pa8IDIwMjHlubQ2
5pyIM+aXpSDpgLHlm5sg5LiL5Y2INjoyMOWvq+mBk++8mg0KPiA+DQo+ID4NCj4gPiBIaSwgQXhl
bDo+IFVzZSByZWd1bGF0b3Jfc2V0X3JhbXBfZGVsYXlfcmVnbWFwIGluc3RlYWQgb2Ygb3Blbi1j
b2RlZC4NCj4gPiA+DQo+ID4gPg0KPiA+IFRoZXJlJ3Mgc29tZSByZWFzb24uDQo+ID4gWW91IGNh
biByZWZlciB0byBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMS82LzEvMTE0NS4NCj4gPg0KPiA+
IEl0J3MgYmVjYXVzZSBvdXIgcmFtcCB2YWx1ZSBvcmRlciBpcyBmcm9tIHNtYWxsIHRvIGxhcmdl
LCBub3QgbGFyZ2UgdG8NCj4gPiBzbWFsbC4NCj4gPiBJdCBjb25mbGljdHMgd2l0aCBmaW5kX2Ns
b3Nlc3RfYmlnZ2VyIHZhbHVlIGNob3NlbiBsb2dpYy4NCj4gSSBoYXZlIHZlcmlmaWVkIHRoZSBy
dDYxNjBfc2V0X3JhbXBfZGVsYXkoKSBiZWhhdmlvciBleGFjdGx5IHRoZSBzYW1lIGFzDQo+IHJl
Z3VsYXRvcl9zZXRfcmFtcF9kZWxheV9yZWdtYXAuIChib3RoIGZ1bmN0aW9ucyBnZXQgdGhlIHNh
bWUgc2VsZWN0b3INCj4gZm9yIGEgZ2l2ZW4gZGVsYXkpDQo+DQo+IENvdWxkIHlvdSBjaGVjayBp
ZiB0aGlzIHBhdGNoIHdvcmtzPw0KU3VyZS4NCj4NCj4gVGhhbmtzLA0KPiBBeGVsDQoqKioqKioq
KioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioN
Cg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNs
dWRpbmcgYW55IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwg
cHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlIGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBw
bGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZSBjb252ZXllZCBvbmx5IHRvIHRoZSBk
ZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0
aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1
ZGluZyBpdHMgYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmlj
dGx5IHByb2hpYml0ZWQgYW5kIG1heSBiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50
ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxpZXZlIHRoYXQgeW91IGhhdmUg
cmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBh
bGwgY29waWVzIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9t
IHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1t
YWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCg==
