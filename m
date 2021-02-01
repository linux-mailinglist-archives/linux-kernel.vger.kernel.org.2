Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9330A016
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhBABsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:48:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:11920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229765AbhBABsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:48:36 -0500
X-UUID: 50cf61722eab4a759cbcf77009172996-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cqrms7Ue1/V7oS95GhlRfd1HqRHxwPoPO4V21qXshyk=;
        b=nAi6dqLoS9jhSl9/cDrzkyXEQmXCt+gNIiBJlXIc180X9tRSSeWnrCnj++Hy/ZnJqlu8cHeErBEbwxg89T8Ir4KvDR3wOqw+TmvIozxiCj72ofmB665V2hyYRWfoC89Vs2aDovBO17hSEpxbkrYkatkxJjNo4YA/jNr6VWjhx3E=;
X-UUID: 50cf61722eab4a759cbcf77009172996-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1586998223; Mon, 01 Feb 2021 09:47:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 09:47:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 09:47:42 +0800
Message-ID: <1612144062.25113.6.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rosen Penev <rosenp@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 1 Feb 2021 09:47:42 +0800
In-Reply-To: <7ad022d3-ff83-9126-ee74-6d1e4d381366@gmail.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
         <20201216115125.5886-2-chunfeng.yun@mediatek.com>
         <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
         <1608171557.23328.53.camel@mhfsdcap03>
         <CAKxU2N8q1XjDbWbv5ksqYr7RMEedV7fng7OUccVggsT89Oyf5w@mail.gmail.com>
         <1608794285.23328.79.camel@mhfsdcap03>
         <7ad022d3-ff83-9126-ee74-6d1e4d381366@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A5024271AC4526812F95AD3BC549251504E6929E05351F62AF340B5A5392FFC52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTMxIGF0IDE1OjEzICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjQvMTIvMjAyMCAwODoxOCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyMC0xMi0xNiBhdCAxOTo0MyAtMDgwMCwgUm9zZW4gUGVuZXYgd3JvdGU6DQo+ID4+
IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDY6MjkgUE0gQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55
dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+PiBPbiBXZWQsIDIwMjAtMTItMTYg
YXQgMjA6MjggKzA4MDAsIE5pY29sYXMgQm9pY2hhdCB3cm90ZToNCj4gPj4+PiBPbiBXZWQsIERl
YyAxNiwgMjAyMCBhdCA3OjUzIFBNIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4gd3JvdGU6DQo+IFsuLi5dDQo+ID4+Pj4+ICAgICAgICAgbXRrLT5scG1fc3VwcG9ydCA9
IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAidXNiMy1scG0tY2FwYWJsZSIpOw0KPiA+Pj4+
PiArICAgICAgIG10ay0+YnJva2VuX3N0cmVhbXMgPQ0KPiA+Pj4+PiArICAgICAgICAgICAgICAg
b2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJtZWRpYXRlayxicm9rZW5fc3RyZWFtc19xdWly
ayIpOw0KPiA+Pj4+DQo+ID4+Pj4gV291bGQgaXQgYmUgYmV0dGVyIHRvIGFkZCBhIGRhdGEgZmll
bGQgdG8gc3RydWN0IG9mX2RldmljZV9pZA0KPiA+Pj4+IG10a194aGNpX29mX21hdGNoLCBhbmQg
ZW5hYmxlIHRoaXMgcXVpcmsgb24gbWVkaWF0ZWssbXQ4MTczLXhoY2kgb25seT8NCj4gPj4+IFRo
aXMgaXMgdGhlIGNvbW1vbiBpc3N1ZSBmb3IgYWxsIFNvQ3MgKGJlZm9yZSAyMDE2LjA2KSB3aXRo
IDAuOTYgeEhDSQ0KPiA+Pj4gd2hlbiB0aGUgY29udHJvbGxlciBkb24ndCBzdXBwb3J0IGJ1bGsg
c3RyZWFtLiBJZiBlbmFibGUgdGhpcyBxdWlyayBvbmx5DQo+ID4+PiBmb3IgbXQ4MTczLCB0aGVu
IGZvciBvdGhlciBTb0NzLCB0aGUgY29tcGF0aWJsZSBuZWVkIGluY2x1ZGUNCj4gPj4+ICJtZWRp
YXRlayxtdDgxNzMteGhjaSIgaW4gZHRzLCB0aGlzIG1heSBiZSBub3QgZmxleGlibGUgZm9yIHNv
bWUgY2FzZXMsDQo+ID4+PiBlLmcuIGEgbmV3IFNvQyBoYXMgdGhlIGJyb2tlbiBzdHJlYW0gYXMg
bXQ4MTczLCBidXQgYWxzbyBoYXMgYW5vdGhlcg0KPiA+Pj4gZGlmZmVyZW50IHF1aXJrLCB0aGUg
d2F5IHlvdSBzdWdnZXN0ZWQgd2lsbCBub3QgaGFuZGxlIGl0Lg0KPiA+Pj4gQW5kIEkgcGxhbiB0
byByZW1vdmUgIm1lZGlhdGVrLG10ODE3My14aGNpIiBpbiBtdGtfeGhjaV9vZl9tYXRjaCBhZnRl
cg0KPiA+Pj4gY29udmVydGluZyB0aGUgYmluZGluZyB0byBZTUFMLg0KPiA+PiBJJ20gZ3Vlc3Np
bmcgdGhpcyBhbHNvIGFwcGxpZXMgdG8gbXQ3NjIxPw0KPiA+IFllcywgbXQ3NjIxIGRvZXNuJ3Qg
c3VwcG9ydCBidWxrIHN0cmVhbQ0KPiA+IA0KPiANCj4gVGhlbiBwbGVhc2UgcHJvdmlkZSBwYXRj
aGVzIHRvIHRoZSBEVFNJIGZvciBhbGwgU29DcyB0aGF0IGhhdmUgdGhpcyBwcm9ibGVtLg0KPiBF
aXRoZXIgYXMgYSBmb2xsb3ctdXAgb3IgYXMgcGFydCBvZiB0aGlzIHNlcmllcywgaWYgeW91IG5l
ZWQgdG8gcmVzdWJtaXQuDQpPaywgSSdsbCBzZW5kIG5ldyB2ZXJzaW9uLCBhbmQgYWxzbyB0cnkg
b3RoZXIgd2F5IHRvIGZpeCBpdCB3aXRob3V0IGFkZA0KcHJvcGVydHkgaW4gRFRTLCB0aGFua3MN
Cg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCg0K

