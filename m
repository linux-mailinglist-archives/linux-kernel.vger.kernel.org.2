Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1838C25A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhEUI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:56:54 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26640 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhEUI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1621587331; x=1653123331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=zAlN/8pufOFi3mNobV1l5D8D2g3R4Lna0qn1Ddwa+Zw=;
  b=HMzMdatabIhIbnU2IyAJwjci6FWeHpkYCkDQI62FCfC3TB8pWBju0AR9
   xXitUreWd4wnVP1D4ZkroEBL6teVJCJLTQo9YeUBNSNl5Pzt0I6xrpX4+
   F1LpPIHojGZwiOY9+Dz2p2CJi6fgsn/09YKSYiFZuGOHolhG37dZnU1jy
   I=;
X-IronPort-AV: E=Sophos;i="5.82,313,1613433600"; 
   d="scan'208";a="136149384"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 21 May 2021 08:55:24 +0000
Received: from EX13D17EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 54CE0A1ED1;
        Fri, 21 May 2021 08:55:20 +0000 (UTC)
Received: from EX13D18EUC002.ant.amazon.com (10.43.164.50) by
 EX13D17EUC003.ant.amazon.com (10.43.164.28) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 21 May 2021 08:55:19 +0000
Received: from EX13D18EUC002.ant.amazon.com ([10.43.164.50]) by
 EX13D18EUC002.ant.amazon.com ([10.43.164.50]) with mapi id 15.00.1497.018;
 Fri, 21 May 2021 08:55:19 +0000
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
Subject: Re: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
Thread-Topic: [PATCH v29 00/13] Introduce Data Access MONitor (DAMON)
Thread-Index: AQHXTU3QqJGz+I/OIE2DmHdI98UbUars9fgAgACtdoA=
Date:   Fri, 21 May 2021 08:55:18 +0000
Message-ID: <c273f5a8797a6c00c8ce004b0979961873d4fcf0.camel@amazon.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
         <20210520153426.34bfe5ab64ca1f06cca6f231@linux-foundation.org>
In-Reply-To: <20210520153426.34bfe5ab64ca1f06cca6f231@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.65]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FB15F179F2BB84EB3D4B6D2F18A443D@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEFuZHJldywNCg0KT24gVGh1LCAyMDIxLTA1LTIwIGF0IDE1OjM0IC0wNzAwLCBBbmRyZXcg
TW9ydG9uIHdyb3RlOg0KDQo+IFRoYW5rcyBmb3IgcGVyc2lzdGluZyB3aXRoIHRoaXMuDQo+IA0K
PiBJJ2QgYmUgaW50ZXJlc3RlZCBpbiBwZW9wbGUncyBvdmVyYWxsIHRha2Ugb24gdGhpcyB3b3Jr
LCBwbGVhc2UuIA0KPiBNYWlubHkgYSBoaWdoLWxldmVsICJzaG91bGQgd2UgbWVyZ2UgdGhpcyIg
dmlldy4gIERldGFpbGVkIHJldmlldyBvZg0KPiBpbXBsZW1lbnRhdGlvbiBhbmQgaW50ZXJmYWNl
IGRldGFpbHMgY2FuIGZvbGxvdyBvbiBpbiB0aGUgdXN1YWwgZmFzaGlvbi4NCg0KVGhlcmUgYXJl
IGEgZmV3IGtlcm5lbCBkZXZlbG9wZXJzIGF0IEFtYXpvbiB3YXRjaGluZyBvdmVyIHRoaXMgZWZm
b3J0LA0KYW5kIG51ZGdpbmcgaXQgYWxvbmcuICBCdXQgbW9yZSBpbXBvcnRhbnRseSwgd2UncmUg
d29ya2luZyB3aXRoIGZsZWV0DQpvd25lcnMgb3BlcmF0aW5nIGxhcmdlIGZsZWV0cyB0byBndWlk
ZSB0aGlzIGVmZm9ydC4NCg0KVGhhdCBtYWtlcyB0aGUgb3ZlcmFsbCBlZmZvcnQgYSAyLXBoYXNl
IG9uZTogcHJvZmlsaW5nIGZpcnN0ICh3aGljaCBpcw0Kd2hhdCB0aGlzIHBhdGNoc2V0IGRvZXMp
LCBhbmQgdGhlbiBpbXByb3Zpbmcgb3RoZXIgdGhpbmdzIHRoYXQgdXNlIHRoaXMNCnByb2ZpbGlu
ZyBpbmZvcm1hdGlvbiBmb3IgYmV0dGVyIHN5c3RlbSBlZmZpY2llbmNpZXMuDQoNCkFsbCB0aGF0
J3MgcHJpbWFyaWx5IGZvciB1c2UtY2FzZXMgaW50ZXJuYWxseSByaWdodCBub3cuICBPbmNlIHRo
ZSBiYXNlDQpzZXQgb2YgcGF0Y2hlcyBpcyB1cHN0cmVhbSwgd2UncmUgZ29pbmcgdG8gd29yayBv
biBhbGwgdGhlIHZhcmlvdXMgdXNlLQ0KY2FzZXMgd2UndmUgaWRlbnRpZmllZCBzbyBmYXIgd2hl
cmUgdGhpcyBpcyBnb2luZyB0byBiZSBiZW5lZmljaWFsLg0KDQpDdXJyZW50IGludGVybmFsIHVz
ZXMgYXJlIG1haW5seSBhcm91bmQgcHJvZmlsaW5nLiAgT25lIGV4YW1wbGUgaXMNCm1lbnRpb25l
ZCBieSBTZW9uZ0phZSBpbiB0aGUgY292ZXIgbGV0dGVyJ3MgIlJlYWwtd29ybGQgVXNlciBTdG9y
eSINCnNlY3Rpb24sIHdoZXJlIHR1bmluZyBwYWdlIHJlY2xhbWF0aW9uIGFsZ29yaXRobXMgYmFz
ZWQgb24gdGhpcw0KcHJvZmlsaW5nIGluZm9ybWF0aW9uIGlzIGdvaW5nIHRvIHJlc3VsdCBpbiBi
ZXR0ZXIgZWZmaWNpZW5jaWVzLCBhbmQNCmVuZXJneSBhbmQgY29zdCByZWR1Y3Rpb25zLg0KDQpB
bm90aGVyIGludGVyZXN0aW5nIHVzZWNhc2UgdGhhdCdzIGRldmVsb3BpbmcgaXMgaWRlbnRpZnlp
bmcgZnJlZSBwYWdlcw0KZm9yIHJlY2xhbWF0aW9uIGFuZCBjb21wYWN0aW9uIGJhc2VkIG9uIHRo
aXMgd29yay4gIFRoYXQncyBnb2luZyB0bw0KaGVscCBsaXZlIG1pZ3JhdGlvbiBhbmQgbWVtb3J5
IG92ZXJjb21taXQgc2NlbmFyaW9zIGZvciBLVk0gZ3Vlc3RzLiAgU0oNCmlzIHByZXBhcmluZyB0
byBzZW5kIG91dCB0aG9zZSBwYXRjaGVzIHRvIHRoZSBsaXN0cyBhcyB3ZWxsLg0KDQpUaGFua3Mh
DQoNCgkJQW1pdA0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

