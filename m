Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56D3120D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGCL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 21:11:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:56339 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229522AbhBGCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 21:11:25 -0500
X-UUID: ced1d66ed56b4ac091400e5512e046af-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TX4lSlAbeAqKjYx/w0Lj9bavqM0Zf4skWi3dYgpYSTE=;
        b=kpPoCgCD2C0SU3+NlzPJem6BU0fRAM8Cqm0BusfJu+z2ZLmThP8ZutrCptxfrZAuHn6/rpb83/QKqHI9z96bNcwjEslsnpVNcmB2ILyipm39W3apDYkA0WrPb8MsrjptGZVzlfdPFdA9S1DP2TBMWCmmNm7SagZpBFwBoucYyPA=;
X-UUID: ced1d66ed56b4ac091400e5512e046af-20210207
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 641904420; Sun, 07 Feb 2021 10:10:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 10:10:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 10:10:33 +0800
Message-ID: <1612663833.5147.19.camel@mhfsdcap03>
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add compatible
 for mt8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        "Nicolas Boichat" <drinkcat@chromium.org>
Date:   Sun, 7 Feb 2021 10:10:33 +0800
In-Reply-To: <YBp7hnyPJwgK598V@kroah.com>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
         <YBp7hnyPJwgK598V@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5AAE49BA3F09489F842EFD23B49F651E0B37C4C1342176E6BF5BF481ACC3F1D62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAyLTAzIGF0IDExOjMxICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgRmViIDAzLCAyMDIxIGF0IDA2OjI2OjQwUE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBUaGVyZSBhcmUgNCBVU0IgY29udHJvbGxlcnMgb24gTVQ4MTk1LCB0
aGUgY29udHJvbGxlcnMgKElQMX5JUDMsDQo+ID4gZXhjbHVkZSBJUDApIGhhdmUgYSB3cm9uZyBk
ZWZhdWx0IFNPRi9JVFAgaW50ZXJ2YWwgd2hpY2ggaXMNCj4gPiBjYWxjdWxhdGVkIGZyb20gdGhl
IGZyYW1lIGNvdW50ZXIgY2xvY2sgMjRNaHogYnkgZGVmYXVsdCwgYnV0DQo+ID4gaW4gZmFjdCwg
dGhlIGZyYW1lIGNvdW50ZXIgY2xvY2sgaXMgNDhNaHosIHNvIHdlIHNob3VsZCBzZXQNCj4gPiB0
aGUgYWNjdXJhdGUgaW50ZXJ2YWwgYWNjb3JkaW5nIHRvIDQ4TWh6LiBIZXJlIGFkZCBhIG5ldyBj
b21wYXRpYmxlDQo+ID4gZm9yIE1UODE5NSwgaXQncyBhbHNvIHN1cHBvcnRlZCBpbiBkcml2ZXIu
IEJ1dCB0aGUgZmlyc3QgY29udHJvbGxlcg0KPiA+IChJUDApIGhhcyBubyBzdWNoIGlzc3VlLCB3
ZSBwcmVmZXIgdG8gdXNlIGdlbmVyaWMgY29tcGF0aWJsZSwNCj4gPiBlLmcuIG10ODE5MidzIGNv
bXBhdGlibGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBubyBjaGFuZ2VzDQo+IA0KPiBO
b3RlLCBJIGRvIG5vdCBhcHBseSBwYXRjaGVzIHdpdGggIlJGQyIgYXMgb2J2aW91c2x5IHlvdSBk
byBub3QgdGhpbmsNCj4gdGhleSBhcmUgd29ydGh5IG9mIGJlaW5nIGFwcGxpZWQuICBJIGRvbid0
IHNlZSB3aGF0IHlvdSBhcmUgYXNraW5nIHRvIGJlDQo+IGRvbmUgd2l0aCB0aGlzIHNldCBvZiBw
YXRjaGVzLCBwbGVhc2UgZXhwbGFpbj8NClRoZSBEVFMgcGF0Y2ggWzIvM10gaW4gdGhlIHNlcmll
cyB3aWxsIGNhdXNlIG1lcmdlIGNvbmZsaWN0LCBkdWUgdG8gdGhlDQpkZXBlbmRlbnQgcGF0Y2hl
cyBhcmUgbm90IHVwc3RyZWFtZWQuDQoNCkFub3RoZXIgcHJvYmxlbSBpcyB0aGF0IEkgd2FuZGVy
IHRvIGtub3cgd2hldGhlciB0aGUgY29tcGF0aWJsZSB1c2FnZSBhcw0KZm9sbG93aW5nIGlzIGFs
bG93ZWQ6DQoNCmFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCg0KICAg
dXNiQDExMjAwMDAwIHsgIC8vIGlwMA0KICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE5Mi14aGNpIiwgIC8vIGhlcmUgdXNlIG10ODE5MidzDQpjb21wYXRpYmxlLCBhdm9pZCBjaGFu
Z2luZyBTT0YvSVRQIGludGVydmFsIGZvciBpcDAsIGJlY2F1c2UgaXQncw0KZGVmYXVsdCB2YWx1
ZSBpcyBvay4ibWVkaWF0ZWssbXQ4MTkyLXhoY2kiIGlzIG5vdCBzdXBwb3J0ZWQgaW4gZHJpdmVy
LA0Kc28gZmluYWxseSB3aWxsIHVzZSBnZW5lcmljIGNvcGF0aWJsZSAibWVkaWF0ZWssbXRrLXho
Y2kiLg0KDQogICAgICAgICAgICAgICAgICAgICAibWVkaWF0ZWssbXRrLXhoY2kiOw0KICAgICAg
ICAuLi4uDQogICAgfTsNCg0KICAgdXNiQDExMjkwMDAwIHsgIC8vIGlwMQ0KICAgICAgICBjb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS14aGNpIiwgIC8vIGhlcmUgdXNlIG10ODE5NSdzDQpj
b21wYXRpYmxlLCB1c2VkIHRvIGNoYW5nZSBTT0YvSVRQIGludGVydmFsLCBkdWUgdGhlIHRoZSB3
cm9uZyBkZWZhdWx0DQp2YWx1ZS4NCiAgICAgICAgICAgICAgICAgICAgICJtZWRpYXRlayxtdGst
eGhjaSI7DQogICB9Ow0KDQogICB1c2JAMTEyYTAwMDAgeyAgLy8gaXAyDQogICAgICAgIGNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXhoY2kiLCAgLy8gc2FtZSBhcyBpcDENCiAgICAgICAg
ICAgICAgICAgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQogICAgfTsNCg0KVGhhbmsgeW91DQoN
Cj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

