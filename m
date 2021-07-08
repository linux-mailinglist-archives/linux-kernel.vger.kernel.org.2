Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4E3BF703
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGHIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:45:41 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:45096 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhGHIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625733777; x=1628325777;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mo5rn9t5Ua3HHAyBT6SB4bbVzAIQ4ApHmyY/cAc+fGM=;
        b=g7KaKGzIOouPYM4CIV10RQu2JKG+OHUm41+fDwxaCM+rioTxAmKPJp1CsOIr1v2N
        oTu9B5NBLgKjbvtiSDLzwlI0kUmsbT5zhqavLFQcgvlUW6Pg0hx6R3aUB08ML0Ys
        gWfstBFUvpoarc5/Aj+ZsIkR9Gq67aSe3sVIEOxzZwk=;
X-AuditID: c39127d2-1d8f870000001daf-64-60e6ba91bb8c
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.16.0.119])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 83.47.07599.19AB6E06; Thu,  8 Jul 2021 10:42:57 +0200 (CEST)
Received: from Florix.phytec.de (172.16.0.118) by Diagnostix.phytec.de
 (172.16.0.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 8 Jul 2021
 10:42:57 +0200
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%7]) with mapi id 15.01.2176.009;
 Thu, 8 Jul 2021 10:42:57 +0200
From:   =?utf-8?B?U3RlZmFuIFJpZWRtw7xsbGVy?= <S.Riedmueller@phytec.de>
To:     "ada@thorsis.com" <ada@thorsis.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan_brown@ieee.org" <dan_brown@ieee.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching
 for the BBT in NAND
Thread-Topic: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching
 for the BBT in NAND
Thread-Index: AQHXab81XYl8ULPcl06Cu0VqfeH4Uas2DpgAgAEel4CAAYhKAA==
Date:   Thu, 8 Jul 2021 08:42:57 +0000
Message-ID: <ced4e27f921b2ab2fb19c1bb45e87a9886c6d04c.camel@phytec.de>
References: <20210625123821.207458-1-s.riedmueller@phytec.de>
         <20210706181308.1aa21d00@xps13> <2691583.eailiBHnQg@ada>
In-Reply-To: <2691583.eailiBHnQg@ada>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6EBE5E1F1DBFA4B8D58E1A064042AF0@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWyRoChXHfirmcJBusuGVr0HWSyOH3mFJPF
        kb7NzBYTV05mtnh41d9i1dSdLBafrnUzWlzeNYfNYnfTMnaLh7OvMlocbt/HajF55xtGi7/b
        N7FY/D/7gd2Bz2PemmqPHXeXMHrsnHWX3WN2x0xWj6cTDjJ5bF6h5bFpVSebx+Yl9R435xV6
        9P818Fg39z27x/Eb25k8Pm+SC+CN4rJJSc3JLEst0rdL4Mq4f7CTsWCfR8WXriOMDYwX3LoY
        OTkkBEwkFi69x9LFyMUhJLCeSeL9v2OMEM4TRomDz88wglQJCWxklNjWaANiswm4SHxu+8YG
        YosIqEss/P2bCaSBWeAsq8T7rTeARnFwCAskSvx/lgNRkyRx//EKdgjbSaKp4xgTiM0ioCJx
        u+sNK4jNK+AmcfnjZzaIXZUSLfNnM4PYnAKqEqsv7QCzGQVkJTob3oH1MguIS2x69p0V4gMB
        iSV7zjND2KISLx//g4orSLT1dDKBnMMsoCmxfpc+RKuFxP/eqywQtqLElO6H7BAnCEqcnPmE
        ZQKj+CwkG2YhdM9C0j0LSfcsJN0LGFlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgQmj8MT1S/t
        YOyb43GIkYmD8RCjBAezkgiv0YxnCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5N/CWhAkJpCeW
        pGanphakFsFkmTg4pRoYCxj55D2t9Ny4gyJ/3d9ZY7P/Bq/5w3WNRe6TDsekdndXM9/avSaw
        733Pobx8wfDsW7V5Pktqp78K+CRqt6jv/9njesnXD5259El1jlq+9Dz2vaKLLGLE3+oU35g2
        e4qStPf8/2d7NsQ6/I/vrjxSPO+5aEBaW8S0Dz1Zy46e8P6+Ya0n+/tFSizFGYmGWsxFxYkA
        GZoougwDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZGVyLA0KDQpPbiBXZWQsIDIwMjEtMDctMDcgYXQgMTE6MTggKzAyMDAsIEFsZXhh
bmRlciBEYWhsIHdyb3RlOg0KPiBIZWkgaGVpLA0KPiANCj4gQW0gRGllbnN0YWcsIDYuIEp1bGkg
MjAyMSwgMTg6MTM6MDggQ0VTVCBzY2hyaWViIE1pcXVlbCBSYXluYWw6DQo+ID4gSGkgU3RlZmFu
LA0KPiA+IA0KPiA+IFN0ZWZhbiBSaWVkbXVlbGxlciA8cy5yaWVkbXVlbGxlckBwaHl0ZWMuZGU+
IHdyb3RlIG9uIEZyaSwgMjUgSnVuIDIwMjENCj4gPiANCj4gPiAxNDozODoyMSArMDIwMDoNCj4g
PiA+IFRoZSBibG9ja3MgY29udGFpbmluZyB0aGUgYmFkIGJsb2NrIHRhYmxlIGNhbiBiZWNvbWUg
YmFkIGFzIHdlbGwuIFNvDQo+ID4gPiBtYWtlIHN1cmUgdG8gc2tpcCBhbnkgYmxvY2tzIHRoYXQg
YXJlIG1hcmtlZCBiYWQgd2hlbiBzZWFyY2hpbmcgZm9yIHRoZQ0KPiA+ID4gYmFkIGJsb2NrIHRh
YmxlLg0KPiA+ID4gDQo+ID4gPiBPdGhlcndpc2UgaW4gdmVyeSByYXJlIGNhc2VzIHdoZXJlIHR3
byBCQlQgYmxvY2tzIHdlYXIgb3V0IGl0IG1pZ2h0DQo+ID4gPiBoYXBwZW4gdGhhdCBhbiBvYnNv
bGV0ZSBCQlQgaXMgdXNlZCBpbnN0ZWFkIG9mIGEgbmV3ZXIgYXZhaWxhYmxlDQo+ID4gPiB2ZXJz
aW9uLg0KPiA+ID4gDQo+ID4gPiBUaGlzIG9ubHkgYXBwbGllcyB0byBkcml2ZXJzIHdoaWNoIG1h
a2UgdXNlIG9mIGEgYmFkIGJsb2NrIG1hcmtlciBpbg0KPiA+ID4gZmxhc2guDQo+ID4gPiBPdGhl
ciBkcml2ZXJzIHdvbid0IGJlIGFibGUgdG8gaWRlbnRpZnkgYmFkIEJCVCBibG9ja3MgYW5kIHRo
dXMgY2FuJ3QNCj4gPiA+IHNraXANCj4gPiA+IHRoZXNlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gUmllZG11ZWxsZXIgPHMucmllZG11ZWxsZXJAcGh5dGVjLmRlPg0KPiA+
IA0KPiA+IEJlc2lkZXMgdGhlIGFsaWdubWVudCBvZiB0aGUgaGVscGVyIHBhcmFtZXRlcnMgKG5p
dHBpY2spIHRoZSBwYXRjaA0KPiA+IGxvb2tzIGdvb2QgdG8gbWUuIElmIHdlIGNhbiBnZXQgc29t
ZW9uZSB0byB0ZXN0IGl0IGJlZm9yZSB0aGUgbWVyZ2UNCj4gPiB3aW5kb3cgY2xvc2VzIGl0J3Mg
cGVyZmVjdC4gT3RoZXJ3aXNlIEknbGwgYXBwbHkgaXQgYW5kIHdlJ2xsIGxldCByb2JvdHMNCj4g
PiBkbyB0aGUgam9iLg0KPiANCj4gQWRkZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiB2NS4xMC4yMSBh
bmQgYm9vdGVkIGEgU0FNQTVEMjcgYmFzZWQgYm9hcmQsIGZyb20NCj4gdGhlIA0KPiBib290IGxv
ZzoNCj4gDQo+IG5hbmQ6IGRldmljZSBmb3VuZCwgTWFudWZhY3R1cmVyIElEOiAweDAxLCBDaGlw
IElEOiAweGRhDQo+IG5hbmQ6IEFNRC9TcGFuc2lvbiBTMzRNTDAyRzENCj4gbmFuZDogMjU2IE1p
QiwgU0xDLCBlcmFzZSBzaXplOiAxMjggS2lCLCBwYWdlIHNpemU6IDIwNDgsIE9PQiBzaXplOiA2
NA0KPiBCYWQgYmxvY2sgdGFibGUgZm91bmQgYXQgcGFnZSAxMzEwMDgsIHZlcnNpb24gMHhGRg0K
PiBCYWQgYmxvY2sgdGFibGUgZm91bmQgYXQgcGFnZSAxMzA5NDQsIHZlcnNpb24gMHhGRg0KPiA2
IGNtZGxpbmVwYXJ0IHBhcnRpdGlvbnMgZm91bmQgb24gTVREIGRldmljZSBhdG1lbF9uYW5kDQo+
IENyZWF0aW5nIDYgTVREIHBhcnRpdGlvbnMgb24gImF0bWVsX25hbmQiOg0KPiAweDAwMDAwMDAw
MDAwMC0weDAwMDAwMDA0MDAwMCA6ICJib290c3RyYXAiDQo+IDB4MDAwMDAwMDQwMDAwLTB4MDAw
MDAwMTAwMDAwIDogInVib290Ig0KPiAweDAwMDAwMDEwMDAwMC0weDAwMDAwMDE0MDAwMCA6ICJl
bnYxIg0KPiAweDAwMDAwMDE0MDAwMC0weDAwMDAwMDE4MDAwMCA6ICJlbnYyIg0KPiAweDAwMDAw
MDE4MDAwMC0weDAwMDAwMDIwMDAwMCA6ICJyZXNlcnZlZCINCj4gMHgwMDAwMDAyMDAwMDAtMHgw
MDAwMTAwMDAwMDAgOiAiVUJJIg0KPiBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3
DQo+IHViaTA6IGF0dGFjaGluZyBtdGQ1DQo+IHJhbmRvbTogZmFzdCBpbml0IGRvbmUNCj4gdWJp
MDogc2Nhbm5pbmcgaXMgZmluaXNoZWQNCj4gdWJpMDogYXR0YWNoZWQgbXRkNSAobmFtZSAiVUJJ
Iiwgc2l6ZSAyNTQgTWlCKQ0KPiB1YmkwOiBQRUIgc2l6ZTogMTMxMDcyIGJ5dGVzICgxMjggS2lC
KSwgTEVCIHNpemU6IDEyNjk3NiBieXRlcw0KPiB1YmkwOiBtaW4uL21heC4gSS9PIHVuaXQgc2l6
ZXM6IDIwNDgvMjA0OCwgc3ViLXBhZ2Ugc2l6ZSAyMDQ4DQo+IHViaTA6IFZJRCBoZWFkZXIgb2Zm
c2V0OiAyMDQ4IChhbGlnbmVkIDIwNDgpLCBkYXRhIG9mZnNldDogNDA5Ng0KPiB1YmkwOiBnb29k
IFBFQnM6IDIwMjgsIGJhZCBQRUJzOiA0LCBjb3JydXB0ZWQgUEVCczogMA0KPiB1YmkwOiB1c2Vy
IHZvbHVtZTogNCwgaW50ZXJuYWwgdm9sdW1lczogMSwgbWF4LiB2b2x1bWVzIGNvdW50OiAxMjgN
Cj4gdWJpMDogbWF4L21lYW4gZXJhc2UgY291bnRlcjogNC8xLCBXTCB0aHJlc2hvbGQ6IDQwOTYs
IGltYWdlIHNlcXVlbmNlDQo+IG51bWJlcjogDQo+IDE2MDA4MTIxODkNCj4gdWJpMDogYXZhaWxh
YmxlIFBFQnM6IDAsIHRvdGFsIHJlc2VydmVkIFBFQnM6IDIwMjgsIFBFQnMgcmVzZXJ2ZWQgZm9y
IGJhZA0KPiBQRUIgDQo+IGhhbmRsaW5nOiAzNg0KPiB1YmkwOiBiYWNrZ3JvdW5kIHRocmVhZCAi
dWJpX2JndDBkIiBzdGFydGVkLCBQSUQgODUNCj4gDQo+IE5vIHN1c3BpY2lvdXMgb3RoZXIgbWVz
c2FnZXMuIA0KPiANCj4gTm90IHN1cmUgaWYgdGhhdCBkZXZpY2Ugd291bGQgYmUgYWZmZWN0ZWQg
YW55d2F5cy4gTm8gYmFkIGJsb2NrcyBhcmUga25vd24NCj4gb24gDQo+IHRoaXMgZmxhc2gsIGRl
dmljZSBiZWhhdmVzIGFzIHVzdWFsLg0KDQpUaGFua3MgZm9yIHRlc3RpbmchIDopDQoNClJlZ2Fy
ZHMsDQpTdGVmYW4NCg0KPiANCj4gSFRIICYgR3JlZXRzDQo+IEFsZXgNCj4gDQo+ID4gPiAtLS0N
Cj4gPiA+IA0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+IHRoaXMgaXMgdGhlIHNlY29uZCBhcHBy
b2FjaCBvZiB0aGlzIHBhdGNoLiBUaGUgZmlyc3Qgb25lIFsxXQ0KPiA+ID4gdW5mb3J0dW5hdGVs
eQ0KPiA+ID4gbGVhZCB0byBib290IGZhaWx1cmVzIG9uIGkuTVggMjcgYm9hcmRzIFsyXSBzaW5j
ZSB0aGUgaS5NWCAyNyBkcml2ZXINCj4gPiA+IHVzZXMNCj4gPiA+IHRoZSBiYWQgYmxvY2sgbWFy
a2VyIHBvc2l0aW9uIGZvciB0aGUgYmFkIGJsb2NrIHRhYmxlIG1hcmtlciB3aGljaCBsZWFkDQo+
ID4gPiB0byBmYWxzZWx5IGlkZW50aWZ5aW5nIGFsbCBCQlQgYmxvY2tzIGFzIGJhZC4NCj4gPiA+
IA0KPiA+ID4gVGhpcyBuZXcgcGF0Y2ggbm93IHNraXBzIHRoZSBjaGVjayBmb3IgYmFkIEJCVCBi
bG9ja3MgaWYgdGhlIEJCVCBtYXJrZXINCj4gPiA+IHBvc2l0aW9uIGluIE9PQiBvdmVybGFwcyB3
aXRoIHRoZSBiYWQgYmxvY2sgbWFya2VyIHBvc2l0aW9uIG9yIGlmIGENCj4gPiA+IGRyaXZlcg0K
PiA+ID4gY2FuJ3QgdXNlIGJhZCBibG9jayBtYXJrZXJzIGluIGZsYXNoIGF0IGFsbCAoTkFORF9C
QlRfTk9fT09CX0JCTSBvcg0KPiA+ID4gTkFORF9OT19CQk1fUVVJUksgYXJlIHNldCkuIFRoaXMg
aG9wZWZ1bGx5IG1ha2VzIHN1cmUgd2UgZG9uJ3QgYnJlYWsNCj4gPiA+IGRyaXZlcnMgd2hpY2gg
Y2Fubm90IGNoZWNrIGZvciBiYWQgQkJUIGJsb2NrcyBkdWUgdG8gdGhlIGxpbWl0YXRpb25zDQo+
ID4gPiBtZW50aW9uZWQgYmVmb3JlLg0KPiA+ID4gDQo+ID4gPiBJIHdhcyBvbmx5IGFibGUgdG8g
dGVzdCB0aGlzIHBhdGNoIG9uIGEgcGh5Q09SRS1pLk1YIDYgYW5kIGEgcGh5Q0FSRC0NCj4gPiA+
IGkuTVgNCj4gPiA+IDI3LiBUaGVyZm9yZSB3b3VsZCByZWFsbHkgYXBwcmVjaWF0ZSBtb3JlIHBl
b3BsZSB0ZXN0aW5nIHRoaXMgdG8gbWFrZQ0KPiA+ID4gc3VyZSBJIGhhdmUgbm90IG1pc3NlZCBh
bm90aGVyIHVzZSBjYXNlIHdoZXJlIHRoZSBiYWQgYmxvY2sgbWFya2VyDQo+ID4gPiBwb3NpdGlv
biBpbiBPT0IgaXMgdXNlZCBpbiBhIGRpZmZlcmVudCB3YXkgdGhhbiBmb3IgdGhlIEJCTS4NCj4g
PiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IFN0ZWZhbg0KPiA+ID4gDQo+ID4gPiBbMV0NCj4g
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIxMDMyNTEwMjMzNy40ODEx
NzItMS1zLnJpZWRtdWVsbGVyQHANCj4gPiA+IGh5dGVjLmRlLyBbMl0NCj4gPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC9DQU9NWk81RHVmVlI9K0V6Q2ExLU1QVWMrWmVmWlZU
WGI1S2d1M1cNCj4gPiA+IHhtczdjeHc5R21HZ0BtYWlsLmdtYWlsLmNvbS8+IA0KPiA+ID4gIGRy
aXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmJ0LmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYnQuYw0K
PiA+ID4gYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2JidC5jIGluZGV4IGRjZWQzMmExMjZk
OS4uMmEzMDcxNDM1MGVlDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25h
bmQvcmF3L25hbmRfYmJ0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRf
YmJ0LmMNCj4gPiA+IEBAIC00NDcsNiArNDQ3LDM2IEBAIHN0YXRpYyBpbnQgc2Nhbl9ibG9ja19m
YXN0KHN0cnVjdCBuYW5kX2NoaXAgKnRoaXMsDQo+ID4gPiBzdHJ1Y3QgbmFuZF9iYnRfZGVzY3Ig
KmJkLD4gDQo+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gIA0KPiA+ID4gIH0NCj4gPiA+IA0KPiA+
ID4gKy8qIENoZWNrIGlmIGEgcG90ZW50aWFsIEJCVCBibG9jayBpcyBtYXJrZWQgYXMgYmFkICov
DQo+ID4gPiArc3RhdGljIGludCBiYnRfYmxvY2tfY2hlY2tiYWQoc3RydWN0IG5hbmRfY2hpcCAq
dGhpcywNCj4gPiA+ICsJCQkJICAgICAgc3RydWN0IG5hbmRfYmJ0X2Rlc2NyICp0ZCwNCj4gPiA+
ICsJCQkJICAgICAgbG9mZl90IG9mZnMsIHVpbnQ4X3QgKmJ1ZikNCj4gPiA+ICt7DQo+ID4gPiAr
CXN0cnVjdCBuYW5kX2JidF9kZXNjciAqYmQgPSB0aGlzLT5iYWRibG9ja19wYXR0ZXJuOw0KPiA+
ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBObyBuZWVkIHRvIGNoZWNrIGZvciBhIGJhZCBC
QlQgYmxvY2sgaWYgdGhlIEJCTSBhcmVhIG92ZXJsYXBzIHdpdGgNCj4gPiA+ICsJICogdGhlIGJh
ZCBibG9jayB0YWJsZSBtYXJrZXIgYXJlYSBpbiBPT0Igc2luY2Ugd3JpdGluZyBhIEJCTSBoZXJl
DQo+ID4gPiArCSAqIGludmFsaWRhdGVzIHRoZSBiYWQgYmxvY2sgdGFibGUgbWFya2VyIGFueXdh
eS4NCj4gPiA+ICsJICovDQo+ID4gPiArCWlmICghKHRkLT5vcHRpb25zICYgTkFORF9CQlRfTk9f
T09CKSAmJg0KPiA+ID4gKwkgICAgdGQtPm9mZnMgPj0gYmQtPm9mZnMgJiYgdGQtPm9mZnMgPCBi
ZC0+b2ZmcyArIGJkLT5sZW4pDQo+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICsJ
LyoNCj4gPiA+ICsJICogVGhlcmUgaXMgbm8gcG9pbnQgaW4gY2hlY2tpbmcgZm9yIGEgYmFkIGJs
b2NrIG1hcmtlciBpZiB3cml0aW5nDQo+ID4gPiArCSAqIHN1Y2ggbWFya2VyIGlzIG5vdCBzdXBw
b3J0ZWQNCj4gPiA+ICsJICovDQo+ID4gPiArCWlmICh0aGlzLT5iYnRfb3B0aW9ucyAmIE5BTkRf
QkJUX05PX09PQl9CQk0gfHwNCj4gPiA+ICsJICAgIHRoaXMtPm9wdGlvbnMgJiBOQU5EX05PX0JC
TV9RVUlSSykNCj4gPiA+ICsJCXJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoc2Nhbl9i
bG9ja19mYXN0KHRoaXMsIGJkLCBvZmZzLCBidWYpID4gMCkNCj4gPiA+ICsJCXJldHVybiAxOw0K
PiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiANCj4g
PiA+ICAvKioNCj4gPiA+ICANCj4gPiA+ICAgKiBjcmVhdGVfYmJ0IC0gW0dFTkVSSUNdIENyZWF0
ZSBhIGJhZCBibG9jayB0YWJsZSBieSBzY2FubmluZyB0aGUNCj4gPiA+IGRldmljZQ0KPiA+ID4g
ICAqIEB0aGlzOiBOQU5EIGNoaXAgb2JqZWN0DQo+ID4gPiANCj4gPiA+IEBAIC01NjAsNiArNTkw
LDEwIEBAIHN0YXRpYyBpbnQgc2VhcmNoX2JidChzdHJ1Y3QgbmFuZF9jaGlwICp0aGlzLA0KPiA+
ID4gdWludDhfdA0KPiA+ID4gKmJ1Ziw+IA0KPiA+ID4gIAkJCWludCBhY3RibG9jayA9IHN0YXJ0
YmxvY2sgKyBkaXIgKiBibG9jazsNCj4gPiA+ICAJCQlsb2ZmX3Qgb2ZmcyA9IChsb2ZmX3QpYWN0
YmxvY2sgPDwgdGhpcy0NCj4gPiA+ID5iYnRfZXJhc2Vfc2hpZnQ7DQo+ID4gPiANCj4gPiA+ICsJ
CQkvKiBDaGVjayBpZiBibG9jayBpcyBtYXJrZWQgYmFkICovDQo+ID4gPiArCQkJaWYgKGJidF9i
bG9ja19jaGVja2JhZCh0aGlzLCB0ZCwgb2ZmcywgYnVmKSkNCj4gPiA+ICsJCQkJY29udGludWU7
DQo+ID4gPiArDQo+ID4gPiANCj4gPiA+ICAJCQkvKiBSZWFkIGZpcnN0IHBhZ2UgKi8NCj4gPiA+
ICAJCQlzY2FuX3JlYWQodGhpcywgYnVmLCBvZmZzLCBtdGQtPndyaXRlc2l6ZSwgdGQpOw0KPiA+
ID4gIAkJCWlmICghY2hlY2tfcGF0dGVybihidWYsIHNjYW5sZW4sIG10ZC0+d3JpdGVzaXplLCB0
ZCkpDQo+ID4gPiB7DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IE1pcXXDqGwNCj4gPiANCj4gPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4gPiBodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8NCj4gDQo+IA0KPiANCg==
