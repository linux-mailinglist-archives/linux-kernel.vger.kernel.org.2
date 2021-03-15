Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42333C431
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhCORan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:30:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44828 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232341AbhCORab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:30:31 -0400
X-UUID: a0fdd4afc34a41ba9d67db60143e695c-20210316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=r9FRBMB1nJgQB9Ktvs2Hm5ModFYF6hmKvuOFmqaVDZY=;
        b=qRIIXsyi78HDLRPozDRbPgfNSeUL3FO10caPN1G3q7ZRRSdBrmajXULm+zMLDOge2CmtFyZhOzLyRK/rTCX9h4kkjOGhhI1ZWQmaxlmviyplZk+MNr8dvHWupuYKVUe6x6d/42JOUiXuCfEHQwUBgiK6SHXH57xtZCW2ejhQtWA=;
X-UUID: a0fdd4afc34a41ba9d67db60143e695c-20210316
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1224446361; Tue, 16 Mar 2021 01:30:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 01:30:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 01:30:25 +0800
Message-ID: <1615829425.2591.1.camel@mtksdaap41>
Subject: Re: [PATCH v7 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, "Rob Herring" <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Stephen Boyd" <sboyd@kernel.org>
Date:   Tue, 16 Mar 2021 01:30:25 +0800
In-Reply-To: <1615818177.192018.876373.nullmailer@robh.at.kernel.org>
References: <1615658453-3989-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1615658453-3989-3-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1615818177.192018.876373.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNpcg0KDQpPbiBNb24sIDIwMjEtMDMtMTUgYXQgMDg6MjIgLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBTdW4sIDE0IE1hciAyMDIxIDAyOjAwOjUxICswODAwLCBIc2luLUhzaXVu
ZyBXYW5nIHdyb3RlOg0KPiA+IFRoaXMgYWRkcyBkb2N1bWVudGF0aW9uIGZvciB0aGUgU1BNSSBj
b250cm9sbGVyIGZvdW5kIG9uIE1lZGlhdGVrIFNvQ3MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4g
Y2hhbmdlcyBzaW5jZSB2NjoNCj4gPiAtIG5vIGNoYW5nZXMuDQo+ID4gLS0tDQo+ID4gIC4uLi9i
aW5kaW5ncy9zcG1pL210ayxzcG1pLW10ay1wbWlmLnlhbWwgICAgICB8IDc0ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcG1pL210
ayxzcG1pLW10ay1wbWlmLnlhbWwNCj4gPiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVu
bmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4geWFtbGxp
bnQgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoN
Cj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwbWkvbXRrLHNwbWktbXRrLXBt
aWYuZXhhbXBsZS5kdHM6MTk6MTg6IGZhdGFsIGVycm9yOiBkdC1iaW5kaW5ncy9jbG9jay9tdDgx
OTItY2xrLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gICAgMTkgfCAgICAgICAgICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQo+ICAgICAgIHwgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBjb21waWxhdGlv
biB0ZXJtaW5hdGVkLg0KPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUubGliOjM0OTog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwbWkvbXRrLHNwbWktbXRrLXBtaWYu
ZXhhbXBsZS5kdC55YW1sXSBFcnJvciAxDQo+IG1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTM4MDogZHRfYmluZGluZ19j
aGVja10gRXJyb3IgMg0KPiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0
Y2gvMTQ1MjUyOQ0KPiANCj4gVGhpcyBjaGVjayBjYW4gZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRl
cGVuZGVuY2llcy4gVGhlIGJhc2UgZm9yIGEgcGF0Y2gNCj4gc2VyaWVzIGlzIGdlbmVyYWxseSB0
aGUgbW9zdCByZWNlbnQgcmMxLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2Jp
bmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBt
YWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0K
PiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxl
YXNlIGNoZWNrIGFuZCByZS1zdWJtaXQuDQo+IA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpU
aGlzIHNlcmllcyBpcyBiYXNlZCBvbiBXZWl5aSdzIHBhdGNoZXMuDQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMTYwODY0MjU4Ny0xNTYz
NC03LWdpdC1zZW5kLWVtYWlsLXdlaXlpLmx1QG1lZGlhdGVrLmNvbS8NCg0KDQo=

