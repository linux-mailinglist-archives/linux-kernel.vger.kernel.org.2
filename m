Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89759357B09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhDHEEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:04:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40917 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229735AbhDHEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:04:06 -0400
X-UUID: ba972cc9a02c45799f041d257df7ca94-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DVHlk3aQBzPohEdHzeEyWWrR5lnDnpX1qWaGhOvJPGs=;
        b=QTiBGQJr1GMEiINEgdZv3lwl5O7N5sa5wJkXgBr2F6FVl9BNtt8ax64gkAQFP6Hz9cQF6O79MZhWXxjUvPqWDCoKhQlu/pvNUyurThXfbMVP3tWfSIaSnHhJ88QhWMMzBFsTIHZkPHErxfjyM7jyvzPQ3/yTYNGoC6ktGs7d5lQ=;
X-UUID: ba972cc9a02c45799f041d257df7ca94-20210408
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 422226286; Thu, 08 Apr 2021 12:03:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 12:03:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 12:03:51 +0800
Message-ID: <1617854631.5654.9.camel@mtksdccf07>
Subject: Re: [PATCH 5/8] dt-bindings: soc: mediatek: apusys: Add new
 document for APU power domain
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-mediatek@lists.infradead.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
Date:   Thu, 8 Apr 2021 12:03:51 +0800
In-Reply-To: <1617805692.253379.3696993.nullmailer@robh.at.kernel.org>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
         <1617766086-5502-6-git-send-email-flora.fu@mediatek.com>
         <1617805692.253379.3696993.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYiwgDQoNClRoZSBlcnJvciBpcyByZXN1bHRlZCBmcm9tIHNvbWUgdW4tbWVyZ2VkIHBh
dGNoLg0KDQpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBwYXRjaCBkZXBlbmRzIE1UODE5MiBjbG9jayBw
YXRjaGVzIHdoaWNoIGhhdmVuJ3QgeWV0IGJlZW4gYWNjZXB0ZWQuDQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMTAzMjQxMDQxMTAu
MTMzODMtNy1jaHVuLWppZS5jaGVuQG1lZGlhdGVrLmNvbS8NCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldy4NCg0KT24gV2VkLCAyMDIxLTA0LTA3IGF0IDA5OjI4IC0wNTAwLCBSb2IgSGVycmluZyB3
cm90ZToNCj4gT24gV2VkLCAwNyBBcHIgMjAyMSAxMToyODowMyArMDgwMCwgRmxvcmEgRnUgd3Jv
dGU6DQo+ID4gRG9jdW1lbnQgdGhlIGJpbmRpbmdzIGZvciBBUFUgcG93ZXIgZG9tYWluIG9uIE1l
ZGlhVGVrIFNvQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGbG9yYSBGdSA8ZmxvcmEuZnVA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vc29jL21lZGlhdGVrL21lZGlhdGVrLGFw
dS1wbS55YW1sICAgICAgICAgfCAxNDYgKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9tZWRpYXRlayxhcHUtcG0u
eWFtbA0KPiA+IA0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NI
RUNLRVJfRkxBR1M9LW0gZHRfYmluZGluZ19jaGVjaycNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hF
Q0tFUl9GTEFHUyBpcyBuZXcgaW4gdjUuMTMpOg0KPiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJy
b3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9tZWRpYXRlayxhcHUtcG0uZXhhbXBs
ZS5kdHM6MTk6MTg6IGZhdGFsIGVycm9yOiBkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg6
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gICAgMTkgfCAgICAgICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQo+ICAgICAgIHwgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBjb21waWxhdGlvbiB0ZXJtaW5h
dGVkLg0KPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUubGliOjM3NzogRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9tZWRpYXRlayxhcHUtcG0uZXhh
bXBsZS5kdC55YW1sXSBFcnJvciAxDQo+IG1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTQxNDogZHRfYmluZGluZ19jaGVj
a10gRXJyb3IgMg0KPiANCj4gU2VlIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzE0NjMxMTVfXzshIUNUUk5LQTl3TWcwQVJidyEw
WFVuMUxjTkhmdlVTaE5DbHBNX3lINzNUQVI5cWRtMjlTWk1ja2Fzb0NROFV6ZUtTLXZaVzBRVXUz
U3NuLXM2JCANCj4gDQo+IFRoaXMgY2hlY2sgY2FuIGZhaWwgaWYgdGhlcmUgYXJlIGFueSBkZXBl
bmRlbmNpZXMuIFRoZSBiYXNlIGZvciBhIHBhdGNoDQo+IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhl
IG1vc3QgcmVjZW50IHJjMS4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5k
aW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3IocyksIHRoZW4gbWFr
ZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8NCj4g
ZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFz
ZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KPiANCg0KDQo=

