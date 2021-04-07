Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72E3561D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhDGDXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:23:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56165 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231781AbhDGDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:23:45 -0400
X-UUID: a1f7880b9a0441a58af7d8279786b932-20210407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6p+Sqw+2wiM1G9Ia9wdDLxw/Y5+M1qO/dO+F1uZZDGk=;
        b=IXXcWshEAKNEyft7pQP3wF5j9gSHIlyls3bXxSThTBGJKdyPJtvaeeszJi/+kDqKO2WmPXeGk+8AEqbYv21+bBFn2NeSRfCsq1Z43QHsW59LKfuGmWcuhAG1LQkHaKGmU5oB+wTl46ulI5MjfVmvXTx8Jf4Zvwj8fcEZ5jFxu5M=;
X-UUID: a1f7880b9a0441a58af7d8279786b932-20210407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 886263453; Wed, 07 Apr 2021 11:23:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 11:23:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:23:28 +0800
Message-ID: <1617765808.4370.1.camel@mhfsdcap03>
Subject: Re: [PATCH v1 1/1] ubifs: only check replay with inode type to
 judge if inode linked
From:   Guochun Mao <guochun.mao@mediatek.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 7 Apr 2021 11:23:28 +0800
In-Reply-To: <20210316085214.25024-2-guochun.mao@mediatek.com>
References: <20210316085214.25024-1-guochun.mao@mediatek.com>
         <20210316085214.25024-2-guochun.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmljaGFyZCwNCg0KR2VudGxlIHBpbmcuDQoNCg0KT24gVHVlLCAyMDIxLTAzLTE2IGF0IDE2
OjUyICswODAwLCBndW9jaHVuLm1hb0BtZWRpYXRlay5jb20gd3JvdGU6DQo+IEZyb206IEd1b2No
dW4gTWFvIDxndW9jaHVuLm1hb0BtZWRpYXRlay5jb20+DQo+IA0KPiBDb25zaWRlIHRoZSBmb2xs
b3dpbmcgY2FzZSwgaXQganVzdCB3cml0ZSBhIGJpZyBmaWxlIGludG8gZmxhc2gsDQo+IHdoZW4g
Y29tcGxldGUgd3JpdGluZywgZGVsZXRlIHRoZSBmaWxlLCBhbmQgdGhlbiBwb3dlciBvZmYgcHJv
bXB0bHkuDQo+IE5leHQgdGltZSBwb3dlciBvbiwgd2UnbGwgZ2V0IGEgcmVwbGF5IGxpc3QgbGlr
ZToNCj4gLi4uDQo+IExFQiAxMTA1OjIxMTM0NCBsZW4gNDE0NCBkZWxldGlvbiAwIHNxbnVtIDQy
ODc4MyBrZXkgdHlwZSAxIGlub2RlIDgwDQo+IExFQiAxNToyMzM1NDQgbGVuIDE2MCBkZWxldGlv
biAxIHNxbnVtIDQyODc4NSBrZXkgdHlwZSAwIGlub2RlIDgwDQo+IExFQiAxMTA1OjIxNTQ4OCBs
ZW4gNDE0NCBkZWxldGlvbiAwIHNxbnVtIDQyODc4NyBrZXkgdHlwZSAxIGlub2RlIDgwDQo+IC4u
Lg0KPiBJbiB0aGUgcmVwbGF5IGxpc3QsIGRhdGEgbm9kZXMnIGRlbGV0aW9uIGFyZSAwLCBhbmQg
dGhlIGlub2RlIG5vZGUncw0KPiBkZWxldGlvbiBpcyAxLiBJbiBjdXJyZW50IGxvZ2ljLCB0aGUg
ZmlsZSdzIGRlbnRyeSB3aWxsIGJlIHJlbW92ZWQsDQo+IGJ1dCBpbm9kZSBhbmQgdGhlIGZsYXNo
IHNwYWNlIGl0IG9jY3VwaWVkIHdpbGwgYmUgcmVzZXJ2ZWQuDQo+IFVzZXIgd2lsbCBzZWUgdGhh
dCBtdWNoIGZyZWUgc3BhY2UgYmVlbiBkaXNhcHBlYXJlZC4NCj4gDQo+IFdlIG9ubHkgbmVlZCB0
byBjaGVjayB0aGUgZGVsZXRpb24gdmFsdWUgb2YgdGhlIGZvbGxvd2luZyBpbm9kZSB0eXBlDQo+
IG5vZGUgb2YgdGhlIHJlcGxheSBlbnRyeS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1b2NodW4g
TWFvIDxndW9jaHVuLm1hb0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZnMvdWJpZnMvcmVwbGF5
LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL3ViaWZzL3JlcGxheS5jIGIvZnMvdWJpZnMvcmVw
bGF5LmMNCj4gaW5kZXggMGY4YTZhMTY0MjFiLi4xOTI5ZWM2M2EwY2IgMTAwNjQ0DQo+IC0tLSBh
L2ZzL3ViaWZzL3JlcGxheS5jDQo+ICsrKyBiL2ZzL3ViaWZzL3JlcGxheS5jDQo+IEBAIC0yMjMs
NyArMjIzLDggQEAgc3RhdGljIGJvb2wgaW5vZGVfc3RpbGxfbGlua2VkKHN0cnVjdCB1Ymlmc19p
bmZvICpjLCBzdHJ1Y3QgcmVwbGF5X2VudHJ5ICpyaW5vKQ0KPiAgCSAqLw0KPiAgCWxpc3RfZm9y
X2VhY2hfZW50cnlfcmV2ZXJzZShyLCAmYy0+cmVwbGF5X2xpc3QsIGxpc3QpIHsNCj4gIAkJdWJp
ZnNfYXNzZXJ0KGMsIHItPnNxbnVtID49IHJpbm8tPnNxbnVtKTsNCj4gLQkJaWYgKGtleV9pbnVt
KGMsICZyLT5rZXkpID09IGtleV9pbnVtKGMsICZyaW5vLT5rZXkpKQ0KPiArCQlpZiAoa2V5X2lu
dW0oYywgJnItPmtleSkgPT0ga2V5X2ludW0oYywgJnJpbm8tPmtleSkgJiYNCj4gKwkJICAgIGtl
eV90eXBlKGMsICZyLT5rZXkpID09IFVCSUZTX0lOT19LRVkpDQo+ICAJCQlyZXR1cm4gci0+ZGVs
ZXRpb24gPT0gMDsNCj4gIA0KPiAgCX0NCg0K

