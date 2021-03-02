Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD71632A0A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576228AbhCBE0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:26:15 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:8631 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbhCBBA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614646829; x=1646182829;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Ua/DXM8FJKK98+slS2WdpLDsXC8U/1g8AE39FOYxK3c=;
  b=MpGR4e8TDj+g6Tyz5PyWAEyrt5ZBsDHtBoNGzSlsMyESx5Wh0TZkXslJ
   2s/Cxbh4EobwQt+nZC8U4nqhocB6NgDQ08UVgOIrZ8WtZN6YXYmsFXTvJ
   TRjV4f6SsmlB3tdOvshDy7fxZ69BbE5np8mbWVGiN9F5PA3T403RuUjr+
   M=;
X-IronPort-AV: E=Sophos;i="5.81,216,1610409600"; 
   d="scan'208";a="89911862"
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Thread-Topic: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 02 Mar 2021 00:59:46 +0000
Received: from EX13D19EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 1EDB8A28E4;
        Tue,  2 Mar 2021 00:59:44 +0000 (UTC)
Received: from EX13D07UWB002.ant.amazon.com (10.43.161.131) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Mar 2021 00:59:41 +0000
Received: from EX13D07UWB002.ant.amazon.com ([10.43.161.131]) by
 EX13D07UWB002.ant.amazon.com ([10.43.161.131]) with mapi id 15.00.1497.010;
 Tue, 2 Mar 2021 00:59:40 +0000
From:   "Zhang, Wei" <wzam@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pressman, Gal" <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Thread-Index: AQHXBYW1Cxdjm83Ou0WQu1keqqe3eapvPpqAgACsXgCAAACCgP//ggMA
Date:   Tue, 2 Mar 2021 00:59:40 +0000
Message-ID: <AE355B8D-8496-4CDF-9BC0-A8D6DE0F9C34@amazon.com>
References: <20210217233547.93892-1-peterx@redhat.com>
 <20210301141151.GA397383@xz-x1>
 <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
 <20210302003035.GE444867@ziepe.ca>
In-Reply-To: <20210302003035.GE444867@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.104]
Content-Type: text/plain; charset="utf-8"
Content-ID: <419155D0BE2699428B9630C87C699256@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpZZXMsIHN1Y2ggdXNlciBpbmNsdWRlcyBsaWJmYWJyaWMgKGh0dHBzOi8vb2Zpd2cuZ2l0aHVi
LmlvL2xpYmZhYnJpYy8pIC4gd2hpY2ggdXNlcyBodWdldGxiIHBhZ2VzLg0KIA0K77u/T24gMy8x
LzIxLCA0OjMwIFBNLCAiSmFzb24gR3VudGhvcnBlIiA8amdnQHppZXBlLmNhPiB3cm90ZToNCg0K
ICAgIENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQoNCg0KDQogICAgT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDQ6Mjg6NDZQTSAtMDgwMCwgQW5k
cmV3IE1vcnRvbiB3cm90ZToNCiAgICA+IE9uIE1vbiwgMSBNYXIgMjAyMSAwOToxMTo1MSAtMDUw
MCBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+ID4gT24g
V2VkLCBGZWIgMTcsIDIwMjEgYXQgMDY6MzU6NDJQTSAtMDUwMCwgUGV0ZXIgWHUgd3JvdGU6DQog
ICAgPiA+ID4gdjU6DQogICAgPiA+ID4gLSBwYXRjaCA0OiBjaGFuZ2UgImludCBjb3ciIGludG8g
ImJvb2wgY293Ig0KICAgID4gPiA+IC0gY29sbGVjdCByLWJzIGZvciBKYXNvbg0KICAgID4gPg0K
ICAgID4gPiBBbmRyZXcsDQogICAgPiA+DQogICAgPiA+IEkganVzdCBub3RpY2VkIDUuMTItcmMx
IGhhcyByZWxlYXNlZDsgaXMgdGhpcyBzZXJpZXMgc3RpbGwgcG9zc2libGUgdG8gbWFrZSBpdA0K
ICAgID4gPiBmb3IgNS4xMiwgb3IgbmVlZHMgdG8gd2FpdCBmb3IgNS4xMz8NCiAgICA+ID4NCiAg
ICA+DQogICAgPiBJdCBoYXMgdGFrZW4gYSB3aGlsZSB0byBzZXR0bGUgZG93bi4gIFdoYXQgaXMg
dGhlIGNhc2UgZm9yDQogICAgPiBmYXN0LXRyYWNraW5nIGl0IGludG8gNS4xMj8NCg0KICAgIElJ
UkMgaHVnZXRsYiB1c2VycyBhbmQgZm9yayBhbmQgRE1BIHdpbGwgZ2V0IHRoZSB1bmV4cGVjdGVk
IFZBDQogICAgY29ycnVwdGlvbiB0aGF0IHRyaWdnZXJlZCBhbGwgdGhpcyB3b3JrLg0KDQogICAg
SmFzb24NCg0K
