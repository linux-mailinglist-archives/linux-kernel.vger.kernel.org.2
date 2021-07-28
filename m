Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA83D8BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhG1KVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:21:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229574AbhG1KVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:21:11 -0400
X-UUID: a6123fab58ef4b71af91edc86908cd1a-20210728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pOtzGqpNSphuXXqUkv0xXxPPYQqKavCRJjR/ns5nsaE=;
        b=Tk67lpeXIABoys/9Twvsix2+Lwo8zk+DjnM/l9dkiKzn2GuVvg+PCvD0fUfprX9MtTgXBrY2FFTB7U8E/ud0vAkzBL/K03r4+meFtJiYyMpCXUJi3cYC20NOeKfKpbnB+6tma5f6fnJ/4NYiNLvL+ufbbgXZ0lHYQYP2aoF8e+w=;
X-UUID: a6123fab58ef4b71af91edc86908cd1a-20210728
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 202140126; Wed, 28 Jul 2021 18:21:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 18:21:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 18:21:04 +0800
Message-ID: <fd1a7b95ea63296e350aa04dce1dbb4f8c84092c.camel@mediatek.com>
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 28 Jul 2021 18:21:04 +0800
In-Reply-To: <CAFqH_51D0A_Oht785cxvWjuNFYgLL25-qX1QEpLhWBARtTgVMA@mail.gmail.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
         <20210726105719.15793-3-chun-jie.chen@mediatek.com>
         <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
         <CAFqH_51D0A_Oht785cxvWjuNFYgLL25-qX1QEpLhWBARtTgVMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTI4IGF0IDEwOjQ3ICswMjAwLCBFbnJpYyBCYWxsZXRibyBTZXJyYSB3
cm90ZToNCj4gSGkgQ2h1bi1KaWUgYW5kIFN0ZXBoZW4sDQo+IA0KPiBNaXNzYXRnZSBkZSBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IGRlbCBkaWEgZHQuLCAyNyBkZSBqdWwuDQo+IDIw
MjEgYSBsZXMgMTk6NTQ6DQo+ID4gDQo+ID4gUXVvdGluZyBDaHVuLUppZSBDaGVuICgyMDIxLTA3
LTI2IDAzOjU3OjAwKQ0KPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBtbXN5cyBkb2N1bWVudCBi
aW5kaW5nIGZvciBNVDgxOTIgU29DLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
LUppZSBDaGVuIDxjaHVuLWppZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5
OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCj4gPiA+IFJldmlld2Vk
LWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+ID4gQWNr
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiANCj4g
PiBBcHBsaWVkIHRvIGNsay1uZXh0DQo+ID4gDQo+IA0KPiBUaGlzIHdpbGwgY29uZmxpY3QgaW4g
bGludXgtbmV4dCBhcyB0aGUgYmluZGluZyB3YXMgYWxyZWFkeSBjb252ZXJ0ZWQNCj4gdG8geWFt
bC4gU2VlDQo+IA0KPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2Nv
bW1pdC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLG1tc3lzLnlhbWw/aWQ9NjNlMTEyNWU2YmI4ZWFlM2NkMjAyOTJmNmExMGVlNDIxZGQ1NzRh
ZV9fOyEhQ1RSTktBOXdNZzBBUmJ3ITFsOUl5dXp6eWRVSm1HYUVSUExjYUwycFNkemJ1QlN0TVI0
X2pxVzFhVnlWd0JHZFVVX2cyMmp5RGhxYkNseDREYU5UJA0KPiAgDQo+IA0KPiBUaGFua3MsDQo+
ICAgRW5yaWMNCj4gDQoNCkkgd2lsbCByZXNlbmQgbW1zeXMgYmluZGluZyBkb2N1bWVudCBzaW5n
bHkgYmFzZWQgb24gWzFdLg0KDQpbMV0gDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTQ4NTE2NQ0KDQoNCkJlc3QgUmVnYXJk
cywNCkNodW4tSmllDQoNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiA+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiA+IExpbnV4LW1l
ZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1l
ZGlhdGVrX187ISFDVFJOS0E5d01nMEFSYnchMWw5SXl1enp5ZFVKbUdhRVJQTGNhTDJwU2R6YnVC
U3RNUjRfanFXMWFWeVZ3QkdkVVVfZzIyanlEaHFiQ3BLWWxxNkkkDQo+ID4gIA0K

