Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B53FC47B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhHaItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:49:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56406 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240417AbhHaItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:49:15 -0400
X-UUID: 6edc1c8317294ccb827b04c2f20e7ae5-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sZFVav08zwMRGHECP5b0bRmeLPWcxHvBk2pMalHXz0k=;
        b=RrNGUABsTqOF6ZgnPrXLHCz6igypBPTyoCG/9aQ4khqMEc+A+t2awTUZPvESjURS1zM59KQwGjxAdKrF8Zy9+Zi/EnWXK+5UCnVAa1xE3dvUS3Ul5I18sNL2fA9p1u3c3GkWJwMdnVd8X78/dsNqCAGBp4rIxUlo/61dBAcCc3g=;
X-UUID: 6edc1c8317294ccb827b04c2f20e7ae5-20210831
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1984509139; Tue, 31 Aug 2021 16:48:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 16:48:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 16:48:10 +0800
Message-ID: <0d73ada63c3c2949a283ac6830ab9cc84a5e4a41.camel@mediatek.com>
Subject: Re: [PATCH v5 07/11] dt-bindings: mediatek: mt8195: add audio afe
 document
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <bicycle.tsai@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        "Jimmy Cheng-Yi Chiang" <cychiang@google.com>,
        Li-Yu Yu <aaronyu@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 31 Aug 2021 16:48:10 +0800
In-Reply-To: <CAL_Jsq+bLVLqqVKfYuXDVYexMojMgZ5p34Pcx7_7LwU40b-2dA@mail.gmail.com>
References: <20210819084144.18483-1-trevor.wu@mediatek.com>
         <20210819084144.18483-8-trevor.wu@mediatek.com>
         <CAL_Jsq+bLVLqqVKfYuXDVYexMojMgZ5p34Pcx7_7LwU40b-2dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDA3OjM1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMTksIDIwMjEgYXQgMzo0MyBBTSBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRp
YXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBtdDgxOTUgYXVk
aW8gYWZlIGRvY3VtZW50Lg0KPiA+IA0KPiA+IEluIG9yZGVyIHRvIHN1cHBvcnQgZHluYW1pYyBj
bG9jayByZXBhcmVudGluZyBmb3IgQUREQSBhbmQgRVRETSwNCj4gPiBQTEwNCj4gPiBhbmQgTVVY
IGNsb2NrcyBhcmUgcmVxdWVzdGVkIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIG5vdCBjb25zdW1lZCBi
eQ0KPiA+IGFmZQ0KPiA+IGRpcmVjdGx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZv
ciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBUaGlzIHBhdGNoIGRl
cGVuZHMgb24gdGhlIGZvbGxvd2luZyBzZXJpZXMgdGhhdCBoYXZlIG5vdCBiZWVuDQo+ID4gYWNj
ZXB0ZWQuDQo+ID4gDQo+ID4gWzFdIE1lZGlhdGVrIE1UODE5NSBjbG9jayBzdXBwb3J0DQo+ID4g
DQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz01MDE5MjNfXzshIUNUUk5LQTl3
TWcwQVJidyF5Ym03RTgwRExMWVhzOE91ak80NlNVS1lGT1V4OGdzTFpQVEU2VkRGckdUUTByQVls
SkpIT1VLaExfWlVTSlNMa0EkDQo+ID4gIA0KPiA+IChkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTUt
Y2xrLmggaXMgaW5jbHVkZWQpDQo+IA0KPiBUaGlzIGRlcGVuZGVuY3kgaXMgc3RpbGwgbm90IGFw
cGxpZWQsIHNvIHRoZSBleGFtcGxlIGZhaWxzLiBPbmUgb2YNCj4gdGhlDQo+IGZvbGxvd2luZyBu
ZWVkcyB0byBoYXBwZW46IHRoZSBkZXBlbmRlbmN5IG5lZWRzIHRvIGJlIGFwcGxpZWQsIHRoaXMN
Cj4gcGF0Y2ggcmV2ZXJ0ZWQsIG9yIGRyb3AgdGhlIHVzZSBvZiB0aGUgZGVmaW5lcyBpbiB0aGUg
ZXhhbXBsZS4NCj4gDQo+IFJvYg0KDQpIaSBSb2IsDQoNCkkgc2VuZCBhIHBhdGNoIGFuZCBkcm9w
IHRoZSB1c2Ugb2YgZGVmaW5lcy4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2Fsc2EtZGV2ZWwvcGF0Y2gvMjAyMTA4MzEwODM5NTYuOTgwNC0xLXRyZXZvci53dUBtZWRp
YXRlay5jb20vDQoNClRoYW5rcywNClRyZXZvcg0KDQo=

