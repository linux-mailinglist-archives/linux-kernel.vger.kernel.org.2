Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B7375E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhEGB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:29:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57775 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231461AbhEGB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:29:10 -0400
X-UUID: 2813c489632c4127a7d8a8247f3303f4-20210507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U2f4lwRTl6Sq8MKJTf5waJFrZocVoKmmodtxVAvrn2Y=;
        b=kZ18lCiUw3TgV558F55Bb/E45exPUhGhZKqT7iimJlYHpVl754LzBHQR+N1o713NUFzuscZHhEvFqa0hll3bZXBS3sOqW5VGakL9/KzSHYGWpT0oRM7LAHlKky7cV7mGMMQfBLlD/zAul0f/bfxFycPZSPTjVNE8ZmpbJcif7fY=;
X-UUID: 2813c489632c4127a7d8a8247f3303f4-20210507
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1728646819; Fri, 07 May 2021 09:28:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 09:28:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 09:28:04 +0800
Message-ID: <1620350884.10796.4.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/3] usb: xhci-mtk: use bitfield instead of bool
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ikjoon Jang" <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Fri, 7 May 2021 09:28:04 +0800
In-Reply-To: <a3d1a695-3138-f322-3b4f-5d00e9c85a50@gmail.com>
References: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
         <a3d1a695-3138-f322-3b4f-5d00e9c85a50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B66C12DD37D5DBACDC72E5D8E7E26DD366849082BA3EF9E5C2458D502063B1992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTA2IGF0IDExOjUwICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMDYuMDUuMjAyMSA5OjMxLCBDaHVuZmVuZyBZdW4gd3JvdGU6
DQo+IA0KPiA+IFVzZSBiaXRmaWVsZCBpbnN0ZWFkIG9mIGJvb2wgaW4gc3RydWN0DQo+ID4gDQo+
ID4gUmVmZXIgdG8gY29kaW5nLXN0eWxlLnJzdCAxNykgVXNpbmcgYm9vbDoNCj4gPiAiSWYgYSBz
dHJ1Y3R1cmUgaGFzIG1hbnkgdHJ1ZS9mYWxzZSB2YWx1ZXMsIGNvbnNpZGVyIGNvbnNvbGlkYXRp
bmcNCj4gPiB0aGVtIGludG8gYSBiaXRmaWVsZCB3aXRoIDEgYml0IG1lbWJlcnMsIG9yIHVzaW5n
IGFuIGFwcHJvcHJpYXRlDQo+ID4gZml4ZWQgd2lkdGggdHlwZSwgc3VjaCBhcyB1OC4iDQo+ID4g
DQo+ID4gRHVlIHRvIEBoYXNfaXBwYydzIGRlZmF1bHQgdmF1bGUgaXMgMCwgbm8gbmVlZCBzZXQg
aXQgYWdhaW4gaWYgZmFpbA0KPiANCj4gICAgIFZhbHVlLiA6LSkNCldpbGwgZml4IGl0LCB0aGFu
a3MNCj4gDQo+ID4gdG8gZ2V0IGlwcGMgYmFzZSBhZGRyZXNzDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiBbLi4uXQ0K
PiANCj4gTUJSLCBTZXJnZWkNCg0K

