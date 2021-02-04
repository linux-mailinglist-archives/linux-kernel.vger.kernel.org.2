Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5025E30D39C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhBCG7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 01:59:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51919 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231784AbhBCG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:59:15 -0500
X-UUID: f3fed154928846a1a251a89ecb68e621-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CjdN8hd2DDZylVIhOx3Ho4XozyJvo82Whum33sHVPUY=;
        b=jDbIm8hrKuj4UdpxS6jHxgIrGlBPbwBPnqUSbn/h/Dn4nPUP9sTgMyiRYeztY7GNsRBh0Ym6ZjNGJYmW38DW0Tr/ShJruk9cSQPM268RPvCKqHc3a5O7vUsixV7ZxH47p8vaV0FA1kLm6uCRimwT3mb/giePa5oPz3VSaZG7DoI=;
X-UUID: f3fed154928846a1a251a89ecb68e621-20210203
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1658595977; Wed, 03 Feb 2021 14:58:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 14:58:25 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 14:58:26 +0800
Message-ID: <1612335506.9202.2.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mt6359: add ASoC mt6359
 accdet document
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
Date:   Wed, 3 Feb 2021 14:58:26 +0800
In-Reply-To: <1609935546-11722-2-git-send-email-argus.lin@mediatek.com>
References: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
         <1609935546-11722-2-git-send-email-argus.lin@mediatek.com>
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
LCBBcmd1cyBMaW4gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBNZWRpYVRlayBNVDYzNTkgYWNj
ZGV0IGRvY3VtZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJndXMgTGluIDxhcmd1cy5saW5A
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
NjM1OS1hY2NkZXQueWFtbCAgIHwgMTQyICsrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE0MiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210NjM1OS1hY2NkZXQueWFtbA0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9t
dDYzNTktYWNjZGV0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvbXQ2MzU5LWFjY2RldC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAuLmZkZTBkMjkNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LWFjY2RldC55YW1sDQo+IEBAIC0wLDAgKzEs
MTQyIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL3NvdW5kL210NjM1OS1hY2NkZXQueWFtbCMNCj4gKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRs
ZTogTWVkaWF0ZWsgVGVjaG5vbG9naWVzIEluYy4gTVQ2MzU5IEFTb0MgYWNjZGV0IGRyaXZlciBi
aW5kaW5ncw0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBDaGlwZW5nIENoYW5nIDxjaGlw
ZW5nLmNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gKw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgVGhp
cyBiaW5kaW5nIGRlc2NyaWJlcyB0aGUgTWVkaWF0ZWsgVGVjaG5vbG9naWVzIE1UNjM1OSBBU29D
DQo+ICsgIGFjY2RldCBkcml2ZXIuDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGli
bGU6DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0gbWVkaWF0ZWssbXQ2MzU5LWFjY2RldA0KPiAr
ICAgICAgLSBtZWRpYXRlayxwbWljLWFjY2RldA0KPiArDQo+ICsgIGFjY2RldC1uYW1lOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsgICAgZGVzY3JpcHRpb246IG5hbWVkIGFzICJtdDYzNTktYWNj
ZGV0IiBmb3Igc25kX3NvY19jYXJkX2phY2suDQo+ICsNCj4gKyAgYWNjZGV0LW1pYy12b2w6DQo+
ICsgICAgbWF4SXRlbXM6IDENCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgYWNjZGV0
IG1pY2JpYXMxIHZvbHRhZ2UuDQo+ICsNCj4gKyAgICAgIGVudW06DQo+ICsgICAgICAgIC0gMHgw
MCAjIDEuN3YgLSBtaWNiaWFzMSB2b2xhZ2UgaXMgMS43di4NCj4gKyAgICAgICAgLSAweDAxICMg
MS44diAtIG1pY2JpYXMxIHZvbGFnZSBpcyAxLjh2Lg0KPiArICAgICAgICAtIDB4MDIgIyAxLjl2
IC0gbWljYmlhczEgdm9sYWdlIGlzIDEuOXYuDQo+ICsgICAgICAgIC0gMHgwMyAjIDIuMHYgLSBt
aWNiaWFzMSB2b2xhZ2UgaXMgMi4wdi4NCj4gKyAgICAgICAgLSAweDA0ICMgMi4xdiAtIG1pY2Jp
YXMxIHZvbGFnZSBpcyAyLjF2Lg0KPiArICAgICAgICAtIDB4MDUgIyAyLjV2IC0gbWljYmlhczEg
dm9sYWdlIGlzIDIuNXYuDQo+ICsgICAgICAgIC0gMHgwNiAjIDIuNnYgLSBtaWNiaWFzMSB2b2xh
Z2UgaXMgMi42di4NCj4gKyAgICAgICAgLSAweDA3ICMgMi43diAtIG1pY2JpYXMxIHZvbGFnZSBp
cyAyLjd2Lg0KPiArICAgICAgICAtIDB4MDggIyAyLjh2IC0gbWljYmlhczEgdm9sYWdlIGlzIDIu
OHYuDQo+ICsgICAgICAgIC0gMHgwOSAjIDIuODV2IC0gbWljYmlhczEgdm9sYWdlIGlzIDIuODV2
Lg0KPiArDQo+ICsgIGFjY2RldC1wbHVnb3V0LWRlYm91bmNlOg0KPiArICAgIG1heEl0ZW1zOiAx
DQo+ICsgICAgZGVzY3JpcHRpb246IEZvciB1c2luZyBhcCBncGlvIGVpbnQgb25seSwgaXQgaXMg
c3cgZGVib3VuY2UgdGltZS4NCj4gKw0KPiArICBhY2NkZXQtbWljLW1vZGU6DQo+ICsgICAgbWF4
SXRlbXM6IDENCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgdmFsdWUgYXMgMSwgMiwg
NiB0byBpbmRpY2F0ZSBBQ0MvRENDIG1vZGUuIGRlZmF1bHQgaXMgRENDIG1vZGUgMi4NCj4gKw0K
PiArICAgICAgZW51bToNCj4gKyAgICAgICAgLSAweDAxICMgQUNDIC0gQUNDIG1vZGUuDQo+ICsg
ICAgICAgIC0gMHgwMiAjIERDQyAtIGxvdyBjb3N0IHdpdGhvdXQgaW4gYmlhcy4NCj4gKyAgICAg
ICAgLSAweDA2ICMgRENDIC0gbG93IGNvc3Qgd2l0aCBpbiBiaWFzLg0KPiArDQo+ICsgIGVpbnRf
dXNlX2V4dF9yZXM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKyAgICBkZXNjcmlwdGlvbjogc2Vs
ZWN0IEhQX0VJTlQgcHVsbCB1cCByZXNpc3RhbmNlLCBkZWZhdWx0IDAgdXNlIGludGVybmFsIHJl
c2lzdGFuY2UuDQo+ICsNCj4gKyAgaGVhZHNldC1tb2RlLXNldHRpbmc6DQo+ICsgICAgbWF4SXRl
bXM6IDE1DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgICBoZWFkc2V0LW1vZGUtc2V0
dGluZyA6IEluZGljYXRlcyBjdXN0b21pemVkIHB3bSwgZGVib3VuY2Ugc2V0dGluZw0KPiArICAg
ICAgIGFjY2RldCBwd21fd2lkdGgsIHB3bV90aHJlc2gsIGZhbGxfZGVsYXksIHJpc2VfZGVsYXkN
Cj4gKyAgICAgICBkZWJvdW5jZTAsIGRlYm91bmNlMSwgZGVib3VuY2UzLCBkZWJvdW5jZTQNCj4g
KyAgICAgICBlaW50IHB3bV93aWR0aCwgZWludCBwd21fdGhyZXNoDQo+ICsgICAgICAgZWludCBk
ZWIoZGVib3VuY2UwLCBkZWJvdW5jZTEsIGRlYm91bmNlMiwgZGVib3VuY2UzKSwgaW52X2RlYm91
bmNlLg0KPiArDQo+ICsgIGhlYWRzZXQtdXNlLWFwLWVpbnQ6DQo+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gKyAgICBkZXNjcmlwdGlvbjogaW5kaWNhdGVzIHRvIHVzZSBhcCBncGlvLg0KPiArDQo+ICsg
IGhlYWRzZXQtZWludC1udW06DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKyAgICBkZXNjcmlwdGlv
bjogfA0KPiArICAgICAgaW5jaWNhdGVzIHBtaWMgZWludCB1c2FnZS4NCj4gKw0KPiArICAgICAg
ZW51bToNCj4gKyAgICAgICAgLSAweDAgIyBQTUlDX0VJTlQwIC0gdXNlIHBtaWMgZWludDAgdG8g
dHJpZ2dlciBwbHVnIGludGVycnVwdC4NCj4gKyAgICAgICAgLSAweDEgIyBQTUlDX0VJTlQxIC0g
dXNlIHBtaWMgZWludDEgdG8gdHJpZ2dlciBwbHVnIGludGVycnVwdC4NCj4gKyAgICAgICAgLSAw
eDIgIyBQTUlDX0JJX0VJTlQgLSB1c2UgcG1pYyBlaW50MC8xIHRvIHRyaWdnZXIgcGx1ZyBpbnRl
cnJ1cHQuDQo+ICsNCj4gKyAgaGVhZHNldC1laW50LXRyaWctbW9kZToNCj4gKyAgICBtYXhJdGVt
czogMQ0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBpbmNpY2F0ZXMgcG1pYyBlaW50
IHRyaWdnZXIgbW9kZS4NCj4gKw0KPiArICAgICAgZW51bToNCj4gKyAgICAgICAgLSAweDAgIyBQ
TUlDX0dQSU8gLSB1c2UgcG1pYyBncGlvIHRvIGRldGVjdCBwbHVnIHN0YXR1cyBieSBzZXR0aW5n
IHBvbGFyaXR5IHRvIGhpZ2ggb3IgbG93Lg0KPiArICAgICAgICAtIDB4MSAjIFBNSUNfSU5WRVJU
RVIgLSB1c2UgcG1pYyBpbnZlcnRlciB0byBkZXRlY3QgcGx1ZyBzdGF0dXMuDQo+ICsNCj4gKyAg
aGVhZHNldC1rZXktbW9kZToNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArICAgIGRlc2NyaXB0aW9u
OiB8DQo+ICsgICAgICBpbmNpY2F0ZXMga2V5IG1vZGUgdHlwZS4NCj4gKw0KPiArICAgICAgZW51
bToNCj4gKyAgICAgICAgLSAweDAgIyBUSFJFRV9LRVkgLSBzdXBwb3J0IDMta2V5IGtleSBtb2Rl
Lg0KPiArICAgICAgICAtIDB4MSAjIEZPVVJfS0VZIC0gc3VwcG9ydCA0LWtleSBrZXkgbW9kZS4N
Cj4gKyAgICAgICAgLSAweDEgIyBUUklfS0VZX0NERCAtIHN1cHBvcnQgMy1rZXkgZ29vZ2xlIENE
RCBrZXkgbW9kZS4NCj4gKw0KPiArICBoZWFkc2V0LXRocmVlLWtleS10aHJlc2hvbGQ6DQo+ICsg
ICAgbWF4SXRlbXM6IDQNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgMyBrZXkgZGV2
aWNlIGRldGVjdGlvbiB0aHJlc2hvbGQ6IDAtLU1EX01BWC0tVVBfTUFYLS1EV19NQVguDQo+ICsN
Cj4gKyAgaGVhZHNldC10aHJlZS1rZXktdGhyZXNob2xkLUNERDoNCj4gKyAgICBtYXhJdGVtczog
NA0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICAgMyBrZXkgQ0REIGRldmljZSBkZXRl
Y3Rpb24gdGhyZXNob2xkOiAwLS1NRF9NQVgtLVVQX01BWC0tRFdfTUFYLg0KPiArDQo+ICsgIGhl
YWRzZXQtZm91ci1rZXktdGhyZXNob2xkOg0KPiArICAgIG1heEl0ZW1zOiA0DQo+ICsgICAgZGVz
Y3JpcHRpb246IHwNCj4gKyAgICAgIDQga2V5IGRldmljZSBkZXRlY3Rpb24gdGhyZXNob2xkOiAw
LS1NRF9NQVgtLVZPSUNFX01BWC0tVVBfTUFYLS1EV19NQVguDQo+ICsNCj4gK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAgYWNj
ZGV0OiBhY2NkZXQgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM1OS1h
Y2NkZXQiOw0KPiArICAgICAgICBhY2NkZXQtbmFtZSA9ICJtdDYzNTktYWNjZGV0IjsNCj4gKyAg
ICAgICAgYWNjZGV0LW1pYy12b2wgPSA8OD47DQo+ICsgICAgICAgIGFjY2RldC1wbHVnb3V0LWRl
Ym91bmNlID0gPDE+Ow0KPiArICAgICAgICBhY2NkZXQtbWljLW1vZGUgPSA8Mj47DQo+ICsgICAg
ICAgIGVpbnRfdXNlX2V4dF9yZXMgPSA8MD47DQo+ICsgICAgICAgIGhlYWRzZXQtbW9kZS1zZXR0
aW5nID0gPDB4NTAwIDB4NTAwIDEgMHgxZjANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMHg4MDAgMHg4MDAgMHgyMCAweDQ0DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDB4NCAweDENCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg1IDB4
MyAweDMgMHg1IDB4ZT47DQo+ICsgICAgICAgIGhlYWRzZXQtdXNlLWFwLWVpbnQgPSA8MD47DQo+
ICsgICAgICAgIGhlYWRzZXQtZWludC1udW0gPSA8MD47DQo+ICsgICAgICAgIGhlYWRzZXQtZWlu
dC10cmlnLW1vZGUgPSA8MT47DQo+ICsgICAgICAgIGhlYWRzZXQta2V5LW1vZGUgPSA8MD47DQo+
ICsgICAgICAgIGhlYWRzZXQtdGhyZWUta2V5LXRocmVzaG9sZCA9IDwwIDgwIDIyMCA0MDA+Ow0K
PiArICAgICAgICBoZWFkc2V0LXRocmVlLWtleS10aHJlc2hvbGQtQ0REID0gPDAgMTIxIDE5MiA2
MDA+Ow0KPiArICAgICAgICBoZWFkc2V0LWZvdXIta2V5LXRocmVzaG9sZCA9IDwwIDU4IDEyMSAx
OTIgNDAwPjsNCj4gKyAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiArICAgIH07DQo+ICsuLi4N
Cj4gLS0NCj4gMS44LjEuMS5kaXJ0eQ0KPiANCg0K

