Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603A3ECC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhHPBS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 21:18:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229527AbhHPBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 21:18:56 -0400
X-UUID: 6bca7c7958154cdd95dda9d0a26297db-20210816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zMgcmilrnOZK5/KKJ2IXdoMtIXHDBZKsjT73O5khxW4=;
        b=Q7FLlNeq6vWEv6PmGu3iRJL9/MMeaZ2fxCpraMg20ywYiU0NV6XpK1sLVRuit3+lXbubDc7zq6XLffknGZMW2wcazd+Kq71nE8We7mgDmO/JvwAPkTP94QqDtJrfRNF/fIA51FZHb56nb+naOEL/qbJmAQMiuLhMiuuYaU30Kgk=;
X-UUID: 6bca7c7958154cdd95dda9d0a26297db-20210816
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 89222370; Mon, 16 Aug 2021 09:18:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 Aug
 2021 09:18:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 Aug 2021 09:18:15 +0800
Message-ID: <cba6ccf59101225150d0b9f6020753adc22221ed.camel@mediatek.com>
Subject: Re: [PATCH v6 6/9] soc: mediatek: mmsys: instantiate mdp virtual
 device from mmsys
From:   houlong wei <houlong.wei@mediatek.com>
To:     Eizan Miyamoto <eizan@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "wenst@chromium.org" <wenst@chromium.org>,
        Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= 
        <Yong.Wu@mediatek.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>, <houlong.wei@mediatek.com>
Date:   Mon, 16 Aug 2021 09:18:16 +0800
In-Reply-To: <20210802220943.v6.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
References: <20210802121215.703023-1-eizan@chromium.org>
         <20210802220943.v6.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D1B8CF45BE547C01305672B36FAAF841C10023D9984BDBA7059507DD2D056FB62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTAyIGF0IDIwOjEyICswODAwLCBFaXphbiBNaXlhbW90byB3cm90ZToN
Cj4gQSB2aXJ0dWFsIGRldmljZSB0aGF0IGlzIHByb2JlZCBieSB0aGUgbXRrX21kcF9jb3JlIGRy
aXZlciBpcw0KPiBpbnN0YW50aWF0ZWQgYnkgdGhlIG10a19tbXN5cyBkcml2ZXIuDQo+IA0KPiBU
aGlzIGJldHRlciByZWZsZWN0cyB0aGUgbG9naWNhbCBvcmdhbml6YXRpb24gb2YgdGhlIGhhcmR3
YXJlIGFuZA0KPiBkcml2ZXI6IHRoZXJlIGFyZSBhIG51bWJlciBvZiBoYXJkd2FyZSBibG9ja3Mg
dGhhdCBhcmUgdXNlZCBieSB0aGUNCj4gTURQDQo+IHRoYXQgaGF2ZSBubyBzdHJpY3QgaGllcmFy
Y2h5LCBhbmQgdGhlIHNvZnR3YXJlIGRyaXZlciBpcyByZXNwb25zaWJsZQ0KPiBmb3IgZHJpdmlu
ZyB0aGVtIHByb3Blcmx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWl6YW4gTWl5YW1vdG8gPGVp
emFuQGNocm9taXVtLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBIb3Vsb25nIFdlaSA8aG91
bG9uZy53ZWlAbWVkaWF0ZWsuY29tPg0KDQo+IChubyBjaGFuZ2VzIHNpbmNlIHYxKQ0KPiANCj4g
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5jIHwgMjAgKysrKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4gYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYw0KPiBpbmRleCAwODA2NjBlZjExYmYuLmU2
ODEwMjlmZTgwNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
LmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4gQEAgLTk3LDYg
Kzk3LDcgQEAgc3RhdGljIGludCBtdGtfbW1zeXNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjbGtzOw0KPiAgCXN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKmRybTsNCj4gIAlzdHJ1Y3QgbXRrX21tc3lzICptbXN5czsNCj4g
KwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICptZHA7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCW1t
c3lzID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCptbXN5cyksIEdGUF9LRVJORUwpOw0KPiBA
QCAtMTIyLDEwICsxMjMsMjcgQEAgc3RhdGljIGludCBtdGtfbW1zeXNfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCQkJICAgIFBMQVRGT1JNX0RFVklEX0FVVE8s
IE5VTEwsDQo+IDApOw0KPiAgCWlmIChJU19FUlIoZHJtKSkgew0KPiAgCQlwbGF0Zm9ybV9kZXZp
Y2VfdW5yZWdpc3RlcihjbGtzKTsNCj4gLQkJcmV0dXJuIFBUUl9FUlIoZHJtKTsNCj4gKwkJcmV0
ID0gUFRSX0VSUihkcm0pOw0KPiArCQlnb3RvIGVycl9kcm07DQo+ICsJfQ0KPiArDQo+ICsJbWRw
ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoJnBkZXYtPmRldiwgIm10ay1tZHAiLA0K
PiArCQkJCQkgICAgUExBVEZPUk1fREVWSURfQVVUTywgTlVMTCwNCj4gMCk7DQo+ICsJaWYgKElT
X0VSUihtZHApKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIobWRwKTsNCj4gKwkJZGV2X2VycihkZXYs
ICJGYWlsZWQgdG8gcmVnaXN0ZXIgbWRwOiAlZFxuIiwgcmV0KTsNCj4gKwkJZ290byBlcnJfbWRw
Ow0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtlcnJfbWRwOg0KPiArCXBsYXRm
b3JtX2RldmljZV91bnJlZ2lzdGVyKGRybSk7DQo+ICsNCj4gK2Vycl9kcm06DQo+ICsJcGxhdGZv
cm1fZGV2aWNlX3VucmVnaXN0ZXIoY2xrcyk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0K
PiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9tdGtfbW1z
eXNbXSA9IHsNCj4gLS0gDQo+IDIuMzIuMC41NTQuZ2UxYjMyNzA2ZDgtZ29vZw0KPiANCg==

