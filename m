Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66160349EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCZBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:31:35 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:9855 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230155AbhCZBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:31:11 -0400
X-UUID: e409ad9f6d904a43a0b4bf5033141303-20210326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VxpyOMauSLivU/LqjpxZ6z4fpqwX1nMTv/ksMPXytSA=;
        b=ZWdWdwsB/IhhQw3ttqF6V6eQRlOtE+hfPfb8KRes2do13CIAow7ftAZAtDaIMQo1W31mY5zH91nJGaM16Crl3OsK7uMawzYxJ2q8Vft7Houd2pkFge11WIGDD+pjeyJX+6T+XskZ29BnIhAkzzzmNjdLAWYxQkXg9jwDJ3RFSYs=;
X-UUID: e409ad9f6d904a43a0b4bf5033141303-20210326
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 702491464; Fri, 26 Mar 2021 09:31:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Mar
 2021 09:30:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 09:30:52 +0800
Message-ID: <1616722252.22957.3.camel@mhfsdcap03>
Subject: Re: [PATCH] dt-bindings: i2c: Add device clock-stretch time via dts
From:   Qii Wang <qii.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <matthias.bgg@gmail.com>, <wsa@the-dreams.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>
Date:   Fri, 26 Mar 2021 09:30:52 +0800
In-Reply-To: <20210324171217.GA3262580@robh.at.kernel.org>
References: <1615622829-15167-1-git-send-email-qii.wang@mediatek.com>
         <20210324171217.GA3262580@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A452831894ABC2ECCDFFDB024427EA9781CA86A0FDAE166AA0BE5DD9588A5432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTI0IGF0IDExOjEyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBNYXIgMTMsIDIwMjEgYXQgMDQ6MDc6MDlQTSArMDgwMCwgcWlpLndhbmdAbWVkaWF0
ZWsuY29tIHdyb3RlOg0KPiA+IEZyb206IFFpaSBXYW5nIDxxaWkud2FuZ0BtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gdFNVLFNUQS90SEQsU1RBL3RTVSxTVE9QIG1heWJlIG91dCBvZiBzcGVjIGR1
ZSB0byBkZXZpY2UNCj4gPiBjbG9jay1zdHJldGNoaW5nIG9yIGNpcmN1aXQgbG9zcywgd2UgY291
bGQgZ2V0IGRldmljZQ0KPiA+IGNsb2NrLXN0cmV0Y2ggdGltZSBmcm9tIGR0cyB0byBhZGp1c3Qg
dGhlc2UgcGFyYW1ldGVycw0KPiA+IHRvIG1lZXQgdGhlIHNwZWMgdmlhIEVYVF9DT05GIHJlZ2lz
dGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpaSBXYW5nIDxxaWkud2FuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
MmMvaTJjLW10NjV4eC50eHQgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pMmMvaTJjLW10NjV4eC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaTJjL2kyYy1tdDY1eHgudHh0DQo+ID4gaW5kZXggN2YwMTk0Zi4uOTdmNjZmMCAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1
eHgudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9p
MmMtbXQ2NXh4LnR4dA0KPiA+IEBAIC0zMiw2ICszMiw3IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6
DQo+ID4gICAgLSBtZWRpYXRlayxoYXZlLXBtaWM6IHBsYXRmb3JtIGNhbiBjb250cm9sIGkyYyBm
b3JtIHNwZWNpYWwgcG1pYyBzaWRlLg0KPiA+ICAgICAgT25seSBtdDY1ODkgYW5kIG10ODEzNSBz
dXBwb3J0IHRoaXMgZmVhdHVyZS4NCj4gPiAgICAtIG1lZGlhdGVrLHVzZS1wdXNoLXB1bGw6IElP
IGNvbmZpZyB1c2UgcHVzaC1wdWxsIG1vZGUuDQo+ID4gKyAgLSBjbG9jay1zdHJldGNoLW5zOiBT
bGF2ZSBkZXZpY2UgY2xvY2stc3RyZXRjaCB0aW1lLg0KPiANCj4gU2hvdWxkIGJlIGEgY29tbW9u
IEkyQyBwcm9wZXJ0eT8NCj4gDQoNCldvbGZyYW0gU2FuZyB3aWxsIGxvb2sgYXQgdGhpcyBuZXh0
IGFuZCB0aGluayBhYm91dCBpdC4gSSBob3BlIGl0IHdvdWxkDQpiZSBhIGNvbW1vbiBJMkMgcHJv
cGVydHkuDQoNCj4gPiAgDQo+ID4gIEV4YW1wbGU6DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDEuOS4x
DQo+ID4gDQoNCg==

