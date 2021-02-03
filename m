Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531530D398
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBCG6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 01:58:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52377 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230193AbhBCG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:58:30 -0500
X-UUID: b25f4208624141f387ec8ef77e08ea68-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xRMlI2EADtM4gae429sxpvqn+NvYbc5cVgo4D59hErQ=;
        b=BT4M3PrsQ5TGCxdMvQMoEw82htr4KY49+wSBhScM0I4Mgp6CZPdigPsdoyqjhkLNFyJ1gW7bGmptO7phCBeRKL+llB2dnBgiG/D6RtueM043GNLl0kVDgngD1wmuYcqBJy6hERGLiMJOhqFfXzBZ7atfJkElpdDyBrmhzZrbRDU=;
X-UUID: b25f4208624141f387ec8ef77e08ea68-20210203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 815628569; Wed, 03 Feb 2021 14:57:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 14:57:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 14:57:43 +0800
Message-ID: <1612335462.9202.1.camel@mtkswgap22>
Subject: Re: [PATCH 0/2] Add mediatek MT6359 accdet driver
From:   Argus Lin <argus.lin@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Arnd Bergmann <arnd@arndb.de>, Jack Yu <jack.yu@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Dan Murphy <dmurphy@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiaxin Yu =?UTF-8?Q?=28=E4=BF=9E=E5=AE=B6=E9=91=AB=29?= 
        <Jiaxin.Yu@mediatek.com>, Tzung-Bi Shih <tzungbi@google.com>,
        Shane Chien =?UTF-8?Q?=28=E7=B0=A1=E4=BD=91=E8=BB=92=29?= 
        <Shane.Chien@mediatek.com>,
        ChiPeng Chang =?UTF-8?Q?=28=E5=BC=B5=E7=90=A6=E6=9C=8B=29?= 
        <chipeng.chang@mediatek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 3 Feb 2021 14:57:42 +0800
In-Reply-To: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
References: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBtYWludGFpbmVyczoNCkNhbiB5b3UgcmVwbHkgdG8gbWUgaWYgYW55IG9waW5pb24/DQp0
aGFua3MNCg0KQi5SLg0KQXJndXMNCg0KT24gV2VkLCAyMDIxLTAxLTA2IGF0IDIwOjE5ICswODAw
LCBBcmd1cyBMaW4gd3JvdGU6DQo+IE1UNjM1OSBhdWRpbyBjb2RlYyBzdXBwb3J0IGFjY2Vzc29y
eSBkZXRlY3QgZmVhdHVyZXMsIHRoZSBnZW5lcmFsIGZlYXR1cmVzDQo+IGFyZSBqYWNrIHBsdWcg
ZGV0ZWN0aW9uIGFuZCBrZXkgZGV0ZWN0aW9uLg0KPiANCj4gQWxsIG9mIDMtcG9sZSBhbmQgNC1w
b2xlIGphY2sgYXJlIHN1cHBvcnRlZC4NCj4gDQo+IGNoYW5nZSBzaW5jZSB2MToNCj4gICAtIGFk
ZHMgbXQ2MzU5IGFjY2RldCBiaW5kaW5nIGRvY3VtZW50DQo+ICAgLSBhZGRzIG10NjM1OSBhY2Nk
ZXQgZHJpdmVyDQo+IA0KPiANCj4gQXJndXMgTGluICgyKToNCj4gICBkdC1iaW5kaW5nczogbWVk
aWF0ZWs6IG10NjM1OTogYWRkIEFTb0MgbXQ2MzU5IGFjY2RldCBkb2N1bWVudA0KPiAgIEFTb0M6
IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBNVDYzNTkgYWNjZGV0IGRyaXZlcg0KPiANCj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210NjM1OS1hY2NkZXQueWFtbCAgIHwgIDE0MiArKw0K
PiAgc291bmQvc29jL2NvZGVjcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICA3ICsNCj4gIHNvdW5kL3NvYy9jb2RlY3MvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgMiArDQo+ICBzb3VuZC9zb2MvY29kZWNzL210NjM1OS1hY2NkZXQuYyAgICAgICAg
ICAgICAgICAgICB8IDE5NTEgKysrKysrKysrKysrKysrKysrKysNCj4gIHNvdW5kL3NvYy9jb2Rl
Y3MvbXQ2MzU5LWFjY2RldC5oICAgICAgICAgICAgICAgICAgIHwgIDEzNiArKw0KPiAgc291bmQv
c29jL2NvZGVjcy9tdDYzNTkuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxODYzICsrKysr
KysrKysrKysrKysrLS0NCj4gIDYgZmlsZXMgY2hhbmdlZCwgMzk5NSBpbnNlcnRpb25zKCspLCAx
MDYgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL210NjM1OS1hY2NkZXQueWFtbA0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LWFjY2RldC5jDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgc291bmQvc29jL2NvZGVjcy9tdDYzNTktYWNjZGV0LmgNCj4gDQo+IC0tDQo+IDEuOC4x
LjEuZGlydHkNCj4gDQoNCg==

