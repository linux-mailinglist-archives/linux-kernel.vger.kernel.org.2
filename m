Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A83AB202
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhFQLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:12:42 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:24760 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFQLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1623928231; x=1655464231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=SjNw0JAlxWOn1JDiuTjowRxzofF3Vruoxoeez19EyRw=;
  b=IhbPAZUIrKqjhopghJV2cE/NnnvWsb66oxPomPdoCL9eRUphZCYQN/dw
   k/7x5wVaC6ExLD75Q++p6/SeTWIEAZ1VU0Le1l1NRmjuuQDeszveuCemN
   l/8F+RwEWMZNo/DdoqGqs4bs+aPc36CVZXKSVAwgYy9S/V8h3uGxOnL1f
   0=;
X-IronPort-AV: E=Sophos;i="5.83,280,1616457600"; 
   d="scan'208";a="131434296"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 17 Jun 2021 11:10:24 +0000
Received: from EX13D14EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id AE7BBA1B9C;
        Thu, 17 Jun 2021 11:10:21 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D14EUB001.ant.amazon.com (10.43.166.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 17 Jun 2021 11:10:19 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.018;
 Thu, 17 Jun 2021 11:10:19 +0000
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
Subject: Re: [PATCH v30 13/13] MAINTAINERS: Update for DAMON
Thread-Topic: [PATCH v30 13/13] MAINTAINERS: Update for DAMON
Thread-Index: AQHXYoHIR6NmEo2PmUOZPfcxaTi1cKsYDbIA
Date:   Thu, 17 Jun 2021 11:10:19 +0000
Message-ID: <45185ae07a83ea0d3a27de0a7d10d0469caee44b.camel@amazon.de>
References: <20210616073119.16758-1-sj38.park@gmail.com>
         <20210616073119.16758-14-sj38.park@gmail.com>
In-Reply-To: <20210616073119.16758-14-sj38.park@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.169]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66BD59A6B64D6C408C578CD485D5FDDC@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDA3OjMxICswMDAwLCBTZW9uZ0phZSBQYXJrIHdyb3RlOg0K
PiBGcm9tOiBTZW9uZ0phZSBQYXJrIDxzanBhcmtAYW1hem9uLmRlPg0KPiANCj4gVGhpcyBjb21t
aXQgdXBkYXRlcyBNQUlOVEFJTkVSUyBmaWxlIGZvciBEQU1PTiByZWxhdGVkIGZpbGVzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2VvbmdKYWUgUGFyayA8c2pwYXJrQGFtYXpvbi5kZT4NCj4gLS0t
DQo+ICBNQUlOVEFJTkVSUyB8IDEyICsrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTDQo+IGluZGV4IDBiY2I3ZjRjOWQ3NC4uZjY1Nzc1NDFlYjE1IDEwMDY0NA0KPiAtLS0gYS9N
QUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtNTA5NCw2ICs1MDk0LDE4IEBA
IEY6CW5ldC9heDI1L2F4MjVfb3V0LmMNCj4gIEY6CW5ldC9heDI1L2F4MjVfdGltZXIuYw0KPiAg
RjoJbmV0L2F4MjUvc3lzY3RsX25ldF9heDI1LmMNCj4gIA0KPiArREFUQSBBQ0NFU1MgTU9OSVRP
Ug0KPiArTToJU2VvbmdKYWUgUGFyayA8c2pwYXJrQGFtYXpvbi5kZT4NCj4gK0w6CWxpbnV4LW1t
QGt2YWNrLm9yZw0KPiArUzoJTWFpbnRhaW5lZA0KPiArRjoJRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9tbS9kYW1vbi8qDQo+ICtGOglEb2N1bWVudGF0aW9uL3ZtL2RhbW9uLyoNCj4gK0Y6CWlu
Y2x1ZGUvbGludXgvZGFtb24uaA0KPiArRjoJaW5jbHVkZS90cmFjZS9ldmVudHMvZGFtb24uaA0K
PiArRjoJbW0vZGFtb24vKg0KPiArRjoJdG9vbHMvZGFtb24vKg0KPiArRjoJdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvZGFtb24vKg0KPiArDQo+ICBEQVZJQ09NIEZBU1QgRVRIRVJORVQgKERNRkUp
IE5FVFdPUksgRFJJVkVSDQo+ICBMOgluZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+ICBTOglPcnBo
YW4NCg0KUmV2aWV3ZWQtYnk6IE1hcmt1cyBCb2VobWUgPG1hcmt1Ym9AYW1hem9uLmRlPg0KCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

