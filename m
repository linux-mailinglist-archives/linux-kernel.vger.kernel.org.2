Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD803A4282
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhFKM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:57:45 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:15279 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFKM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623416146; x=1654952146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=BrXCGDBeKR6P+P7CyrC4DzPL0ctuvXpE83eAuIvY2wU=;
  b=hItZYzPDEf+7Ajuc9+qjGYt1kE2kgstc4fbBDioB6w4s2xFiJV5DS03q
   OgZQropPvQNkAqA5D1JKOgWQFIfejYmE2achD18Esc/sApvOMwUCqKbGA
   bWt1GrJPNBrxVuEDecV23Je/B54GVhd26H+Xf5+AIJWeUL22kinNoT1si
   w=;
X-IronPort-AV: E=Sophos;i="5.83,265,1616457600"; 
   d="scan'208";a="115255326"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 11 Jun 2021 12:55:38 +0000
Received: from EX13D17EUC003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id AB759A176A;
        Fri, 11 Jun 2021 12:55:28 +0000 (UTC)
Received: from EX13D18EUC002.ant.amazon.com (10.43.164.50) by
 EX13D17EUC003.ant.amazon.com (10.43.164.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 11 Jun 2021 12:55:27 +0000
Received: from EX13D18EUC002.ant.amazon.com ([10.43.164.50]) by
 EX13D18EUC002.ant.amazon.com ([10.43.164.50]) with mapi id 15.00.1497.018;
 Fri, 11 Jun 2021 12:55:27 +0000
From:   "Shah, Amit" <aams@amazon.de>
To:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "snu@amazon.de" <snu@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "zgf574564920@gmail.com" <zgf574564920@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fan.du@intel.com" <fan.du@intel.com>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "amit@kernel.org" <amit@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "greg@kroah.com" <greg@kroah.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "elver@google.com" <elver@google.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v29 04/13] mm/idle_page_tracking: Make PG_idle reusable
Thread-Topic: [PATCH v29 04/13] mm/idle_page_tracking: Make PG_idle reusable
Thread-Index: AQHXTU3EfT2+O9xDt0CAVETbPjCp+asO530A
Date:   Fri, 11 Jun 2021 12:55:27 +0000
Message-ID: <ac98333d677a3ae8d25a998816e025954826e5c1.camel@amazon.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
         <20210520075629.4332-5-sj38.park@gmail.com>
In-Reply-To: <20210520075629.4332-5-sj38.park@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB8B591EDE18448A170B6951C66C786@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTIwIGF0IDA3OjU2ICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBGcm9tOiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiANCj4gUEdfaWRsZSBh
bmQgUEdfeW91bmcgYWxsb3cgdGhlIHR3byBQVEUgQWNjZXNzZWQgYml0IHVzZXJzLCBJZGxlIFBh
Z2UNCj4gVHJhY2tpbmcgYW5kIHRoZSByZWNsYWltIGxvZ2ljIGNvbmN1cnJlbnRseSB3b3JrIHdo
aWxlIGRvbid0IGludGVyZmVyZQ0KDQouLi4gd2hpbGUgbm90IGludGVyZmVyaW5nIHdpdGggLi4u
DQoNCj4gZWFjaCBvdGhlci4gIFRoYXQgaXMsIHdoZW4gdGhleSBuZWVkIHRvIGNsZWFyIHRoZSBB
Y2Nlc3NlZCBiaXQsIHRoZXkgc2V0DQo+IFBHX3lvdW5nIHRvIHJlcHJlc2VudCB0aGUgcHJldmlv
dXMgc3RhdGUgb2YgdGhlIGJpdCwgcmVzcGVjdGl2ZWx5LiAgQW5kDQo+IHdoZW4gdGhleSBuZWVk
IHRvIHJlYWQgdGhlIGJpdCwgaWYgdGhlIGJpdCBpcyBjbGVhcmVkLCB0aGV5IGZ1cnRoZXIgcmVh
ZA0KPiB0aGUgUEdfeW91bmcgdG8ga25vdyB3aGV0aGVyIHRoZSBvdGhlciBoYXMgY2xlYXJlZCB0
aGUgYml0IG1lYW53aGlsZSBvcg0KPiBub3QuDQo+IA0KPiBXZSBjb3VsZCBhZGQgYW5vdGhlciBw
YWdlIGZsYWcgYW5kIGV4dGVuZCB0aGUgbWVjaGFuaXNtIHRvIHVzZSB0aGUgZmxhZw0KPiBpZiB3
ZSBuZWVkIHRvIGFkZCBhbm90aGVyIGNvbmN1cnJlbnQgUFRFIEFjY2Vzc2VkIGJpdCB1c2VyIHN1
YnN5c3RlbS4NCj4gSG93ZXZlciwgdGhlIHNwYWNlIGlzIGxpbWl0ZWQuICBNZWFud2hpbGUsIGlm
IHRoZSBuZXcgc3Vic3lzdGVtIGlzDQo+IG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIElETEVfUEFH
RV9UUkFDS0lORyBvciBpbnRlcmZlcmluZyB3aXRoIGl0IGlzIG5vdA0KPiBhIHJlYWwgcHJvYmxl
bSwgaXQgd291bGQgYmUgb2sgdG8gc2ltcGx5IHJldXNlIHRoZSBQR19pZGxlIGZsYWcuDQo+IEhv
d2V2ZXIsIGl0J3MgaW1wb3NzaWJsZSBiZWNhdXNlIHRoZSBmbGFncyBhcmUgZGVwZW5kZW50IG9u
DQo+IElETEVfUEFHRV9UUkFDS0lORy4NCg0KRm9yIGJldHRlciByZWFkYWJpbGl0eSwgSSBzdWdn
ZXN0Og0KDQpGb3IgeWV0IGFub3RoZXIgdXNlciBvZiB0aGUgUFRFIEFjY2Vzc2VkIGJpdCwgd2Ug
Y291bGQgYWRkIGFub3RoZXIgcGFnZQ0KZmxhZywgb3IgZXh0ZW5kIHRoZSBtZWNoYW5pc20gdG8g
dXNlIHRoZSBmbGFncy4gRm9yIHRoZSBEQU1PTiB1c2VjYXNlLA0KaG93ZXZlciwgd2UgZG9uJ3Qg
bmVlZCB0byBkbyB0aGF0IGp1c3QgeWV0LiAgSURMRV9QQUdFX1RSQUNLSU5HIGFuZA0KREFNT04g
YXJlIG11dHVhbGx5IGV4Y2x1c2l2ZSwgc28gdGhlcmUncyBvbmx5IGV2ZXIgZ29pbmcgdG8gYmUg
b25lIHVzZXINCm9mIHRoZSBjdXJyZW50IHNldCBvZiBmbGFncy4gDQoNCkluIHRoaXMgY29tbWl0
LCB3ZSBzcGxpdCBvdXQgdGhlIENPTkZJRyBvcHRpb25zIHRvIGFsbG93IGZvciB0aGUgdXNlIG9m
DQpQR195b3VuZyBhbmQgUEdfaWRsZSBvdXRzaWRlIG9mIGlkbGUgcGFnZSB0cmFja2luZy4NCg0K
PiANCj4gVG8gYWxsb3cgc3VjaCByZXVzZSBvZiB0aGUgZmxhZ3MsIHRoaXMgY29tbWl0IHNlcGFy
YXRlcyB0aGUgUEdfeW91bmcgYW5kDQo+IFBHX2lkbGUgZmxhZyBsb2dpYyBmcm9tIElETEVfUEFH
RV9UUkFDS0lORyBhbmQgaW50cm9kdWNlcyBuZXcga2VybmVsDQo+IGNvbmZpZywgJ1BBR0VfSURM
RV9GTEFHJy4gIEhlbmNlLCBhIG5ldyBzdWJzeXN0ZW0gd291bGQgYmUgYWJsZSB0byByZXVzZQ0K
PiBQR19pZGxlIHdpdGhvdXQgZGVwZW5kaW5nIG9uIElETEVfUEFHRV9UUkFDS0lORy4NCj4gDQo+
IEluIHRoZSBuZXh0IGNvbW1pdCwgREFNT04ncyByZWZlcmVuY2UgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIHZpcnR1YWwNCj4gbWVtb3J5IGFkZHJlc3Mgc3BhY2UgbW9uaXRvcmluZyBwcmltaXRpdmVz
IHdpbGwgdXNlIGl0Lg0KDQpbLi4uXQ0KDQpDaGVlcnMsDQoNCgkJQW1pdA0KCgoKQW1hem9uIERl
dmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3
MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

