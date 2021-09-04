Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64711400BC4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhIDPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:01:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38888 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230039AbhIDPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:01:54 -0400
X-UUID: 56e0fa7b868d4402aa2d51213ca8313d-20210904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RyIAY0T/rYq+im92ZCaJuNgcDI6T0FxoLAPeoBZwg3U=;
        b=U6PR2L8xM1YAxnhz0JVtId+gYJJbzY2jpp0NbchcRVISHGiwXMKY6TR2ytyCTZaGdcJgws2iU5RTgh9lsUnxJHX8hxuNc8prkJH6cPwxFA+Yud8m72G1yDqiRgqMVpmgXT4ctvieqDJqq/9RFCGOAuM+AHL3FSQ30dHYFWPhTY4=;
X-UUID: 56e0fa7b868d4402aa2d51213ca8313d-20210904
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 943019367; Sat, 04 Sep 2021 23:00:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Sep 2021 23:00:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Sep 2021 23:00:48 +0800
Message-ID: <42a32455186e5deb476cca74e64de18e8cc1a34c.camel@mediatek.com>
Subject: Re: [PATCH] clk: rockchip: use module_platform_driver_probe
From:   Miles Chen <miles.chen@mediatek.com>
To:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Sat, 4 Sep 2021 23:00:48 +0800
In-Reply-To: <1764446.vrLGdHa7mH@diego>
References: <20210902075713.7563-1-miles.chen@mediatek.com>
         <1764446.vrLGdHa7mH@diego>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTAzIGF0IDIyOjU5ICswMjAwLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToN
Cj4gQW0gRG9ubmVyc3RhZywgMi4gU2VwdGVtYmVyIDIwMjEsIDA5OjU3OjEzIENFU1Qgc2Nocmll
YiBNaWxlcyBDaGVuOg0KPiA+IFJlcGxhY2UgYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUg
d2l0aA0KPiA+IG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUNCj4gPiBiZWNhdXNlIHRoYXQg
cmszMzk5IGFuZCByazM1NjggY2FuIGJlIGJ1aWx0IGFzIGtlcm5lbCBtb2R1bGVzLg0KPiA+IA0K
PiA+IENjOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBvbiBib3RoIHJr
MzM5OSBhbmQgcmszNTY4Og0KPiBUZXN0ZWQtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRl
Y2guZGU+DQo+IA0KPiBhbmQgYWxzbw0KPiBSZXZpZXdlZC1ieTogSGVpa28gU3R1ZWJuZXIgPGhl
aWtvQHNudGVjaC5kZT4NCj4gDQoNCnRoYW5rcyBmb3IgZG9pbmcgdGhlIHRlc3QuIEkgd2lsbCBh
ZGQgeW91ciB0YWdzIGluIG15IG5leHQgcGF0Y2guDQo+IA0KPiBIZWlrbw0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrLXJrMzM5OS5jIHwgMiArLQ0KPiA+ICBkcml2
ZXJzL2Nsay9yb2NrY2hpcC9jbGstcmszNTY4LmMgfCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9yb2NrY2hpcC9jbGstcmszMzk5LmMNCj4gPiBiL2RyaXZlcnMvY2xrL3Jv
Y2tjaGlwL2Nsay1yazMzOTkuYw0KPiA+IGluZGV4IDYyYTRmMjU0Mzk2MC4uYTUxNjkxNTZmMWQy
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3JvY2tjaGlwL2Nsay1yazMzOTkuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvY2xrL3JvY2tjaGlwL2Nsay1yazMzOTkuYw0KPiA+IEBAIC0xNjUzLDcg
KzE2NTMsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlcg0KPiA+IGNsa19yazMzOTlf
ZHJpdmVyID0gew0KPiA+ICAJCS5zdXBwcmVzc19iaW5kX2F0dHJzID0gdHJ1ZSwNCj4gPiAgCX0s
DQo+ID4gIH07DQo+ID4gLWJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyX3Byb2JlKGNsa19yazMzOTlf
ZHJpdmVyLA0KPiA+IGNsa19yazMzOTlfcHJvYmUpOw0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJp
dmVyX3Byb2JlKGNsa19yazMzOTlfZHJpdmVyLCBjbGtfcmszMzk5X3Byb2JlKTsNCj4gPiAgDQo+
ID4gIE1PRFVMRV9ERVNDUklQVElPTigiUm9ja2NoaXAgUkszMzk5IENsb2NrIERyaXZlciIpOw0K
PiA+ICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L3JvY2tjaGlwL2Nsay1yazM1NjguYw0KPiA+IGIvZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrLXJr
MzU2OC5jDQo+ID4gaW5kZXggNzVjYTg1NWU3MjBkLi45MzllNzA3OWMzMzQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9jbGsvcm9ja2NoaXAvY2xrLXJrMzU2OC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9jbGsvcm9ja2NoaXAvY2xrLXJrMzU2OC5jDQo+ID4gQEAgLTE3MTksNyArMTcxOSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyDQo+ID4gY2xrX3JrMzU2OF9kcml2ZXIgPSB7DQo+
ID4gIAkJLnN1cHByZXNzX2JpbmRfYXR0cnMgPSB0cnVlLA0KPiA+ICAJfSwNCj4gPiAgfTsNCj4g
PiAtYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUoY2xrX3JrMzU2OF9kcml2ZXIsDQo+ID4g
Y2xrX3JrMzU2OF9wcm9iZSk7DQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUoY2xr
X3JrMzU2OF9kcml2ZXIsIGNsa19yazM1NjhfcHJvYmUpOw0KPiA+ICANCj4gPiAgTU9EVUxFX0RF
U0NSSVBUSU9OKCJSb2NrY2hpcCBSSzM1NjggQ2xvY2sgRHJpdmVyIik7DQo+ID4gIE1PRFVMRV9M
SUNFTlNFKCJHUEwiKTsNCj4gPiANCj4gDQo+IA0KPiANCj4gDQo=

