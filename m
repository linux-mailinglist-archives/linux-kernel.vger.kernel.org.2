Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37B842A2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhJLLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:15:13 -0400
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119]:47772 "EHLO
        esa1.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232475AbhJLLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:15:12 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 07:15:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1634037191; x=1665573191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JFHujRfy3lQPEZua4JS1l/cIcnmT07COSgKpp4kKWBg=;
  b=FfrTCGV07W1xII0UR+hPZY+yAy2NoOtHe9/nctkhcSf2y8eSq9pnbcdW
   iLU6ggDBJRPzEJTKuDWfkpHBqSS1yFVX4ZeN42ZP8oZDZ9PH/ch15Ghh0
   vDYpFS6I1A9iZH3WuraU0CFWr1U3r0vZlSVf5Ymo1IYV5pHPDvmMteMrl
   k=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 12 Oct 2021 13:06:02 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw6.muc with ESMTP/TLS;
 12 Oct 2021 13:05:58 +0200
Received: from smucm10k.bmwgroup.net (HELO smucm10k.europe.bmw.corp) ([160.48.96.47])
 by esabb4.muc with ESMTP/TLS; 12 Oct 2021 13:05:57 +0200
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10k.europe.bmw.corp
 (160.48.96.47) with Microsoft SMTP Server (TLS;
 Tue, 12 Oct 2021 13:05:57 +0200
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.018; Tue,
 12 Oct 2021 13:05:57 +0200
From:   <Viktor.Rosendahl@bmw.de>
To:     <rostedt@goodmis.org>, <davidcomponentone@gmail.com>
CC:     <vulab@iscas.ac.cn>, <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>, <zealci@zte.com.cn>
Subject: Re: [PATCH] Fix application of sizeof to pointer
Thread-Topic: [PATCH] Fix application of sizeof to pointer
Thread-Index: AQHXvxSBTT5nPxY6VkyBsniCij/TUKvOjKKAgACF8AA=
Date:   Tue, 12 Oct 2021 11:05:57 +0000
Message-ID: <5941214abba2a844472a257d9bf068c2efb1f879.camel@bmw.de>
References: <20211012025424.180781-1-davidcomponentone@gmail.com>
         <20211011230633.262b54a5@oasis.local.home>
In-Reply-To: <20211011230633.262b54a5@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D2D040D38CC24B8274A97B672B5CC8@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTExIGF0IDIzOjA2IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVHVlLCAxMiBPY3QgMjAyMSAxMDo1NDoyNCArMDgwMA0KPiBkYXZpZGNvbXBvbmVudG9u
ZUBnbWFpbC5jb20gd3JvdGU6DQo+IA0KPiA+IEZyb206IERhdmlkIFlhbmcgPGRhdmlkY29tcG9u
ZW50b25lQGdtYWlsLmNvbT4NCj4gPiANCj4gPiBUaGUgY29jY2luZWxsZSBjaGVjayByZXBvcnQ6
DQo+ID4gIi4vdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVjdG9yLmM6MTU0MTox
MC0xNjoNCj4gPiBFUlJPUjogYXBwbGljYXRpb24gb2Ygc2l6ZW9mIHRvIHBvaW50ZXIiDQo+ID4g
VXNpbmcgdGhlICJzdHJsZW4iIHRvIGZpeCBpdC4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogWmVh
bCBSb2JvdCA8emVhbGNpQHp0ZS5jb20uY24+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgWWFu
ZyA8ZGF2aWRjb21wb25lbnRvbmVAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy90cmFj
aW5nL2xhdGVuY3kvbGF0ZW5jeS1jb2xsZWN0b3IuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jDQo+ID4gYi90b29scy90
cmFjaW5nL2xhdGVuY3kvbGF0ZW5jeS1jb2xsZWN0b3IuYw0KPiA+IGluZGV4IDNhMmU2YmI3ODFh
OC4uYjEzMTAwN2U2YzcwIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3RyYWNpbmcvbGF0ZW5jeS9s
YXRlbmN5LWNvbGxlY3Rvci5jDQo+ID4gKysrIGIvdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVu
Y3ktY29sbGVjdG9yLmMNCj4gPiBAQCAtMTUzOCw3ICsxNTM4LDcgQEAgc3RhdGljIHZvaWQgdHJh
Y2luZ19sb29wKHZvaWQpDQo+ID4gIAkJCQltdXRleF9sb2NrKCZwcmludF9tdHgpOw0KPiA+ICAJ
CQkJY2hlY2tfc2lnbmFscygpOw0KPiA+ICAJCQkJd3JpdGVfb3JfZGllKGZkX3N0ZG91dCwgcXVl
dWVfZnVsbF93YXJuaW5nLA0KPiA+IC0JCQkJCSAgICAgc2l6ZW9mKHF1ZXVlX2Z1bGxfd2Fybmlu
ZykpOw0KPiA+ICsJCQkJCSAgICAgc3RybGVuKHF1ZXVlX2Z1bGxfd2FybmluZykgKyAxKTsNCj4g
DQo+IFJlYWxseSwgdGhlICsxLCBhbHRob3VnaCB3b3VsZCBtYXRjaCBpZiBxdWV1ZV9mdWxsX3dh
cm5pbmcgd2FzIGFuDQo+IGFycmF5LCBidXQgaW4gdGhpcyB1c2UgY2FzZSwgdGhlcmUncyBubyBy
ZWFzb24gdG8gcGFzcyB0aGUgbnVsDQo+IGNoYXJhY3RlciB0byB0aGUgd3JpdGUuDQoNCkkgYWdy
ZWUgdGhhdCB0aGUgKzEgc2hvdWxkIG5vdCBiZSB0aGVyZSBiZWNhdXNlIHRoZSBudWxsIGNoYXJh
Y3RlciB3b3VsZCBlbmQgdXANCmluIHRoZSBvdXRwdXQ7IHdyaXRlIHdpbGwgbm90IGlnbm9yZSBp
dC4gSXQgY291bGQgYmUgY29uZnVzaW5nIGlmIHRoZSBvdXRwdXQNCndvdWxkIGJlIGJlIHByb2Nl
c3NlZCBieSBhbm90aGVyIHByb2dyYW0uDQoNCmJlc3QgcmVnYXJkcywNCg0KVmlrdG9yDQoNCj4g
DQo+IC0tIFN0ZXZlDQo+IA0KPiANCj4gPiAgCQkJCW11dGV4X3VubG9jaygmcHJpbnRfbXR4KTsN
Cj4gPiAgCQkJfQ0KPiA+ICAJCQltb2RpZmllZC0tOw0K
