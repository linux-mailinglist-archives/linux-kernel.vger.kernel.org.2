Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8C390DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEZBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:46:31 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20674 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230306AbhEZBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:46:29 -0400
X-UUID: 403647ee35cf48008ed38b7218b6d2af-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NmtG8PtbQGS64/5D4XTWx2C/g8jAAgXP164fQIUW45A=;
        b=Q9E5cXo9aXD6XSawc5MLK/h9cgswAyrIzSrBuUsr4SankYVwMq1p+7WuVU1GvZm00DyvwIEF1i6ugCuAzbftnG6yZKK4fpWiLM2e/i4V0Qw/OXTWriT9AGaSthd04nOCEAc7r/H731G93Uy5y/ObPWQKCrtAO4j4j8aE/BQBe5Q=;
X-UUID: 403647ee35cf48008ed38b7218b6d2af-20210526
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 775569361; Wed, 26 May 2021 09:44:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 09:44:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 09:44:48 +0800
Message-ID: <1621993487.26501.19.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/3] Revert "usb: common: usb-conn-gpio: Make VBUS
 supply optional"
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Thierry Reding <treding@nvidia.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 May 2021 09:44:47 +0800
In-Reply-To: <YKzhPnMU3PXx+tXK@orome.fritz.box>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
         <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
         <YKezl0nlWFQhLyf/@orome.fritz.box> <1621835511.26501.14.camel@mhfsdcap03>
         <YKzhPnMU3PXx+tXK@orome.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DBEF9475E366CD9EE010AAD1B760E5197873115102002DEC0FB5709042E1CFEF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTI1IGF0IDEzOjM2ICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToN
Cj4gT24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgMDE6NTE6NTFQTSArMDgwMCwgQ2h1bmZlbmcgWXVu
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMS0wNS0yMSBhdCAxNToyMCArMDIwMCwgVGhpZXJyeSBS
ZWRpbmcgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCAwMjozOTo0NlBNICsw
ODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gPiA+IFZidXMgaXMgYWxyZWFkeSBhbiBvcHRp
b25hbCBzdXBwbHksIGlmIHRoZSB2YnVzLXN1cHBseSBpcyBub3QNCj4gPiA+ID4gcHJvdmlkZWQg
aW4gRFRTLCB3aWxsIHVzZSBhIGR1bW15IHJlZ3VsYXRvciwNCj4gPiA+IA0KPiA+ID4gVGhhdCBz
dGF0ZW1lbnQgaXMgbm90IGVudGlyZWx5IGNvcnJlY3QuIFRoZSBkdW1teSByZWd1bGF0b3IgaXMN
Cj4gPiA+IHN1YnN0aXR1dGVkIG9ubHkgaWYgdGhlIHN1cHBseSBpcyBpbiBmYWN0IG5vdCBvcHRp
b25hbC4gVGhlIGlkZWEgYmVoaW5kDQo+ID4gPiB0aGF0IGlzIHRvIGFsbG93IERUUyBmaWxlcyB0
aGF0IGRvbid0IHNwZWNpZnkgYWxsIHJlcXVpcmVkIHJlZ3VsYXRvcnMgdG8NCj4gPiA+IGdldCBh
d2F5IHdpdGggaXQsIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHN1cHBseSBpcyBv
bmUgb2YNCj4gPiA+IHRob3NlIGFsd2F5cy1vbiBzdXBwbGllcyB0aGF0IGFyZSBvZnRlbiBub3Qg
ZGVzY3JpYmVkIGluIERUUy4NCj4gPiBZZXMsIHlvdSBhcmUgcmlnaHQuDQo+ID4gQnV0IGZyb20g
dGhlIHBvaW50IG9mIHJlc3VsdCwgaXQgaW5kZWVkIGNhbiBoZWxwIHRvIGhhbmRsZSB0aGUgYWJz
ZW50DQo+ID4gcmVndWxhdG9yLg0KPiA+ID4gDQo+ID4gPiA+IHRoZSB3YXJuaW5nIGxvZyBpcyBh
cyBiZWxvdzoNCj4gPiA+ID4gInN1cHBseSB2YnVzIG5vdCBmb3VuZCwgdXNpbmcgZHVtbXkgcmVn
dWxhdG9yIg0KPiA+ID4gDQo+ID4gPiBBbmQgdGhlIHJlYXNvbiB3aHkgd2UgZ2V0IHRoYXQgd2Fy
bmluZyBpcyB0byBwb2ludCBvdXQgdGhhdCB0aGUgRFRTIGhhcw0KPiA+ID4gYSBidWcgYW5kIHRo
YXQgaXQgc2hvdWxkIGJlIGZpeGVkIChieSBhZGRpbmcgYSBwcm9wZXIgcmVndWxhdG9yIHRvIHRh
a2UNCj4gPiA+IHRoZSBwbGFjZSBvZiB0aGUgZHVtbXkpLg0KPiA+ID4gDQo+ID4gPiA+IFRoaXMg
cmV2ZXJ0cyBjb21taXQgNGRkZjFhYzc5ZTVmMDgyNDUxY2Q1NDkyODNkMmViNzU1OWFiNmNhOS4N
Cj4gPiA+IA0KPiA+ID4gQnV0IGlmIHlvdSByZWFkIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGF0IGNv
bW1pdCwgdGhlIHB1cnBvc2Ugb2YgdGhhdA0KPiA+ID4gcGF0Y2ggd2FzIGluIGZhY3QgdG8gbWFr
ZSB0aGUgc3VwcGx5IGNvbXBsZXRlbHkgb3B0aW9uYWwgaW4gdGhlIGNhc2UNCj4gPiA+IHdoZXJl
IHdlIGFscmVhZHkgaGF2ZSB0aGUgVkJVUyBzdXBwbHkgc3BlY2lmaWVkIGZvciB0aGUgVVNCIHBv
cnQgdGhhdA0KPiA+ID4gdGhlIGNvbm5lY3RvciBpcyBwYXJlbnRlZCB0by4NCj4gPiBDb3VsZCB5
b3UgcGxlYXNlIGdpdmUgYW4gZXhhbXBsZSB5b3UgbWVudGlvbmVkPw0KPiANCj4gWW91IGNhbiBm
aW5kIGV4YW1wbGVzIG9mIHRoaXMgaW4gdGhlc2U6DQo+IA0KPiAJYXJjaC9hcm02NC9ib290L2R0
cy9udmlkaWEvdGVncmEyMTAtcDI1OTcuZHRzaQ0KPiAJYXJjaC9hcm02NC9ib290L2R0cy9udmlk
aWEvdGVncmEyMTAtcDM0NTAtMDAwMC5kdHMNCj4gCWFyY2gvYXJtNjQvYm9vdC9kdHMvbnZpZGlh
L3RlZ3JhMTg2LXAyNzcxLTAwMDAuZHRzDQo+IA0KPiA+IEl0IHNlZW1zIHByZWZlciB0byBwcm92
aWRlIHZidXMgc3VwcGx5IGluIGNvbm5lY3RvciBpbnN0ZWFkIG9mIHBvcnQNCj4gPiBhY2NvcmRp
bmcgdG8gZHQtYmluZGluZw0KPiANCj4gTXkgcmVjb2xsZWN0aW9uIGlzIHRoYXQgdGhlIGFib3Zl
IChvciBhdCBsZWFzdCBzb21lIG9mIHRoZW0pIHByZWRhdGUgVVNCDQo+IGNvbm5lY3RvcnMuDQo+
IA0KPiBJdCdzIHBvc3NpYmxlIHRoYXQgd2UgY291bGQgY29udmVydCB0aGUgYWJvdmUgdG8gaGF2
ZSB0aGUgVkJVUyBzdXBwbHkNCj4gbGlzdGVkIGluIHRoZSBjb25uZWN0b3IgaW5zdGVhZCBvZiB0
aGUgcG9ydC4gSG93ZXZlciwgc2luY2Ugd2UgaGF2ZSB0bw0KPiBwcmVzZXJ2ZSBiYWNrd2FyZHMg
Y29tcGF0aWJpbGl0eSB3aXRoIG9sZGVyIGRldmljZSB0cmVlcywgd2UgY2FuJ3QNCj4gcmV2ZXJ0
IHRoZSBjb21taXQgYW55d2F5Lg0KR290IGl0LCB0aGFua3MgYSBsb3QNCg0KPiANCj4gVGhpZXJy
eQ0KDQo=

