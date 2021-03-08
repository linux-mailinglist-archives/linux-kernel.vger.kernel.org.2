Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63D330CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCHLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:47:57 -0500
Received: from esa13.hc324-48.eu.iphmx.com ([207.54.72.35]:9070 "EHLO
        esa13.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhCHLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:47:37 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 06:47:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1615204057; x=1646740057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+p9IWCunoTrr9/xJ38j2a8VI1ljw2vTyO4nTrLBSoE=;
  b=enFQXbri9oQPO0kmApeAiaCNaOKENRgpGpIX3nd1CIY9BbiJfxv6RcwW
   l8A/iPnX/Nl1Q14n5L9js/KDo2b0Cp5UQa+iiqVM4bICmo3WfhwQ0eTjQ
   QmbOf9Zyn2RaZXUaWS6nRvuUjp68w+6DicENqGfdxVVJ61keYbkdiSlw+
   o=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 08 Mar 2021 12:40:22 +0100
Received: from esabb4.muc ([160.50.100.33])  by esagw3.muc with ESMTP/TLS;
 08 Mar 2021 12:40:02 +0100
Received: from smucm10l.bmwgroup.net (HELO smucm10l.europe.bmw.corp) ([160.48.96.48])
 by esabb4.muc with ESMTP/TLS; 08 Mar 2021 12:40:01 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10l.europe.bmw.corp
 (160.48.96.48) with Microsoft SMTP Server (TLS;
 Mon, 8 Mar 2021 12:40:01 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.012; Mon, 8
 Mar 2021 12:40:01 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <vulab@iscas.ac.cn>, <rostedt@goodmis.org>,
        <colin.king@canonical.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/tools: Remove unneeded semicolon
Thread-Topic: [PATCH v2] tracing/tools: Remove unneeded semicolon
Thread-Index: AQHXE8JE0HqM5vMds0eu76gkin2xiap550OA
Date:   Mon, 8 Mar 2021 11:40:01 +0000
Message-ID: <f0c93539788a342f68d7cb16bab3290f66e61915.camel@bmw.de>
References: <20210308022459.59881-1-vulab@iscas.ac.cn>
In-Reply-To: <20210308022459.59881-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <59E260A687D6874C9220AB7679182603@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTA4IGF0IDAyOjI0ICswMDAwLCBYdSBXYW5nIHdyb3RlOg0KPiBmaXgg
c2VtaWNvbG9uLmNvY2NpIHdhcm5pbmc6DQo+IHRvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5
LWNvbGxlY3Rvci5jOjEwMjE6Mi0zOiBVbm5lZWRlZCBzZW1pY29sb24NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFh1IFdhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KDQpSZXZpZXdlZC1ieTogVmlrdG9y
IFJvc2VuZGFobCA8VmlrdG9yLlJvc2VuZGFobEBibXcuZGU+DQoNCj4gLS0tDQo+IENoYW5nZXMg
c2luY2UgdjI6DQo+IC0gRml4IGFub3RoZXIgaW5zdGFuY2Ugb2Ygc3VwZXJmbHVvdXMgc2VtaWNv
bG9uLg0KPiAtLS0NCj4gIHRvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5j
IHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNv
bGxlY3Rvci5jDQo+IGIvdG9vbHMvdHJhY2luZy9sYXRlbmN5L2xhdGVuY3ktY29sbGVjdG9yLmMN
Cj4gaW5kZXggYjY5ZGU5MjYzZWU2Li4zYTJlNmJiNzgxYTggMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3RyYWNpbmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jDQo+ICsrKyBiL3Rvb2xzL3RyYWNp
bmcvbGF0ZW5jeS9sYXRlbmN5LWNvbGxlY3Rvci5jDQo+IEBAIC0xMDE4LDcgKzEwMTgsNyBAQCBz
dGF0aWMgbG9uZyBnb190b19zbGVlcChjb25zdCBzdHJ1Y3QgZW50cnkgKnJlcSkNCj4gIAkJY29u
ZF90aW1lZHdhaXQoJnByaW50c3RhdGUuY29uZCwgJnByaW50c3RhdGUubXV0ZXgsICZmdXR1cmUp
Ow0KPiAgCQlpZiAodGltZV9oYXNfcGFzc2VkKCZmdXR1cmUpKQ0KPiAgCQkJYnJlYWs7DQo+IC0J
fTsNCj4gKwl9DQo+ICANCj4gIAlpZiAocHJpbnRzdGF0ZV9oYXNfbmV3X3JlcV9hcnJpdmVkKHJl
cSkpDQo+ICAJCWRlbGF5ID0gLTE7DQo+IEBAIC0xOTQxLDcgKzE5NDEsNyBAQCBzdGF0aWMgdm9p
ZCBzY2FuX2FyZ3VtZW50cyhpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgCQkJaWYgKHZhbHVl
IDwgMCkgew0KPiAgCQkJCXdhcm54KCJUSU1FIG11c3QgYmUgPj0gMFxuIik7DQo+ICAJCQkJc2hv
d191c2FnZSgpOw0KPiAtCQkJCTsNCj4gKwkJCQlleGl0KDApOw0KPiAgCQkJfQ0KPiAgCQkJdHJh
Y2VfZW5hYmxlID0gdHJ1ZTsNCj4gIAkJCXVzZV9yYW5kb21fc2xlZXAgPSB0cnVlOw0KDQpiZXN0
IHJlZ2FyZHMsDQoNClZpa3Rvcg0K
