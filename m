Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC8443AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhKCB0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:26:31 -0400
Received: from [113.204.237.245] ([113.204.237.245]:48160 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231435AbhKCB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:26:30 -0400
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(16713:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 03 Nov 2021 09:20:41 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Nov 2021 09:20:34 +0800
Received: from CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5]) by
 CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5%4]) with mapi id
 15.01.2176.009; Wed, 3 Nov 2021 09:20:34 +0800
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjMgMy84XSBkdC1iaW5kaW5nczogcmVzZXQ6IEFk?=
 =?utf-8?Q?d_bindings_for_SP7021_reset_driver?=
Thread-Topic: [PATCH v3 3/8] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Thread-Index: AQHXzt6BXNsU5ZWDsUy9VCnQJXhHSqvvnAYAgAFmWFA=
Date:   Wed, 3 Nov 2021 01:20:34 +0000
Message-ID: <316eb67cafae48ef92d5e7d5ab56b5c4@cqplus1.com>
References: <cover.1635737544.git.qinjian@cqplus1.com>
         <852e24e942cf40b8240ced4de4ac78acc7694355.1635737544.git.qinjian@cqplus1.com>
 <34481cb056c4bc4dc355571713675f141350e04d.camel@pengutronix.de>
In-Reply-To: <34481cb056c4bc4dc355571713675f141350e04d.camel@pengutronix.de>
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

PiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+
ICsgICAgICAtIHN1bnBsdXMsc3A3MDIxLXJlc2V0ICMgUmVzZXQgQ29udHJvbGxlciBvbiBTUDcw
MjEgYW5kIGNvbXBhdGlibGUgU29Dcw0KPiA+ICsgICAgICAtIHN1bnBsdXMscTY0NS1yZXNldCAj
IFJlc2V0IENvbnRyb2xsZXIgb24gUTY0NSBhbmQgY29tcGF0aWJsZSBTb0NzDQo+IA0KPiBUaGUg
Y29tbWl0IG1lc3NhZ2Ugb25seSBtZW50aW9ucyBTUDcwMjEuIFNob3VsZCBRNjQ1IGJlIGFkZGVk
IGxhdGVyLCBvcg0KPiBpcyB0aGlzIHBhdGNoIG1pc3NpbmcgdGhlIGJpbmRpbmcgaGVhZGVyIGZv
ciBRNjU1Pw0KPg0KDQpJJ2xsIHJlbW92ZSB0aGUgUTY0NSBlbnRyeSwgd2hpY2ggd2lsbCBiZSBh
ZGRlZCBsYXRlciB3aGVuIHN1Ym1pdHRpbmcgUTY0NSBzdXBwb3J0Lg0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldy4gDQoNCg0K
