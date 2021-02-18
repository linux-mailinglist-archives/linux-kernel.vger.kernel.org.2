Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F0231E973
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhBRL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:59:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39931 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232854AbhBRKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:32:06 -0500
X-UUID: 471a6bc633954277bbe2f8199d179daf-20210218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eON87UBh4F9YZE2o4i+l3IiN/mJ3GXZV1FRvjVbIqC0=;
        b=LeXI2DTFzLPmSm8dn0aEv8G3MR1FHCVy3J+TAPwJyGosZyEUlAvfKpceh74+twkU1H5CwhWcQgzSw9sso83EyCIvSrS+QYsUGTIHbP7Xb8DwnLP1DA5kLPougo3iFFURIkT9p/nveibo2Df8HyBwAZ7LYkkKLwPt6g+SqKkTpwQ=;
X-UUID: 471a6bc633954277bbe2f8199d179daf-20210218
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2003067634; Thu, 18 Feb 2021 18:31:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 18:31:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 18:31:03 +0800
Message-ID: <1613644263.10586.8.camel@mtksdaap41>
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add mt8192 power domains
 controller
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 18 Feb 2021 18:31:03 +0800
In-Reply-To: <1606734983.24689.1.camel@mtksdaap41>
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
         <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com>
         <1605791419.19819.4.camel@mtksdaap41>
         <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
         <1f25cc3f-324a-0020-7bf2-e5a915291522@gmail.com>
         <1606734983.24689.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE5OjE2ICswODAwLCBXZWl5aSBMdSB3cm90ZToNCj4gT24g
RnJpLCAyMDIwLTExLTI3IGF0IDEzOjQyICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0K
PiA+IA0KPiA+IE9uIDE5LzExLzIwMjAgMTU6MTMsIEVucmljIEJhbGxldGJvIFNlcnJhIHdyb3Rl
Og0KPiA+ID4gSGkgV2VpeWksDQo+ID4gPiANCj4gPiA+IE1pc3NhdGdlIGRlIFdlaXlpIEx1IDx3
ZWl5aS5sdUBtZWRpYXRlay5jb20+IGRlbCBkaWEgZGouLCAxOSBkZSBub3YuDQo+ID4gPiAyMDIw
IGEgbGVzIDE0OjEwOg0KPiA+ID4+DQo+ID4gPj4gT24gVGh1LCAyMDIwLTExLTE5IGF0IDEzOjEz
ICswMTAwLCBFbnJpYyBCYWxsZXRibyBTZXJyYSB3cm90ZToNCj4gPiA+Pj4gSGkgV2VpeWksDQo+
ID4gPj4+DQo+ID4gPj4+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoDQo+ID4gPj4+DQo+ID4gPj4+
IE1pc3NhdGdlIGRlIFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+IGRlbCBkaWEgZGou
LCAxOSBkZSBub3YuDQo+ID4gPj4+IDIwMjAgYSBsZXMgMTE6NDg6DQo+ID4gPj4+Pg0KPiA+ID4+
Pj4gQWRkIHBvd2VyIGRvbWFpbnMgY29udHJvbGxlciBub2RlIGZvciBTb0MgbXQ4MTkyDQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVr
LmNvbT4NCj4gPiA+Pj4+IC0tLQ0KPiA+IFsuLi5dDQo+ID4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAvKiBTeXN0ZW0gUG93ZXIgTWFuYWdlciAqLw0KPiA+ID4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgc3BtOiBwb3dlci1jb250cm9sbGVyIHsNCj4gPiA+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItcG93ZXIt
Y29udHJvbGxlciI7DQo+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCj4gPiA+Pj4+ICsNCj4gPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogcG93ZXIgZG9tYWluIG9mIHRoZSBT
b0MgKi8NCj4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXVkaW9ATVQ4
MTkyX1BPV0VSX0RPTUFJTl9BVURJTyB7DQo+ID4gPj4+DQo+ID4gPj4+IElmIHlvdSBydW4gdGhl
IGR0X2JpbmRpbmdzX2NoZWNrIGl0IHNob3VsZCByZXR1cm4gc29tZSBlcnJvcnMsIGFzIGFsbA0K
PiA+ID4+PiB0aGVzZSBub2RlIG5hbWVzIHNob3VsZCBiZSAncG93ZXItZG9tYWluQCcuIFdoaWNo
IGlzIGEgYml0IGFubm95aW5nDQo+ID4gPj4+IGJlY2F1c2UgdGhlbiB5b3Ugd2lsbCBnZXQgYSBi
dW5jaCBvZiBlcnJvcnMgbGlrZSB0aGlzOg0KPiA+ID4+Pg0KPiA+ID4+PiBbICAgIDEuOTY5MTEw
XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPiA+Pj4g
J3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4gPj4+IFsgICAgMS45NzY5OTddIGRlYnVn
ZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+ID4+PiAncG1fZ2Vu
cGQnIGFscmVhZHkgcHJlc2VudCENCj4gPiA+Pj4gWyAgICAxLjk4NDgyOF0gZGVidWdmczogRGly
ZWN0b3J5ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4gPj4+ICdwbV9nZW5wZCcgYWxy
ZWFkeSBwcmVzZW50IQ0KPiA+ID4+PiBbICAgIDEuOTkyNjU3XSBkZWJ1Z2ZzOiBEaXJlY3Rvcnkg
J3Bvd2VyLWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHBy
ZXNlbnQhDQo+ID4gPj4+IFsgICAgMi4wMDA2ODVdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXIt
ZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCEN
Cj4gPiA+Pj4gWyAgICAyLjAwODU2Nl0gZGVidWdmczogRGlyZWN0b3J5ICdwb3dlci1kb21haW4n
IHdpdGggcGFyZW50DQo+ID4gPj4+ICdwbV9nZW5wZCcgYWxyZWFkeSBwcmVzZW50IQ0KPiA+ID4+
PiBbICAgIDIuMDE2Mzk1XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0aCBw
YXJlbnQNCj4gPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4gPj4+IFsgICAg
Mi4wMjQyMjFdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0K
PiA+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCENCj4gPiA+Pj4gWyAgICAyLjAzMjA0
OV0gZGVidWdmczogRGlyZWN0b3J5ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4gPj4+
ICdwbV9nZW5wZCcgYWxyZWFkeSBwcmVzZW50IQ0KPiA+ID4+PiBbICAgIDIuMDM5ODc0XSBkZWJ1
Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPiA+Pj4gJ3BtX2dl
bnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4gPj4+IFsgICAgMi4wNDc2OTldIGRlYnVnZnM6IERp
cmVjdG9yeSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+ID4+PiAncG1fZ2VucGQnIGFs
cmVhZHkgcHJlc2VudCENCj4gPiA+Pj4gWyAgICAyLjA1NTUyNF0gZGVidWdmczogRGlyZWN0b3J5
ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4gPj4+ICdwbV9nZW5wZCcgYWxyZWFkeSBw
cmVzZW50IQ0KPiA+ID4+PiBbICAgIDIuMDYzMzUyXSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2Vy
LWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQh
DQo+ID4gPj4+IFsgICAgMi4wNzExNzZdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWlu
JyB3aXRoIHBhcmVudA0KPiA+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCENCj4gPiA+
Pj4NCj4gPiA+Pj4gQnV0IHRoYXQncyBhbm90aGVyIHByb2JsZW0gdGhhdCBzaG91bGQgYmUgaGFu
ZGxlZCBpbiBkZWJ1Z2ZzIHN5c3RlbS4NCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+ID4+IEluZGVlZC4u
LnNvIEkgY2hvc2UgdG8gdXNlIGRpZmZlcmVudCBuYW1lIGluIGR0cyB0byBhdm9pZCBwcm9ibGVt
cyBpbg0KPiA+ID4+IGRlYnVnZnMuIEl0IGRvZXMgdmlvbGF0ZSB0aGUgbmFtaW5nIHJ1bGVzLg0K
PiA+ID4+DQo+ID4gPiANCj4gPiA+IEJ1dCB5b3VyIGJpbmRpbmcgd2lsbCBub3QgcGFzcyAob3Ig
dHJpZ2dlciB3YXJuaW5ncykgdGhlIGR0YiBjaGVjaw0KPiA+ID4gdGhlbi4gUm9iIHdhcyBjbGVh
ciB0aGF0IG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLiBQcm9wZXIgZml4IGlzIGZpeA0KPiA+ID4g
ZGVidWdmcyBub3QgdGhlIGJpbmRpbmcuDQo+ID4gPiANCj4gPiANCj4gPiBCeSB0aGUgd2F5LCBp
cyBhbnlib2R5IHdvcmtpbmcgb24gdGhpcyBkZWJ1Z2ZzIGlzc3VlPw0KPiA+IA0KPiANCj4gSSB0
aGluayB3ZSBjYW4gc29sdmUgdGhpcyBwcm9ibGVtIGJ5IGFkZGluZyAibmFtZSIgdG8gdGhlIHN0
cnVjdA0KPiBzY3BzeXNfZG9tYWluX2RhdGEgYW5kIHVzZSB0aGlzIGRvbWFpbl9kYXRhLT5uYW1l
IGFzIHRoZSBnZW5wZC5uYW1lLg0KPiBUaGlzIGlzIHZlcnkgc2ltcGxlLiBCdXQgSSB3YW50IHRv
IGtub3cgaWYgeW91IGJvdGggbGlrZSBpdD8NCj4gDQoNCkhpIEVucmljIGFuZCBNYXR0aGlhcywN
Cg0KTWF5IEkgaGF2ZSB5b3VyIG9waW5pb25zIG9uIGhvdyB5b3UgbWlnaHQgdG8gZml4IHRoaXMg
aXNzdWU/DQpJJ2xsIHRyeSB0byBnaXZlIGFub3RoZXIgbmFtZSB0byBlYWNoIHBvd2VyIGRvbWFp
biBpbiB0aGUNCnNjcHN5c19kb21haW5fZGF0YSBhbmQgcmVnaXN0ZXIgcG93ZXIgZG9tYWluIHdp
dGggdGhpcyBuYW1lIGxpa2UgYmVsb3cNCg0Kc3RydWN0IHNjcHN5c19kb21haW5fZGF0YSB7DQog
CS4uLg0KKwljaGFyICpuYW1lOw0KIH07DQoNCg0KLQlwZC0+Z2VucGQubmFtZSA9IG5vZGUtPm5h
bWU7DQorCXBkLT5nZW5wZC5uYW1lID0gcGQtPmRhdGEtPm5hbWUgPzogbm9kZS0+bmFtZTsNCg0K
DQpEb2VzIGl0IHZpb2xhdGUgdGhlIG5hbWluZyBydWxlcyB0byBzb21lIGV4dGVudD8gb3IgaXQn
cyBhY2NlcHRhYmxlPw0KDQo+ID4gUmVnYXJkcywNCj4gPiBNYXR0aGlhcw0KPiANCj4gDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1l
ZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVk
aWF0ZWsNCg0K

