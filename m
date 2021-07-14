Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2983C7BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhGNCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:22:10 -0400
Received: from mg.richtek.com ([220.130.44.152]:33230 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237530AbhGNCWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:22:10 -0400
X-Greylist: delayed 1889 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 22:22:09 EDT
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(24174:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 14 Jul 2021 10:19:12 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 14 Jul 2021
 10:19:11 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Wed, 14 Jul 2021
 10:19:11 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] regulator: rtq6752: Add binding document for Richtek
 RTQ6752
Thread-Topic: [PATCH 1/2] regulator: rtq6752: Add binding document for Richtek
 RTQ6752
Thread-Index: AQHXdNjO5meqnI1Ye0Cuv8PFds84A6tA8WiAgABMDYA=
Date:   Wed, 14 Jul 2021 02:19:11 +0000
Message-ID: <1626229151.3432.6.camel@richtek.com>
References: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
         <20210713214659.GA892012@robh.at.kernel.org>
In-Reply-To: <20210713214659.GA892012@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6129D831EB06C84E9071AD0DE2DDE7C0@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIEp1bCAwOSwgMjAyMSBhdCAxMTo0MDozNVBNICswODAwLCBjeV9odWFuZyB3cm90
ZToNCj4gPg0KPiA+IEZyb206IENoaVl1YW4gSHVhbmcgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPg0K
PiA+DQo+ID4gQWRkIGJpbmRpbmcgZG9jdW1lbnQgZm9yIFJpY2h0ZWsgUlRRNjc1Mi4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENoaVl1YW4gSHVhbmcgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vcmVndWxhdG9yL3JpY2h0ZWsscnRxNjc1Mi1yZWd1bGF0b3IueWFt
bCAgICAgICB8IDc4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNzggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JpY2h0ZWsscnRxNjc1Mi1y
ZWd1bGF0b3IueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvcmljaHRlayxydHE2NzUyLQ0KPiA+IHJlZ3VsYXRvci55
YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3Jp
Y2h0ZWsscnRxNjc1Mi1yZWd1bGF0b3IueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAuLjY0MTg0MGUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9yaWNodGVrLHJ0cTY3
NTItDQo+ID4gcmVndWxhdG9yLnlhbWwNCj4gPiBAQCAtMCwwICsxLDc4IEBADQo+ID4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UNCj4gPiAr
JVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL3JlZ3VsYXRvci9yaWNodGVrLHJ0cTY3NTItcmVndWxhdG9yLnlhbWwNCj4gPiAjDQo+ID4g
KyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0K
PiA+ICsNCj4gPiArdGl0bGU6IFJpY2h0ZWsgUlRRNjc1MiBURlQgTENEIFZvbHRhZ2UgUmVndWxh
dG9yDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIENoaVl1YW4gSHVhbmcgPGN5
X2h1YW5nQHJpY2h0ZWsuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBU
aGUgUlRRNjc1MiBpcyBhbiBJMkMgaW50ZXJmYWNlIHBnb3JhbW1hYmxlIHBvd2VyIG1hbmFnZW1l
bnQgSUMuIEl0DQo+ID4gaW5jbHVkZXMNCj4gPiArICB0d28gc3luY2hyb25vdXMgYm9vc3QgY29u
dmVydGVyIGZvciBQQVZERCwgYW5kIG9uZSBzeW5jaHJvbm91cyBOQVZERA0KPiA+ICsgIGJ1Y2st
Ym9vc3QuIFRoZSBkZXZpY2UgaXMgc3VpdGFibGUgZm9yIGF1dG9tb3RpdmUgVEZULUxDRCBwYW5l
bC4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAg
IGVudW06DQo+ID4gKyAgICAgIC0gcmljaHRlayxydHE2NzUyDQo+ID4gKw0KPiA+ICsgIHJlZzoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGVuYWJsZS1ncGlvczoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIEEgY29ubmVjdGlvbiBvZiB0aGUgY2hpcCAn
ZW5hYmxlJyBncGlvIGxpbmUuIElmIG5vdCBwcm92aWRlZCwgdHJlYXQNCj4gPiBpdCBhcw0KPiA+
ICsgICAgICBleHRlcm5hbCBwdWxsIHVwLg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+
ID4gKyAgcmVndWxhdG9yczoNCj4gPiArICAgIHR5cGU6IG9iamVjdA0KPiA+ICsgICAgJHJlZjog
cmVndWxhdG9yLnlhbWwjDQo+IFRoaXMgbm9kZSBpcyBub3QgYSByZWd1bGF0b3IsIGp1c3QgYSBj
b250YWluZXIuIERyb3AuDQo+DQpZZXMuDQo+ID4NCj4gPiArDQo+ID4gKyAgICBwYXR0ZXJuUHJv
cGVydGllczoNCj4gPiArICAgICAgIl4ocHxuKWF2ZGQkIjoNCj4gPiArICAgICAgICB0eXBlOiBv
YmplY3QNCj4gPiArICAgICAgICAkcmVmOiByZWd1bGF0b3IueWFtbCMNCj4gPiArICAgICAgICBk
ZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgcmVndWxhdG9yIGRlc2NyaXB0aW9uIGZvciBw
YXZkZCBhbmQgbmF2ZGQuDQo+ID4gKw0KPiA+ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZh
bHNlDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAt
IHJlZw0KPiA+ICsgIC0gcmVndWxhdG9ycw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIGky
YyB7DQo+ID4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAgIHJ0cTY3NTJANmIgew0KPiA+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAicmljaHRlayxydHE2NzUyIjsNCj4gPiArICAgICAgICBzdGF0dXMgPSAi
b2theSI7DQo+IERvbid0IHNob3cgc3RhdHVzIGluIGV4YW1wbGVzLg0KPg0KT2theS4NCg0KSSds
bCB1c2Ugb25lIHBhdGNoIHRvIHVwZGF0ZSB0aGUgYWJvdmUgY29tbWVudC4NClRoYW5rcy4NCj4g
Pg0KPiA+ICsgICAgICAgIHJlZyA9IDwweDZiPjsNCj4gPiArICAgICAgICBlbmFibGUtZ3Bpb3Mg
PSA8JmdwaW8yNiAyIDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICByZWd1bGF0b3JzIHsNCj4gPiAr
ICAgICAgICAgIHBhdmRkIHsNCj4gPiArICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAicnRx
Njc1Mi1wYXZkZCI7DQo+ID4gKyAgICAgICAgICAgIHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0g
PDUwMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw3
MzAwMDAwPjsNCj4gPiArICAgICAgICAgICAgcmVndWxhdG9yLWJvb3Qtb247DQo+ID4gKyAgICAg
ICAgICB9Ow0KPiA+ICsgICAgICAgICAgbmF2ZGQgew0KPiA+ICsgICAgICAgICAgICByZWd1bGF0
b3ItbmFtZSA9ICJydHE2NzUyLW5hdmRkIjsNCj4gPiArICAgICAgICAgICAgcmVndWxhdG9yLW1p
bi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgIHJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDczMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICByZWd1bGF0b3ItYm9vdC1v
bjsNCj4gPiArICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgICAgfTsNCj4g
PiArICAgIH07DQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioq
KioqKioqKioqKioqKioqKioNCg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUt
bWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50
aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlIGV4ZW1wdCBmcm9tIGRp
c2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZSBjb252
ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2Vt
aW5hdGlvbiwgZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2Yg
dGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVj
aXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSBiZSB1bmxhd2Z1bC4gSWYg
eW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxp
ZXZlIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwp
LCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55
IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBj
b250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCg==
