Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF43910C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhEZGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:36:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21462 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231157AbhEZGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:36:07 -0400
X-UUID: a88f5658f0c543ff85260cac86ae6303-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=A2lWbDjEYuO5XXptG2fKQLFE2+iVC6CpUYAnqdCBNzo=;
        b=MpHZDsufl7B60oxFpH2TLD+YC2K87ARNvJt2Y1BkrLUQv/macjubSempAcFfVirrLv2Spido7lAUyQLeNo1/nX9WoS9OD9r6leiHhjOOimWrEeo6kKSiHqglvjNVbotJsoy3w098Y3LcpnVZ7v/qcHguK43cgUHmkD6UPbIFeAY=;
X-UUID: a88f5658f0c543ff85260cac86ae6303-20210526
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 901601122; Wed, 26 May 2021 14:34:32 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 14:34:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 14:34:22 +0800
Message-ID: <1622010863.21671.1.camel@mhfsdcap03>
Subject: Re: [PATCH 0/3] Refine mtk-cmdq-mailbox callback mechanism
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 26 May 2021 14:34:23 +0800
In-Reply-To: <CAAOTY_9fksAnZc2pqmbHtBiPQgQhX9iX0349K8T9zCG8mH3ZSQ@mail.gmail.com>
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
         <CAAOTY_9fksAnZc2pqmbHtBiPQgQhX9iX0349K8T9zCG8mH3ZSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 98A81E8371B96EDF55C74FFB14F7F97F2789D73EBB01CE7FB6C19F490DD91A0D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpSZXZpZXdlZC1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQoNCk9uIFdlZCwgMjAyMS0wNS0yNiBhdCAxNDoxMyArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90
ZToNCj4gKyBZb25ncWlhbmcuDQo+IA0KPiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2Vy
bmVsLm9yZz4g5pa8IDIwMjHlubQz5pyIMTXml6Ug6YCx5LiAIOS4iuWNiDc6MzPlr6vpgZPvvJoN
Cj4gPg0KPiA+IG10ay1jbWRxLW1haWxib3ggdXNlIHByb3ByaWV0YXJ5IGNhbGxiYWNrIG1lY2hh
bmlzbSBhbmQgcHJvcHJpZXRhcnkNCj4gPiBlcnJvciBudW1iZXIsIGJ1dCB0aGVzZSBjb3VsZCBi
ZSByZXBsYWNlZCBieSBzdGFuZGFyZCBjYWxsYmFjaw0KPiA+IG1lY2hhbmlzbSBhbmQgc3RhbmRh
cmQgZXJyb3IgbnVtYmVyLiBJbiBhZGRpdGlvbiwgdXNlIGNtZHFfcGt0IGFzDQo+ID4gY2FsbGJh
Y2sgZGF0YSB0byBwcmV2ZW50IHJlZHVuZG5hdCBhc3NpZ25tZW50Lg0KPiA+DQo+ID4gQmVjYXVz
ZSBjbGllbnQgZHJpdmVyIHN0aWxsIHVzZSBwcm9wcmlldGFyeSBtZWNoYW5pc20sIHNvIGtlZXAN
Cj4gPiBwcm9wcmlldGFyeSBtZWNoYW5pc20gdW50aWwgY2xpZW50IGRyaXZlciB1c2UgdGhlIHN0
YW5kYXJkIG9uZS4NCj4gPg0KPiA+IENodW4tS3VhbmcgSHUgKDMpOg0KPiA+ICAgbWFpbGJveDog
bXRrLWNtZHE6IFJlbW92ZSBjbWRxX2NiX3N0YXR1cw0KPiA+ICAgbWFpbGJveDogbXRrLWNtZHE6
IFVzZSBtYWlsYm94IHJ4X2NhbGxiYWNrDQo+ID4gICBtYWlsYm94OiBtdGstY21kcTogQWRkIHN0
cnVjdCBjbWRxX3BrdCBpbiBzdHJ1Y3QgY21kcV9jYl9kYXRhDQo+ID4NCj4gPiAgZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICB8IDI0ICsrKysrKysrKysrKysrKy0tLS0t
LS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDgg
KystLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0K

