Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD03A480B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFKRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:46:34 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:56584 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623433473; x=1654969473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=UV87Hv57RasmCwzak7m842vLdCpDlxdm25csnin6dlE=;
  b=SBW8i33hB9irM+yRR4H6DyYUGYi7IhDuc+EQ44NdNVtOKl49cgarRuoN
   z7Zr560dmFpQYrsgQC4HDV37GLd6dRiNWADWJigbnCyI3UI1Xix0NnId8
   DGzbTNLsxiAv8rS7VGvp4NC5u1NEoDSssT0g8w8d8SIx8oNZR3N6im0Kv
   c=;
X-IronPort-AV: E=Sophos;i="5.83,267,1616457600"; 
   d="scan'208";a="119692844"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 11 Jun 2021 17:44:23 +0000
Received: from EX13D17EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 65D07A1E4C;
        Fri, 11 Jun 2021 17:44:20 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D17EUB001.ant.amazon.com (10.43.166.85) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 11 Jun 2021 17:44:18 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.018;
 Fri, 11 Jun 2021 17:44:18 +0000
From:   "Boehme, Markus" <markubo@amazon.de>
To:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "david@redhat.com" <david@redhat.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "snu@amazon.de" <snu@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "zgf574564920@gmail.com" <zgf574564920@gmail.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "amit@kernel.org" <amit@kernel.org>,
        "fan.du@intel.com" <fan.du@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "elver@google.com" <elver@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v29 10/13] Documentation: Add documents for DAMON
Thread-Topic: [PATCH v29 10/13] Documentation: Add documents for DAMON
Thread-Index: AQHXXrya6YymqfW1Sky/9HfBMBcj5qsPFVOA
Date:   Fri, 11 Jun 2021 17:44:18 +0000
Message-ID: <c0758ac4a7f2dae75799c79b12a6a14d3fe8bec3.camel@amazon.de>
References: <20210520075629.4332-1-sj38.park@gmail.com>
         <20210520075629.4332-11-sj38.park@gmail.com>
In-Reply-To: <20210520075629.4332-11-sj38.park@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06F0B64872CB74EB4ED3E05EF117E2E@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTIwIGF0IDA3OjU2ICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBGcm9tOiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiANCj4gVGhpcyBjb21t
aXQgYWRkcyBkb2N1bWVudHMgZm9yIERBTU9OIHVuZGVyDQo+IGBEb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL21tL2RhbW9uL2AgYW5kIGBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2AuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiAtLS0NCj4g
IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vZ3VpZGUucnN0IHwgMTU4ICsrKysr
KysrKysrKysNCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vaW5kZXgucnN0
IHwgIDE1ICsrDQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL3BsYW5zLnJz
dCB8ICAyOSArKysNCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vc3RhcnQu
cnN0IHwgMTE0ICsrKysrKysrKw0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kYW1v
bi91c2FnZS5yc3QgfCAxMTIgKysrKysrKysrDQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L21tL2luZGV4LnJzdCAgICAgICB8ICAgMSArDQo+ICBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2Fw
aS5yc3QgICAgICAgICAgICAgICB8ICAyMCArKw0KPiAgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9k
ZXNpZ24ucnN0ICAgICAgICAgICAgfCAxNjYgKysrKysrKysrKysrKw0KPiAgRG9jdW1lbnRhdGlv
bi92bS9kYW1vbi9ldmFsLnJzdCAgICAgICAgICAgICAgfCAyMzIgKysrKysrKysrKysrKysrKysr
Kw0KPiAgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9mYXEucnN0ICAgICAgICAgICAgICAgfCAgNTgg
KysrKysNCj4gIERvY3VtZW50YXRpb24vdm0vZGFtb24vaW5kZXgucnN0ICAgICAgICAgICAgIHwg
IDMxICsrKw0KPiAgRG9jdW1lbnRhdGlvbi92bS9pbmRleC5yc3QgICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KPiAgMTIgZmlsZXMgY2hhbmdlZCwgOTM3IGluc2VydGlvbnMoKykNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL2d1aWRlLnJz
dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFt
b24vaW5kZXgucnN0DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9tbS9kYW1vbi9wbGFucy5yc3QNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL3N0YXJ0LnJzdA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vdXNhZ2UucnN0DQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9hcGkucnN0DQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9kZXNpZ24ucnN0DQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9ldmFsLnJzdA0KPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vdm0vZGFtb24vZmFxLnJzdA0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vdm0vZGFtb24vaW5kZXgucnN0DQo+IA0KPiBbLi4uXQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kYW1vbi9zdGFydC5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL3N0YXJ0LnJzdA0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY1YmJmMWUzNjgzNg0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vc3Rh
cnQucnN0DQo+IEBAIC0wLDAgKzEsMTE0IEBADQo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPiArDQo+ICs9PT09PT09PT09PT09PT0NCj4gK0dldHRpbmcgU3RhcnRlZA0K
PiArPT09PT09PT09PT09PT09DQo+ICsNCj4gK1RoaXMgZG9jdW1lbnQgYnJpZWZseSBkZXNjcmli
ZXMgaG93IHlvdSBjYW4gdXNlIERBTU9OIGJ5IGRlbW9uc3RyYXRpbmcgaXRzDQo+ICtkZWZhdWx0
IHVzZXIgc3BhY2UgdG9vbC4gIFBsZWFzZSBub3RlIHRoYXQgdGhpcyBkb2N1bWVudCBkZXNjcmli
ZXMgb25seSBhIHBhcnQNCj4gK29mIGl0cyBmZWF0dXJlcyBmb3IgYnJldml0eS4gIFBsZWFzZSBy
ZWZlciB0byA6ZG9jOmB1c2FnZWAgZm9yIG1vcmUgZGV0YWlscy4NCj4gWy4uLl0NCj4gKw0KPiAr
DQo+ICtQcmVyZXF1aXNpdGVzDQo+ICs9PT09PT09PT09PT09DQo+ICsNCj4gK0tlcm5lbA0KPiAr
LS0tLS0tDQo+ICsNCj4gK1lvdSBzaG91bGQgZmlyc3QgZW5zdXJlIHlvdXIgc3lzdGVtIGlzIHJ1
bm5pbmcgb24gYSBrZXJuZWwgYnVpbHQgd2l0aA0KPiArYGBDT05GSUdfREFNT05fKj15YGAuDQo+
ICsNCj4gKw0KPiArVXNlciBTcGFjZSBUb29sDQo+ICstLS0tLS0tLS0tLS0tLS0NCj4gKw0KPiAr
Rm9yIHRoZSBkZW1vbnN0cmF0aW9uLCB3ZSB3aWxsIHVzZSB0aGUgZGVmYXVsdCB1c2VyIHNwYWNl
IHRvb2wgZm9yIERBTU9OLA0KPiArY2FsbGVkIERBTU9OIE9wZXJhdG9yIChEQU1PKS4gIEl0IGlz
IGF2YWlsYWJsZSBhdA0KPiAraHR0cHM6Ly9naXRodWIuY29tL2F3c2xhYnMvZGFtby4gIEZvciBi
cmV2aXR5LCBiZWxvdyBleGFtcGxlcyBhc3N1bWUgeW91IHNldA0KPiArYGAkUEFUSGBgIHRvIHBv
aW50IGl0LiAgSXQncyBub3QgbWFuZGF0b3J5LCB0aG91Z2guDQoNCiJUaGUgZXhhbXBsZXMgYmVs
b3cgYXNzdW1lIGBgZGFtb2BgIGlzIG9uIHlvdXIgYGAkUEFUSGBgLiI/DQoNCj4gKw0KPiArQmVj
YXVzZSBEQU1PIGlzIHVzaW5nIHRoZSBkZWJ1Z2ZzIGludGVyZmFjZSAocmVmZXIgdG8gOmRvYzpg
dXNhZ2VgIGZvciB0aGUNCj4gK2RldGFpbCkgb2YgREFNT04sIHlvdSBzaG91bGQgZW5zdXJlIGRl
YnVnZnMgaXMgbW91bnRlZC4gIE1vdW50IGl0IG1hbnVhbGx5IGFzDQo+ICtiZWxvdzo6DQo+ICsN
Cj4gKyAgICAjIG1vdW50IC10IGRlYnVnZnMgbm9uZSAvc3lzL2tlcm5lbC9kZWJ1Zy8NCj4gKw0K
PiArb3IgYXBwZW5kIGJlbG93IGxpbmUgdG8geW91ciBgYC9ldGMvZnN0YWJgYCBmaWxlIHNvIHRo
YXQgeW91ciBzeXN0ZW0gY2FuDQo+ICthdXRvbWF0aWNhbGx5IG1vdW50IGRlYnVnZnMgZnJvbSBu
ZXh0IGJvb3Rpbmc6Og0KPiArDQo+ICsgICAgZGVidWdmcyAvc3lzL2tlcm5lbC9kZWJ1ZyBkZWJ1
Z2ZzIGRlZmF1bHRzIDAgMA0KPiArDQo+ICsNCj4gWy4uLl0NCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vdXNhZ2UucnN0IGIvRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9tbS9kYW1vbi91c2FnZS5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5lYTNmYTZlNTVmOGINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL3VzYWdlLnJzdA0KPiBAQCAtMCww
ICsxLDExMiBAQA0KPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKw0K
PiArPT09PT09PT09PT09PT09DQo+ICtEZXRhaWxlZCBVc2FnZXMNCj4gKz09PT09PT09PT09PT09
PQ0KPiBbLi4uXQ0KPiArDQo+ICtUcmFjZXBvaW50IGZvciBNb25pdG9yaW5nIFJlc3VsdHMNCj4g
Kz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArDQo+ICtEQU1PTiBwcm92aWRl
cyB0aGUgbW9uaXRvcmluZyByZXN1bHRzIHZpYSBhIHRyYWNlcG9pbnQsDQo+ICtgYGRhbW9uOmRh
bW9uX2FnZ3JlZ2F0ZWRgYC4gIFdoaWxlIHRoZSBtb25pdG9yaW5nIGlzIHR1cm5lZCBvbiwgeW91
IGNvdWxkDQo+ICtyZWNvcmQgdGhlIHRyYWNlcG9pbnQgZXZlbnRzIGFuZCBzaG93IHJlc3VsdHMg
dXNpbmcgdHJhY2Vwb2ludCBzdXBwb3J0aW5nIHRvb2xzDQo+ICtsaWtlIGBgcGVyZmBgLiAgRm9y
IGV4YW1wbGU6Og0KPiArDQo+ICsgICAgIyBlY2hvIG9uID4gbW9uaXRvcl9vbg0KPiArICAgICMg
cGVyZiByZWNvcmQgZGFtb246ZGFtb25fYWdncmVnYXRlZCAmDQoNCkkgdGhpbmsgdGhhdCBuZWVk
cyB0byBiZSAiLWUgZGFtb246ZGFtb25fYWdncmVnYXRlZCIuDQoNCj4gKyAgICAjIHNsZWVwIDUN
Cj4gKyAgICAjIGtpbGwgOSAkKHBpZG9mIHBlcmYpDQo+ICsgICAgIyBlY2hvIG9mZiA+IG1vbml0
b3Jfb24NCj4gKyAgICAjIHBlcmYgc2NyaXB0DQo+IA0KPiBbLi4uXQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9kZXNpZ24ucnN0IGIvRG9jdW1lbnRhdGlvbi92bS9k
YW1vbi9kZXNpZ24ucnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNzI3ZDcyMDkzZjhmDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi92bS9kYW1vbi9kZXNpZ24ucnN0DQo+IEBAIC0wLDAgKzEsMTY2IEBADQo+ICsuLiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArDQo+ICs9PT09PT0NCj4gK0Rlc2lnbg0KPiAr
PT09PT09DQo+ICsNCj4gWy4uLl0NCj4gKw0KPiArUmVmZXJlbmNlIEltcGxlbWVudGF0aW9ucyBv
ZiBBZGRyZXNzIFNwYWNlIFNwZWNpZmljIFByaW1pdGl2ZXMNCj4gKz09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICsNCj4gK1Ro
ZSBsb3cgbGV2ZWwgcHJpbWl0aXZlcyBmb3IgdGhlIGZ1bmRhbWVudGFsIGFjY2VzcyBtb25pdG9y
aW5nIGFyZSBkZWZpbmVkIGluDQo+ICt0d28gcGFydHM6DQo+ICsNCj4gKzEuIElkZW50aWZpY2F0
aW9uIG9mIHRoZSBtb25pdG9yaW5nIHRhcmdldCBhZGRyZXNzIHJhbmdlIGZvciB0aGUgYWRkcmVz
cyBzcGFjZS4NCj4gKzIuIEFjY2VzcyBjaGVjayBvZiBzcGVjaWZpYyBhZGRyZXNzIHJhbmdlIGlu
IHRoZSB0YXJnZXQgc3BhY2UuDQo+ICsNCj4gK0RBTU9OIGN1cnJlbnRseSBwcm92aWRlcyB0aGUg
aW1wbGVtZW50YXRpb24gb2YgdGhlIHByaW1pdGl2ZXMgZm9yIG9ubHkgdGhlDQo+ICt2aXJ0dWFs
IGFkZHJlc3Mgc3BhY2VzLiBCZWxvdyB0d28gc3Vic2VjdGlvbnMgZGVzY3JpYmUgaG93IGl0IHdv
cmtzLg0KPiArDQo+ICsNCj4gK1BURSBBY2Nlc3NlZC1iaXQgQmFzZWQgQWNjZXNzIENoZWNrDQo+
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtUaGUgaW1wbGVt
ZW50YXRpb24gZm9yIHRoZSB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UgdXNlcyBQVEUgQWNjZXNzZWQt
Yml0IGZvcg0KPiArYmFzaWMgYWNjZXNzIGNoZWNrcy4gIEl0IGZpbmRzIHRoZSByZWxldmFudCBQ
VEUgQWNjZXNzZWQgYml0IGZyb20gdGhlIGFkZHJlc3MNCj4gK2J5IHdhbGtpbmcgdGhlIHBhZ2Ug
dGFibGUgZm9yIHRoZSB0YXJnZXQgdGFzayBvZiB0aGUgYWRkcmVzcy4gIEluIHRoaXMgd2F5LCB0
aGUNCj4gK2ltcGxlbWVudGF0aW9uIGZpbmRzIGFuZCBjbGVhcnMgdGhlIGJpdCBmb3IgbmV4dCBz
YW1wbGluZyB0YXJnZXQgYWRkcmVzcyBhbmQNCj4gK2NoZWNrcyB3aGV0aGVyIHRoZSBiaXQgc2V0
IGFnYWluIGFmdGVyIG9uZSBzYW1wbGluZyBwZXJpb2QuICBUaGlzIGNvdWxkIGRpc3R1cmINCj4g
K290aGVyIGtlcm5lbCBzdWJzeXN0ZW1zIHVzaW5nIHRoZSBBY2Nlc3NlZCBiaXRzLCBuYW1lbHkg
SWRsZSBwYWdlIHRyYWNraW5nIGFuZA0KPiArdGhlIHJlY2xhaW0gbG9naWMuICBUbyBhdm9pZCBz
dWNoIGRpc3R1cmJhbmNlcywgREFNT04gbWFrZXMgaXQgbXV0dWFsbHkNCj4gK2V4Y2x1c2l2ZSB3
aXRoIElkbGUgcGFnZSB0cmFja2luZyBhbmQgdXNlcyBgYFBHX2lkbGVgYCBhbmQgYGBQR195b3Vu
Z2BgIHBhZ2UNCj4gK2ZsYWdzIHRvIHNvbHZlIHRoZSBjb25mbGljdCB3aXRoIHRoZSByZWNsYWlt
IGxvZ2ljLCBhcyBJZGxlIHBhZ2UgdHJhY2tpbmcgZG9lcy4NCj4gKw0KPiArDQo+ICtWTUEtYmFz
ZWQgVGFyZ2V0IEFkZHJlc3MgUmFuZ2UgQ29uc3RydWN0aW9uDQo+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK09ubHkgc21hbGwgcGFydHMgaW4g
dGhlIHN1cGVyLWh1Z2UgdmlydHVhbCBhZGRyZXNzIHNwYWNlIG9mIHRoZSBwcm9jZXNzZXMgYXJl
DQo+ICttYXBwZWQgdG8gdGhlIHBoeXNpY2FsIG1lbW9yeSBhbmQgYWNjZXNzZWQuICBUaHVzLCB0
cmFja2luZyB0aGUgdW5tYXBwZWQNCj4gK2FkZHJlc3MgcmVnaW9ucyBpcyBqdXN0IHdhc3RlZnVs
LiAgSG93ZXZlciwgYmVjYXVzZSBEQU1PTiBjYW4gZGVhbCB3aXRoIHNvbWUNCj4gK2xldmVsIG9m
IG5vaXNlIHVzaW5nIHRoZSBhZGFwdGl2ZSByZWdpb25zIGFkanVzdG1lbnQgbWVjaGFuaXNtLCB0
cmFja2luZyBldmVyeQ0KPiArbWFwcGluZyBpcyBub3Qgc3RyaWN0bHkgcmVxdWlyZWQgYnV0IGNv
dWxkIGV2ZW4gaW5jdXIgYSBoaWdoIG92ZXJoZWFkIGluIHNvbWUNCj4gK2Nhc2VzLiAgVGhhdCBz
YWlkLCB0b28gaHVnZSB1bm1hcHBlZCBhcmVhcyBpbnNpZGUgdGhlIG1vbml0b3JpbmcgdGFyZ2V0
IHNob3VsZA0KPiArYmUgcmVtb3ZlZCB0byBub3QgdGFrZSB0aGUgdGltZSBmb3IgdGhlIGFkYXB0
aXZlIG1lY2hhbmlzbS4NCj4gKw0KPiArRm9yIHRoZSByZWFzb24sIHRoaXMgaW1wbGVtZW50YXRp
b24gY29udmVydHMgdGhlIGNvbXBsZXggbWFwcGluZ3MgdG8gdGhyZWUNCj4gK2Rpc3RpbmN0IHJl
Z2lvbnMgdGhhdCBjb3ZlciBldmVyeSBtYXBwZWQgYXJlYSBvZiB0aGUgYWRkcmVzcyBzcGFjZS4g
IFRoZSB0d28NCj4gK2dhcHMgYmV0d2VlbiB0aGUgdGhyZWUgcmVnaW9ucyBhcmUgdGhlIHR3byBi
aWdnZXN0IHVubWFwcGVkIGFyZWFzIGluIHRoZSBnaXZlbg0KPiArYWRkcmVzcyBzcGFjZS4gIFRo
ZSB0d28gYmlnZ2VzdCB1bm1hcHBlZCBhcmVhcyB3b3VsZCBiZSB0aGUgZ2FwIGJldHdlZW4gdGhl
DQo+ICtoZWFwIGFuZCB0aGUgdXBwZXJtb3N0IG1tYXAoKS1lZCByZWdpb24sIGFuZCB0aGUgZ2Fw
IGJldHdlZW4gdGhlIGxvd2VybW9zdA0KPiArbW1hcCgpLWVkIHJlZ2lvbiBhbmQgdGhlIHN0YWNr
IGluIG1vc3Qgb2YgdGhlIGNhc2VzLiAgQmVjYXVzZSB0aGVzZSBnYXBzIGFyZQ0KPiArZXhjZXB0
aW9uYWxseSBodWdlIGluIHVzdWFsIGFkZHJlc3Mgc3BhY2VzLCBleGNsdWRpbmcgdGhlc2Ugd2ls
bCBiZSBzdWZmaWNpZW50DQo+ICt0byBtYWtlIGEgcmVhc29uYWJsZSB0cmFkZS1vZmYuICBCZWxv
dyBzaG93cyB0aGlzIGluIGRldGFpbDo6DQo+ICsNCj4gKyAgICA8aGVhcD4NCj4gKyAgICA8QklH
IFVOTUFQUEVEIFJFR0lPTiAxPg0KPiArICAgIDx1cHBlcm1vc3QgbW1hcCgpLWVkIHJlZ2lvbj4N
Cj4gKyAgICAoc21hbGwgbW1hcCgpLWVkIHJlZ2lvbnMgYW5kIG11bm1hcCgpLWVkIHJlZ2lvbnMp
DQo+ICsgICAgPGxvd2VybW9zdCBtbWFwKCktZWQgcmVnaW9uPg0KPiArICAgIDxCSUcgVU5NQVBQ
RUQgUkVHSU9OIDI+DQo+ICsgICAgPHN0YWNrPg0KPiArDQoNCk5pdDogSSdkIHN3YXAgdGhlc2Ug
c2VjdGlvbnMgc28gdGhleSBtYXRjaCB0aGUgb3JkZXJlZCBsaXN0IGluIHRoZQ0Kc2VjdGlvbiBv
dmVydmlldy4NCg0KPiBbLi4uXQ0KDQpJIHNraXBwZWQgdGhlIGZpbGVzIHlvdSBtZW50aW9uZWQg
d291bGQgYmUgZHJvcHBlZCBmcm9tIHRoZSBuZXh0DQpyZXZpc2lvbi4NCg0KQmVzdCByZWdhcmRz
LA0KTWFya3VzDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1
c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2No
bGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIz
NyA4NzkKCgo=

