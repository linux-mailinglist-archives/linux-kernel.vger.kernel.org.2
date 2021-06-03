Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F149339A0C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFCM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:27:25 -0400
Received: from mg.richtek.com ([220.130.44.152]:59898 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFCM1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:27:24 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(4330:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 03 Jun 2021 20:25:33 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 3 Jun 2021
 20:25:32 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Thu, 3 Jun 2021
 20:25:32 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] regulator: rt4801: Fix NULL pointer dereference if
 priv->enable_gpios is NULL
Thread-Topic: [PATCH] regulator: rt4801: Fix NULL pointer dereference if
 priv->enable_gpios is NULL
Thread-Index: AQHXWF3W9ZPy12H82kGo4cvVJ5UzdasBkriAgAALfICAABIEAA==
Date:   Thu, 3 Jun 2021 12:25:32 +0000
Message-ID: <1622723126.1034.24.camel@richtek.com>
References: <20210603094944.1114156-1-axel.lin@ingics.com>
         <1622716791.1034.13.camel@richtek.com>
         <CAFRkauCQ-BTbad8dgDgduDA8QCFTxbocmLxU+sKErUB8WO4bzQ@mail.gmail.com>
In-Reply-To: <CAFRkauCQ-BTbad8dgDgduDA8QCFTxbocmLxU+sKErUB8WO4bzQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43FC012DD46E846BFD53E4CCAC5A6E1@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksU29ycnksIEkgbWlzZXJ1bmRlcnN0YW5kIGl0Lg0KSXQncyByZWFsbHkgb3B0aW9uYWwgYXMg
eW91IHNhaWQuDQpJIHJlYWxseSBkb24ndCB0aGluayBhYm91dCB0aGUgY2FzZSB5b3Ugc3BlY2lm
aWVkLg0KVGhhbmtzIGZvciB0aGUgZml4Lg0KPg0KPiBSZWdhcmRzLA0KPiBBeGVsDQoqKioqKioq
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
