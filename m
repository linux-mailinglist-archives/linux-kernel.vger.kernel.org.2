Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29434399F22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:41:45 -0400
Received: from mg.richtek.com ([220.130.44.152]:49406 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhFCKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:41:44 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(4326:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 03 Jun 2021 18:39:52 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 3 Jun 2021
 18:39:52 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Thu, 3 Jun 2021
 18:39:52 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt4801: Fix NULL pointer dereference if
 priv->enable_gpios is NULL
Thread-Topic: [PATCH] regulator: rt4801: Fix NULL pointer dereference if
 priv->enable_gpios is NULL
Thread-Index: AQHXWF3W9ZPy12H82kGo4cvVJ5UzdasBkriA
Date:   Thu, 3 Jun 2021 10:39:51 +0000
Message-ID: <1622716791.1034.13.camel@richtek.com>
References: <20210603094944.1114156-1-axel.lin@ingics.com>
In-Reply-To: <20210603094944.1114156-1-axel.lin@ingics.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <530ECB73A7BC924483363760B680EBD8@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEF4ZWw6DQoNCldoaWNoIGNhc2Ugd2lsbCBjYXVzZSB0aGlzIGVycm9yPyBJJ20gbm90IHJl
YWxseSBzdXJlLg0KQnV0IGlmIGRldm1fZ3Bpb2RfZ2V0X2FycmF5X29wdGlvbmFsIHdpbGwgcmV0
dXJuIG51bGwsIHRoZW4gaXQgbXVzdCBiZSBjaGVjaw0KZWFybGllciBpbiBwcm9iZSBmdW5jdGlv
bg0KDQogICAgICAgIHByaXYtPmVuYWJsZV9ncGlvcyA9IGRldm1fZ3Bpb2RfZ2V0X2FycmF5X29w
dGlvbmFsKCZpMmMtPmRldiwgImVuYWJsZSIsDQpHUElPRF9PVVRfSElHSCk7DQotICAgICAgIGlm
IChJU19FUlIocHJpdi0+ZW5hYmxlX2dwaW9zKSkgeysgICAgICAgaWYgKElTX0VSUl9PUl9OVUxM
KHByaXYtPmVuYWJsZV9ncGlvcykpIHsNCg0KSWYgc28sIHRoaXMgY2hhbmdlIHdpbGwgYmUgbW9y
ZSByZWFzb25hYmxlLg0KQ2F1c2UgaW4gYmluZGluZyBkb2N1bWVudCwgSSBhbHJlYWR5IHdyaXRl
IHRoZSBtaW4gaXRlbSBtdXN0IGJlICcxJy4NCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50
aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KDQpUaGUgaW5mb3JtYXRpb24gY29u
dGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMp
IG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBvciBvdGhlcndp
c2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGlu
dGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMp
LiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24sIHByaW50aW5nLCByZXRhaW5p
bmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50cykg
YnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5
IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhp
cyBlLW1haWwsIG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IChieSByZXBseWlu
ZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgdGhpcyBlLW1h
aWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbyBu
b3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVyIHBlcnNv
bi4gVGhhbmsgeW91IQ0K
