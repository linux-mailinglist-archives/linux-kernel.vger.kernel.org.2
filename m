Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B94374F59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhEFG3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:29:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229622AbhEFG3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:29:46 -0400
X-UUID: 523b5180b66047afb6fbcd17914bae6c-20210506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8LYM9vWTj1GDWM/BgYXdn3ciSia7faNxzkY8cLpYr48=;
        b=hZT2/mJR2uj36bgeB/0YHlodag14uCkweJRJw4vU/BXdgEWA7NB6EOS817eIr2PAj3/nFngf9qJi+PPbYUeGpgz7Xn03Qy/OBAf5o1w05hjTNUnvkM/IV03edm8SpaS8cjbpSI8wKXlb41nDYkXCK41LVRPEakx26IQjRVAATog=;
X-UUID: 523b5180b66047afb6fbcd17914bae6c-20210506
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 565868641; Thu, 06 May 2021 14:28:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 14:28:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 May 2021 14:28:40 +0800
Message-ID: <1620282520.10796.2.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] usb: xhci-mtk: use bitfield instead of bool
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 6 May 2021 14:28:40 +0800
In-Reply-To: <YIuxy9OtlNzq7zwM@kroah.com>
References: <20210430071532.51794-1-chunfeng.yun@mediatek.com>
         <YIuxy9OtlNzq7zwM@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 288AA8889CB735784A0D9ABA8A6F83DE47BCAE8646196241C5A92F49A7D2FC5E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTMwIGF0IDA5OjI5ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgQXByIDMwLCAyMDIxIGF0IDAzOjE1OjMwUE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBVc2UgYml0ZmllbGQgaW5zdGVhZCBvZiBib29sIGluIHN0cnVjdA0K
PiANCj4gVGhhdCBzYXlzIHdoYXQgeW91IGRpZCwgYnV0IG5vdCB3aHkgeW91IGRpZCBpdC4NCj4g
DQo+IFdoeT8NCkl0J3Mgc3VnZ2VzdGVkIGJ5ICJVc2luZyBib29sIiBpbiBjb2Rpbmctc3R5bGUu
cnN0LCBJJ2xsIGFkZCBpdA0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNi
L2hvc3QveGhjaS1tdGsuYyB8IDIgLS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5o
IHwgOCArKysrLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gaW5kZXggYjIwNThiM2Jj
ODM0Li4yNTQ4OTc2YmNmMDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gQEAgLTQ5
NSw4ICs0OTUsNiBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAkJCWdvdG8gcHV0X3VzYjJfaGNkOw0KPiA+ICAJCX0NCj4gPiAg
CQltdGstPmhhc19pcHBjID0gdHJ1ZTsNCj4gPiAtCX0gZWxzZSB7DQo+ID4gLQkJbXRrLT5oYXNf
aXBwYyA9IGZhbHNlOw0KPiANCj4gV2h5IGRpZCB5b3UgcmVtb3ZlIHRoaXMgY2h1bms/ICBUaGF0
IGlzIG5vdCBkZXNjcmliZWQgaW4gdGhlIGNoYW5nZWxvZw0KPiBhdCBhbGwuDQpXaWxsIGFkZCBp
dCwgdGhhbmsgeW91DQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

