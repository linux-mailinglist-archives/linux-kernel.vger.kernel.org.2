Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2563A3369E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCKBv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:51:26 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59766 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229599AbhCKBvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:51:13 -0500
X-UUID: 9403a0f406ca4eadbf09e32e5f0979e8-20210311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MyXaycwMY+zGNWOh2kpZh2m5IO5LDfniUPRstEyFC2o=;
        b=nxQwklIMmZ14ITRW+pt5xNSsAI9r1soTlXxLzsJM6J+UdqatiBUVGzdz9M9vUhTy4DQ/thad6tuzVj1PxQrOYMDDvG7Ov70sJxbd7JvMM5MsUTk8UL6dDDLYjSeB0DsWLUDH2kL2/ZUn5NSbFmi6EAoF/2IfJ3z/4rTWfl2aJZc=;
X-UUID: 9403a0f406ca4eadbf09e32e5f0979e8-20210311
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1116286509; Thu, 11 Mar 2021 09:51:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Mar
 2021 09:51:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Mar 2021 09:51:08 +0800
Message-ID: <1615427467.26498.6.camel@mhfsdcap03>
Subject: Re: [PATCH v4 01/12] dt-bindings: usb: fix yamllint check warning
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Thu, 11 Mar 2021 09:51:07 +0800
In-Reply-To: <YEiJS0fPCOPOdlIq@kroah.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
         <20210310022811.GA1612587@robh.at.kernel.org>
         <1615346469.26498.1.camel@mhfsdcap03> <YEiJS0fPCOPOdlIq@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 70009717DE06A89F05E205A0054F956C3D78377B9B4219CCCC6C498156C87FC12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTEwIGF0IDA5OjU0ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0IDExOjIxOjA5QU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjEtMDMtMDkgYXQgMTk6MjggLTA3MDAsIFJvYiBI
ZXJyaW5nIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBNYXIgMDgsIDIwMjEgYXQgMDE6Mzc6MzRQTSAr
MDgwMCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gPiBGaXggd2FybmluZzogIm1pc3Npbmcg
c3RhcnRpbmcgc3BhY2UgaW4gY29tbWVudCINCj4gPiA+IA0KPiA+ID4gV2hhdCB0cmVlIGlzIHRo
aXMgaW4gYmVjYXVzZSBJIGRvbid0IHNlZSBpdC4NCj4gPiBUaGUgcGF0Y2ggaXMgYmFzZWQga2Vy
bmVsIDUuMTItcmMxLCBhbHNvIGhhcHBlbnMgb24NCj4gPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3VzYi5naXQgdXNiLW5leHQNCj4gDQo+IE15
IGJyYW5jaGVzIGFyZSBub3cgcmViYXNlZCB0byBub3QgYmUgb24gNS4xMi1yYzEgYmVjYXVzZSBv
ZiB0aGUNCj4gcHJvYmxlbXMgd2l0aCBpdCwgc28gcGxlYXNlIHJlZnJlc2ggYW5kIHByb3ZpZGUg
YSAiRml4ZXM6ICIgdGFnIGluIHlvdXINCj4gdXBkYXRlZCBwYXRjaC4NClN0aWxsIHJlcHJvZHVj
ZWQgb24gNS4xMi1yYzINCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

