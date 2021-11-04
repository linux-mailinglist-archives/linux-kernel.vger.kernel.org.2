Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C644506B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKDIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:38:57 -0400
Received: from [113.204.237.245] ([113.204.237.245]:57404 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230084AbhKDIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:38:56 -0400
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(16727:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 04 Nov 2021 16:35:07 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 4 Nov 2021 16:35:00 +0800
Received: from CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5]) by
 CQEXMAIL01.cqplus1.com ([fe80::f436:deb3:dd20:6b5%4]) with mapi id
 15.01.2176.009; Thu, 4 Nov 2021 16:35:00 +0800
From:   =?gb2312?B?cWluamlhblvx+72hXQ==?= <qinjian@cqplus1.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?gb2312?B?V2VsbHMgTHUghc63vPJ2?= <wells.lu@sunplus.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY0IDAwLzEwXSBBZGQgU3VucGx1cyBTUDcwMjEgU29D?=
 =?gb2312?Q?_Support?=
Thread-Topic: [PATCH v4 00/10] Add Sunplus SP7021 SoC Support
Thread-Index: AQHX0SjJ2ipTnH6SmUuBHDnmt6AZUKvygdKAgACJW1A=
Date:   Thu, 4 Nov 2021 08:35:00 +0000
Message-ID: <98b3e76029bb4d7096de462c46bca08d@cqplus1.com>
References: <cover.1635496594.git.qinjian@cqplus1.com>
        <cover.1635993377.git.qinjian@cqplus1.com> <8735oc9voy.wl-maz@kernel.org>
In-Reply-To: <8735oc9voy.wl-maz@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFyYywNCg0KR290IGl0LiBUaGFuayB5b3UgZm9yIHJlbWluZGluZyBtZS4NCkknbSBzb3JyeSBm
b3IgdGhlIHByZXZpb3VzIG1pc3Rha2UuDQoNCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8
/sjLOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiC3osvNyrG85DogMjAyMcTqMTHU
wjTI1SAxNjoyMw0KPiDK1bz+yMs6IHFpbmppYW5b8fu9oV0gPHFpbmppYW5AY3FwbHVzMS5jb20+
DQo+ILOty806IHJvYmgrZHRAa2VybmVsLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNi
b3lkQGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4QGFybWxpbnV4Lm9y
Zy51azsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBhcm5kQGFybmRiLmRlOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBX
ZWxscyBMdSCFzre88nYgPHdlbGxzLmx1QHN1bnBsdXMuY29tPg0KPiDW98ziOiBSZTogW1BBVENI
IHY0IDAwLzEwXSBBZGQgU3VucGx1cyBTUDcwMjEgU29DIFN1cHBvcnQNCj4gDQo+IFFpbiwNCj4g
DQo+IE9uIFRodSwgMDQgTm92IDIwMjEgMDI6NTY6NTcgKzAwMDAsDQo+IFFpbiBKaWFuIDxxaW5q
aWFuQGNxcGx1czEuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZCBT
dW5wbHVzIFNQNzAyMSBTb0Mgc3VwcG9ydC4NCj4gPg0KPiA+IFN1bnBsdXMgU1A3MDIxIGlzIGFu
IEFSTSBDb3J0ZXggQTcgKDQgY29yZXMpIGJhc2VkIFNvQy4gSXQgaW50ZWdyYXRlcyBtYW55DQo+
ID4gcGVyaXBoZXJhbHMgKGV4OiBVQVJULCBJMkMsIFNQSSwgU0RJTywgZU1NQywgVVNCLCBTRCBj
YXJkIGFuZCBldGMuKSBpbnRvIGENCj4gPiBzaW5nbGUgY2hpcC4gSXQgaXMgZGVzaWduZWQgZm9y
IGluZHVzdHJpYWwgY29udHJvbC4NCj4gPg0KPiA+IFNQNzAyMSBjb25zaXN0cyBvZiB0d28gY2hp
cHMgKGRpZXMpIGluIGEgcGFja2FnZS4gT25lIGlzIGNhbGxlZCBDLWNoaXANCj4gPiAoY29tcHV0
aW5nIGNoaXApLiBJdCBpcyBhIDQtY29yZSBBUk0gQ29ydGV4IEE3IENQVS4gSXQgYWRvcHRzIGhp
Z2gtbGV2ZWwNCj4gPiBwcm9jZXNzICgyMiBubSkgZm9yIGhpZ2ggcGVyZm9ybWFuY2UgY29tcHV0
aW5nLiBUaGUgb3RoZXIgaXMgY2FsbGVkIFAtDQo+ID4gY2hpcCAocGVyaXBoZXJhbCBjaGlwKS4g
SXQgaGFzIG1hbnkgcGVyaXBoZXJhbHMgYW5kIGFuIEFSTSBBOTI2IGFkZGVkDQo+ID4gZXNwZWNp
YWxseSBmb3IgcmVhbC10aW1lIGNvbnRyb2wuIFAtY2hpcCBpcyBtYWRlIGZvciBjdXN0b21lcnMu
IEl0IGFkb3B0cw0KPiA+IGxvdy1sZXZlbCBwcm9jZXNzIChleDogMC4xMSB1bSkgdG8gcmVkdWNl
IGNvc3QuDQo+IA0KPiBUaGF0J3MgdGhlIDNyZCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIHNpbmNl
IEZyaWRheSwgdHdvIG9mIHRoZW0gZHVyaW5nDQo+IHRoZSBtZXJnZSB3aW5kb3cuIEFsbCB5b3Ug
YXJlIGFjaGlldmluZyBpcyB0byBhY3R1YWxseSAqZGVsYXkqIHRoZQ0KPiByZXZpZXcgcHJvY2Vz
cyAoYXQgdGhpcyByYXRlLCBJJ2xsIHByb2JhYmx5IHdhaXQgdW50aWwgdjExIGJlZm9yZSBJDQo+
IHRha2UgYW5vdGhlciBsb29rIGF0IGl0KS4NCj4gDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9z
dWJtaXR0aW5nLXBhdGNoZXMucnN0IHN0YXRlcyBpdCBjbGVhcmx5Og0KPiANCj4gPHF1b3RlPg0K
PiBXYWl0IGZvciBhIG1pbmltdW0gb2Ygb25lIHdlZWsgYmVmb3JlIHJlc3VibWl0dGluZw0KPiA8
L3F1b3RlPg0KPiANCj4gU28gcGxlYXNlIGxlYXZlIHBlb3BsZSB0aGUgdGltZSB0byBhY3R1YWxs
eSBkbyBhIGdvb2QgcmV2aWV3IGpvYiwgYW5kDQo+IHRha2UgdGhlIG9wcG9ydHVuaXR5IHRvIHJl
dmlldyB5b3VyIG93biBwYXRjaGVzIGJlZm9yZSBwb3N0aW5nIHRoZW0NCj4gYWdhaW4uDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiAJTS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20g
dGhlIG5vcm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCg==
