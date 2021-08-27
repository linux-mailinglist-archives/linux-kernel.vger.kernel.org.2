Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EA3F947A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbhH0Gn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:43:58 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:45626 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhH0Gn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1630046587; x=1632638587;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hjdxX+9t/WsWnVXp1st6p2qOXsa0F3fVD972EzuGFqw=;
        b=FTwVlm6iLtlTCD0DlTspN5OUnb31iq4zDL/4DuTyky3WScJUno0sA88rRuoVWJlc
        I+CGkoOVWBzxr7psSB4pI/+D/yOHTdhKQ1Lcr1Y9QI0x57D8smmygc2y7t+j7/cX
        PgTAMEqAYr2bMmAN/HmR3EdflB4hMf/Tcmx+lX6+1vk=;
X-AuditID: c39127d2-783bf70000001c5c-8a-6128897bd396
Received: from berlix.phytec.de (Berlix.phytec.de [172.16.0.117])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7A.47.07260.B7988216; Fri, 27 Aug 2021 08:43:07 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Berlix.phytec.de
 (172.16.0.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 27 Aug
 2021 08:43:06 +0200
Received: from Berlix.phytec.de ([fe80::c131:350d:c471:aafd]) by
 berlix.phytec.de ([fe80::c131:350d:c471:aafd%3]) with mapi id 15.01.2308.008;
 Fri, 27 Aug 2021 08:43:06 +0200
From:   =?utf-8?B?U3RlZmFuIFJpZWRtw7xsbGVy?= <S.Riedmueller@phytec.de>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "abel.vesa@nxp.com" <abel.vesa@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: imx: imx6ul: Fix csi clk gate register
Thread-Topic: [PATCH 2/2] clk: imx: imx6ul: Fix csi clk gate register
Thread-Index: AQHXmo30E+AoBfzZwEa6zUYT/fs/1KuGFlQAgACwngA=
Date:   Fri, 27 Aug 2021 06:43:06 +0000
Message-ID: <1f1b90c7d2dfa2e80f9a0a7c4bc20d99e7177389.camel@phytec.de>
References: <20210826152049.4175381-1-s.riedmueller@phytec.de>
         <20210826152049.4175381-2-s.riedmueller@phytec.de>
         <CAOMZO5DR7awy7mxr3=qXiEmSG10MX15hc2MJCSajN+gW8=ryuw@mail.gmail.com>
In-Reply-To: <CAOMZO5DR7awy7mxr3=qXiEmSG10MX15hc2MJCSajN+gW8=ryuw@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA95F5E2E272F34AA8D425CAA8169DBB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWyRoChVLe6UyPR4Pk2AYtll44yWjy86m+x
        aupOFotNj6+xWnzsucdq0fVrJbPF5V1z2CwunnK1+Lt9E4vFv2sbWSxebBF34PZ4f6OV3WPn
        rLvsHptWdbJ5bF5S77Hx3Q4mj/6/Bh6fN8kFsEdx2aSk5mSWpRbp2yVwZUx+cJap4ItCxZVN
        G5kbGDsUuhg5OSQETCQWzlrF1sXIxSEksJxJ4tmdzUwQzkNGic2/utkhnE2MEjPO97CDtLAJ
        uEh8bvvGBmKLCOhKrDjRxQhiMwvMYJH4OoWji5GDQxioZs6UYogSV4nPk1cyQdhWEjsaD7GA
        2CwCqhLLLmwCa+UVcJOY+WE9I8SuPYwSfVP7mUDmcAoESvxuiQGpYRSQlehseMcEsUpcYtOz
        76wQHwhILNlznhnCFpV4+fgfVFxBoq2nE2wMs4CmxPpd+hCtFhL3Xj5jhrAVJaZ0P2SHOEFQ
        4uTMJywTGMVnIdkwC6F7FpLuWUi6ZyHpXsDIuopRKDczOTu1KDNbryCjsiQ1WS8ldRMjMM4P
        T1S/tIOxb47HIUYmDsZDjBIczEoivAu+qyUK8aYkVlalFuXHF5XmpBYfYpTmYFES573fw5Qo
        JJCeWJKanZpakFoEk2Xi4JRqYDT+pRSd4yiwI+90rPv55S/5Huzd+26+XsqyJS7bzhveCo6/
        FXkscXLqqu2nrm7azl+/xXJFtcDktb9Pnjc6s+9B9NTjnHc7PrOu+5Ld8VrI4a3wv4ArtxtF
        /d43sOy8ZLZ9/hl5IYVP+29lrTrZqPo3c1+s85ynEU+X5bsyBXKWJNQf9fXYr3pViaU4I9FQ
        i7moOBEAYf1HAOECAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIFRodSwgMjAyMS0wOC0yNiBhdCAxNzoxMCAtMDMwMCwgRmFiaW8gRXN0
ZXZhbSB3cm90ZToNCj4gSGkgU3RlZmFuLA0KPiANCj4gT24gVGh1LCBBdWcgMjYsIDIwMjEgYXQg
MTI6MjAgUE0gU3RlZmFuIFJpZWRtdWVsbGVyDQo+IDxzLnJpZWRtdWVsbGVyQHBoeXRlYy5kZT4g
d3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBpbXg2dWwgUmVmZXJlbmNlIE1hbnVhbCB0aGUg
Y3NpIGNsayBnYXRlIHJlZ2lzdGVyIGlzDQo+ID4gQ0NNX0NDR1IzIChvZmZzZXQgMHg3NCkgYml0
IDAvMS4gRm9yIHRoZSBpbXg2dWxsIG9uIHRoZSBvdGhlciBoYW5kIHRoZQ0KPiA+IFJlZmVyZW5j
ZSBNYW51YWwgbGlzdHMgcmVnaXN0ZXIgQ0NNX0NDR1IyIChvZmZzZXQgMHg3MCkgYml0IDIvMyBh
cyB0aGUNCj4gPiBjc2kgY2xrIGdhdGUgd2hpY2ggaXMgdGhlIGN1cnJlbnQgc2V0dGluZy4NCj4g
PiANCj4gPiBUZXN0cyBoYXZlIHNob3duIHRob3VnaCB0aGF0IHRoZSBjb3JyZWN0IGNzaSBjbGsg
Z2F0ZSByZWdpc3RlciBmb3IgdGhlDQo+ID4gaW14NnVsbCBpcyBhY3R1YWxseSBDQ01fQ0NHUjMg
Yml0IDAvMSBhcyB3ZWxsLiBUaHVzIHNldCB0aGUgY29ycmVjdA0KPiA+IHJlZ2lzdGVyIGZvciBi
b3RoIHBsYXRmb3Jtcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUmllZG11ZWxs
ZXIgPHMucmllZG11ZWxsZXJAcGh5dGVjLmRlPg0KPiANCj4gSSB0ZXN0ZWQgdGhlIHNlcmllcyBv
biBhbiBpbXg2dWxsLWV2ayB3aXRoIGFuIE9WNTY0MCBzZW5zb3I6DQo+IA0KPiBUZXN0ZWQtYnk6
IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gDQo+IGJ1dCBpbiBteSBjYXNl
LCBJIGRpZCBub3Qgc2VlIHRoZSBwcm9ibGVtIGV2ZW4gd2l0aG91dCB5b3VyIHBhdGNoLg0KPiAN
Cj4gTW9zdCBsaWtlbHkgYmVjYXVzZSB0aGUgYm9vdGxvYWRlciB0dXJuZWQgb24gdGhlIENTSSBj
bG9jay4NCg0KdGhhbmtzIGZvciB5b3VyIHRlc3RpbmcgYW5kIHJldmlldy4NCg0KWW91J3JlIHJp
Z2h0LCB0aGUgY3NpIGNsb2NrIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBhbmQgdGh1cyB0aGUgaXNz
dWUgb25seQ0KYXJpc2VzIHdoZW4geW91IHRyeSB0byBkaXNhYmxlIHRoZSBjbG9jayBlLmcuIHRv
IHNhdmUgcG93ZXIgb24gYSBjb25uZWN0ZWQNCnNlbnNvci4NCg0KPiANCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2dWwuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL2lteC9jbGstaW14NnVsLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZ1bC5j
DQo+ID4gaW5kZXggMjA2ZTRjNDNmNjhmLi41ZGQyMjJmYWIwMWIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2dWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14NnVsLmMNCj4gPiBAQCAtMzgwLDcgKzM4MCw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBp
bXg2dWxfY2xvY2tzX2luaXQoc3RydWN0DQo+ID4gZGV2aWNlX25vZGUgKmNjbV9ub2RlKQ0KPiA+
ICAgICAgICAgICAgICAgICBod3NbSU1YNlVMTF9DTEtfRVNBSV9JUEddICAgICAgID0NCj4gPiBp
bXhfY2xrX2h3X2dhdGUyX3NoYXJlZCgiZXNhaV9pcGciLCAgICJhaGIiLCAgICAgICAgICBiYXNl
ICsgMHg3MCwgICAgMCwNCj4gPiAmc2hhcmVfY291bnRfZXNhaSk7DQo+ID4gICAgICAgICAgICAg
ICAgIGh3c1tJTVg2VUxMX0NMS19FU0FJX01FTV0gICAgICAgPQ0KPiA+IGlteF9jbGtfaHdfZ2F0
ZTJfc2hhcmVkKCJlc2FpX21lbSIsICAgImFoYiIsICAgICAgICAgIGJhc2UgKyAweDcwLCAgICAw
LA0KPiA+ICZzaGFyZV9jb3VudF9lc2FpKTsNCj4gPiAgICAgICAgIH0NCj4gPiAtICAgICAgIGh3
c1tJTVg2VUxfQ0xLX0NTSV0gICAgICAgICAgICAgPQ0KPiA+IGlteF9jbGtfaHdfZ2F0ZTIoImNz
aSIsICAgICAgICAgICAgICAgImNzaV9wb2RmIiwgICAgICAgICAgICAgYmFzZSArDQo+ID4gMHg3
MCwgICAgMik7DQo+ID4gICAgICAgICBod3NbSU1YNlVMX0NMS19JMkMxXSAgICAgICAgICAgID0N
Cj4gPiBpbXhfY2xrX2h3X2dhdGUyKCJpMmMxIiwgICAgICAgICAgICAgICJwZXJjbGsiLCAgICAg
ICBiYXNlICsgMHg3MCwgICAgNik7DQo+ID4gICAgICAgICBod3NbSU1YNlVMX0NMS19JMkMyXSAg
ICAgICAgICAgID0NCj4gPiBpbXhfY2xrX2h3X2dhdGUyKCJpMmMyIiwgICAgICAgICAgICAgICJw
ZXJjbGsiLCAgICAgICBiYXNlICsgMHg3MCwgICAgOCk7DQo+ID4gICAgICAgICBod3NbSU1YNlVM
X0NMS19JMkMzXSAgICAgICAgICAgID0NCj4gPiBpbXhfY2xrX2h3X2dhdGUyKCJpMmMzIiwgICAg
ICAgICAgICAgICJwZXJjbGsiLCAgICAgICBiYXNlICsgMHg3MCwgICAgMTApOw0KPiA+IEBAIC0z
OTEsNiArMzkwLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDZ1bF9jbG9ja3NfaW5pdChzdHJ1
Y3QNCj4gPiBkZXZpY2Vfbm9kZSAqY2NtX25vZGUpDQo+ID4gICAgICAgICBod3NbSU1YNlVMX0NM
S19QWFBdICAgICAgICAgICAgID0NCj4gPiBpbXhfY2xrX2h3X2dhdGUyKCJweHAiLCAgICAgICAg
ICAgICAgICJheGkiLCAgICAgICAgICBiYXNlICsgMHg3MCwgICAgMzApOw0KPiA+IA0KPiA+ICAg
ICAgICAgLyogQ0NHUjMgKi8NCj4gDQo+IEl0IHdvdWxkIGJlIG5pY2UgdG8gcHV0IGEgY29tbWVu
dCBoZXJlIGV4cGxhaW5pbmcgdGhlIGlteDZ1bGwNCj4gUmVmZXJlbmNlIE1hbnVhbCBtaXNtYXRj
aC4NCg0KU3VyZSBJIHdpbGwgcHJlcGFyZSBzb21ldGhpbmcuDQoNCj4gDQo+IE1heWJlIEFiZWwg
Y291bGQgaGVscCB0byBjaGVjayBpbnRlcm5hbGx5IGF0IE5YUD8NCg0KWWVzLCB0aGF0IHdvdWxk
IGJlIG5pY2UhDQoNClJlZ2FyZHMsDQpTdGVmYW4NCg0KPiANCj4gPiArICAgICAgIGh3c1tJTVg2
VUxfQ0xLX0NTSV0gICAgICAgICAgICAgPQ0KPiA+IGlteF9jbGtfaHdfZ2F0ZTIoImNzaSIsICAg
ICAgICJjc2lfcG9kZiIsICAgICBiYXNlICsgMHg3NCwgICAgMCk7DQo+IA0KPiBUaGFua3MNCg==
