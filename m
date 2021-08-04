Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B163DFB02
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhHDFUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:20:05 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42580 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231592AbhHDFUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:20:03 -0400
X-UUID: 0156c2db61064683851d0ba38aa8d377-20210804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lTtejfzC/dI1hPB49Y0KNSixxnq5EFnA0JdBRkQ8O7g=;
        b=I+4OB8kqeMMB9e2ENYDVTj9S35N6OUJiWGgcQB/wEeWOKhf2aAm/YQKzsVZwP3xhN/MSeQADFZ5TvsVQKnQaMIoc1QI6MSg1k9UpjIHdpgJNnV06T5L9gcz2Lc/1ndMufqPL1Cp78wnv8SGMpOBaIs5Zv/TM451lDUhtinrYVZg=;
X-UUID: 0156c2db61064683851d0ba38aa8d377-20210804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1879885696; Wed, 04 Aug 2021 13:19:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs02n1.mediatek.inc
 (172.21.101.77) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Aug
 2021 13:19:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Aug 2021 13:19:44 +0800
Message-ID: <1628054384.14982.12.camel@mhfsdcap03>
Subject: Re: [PATCH 08/11] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Wed, 4 Aug 2021 13:19:44 +0800
In-Reply-To: <CAATdQgDWkohpzgr=z+uzro4m9Bd=v88DNnJ-M88-5-0annhH_w@mail.gmail.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <1627635002-24521-8-git-send-email-chunfeng.yun@mediatek.com>
         <CAATdQgDWkohpzgr=z+uzro4m9Bd=v88DNnJ-M88-5-0annhH_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDE0OjA1ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGkgQ2h1bmZlbmcsDQo+IA0KPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCA0OjUxIFBNIENodW5m
ZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBVc2Ug
QGJ3X2J1ZGdldF90YWJsZVtdIHRvIHVwZGF0ZSBmcyBidXMgYmFuZHdpZHRoIGR1ZSB0bw0KPiA+
IG5vdCBhbGwgbWljcm9mcmFtZXMgY29uc3VtZSBAYndfY29zdF9wZXJfbWljcm9mcmFtZSwgc2Vl
DQo+ID4gc2V0dXBfc2NoX2luZm8oKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91
c2IvaG9zdC94aGNpLW10ay1zY2guYyB8IDE3ICsrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLXNjaC5jDQo+ID4gaW5kZXggMGJiMWE2Mjk1ZDY0Li4xMGMwZjBmNjQ2MWYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gPiBAQCAtNDU4LDggKzQ1OCw4
IEBAIHN0YXRpYyBpbnQgY2hlY2tfZnNfYnVzX2J3KHN0cnVjdCBtdTNoX3NjaF9lcF9pbmZvICpz
Y2hfZXAsIGludCBvZmZzZXQpDQo+ID4gICAgICAgICAgICAgICAgICAqIENvbXBhcmVkIHdpdGgg
aHMgYnVzLCBubyBtYXR0ZXIgd2hhdCBlcCB0eXBlLA0KPiA+ICAgICAgICAgICAgICAgICAgKiB0
aGUgaHViIHdpbGwgYWx3YXlzIGRlbGF5IG9uZSB1ZnJhbWUgdG8gc2VuZCBkYXRhDQo+ID4gICAg
ICAgICAgICAgICAgICAqLw0KPiA+IC0gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgc2No
X2VwLT5jc19jb3VudDsgaisrKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgdG1wID0g
dHQtPmZzX2J1c19id1tiYXNlICsgal0gKyBzY2hfZXAtPmJ3X2Nvc3RfcGVyX21pY3JvZnJhbWU7
DQo+ID4gKyAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPm51bV9idWRnZXRf
bWljcm9mcmFtZXM7IGorKykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRtcCA9IHR0
LT5mc19idXNfYndbYmFzZSArIGpdICsgc2NoX2VwLT5id19idWRnZXRfdGFibGVbal07DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHRtcCA+IEZTX1BBWUxPQURfTUFYKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FU0NIX0JXX09WRVJGTE9XOw0K
PiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gQEAgLTUzNCwyMSArNTM0LDE4IEBAIHN0YXRpYyB2
b2lkIHVwZGF0ZV9zY2hfdHQoc3RydWN0IG11M2hfc2NoX2VwX2luZm8gKnNjaF9lcCwgYm9vbCB1
c2VkKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbXUzaF9zY2hfdHQgKnR0ID0gc2NoX2Vw
LT5zY2hfdHQ7DQo+ID4gICAgICAgICB1MzIgYmFzZSwgbnVtX2VzaXQ7DQo+ID4gLSAgICAgICBp
bnQgYndfdXBkYXRlZDsNCj4gPiAgICAgICAgIGludCBpLCBqOw0KPiA+DQo+ID4gICAgICAgICBu
dW1fZXNpdCA9IFhIQ0lfTVRLX01BWF9FU0lUIC8gc2NoX2VwLT5lc2l0Ow0KPiA+DQo+ID4gLSAg
ICAgICBpZiAodXNlZCkNCj4gPiAtICAgICAgICAgICAgICAgYndfdXBkYXRlZCA9IHNjaF9lcC0+
YndfY29zdF9wZXJfbWljcm9mcmFtZTsNCj4gPiAtICAgICAgIGVsc2UNCj4gPiAtICAgICAgICAg
ICAgICAgYndfdXBkYXRlZCA9IC1zY2hfZXAtPmJ3X2Nvc3RfcGVyX21pY3JvZnJhbWU7DQo+ID4g
LQ0KPiA+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9lc2l0OyBpKyspIHsNCj4gPiAgICAg
ICAgICAgICAgICAgYmFzZSA9IHNjaF9lcC0+b2Zmc2V0ICsgaSAqIHNjaF9lcC0+ZXNpdDsNCj4g
Pg0KPiA+IC0gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgc2NoX2VwLT5jc19jb3VudDsg
aisrKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHR0LT5mc19idXNfYndbYmFzZSArIGpd
ICs9IGJ3X3VwZGF0ZWQ7DQo+ID4gKyAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBzY2hf
ZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXM7IGorKykNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAodXNlZCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0LT5m
c19idXNfYndbYmFzZSArIGpdICs9IHNjaF9lcC0+YndfYnVkZ2V0X3RhYmxlW2pdOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHR0LT5mc19idXNfYndbYmFzZSArIGpdIC09IHNjaF9lcC0+YndfYnVkZ2V0X3RhYmxl
W2pdOw0KPiANCj4gSSBhZ3JlZSB0aGF0IHhoY2ktbXRrLXNjaCBzdGlsbCBoYXMgbW9yZSByb29t
cyBmb3IgdHQgcGVyaW9kaWMgYmFuZHdpZHRoDQo+IGJ1dCBJIHRoaW5rIHRoaXMgYXBwcm9hY2gg
Y291bGQgdHJpZ2dlciBhIHByb2JsZW0uDQpTZWUgdXBkYXRfYnVzX2J3KCksIHdoZW4gYWRkIGZz
IGVwJ3MgYmFuZHdpZHRoLCBpdCB1c2VzDQpid19idWRnZXRfdGFibGVbXSwgc28gcHJlZmVyIHRv
IHVzZSB0aGUgc2FtZSB3YXkNCg0KPiANCj4gZm9yIGV4YW1wbGUsIGlmIHRoZXJlIGFyZSB0d28g
ZW5kcG9pbnRzIHNjaGVkdWxlZCBpbiB0aGUgc2FtZSB1LWZyYW1lIGluZGV4LA0KPiAqIGVwMW91
dCAgPSBpc28gMTkyYnl0ZXMgYndfYnVkZ2V0X3RhYmxlW10gPSB7IDE4OCwgMTg4LCAwLCAuLi59
IC0tPiB5MA0KPiAqIGVwMmluID0gaW50IDY0Ynl0ZXMsIGJ3X2J1ZGdldF90YWJsZVtdID0geyAw
LCAwLCA2NCwgLi4uIH0gIC0tPiB5MA0KPiANCj4gKElmIHRoaXMgaXMgcG9zc2libGUgYWxsb2Nh
dGlvbiBmcm9tIHRoaXMgcGF0Y2gpLA0KPiBJIGd1ZXNzIHhoY2ktbXRrIGNvdWxkIGhhdmUgc29t
ZSBwcm9ibGVtcyBvbiBpbnRlcm5hbCBzY2hlZHVsaW5nPw0KDQpUZXN0IGl0IG9uIGR2dCBlbnYu
IGRvbid0IGVuY291bnRlciBpc3N1ZXM7DQoNClRoYW5rcw0KDQo+IA0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICBpZiAodXNlZCkNCj4gDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0K
DQo=

