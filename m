Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6373910E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEZGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:53:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232336AbhEZGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:53:36 -0400
X-UUID: ee2e4de2102d492a830ffabef5d9b877-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=fOje9OZFiImcE3BGskmjJsEOQQBUQvPVEJpqIvWd+ls=;
        b=Err0wCOYmEXo4NTlhmaNQpqmjX5kJRvK7uHzR4JNI9poCGiav/KNc/aNJR6WF0VrQTvKk6Bdv7DwSZ2ECDI4dwdSnX8aS/z+hWDXUnLukWWKI1EuV77rodS4pgr023Xiu9HZWnT+2sfVmTjCy+WnO3nd4w2FjsvOCC2Irmx56Ic=;
X-UUID: ee2e4de2102d492a830ffabef5d9b877-20210526
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 81694292; Wed, 26 May 2021 14:52:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 14:51:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 14:51:56 +0800
Message-ID: <1622011916.21671.4.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] mailbox: mtk-cmdq: Add struct cmdq_pkt in struct
 cmdq_cb_data
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
Date:   Wed, 26 May 2021 14:51:56 +0800
In-Reply-To: <CAAOTY_-L1URHwkiCQv5Z0sF_caWTkU7_2+jw=9DLfCyPyhfT+Q@mail.gmail.com>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
         <20210314233323.23377-4-chunkuang.hu@kernel.org>
         <CAAOTY_-L1URHwkiCQv5Z0sF_caWTkU7_2+jw=9DLfCyPyhfT+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6ACF487A3AE7F2CF0FFA081C9DE4B9F74EFFCE96870C60AD6FC6483A49FB227C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0K
DQpPbiBXZWQsIDIwMjEtMDUtMjYgYXQgMTQ6MTggKzA4MDAsIENodW4tS3VhbmcgSHUgd3JvdGU6
DQo+ICsgWW9uZ3FpYW5nDQo+IA0KPiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVs
Lm9yZz4g5pa8IDIwMjHlubQz5pyIMTXml6Ug6YCx5LiAIOS4iuWNiDc6MzPlr6vpgZPvvJoNCj4g
Pg0KPiA+IEN1cnJlbnQgY2xpZW50IHVzZSAnc3RydWN0IGNtZHFfcGt0JyBhcyBjYWxsYmFjayBk
YXRhLCBzbw0KPiA+IGNoYW5nZSAndm9pZCAqZGF0YScgdG8gJ3N0cnVjdCBjbWRxX3BrdCAqcGt0
Jy4gS2VlcCBkYXRhDQo+ID4gdW50aWwgY2xpZW50IHVzZSBwa3QgaW5zdGVhZCBvZiBkYXRhLg0K
PiA+DQo+ID4gQ2M6IEphc3NpIEJyYXIgPGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT4NCj4gPiBD
YzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiBDYzogSG91
bG9uZyBXZWkgPGhvdWxvbmcud2VpQG1lZGlhdGVrLmNvbT4NCj4gPiBDYzogQmliYnkgSHNpZWgg
PGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBDYzogRGVubmlzIFlDIEhzaWVoIDxkZW5u
aXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
IENjOiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgfCAyICsrDQo+ID4gIGlu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAxICsNCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiA+IGluZGV4IGVmNTllMjIzNGYyMi4uOTlhOWUwNzg3NTAxIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gQEAgLTE4OCw2ICsxODgsNyBAQCBz
dGF0aWMgdm9pZCBjbWRxX3Rhc2tfZXhlY19kb25lKHN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ssIGlu
dCBzdGEpDQo+ID4gICAgICAgICBXQVJOX09OKGNiLT5jYiA9PSAoY21kcV9hc3luY19mbHVzaF9j
YilOVUxMKTsNCj4gPiAgICAgICAgIGRhdGEuc3RhID0gc3RhOw0KPiA+ICAgICAgICAgZGF0YS5k
YXRhID0gY2ItPmRhdGE7DQo+ID4gKyAgICAgICBkYXRhLnBrdCA9IHRhc2stPnBrdDsNCj4gPiAg
ICAgICAgIGlmIChjYi0+Y2IpDQo+ID4gICAgICAgICAgICAgICAgIGNiLT5jYihkYXRhKTsNCj4g
Pg0KPiA+IEBAIC00NTYsNiArNDU3LDcgQEAgc3RhdGljIGludCBjbWRxX21ib3hfZmx1c2goc3Ry
dWN0IG1ib3hfY2hhbiAqY2hhbiwgdW5zaWduZWQgbG9uZyB0aW1lb3V0KQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGxpc3RfZW50cnkpIHsNCj4gPiAgICAgICAgICAgICAg
ICAgZGF0YS5zdGEgPSAtRUNPTk5BQk9SVEVEOw0KPiA+ICAgICAgICAgICAgICAgICBkYXRhLmRh
dGEgPSBjYi0+ZGF0YTsNCj4gPiArICAgICAgICAgICAgICAgZGF0YS5wa3QgPSB0YXNrLT5wa3Q7
DQo+ID4gICAgICAgICAgICAgICAgIGNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQo+ID4gICAg
ICAgICAgICAgICAgIGlmIChjYi0+Y2IpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2It
PmNiKGRhdGEpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0K
PiA+IGluZGV4IDJmN2Q5YTM3ZDYxMS4uNDQzNjVhYWIwNDNjIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gQEAgLTY4LDYgKzY4LDcgQEAg
ZW51bSBjbWRxX2NvZGUgew0KPiA+ICBzdHJ1Y3QgY21kcV9jYl9kYXRhIHsNCj4gPiAgICAgICAg
IGludCAgICAgICAgICAgICAgICAgICAgIHN0YTsNCj4gPiAgICAgICAgIHZvaWQgICAgICAgICAg
ICAgICAgICAgICpkYXRhOw0KPiA+ICsgICAgICAgc3RydWN0IGNtZHFfcGt0ICAgICAgICAgKnBr
dDsNCj4gPiAgfTsNCj4gPg0KPiA+ICB0eXBlZGVmIHZvaWQgKCpjbWRxX2FzeW5jX2ZsdXNoX2Ni
KShzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0K

