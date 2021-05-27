Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466A1392AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhE0Jpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:45:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4646 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235675AbhE0Jp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:45:29 -0400
X-UUID: 232c1ff5b927472e82519f19ecc6fa2a-20210527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UG82Zx0u8Lp+Mb9aUfFVOp7l7pjVcgLf+byTViN+wmc=;
        b=oN3ywjZGK0TB4wa5gno7fljOMEQZzvm6dFf7qLxihlyyYSnLAO9zhsbW8y9HQAJDMYTmHqJ+wJDvniNWVo5g8RmnC4IoiYJpyICvMJq0TaAtxwv44D7XNybWAm0/B+iKLrW6AwW8OxIYv/H+IJUmfDmMR0cTAvUTL+upJFd96u8=;
X-UUID: 232c1ff5b927472e82519f19ecc6fa2a-20210527
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 838898830; Thu, 27 May 2021 17:43:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 17:43:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 May 2021 17:43:39 +0800
Message-ID: <1622108619.5918.3.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: common: add helper to get
 role-switch-default-mode
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 27 May 2021 17:43:39 +0800
In-Reply-To: <YK9KG5c96VmdHfF3@kroah.com>
References: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
         <1621933165-9661-2-git-send-email-chunfeng.yun@mediatek.com>
         <YK9KG5c96VmdHfF3@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E3B543BEFB4730A1515935146F529F28626AA0ABC9D3B9CAB6FCA92BBBE1221B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTI3IGF0IDA5OjI4ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDA0OjU5OjI0UE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBBZGQgaGVscGVyIHRvIGdldCAicm9sZS1zd2l0Y2gtZGVmYXVsdC1t
b2RlIiwgYW5kIGNvbnZlcnQgaXQNCj4gPiB0byB0aGUgY29ycmVzcG9uZGluZyBlbnVtIHVzYl9k
cl9tb2RlDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55
dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9jb21tb24vY29tbW9u
LmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3VzYi9vdGcu
aCAgICAgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jb21tb24vY29tbW9uLmMgYi9kcml2ZXJz
L3VzYi9jb21tb24vY29tbW9uLmMNCj4gPiBpbmRleCBmZmYzMTg1OTczMzcuLjc4YTYyNWE0ZTUy
NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jb21tb24vY29tbW9uLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3VzYi9jb21tb24vY29tbW9uLmMNCj4gPiBAQCAtMjA3LDYgKzIwNywyNiBAQCBl
bnVtIHVzYl9kcl9tb2RlIHVzYl9nZXRfZHJfbW9kZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4g
IH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX2dldF9kcl9tb2RlKTsNCj4gPiAgDQo+ID4g
Ky8qKg0KPiA+ICsgKiB1c2JfZ2V0X3JvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZSAtIEdldCBkZWZh
dWx0IG1vZGUgZm9yIGdpdmVuIGRldmljZQ0KPiA+ICsgKiBAZGV2OiBQb2ludGVyIHRvIHRoZSBn
aXZlbiBkZXZpY2UNCj4gPiArICoNCj4gPiArICogVGhlIGZ1bmN0aW9uIGdldHMgc3RyaW5nIGZy
b20gcHJvcGVydHkgJ3JvbGUtc3dpdGNoLWRlZmF1bHQtbW9kZScsDQo+ID4gKyAqIGFuZCByZXR1
cm5zIHRoZSBjb3JyZXNwb25kaW5nIGVudW0gdXNiX2RyX21vZGUuDQo+ID4gKyAqLw0KPiA+ICtl
bnVtIHVzYl9kcl9tb2RlIHVzYl9nZXRfcm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJY29uc3QgY2hhciAqc3RyOw0KPiA+ICsJaW50IHJl
dDsNCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LCAi
cm9sZS1zd2l0Y2gtZGVmYXVsdC1tb2RlIiwgJnN0cik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4g
PiArCQlyZXR1cm4gVVNCX0RSX01PREVfVU5LTk9XTjsNCj4gPiArDQo+ID4gKwlyZXR1cm4gdXNi
X2dldF9kcl9tb2RlX2Zyb21fc3RyaW5nKHN0cik7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJP
TF9HUEwodXNiX2dldF9yb2xlX3N3aXRjaF9kZWZhdWx0X21vZGUpOw0KPiA+ICsNCj4gPiAgLyoq
DQo+ID4gICAqIHVzYl9kZWNvZGVfaW50ZXJ2YWwgLSBEZWNvZGUgYkludGVydmFsIGludG8gdGhl
IHRpbWUgZXhwcmVzc2VkIGluIDF1cyB1bml0DQo+ID4gICAqIEBlcGQ6IFRoZSBkZXNjcmlwdG9y
IG9mIHRoZSBlbmRwb2ludA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9vdGcu
aCBiL2luY2x1ZGUvbGludXgvdXNiL290Zy5oDQo+ID4gaW5kZXggYTg2ZWU2YWFkNTFiLi5iZGUz
MTNjOTdmYjYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC91c2Ivb3RnLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3VzYi9vdGcuaA0KPiA+IEBAIC0xMjEsNSArMTIxLDYgQEAgZW51
bSB1c2JfZHJfbW9kZSB7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBleHRlcm4gZW51bSB1c2JfZHJf
bW9kZSB1c2JfZ2V0X2RyX21vZGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiArZXh0ZXJuIGVu
dW0gdXNiX2RyX21vZGUgdXNiX2dldF9yb2xlX3N3aXRjaF9kZWZhdWx0X21vZGUoc3RydWN0IGRl
dmljZSAqZGV2KTsNCj4gDQo+IFdoYXQgb3RoZXIgY29kZSBvdXRzaWRlIG9mIHRoZSBkd2MzIGRy
aXZlciB3aWxsIGV2ZXIgbmVlZCB0byBjYWxsIHRoaXM/DQpJIHByZXBhcmUgYSBzZXJpZXMgb2Yg
cGF0aGVzIGZvciBtdHUzLCBhbmQgd2lsbCBzdXBwb3J0DQoicm9sZS1zd2l0Y2gtZGVmYXVsdC1t
b2RlIiBwcm9wZXJ0eQ0KDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=

