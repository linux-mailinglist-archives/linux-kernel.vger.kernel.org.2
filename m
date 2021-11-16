Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C970452B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKPG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:59:34 -0500
Received: from m13114.mail.163.com ([220.181.13.114]:31925 "EHLO
        m13114.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:59:30 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 01:59:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dm99I
        mjsnU0DiVA05qj0id/TZYTy9xCy5wMYaAe/P+0=; b=nwrCJZetRkpiCich85XjB
        /uHcbB67mXdr2Az/Q8mYrTolLwo4qL6PXUtW3ub9vre38/T/rCppgXWGD0oenDRP
        mJ3aUQ3FiBMRwvOTg2a29Rf+qyg8YKL/PZ829V1x2491M1NUoqlm4Zd6Ywc1Laxc
        h+NMz+VP1AvjTjzHN8E1+A=
Received: from slark_xiao$163.com ( [112.97.50.141] ) by
 ajax-webmail-wmsvr114 (Coremail) ; Tue, 16 Nov 2021 14:40:30 +0800 (CST)
X-Originating-IP: [112.97.50.141]
Date:   Tue, 16 Nov 2021 14:40:30 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     hmh@hmh.eng.br, mgross@linux.intel.com, markpearson@lenovo.com,
        njoshi1@lenovo.com, ibm-acpi-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re:Re:Re: [PATCH v3] Fix WWAN device disabled issue after S3 deep
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <7821731c.1990.17d02723fb6.Coremail.slark_xiao@163.com>
References: <20211108060648.8212-1-slark_xiao@163.com>
 <b3523a57-a21e-80ca-561d-23f6ee89913d@redhat.com>
 <7821731c.1990.17d02723fb6.Coremail.slark_xiao@163.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <350a209b.242b.17d2779c109.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowACHn+teUpNhQqvdAA--.22805W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxhIZGB0HqHiHQACsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMS0xMS0wOSAxMDowNjoyMSwgIlNsYXJrIFhpYW8iIDxzbGFya194aWFvQDE2My5j
b20+IHdyb3RlOgo+Cj4KPkF0IDIwMjEtMTEtMDggMjI6MzI6NTYsICJIYW5zIGRlIEdvZWRlIiA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+SGksCj4+Cj4+T24gMTEvOC8yMSAwNzowNiwg
U2xhcmsgWGlhbyB3cm90ZToKPj4+IFdoZW4gV1dBTiBkZXZpY2Ugd2FrZSBmcm9tIFMzIGRlZXAs
IHVuZGVyIHRoaW5rcGFkIHBsYXRmb3JtLAo+Pj4gV1dBTiB3b3VsZCBiZSBkaXNhYmxlZC4gVGhp
cyBkaXNhYmxlIHN0YXR1cyBjb3VsZCBiZSBjaGVja2VkCj4+PiBieSBjb21tYW5kICdubWNsaSBy
IHd3YW4nIG9yICdyZmtpbGwgbGlzdCcuCj4+PiAKPj4+IElzc3VlIGFuYWx5c2lzIGFzIGJlbG93
Ogo+Pj4gICBXaGVuIGhvc3QgcmVzdW1lIGZyb20gUzMgZGVlcCwgdGhpbmtwYWRfYWNwaSBkcml2
ZXIgd291bGQKPj4+IGNhbGwgaG90a2V5X3Jlc3VtZSgpIGZ1bmN0aW9uLiBGaW5uYWx5LCBpdCB3
aWxsIHVzZQo+Pj4gd2FuX2dldF9zdGF0dXMgdG8gY2hlY2sgdGhlIGN1cnJlbnQgc3RhdHVzIG9m
IFdXQU4gZGV2aWNlLgo+Pj4gRHVyaW5nIHRoaXMgcmVzdW1lIHByb2dyZXNzLCB3YW5fZ2V0X3N0
YXR1cyB3b3VsZCBhbHdheXMKPj4+IHJldHVybiBvZmYgZXZlbiBXV0FOIGJvb3QgdXAgY29tcGxl
dGVseS4KPj4+ICAgSW4gcGF0Y2ggVjIsIEhhbnMgc2FpZCAnc3dfc3RhdGUgc2hvdWxkIGJlIHVu
Y2hhbmdlZAo+Pj4gYWZ0ZXIgYSBzdXNwZW5kL3Jlc3VtZS4gSXQncyBiZXR0ZXIgdG8gZHJvcCB0
aGUKPj4+IHRwYWNwaV9yZmtfdXBkYXRlX3N3c3RhdGUgY2FsbCBhbGwgdG9nZXRoZXIgZnJvbSB0
aGUKPj4+IHJlc3VtZSBwYXRoJy4KPj4+ICAgQW5kIGl0J3MgY29uZmltZWQgYnkgTGVub3ZvIHRo
YXQgR1dBTiBpcyBubyBsb25nZXIKPj4+ICBhdmFpbGFibGUgZnJvbSBXSEwgZ2VuZXJhdGlvbiBi
ZWNhdXNlIHRoZSBkZXNpZ24gZG9lcyBub3QKPj4+ICBtYXRjaCB3aXRoIGN1cnJlbnQgcGluIGNv
bnRyb2wuCj4+PiAKPj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYz
LmNvbT4KPj4KPj5UaGFua3MsIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWU6Cj4+Cj4+UmV2aWV3ZWQt
Ynk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Cj4+Cj4+SSB3aWxsIG1lcmdl
IHRoaXMgb25jZSA1LjE2LXJjMSBpcyBvdXQuCj4+Cj4+UmVnYXJkcywKPj4KSGkgSGFucywKICA1
LjE2LXJjMSBpcyBhbHJlYWR5IG91dC4gQ291bGQgeW91IGhlbHAgbWVyZ2UgdGhpcyBwYXRjaCBp
bnRvIGJhc2VsaW5lIG5vdz8KClRoYW5rcyEKU2xhcmsgWGlhbwo+Pgo+Pj4gLS0tCj4+PiAgZHJp
dmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jIHwgMTIgLS0tLS0tLS0tLS0tCj4+PiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQo+Pj4gCj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYv
dGhpbmtwYWRfYWNwaS5jCj4+PiBpbmRleCA1MGZmMDRjODQ2NTAuLmYxY2JkMjcyODJlMSAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3RoaW5rcGFkX2FjcGkuYwo+Pj4gKysr
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jCj4+PiBAQCAtMTE3OCwxNSAr
MTE3OCw2IEBAIHN0YXRpYyBpbnQgdHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZShjb25zdCBzdHJ1
Y3QgdHBhY3BpX3JmayAqdHBfcmZrKQo+Pj4gIAlyZXR1cm4gc3RhdHVzOwo+Pj4gIH0KPj4+ICAK
Pj4+IC0vKiBRdWVyeSBGVyBhbmQgdXBkYXRlIHJma2lsbCBzdyBzdGF0ZSBmb3IgYWxsIHJma2ls
bCBzd2l0Y2hlcyAqLwo+Pj4gLXN0YXRpYyB2b2lkIHRwYWNwaV9yZmtfdXBkYXRlX3N3c3RhdGVf
YWxsKHZvaWQpCj4+PiAtewo+Pj4gLQl1bnNpZ25lZCBpbnQgaTsKPj4+IC0KPj4+IC0JZm9yIChp
ID0gMDsgaSA8IFRQQUNQSV9SRktfU1dfTUFYOyBpKyspCj4+PiAtCQl0cGFjcGlfcmZrX3VwZGF0
ZV9zd3N0YXRlKHRwYWNwaV9yZmtpbGxfc3dpdGNoZXNbaV0pOwo+Pj4gLX0KPj4+IC0KPj4+ICAv
Kgo+Pj4gICAqIFN5bmMgdGhlIEhXLWJsb2NraW5nIHN0YXRlIG9mIGFsbCByZmtpbGwgc3dpdGNo
ZXMsCj4+PiAgICogZG8gbm90aWNlIGl0IGNhdXNlcyB0aGUgcmZraWxsIGNvcmUgdG8gc2NoZWR1
bGUgdWV2ZW50cwo+Pj4gQEAgLTMxMjksOSArMzEyMCw2IEBAIHN0YXRpYyB2b2lkIHRwYWNwaV9z
ZW5kX3JhZGlvc3dfdXBkYXRlKHZvaWQpCj4+PiAgCWlmICh3bHN3ID09IFRQQUNQSV9SRktfUkFE
SU9fT0ZGKQo+Pj4gIAkJdHBhY3BpX3Jma191cGRhdGVfaHdibG9ja19zdGF0ZSh0cnVlKTsKPj4+
ICAKPj4+IC0JLyogU3luYyBzdyBibG9ja2luZyBzdGF0ZSAqLwo+Pj4gLQl0cGFjcGlfcmZrX3Vw
ZGF0ZV9zd3N0YXRlX2FsbCgpOwo+Pj4gLQo+Pj4gIAkvKiBTeW5jIGh3IGJsb2NraW5nIHN0YXRl
IGxhc3QgaWYgaXQgaXMgaHctdW5ibG9ja2VkICovCj4+PiAgCWlmICh3bHN3ID09IFRQQUNQSV9S
RktfUkFESU9fT04pCj4+PiAgCQl0cGFjcGlfcmZrX3VwZGF0ZV9od2Jsb2NrX3N0YXRlKGZhbHNl
KTsKPj4+IAo=
