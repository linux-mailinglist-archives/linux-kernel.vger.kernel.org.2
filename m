Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694C63B1319
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:05:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43742 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229665AbhFWFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:05:08 -0400
X-UUID: beb468f6d08b4aeab283cd1a3e7f4fcd-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Tb0D+IuavYVr+gsGbryHcedknd8az3dO6DMKG1z8G4Y=;
        b=Q9GZe7IeUtuzYkIkc5o8yb+kWqRAGrxRb7akCrnSZ4A49cyWr6zKAQhYvg3lSzFRIPwdcxQHd3xrb/t37C0bhMcdJQJVQgRkVc+ZVC+uyjFN9SpFxNp+JrRULbci6/Shmi1kUMK1czuoTJv11CIG2OqO/x5Gy4f5uvhNPqbkmc8=;
X-UUID: beb468f6d08b4aeab283cd1a3e7f4fcd-20210623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1392690866; Wed, 23 Jun 2021 13:02:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 13:02:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 13:02:47 +0800
Message-ID: <1624424567.1145.0.camel@mtksdaap41>
Subject: Re: regulator: mt6358 vdram2_idx/vsel_mask/ vsel_shift setting
 seems wrong
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Axel Lin <axel.lin@ingics.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>
Date:   Wed, 23 Jun 2021 13:02:47 +0800
In-Reply-To: <CAFRkauDjKaEmtEoUH94wkT0Xd9-XL3NOYyvB3haYVT+BrAK-Dw@mail.gmail.com>
References: <CAFRkauDjKaEmtEoUH94wkT0Xd9-XL3NOYyvB3haYVT+BrAK-Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEF4ZWwgc2lyDQpBZnRlciBjaGVja2luZyB0aGUgc3BlYywgdGhlIHZzZWxfbWFzayBpcyB3
cm9uZy4NCkkgc3VibWl0IGEgcGF0Y2ggdG8gZml4IGl0Lg0KTWFueSB0aGFua3MgZm9yIHRoZSBj
b3JyZWN0aW5nLiA6KQ0KDQpPbiBUdWUsIDIwMjEtMDYtMjIgYXQgMTE6MjAgKzA4MDAsIEF4ZWwg
TGluIHdyb3RlOg0KPiBIaSBIc2luLUhzaXVuZywNCj4gDQo+IEluIGRyaXZlcnMvcmVndWxhdG9y
L210NjM1OC1yZWd1bGF0b3IuYzoNCj4gDQo+IHN0YXRpYyBjb25zdCB1MzIgdmRyYW0yX2lkeFtd
ID0gew0KPiAgICAgICAgIDAsIDEyLA0KPiB9Ow0KPiANCj4gTVQ2MzU4X0xETygibGRvX3ZkcmFt
MiIsIFZEUkFNMiwgdmRyYW0yX3ZvbHRhZ2VzLCB2ZHJhbTJfaWR4LA0KPiAgICAgICAgICAgIE1U
NjM1OF9MRE9fVkRSQU0yX0NPTjAsIDAsIE1UNjM1OF9MRE9fVkRSQU0yX0VMUjAsIDB4MTAsIDAp
LA0KPiANCj4gV2l0aCBjdXJyZW50IHNldHRpbmcgdGhlIHZzZWxfbWFzayBkb2VzIG5vdCBtYXRj
aCB0aGUgdnNlbF9zaGlmdCBzZXR0aW5nDQo+ICAgIFNvIGluIHNldF92b2x0YWdlX3NlbCwgaXQg
d2lsbCBjYWxsIHJlZ21hcF91cGRhdGVfYml0cyB3aXRoDQo+ICAgIG1hc2sgPSAweDEwDQo+ICAg
IHZhbCA9IGlkeCA8PCAwDQo+ICAgIE5vIG1hdHRlciBpZHggaXMgMCAocHZvbFswXSkgb3IgMTIg
KHB2b2xbMV0pLCBpdCB3aWxsIGNsZWFyIHZzZWxfbWFzayBiaXRzDQo+IA0KPiBJIGRvbid0IGhh
dmUgdGhlIGRhdGFzaGVldCB0byBjaGVjaywgc28gcGxlYXNlIGhlbHAgdG8gZG91YmxlIGNoZWNr
IHRoZQ0KPiB2ZHJhbTJfaWR4LCB2c2VsX21hc2sgYW5kIHZzZWxfc2hpZnQgc2V0dGluZ3MgZm9y
IGxkb192ZHJhbTIuDQo+IEkgdGhpbmsgYXQgbGVhc3Qgb25lIG9mIHRoZSBzZXR0aW5ncyBpcyB3
cm9uZy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEF4ZWwNCg0K

