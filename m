Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC813910E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhEZGxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:53:05 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:6958 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232403AbhEZGxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:53:03 -0400
X-UUID: 687e7a7c3b7f424ab728a4513682179f-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=VSijLJMJY/rgjRyjiGZ+4Lhjs7svu6Wpeo2O29kjuu0=;
        b=MlGwiC7E9Y1cAGW7yhiL+nYINdgJ6V+vZYjru601Wmv9aQ17kKJNPpGE8/L3FSvwtvpRTzL5SAcurOSH0qfTHXiASNLttcBT37C35DvZKfH9joEZF8joqc1gILz2eZJaN7PiI4EBJuZ98Tr9Ej0BAHip9cTSvLtUwvEArdMtUcA=;
X-UUID: 687e7a7c3b7f424ab728a4513682179f-20210526
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1909821971; Wed, 26 May 2021 14:51:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 14:51:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 14:51:27 +0800
Message-ID: <1622011887.21671.2.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 May 2021 14:51:27 +0800
In-Reply-To: <CAAOTY_-SdjB5yTxwABLdrYgr+PpbbCnKhTPskBYwcQDeCCxvhQ@mail.gmail.com>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
         <20210314233323.23377-2-chunkuang.hu@kernel.org>
         <CAAOTY_-SdjB5yTxwABLdrYgr+PpbbCnKhTPskBYwcQDeCCxvhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B54DB735DC0DF86290610CC6963C5B4F764EED6796D1CA1EDAD6909AD56B60B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpSZXZpZXdlZC1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQoNCk9uIFdlZCwgMjAyMS0wNS0yNiBhdCAxNDoxNSArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90
ZToNCj4gKyBZb25ncWlhbmcNCj4gDQo+IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJu
ZWwub3JnPiDmlrwgMjAyMeW5tDPmnIgxNeaXpSDpgLHkuIAg5LiK5Y2INzozM+Wvq+mBk++8mg0K
PiA+DQo+ID4gY21kcV9jYl9zdGF0dXMgaXMgYW4gZXJyb3Igc3RhdHVzLiBVc2UgdGhlIHN0YW5k
YXJkIGVycm9yIG51bWJlcg0KPiA+IGluc3RlYWQgb2YgY21kcV9jYl9zdGF0dXMgdG8gcHJldmVu
dCBzdGF0dXMgZHVwbGljYXRpb24uDQo+ID4NCj4gPiBDYzogSmFzc2kgQnJhciA8amFzc2lzaW5n
aGJyYXJAZ21haWwuY29tPg0KPiA+IENjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dA
Z21haWwuY29tPg0KPiA+IENjOiBIb3Vsb25nIFdlaSA8aG91bG9uZy53ZWlAbWVkaWF0ZWsuY29t
Pg0KPiA+IENjOiBCaWJieSBIc2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IENj
OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gQ2M6IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2Vy
bmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
YyAgICAgICB8IDEwICsrKysrLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaCB8ICA3ICstLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFp
bGJveC5jDQo+ID4gaW5kZXggNTY2NWI2ZWE4MTE5Li4zZDM3YzFjZDQwZjEgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBAQCAtMTgwLDcgKzE4MCw3IEBAIHN0
YXRpYyBib29sIGNtZHFfdGhyZWFkX2lzX2luX3dmZShzdHJ1Y3QgY21kcV90aHJlYWQgKnRocmVh
ZCkNCj4gPiAgICAgICAgIHJldHVybiByZWFkbCh0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9XQUlU
X1RPS0VOKSAmIENNRFFfVEhSX0lTX1dBSVRJTkc7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMg
dm9pZCBjbWRxX3Rhc2tfZXhlY19kb25lKHN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ssIGVudW0gY21k
cV9jYl9zdGF0dXMgc3RhKQ0KPiA+ICtzdGF0aWMgdm9pZCBjbWRxX3Rhc2tfZXhlY19kb25lKHN0
cnVjdCBjbWRxX3Rhc2sgKnRhc2ssIGludCBzdGEpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVj
dCBjbWRxX3Rhc2tfY2IgKmNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQo+ID4gICAgICAgICBz
dHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGE7DQo+ID4gQEAgLTI0NCwxMCArMjQ0LDEwIEBAIHN0YXRp
YyB2b2lkIGNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKHN0cnVjdCBjbWRxICpjbWRxLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGN1cnJfdGFzayA9IHRhc2s7DQo+ID4NCj4gPiAgICAgICAg
ICAgICAgICAgaWYgKCFjdXJyX3Rhc2sgfHwgY3Vycl9wYSA9PSB0YXNrX2VuZF9wYSAtIENNRFFf
SU5TVF9TSVpFKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgY21kcV90YXNrX2V4ZWNf
ZG9uZSh0YXNrLCBDTURRX0NCX05PUk1BTCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y21kcV90YXNrX2V4ZWNfZG9uZSh0YXNrLCAwKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBrZnJlZSh0YXNrKTsNCj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChlcnIpIHsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBjbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFf
Q0JfRVJST1IpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNtZHFfdGFza19leGVjX2Rv
bmUodGFzaywgLUVOT0VYRUMpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNtZHFfdGFz
a19oYW5kbGVfZXJyb3IoY3Vycl90YXNrKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBr
ZnJlZSh0YXNrKTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+IEBAIC00MTUsNyArNDE1LDcg
QEAgc3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4p
DQo+ID4NCj4gPiAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0YXNrLCB0bXAsICZ0
aHJlYWQtPnRhc2tfYnVzeV9saXN0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxpc3RfZW50cnkpIHsNCj4gPiAtICAgICAgICAgICAgICAgY21kcV90YXNrX2V4ZWNfZG9u
ZSh0YXNrLCBDTURRX0NCX0VSUk9SKTsNCj4gPiArICAgICAgICAgICAgICAgY21kcV90YXNrX2V4
ZWNfZG9uZSh0YXNrLCAtRUNPTk5BQk9SVEVEKTsNCj4gPiAgICAgICAgICAgICAgICAga2ZyZWUo
dGFzayk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiBAQCAtNDUzLDcgKzQ1Myw3IEBAIHN0YXRp
YyBpbnQgY21kcV9tYm94X2ZsdXNoKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHVuc2lnbmVkIGxv
bmcgdGltZW91dCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2Vu
dHJ5KSB7DQo+ID4gICAgICAgICAgICAgICAgIGNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQo+
ID4gICAgICAgICAgICAgICAgIGlmIChjYi0+Y2IpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBkYXRhLnN0YSA9IENNRFFfQ0JfRVJST1I7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZGF0YS5zdGEgPSAtRUNPTk5BQk9SVEVEOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGRhdGEuZGF0YSA9IGNiLT5kYXRhOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNiLT5j
YihkYXRhKTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaA0KPiA+IGluZGV4IGQ1YTk4M2Q2NWYwNS4uMmY3ZDlhMzdkNjEx
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+
ID4gQEAgLTY1LDEzICs2NSw4IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gPiAgICAgICAgIENNRFFf
Q09ERV9MT0dJQyA9IDB4YTAsDQo+ID4gIH07DQo+ID4NCj4gPiAtZW51bSBjbWRxX2NiX3N0YXR1
cyB7DQo+ID4gLSAgICAgICBDTURRX0NCX05PUk1BTCA9IDAsDQo+ID4gLSAgICAgICBDTURRX0NC
X0VSUk9SDQo+ID4gLX07DQo+ID4gLQ0KPiA+ICBzdHJ1Y3QgY21kcV9jYl9kYXRhIHsNCj4gPiAt
ICAgICAgIGVudW0gY21kcV9jYl9zdGF0dXMgICAgIHN0YTsNCj4gPiArICAgICAgIGludCAgICAg
ICAgICAgICAgICAgICAgIHN0YTsNCj4gPiAgICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAg
ICpkYXRhOw0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KDQo=

