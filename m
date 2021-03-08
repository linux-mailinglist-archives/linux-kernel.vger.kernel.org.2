Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13793305F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhCHCnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:43:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:32969 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231807AbhCHCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:42:59 -0500
X-UUID: d0992f820a0a414cb997aaff0886e7ef-20210308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tmFMRE/P9dCZMbgSbCqxp6hLsrBfJHM8KiREHxCaGg4=;
        b=H5/CVYnW5aW3Q7sSUO/IMQu0+VXMa9N2snh83StLy4B5iF57O0oem+u61PVsV30ZpX0aiVje/VibfKQEoET9pJRMcn9qO4CmWOZfHQcriJzsfSg6PMcfBpg8IY91b3h5z7qRXLnVHZcYLZwV6HKfk12PxnAoV3L0WYqf39RdtRE=;
X-UUID: d0992f820a0a414cb997aaff0886e7ef-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1128905239; Mon, 08 Mar 2021 10:42:54 +0800
Received: from mtkmbs05n2.mediatek.inc (172.21.101.140) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:42:51 +0800
Received: from mtkmbs05n2.mediatek.inc ([fe80::bd4e:d674:5559:dd7f]) by
 mtkmbs05n2.mediatek.inc ([::1]) with mapi id 15.00.1497.012; Mon, 8 Mar 2021
 10:42:51 +0800
From:   =?big5?B?TWFyay1QSyBUc2FpICi9sqhLregp?= <Mark-PK.Tsai@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>, Daniel Palmer <daniel@0x0f.com>
CC:     Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?big5?B?WUogQ2hpYW5nICimv61eqk4p?= <yj.chiang@mediatek.com>
Subject: RE: [PATCH] irqchip/irq-mst: Support polarity configuration
Thread-Topic: [PATCH] irqchip/irq-mst: Support polarity configuration
Thread-Index: AQHXEbhnucN+qo9yHkCC3o1uWx58eKp2rKaAgAAWxACAAp0dwA==
Date:   Mon, 8 Mar 2021 02:42:51 +0000
Message-ID: <30c45ccea273461ca9552cef01b75de2@mtkmbs05n2.mediatek.inc>
References: <20210305120930.14297-1-mark-pk.tsai@mediatek.com>
        <CAFr9PXmDp7UwWnT+49Yciy-gvYiQOd3cus0W_QnGKm-LqziHCg@mail.gmail.com>
 <875z24rvaz.wl-maz@kernel.org>
In-Reply-To: <875z24rvaz.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTg1MjVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mOGVkYjA3Mi03ZmI3LTExZWItYjYzMi0xMDYyZTVlZDk5MjFcYW1lLXRlc3RcZjhlZGIwNzQtN2ZiNy0xMWViLWI2MzItMTA2MmU1ZWQ5OTIxYm9keS50eHQiIHN6PSIyNjYwIiB0PSIxMzI1OTY0NDk3MDczODI2MTEiIGg9IjdvbWRRZFRrWXo5djhSaCtDNjFsbkdsU3hwcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: =?big5?B?P+ZJ4fQ/qkjVp+1j5ls/NA==?=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
x-tm-snts-smtp: B2C905EECFAA1922DCBC033F491139A06C0170E2A6E822BCE7F0E2317EBF51CF2000:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gSGkgTWFyay1QSywNCj4NCj4gSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIHRoZSBsb2dp
YyBiZWhpbmQgdGhlIGNoYW5nZXMuDQo+IEl0IHNlZW1zIGxpa2UgdGhlIHBvbGFyaXR5IG9mIGlu
dGVycnVwdHMgaXMgYWx3YXlzIHRoZSBzYW1lIGJldHdlZW4gdGhlIE1TdGFyIGludGMgYW5kIHRo
ZSBHSUM/IExvdyBsZXZlbCBpbnRlcnJ1cHRzIGFyZSBoYW5kbGVkIGluIHRoZSBtc3RhciBpbnRj
IGFuZCBiZWNvbWUgaGlnaCBsZXZlbCBpbnRlcnJ1cHRzIHRvIHRoZSBHSUM/DQo+IEkgdGhpbmsg
Zm9yIHRoZSBNc3RhciBNU0MzMTMoZSkgYW5kIFNpZ21hU3RhciBjaGlwcyBhbGwgb2YgdGhlIGlu
dGVybmFsIGludGVycnVwdHMgYXJlIGhpZ2ggbGV2ZWwgc28gSSBuZXZlciBub3RpY2VkIHRoaXMg
YmVoYXZpb3VyLg0KPiBJIGNhbid0IHJlbWVtYmVyIHNlZWluZyBhbnl0aGluZyB0aGF0IGhhbmRs
ZWQgdGhpcyBpbiB0aGUgTVN0YXIga2VybmVsIGNvZGUgSSBsb29rZWQgYXQuDQo+IElzIHRoaXMg
c3BlY2lmaWMgdG8gYSBjZXJ0YWluIGNoaXAgb3IgZG9lcyBpdCBhcHBseSBmb3IgZXZlcnl0aGlu
ZyB3aXRoIHRoaXMgaW50Yz8NCg0KSSBzdXBwb3NlIE1zdGFyIFNvQ3MgYWxzbyBuZWVkIHRoaXMg
cGF0Y2ggd2hpY2ggZGVwZW5kcyBvbiB3aGF0IGtpbmQgb2YgaW50ZXJydXB0IHNvdXJjZSB0aGUg
SFcgZGVzaWduZXIgd2lyZSB0byB0aGlzIGludGMuDQpJZiBhbiBpbnRlcnJ1cHQgc291cmNlIGlz
IGFjdGl2ZSBsb3csIHdlIG5lZWQgdG8gc2V0IHRoZSBjb3JyZXNwb25kaW5nIGJpdCB0byByZXZl
cnNlIHRoZSBwb2xhcml0eSB0byBtZWV0IEdJQyBTUEkgcmVxdWlyZW1lbnQgYXMgTWFyYyBtZW50
aW9uZWQuDQoNCj4gVGhlIHJlZ2lzdGVyIHZhbHVlcyBiZWluZyBsb3N0IGlmIHRoZSBjaGlwIGdv
ZXMgaW50byBzdXNwZW5kIHRvIG1lbW9yeSBtYWtlcyBzZW5zZSBmb3IgdGhlIE1TdGFyIGNoaXBz
IHRvbyBJIHRoaW5rIGFzIGV2ZXJ5dGhpbmcgdGhhdCBpcyBub3QgaW4gdGhlICJwbXNsZWVwIiBy
ZWdpc3RlciBncm91cCBzZWVtcyB0byBiZSBsb3N0Lg0KDQpUaGVyZSBhcmUgbWFzayBhbmQgZW9p
IGJpdHMgSSBkaWQgbm90IGhhbmRsZSBoZXJlLg0KVGhhdCdzIGJlY2F1c2Uga2VybmVsIHdpbGwg
aGFuZGxlIHRoZSBtYXNrIGFuZCBlb2kgc3RhdHVzIHdoZW4gc3lzdGVtIGdvaW5nIHRvIHN1c3Bl
bmQvcmVzdW1lIGluIHN1c3BlbmRfZGV2aWNlX2lycXMvIHJlc3VtZV9kZXZpY2VfaXJxcy4NCkFu
ZCBhbGwgdGhlIGlycXMgb2YgTXN0YXIgaW50YyBhcmUgbWFza2VkIGJ5IGRlZmF1bHQgd2hlbiB0
aGUgSVAgcG93ZXJlZCBvbi4NCg0KDQpCZXN0IHJlZ2FyZHMsDQpNYXJrLVBLIFRzYWkNCg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFyYyBaeW5naWVyIFttYWlsdG86bWF6
QGtlcm5lbC5vcmddIA0KU2VudDogU3VuZGF5LCBNYXJjaCA3LCAyMDIxIDI6MjggQU0NClRvOiBE
YW5pZWwgUGFsbWVyIDxkYW5pZWxAMHgwZi5jb20+DQpDYzogTWFyay1QSyBUc2FpICi9sqhLregp
IDxNYXJrLVBLLlRzYWlAbWVkaWF0ZWsuY29tPjsgRGFuaWVsIFBhbG1lciA8ZGFuaWVsQHRoaW5n
eS5qcD47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSmFzb24gQ29vcGVy
IDxqYXNvbkBsYWtlZGFlbW9uLm5ldD47IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0Bn
bWFpbC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnPjsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgWUogQ2hpYW5n
ICimv61eqk4pIDx5ai5jaGlhbmdAbWVkaWF0ZWsuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
aXJxY2hpcC9pcnEtbXN0OiBTdXBwb3J0IHBvbGFyaXR5IGNvbmZpZ3VyYXRpb24NCg0KT24gU2F0
LCAwNiBNYXIgMjAyMSAxNzowNjo1MSArMDAwMCwNCkRhbmllbCBQYWxtZXIgPGRhbmllbEAweDBm
LmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBNYXJrLVBLLA0KPiANCj4gSSdtIHRyeWluZyB0byB1bmRl
cnN0YW5kIHRoZSBsb2dpYyBiZWhpbmQgdGhlIGNoYW5nZXMuDQo+IEl0IHNlZW1zIGxpa2UgdGhl
IHBvbGFyaXR5IG9mIGludGVycnVwdHMgaXMgYWx3YXlzIHRoZSBzYW1lIGJldHdlZW4gDQo+IHRo
ZSBNU3RhciBpbnRjIGFuZCB0aGUgR0lDPyBMb3cgbGV2ZWwgaW50ZXJydXB0cyBhcmUgaGFuZGxl
ZCBpbiB0aGUgDQo+IG1zdGFyIGludGMgYW5kIGJlY29tZSBoaWdoIGxldmVsIGludGVycnVwdHMg
dG8gdGhlIEdJQz8NCg0KVGhhdCdzIGJlY2F1c2UgdGhlIEdJQyBvbmx5IHN1cHBvcnRzIGxldmVs
LWhpZ2ggaW5wdXQgaW50ZXJydXB0cyB3aGVuIHRoZXkgYXJlIGxldmVsIHRyaWdnZXJlZCAoYW5k
IHJpc2luZyBlZGdlIHdoZW4gZWRnZSB0cmlnZ2VyZWQpLg0KDQpUaGFua3MsDQoNCglNLg0KDQot
LQ0KV2l0aG91dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3Np
YmxlLg0K
