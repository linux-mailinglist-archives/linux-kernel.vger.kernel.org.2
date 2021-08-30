Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05903FBC97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhH3SoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:44:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50118 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229738AbhH3SoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:44:01 -0400
X-UUID: 3c38feffae8d4552b46d08b8f31ad6cd-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=crEFcIJTwJOrLYU5quGGhCcTCYZ9VLSPd8BGPPPojGA=;
        b=BSuZvyQw78QfkmkEI6Rrv5Klossyk2XJHBT8hKa5VpcgLWC5/9MyWDcOLQbRsXNSbIeW98kBGIUReWu90oudjM/gpS83yOUH6NGqPEpHldJtqByCwiPnen9ajEAWAd+KKheb1eU7+qCCX3uq9dtf7IwOYlo9VE325CvvfrBf+Hg=;
X-UUID: 3c38feffae8d4552b46d08b8f31ad6cd-20210831
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1083142343; Tue, 31 Aug 2021 02:43:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 02:43:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 02:43:04 +0800
Message-ID: <1630348984.24981.2.camel@mtkswgap22>
Subject: Re: [RESEND PATCH 3/4] clk: mediatek: support COMMON_CLK_MT6779
 module build
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        "Hanks Chen" <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Date:   Tue, 31 Aug 2021 02:43:04 +0800
In-Reply-To: <163021049667.2676726.10138202396240942833@swboyd.mtv.corp.google.com>
References: <20210813032429.14715-1-miles.chen@mediatek.com>
         <20210813032429.14715-4-miles.chen@mediatek.com>
         <163021049667.2676726.10138202396240942833@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTA4LTI4IGF0IDIxOjE0IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgTWlsZXMgQ2hlbiAoMjAyMS0wOC0xMiAyMDoyNDoyOCkNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc3OS1hdWQuYyBiL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDY3NzktYXVkLmMNCj4gPiBpbmRleCAxMWIyMDlmOTVlMjUuLjQzOWMwYmM5
NGI3MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ2Nzc5LWF1
ZC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc3OS1hdWQuYw0KPiA+
IEBAIC00LDYgKzQsNyBAQA0KPiA+ICAgKiBBdXRob3I6IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4gICAqLw0KPiA+ICANCj4gPiArI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+
IEBAIC0xMTUsMyArMTE2LDQgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgY2xrX210
Njc3OV9hdWRfZHJ2ID0gew0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgYnVpbHRpbl9wbGF0Zm9ybV9k
cml2ZXIoY2xrX210Njc3OV9hdWRfZHJ2KTsNCj4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0K
PiANCj4gSG93IGRvZXMgdGhpcyB3b3JrPyBidWlsdGluX3BsYXRmb3JtX2RyaXZlcigpIG1lYW5z
IHRoYXQgaXQncyBub3QNCj4gbW9kdWxhciBjb2RlLiBTaG91bGRuJ3QgdGhhdCBiZSBtb2R1bGVf
cGxhdGZvcm1fZHJpdmVyKCk/IEhhdmUgeW91IHRyaWVkDQo+IGxvYWRpbmcgYW5kIHVubG9hZGlu
ZyB0aGUgbW9kdWxlPw0KDQpzb3JyeSBmb3IgbXkgbGF0ZSByZXNwb25zZS4gDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkgaGF2ZSB0aGUgc2FtZSBxdWVzdGlvbiB3aGVuIEkgd2Fz
DQpidWlsZGluZyB0aGlzIHBhdGNoLiBUaGF0IHRpbWUgSSBmb3VuZCBzb21lIGV4YW1wbGVzIHdo
ZXJlDQp0aGV5IGFyZSB1c2luZyBidWlsdGluX3BsYXRmb3JtX2RyaXZlciBhbmQgY2FuIGJlIGJ1
aWx0IGFzIA0Ka2VybmVsIG1vZHVsZXM6DQoNCmNvbmZpZyBDTEtfSU1YOFFYUCAodHJpc3RhdGUp
ICYmIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OHF4cC1scGNnLmMNCmNvbmZpZyBDTEtfUkszMzk5
ICh0cmlzdGF0ZSkgJiYgZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrLXJrMzM5OS5jDQoNCm15IGxv
YWQgdGVzdDoNCmxvYWQgdGhlc2UgbW9kdWxlc3MgYW5kIGRvICdsc21vZCcgb24gdjUuMTQtcmMx
L210Njc3OSBlbnZpcm9ubWVudDoNCg0KY2xrX210Njc3OV9hdWQgMTYzODQgMCBbcGVybWFuZW50
XSwgTGl2ZSAweGZmZmY4MDAwMDhmZDgwMDANCmNsa19tdDY3NzlfbWZnIDE2Mzg0IDAgW3Blcm1h
bmVudF0sIExpdmUgMHhmZmZmODAwMDA4ZmQwMDAwDQpjbGtfbXQ2Nzc5X3ZlbmMgMTYzODQgMCBb
cGVybWFuZW50XSwgTGl2ZSAweGZmZmY4MDAwMDhmYzgwMDANCmNsa19tdDY3NzlfdmRlYyAxNjM4
NCAwIFtwZXJtYW5lbnRdLCBMaXZlIDB4ZmZmZjgwMDAwOGZjMDAwMA0KY2xrX210Njc3OV9jYW0g
MTYzODQgMCBbcGVybWFuZW50XSwgTGl2ZSAweGZmZmY4MDAwMDhmYjgwMDANCmNsa19tdDY3Nzlf
aXBlIDE2Mzg0IDAgW3Blcm1hbmVudF0sIExpdmUgMHhmZmZmODAwMDA4ZmIwMDAwDQpjbGtfbXQ2
Nzc5X2ltZyAxNjM4NCAwIFtwZXJtYW5lbnRdLCBMaXZlIDB4ZmZmZjgwMDAwOGZhODAwMA0KY2xr
X210Njc3OV9tbSAxNjM4NCAwIFtwZXJtYW5lbnRdLCBMaXZlIDB4ZmZmZjgwMDAwOGZhMDAwMA0K
DQpJIGRpZCBub3QgdGVzdCAndW5sb2FkJyBrZXJuZWwgbW9kdWxlcyBiZWNhdXNlIEkgZGlkIG5v
dA0KZGVmaW5lIG1vZHVsZV9leGl0IGluIHRoaXMgcGF0Y2guDQoNCkJ1dCBhcyB5b3UgcG9pbnRl
ZCBvdXQsIGl0IHNob3VsZCBiZSBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKCkuDQpJIHdpbGwgdXNl
IG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoKSBpbiB0aGUgbmV4dCBwYXRjaC4NCg0KDQpNaWxlcw0K

