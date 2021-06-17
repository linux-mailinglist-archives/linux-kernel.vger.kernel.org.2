Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EBC3AB292
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFQLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:32:05 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15597 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFQLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623929398; x=1655465398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=4QSTyRfubUndkbBs5+6KQTQPFCIZthylghgXKSrFE54=;
  b=ZeLv3KXv+7B7Ch20wNS5TkdYT256S7w2ZO2l7jWK/CsS5i36m82aLYUW
   YZ3zkACo5rBBOiatX54+SPJfaAn+J+/gi2uaoroJqUxcLcmD7Ghcd1Iek
   8oDAOD2A3PcFTvVYQ7J0XTa2KC3h1YryF7/fbFtDMCpFQB7So7SIcFZIw
   Y=;
X-IronPort-AV: E=Sophos;i="5.83,280,1616457600"; 
   d="scan'208";a="114907178"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-4101.iad4.amazon.com with ESMTP; 17 Jun 2021 11:29:47 +0000
Received: from EX13D14EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id EC450A18F2;
        Thu, 17 Jun 2021 11:29:43 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D14EUB001.ant.amazon.com (10.43.166.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 17 Jun 2021 11:29:42 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.018;
 Thu, 17 Jun 2021 11:29:42 +0000
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
        "Heyne, Maximilian" <mheyne@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gowans, James" <jgowans@amazon.com>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "snu@zelle79.org" <snu@zelle79.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "Sieber, Fernand" <sieberf@amazon.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v30 12/13] mm/damon: Add user space selftests
Thread-Topic: [PATCH v30 12/13] mm/damon: Add user space selftests
Thread-Index: AQHXYoHCyC4WtkzPBU+BE/7p9v1QtqsYEqyAgAAAcIA=
Date:   Thu, 17 Jun 2021 11:29:41 +0000
Message-ID: <1ad122038f283961b787b26bb838a063ff7c43cf.camel@amazon.de>
References: <20210616073119.16758-1-sj38.park@gmail.com>
         <20210616073119.16758-13-sj38.park@gmail.com>
         <592c117d55bea3e5f97c49cbe9a79f0093e03dcb.camel@amazon.de>
In-Reply-To: <592c117d55bea3e5f97c49cbe9a79f0093e03dcb.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <121522546DD7674780FF5A08D671D29D@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTE3IGF0IDExOjI4ICswMDAwLCBCb2VobWUsIE1hcmt1cyB3cm90ZToN
Cj4gT24gV2VkLCAyMDIxLTA2LTE2IGF0IDA3OjMxICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3Rl
Og0KPiA+IEZyb206IFNlb25nSmFlIFBhcmsgPHNqcGFya0BhbWF6b24uZGU+DQo+ID4gDQo+ID4g
VGhpcyBjb21taXQgYWRkcyBhIHNpbXBsZSB1c2VyIHNwYWNlIHRlc3RzIGZvciBEQU1PTi4gIFRo
ZSB0ZXN0cw0KPiA+IGFyZQ0KPiA+IHVzaW5nIGtzZWxmdGVzdCBmcmFtZXdvcmsuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogU2VvbmdKYWUgUGFyayA8c2pwYXJrQGFtYXpvbi5kZT4NCj4gPiAt
LS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGFtb24vTWFrZWZpbGUgICAgICAgIHwg
IDcgKysNCj4gPiAgLi4uL3NlbGZ0ZXN0cy9kYW1vbi9fY2hrX2RlcGVuZGVuY3kuc2ggICAgICAg
IHwgMjggKysrKysrKw0KPiA+ICAuLi4vdGVzdGluZy9zZWxmdGVzdHMvZGFtb24vZGVidWdmc19h
dHRycy5zaCAgfCA3NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZGFtb24vTWFrZWZpbGUNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+
ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGFtb24vX2Noa19kZXBlbmRlbmN5LnNoDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kYW1vbi9kZWJ1Z2Zz
X2F0dHJzLnNoDQo+ID4gDQo+ID4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvZGFtb24vZGVidWdmc19hdHRycy5zaA0KPiA+IGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZGFtb24vZGVidWdmc19hdHRycy5zaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42MDM0MmQ2Yzg2ZDgNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGFtb24vZGVidWdmc19hdHRycy5z
aA0KPiA+IEBAIC0wLDAgKzEsNzUgQEANCj4gPiArIyEvYmluL2Jhc2gNCj4gPiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsNCj4gPiArdGVzdF93cml0ZV9yZXN1bHQo
KSB7DQo+ID4gKwlmaWxlPSQxDQo+ID4gKwljb250ZW50PSQyDQo+ID4gKwlvcmlnX2NvbnRlbnQ9
JDMNCj4gPiArCWV4cGVjdF9yZWFzb249JDQNCj4gPiArCWV4cGVjdGVkPSQ1DQo+ID4gKw0KPiA+
ICsJZWNobyAiJGNvbnRlbnQiID4gIiRmaWxlIg0KPiA+ICsJaWYgWyAkPyAtbmUgIiRleHBlY3Rl
ZCIgXQ0KPiA+ICsJdGhlbg0KPiA+ICsJCWVjaG8gIndyaXRpbmcgJGNvbnRlbnQgdG8gJGZpbGUg
ZG9lc24ndCByZXR1cm4NCj4gPiAkZXhwZWN0ZWQiDQo+ID4gKwkJZWNobyAiZXhwZWN0ZWQgYmVj
YXVzZTogJGV4cGVjdF9yZWFzb24iDQo+ID4gKwkJZWNobyAiJG9yaWdfY29udGVudCIgPiAiJGZp
bGUiDQo+ID4gKwkJZXhpdCAxDQo+ID4gKwlmaQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICt0ZXN0X3dy
aXRlX3N1Y2MoKSB7DQo+ID4gKwl0ZXN0X3dyaXRlX3Jlc3VsdCAiJDEiICIkMiIgIiQzIiAiJDQi
IDANCj4gPiArfQ0KPiA+ICsNCj4gPiArdGVzdF93cml0ZV9mYWlsKCkgew0KPiA+ICsJdGVzdF93
cml0ZV9yZXN1bHQgIiQxIiAiJDIiICIkMyIgIiQ0IiAxDQo+ID4gK30NCj4gPiArDQo+ID4gK3Rl
c3RfY29udGVudCgpIHsNCj4gPiArCWZpbGU9JDENCj4gPiArCW9yaWdfY29udGVudD0kMg0KPiA+
ICsJZXhwZWN0ZWQ9JDMNCj4gPiArCWV4cGVjdF9yZWFzb249JDQNCj4gPiArDQo+ID4gKwljb250
ZW50PSQoY2F0ICIkZmlsZSIpDQo+ID4gKwlpZiBbICIkY29udGVudCIgIT0gIiRjb250ZW50IiBd
DQo+IA0KPiBUaGF0J2xsIGFsd2F5cyBldmFsdWF0ZSBmYWxzZSBhbmQgc2hvdWxkIGNvbXBhcmUg
YWdhaW5zdCAiZXhwZWN0ZWQiDQo+IGluc3RlYWQuDQo+IA0KDQpGZWVsIGZyZWUgdG8gYWRkIFJl
dmlld2VkLWJ5OiBNYXJrdXMgQm9laG1lIDxtYXJrdWJvQGFtYXpvbi5kZT4gd2hlbg0KdGhpcyBp
cyBmaXhlZC4NCg0KPiA+ICsJdGhlbg0KPiA+ICsJCWVjaG8gInJlYWRpbmcgJGZpbGUgZXhwZWN0
ZWQgJGV4cGVjdGVkIGJ1dCAkY29udGVudCINCj4gPiArCQllY2hvICJleHBlY3RlZCBiZWNhdXNl
OiAkZXhwZWN0X3JlYXNvbiINCj4gPiArCQllY2hvICIkb3JpZ19jb250ZW50IiA+ICIkZmlsZSIN
Cj4gPiArCQlleGl0IDENCj4gPiArCWZpDQo+ID4gK30NCj4gPiANCj4gPiBbLi4uXQ0KPiANCj4g
T3RoZXJ3aXNlIGxvb2tpbmcgZ29vZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gTWFya3VzDQoK
CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAox
MDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25h
dGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRl
ciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

