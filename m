Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613DC336B49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCKFBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:01:20 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:49558 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhCKFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615438854; x=1646974854;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=IWI4+2gSrZACZzxQChsLqpe+HvfyCpuEwUIo/DVKsDs=;
  b=FPM2ndaFU1R0rnPUc+RNdZml2LvtjlrrZz7zKhnKmLbw5gUoEwoh0XBC
   rJy5LAh4GnpUHInVNR/bziHieu4oy/ZtKMKIGJykAUf4fddDyWv5VIATT
   3ixk4QjFJpEiMh+QrxZ9mmUA9eFfq+wVndxxzTzd3XVYkEthZPNGCpTao
   M=;
IronPort-HdrOrdr: A9a23:+FBHJ6jhTEtXdf2ttEK7exZcGHBQXxB13DAbvn1ZSRFFG/Gwvc
 aogfgdyFvImC8cMUtQ/eyoFYuhZTfn9ZBz6ZQMJrvKZmKNhEKEJJxvhLGO/xTOFyHy/eZW1+
 NBXsFFeaLNJHdgi8KS2mWFOvYmhOKK6aW5wdrZpk0dLj1CT4FFw0NHBh2AEktwLTM2YKYRMJ
 aH/MJIq36BVB0sDviTPXUOU+jdq9CjrvuPXTc8Cwcj+E2yi1qThoLSKRSe0xsEOgkh/Z4Z7W
 PHnwblj5/T0c2T9xm07Q7uxqUTovfajv1eGcKLis8aQw+c9jqAVcBae5nHlDopvOmrrHkwlt
 2kmWZcA+1Dr0nwWiWfpBPm2Szhyisj5jvYxVWZmHvuptHiLQhKbPZptMZiUj+cxkwroNVx17
 8O/2/xjesuMTrw2B7cw5zkURt3kkayvD4Zm+8ei3Q3a/p5VJZh6bY+2Ad0CtMpFj/77odiOv
 JjBNzRjcwmC2+yXjTink0q+dS2UnMvWjiBR0UPoaWuokNrtUE89Ws9gPEYhzMk+I0wTt1q4e
 HIPr8ArsA2cvMr
X-IronPort-AV: E=Sophos;i="5.81,239,1610409600"; 
   d="scan'208";a="918217041"
Subject: Re: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for arm64
Thread-Topic: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for arm64
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 11 Mar 2021 05:00:45 +0000
Received: from EX13D22EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 47476A1791;
        Thu, 11 Mar 2021 05:00:44 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13D22EUA004.ant.amazon.com (10.43.165.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Mar 2021 05:00:43 +0000
Received: from EX13D22EUA003.ant.amazon.com ([10.43.165.210]) by
 EX13D22EUA003.ant.amazon.com ([10.43.165.210]) with mapi id 15.00.1497.012;
 Thu, 11 Mar 2021 05:00:42 +0000
From:   "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
To:     Chen Huang <chenhuang5@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "rientjes@google.com" <rientjes@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "Umesh Sargur, Gautam" <sargur@amazon.com>
Thread-Index: AQHXFX2f1iiLEa+yjUWtpclelFHNUap+Lo8AgABpoYA=
Date:   Thu, 11 Mar 2021 05:00:42 +0000
Message-ID: <ED06294F-F046-4B21-9E52-F439C2B32B45@amazon.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
 <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
In-Reply-To: <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B8D232915107C4182231959190CBBC9@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hlbiwgaXMgeW91ciB0ZXN0aW5nIHN0ZXBzIGRvY3VtZW50ZWQgc29tZXdoZXJlLCBjYW4geW91
IHBsZWFzZSBwb2ludCB1cyB0byB0aGUgc2FtZS4gSSBmb2xsb3dlZCBzb21lIHN0ZXBzIGZvciB0
ZXN0aW5nIHRoZSB4ODYgcGF0Y2hlcywganVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIEkgYW0gY292
ZXJpbmcgeW91ciB0ZXN0cyBhcyB3ZWxsLiBXZSBhcmUgYWN0aXZlbHkgd29ya2luZyBvbiBidWls
ZGluZyBhbmQgdGVzdGluZyB0aGVzZSBwYXRjaGVzIGZvciBBUk0uDQoNCu+7v09uIDExLzAzLzIx
LCA5OjQ0IEFNLCAiQ2hlbiBIdWFuZyIgPGNoZW5odWFuZzVAaHVhd2VpLmNvbT4gd3JvdGU6DQoN
CiAgICBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KDQoNCg0KICAgIOWcqCAyMDIxLzMvMTAgMTU6MTUsIE11Y2h1biBTb25nIOWGmemBkzoNCiAg
ICA+IFRoaXMgcGF0Y2hzZXQgaXMgYmFzZWQgb24gdGhlIHNlcmllcyBvZiAiRnJlZSBzb21lIHZt
ZW1tYXAgcGFnZXMgb2YgSHVnZVRMQg0KICAgID4gcGFnZSIuIE1vcmUgZGV0YWlscyBjYW4gcmVm
ZXIgdG8gdGhlIGJlbG93IGxpbmsuDQogICAgPg0KICAgID4gICBodHRwczovL2xrbWwua2VybmVs
Lm9yZy9yLzIwMjEwMzA4MTAyODA3LjU5NzQ1LTEtc29uZ211Y2h1bkBieXRlZGFuY2UuY29tDQog
ICAgPg0KICAgID4gSSBvZnRlbiByZWNlaXZlZCBzb21lIGZlZWRiYWNrIChXZSB3YW50IHRvIHRl
c3QgdGhpcyBmZWF0dXJlIG9uIGFybTY0KSBiZWZvcmUuDQogICAgPiBCZWNhdXNlIHRoZSBwcmV2
aW91cyBjb2RlIGhhcyBiZWVuIHJldmlld2VkIGZvciAxOCB2ZXJzaW9ucyBhbmQgaXMgbWVyZ2Vk
DQogICAgPiBpbnRvIG1tIHRyZWUsIEkgdGhpbmsgdGhhdCBpdCBpcyB0aW1lIHRvIHJlbGVhc2Ug
dGhpcyBwYXRjaHNldC4gSWYgeW91IHdhbnQNCiAgICA+IHRvIHRlc3QgdGhlbiB5b3UgY2FuIHN0
YXJ0IG5vdyA6LSkuIEFuZCBJIGFsc28gaG9wZSBzb21lb25lIGNhbiByZXZpZXcgdGhpcy4NCiAg
ICA+DQogICAgPiBUaGFua3MuDQogICAgPg0KICAgID4gTXVjaHVuIFNvbmcgKDMpOg0KICAgID4g
ICBtbTogYm9vdG1lbV9pbmZvOiBtYXJrIHJlZ2lzdGVyX3BhZ2VfYm9vdG1lbV9pbmZvX3NlY3Rp
b24gX19pbml0DQogICAgPiAgIG1tOiBodWdldGxiOiBpbnRyb2R1Y2UgYXJjaF9mcmVlX3ZtZW1t
YXBfcGFnZQ0KICAgID4gICBhcm02NDogbW06IGh1Z2V0bGI6IGFkZCBzdXBwb3J0IGZvciBmcmVl
IHZtZW1tYXAgcGFnZXMgb2YgSHVnZVRMQg0KICAgID4NCiAgICA+ICBhcmNoL2FybTY0L21tL21t
dS5jICAgfCA1ICsrKysrDQogICAgPiAgYXJjaC94ODYvbW0vaW5pdF82NC5jIHwgNSArKysrKw0K
ICAgID4gIGZzL0tjb25maWcgICAgICAgICAgICB8IDQgKystLQ0KICAgID4gIG1tL2Jvb3RtZW1f
aW5mby5jICAgICB8IDQgKystLQ0KICAgID4gIG1tL3NwYXJzZS12bWVtbWFwLmMgICB8IDkgKysr
KysrKy0tDQogICAgPiAgNSBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KICAgID4NCg0KICAgIFRlc3RlZC1ieTogQ2hlbiBIdWFuZyA8Y2hlbmh1YW5nNUBo
dWF3ZWkuY29tPg0KDQogICAgSSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2ggYW5kIHRoZSByZXN1bHQg
aXMgc2FtZSBhcyB0aGUgbGFzdCB0aW1lLg0KDQo=
