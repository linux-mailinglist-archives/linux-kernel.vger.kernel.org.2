Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5623D5884
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhGZKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:50:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52452 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233162AbhGZKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:50:52 -0400
X-UUID: 8accbbb64a9d41b086ba4a9e510bb324-20210726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SvbcylQIDwYvhf0Wwa/jBlMORZrzYSGu9JBqThQEr2E=;
        b=rKFkTeqSNbEwCgCxyr/AB/tUYOp3cspJ++Td6m/QtSYorwPfY2/W0tnybKz+oM2ZRebOFOhIFrZ9dcpovkX1WnD2Upcgg0fuUosk6kvJKZ5wStKAt1YyJlfYeOInKw3jasX0AYe20c7DpU5+cqhnWK46oCGWC9/pBsdoBuSMSyc=;
X-UUID: 8accbbb64a9d41b086ba4a9e510bb324-20210726
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 661082176; Mon, 26 Jul 2021 19:31:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Jul 2021 19:31:17 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Jul 2021 19:31:16 +0800
Message-ID: <a8c0bd3cba8731fefac0678fe25d0482b8ed8b13.camel@mediatek.com>
Subject: Re: [v3 5/5] soc: mediatek: pm-domains: Remove unused macro
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 26 Jul 2021 19:31:16 +0800
In-Reply-To: <CAGXv+5ETE=qSPyKL6AjDtSHCDvu3Ua-rrLZWOECjZXrcNZ-9Tw@mail.gmail.com>
References: <20210705054111.4473-1-chun-jie.chen@mediatek.com>
         <20210705054111.4473-6-chun-jie.chen@mediatek.com>
         <CAGXv+5ETE=qSPyKL6AjDtSHCDvu3Ua-rrLZWOECjZXrcNZ-9Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTE1IGF0IDE0OjQwICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDUsIDIwMjEgYXQgMTo0OCBQTSBDaHVuLUppZSBDaGVuIDwNCj4gY2h1bi1q
aWUuY2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IER1ZSB0byBjbGsgcmVzb3Vy
Y2UgZGF0YSB3aWxsIGJlIGFsbG9jYXRlZCBkeW5hbWljYWxseSBieQ0KPiA+IHNlYXJjaGluZyBw
YXJlbnQgY291bnQgb2YgY2xrIGluIHBvd2VyIGRvbWFpbiBub2RlLCBzbyByZW1vdmUNCj4gPiB0
aGUgdW51c2VkIG1hcmNvIE1BWF9TVUJTWVNfQ0xLUyBmb3Igc3RhdGljIGFsbG9jYXRpb24uDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1KaWUgQ2hlbiA8Y2h1bi1qaWUuY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmlj
LmJhbGxldGJvQGNvbGxhYm9yYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1wbS1kb21haW5zLmggfCAyIC0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
cG0tZG9tYWlucy5oDQo+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5o
DQo+ID4gaW5kZXggY2FhYTM4MTAwMDkzLi4xYjg5NjdiOTgyOWUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1wbS1kb21haW5zLmgNCj4gPiBAQCAtNzIsOCArNzIsNiBAQCBzdHJ1
Y3Qgc2Nwc3lzX2J1c19wcm90X2RhdGEgew0KPiA+ICAgICAgICAgYm9vbCBpZ25vcmVfY2xyX2Fj
azsNCj4gPiAgfTsNCj4gPiANCj4gPiAtI2RlZmluZSBNQVhfU1VCU1lTX0NMS1MgMTANCj4gPiAt
DQo+IA0KPiBGdXR1cmUgYWR2aWNlOiBjbGVhbnVwcyBsaWtlIHRoaXMgYW5kIG90aGVyIGZpeGVz
IHNob3VsZCBiZSBwdXQgaW4NCj4gdGhlDQo+IGZyb250IG9mIHRoZSBzZXJpZXMsIGJlZm9yZSBh
bnkgcGF0Y2hlcyB0aGF0IGludHJvZHVjZSBzdXBwb3J0IGZvcg0KPiBuZXcNCj4gZmVhdHVyZXMg
b3IgaGFyZHdhcmUuIFRoYXQgd2F5IGlmIHRoZSBuZXcgY29kZSBzdGlsbCBuZWVkcyB3b3JrLA0K
PiBtYWludGFpbmVycyBjYW4gb3B0aW9uYWxseSBhcHBseSB0aGUgZml4ZXMgc28geW91IGRvbid0
IGhhdmUgdG8gY2FycnkNCj4gYSBsYXJnZSBwYXRjaCBzZXJpZXMgZm9yd2FyZC4NCj4gDQo+IENo
ZW5ZdQ0KPiANCk9rLCBJIHdpbGwgcmUtb3JkZXIgdGhlIHBhdGNoZXMgaW4gbmV4dCBzZXJpZXMu
DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCg0KQmVzdCBSZWdhcmRzLA0KQ2h1bi1KaWUNCg0K
PiA+ICAvKioNCj4gPiAgICogc3RydWN0IHNjcHN5c19kb21haW5fZGF0YSAtIHNjcCBkb21haW4g
ZGF0YSBmb3IgcG93ZXIgb24vb2ZmDQo+ID4gZmxvdw0KPiA+ICAgKiBAbmFtZTogVGhlIG5hbWUg
b2YgdGhlIHBvd2VyIGRvbWFpbi4NCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsg
bWFpbGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWtfXzshIUNUUk5LQTl3TWcwQVJidyEybF82
aS1NZHJmMjcwZVZLb281OWNsQ25PVlpvaTV3bEJFdUhGQWZyaVR2YVNzcnY2TG9jOEhKYnQ3SzhM
ZXhJSld1UiQNCj4gPiAgDQo=

