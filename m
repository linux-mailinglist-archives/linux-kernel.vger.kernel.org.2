Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5200B3AEB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:38:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:11388 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1624286154; x=1655822154;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FcwobHhbJLD90H/Svaz513OCpIOMqIcloJDeG4LnHQM=;
  b=HnA4eBu3nQXD9FNWTRnc0mVBXJHT8mXwuLNH2Rm64wdF8km48neNYK8/
   SdN/U/JizBkKF9jaGi6OY4dx7aUna3jnP2foAFbcPzxPzywJqNSbPBdfY
   irfPfVOQ87YvodfBVc9z0Lnup1flqiRuI2g8CnY5jKmYTXC6sK070RtMu
   U=;
X-IronPort-AV: E=Sophos;i="5.83,289,1616457600"; 
   d="scan'208";a="141304827"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 21 Jun 2021 14:35:47 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id A3346A0571;
        Mon, 21 Jun 2021 14:35:46 +0000 (UTC)
Received: from 38f9d34ed3b1.ant.amazon.com (10.43.162.178) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Mon, 21 Jun 2021 14:35:42 +0000
Subject: Re: [PATCH v2] nitro_enclaves: Set Bus Master for the NE PCI device
To:     "Longpeng(Mike)" <longpeng2@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <arei.gonglei@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Vasile <lexnv@amazon.com>,
        Alexandru Ciobotaru <alcioa@amazon.com>
References: <20210621004046.1419-1-longpeng2@huawei.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
Message-ID: <f1e75453-b7db-17c7-fc52-0d233073784c@amazon.com>
Date:   Mon, 21 Jun 2021 17:35:32 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210621004046.1419-1-longpeng2@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.178]
X-ClientProxiedBy: EX13D18UWA004.ant.amazon.com (10.43.160.45) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAyMS8wNi8yMDIxIDAzOjQwLCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPiBFbmFibGUgQnVz
IE1hc3RlciBmb3IgdGhlIE5FIFBDSSBkZXZpY2UsIGFjY29yZGluZyB0byB0aGUgUENJIHNwZWMK
PiBmb3Igc3VibWl0dGluZyBtZW1vcnkgb3IgSS9PIHJlcXVlc3RzOgo+Cj4gICBNYXN0ZXIgRW5h
YmxlIOKAkyBDb250cm9scyB0aGUgYWJpbGl0eSBvZiBhIFBDSSBFeHByZXNzCj4gICAgRW5kcG9p
bnQgdG8gaXNzdWUgTWVtb3J5IGFuZCBJL08gUmVhZC9Xcml0ZSBSZXF1ZXN0cywgYW5kCj4gICAg
dGhlIGFiaWxpdHkgb2YgYSBSb290IG9yIFN3aXRjaCBQb3J0IHRvIGZvcndhcmQgTWVtb3J5IGFu
ZAo+ICAgIEkvTyBSZWFkL1dyaXRlIFJlcXVlc3RzIGluIHRoZSBVcHN0cmVhbSBkaXJlY3Rpb24K
Pgo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+
IENjOiBBbmRyYSBQYXJhc2NoaXYgPGFuZHJhcHJzQGFtYXpvbi5jb20+Cj4gQ2M6IEFsZXhhbmRy
dSBWYXNpbGUgPGxleG52QGFtYXpvbi5jb20+Cj4gQ2M6IEFsZXhhbmRydSBDaW9ib3RhcnUgPGFs
Y2lvYUBhbWF6b24uY29tPgo+IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5nKE1pa2UpIDxsb25ncGVu
ZzJAaHVhd2VpLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIHNpbmNlIHYxOgo+ICAgIC0gdXBkYXRlIHRo
ZSBjb21taXQgbWVzc2FnZS4gW0FuZHJhXQo+IC0tLQo+ICAgZHJpdmVycy92aXJ0L25pdHJvX2Vu
Y2xhdmVzL25lX3BjaV9kZXYuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfcGNp
X2Rldi5jIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX3BjaV9kZXYuYwo+IGluZGV4
IGI5YzFkZTQuLjE0MzIwN2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xh
dmVzL25lX3BjaV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9w
Y2lfZGV2LmMKPiBAQCAtNDgwLDYgKzQ4MCw4IEBAIHN0YXRpYyBpbnQgbmVfcGNpX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4gICAg
ICAgICAgICAgICAgICBnb3RvIGZyZWVfbmVfcGNpX2RldjsKPiAgICAgICAgICB9Cj4KPiArICAg
ICAgIHBjaV9zZXRfbWFzdGVyKHBkZXYpOwo+ICsKPiAgICAgICAgICByYyA9IHBjaV9yZXF1ZXN0
X3JlZ2lvbnNfZXhjbHVzaXZlKHBkZXYsICJuaXRyb19lbmNsYXZlcyIpOwo+ICAgICAgICAgIGlm
IChyYyA8IDApIHsKPiAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkVycm9y
IGluIHBjaSByZXF1ZXN0IHJlZ2lvbnMgW3JjPSVkXVxuIiwgcmMpOwo+IC0tCj4gMS44LjMuMQo+
CgpSZXZpZXdlZC1ieTogQW5kcmEgUGFyYXNjaGl2IDxhbmRyYXByc0BhbWF6b24uY29tPgoKVGhh
bmsgeW91LgoKQW5kcmEKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciAoUm9tYW5pYSkgUy5S
LkwuIHJlZ2lzdGVyZWQgb2ZmaWNlOiAyN0EgU2YuIExhemFyIFN0cmVldCwgVUJDNSwgZmxvb3Ig
MiwgSWFzaSwgSWFzaSBDb3VudHksIDcwMDA0NSwgUm9tYW5pYS4gUmVnaXN0ZXJlZCBpbiBSb21h
bmlhLiBSZWdpc3RyYXRpb24gbnVtYmVyIEoyMi8yNjIxLzIwMDUuCg==

