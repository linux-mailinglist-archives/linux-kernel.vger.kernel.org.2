Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07631CCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhBPPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:19:40 -0500
Received: from esa6.hc324-48.eu.iphmx.com ([207.54.71.69]:25868 "EHLO
        esa6.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhBPPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:19:35 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 10:19:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1613488775; x=1645024775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tPSLFw/CyQ8Jly77v8wfyVnxBocD9UPp4vZzyS05VVc=;
  b=DWxrYUou53tFthm975LinY45clIEDlIt1CjJgBWBkU09/rAAaBFjHza4
   hPevTahqPnny0QNo+Y+XOc8ud9E0T1iswbZwwmUIRaoqC71xrQ7W1oGGj
   fXoyYB4oJP5HnIOqtWQRHT2Pe7OE79o+4KstITs8EiMGh25veL1LJ/nuc
   8=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 16 Feb 2021 16:11:07 +0100
Received: from esabb5.muc ([160.50.100.47])  by esagw3.muc with ESMTP/TLS;
 16 Feb 2021 16:10:55 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb5.muc with ESMTP/TLS; 16 Feb 2021 16:10:55 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Tue, 16 Feb 2021 16:10:55 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.010; Tue,
 16 Feb 2021 16:10:55 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <colin.king@canonical.com>
CC:     <rostedt@goodmis.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/tools: fix a couple of spelling mistakes
Thread-Topic: [PATCH] tracing/tools: fix a couple of spelling mistakes
Thread-Index: AQHXBHXsW67nQO2JSk2CuqB8wOiyGg==
Date:   Tue, 16 Feb 2021 15:10:55 +0000
Message-ID: <d2b31974527bc27cda4272e16ed40575ddc9764a.camel@bmw.de>
References: <20210216140844.160499-1-colin.king@canonical.com>
In-Reply-To: <20210216140844.160499-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <814E42483CD13440818D43E63C72276A@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgZmluZGluZyB0aGVzZSBtaXN0YWtlcy4NCg0KT24gVHVlLCAyMDIx
LTAyLTE2IGF0IDE0OjA4ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KDQo+ICAJCQlwcmludGYo
DQo+IC0iV2FybmluZyEgVXNpbmcgdHJpdmlhbCByYW5kb20gbnVtbWVyIHNlZWQsIHNpbmNlICVz
IG5vdCBhdmFpbGFibGVcbiIsDQo+ICsiV2FybmluZyEgVXNpbmcgdHJpdmlhbCByYW5kb20gbnVt
YmVyIHNlZWQsIHNpbmNlICVzIG5vdCBhdmFpbGFibGVcbiIsDQo+ICAJCQlERVZfVVJBTkRPTSk7
DQo+ICAJCQlmZmx1c2goc3Rkb3V0KTsNCj4gIAkJCSpzZWVkID0gaTsNCj4gQEAgLTE3MTEsNyAr
MTcxMSw3IEBAIHN0YXRpYyB2b2lkIHNob3dfdXNhZ2Uodm9pZCkNCj4gICJcdFx0XHRiZWdpbm5p
bmcsIGVuZCwgYW5kIGJhY2t0cmFjZS5cblxuIg0KPiAgDQo+ICAiLWcsIC0tZ3JhcGhcdFx0RW5h
YmxlIHRoZSBkaXNwbGF5LWdyYXBoIG9wdGlvbiBpbiB0cmFjZV9vcHRpb24uIFRoaXNcbiINCj4g
LSJcdFx0XHRvcHRpb24gY2F1c2VzIGZ0cmFjZSB0byBzaG93IHRoZSBmdW5jdGlvbnBoIG9mIGhv
d1xuIg0KPiArIlx0XHRcdG9wdGlvbiBjYXVzZXMgZnRyYWNlIHRvIHNob3cgdGhlIGdyYXBoIG9m
IGhvd1xuIg0KPiAgIlx0XHRcdGZ1bmN0aW9ucyBhcmUgY2FsbGluZyBvdGhlciBmdW5jdGlvbnMu
XG5cbiINCg0KVGhpcyBpcyBhIGxhcmdlIGltcHJvdmVtZW50IGJ1dCBzaW5jZSB0aGUgY29ycmVj
dGVkIHdvcmQgaXMgc28gbXVjaCBzaG9ydGVyLCB3ZQ0Kd291bGQgaWRlYWxseSBtb3ZlIHRoZSBm
aXJzdCB3b3JkIG9mIHRoZSBuZXh0IGxpbmUgdG8gdGhpcyBsaW5lIGFzIHdlbGw6DQoNCiJcdFx0
XHRvcHRpb24gY2F1c2VzIGZ0cmFjZSB0byBzaG93IHRoZSBncmFwaCBvZiBob3cgZnVuY3Rpb25z
XG4iDQoiXHRcdFx0YXJlIGNhbGxpbmcgb3RoZXIgZnVuY3Rpb25zLlxuXG4iDQoNCmJlc3QgcmVn
YXJkcywNCg0KVmlrdG9yDQoNCj4gIA0KPiAgIi1jLCAtLXBvbGljeSBQT0xcdFJ1biB0aGUgcHJv
Z3JhbSB3aXRoIHNjaGVkdWxpbmcgcG9saWN5IFBPTC4gUE9MIGNhbiBiZVxuIg0K
