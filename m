Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627773335A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCJGFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:05:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36585 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229470AbhCJGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:05:24 -0500
X-UUID: 34a4b2874e354797a80b9f074c1ae363-20210310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TpSFMejpETm7dL5XOwTkRbiRAvyZRSD0cuBEgmPjSQA=;
        b=kJI9QQcXU4XVod+1Enok55dwINUYXat1hTh+tbdNvfhihxkobWEafebU2HPUGeIVU6GoN+qQKzaiwA//JvVwAP4KXNMkLc43TwcG8kZKYne/x3ZW3BoIxz0hwEdfUxI/Eq9gFcAqYIHGdbIU3DhOIS+/g2P2fc2iWIv5fymf8Vg=;
X-UUID: 34a4b2874e354797a80b9f074c1ae363-20210310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 956211239; Wed, 10 Mar 2021 14:05:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 14:05:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 14:05:18 +0800
Message-ID: <1615356318.4818.5.camel@mtkswgap22>
Subject: Re: [PATCH v8 3/4] arm64: dts: mediatek: add mt6765 support
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Date:   Wed, 10 Mar 2021 14:05:18 +0800
In-Reply-To: <CAAOTY__kSW0ci9YJjSALOfRqKxxR3ysZUQ3Mxsab77hmCO0TyA@mail.gmail.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
         <1582279929-11535-4-git-send-email-macpaul.lin@mediatek.com>
         <CAAOTY__kSW0ci9YJjSALOfRqKxxR3ysZUQ3Mxsab77hmCO0TyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTEwIGF0IDAwOjA4ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgTWFjcGF1bDoNCj4gDQo+IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5j
b20+IOaWvCAyMDIw5bm0MuaciDIx5pelIOmAseS6lCDkuIvljYg2OjIy5a+r6YGT77yaDQo+ID4N
Cj4gPiBGcm9tOiBNYXJzIENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+
IEFkZCBiYXNpYyBjaGlwIHN1cHBvcnQgZm9yIE1lZGlhdGVrIDY3NjUsIGluY2x1ZGUNCj4gPiB1
YXJ0IG5vZGUgd2l0aCBjb3JyZWN0IHVhcnQgY2xvY2tzLCBwd3JhcCBkZXZpY2UNCj4gPg0KPiA+
IEFkZCBjbG9jayBjb250cm9sbGVyIG5vZGVzLCBpbmNsdWRlIHRvcGNrZ2VuLCBpbmZyYWNmZywN
Cj4gPiBhcG1peGVkc3lzIGFuZCBzdWJzeXN0ZW0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJzIENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBP
d2VuIENoZW4gPG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFj
cGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBBY2tlZC1ieTogTWFyYyBa
eW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8ICAgIDEgKw0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS1ldmIuZHRzIHwgICAzMyArKysrDQo+ID4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2NzY1LmR0c2kgICAgfCAgMjUzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI4NyBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
Njc2NS1ldmIuZHRzDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210Njc2NS5kdHNpDQoNCltkZWxldGVkXQ0KDQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICBtbXN5c19jb25maWc6IHN5c2NvbkAxNDAwMDAwMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtbW1zeXMiLCAic3lzY29u
IjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDE0MDAwMDAwIDAgMHgx
MDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MjI3IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+IA0KPiBJIGRvZXMgbm90IHNlZSBpbnRlcnJ1cHRz
IHByb3BlcnR5IGluIGJpbmRpbmcgZG9jdW1lbnQgWzFdLCBwbGVhc2UgYWRkDQo+IHRoaXMgaW4g
YmluZGluZyBkb2N1bWVudCBmaXJzdC4NCj4gSSdtIGN1cmlvdXMgYWJvdXQgdGhpcyBpbnRlcnJ1
cHQuIEluIHdoaWNoIGNvbmRpdGlvbiB3b3VsZCBpdCBiZSB0cmlnZ2VyZWQ/DQo+IA0KPiBbMV0g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRp
YXRlay9tZWRpYXRlayxtbXN5cy50eHQ/aD12NS4xMi1yYzINCj4gDQo+IFJlZ2FyZHMsDQo+IENo
dW4tS3VhbmcuDQoNClRoYW5rcyBmb3IgcmVtaW5kaW5nLg0KSSdsbCByZW1vdmUgaW50ZXJydXB0
cyBiaW5kaW5nIGluIG5leHQgdmVyc2lvbiBhbmQgbGVhdmUgaXQgZm9yIG1tc3lzDQpkcml2ZXIg
b3duZXIgdG8gdXBkYXRlIHdoZW4gdGhlIGNvbmZpZ3VyYXRpb24gb2YgbW1zeXMgZHJpdmVyIGlz
DQplbmFibGVkLg0KDQpbLi4uXQ0KDQoNCj4gPiArICAgICAgICAgICAgICAgc21pX2NvbW1vbjog
c21pX2NvbW1vbkAxNDAwMjAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtc21pLWNvbW1vbiIsICJzeXNjb24iOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4MTQwMDIwMDAgMCAweDEwMDA+Ow0KPiA+ICsg
ICAgICAgICAgICAgICB9Ow0KPiA+ICsNCg0KQFlvbmcgV3UNClRoYW5rcyBmb3IgcmV2aWV3aW5n
IGhlcmUsIEknbGwgcmVwbGFjZSBzbWlfY29tbW9uQDE0MDAyMDAwIHRvDQpzbWlAMTQwMDIwMDAN
Cg0KUmVnYXJkcywNCk1hY3BhdWwgTGluDQo=

