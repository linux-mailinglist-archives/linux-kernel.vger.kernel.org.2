Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9B3E9C14
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhHLBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:53:42 -0400
Received: from m1364.mail.163.com ([220.181.13.64]:8075 "EHLO
        m1364.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhHLBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tOV6p
        Rhw5Sb2WQF1V+38C0mh1otMdM1454Q4CGOF9XM=; b=X4jq/yCVBt5rPvr1h8/nq
        pOAX15Vm9G9ea1bsxPsDFKH/C97vSr+sTrvuV+GURX2ZNHXSNdeeMP2u3Sf+1mES
        14VzI/mt7LN2vzAD4wnrWaG3nUYeft30ItErLQz2HIC6uh6JxDm+Jv3yn8CNCR4i
        DDjzoc3GgBCGyEer5Ehm9E=
Received: from slark_xiao$163.com ( [223.104.68.9] ) by ajax-webmail-wmsvr64
 (Coremail) ; Thu, 12 Aug 2021 09:52:56 +0800 (CST)
X-Originating-IP: [223.104.68.9]
Date:   Thu, 12 Aug 2021 09:52:56 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YRO3nDjt52EF1uVz@kroah.com>
References: <20210811085635.4699-1-slark_xiao@163.com>
 <YRO3nDjt52EF1uVz@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <20ff1e24.a43.17b380ffaf4.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowABXXs75fhRhx6DBAA--.5815W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrQXsZF75bLJvfgAHsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTEgMTk6NDI6MjAsICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMDQ6
NTY6MzVQTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gRm94Y29ubiBTRFg1NSBUNzdXMTc1
IGRldmljZSBpcyB3b3JraW5nIGluIFBDSWUgbW9kZSBub3JtYWxseS4KPj4gWW91IGNhbiBmaW5k
IGl0IGluIGRyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZWlyYy5jIGZpbGUuCj4+IEJ1dCBpbiBzb21l
IHNjZW5hcmlvLCB3ZSBuZWVkIHRvIGNhcHR1cmUgdGhlIG1lbW9yeSBkdW1wIG9uY2UgaXQgY3Jh
c2hlZC4KPj4gU28gYSBkaWFnIHBvcnQgZHJpdmVyIGlzIG5lZWRlZC4KPj4gCj4+IFNpZ25lZC1v
ZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJz
L3VzYi9zZXJpYWwvcWNzZXJpYWwuYyB8IDEgKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc2VyaWFsL3Fjc2VyaWFsLmMg
Yi9kcml2ZXJzL3VzYi9zZXJpYWwvcWNzZXJpYWwuYwo+PiBpbmRleCA4M2RhODIzNmUzYzguLmQ4
YjU4YWVhM2M2MCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy91c2Ivc2VyaWFsL3Fjc2VyaWFsLmMK
Pj4gKysrIGIvZHJpdmVycy91c2Ivc2VyaWFsL3Fjc2VyaWFsLmMKPj4gQEAgLTExMSw2ICsxMTEs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsKPj4g
IAl7VVNCX0RFVklDRSgweDE2ZDgsIDB4ODAwMil9LAkvKiBDTURUZWNoIEdvYmkgMjAwMCBNb2Rl
bSBkZXZpY2UgKFZVOTIyKSAqLwo+PiAgCXtVU0JfREVWSUNFKDB4MDVjNiwgMHg5MjA0KX0sCS8q
IEdvYmkgMjAwMCBRREwgZGV2aWNlICovCj4+ICAJe1VTQl9ERVZJQ0UoMHgwNWM2LCAweDkyMDUp
fSwJLyogR29iaSAyMDAwIE1vZGVtIGRldmljZSAqLwo+PiArCXtVU0JfREVWSUNFKDB4MDVjNiwg
MHg5MDFkKX0sCS8qIEZveGNvbm4gU0RYNTUgUURMICovCj4KPldoeSBpcyB0aGlzIG5vdCBzb3J0
ZWQ/Cj4KPkFuZCB0aGUgc3ViamVjdCBuZWVkcyBzb21lIHdvcmsgc3RpbGwuLi4KPgo+dGhhbmtz
LAo+Cj5ncmVnIGstaAoKSGkgR3JlZywKICBTb3JyeSwgIGNhbiB5b3Ugc2hvdyBtZSB3aGVyZSBz
aG91bGQgSSBwdXQgaXQgYXQ/CiAgQWNjb3JkaW5nIHRvIEJqw7hybiBjb21tZW50LCBJIHRoaW5r
IEkgbmVlZCB0byBjcmVhdGUgYSBuZXcgbGF5b3V0IGZvciBGb3hjb25uIFNEWDU1IGRldmljZS4K
ClRoYW5rcy4K
