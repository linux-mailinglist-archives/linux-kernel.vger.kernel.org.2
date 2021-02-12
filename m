Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C4319E67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBLM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:27:01 -0500
Received: from esa10.hc324-48.eu.iphmx.com ([207.54.69.29]:21087 "EHLO
        esa10.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231404AbhBLMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:24:42 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 07:24:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1613132680; x=1644668680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q2ILbveFPLz1kfsVZPj8BUm7jvcrKNtYx5G1zL94pIM=;
  b=GG2epcITr1T6tTEY192GcJb7Q1xsjFIBN/7yDWVR+tdHmBUZlZQKw301
   YUrAQqJ8BE9+BqpP6u5iuKWEphSkej9SaeV15qEnBOEqSRE27c2ILtvDp
   tggEWTXtm3OZhdZ8G1SGUjggJaDUCMDJjQPRjQm3AAkrSRTtgqpnnVQWb
   Y=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa10.hc324-48.eu.iphmx.com with ESMTP/TLS; 12 Feb 2021 13:16:12 +0100
Received: from esabb4.muc ([160.50.100.33])  by esagw3.muc with ESMTP/TLS;
 12 Feb 2021 13:16:09 +0100
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp) ([160.48.96.46])
 by esabb4.muc with ESMTP/TLS; 12 Feb 2021 13:16:08 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10j.europe.bmw.corp
 (160.48.96.46) with Microsoft SMTP Server (TLS;
 Fri, 12 Feb 2021 13:16:08 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1497.010; Fri,
 12 Feb 2021 13:16:08 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add the latency-collector to tools
Thread-Topic: [PATCH] Add the latency-collector to tools
Thread-Index: AQHXAJGP4XBNff+fAUa2aU9NFMM3FKpTTikAgAERnwA=
Date:   Fri, 12 Feb 2021 12:16:08 +0000
Message-ID: <d2a434e4dfa012dcfdf6525f26ffaa04671fcab9.camel@bmw.de>
References: <20210126142652.41b961f2@gandalf.local.home>
         <20210211161742.25386-1-Viktor.Rosendahl@bmw.de>
         <20210211145648.1e1e1325@gandalf.local.home>
In-Reply-To: <20210211145648.1e1e1325@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <80A270380375A244B3EA774B3F40A602@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAyLTExIGF0IDE0OjU2IC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVGh1LCAxMSBGZWIgMjAyMSAxNzoxNzo0MiArMDEwMA0KPiBWaWt0b3IgUm9zZW5kYWhs
IDxWaWt0b3IuUm9zZW5kYWhsQGJtdy5kZT4gd3JvdGU6DQo+IA0KPiA+IEl0IHNlZW1zIHRvIHdv
cmsgYnV0IEkgZGlzY292ZXJlZCBkdXJpbmcgdGVzdGluZyB0aGF0IGl0IHNlZW1zIGxpa2UgbmV3
ZXINCj4gPiBrZXJuZWxzIGhhdmUgYSB0ZW5kZW5jeSB0byBsb3NlIHNvbWUgbGF0ZW5jaWVzIGlu
IGxvbmdlciBidXJzdHMuIEkgZ3Vlc3MNCj4gPiB0aGlzDQo+ID4gaXMgbGlrZWx5IHRvIGJlIGFu
b3RoZXIgcmVncmVzc2lvbiBpbiB0aGUgcHJlZW1wdGlycXNvZmYgdHJhY2VyLg0KPiANCj4gTm90
IHN1cmUgd2hhdCB5b3UgbWVhbiBieSB0aGUgYWJvdmUuIEknZCBiZSBpbnRlcmVzdGVkIGluIGZp
eGluZyBpdCBpZiBpcw0KPiByZWFsbHkgYSBwcm9ibGVtLg0KDQoNClNvcnJ5LCBteSBiYWQ7IEkg
c2hvdWxkIGhhdmUgYmVlbiBtb3JlIHNwZWNpZmljLg0KDQpZZXN0ZXJkYXksIHdoZW4gSSB0ZXN0
ZWQgdGhlIGxhdGVuY3ktY29sbGVjdG9yLCBJIGNvdWxkIHNlZSB0aGF0IHRoZXJlIHdlcmUNCmNs
ZWFyIHNpZ25zIG9mIG1pc3NpbmcgbGF0ZW5jaWVzLiBJIHVzZWQgcHJlZW1wdGlycV9kZWxheV90
ZXN0IHRvIGdlbmVyYXRlDQpidXJzdHMgb2YgMTAgYW5kIG5ldmVyIGdvdCBhbnkgc3RhY2sgdHJh
Y2VzIGZyb20gdGhlIDEwdGggbGF0ZW5jeSAobm9yIHRoZSA5dGgNCm9yIDh0aCkuIA0KDQpJIHRo
aW5rIEkgdXNlZCAyMDAwdXMgYXMgYSB0aHJlc2hvbGQgYW5kIGdlbmVyYXRlZCBsYXRlbmNpZXMg
b2YgMzAwMHVzLg0KDQpBbHNvLCBzb21ldGltZXMsIEkgY291bGQgc2VlIHRoYXQgdGhlcmUgd2Vy
ZSBub3QgZW5vdWdoIChtZWFuaW5nIDkpIG1lc3NhZ2VzDQpsaWtlICJwcmludG91dCBza2lwcGVk
IGR1ZSB0byByYW5kb20gZGVsYXkiIGJlZm9yZSBhICJyYW5kb21seSBzbGVlcCBmb3IgMTAwMCBt
cw0KYmVmb3JlIHByaW50IiwgYW5kIHRoZW4gdGhlIHN0YWNrIHRyYWNlIHdvdWxkIHBvaW50IHRv
IGEgbGF0ZW5jeSBmcm9tIHRoZQ0KYmVnaW5uaW5nIG9mIHRoZSBidXJzdCwgYW5kIG5vdCB0aGUg
bGFzdCwgYXMgd291bGQgYmUgZXhwZWN0ZWQgaWYgdGhlIGxhdGVuY3ktDQpjb2xsZWN0b3Igc2xl
cHQgZm9yIDEwMDAgbXMuDQoNCkkgY291bGQgc2VlIHRoZSBwcm9ibGVtIGFsc28gd2l0aG91dCB0
aGUgbGF0ZW5jeS1jb2xsZWN0b3IsIGJlY2F1c2UgaWYgSQ0KZ2VuZXJhdGVkIGEgYnVyc3Qgb2Yg
MTAgYW5kIHRoZW4gY2hlY2tlZCAvc3lzL2tlcm5lbC90cmFjaW5nL3RyYWNlLCBJIHdvdWxkIG5v
dA0Kc2VlIHRoZSB0aGUgc3RhY2sgdHJhY2UgZnJvbSB0aGUgMTB0aCBsYXRlbmN5IGJ1dCBmcm9t
IG9uZSBvZiB0aGUgZWFybGllciBvbmVzLA0KdGhhdCBpcywgSSB3b3VsZCBmb3IgZXhhbXBsZSBz
ZWUgdGhlIHByZWVtcHRpcnF0ZXN0XzIgZnVuY3Rpb24gaW4gdGhlIHRyYWNlLA0KaW5zdGVhZCBv
ZiBwcmVlbXB0aXJxdGVzdF85LCBhcyBleHBlY3RlZC4gSUlSQywgSSBzb21ldGltZXMgc2F3DQp0
aGUgcmVlbXB0aXJxdGVzdF8wIGZ1bmN0aW9uLCBpbmRpY2F0aW5nIHRoYXQgb25seSB0aGUgZmly
c3Qgd2FzIGNhcHR1cmVkIGFuZA0KdGhlIHJlc3Qgd2VyZSBsb3N0Lg0KDQpIb3dldmVyLCBmb3Ig
c29tZSByZWFzb24gSSBjYW5ub3QgcmVwcm9kdWNlIHRoZSBiZWhhdmlvciBub3csIGFsbHRob3Vn
aCBJIHVzZQ0KZXhhY3RseSB0aGUgc2FtZSBrZXJuZWwuDQoNCkJlY2F1c2UgaHVtYW5zIGFyZSBt
b3JlIG9mdGVuIGF0IGZhdWx0IHRoYW4gY29tcHV0ZXJzLCBJIGNhbm5vdCBkZW55IHRoZQ0KcG9z
c2liaWxpdHkgdGhhdCBJIHdvdWxkIGhhdmUgbWlzY29uZmlndXJlZCBzb21ldGhpbmcgYW5kIGl0
IHdhcyBhbGwgdGhlIHJlc3VsdA0Kb2YgYSBmYXVsdHkgdGVzdC4NCg0KSSB3aWxsIGxldCB5b3Ug
a25vdyBpZiBjb21lIHVwIHdpdGggYSB3YXkgb2YgcmVwcm9kdWNpbmcgdGhpcyBiZWhhdmlvciBs
YXRlci4gSQ0KY2Fubm90IHNwZW5kIG1vcmUgdGltZSBvbiBpdCByaWdodCBub3cuDQoNCj4gDQo+
IA0KPiANCj4gSSBkaWRuJ3QgbG9vayB0b28gZGVlcGx5IGF0IHRoZSByZXN0LCBqdXN0IHNraW1t
ZWQgaXQgYmFzaWNhbGx5LCBhbmQgSQ0KPiB0cmllZCBpdCBvdXQuDQo+IA0KPiBJJ20gZmluZSB3
aXRoIHB1bGxpbmcgdGhpcyBpbnRvIG15IHF1ZXVlLCBhcyBpdCdzIGp1c3QgYSB0b29sIGFuZCB3
b250DQo+IGNhdXNlIGFueSBvdGhlciBpc3N1ZXMuIEkgY2FuIG1vdmUgc29tZSBvZiB0aGUgZmls
ZXMgaW4gc2NyaXB0cyB0aGF0IGRlYWxzDQo+IHdpdGggdHJhY2luZyBpbnRvIHRoZSB0b29scy90
cmFjaW5nIGRpcmVjdG9yeSB0b28uIE1heWJlIHRoaXMgc2hvdWxkIGJlDQo+IHBsYWNlZCBpbiBh
IHN1YiBkaXJlY3Rvcnk/IHRvb2xzL3RyYWNpbmcvbGF0ZW5jeS8gPw0KPiANCj4gRmVlbCBmcmVl
IHRvIHN1Ym1pdCBhIHByb3BlciBwYXRjaCAocHJvcGVyIGNoYW5nZSBsb2csIGV0YykuDQo+IA0K
DQpPaywgdGhhbmtzLCBJIHRoaW5rIHRoYXQgSSBoYXZlIGluY29ycG9yYXRlZCBhbGwgb2YgeW91
ciBzdWdnZXN0aW9ucyBpbiB0aGUNCnBhdGNoIHRoYXQgSSBhbHJlYWR5IHNlbnQgb3V0IGVhcmxp
ZXIgdG9kYXkuDQoNCmJlc3QgcmVnYXJkcywNCg0KVmlrdG9yDQoNCg==
