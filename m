Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750793959CB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhEaLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:38:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64627 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230521AbhEaLiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:38:10 -0400
X-UUID: d29003bbc1ab4747b897ad5a872a3c8c-20210531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lGvDrucw7R+ESa51Vw2ltK2gA0igTci22CG0bvNo3sI=;
        b=R42WH1CKbw1qAt5ERiizYdFzIgObOHmlC6ku/pkFz8vpCJbhGrlAMv9zQEa0mdf6LnMqlMP5r2/CKGmmnl/lIXwLatJaL/Q4p5B15uQ37SKzk/gLlnNojLfA8quOUOY66jC84Xz/Y6P9ZreruRTubDGsAyr3NXUNcjX5VgOfTeQ=;
X-UUID: d29003bbc1ab4747b897ad5a872a3c8c-20210531
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1792962603; Mon, 31 May 2021 19:36:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 May 2021 19:36:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 May 2021 19:36:12 +0800
Message-ID: <f0eb6a1ac2e3a03c4cc742f45cdd9cb91537ff4d.camel@mediatek.com>
Subject: Re: [PATCH 2/3] soc: mtk-pm-domains: do not register smi node as
 syscon
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <chun-jie.chen@mediatek.corp-partner.google.com>,
        Yong Wu <yong.wu@mediatek.com>
Date:   Mon, 31 May 2021 19:36:12 +0800
In-Reply-To: <20210531043502.2702645-2-hsinyi@chromium.org>
References: <20210531043502.2702645-1-hsinyi@chromium.org>
         <20210531043502.2702645-2-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CB375E2EB8027F684503A9B61A4BB8DDB07113F80DBAC2D41A947B8ADBDB162F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTMxIGF0IDEyOjM1ICswODAwLCBIc2luLVlpIFdhbmcgd3JvdGU6DQo+
IE1lZGlhdGVrIHJlcXVpcmVzIG1tc3lzIGNsb2NrcyB0byBiZSB1bnByZXBhcmVkIGR1cmluZyBz
dXNwZW5kLA0KPiBvdGhlcndpc2Ugc3lzdGVtIGhhcyBjaGFuY2VzIHRvIGhhbmcuDQo+IA0KPiBz
eXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlX29wdGlvbmFsKCkgd2lsbCBhdHRhY2ggYW5k
IHByZXBhcmUNCj4gdGhlDQo+IGZpcnN0IGNsb2NrIGluIHNtaSBub2RlLCBsZWFkaW5nIHRvIGFk
ZGl0aW9uYWwgcHJlcGFyZSB0byB0aGUgY2xvY2sNCj4gd2hpY2ggaXMgbm90IGJhbGFuY2VkIHdp
dGggdGhlIHByZXBhcmUvdW5wcmVwYXJlIHBhaXIgaW4NCj4gcmVzdW1lL3N1c3BlbmQNCj4gY2Fs
bGJhY2tzLg0KPiANCj4gSWYgYSBwb3dlciBkb21haW4gbm9kZSByZXF1ZXN0cyBhbiBzbWkgbm9k
ZSBhbmQgdGhlIHNtaSBub2RlJ3MgZmlyc3QNCj4gY2xvY2sgaXMgYW4gbW1zeXMgY2xvY2ssIGl0
IHdpbGwgcmVzdWx0cyBpbiBhbiB1bnN0YWJrZSBzdXNwZW5kDQo+IHJlc3VtZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCg0KUmV2aWV3
ZWQtYnk6IGNodW4tamllLmNoZW4gPGNodW4tamllLmNoZW5AbWVkaWF0ZWsuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyB8IDEyICsrKysrKysr
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5j
DQo+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiBpbmRleCA1MzZk
OGM2NGIyYjQuLmE5YmE3MWVlZTRiYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0t
ZG9tYWlucy5jDQo+IEBAIC0yOTYsNyArMjk2LDcgQEAgZ2VuZXJpY19wbV9kb21haW4gKnNjcHN5
c19hZGRfb25lX2RvbWFpbihzdHJ1Y3QNCj4gc2Nwc3lzICpzY3BzeXMsIHN0cnVjdCBkZXZpY2Vf
bm8NCj4gIHsNCj4gIAljb25zdCBzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbl9kYXRhICpkb21haW5fZGF0
YTsNCj4gIAlzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAqcGQ7DQo+IC0Jc3RydWN0IGRldmljZV9ub2Rl
ICpyb290X25vZGUgPSBzY3BzeXMtPmRldi0+b2Zfbm9kZTsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnJvb3Rfbm9kZSA9IHNjcHN5cy0+ZGV2LT5vZl9ub2RlLA0KPiAqc21pX25vZGU7DQo+ICAJ
c3RydWN0IHByb3BlcnR5ICpwcm9wOw0KPiAgCWNvbnN0IGNoYXIgKmNsa19uYW1lOw0KPiAgCWlu
dCBpLCByZXQsIG51bV9jbGtzOw0KPiBAQCAtMzUyLDkgKzM1MiwxMyBAQCBnZW5lcmljX3BtX2Rv
bWFpbiAqc2Nwc3lzX2FkZF9vbmVfZG9tYWluKHN0cnVjdA0KPiBzY3BzeXMgKnNjcHN5cywgc3Ry
dWN0IGRldmljZV9ubw0KPiAgCWlmIChJU19FUlIocGQtPmluZnJhY2ZnKSkNCj4gIAkJcmV0dXJu
IEVSUl9DQVNUKHBkLT5pbmZyYWNmZyk7DQo+ICANCj4gLQlwZC0+c21pID0gc3lzY29uX3JlZ21h
cF9sb29rdXBfYnlfcGhhbmRsZV9vcHRpb25hbChub2RlLA0KPiAibWVkaWF0ZWssc21pIik7DQo+
IC0JaWYgKElTX0VSUihwZC0+c21pKSkNCj4gLQkJcmV0dXJuIEVSUl9DQVNUKHBkLT5zbWkpOw0K
PiArCXNtaV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShub2RlLCAibWVkaWF0ZWssc21pIiwgMCk7
DQo+ICsJaWYgKHNtaV9ub2RlKSB7DQo+ICsJCXBkLT5zbWkgPSBkZXZpY2Vfbm9kZV90b19yZWdt
YXAoc21pX25vZGUpOw0KPiArCQlvZl9ub2RlX3B1dChzbWlfbm9kZSk7DQo+ICsJCWlmIChJU19F
UlIocGQtPnNtaSkpDQo+ICsJCQlyZXR1cm4gRVJSX0NBU1QocGQtPnNtaSk7DQo+ICsJfQ0KPiAg
DQo+ICAJbnVtX2Nsa3MgPSBvZl9jbGtfZ2V0X3BhcmVudF9jb3VudChub2RlKTsNCj4gIAlpZiAo
bnVtX2Nsa3MgPiAwKSB7DQo=

