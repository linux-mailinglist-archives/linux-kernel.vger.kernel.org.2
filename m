Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6774F32E6B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:49:44 -0500
Received: from esa13.hc324-48.eu.iphmx.com ([207.54.72.35]:9892 "EHLO
        esa13.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhCEKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:49:28 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 05:49:27 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1614941367; x=1646477367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Uk681H9zLfwid+oUuqt0hWrsjG3K9a7+tpJ87FhlTM=;
  b=AxYK+AZZTpeb9l0GIJl2dt0Tr4uJRyNpbOCD8bAP4Qg2b6b0qw3OqwW1
   WiRqJpf+6UXNW9OIIekXUywDZ733k83n6jtpH1biFtIRQE92iWFW+RmTM
   VWNjfvPyFLBN3Y7LTiMFgD9M6bvUd41wU2a7gJnEPIDaxf+QkuhOcekah
   U=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 05 Mar 2021 11:42:13 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw1.muc with ESMTP/TLS;
 05 Mar 2021 11:42:12 +0100
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp) ([160.48.96.46])
 by esabb6.muc with ESMTP/TLS; 05 Mar 2021 11:42:08 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10j.europe.bmw.corp
 (160.48.96.46) with Microsoft SMTP Server (TLS;
 Fri, 5 Mar 2021 11:42:08 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.010; Fri, 5
 Mar 2021 11:42:08 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <vulab@iscas.ac.cn>
CC:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: Re: [PATCH] tracing/tools: Remove unneeded semicolon
Thread-Topic: [PATCH] tracing/tools: Remove unneeded semicolon
Thread-Index: AQHXEaOOxul1Ngk1pUujXyzKeVa/nKp1JFYA
Date:   Fri, 5 Mar 2021 10:42:08 +0000
Message-ID: <480322830b8aa400f4293e635184a31d392e4dad.camel@bmw.de>
References: <20210305094005.1724-1-vulab@iscas.ac.cn>
In-Reply-To: <20210305094005.1724-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <039DF0235365FF4CB20B3AD32AFA9D21@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDA5OjQwICswMDAwLCBYdSBXYW5nIHdyb3RlOg0KPiBmaXgg
c2VtaWNvbG9uLmNvY2NpIHdhcm5pbmc6DQo+IHRvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5
LWNvbGxlY3Rvci5jOjEwMjE6Mi0zOiBVbm5lZWRlZCBzZW1pY29sb24NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFh1IFdhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KPiAtLS0NCj4gIHRvb2xzL3RyYWNp
bmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVjdG9yLmMNCj4gYi90b29scy90cmFjaW5nL2xh
dGVuY3kvbGF0ZW5jeS1jb2xsZWN0b3IuYw0KPiBpbmRleCBiNjlkZTkyNjNlZTYuLjEyOWZiMDBi
NzBjMiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVj
dG9yLmMNCj4gKysrIGIvdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVjdG9yLmMN
Cj4gQEAgLTEwMTgsNyArMTAxOCw3IEBAIHN0YXRpYyBsb25nIGdvX3RvX3NsZWVwKGNvbnN0IHN0
cnVjdCBlbnRyeSAqcmVxKQ0KPiAgCQljb25kX3RpbWVkd2FpdCgmcHJpbnRzdGF0ZS5jb25kLCAm
cHJpbnRzdGF0ZS5tdXRleCwgJmZ1dHVyZSk7DQo+ICAJCWlmICh0aW1lX2hhc19wYXNzZWQoJmZ1
dHVyZSkpDQo+ICAJCQlicmVhazsNCj4gLQl9Ow0KPiArCX0NCj4gIA0KPiAgCWlmIChwcmludHN0
YXRlX2hhc19uZXdfcmVxX2Fycml2ZWQocmVxKSkNCj4gIAkJZGVsYXkgPSAtMTsNCg0KTG9va3Mg
Z29vZCBidXQgSSB3b3VsZCBzdWdnZXN0IHRvIGZpeCBhbHNvIHRoZSBvdGhlciBpbnN0YW5jZXMg
b2Ygc3VwZXJmbHVvdXMNCnNlbWljb2xvbnMgd2l0aCB0aGUgc2FtZSBwYXRjaC4NCg0KVGhlcmUg
c2VlbXMgdG8gYmUgYSBsb25lbHkgc2VtaWNvbG9uIG9uIGxpbmUgMTk0NCwgaS5lIHRoaXMgY29k
ZToNCg0KCQkJaWYgKHZhbHVlIDwgMCkgew0KCQkJCXdhcm54KCJUSU1FIG11c3QgYmUgPj0gMFxu
Iik7DQoJCQkJc2hvd191c2FnZSgpOw0KCQkJCTsNCgkJCX0NCg0KSW4gdGhhdCBjYXNlIHRoZSBs
b25lbHkgc2VtaWNvbG9uIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoICJleGl0KDApOyINCg0KYmVz
dCByZWdhcmRzLA0KDQpWaWt0b3INCg==
