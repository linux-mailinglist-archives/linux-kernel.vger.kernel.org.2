Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3926031CDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBPQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:25:12 -0500
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119]:47058 "EHLO
        esa1.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhBPQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:25:08 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 11:25:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1613492707; x=1645028707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9oEG2z5u3V95BKMG5vyexn2wShlVqEN0j0D1UF1bkGc=;
  b=mKUWcMze4vZ2X+J/rPuaRCnYPMKCjQE4h1ltjnumX80eYvLSKNKQwfN4
   6LSxNlNT+dzkeo0Yc1GAUadPTgF4Mp3RBNx2h2DbbqIILx6+GAttKQlhb
   ZN+cdzjpo+U/sC1YaoWSBMSqFtxxP7eIIbSGAnLv/p0Ouu4HDDs0xSumR
   g=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 16 Feb 2021 17:16:42 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
 16 Feb 2021 17:16:42 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb2.muc with ESMTP/TLS; 16 Feb 2021 17:16:42 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Tue, 16 Feb 2021 17:16:42 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.010; Tue,
 16 Feb 2021 17:16:42 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <rostedt@goodmis.org>, <colin.king@canonical.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH][next][V3] tracing/tools: fix a couple of
 spelling mistakes
Thread-Topic: [EXTERNAL] [PATCH][next][V3] tracing/tools: fix a couple of
 spelling mistakes
Thread-Index: AQHXBHimQNQZ/SyPYUCVig0MMizfNKpa5IOA
Date:   Tue, 16 Feb 2021 16:16:42 +0000
Message-ID: <c7bd56b83ac50ffb3a3b3bfad58cde8bf1d24cfa.camel@bmw.de>
References: <20210216153023.163488-1-colin.king@canonical.com>
In-Reply-To: <20210216153023.163488-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6755ACBD5A69D4A8695B66F59CF54DB@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBsb29rcyBnb29kIHRvIG1lLg0KDQpiZXN0IHJlZ2FyZHMsDQoNClZpa3Rvcg0KDQpPbiBU
dWUsIDIwMjEtMDItMTYgYXQgMTU6MzAgKzAwMDAsIENvbGluIEtpbmcgd3JvdGU6DQo+IEVYVEVS
TkFMIFNFTkRFUiAtIGJlIENBVVRJT1VTLCBwYXJ0aWN1bGFybHkgd2l0aCBsaW5rcyBhbmQgYXR0
YWNobWVudHMuIA0KPiBFWFRFUk5FUiBBYnNlbmRlciAtIEJpdHRlIFZPUlNJQ0hUIGJlaW0gw5Zm
Zm5lbiB2b24gTGlua3MgdW5kIEFuaMOkbmdlbi4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAtLS0tLS0tLS0tLS0NCj4gDQo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+DQo+IA0KPiBUaGVyZSBpcyBhIHNwZWxsaW5nIG1pc3Rha2UgaW4gdGhlIC1n
IGhlbHAgb3B0aW9uLCBJIGJlbGlldmUNCj4gaXQgc2hvdWxkIGJlICJncmFwaCIuICBUaGVyZSBp
cyBhbHNvIGEgc3BlbGxpbmcgbWlzdGFrZSBpbiBhDQo+IHdhcm5pbmcgbWVzc2FnZS4gRml4IGJv
dGggbWlzdGFrZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4u
a2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gDQo+IFYyOiBBbHNvIGZpeCAibnVtbWVyIiBz
cGVsbGluZyBtaXN0YWtlLg0KPiBWMzogcmUtZm9ybWF0IHRleHQsIGFzIHN1Z2dlc3RlZCBieSBW
aWt0b3INCj4gDQo+IC0tLQ0KPiAgdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVj
dG9yLmMgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90cmFjaW5nL2xhdGVuY3kvbGF0
ZW5jeS1jb2xsZWN0b3IuYw0KPiBiL3Rvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxl
Y3Rvci5jDQo+IGluZGV4IDU3YjIwODAyZTcxYi4uYjY5ZGU5MjYzZWU2IDEwMDY0NA0KPiAtLS0g
YS90b29scy90cmFjaW5nL2xhdGVuY3kvbGF0ZW5jeS1jb2xsZWN0b3IuYw0KPiArKysgYi90b29s
cy90cmFjaW5nL2xhdGVuY3kvbGF0ZW5jeS1jb2xsZWN0b3IuYw0KPiBAQCAtMTY1MCw3ICsxNjUw
LDcgQEAgc3RhdGljIHZvaWQgc3RhcnRfcHJpbnR0aHJlYWQodm9pZCkNCj4gIAkJaWYgKHVmZCA8
ICAwIHx8DQo+ICAJCSAgICByZWFkKHVmZCwgc2VlZCwgc2l6ZW9mKCpzZWVkKSkgIT0gc2l6ZW9m
KCpzZWVkKSkgew0KPiAgCQkJcHJpbnRmKA0KPiAtIldhcm5pbmchIFVzaW5nIHRyaXZpYWwgcmFu
ZG9tIG51bW1lciBzZWVkLCBzaW5jZSAlcyBub3QgYXZhaWxhYmxlXG4iLA0KPiArIldhcm5pbmch
IFVzaW5nIHRyaXZpYWwgcmFuZG9tIG51bWJlciBzZWVkLCBzaW5jZSAlcyBub3QgYXZhaWxhYmxl
XG4iLA0KPiAgCQkJREVWX1VSQU5ET00pOw0KPiAgCQkJZmZsdXNoKHN0ZG91dCk7DQo+ICAJCQkq
c2VlZCA9IGk7DQo+IEBAIC0xNzExLDggKzE3MTEsOCBAQCBzdGF0aWMgdm9pZCBzaG93X3VzYWdl
KHZvaWQpDQo+ICAiXHRcdFx0YmVnaW5uaW5nLCBlbmQsIGFuZCBiYWNrdHJhY2UuXG5cbiINCj4g
IA0KPiAgIi1nLCAtLWdyYXBoXHRcdEVuYWJsZSB0aGUgZGlzcGxheS1ncmFwaCBvcHRpb24gaW4g
dHJhY2Vfb3B0aW9uLiBUaGlzXG4iDQo+IC0iXHRcdFx0b3B0aW9uIGNhdXNlcyBmdHJhY2UgdG8g
c2hvdyB0aGUgZnVuY3Rpb25waCBvZiBob3dcbiINCj4gLSJcdFx0XHRmdW5jdGlvbnMgYXJlIGNh
bGxpbmcgb3RoZXIgZnVuY3Rpb25zLlxuXG4iDQo+ICsiXHRcdFx0b3B0aW9uIGNhdXNlcyBmdHJh
Y2UgdG8gc2hvdyB0aGUgZ3JhcGggb2YgaG93IGZ1bmN0aW9uc1xuIg0KPiArIlx0XHRcdGFyZSBj
YWxsaW5nIG90aGVyIGZ1bmN0aW9ucy5cblxuIg0KPiAgDQo+ICAiLWMsIC0tcG9saWN5IFBPTFx0
UnVuIHRoZSBwcm9ncmFtIHdpdGggc2NoZWR1bGluZyBwb2xpY3kgUE9MLiBQT0wgY2FuIGJlXG4i
DQo+ICAiXHRcdFx0b3RoZXIsIGJhdGNoLCBpZGxlLCByciBvciBmaWZvLiBUaGUgZGVmYXVsdCBp
cyByci4gV2hlblxuIg0K
