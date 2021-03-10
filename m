Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EC3333CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhCJDVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:21:47 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:53287 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231335AbhCJDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:21:22 -0500
X-UUID: eab3b4bbb0a846868e39fa1681109134-20210310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Qm4ADIUSz0BkSqAidhclsvS24ql8ww8Akt6F39qDx7Y=;
        b=dQNMnUK5Rgi5d0+JFSbgWfXkESLIQPVG+2CPB8ps5/Mt+5PfBP8hoYACMS0kprBTw6yk0UbhGPfd9oa20HnF5deEXi1hQws3rO53Deu8WSu0Q8ofKzsu1K4CXBZcdGagvcUynYa7LtiQUQypmNOLZghTDOx3c00cIJeN6TyqRzU=;
X-UUID: eab3b4bbb0a846868e39fa1681109134-20210310
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 711981258; Wed, 10 Mar 2021 11:21:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Mar
 2021 11:21:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 11:21:11 +0800
Message-ID: <1615346469.26498.1.camel@mhfsdcap03>
Subject: Re: [PATCH v4 01/12] dt-bindings: usb: fix yamllint check warning
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Wed, 10 Mar 2021 11:21:09 +0800
In-Reply-To: <20210310022811.GA1612587@robh.at.kernel.org>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
         <20210310022811.GA1612587@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 03113CCC20566CE8672CF41E43EC90724E1ED108A9BDF8A6453CB766C18F9BDB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDE5OjI4IC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBNYXIgMDgsIDIwMjEgYXQgMDE6Mzc6MzRQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEZpeCB3YXJuaW5nOiAibWlzc2luZyBzdGFydGluZyBzcGFjZSBpbiBjb21tZW50
Ig0KPiANCj4gV2hhdCB0cmVlIGlzIHRoaXMgaW4gYmVjYXVzZSBJIGRvbid0IHNlZSBpdC4NClRo
ZSBwYXRjaCBpcyBiYXNlZCBrZXJuZWwgNS4xMi1yYzEsIGFsc28gaGFwcGVucyBvbg0KZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC91c2IuZ2l0IHVz
Yi1uZXh0DQoNCg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjJ+djQ6IG5vIGNoYW5nZXMN
Cj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2It
ZGV2aWNlLnlhbWwgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWRldmljZS55YW1sDQo+ID4gaW5kZXggZDRjOTk4
MDllZTlhLi5iNzc5NjBhN2EzN2IgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KPiA+IEBAIC04Miw5
ICs4Miw5IEBAIHJlcXVpcmVkOg0KPiA+ICBhZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KPiA+
ICANCj4gPiAgZXhhbXBsZXM6DQo+ID4gLSAgI2h1YiBjb25uZWN0ZWQgdG8gcG9ydCAxDQo+ID4g
LSAgI2RldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAyDQo+ID4gLSAgI2RldmljZSBjb25uZWN0ZWQg
dG8gcG9ydCAzDQo+ID4gKyAgIyBodWIgY29ubmVjdGVkIHRvIHBvcnQgMQ0KPiA+ICsgICMgZGV2
aWNlIGNvbm5lY3RlZCB0byBwb3J0IDINCj4gPiArICAjIGRldmljZSBjb25uZWN0ZWQgdG8gcG9y
dCAzDQo+ID4gICAgIyAgICBpbnRlcmZhY2UgMCBvZiBjb25maWd1cmF0aW9uIDENCj4gPiAgICAj
ICAgIGludGVyZmFjZSAwIG9mIGNvbmZpZ3VyYXRpb24gMg0KPiA+ICAgIC0gfA0KPiA+IC0tIA0K
PiA+IDIuMTguMA0KDQo=

