Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29D34C223
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 05:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC2DKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 23:10:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48087 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229822AbhC2DKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 23:10:10 -0400
X-UUID: c02db032ecec40e5ad041916dcd9bd66-20210329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wSaNHIYgbtxvvyhecQJ0vc5k/eJQ8TBE/XpQJUZ1nTo=;
        b=UPxpM2GrBuDavjJiFgmzxdQRb1BK/gdTNFF5UYRWIy1UjPe9YOBtUlDGbgGkVah3Nw4CCQieF2feczW0RjICYnTTEfLKlSKMTiZHOQUThsyOE+5R6KZ8ebU+7Ijw4QbWjtdAEaj7+pVVnEWWuqNWaleXEgg+6FA/ufwobNDmj2U=;
X-UUID: c02db032ecec40e5ad041916dcd9bd66-20210329
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 397472872; Mon, 29 Mar 2021 11:10:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Mar
 2021 11:10:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Mar 2021 11:10:03 +0800
Message-ID: <1616987403.1101.0.camel@mhfsdcap03>
Subject: Re: [PATCH v2 01/13] dt-bindings: usb: mtk-xhci: support property
 usb2-lpm-disable
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 29 Mar 2021 11:10:03 +0800
In-Reply-To: <20210327172438.GA268453@robh.at.kernel.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
         <20210327172438.GA268453@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 81D83AAA84D63BFC35F7B38B8A44CC61F10435E3EBDF6E402B43BCF3EA74F96D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAzLTI3IGF0IDExOjI0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBNYXIgMjMsIDIwMjEgYXQgMDM6MDI6NDNQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IGNvbW1vbiBwcm9wZXJ0eSB1c2IyLWxwbS1kaXNhYmxlDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBubyBjaGFuZ2VzDQo+ID4gLS0tDQo+ID4gIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8
IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+IGluZGV4IDE0ZjQwZWZiM2IyMi4uMjI0NmQyOWE1
ZTRlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+IEBAIC0xMDMsNiAr
MTAzLDEwIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjogc3VwcG9ydHMgVVNC
My4wIExQTQ0KPiA+ICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICANCj4gPiArICB1c2IyLWxwbS1k
aXNhYmxlOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IGRpc2FibGUgVVNCMiBIVyBMUE0NCj4gPiAr
ICAgIHR5cGU6IGJvb2xlYW4NCj4gDQo+IEFscmVhZHkgaGFzIGEgdHlwZS4gRG9uJ3QgcmVkZWZp
bmUgaGVyZS4gSnVzdCAndXNiMi1scG0tZGlzYWJsZTogdHJ1ZScgDQo+IGFuZCBtYWtlIHN1cmUg
dXNiLXhoY2kueWFtbCBpcyByZWZlcmVuY2VkLg0KT2ssIHRoYW5rcw0KPiANCj4gPiArDQo+ID4g
ICAgaW1vZC1pbnRlcnZhbC1uczoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAgICBJ
bnRlcnJ1cHQgbW9kZXJhdGlvbiBpbnRlcnZhbCB2YWx1ZSwgaXQgaXMgOCB0aW1lcyBhcyBtdWNo
IGFzIHRoYXQNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg0K

