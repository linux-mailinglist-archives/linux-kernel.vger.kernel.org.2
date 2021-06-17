Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561E73AB28F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFQLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:30:39 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:61941 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFQLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623929309; x=1655465309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=v0Zxkwcj7bLdylAaS5fxp5kMUZNNWv0tIXh36+U/mGk=;
  b=RCqsBH9y63/yp4cMPn4qoqXbR4BtT3v/xMlQvJ84lqXP82/UwNw29LPO
   xdpk5RhsvWUUmSXNclUYHzcUMp9DD1Cat7lJCkghIt2LEM9JrmZJl4R+G
   I0wErkTn8hclq16vMNqz32Sbq8PKG9Nl/U05wSzsZBusRC/5sYbQoO7LS
   Y=;
X-IronPort-AV: E=Sophos;i="5.83,280,1616457600"; 
   d="scan'208";a="7150780"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1e-28209b7b.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 17 Jun 2021 11:28:20 +0000
Received: from EX13D17EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-28209b7b.us-east-1.amazon.com (Postfix) with ESMTPS id 61DDAC2873;
        Thu, 17 Jun 2021 11:28:10 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D17EUB001.ant.amazon.com (10.43.166.85) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 17 Jun 2021 11:28:09 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.018;
 Thu, 17 Jun 2021 11:28:08 +0000
From:   "Boehme, Markus" <markubo@amazon.de>
To:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "Heyne, Maximilian" <mheyne@amazon.de>,
        "david@redhat.com" <david@redhat.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Gowans, James" <jgowans@amazon.com>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "snu@zelle79.org" <snu@zelle79.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Sieber, Fernand" <sieberf@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "shakeelb@google.com" <shakeelb@google.com>,
        "elver@google.com" <elver@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v30 12/13] mm/damon: Add user space selftests
Thread-Topic: [PATCH v30 12/13] mm/damon: Add user space selftests
Thread-Index: AQHXYoHCyC4WtkzPBU+BE/7p9v1QtqsYEqyA
Date:   Thu, 17 Jun 2021 11:28:08 +0000
Message-ID: <592c117d55bea3e5f97c49cbe9a79f0093e03dcb.camel@amazon.de>
References: <20210616073119.16758-1-sj38.park@gmail.com>
         <20210616073119.16758-13-sj38.park@gmail.com>
In-Reply-To: <20210616073119.16758-13-sj38.park@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E8110F27E839438FA0CB8CE147EA91@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDA3OjMxICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBGcm9tOiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiANCj4gVGhpcyBjb21t
aXQgYWRkcyBhIHNpbXBsZSB1c2VyIHNwYWNlIHRlc3RzIGZvciBEQU1PTi4gIFRoZSB0ZXN0cyBh
cmUNCj4gdXNpbmcga3NlbGZ0ZXN0IGZyYW1ld29yay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNl
b25nSmFlIFBhcmsgPHNqcGFya0BhbWF6b24uZGU+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZGFtb24vTWFrZWZpbGUgICAgICAgIHwgIDcgKysNCj4gIC4uLi9zZWxmdGVzdHMv
ZGFtb24vX2Noa19kZXBlbmRlbmN5LnNoICAgICAgICB8IDI4ICsrKysrKysNCj4gIC4uLi90ZXN0
aW5nL3NlbGZ0ZXN0cy9kYW1vbi9kZWJ1Z2ZzX2F0dHJzLnNoICB8IDc1ICsrKysrKysrKysrKysr
KysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kYW1vbi9NYWtlZmlsZQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL19jaGtfZGVwZW5k
ZW5jeS5zaA0KPiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Rh
bW9uL2RlYnVnZnNfYXR0cnMuc2gNCj4gDQo+IFsuLi5dDQo+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9kYW1vbi9kZWJ1Z2ZzX2F0dHJzLnNoIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZGFtb24vZGVidWdmc19hdHRycy5zaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0K
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjYwMzQyZDZjODZkOA0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RhbW9uL2RlYnVnZnNfYXR0cnMuc2gNCj4gQEAg
LTAsMCArMSw3NSBAQA0KPiArIyEvYmluL2Jhc2gNCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gKw0KPiArdGVzdF93cml0ZV9yZXN1bHQoKSB7DQo+ICsJZmlsZT0kMQ0K
PiArCWNvbnRlbnQ9JDINCj4gKwlvcmlnX2NvbnRlbnQ9JDMNCj4gKwlleHBlY3RfcmVhc29uPSQ0
DQo+ICsJZXhwZWN0ZWQ9JDUNCj4gKw0KPiArCWVjaG8gIiRjb250ZW50IiA+ICIkZmlsZSINCj4g
KwlpZiBbICQ/IC1uZSAiJGV4cGVjdGVkIiBdDQo+ICsJdGhlbg0KPiArCQllY2hvICJ3cml0aW5n
ICRjb250ZW50IHRvICRmaWxlIGRvZXNuJ3QgcmV0dXJuICRleHBlY3RlZCINCj4gKwkJZWNobyAi
ZXhwZWN0ZWQgYmVjYXVzZTogJGV4cGVjdF9yZWFzb24iDQo+ICsJCWVjaG8gIiRvcmlnX2NvbnRl
bnQiID4gIiRmaWxlIg0KPiArCQlleGl0IDENCj4gKwlmaQ0KPiArfQ0KPiArDQo+ICt0ZXN0X3dy
aXRlX3N1Y2MoKSB7DQo+ICsJdGVzdF93cml0ZV9yZXN1bHQgIiQxIiAiJDIiICIkMyIgIiQ0IiAw
DQo+ICt9DQo+ICsNCj4gK3Rlc3Rfd3JpdGVfZmFpbCgpIHsNCj4gKwl0ZXN0X3dyaXRlX3Jlc3Vs
dCAiJDEiICIkMiIgIiQzIiAiJDQiIDENCj4gK30NCj4gKw0KPiArdGVzdF9jb250ZW50KCkgew0K
PiArCWZpbGU9JDENCj4gKwlvcmlnX2NvbnRlbnQ9JDINCj4gKwlleHBlY3RlZD0kMw0KPiArCWV4
cGVjdF9yZWFzb249JDQNCj4gKw0KPiArCWNvbnRlbnQ9JChjYXQgIiRmaWxlIikNCj4gKwlpZiBb
ICIkY29udGVudCIgIT0gIiRjb250ZW50IiBdDQoNClRoYXQnbGwgYWx3YXlzIGV2YWx1YXRlIGZh
bHNlIGFuZCBzaG91bGQgY29tcGFyZSBhZ2FpbnN0ICJleHBlY3RlZCINCmluc3RlYWQuDQoNCj4g
Kwl0aGVuDQo+ICsJCWVjaG8gInJlYWRpbmcgJGZpbGUgZXhwZWN0ZWQgJGV4cGVjdGVkIGJ1dCAk
Y29udGVudCINCj4gKwkJZWNobyAiZXhwZWN0ZWQgYmVjYXVzZTogJGV4cGVjdF9yZWFzb24iDQo+
ICsJCWVjaG8gIiRvcmlnX2NvbnRlbnQiID4gIiRmaWxlIg0KPiArCQlleGl0IDENCj4gKwlmaQ0K
PiArfQ0KPiANCj4gWy4uLl0NCg0KDQpPdGhlcndpc2UgbG9va2luZyBnb29kLg0KDQpCZXN0IHJl
Z2FyZHMsDQpNYXJrdXMNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlh
biBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAy
ODkgMjM3IDg3OQoKCg==

