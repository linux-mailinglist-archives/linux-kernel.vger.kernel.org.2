Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9093F28D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhHTJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:08:03 -0400
Received: from esa7.hc324-48.eu.iphmx.com ([207.54.71.126]:8945 "EHLO
        esa7.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbhHTJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:07:59 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 05:07:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1629450441; x=1660986441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G1n+8bgWi/ssCFhnKCSb4Xb7TsSj5f5/9symsjL3PVk=;
  b=drMyAHxcynM6dsFdfVhNHLV9IJbjJgDA4zcYBeZZ0UUsWGPQq2Omb5nU
   d8L1my5obWfco15dHmAS47ko9e3Y1bPoVmMAvW2M5msVuS5RBs+nFIw/s
   DNXBx4HhMKDA1URZNrpOQ6U1pqkKkq+qP8HUELvrD+sKbeNsavkNjTvsf
   o=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 20 Aug 2021 11:00:10 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw3.muc with ESMTP/TLS;
 20 Aug 2021 11:00:10 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp) ([160.48.96.47])
 by esabb2.muc with ESMTP/TLS; 20 Aug 2021 11:00:10 +0200
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10k.europe.bmw.corp
 (160.48.96.47) with Microsoft SMTP Server (TLS;
 Fri, 20 Aug 2021 11:00:09 +0200
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.018; Fri,
 20 Aug 2021 11:00:09 +0200
From:   <Viktor.Rosendahl@bmw.de>
To:     <jing.yangyang@zte.com.cn>, <rostedt@goodmis.org>,
        <cgel.zte@gmail.com>
CC:     <vulab@iscas.ac.cn>, <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>, <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tools/tracing: fix application of sizeof to
 pointer
Thread-Topic: [PATCH linux-next] tools/tracing: fix application of sizeof to
 pointer
Thread-Index: AQHXlYjEnbB5M+F6BEO7WdwWmrco06t79vWA
Date:   Fri, 20 Aug 2021 09:00:09 +0000
Message-ID: <e43ee2b8ed6e69bdda1ab859a4a16bc80bbba8d6.camel@bmw.de>
References: <8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn>
In-Reply-To: <8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D387B9E269704592EBCBE066DD89B7@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFuZ3lhbmcsDQoNCk9uIFRodSwgMjAyMS0wOC0xOSBhdCAyMzowMCAtMDcwMCwgQ0dFTCB3
cm90ZToNCj4gRnJvbTogamluZyB5YW5neWFuZyA8amluZy55YW5neWFuZ0B6dGUuY29tLmNuPg0K
PiANCj4gc2l6ZW9mIHdoZW4gYXBwbGllZCB0byBhIHBvaW50ZXIgdHlwZWQgZXhwcmVzc2lvbiBn
aXZlcyB0aGUgc2l6ZSBvZg0KPiB0aGUgcG9pbnRlci4NCj4gDQo+IC4vdG9vbHMvdHJhY2luZy9s
YXRlbmN5L2xhdGVuY3ktY29sbGVjdG9yLmM6MTU0MToxMC0xNjpFUlJPUiBhcHBsaWNhdGlvbiBv
Zg0KPiBzaXplb2YgdG8gcG9pbnRlcg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgd2l0
aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFplYWwgUm9ib3Qg
PHplYWxjaUB6dGUuY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBqaW5nIHlhbmd5YW5nIDxqaW5n
Lnlhbmd5YW5nQHp0ZS5jb20uY24+DQo+IC0tLQ0KPiAgdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xh
dGVuY3ktY29sbGVjdG9yLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90cmFjaW5nL2xhdGVu
Y3kvbGF0ZW5jeS1jb2xsZWN0b3IuYw0KPiBiL3Rvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5
LWNvbGxlY3Rvci5jDQo+IGluZGV4IDNhMmU2YmIuLjY0ZDUzMWQgMTAwNjQ0DQo+IC0tLSBhL3Rv
b2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jDQo+ICsrKyBiL3Rvb2xzL3Ry
YWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jDQo+IEBAIC0xNTM4LDcgKzE1MzgsNyBA
QCBzdGF0aWMgdm9pZCB0cmFjaW5nX2xvb3Aodm9pZCkNCj4gIAkJCQltdXRleF9sb2NrKCZwcmlu
dF9tdHgpOw0KPiAgCQkJCWNoZWNrX3NpZ25hbHMoKTsNCj4gIAkJCQl3cml0ZV9vcl9kaWUoZmRf
c3Rkb3V0LCBxdWV1ZV9mdWxsX3dhcm5pbmcsDQo+IC0JCQkJCSAgICAgc2l6ZW9mKHF1ZXVlX2Z1
bGxfd2FybmluZykpOw0KPiArCQkJCQkgICAgIHNpemVvZigqcXVldWVfZnVsbF93YXJuaW5nKSk7
DQoNClRoZSBvbGQgY29kZSB3b3VsZCBnaXZlIGEgc2l6ZSBvZiA4LCBpLmUuIHRoZSBzaXplIG9m
IHRoZSBwb2ludGVyLiBZb3VyDQpzdWdnZXN0aW9uIHdpbGwgZ2l2ZSBhIHNpemUgb2YgMSwgaS5l
LiB0aGUgc2l6ZSBvZiB0aGUgZmlyc3QgY2hhcmFjdGVyIG9mIHRoZQ0KZXJyb3IgbWVzc2FnZS4g
U28gaW5zdGVhZCBvZiBvdXB1dGluZyAiQ291bGQgbm8iIHdlIHdvdWxkIG9ubHkgd3JpdGUgb3V0
ICJDIi4NCg0KV2hhdCB3ZSB3YW50IGlzIHRoZSBsZW5ndGggb2YgdGhlIGVycm9yIG1lc3NhZ2Uu
IFRoaXMgY291bGQgYmUgYWNoaWV2ZWQgaW4gdHdvDQp3YXlzOg0KDQoxLiBCeSBjaGFuZ2luZyB0
aGUgc2l6ZW9mKHF1ZXVlX2Z1bGxfd2FybmluZykgdG8gc3RybGVuKHF1ZXVlX2Z1bGxfd2Fybmlu
ZykuDQoNCjIuIEJ5IGNoYW5naW5nIHRoZSBkZWZpbml0aW9uIG9mIHF1ZXVlX2Z1bGxfd2Fybmlu
ZyB0byBiZSBhbiBhcnJheSwgaW4gdGhhdCBjYXNlDQp3ZSB3b3VsZCBsaWtlIHRvIHVzZSBzaXpl
b2YocXVldWVfZnVsbF93YXJuaW5nKSAtIDEsIHRoZSAiLSAxIiBjb21lcyBmcm9tIHRoZQ0KZmFj
dCB0aGF0IHdlIGRvbid0IHdhbnQgdG8gd3JpdGUgb3V0IHRoZSB0ZXJtaW5hdGluZyBudWxsIGNo
YXJhY3Rlci4NCg0KSSB0aGluayB0aGUgZmlyc3QgYXBwcm9hY2ggd2l0aCBzdHJsZW4oKSBpcyB0
aGUgYmV0dGVyIHNvbHV0aW9uIGJlY2F1c2UgaXQncw0Kc2hvcnRlciBhbmQgbW9kZXJuIGNvbXBp
bGVycyB3aWxsIGRvIHRoZSBzdHJsZW4oKSBjYWxjdWxhdGlvbiBvZiBjb25zdGFudA0Kc3RyaW5n
cyBhdCBjb21waWxlIHRpbWUgYW55d2F5Lg0KDQpiZXN0IHJlZ2FyZHMsDQoNClZpa3RvciANCg0K
DQo+ICAJCQkJbXV0ZXhfdW5sb2NrKCZwcmludF9tdHgpOw0KPiAgCQkJfQ0KPiAgCQkJbW9kaWZp
ZWQtLTsNCg==
