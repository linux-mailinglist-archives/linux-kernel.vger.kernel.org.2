Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9A443B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKCCsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 22:48:03 -0400
Received: from [113.204.237.245] ([113.204.237.245]:48842 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231340AbhKCCsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 22:48:01 -0400
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(16716:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 03 Nov 2021 10:42:24 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Nov 2021 10:42:17 +0800
Received: from CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5]) by
 CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5%4]) with mapi id
 15.01.2176.009; Wed, 3 Nov 2021 10:42:17 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjMgNC84XSByZXNldDogQWRkIFN1bnBsdXMgU1A3?=
 =?utf-8?Q?021_reset_driver?=
Thread-Topic: [PATCH v3 4/8] reset: Add Sunplus SP7021 reset driver
Thread-Index: AQHXzt46EW2BoRs5KkGXOKlY9rlL96vvpOWAgAF0OsA=
Date:   Wed, 3 Nov 2021 02:42:17 +0000
Message-ID: <e2b74b29d6394017a5127f7091c65e1b@cqplus1.com>
References: <cover.1635737544.git.qinjian@cqplus1.com>
         <c6f0aaef57b25705af988797ede5ab7119852a5c.1635737544.git.qinjian@cqplus1.com>
 <296d4a9fdbe2b60eea4d259f1e2e3fe8d67b3c07.camel@pengutronix.de>
In-Reply-To: <296d4a9fdbe2b60eea4d259f1e2e3fe8d67b3c07.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiArCWhlbHANCj4gPiArCSAgVGhpcyBlbmFibGVzIHRoZSByZXNldCBkcml2ZXIgc3Vw
cG9ydCBmb3IgU3VucGx1cyBTUDcwMjEgU29DIGZhbWlseS4NCj4gPiArCSAgU2F5IFkgaWYgeW91
IHdhbnQgdG8gY29udHJvbCByZXNldCBzaWduYWxzIGJ5IHRoZSByZXNldCBjb250cm9sbGVyLg0K
PiA+ICsJICBPdGhlcndpc2UsIHNheSBOLg0KPiA+ICsJICBUaGlzIGRyaXZlciBpcyBzZWxlY3Rl
ZCBhdXRvbWF0aWNhbGx5IGJ5IHBsYXRmb3JtIGNvbmZpZy4NCj4gDQo+IFdoaWNoIHBsYXRmb3Jt
IGNvbmZpZz8NCg0KYXJjaC9hcm0vbWFjaC1zdW5wbHVzL0tjb25maWcsIHdoaWNoIHdpbGwgYmUg
c3VibWl0IGxhdGVyLg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJJ2xsIHN1Ym1pdCB0aGUg
bmV3IHZlcnNpb24gYmFzZWQgb24geW91ciBhZHZpY2UuDQo=
