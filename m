Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7513EA348
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhHLLHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:07:10 -0400
Received: from m13101.mail.163.com ([220.181.13.101]:10284 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbhHLLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:07:08 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 07:07:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Lee7l
        uoXomuWjL02EZ6WTT1sWXOa9HBvRot/xmsw8+A=; b=Q5Xau5YuoR3PZg3+i3U9X
        kQPqfBObaWKRHKWaMwrFAZs7WNqCL2FinZOU7gWkc5BcTml780OF9SnLOCPjySfK
        JXtIsdbIyiu+cNARvNUqj+n8oviHHUgMdYkRn9BYTiWyrXWFp1e1+uPln73PlOu2
        40Ym0Y44EeiEui1FXBORZ0=
Received: from slark_xiao$163.com ( [223.104.68.9] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Thu, 12 Aug 2021 18:51:05 +0800 (CST)
X-Originating-IP: [223.104.68.9]
Date:   Thu, 12 Aug 2021 18:51:05 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YRTD3szluseOmv8f@kroah.com>
References: <20210811085635.4699-1-slark_xiao@163.com>
 <YRO3nDjt52EF1uVz@kroah.com>
 <20ff1e24.a43.17b380ffaf4.Coremail.slark_xiao@163.com>
 <YRTD3szluseOmv8f@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56d172d4.79f0.17b39fcabfd.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowAC3v88Z_RRhyj+DAQ--.52514W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiox3sZFUMYg+fJAACs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTIgMTQ6NDY6NTQsICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDk6
NTI6NTZBTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gQXQgMjAyMS0wOC0xMSAxOTo0Mjoy
MCwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+ID5PbiBX
ZWQsIEF1ZyAxMSwgMjAyMSBhdCAwNDo1NjozNVBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+
PiA+PiBGb3hjb25uIFNEWDU1IFQ3N1cxNzUgZGV2aWNlIGlzIHdvcmtpbmcgaW4gUENJZSBtb2Rl
IG5vcm1hbGx5Lgo+PiA+PiBZb3UgY2FuIGZpbmQgaXQgaW4gZHJpdmVycy9idXMvbWhpL3BjaV9n
ZW5laXJjLmMgZmlsZS4KPj4gPj4gQnV0IGluIHNvbWUgc2NlbmFyaW8sIHdlIG5lZWQgdG8gY2Fw
dHVyZSB0aGUgbWVtb3J5IGR1bXAgb25jZSBpdCBjcmFzaGVkLgo+PiA+PiBTbyBhIGRpYWcgcG9y
dCBkcml2ZXIgaXMgbmVlZGVkLgo+PiA+PiAKPj4gPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlh
byA8c2xhcmtfeGlhb0AxNjMuY29tPgo+PiA+PiAtLS0KPj4gPj4gIGRyaXZlcnMvdXNiL3Nlcmlh
bC9xY3NlcmlhbC5jIHwgMSArCj4+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
Pj4gPj4gCj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9zZXJpYWwvcWNzZXJpYWwuYyBi
L2RyaXZlcnMvdXNiL3NlcmlhbC9xY3NlcmlhbC5jCj4+ID4+IGluZGV4IDgzZGE4MjM2ZTNjOC4u
ZDhiNThhZWEzYzYwIDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9zZXJpYWwvcWNzZXJp
YWwuYwo+PiA+PiArKysgYi9kcml2ZXJzL3VzYi9zZXJpYWwvcWNzZXJpYWwuYwo+PiA+PiBAQCAt
MTExLDYgKzExMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBpZF90YWJs
ZVtdID0gewo+PiA+PiAgCXtVU0JfREVWSUNFKDB4MTZkOCwgMHg4MDAyKX0sCS8qIENNRFRlY2gg
R29iaSAyMDAwIE1vZGVtIGRldmljZSAoVlU5MjIpICovCj4+ID4+ICAJe1VTQl9ERVZJQ0UoMHgw
NWM2LCAweDkyMDQpfSwJLyogR29iaSAyMDAwIFFETCBkZXZpY2UgKi8KPj4gPj4gIAl7VVNCX0RF
VklDRSgweDA1YzYsIDB4OTIwNSl9LAkvKiBHb2JpIDIwMDAgTW9kZW0gZGV2aWNlICovCj4+ID4+
ICsJe1VTQl9ERVZJQ0UoMHgwNWM2LCAweDkwMWQpfSwJLyogRm94Y29ubiBTRFg1NSBRREwgKi8K
Pj4gPgo+PiA+V2h5IGlzIHRoaXMgbm90IHNvcnRlZD8KPj4gPgo+PiA+QW5kIHRoZSBzdWJqZWN0
IG5lZWRzIHNvbWUgd29yayBzdGlsbC4uLgo+PiA+Cj4+ID50aGFua3MsCj4+ID4KPj4gPmdyZWcg
ay1oCj4+IAo+PiBIaSBHcmVnLAo+PiAgIFNvcnJ5LCAgY2FuIHlvdSBzaG93IG1lIHdoZXJlIHNo
b3VsZCBJIHB1dCBpdCBhdD8KPgo+SWYgaXQgYmVsb25ncyBpbiB0aGlzIGxpc3QsIHRoZW4gaXQg
c2hvdWxkIGJlIGluIHNvcnRlZCBvcmRlciwgd2hpY2ggeW91Cj5kaWQgbm90IGRvIGhlcmUsIHNv
IHRoYXQgd291bGQgYmUgYSBnb29kIGlkZWEsIHJpZ2h0Pwo+Cj4+ICAgQWNjb3JkaW5nIHRvIEJq
w7hybiBjb21tZW50LCBJIHRoaW5rIEkgbmVlZCB0byBjcmVhdGUgYSBuZXcgbGF5b3V0IGZvciBG
b3hjb25uIFNEWDU1IGRldmljZS4KPgo+VGhhdCBpcyB1cCB0byB5b3UgYW5kIEJqw7hybiB0byB3
b3JrIG91dCA6KQo+Cj50aGFua3MsCj4KPmdyZWcgay1oCgpIaSBHcmVnLCBCasO4cm4sCiAgIEhv
dyBhYm91dCBtb3ZlIHRoaXMgY2hhbmdlIHRvIC9kcml2ZXJzL3VzYi9zZXJpYWwvb3B0aW9uLmMg
PyBJIGp1c3QgdGVzdCBpdCBhbmQgZXZlcnl0aGluZyBpcyBvayBmb3IgbXkgZGV2aWNlLgogICBB
bmQgdGhlbiB3ZSBjYW4gaWdub3JlIHRoZSBsYXlvdXQgaXNzdWUuCgpUaGFua3M=
