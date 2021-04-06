Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10959354EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhDFIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:44:21 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62578 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244441AbhDFIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:44:20 -0400
X-UUID: d3cbea260d2b4ff5aed39e03c1572021-20210406
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jskoNae0qUUv9JNUt4/vWKhrhKvU8yBtWmyh/Q5AcmM=;
        b=G8rFL6yhGxb8jkhu3+o8gHKE6mQjcPX5MXgR5gDWr5dgEPEJX5cCNb3eJYOrwSmS9uBohDsfDX6Bfi33cZ7wxj5PusOpLET3kDYjB2kFLr4rYSF/fIQsl7Ah8Wgnf15j0gQt7gXyXPDL/CNgc2GqD2079Cub0VXk+05sI1j21sY=;
X-UUID: d3cbea260d2b4ff5aed39e03c1572021-20210406
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 170298927; Tue, 06 Apr 2021 16:44:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr
 2021 16:43:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 16:43:56 +0800
Message-ID: <1617698636.26944.8.camel@mhfsdcap03>
Subject: Re: [PATCH 3/5] arm64: dts: mediatek: mt8167: add larb nodes
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <mkorpershoek@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 6 Apr 2021 16:43:56 +0800
In-Reply-To: <20210405200821.2203458-3-fparent@baylibre.com>
References: <20210405200821.2203458-1-fparent@baylibre.com>
         <20210405200821.2203458-3-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7691E83C22369EB7F43B506DD7397EE3A87FE371554C2C63EF10D93131A4815E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTA1IGF0IDIyOjA4ICswMjAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
PiBBZGQgbGFyYiBub2RlcyBmb3IgTVQ4MTY3Og0KPiAqIGxhcmIwIGlzIHVzZWQgZm9yIGRpc3Bs
YXkgKGRzaSBhbmQgaGRtaSkNCj4gKiBsYXJiMSBpcyB1c2VkIGZvciBjYW1lcmEgKGNzaSkNCj4g
KiBsYXJiMiBpcyB1c2VkIGZvciB0aGUgdmlkZW8gaGFyZHdhcmUgZGVjb2Rlcg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNjcuZHRzaSB8IDMzICsrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE2Ny5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNjcuZHRzaQ0KPiBpbmRleCA0Yjk1
MWY4MWRiOWUuLjliMzUyMDMxYzVmNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxNjcuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE2Ny5kdHNpDQo+IEBAIC0xNDAsNSArMTQwLDM4IEBAIHNtaV9jb21tb246IHNtaUAx
NDAxNzAwMCB7DQo+ICAJCQljbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIjsNCj4gIAkJCXBvd2Vy
LWRvbWFpbnMgPSA8JnNwbSBNVDgxNjdfUE9XRVJfRE9NQUlOX01NPjsNCj4gIAkJfTsNCj4gKw0K
PiArCQlsYXJiMDogbGFyYkAxNDAxNjAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE2Ny1zbWktbGFyYiI7DQo+ICsJCQlyZWcgPSA8MCAweDE0MDE2MDAwIDAgMHgxMDAwPjsN
Cj4gKwkJCW1lZGlhdGVrLHNtaSA9IDwmc21pX2NvbW1vbj47DQo+ICsJCQltZWRpYXRlayxsYXJi
aWQgPSA8MD47DQoNCkZyb20gWzFdLCBUaGlzIHNob3VsZCBiZTogbWVkaWF0ZWssbGFyYi1pZC4N
Cg0KQWN0dWFsbHkgdGhpcyBwcm9wZXJ0eSBpcyB1bm5lY2Vzc2FyeSBpbiB0aGlzIFNvQyBzaW5j
ZSB0aGlzIGxhcmItaWQgaW4NCnRoZSBtNHUgbm9kZSBpcyBjb25zZWN1dGl2ZS4NCg0KWzFdDQpo
dHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xMi1yYzIvc291cmNlL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21p
LWxhcmIueWFtbCNMNTgNCg0KPiArCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fU01JX0xBUkIw
PiwNCj4gKwkJCQkgPCZtbXN5cyBDTEtfTU1fU01JX0xBUkIwPjsNCj4gKwkJCWNsb2NrLW5hbWVz
ID0gImFwYiIsICJzbWkiOw0KPiArCQkJcG93ZXItZG9tYWlucyA9IDwmc3BtIE1UODE2N19QT1dF
Ul9ET01BSU5fTU0+Ow0KPiArCQl9Ow0KPiArDQo+ICsJCWxhcmIxOiBsYXJiQDE1MDAxMDAwIHsN
Cj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTY3LXNtaS1sYXJiIjsNCj4gKwkJCXJl
ZyA9IDwwIDB4MTUwMDEwMDAgMCAweDEwMDA+Ow0KPiArCQkJbWVkaWF0ZWssc21pID0gPCZzbWlf
Y29tbW9uPjsNCj4gKwkJCW1lZGlhdGVrLGxhcmJpZCA9IDwxPjsNCj4gKwkJCWNsb2NrcyA9IDwm
aW1nc3lzIENMS19JTUdfTEFSQjFfU01JPiwNCj4gKwkJCQkgPCZpbWdzeXMgQ0xLX0lNR19MQVJC
MV9TTUk+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSI7DQo+ICsJCQlwb3dlci1k
b21haW5zID0gPCZzcG0gTVQ4MTY3X1BPV0VSX0RPTUFJTl9JU1A+Ow0KPiArCQl9Ow0KPiArDQo+
ICsJCWxhcmIyOiBsYXJiQDE2MDEwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTY3LXNtaS1sYXJiIjsNCj4gKwkJCXJlZyA9IDwwIDB4MTYwMTAwMDAgMCAweDEwMDA+Ow0K
PiArCQkJbWVkaWF0ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCj4gKwkJCW1lZGlhdGVrLGxhcmJp
ZCA9IDwyPjsNCj4gKwkJCWNsb2NrcyA9IDwmdmRlY3N5cyBDTEtfVkRFQ19DS0VOPiwNCj4gKwkJ
CQkgPCZ2ZGVjc3lzIENMS19WREVDX0xBUkIxX0NLRU4+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAi
YXBiIiwgInNtaSI7DQo+ICsJCQlwb3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTY3X1BPV0VSX0RP
TUFJTl9WREVDPjsNCj4gKwkJfTsNCj4gIAl9Ow0KPiAgfTsNCg0K

