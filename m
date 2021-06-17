Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F93AB1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhFQLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:09:44 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44966 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhFQLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623928052; x=1655464052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=+BkQlTcpQMgDlwUQiT9p+dZNhdj6d7z73rymX6g0Y/s=;
  b=shd4uroZsKt6IO3Z7y4IvD//pU//1KoFYYyb8vyyKoYGGR14KBFkTQx9
   wZ1G0cvTA7helaXRUQDyLwR08UAs19SMK3/5m3N4jMFfLhMDKycQLdqEQ
   OcKxxhNCxtlH2YeoPOmh/44LYY8G/AyBQdf+VtH6574J0cwwwNT+29O6y
   o=;
X-IronPort-AV: E=Sophos;i="5.83,280,1616457600"; 
   d="scan'208";a="140641814"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 17 Jun 2021 11:07:22 +0000
Received: from EX13D08EUB003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 8A86EA1860;
        Thu, 17 Jun 2021 11:07:11 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D08EUB003.ant.amazon.com (10.43.166.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 17 Jun 2021 11:07:10 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.018;
 Thu, 17 Jun 2021 11:07:10 +0000
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
Subject: Re: [PATCH v30 10/13] Documentation: Add documents for DAMON
Thread-Topic: [PATCH v30 10/13] Documentation: Add documents for DAMON
Thread-Index: AQHXYoHRO6t1j0COMUyCO/a1OiXYyKsYDM8A
Date:   Thu, 17 Jun 2021 11:07:10 +0000
Message-ID: <3a28ba410a6f6b69f1eb01f19c61f8dd7412d26d.camel@amazon.de>
References: <20210616073119.16758-1-sj38.park@gmail.com>
         <20210616073119.16758-11-sj38.park@gmail.com>
In-Reply-To: <20210616073119.16758-11-sj38.park@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.186]
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EAAD5FF01E6F44BDF2D64F7383EEB8@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDA3OjMxICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBGcm9tOiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiANCj4gVGhpcyBjb21t
aXQgYWRkcyBkb2N1bWVudHMgZm9yIERBTU9OIHVuZGVyDQo+IGBEb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL21tL2RhbW9uL2AgYW5kIGBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2AuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiBSZXZpZXdl
ZC1ieTogRmVybmFuZCBTaWViZXIgPHNpZWJlcmZAYW1hem9uLmNvbT4NCj4gLS0tDQo+ICBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL2luZGV4LnJzdCB8ICAxNSArKw0KPiAgRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kYW1vbi9zdGFydC5yc3QgfCAxMTQgKysrKysrKysr
KysrKw0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kYW1vbi91c2FnZS5yc3QgfCAx
MTIgKysrKysrKysrKysrKw0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9pbmRleC5y
c3QgICAgICAgfCAgIDEgKw0KPiAgRG9jdW1lbnRhdGlvbi92bS9kYW1vbi9hcGkucnN0ICAgICAg
ICAgICAgICAgfCAgMjAgKysrDQo+ICBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2Rlc2lnbi5yc3Qg
ICAgICAgICAgICB8IDE2NiArKysrKysrKysrKysrKysrKysrDQo+ICBEb2N1bWVudGF0aW9uL3Zt
L2RhbW9uL2ZhcS5yc3QgICAgICAgICAgICAgICB8ICA1MSArKysrKysNCj4gIERvY3VtZW50YXRp
b24vdm0vZGFtb24vaW5kZXgucnN0ICAgICAgICAgICAgIHwgIDMwICsrKysNCj4gIERvY3VtZW50
YXRpb24vdm0vaW5kZXgucnN0ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIDkgZmlsZXMg
Y2hhbmdlZCwgNTEwIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL21tL2RhbW9uL2luZGV4LnJzdA0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGFtb24vc3RhcnQucnN0DQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kYW1vbi91c2FnZS5y
c3QNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2FwaS5yc3QN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2Rlc2lnbi5yc3QN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2ZhcS5yc3QNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZtL2RhbW9uL2luZGV4LnJzdA0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IE1hcmt1cyBCb2VobWUgPG1hcmt1Ym9AYW1hem9uLmRlPg0KCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4g
V2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

