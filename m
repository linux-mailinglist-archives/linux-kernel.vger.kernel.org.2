Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477B30A02A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBACF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:05:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231136AbhBACFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:05:23 -0500
X-UUID: 711aee05963a44df9965c41cfaf1ebac-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OSHhhm/W19Y6B56K3//3peDiPN/C9u9TXy7oxQkRT3c=;
        b=Y3nSgT7MbMlfgRyVFchUbxD5T5BW8J2m1devVqk39MPyT0/YTKuSQVLZqMgN7+3MEbdLFpSo82J17QvQ7Bl5xavwIQ5MY/kc24VgAI3lOtlKfAFGcA3lwXsLMXTBRNlBz5NIVXN1g/D3rtGNIXKOD9ssFxgzE109jNUUGIB+pIM=;
X-UUID: 711aee05963a44df9965c41cfaf1ebac-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1282575189; Mon, 01 Feb 2021 10:04:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 10:04:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 10:04:34 +0800
Message-ID: <1612145075.25113.7.camel@mhfsdcap03>
Subject: Re: [PATCH v7] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Zhanyong Wang" <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Date:   Mon, 1 Feb 2021 10:04:35 +0800
In-Reply-To: <YBPjJ8CCLcBjg42S@kroah.com>
References: <1611913099-25805-1-git-send-email-chunfeng.yun@mediatek.com>
         <YBPjJ8CCLcBjg42S@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 306A99247371E3F7DA2B90EE49997CA49BA06C6C3336BD45278E03C3B49E59BC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTI5IGF0IDExOjI3ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgSmFuIDI5LCAyMDIxIGF0IDA1OjM4OjE5UE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBGcm9tOiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQo+
ID4gDQo+ID4geGhjaS1tdGsgbmVlZHMgWEhDSV9NVEtfSE9TVCBxdWlyayBmdW5jdGlvbnMgaW4g
YWRkX2VuZHBvaW50KCkgYW5kDQo+ID4gZHJvcF9lbmRwb2ludCgpIHRvIGhhbmRsZSBpdHMgb3du
IHN3IGJhbmR3aWR0aCBtYW5hZ2VtZW50Lg0KPiA+IA0KPiA+IEl0IHN0b3JlcyBiYW5kd2lkdGgg
ZGF0YSBpbnRvIGFuIGludGVybmFsIHRhYmxlIGV2ZXJ5IHRpbWUNCj4gPiBhZGRfZW5kcG9pbnQo
KSBpcyBjYWxsZWQsIGFuZCBkcm9wcyB0aG9zZSBpbiBkcm9wX2VuZHBvaW50KCkuDQo+ID4gQnV0
IHdoZW4gYmFuZHdpZHRoIGFsbG9jYXRpb24gZmFpbHMgYXQgb25lIGVuZHBvaW50LCBhbGwgZWFy
bGllcg0KPiA+IGFsbG9jYXRpb24gZnJvbSB0aGUgc2FtZSBpbnRlcmZhY2UgY291bGQgc3RpbGwg
cmVtYWluIGF0IHRoZSB0YWJsZS4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIG1vdmVzIGJhbmR3aWR0
aCBtYW5hZ2VtZW50IGNvZGVzIHRvIGNoZWNrX2JhbmR3aWR0aCgpIGFuZA0KPiA+IHJlc2V0X2Jh
bmR3aWR0aCgpIHBhdGguIFRvIGRvIHNvLCB0aGlzIHBhdGNoIGFsc28gYWRkcyB0aG9zZSBmdW5j
dGlvbnMNCj4gPiB0byB4aGNpX2RyaXZlcl9vdmVycmlkZXMgYW5kIGxldHMgbXRrLXhoY2kgdG8g
cmVsZWFzZSBhbGwgZmFpbGVkDQo+ID4gZW5kcG9pbnRzIGluIHJlc2V0X2JhbmR3aWR0aCgpIHBh
dGguDQo+ID4gDQo+ID4gRml4ZXM6IDA4ZTQ2OWRlODdhMiAoInVzYjogeGhjaS1tdGs6IHN1cHBv
cnRzIGJhbmR3aWR0aCBzY2hlZHVsaW5nIHdpdGggbXVsdGktVFQiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVtLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gQ2hh
bmdlcyBpbiB2NyBmcm9tIENodW5mZW5nOg0KPiA+IC0gcmVuYW1lIHhoY2lfbXRrX2Ryb29wX2Vw
KCkgYXMgZGVzdHJveV9zY2hfZXAoKSwgYW5kIGluY2x1ZGUgcGFyYW1ldGVycw0KPiA+IC0gYWRk
IG1lbWJlciBAYWxsb2NhdGVkIGluIG11M2hfc2NoX2VwX2luZm8gc3RydWN0DQo+ID4gICB1c2Vk
IHRvIHNraXAgZW5kcG9pbnQgbm90IGFsbG9jYXRlZCBiYW5kd2lkdGgNCj4gPiAtIHVzZSB4aGNp
X2RiZygpIGluc3RlYWQgb2YgZGV2X2RiZygpDQo+ID4gLSByZW5hbWUgYndfZXBfbGlzdF9uZXcg
YXMgYndfZXBfY2hrX2xpc3QNCj4gDQo+IEFzIGEgcHJldmlvdXMgdmVyc2lvbiBvZiB0aGlzIHBh
dGNoIGlzIGFscmVhZHkgaW4gbXkgcHVibGljIHRyZWUsIGp1c3QNCj4gc2VuZCBhIGZvbGxvdy1v
biBwYXRjaCB0aGF0IHJlc29sdmVzIHRoZSBpc3N1ZXMgaW4gdGhlIHByZXZpb3VzIG9uZSwgYXMN
Cj4gSSBjYW4gbm90IGFwcGx5IHRoaXMgb25lLiAgQm9udXMgaXMgdGhhdCB5b3UgZ2V0IHRoZSBj
cmVkaXQgZm9yIGZpeGluZw0KPiB0aGVzZSBpc3N1ZXMgOikNCk9rLCB0aGFua3MNCg0KPiANCj4g
dGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

