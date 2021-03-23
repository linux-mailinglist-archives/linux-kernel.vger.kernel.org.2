Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA5345597
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCWCkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:40:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36532 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229972AbhCWCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:40:01 -0400
X-UUID: 8e61e3744c2b4f15b5571999d2d9d456-20210323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=t0qU8llNkRDLUgJXViRWMIBmBCKeW0QIxCmuD9wSIyA=;
        b=sG0lRv2QbVu+xjPq1mxgKkmu/mtyGHHcLmV5k6p3xlNM2jBa6DcMKz3P4mOXS9sPve0T84nVEoZhfvj3PAv30KNP9Uesk+fjgX5aM14SDoPn6TO9EPDNc4VRopPuYYHgUWSctGc7icUCqlgDyVHHa8csNO0U43M8PnRWIfZ7pko=;
X-UUID: 8e61e3744c2b4f15b5571999d2d9d456-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1600099692; Tue, 23 Mar 2021 10:39:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Mar
 2021 10:39:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:39:54 +0800
Message-ID: <1616467194.11286.2.camel@mhfsdcap03>
Subject: Re: [PATCH 07/13] usb: xhci-mtk: add support ip-sleep wakeup for
 mT8192
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 23 Mar 2021 10:39:54 +0800
In-Reply-To: <f9d14506-5db5-8f97-e3d0-5956cc17dadd@gmail.com>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
         <1616382832-28450-7-git-send-email-chunfeng.yun@mediatek.com>
         <f9d14506-5db5-8f97-e3d0-5956cc17dadd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDExOjU4ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IE9uIDIyLjAzLjIwMjEgNjoxMywgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiANCj4gPiBBZGQg
c3VwcG9ydCBpcC1zbGVlcCB3YWtldXAgZm9yIG1UODE5MiwgaXQncyBhIHNwZWNpZmljIHJldmlz
aW9uLA0KPiAgICAgICAgICAgICAgIF4gZm9yDQo+IA0KPiA+IGFuZCBub3QgZm9sbG93IElQTSBy
dWxlLg0KPiANCj4gICAgIEZvbGxvd2luZz8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy91c2IvaG9zdC94aGNpLW10ay5jIHwgMTAgKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gaW5kZXgg
OGJhMWY5MTRjYjc1Li4xYmZhMjhjOWI1YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+
ID4gQEAgLTcwLDYgKzcwLDEwIEBADQo+ID4gICAjZGVmaW5lIFdDMF9JU19QCUJJVCgxMikJLyog
cG9sYXJpdHkgKi8NCj4gPiAgICNkZWZpbmUgV0MwX0lTX0VOCUJJVCg2KQ0KPiA+ICAgDQo+ID4g
Ky8qIG10ODE5MiAqLw0KPiA+ICsjZGVmaW5lIFdDMF9TU1VTQjBfQ0RFTgkJQklUKDYpDQo+ID4g
KyNkZWZpbmUgV0MwX0lTX1NQTV9FTgkJQklUKDEpDQo+ID4gKw0KPiA+ICAgLyogbXQyNzEyIGV0
YyAqLw0KPiA+ICAgI2RlZmluZSBQRVJJX1NTVVNCX1NQTV9DVFJMCTB4MA0KPiA+ICAgI2RlZmlu
ZSBTU0NfSVBfU0xFRVBfRU4JQklUKDQpDQo+ID4gQEAgLTc5LDYgKzgzLDcgQEAgZW51bSBzc3Vz
Yl91d2tfdmVycyB7DQo+ID4gICAJU1NVU0JfVVdLX1YxID0gMSwNCj4gPiAgIAlTU1VTQl9VV0tf
VjIsDQo+ID4gICAJU1NVU0JfVVdLX1YxMSA9IDExLAkvKiBzcGVjaWZpYyByZXZpc2lvbiAxLjEg
Ki8NCj4gPiArCVNTVVNCX1VXS19WMTIsCQkvKiBzcGVjaWZpYyByZXZpc2lvbiAxLjIgKi8NCj4g
DQo+ICAgICBTU1VTQl9VV0tfVjFfMiwgbWF5YmU/DQpPaywgd2lsbCBkbyBpdCwgdGhhbmtzIGEg
bG90DQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBNQlIsIFNlcmdlaQ0KDQo=

