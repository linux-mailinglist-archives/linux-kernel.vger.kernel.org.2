Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE744A48A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhKICYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:24:41 -0500
Received: from m13101.mail.163.com ([220.181.13.101]:8864 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhKICYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:24:38 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 21:24:38 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=da2OZ
        IGjhBRiQ56M5Fhk60Ma2WvML03fZ6clcMLQxXU=; b=KUq3FDD2lxwNZh4CKgKCK
        CPBcjuu7XYLbDAJJEKXW7KpmPTvhrPvUEhlkE19dgAy6teg2L3xdhTO9cDtl8JUP
        x3ifLGeyUM9ENsGVdjAja76p1UYcQhAs4cw5vOsz0xXCH0ZLmLizrZa+yePkhTxD
        4MQcotMr8bHRC3FxLcNkaQ=
Received: from slark_xiao$163.com ( [223.104.68.17] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Tue, 9 Nov 2021 10:06:21 +0800 (CST)
X-Originating-IP: [223.104.68.17]
Date:   Tue, 9 Nov 2021 10:06:21 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     hmh@hmh.eng.br, mgross@linux.intel.com, markpearson@lenovo.com,
        njoshi1@lenovo.com, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v3] Fix WWAN device disabled issue after S3 deep
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <b3523a57-a21e-80ca-561d-23f6ee89913d@redhat.com>
References: <20211108060648.8212-1-slark_xiao@163.com>
 <b3523a57-a21e-80ca-561d-23f6ee89913d@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7821731c.1990.17d02723fb6.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowAC3MTSe14lhjmK2AQ--.38782W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrQFFZF75cQnpcQABsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIxLTExLTA4IDIyOjMyOjU2LCAiSGFucyBkZSBHb2VkZSIgPGhkZWdvZWRlQHJlZGhh
dC5jb20+IHdyb3RlOgo+SGksCj4KPk9uIDExLzgvMjEgMDc6MDYsIFNsYXJrIFhpYW8gd3JvdGU6
Cj4+IFdoZW4gV1dBTiBkZXZpY2Ugd2FrZSBmcm9tIFMzIGRlZXAsIHVuZGVyIHRoaW5rcGFkIHBs
YXRmb3JtLAo+PiBXV0FOIHdvdWxkIGJlIGRpc2FibGVkLiBUaGlzIGRpc2FibGUgc3RhdHVzIGNv
dWxkIGJlIGNoZWNrZWQKPj4gYnkgY29tbWFuZCAnbm1jbGkgciB3d2FuJyBvciAncmZraWxsIGxp
c3QnLgo+PiAKPj4gSXNzdWUgYW5hbHlzaXMgYXMgYmVsb3c6Cj4+ICAgV2hlbiBob3N0IHJlc3Vt
ZSBmcm9tIFMzIGRlZXAsIHRoaW5rcGFkX2FjcGkgZHJpdmVyIHdvdWxkCj4+IGNhbGwgaG90a2V5
X3Jlc3VtZSgpIGZ1bmN0aW9uLiBGaW5uYWx5LCBpdCB3aWxsIHVzZQo+PiB3YW5fZ2V0X3N0YXR1
cyB0byBjaGVjayB0aGUgY3VycmVudCBzdGF0dXMgb2YgV1dBTiBkZXZpY2UuCj4+IER1cmluZyB0
aGlzIHJlc3VtZSBwcm9ncmVzcywgd2FuX2dldF9zdGF0dXMgd291bGQgYWx3YXlzCj4+IHJldHVy
biBvZmYgZXZlbiBXV0FOIGJvb3QgdXAgY29tcGxldGVseS4KPj4gICBJbiBwYXRjaCBWMiwgSGFu
cyBzYWlkICdzd19zdGF0ZSBzaG91bGQgYmUgdW5jaGFuZ2VkCj4+IGFmdGVyIGEgc3VzcGVuZC9y
ZXN1bWUuIEl0J3MgYmV0dGVyIHRvIGRyb3AgdGhlCj4+IHRwYWNwaV9yZmtfdXBkYXRlX3N3c3Rh
dGUgY2FsbCBhbGwgdG9nZXRoZXIgZnJvbSB0aGUKPj4gcmVzdW1lIHBhdGgnLgo+PiAgIEFuZCBp
dCdzIGNvbmZpbWVkIGJ5IExlbm92byB0aGF0IEdXQU4gaXMgbm8gbG9uZ2VyCj4+ICBhdmFpbGFi
bGUgZnJvbSBXSEwgZ2VuZXJhdGlvbiBiZWNhdXNlIHRoZSBkZXNpZ24gZG9lcyBub3QKPj4gIG1h
dGNoIHdpdGggY3VycmVudCBwaW4gY29udHJvbC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJr
IFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPgo+VGhhbmtzLCBwYXRjaCBsb29rcyBnb29kIHRv
IG1lOgo+Cj5SZXZpZXdlZC1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4K
Pgo+SSB3aWxsIG1lcmdlIHRoaXMgb25jZSA1LjE2LXJjMSBpcyBvdXQuCj4KPlJlZ2FyZHMsCj4K
PkhhbnMKSGkgSGFucywKICAgVGhhbmtzIGZvciB0aGF0IQoKUmVnYXJkcywKU2xhcmsKPgo+PiAt
LS0KPj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L3RoaW5rcGFkX2FjcGkuYyB8IDEyIC0tLS0tLS0t
LS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3RoaW5rcGFkX2FjcGkuYyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L3RoaW5rcGFkX2FjcGkuYwo+PiBpbmRleCA1MGZmMDRjODQ2NTAuLmYxY2JkMjcyODJl
MSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jCj4+
ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3RoaW5rcGFkX2FjcGkuYwo+PiBAQCAtMTE3OCwx
NSArMTE3OCw2IEBAIHN0YXRpYyBpbnQgdHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZShjb25zdCBz
dHJ1Y3QgdHBhY3BpX3JmayAqdHBfcmZrKQo+PiAgCXJldHVybiBzdGF0dXM7Cj4+ICB9Cj4+ICAK
Pj4gLS8qIFF1ZXJ5IEZXIGFuZCB1cGRhdGUgcmZraWxsIHN3IHN0YXRlIGZvciBhbGwgcmZraWxs
IHN3aXRjaGVzICovCj4+IC1zdGF0aWMgdm9pZCB0cGFjcGlfcmZrX3VwZGF0ZV9zd3N0YXRlX2Fs
bCh2b2lkKQo+PiAtewo+PiAtCXVuc2lnbmVkIGludCBpOwo+PiAtCj4+IC0JZm9yIChpID0gMDsg
aSA8IFRQQUNQSV9SRktfU1dfTUFYOyBpKyspCj4+IC0JCXRwYWNwaV9yZmtfdXBkYXRlX3N3c3Rh
dGUodHBhY3BpX3Jma2lsbF9zd2l0Y2hlc1tpXSk7Cj4+IC19Cj4+IC0KPj4gIC8qCj4+ICAgKiBT
eW5jIHRoZSBIVy1ibG9ja2luZyBzdGF0ZSBvZiBhbGwgcmZraWxsIHN3aXRjaGVzLAo+PiAgICog
ZG8gbm90aWNlIGl0IGNhdXNlcyB0aGUgcmZraWxsIGNvcmUgdG8gc2NoZWR1bGUgdWV2ZW50cwo+
PiBAQCAtMzEyOSw5ICszMTIwLDYgQEAgc3RhdGljIHZvaWQgdHBhY3BpX3NlbmRfcmFkaW9zd191
cGRhdGUodm9pZCkKPj4gIAlpZiAod2xzdyA9PSBUUEFDUElfUkZLX1JBRElPX09GRikKPj4gIAkJ
dHBhY3BpX3Jma191cGRhdGVfaHdibG9ja19zdGF0ZSh0cnVlKTsKPj4gIAo+PiAtCS8qIFN5bmMg
c3cgYmxvY2tpbmcgc3RhdGUgKi8KPj4gLQl0cGFjcGlfcmZrX3VwZGF0ZV9zd3N0YXRlX2FsbCgp
Owo+PiAtCj4+ICAJLyogU3luYyBodyBibG9ja2luZyBzdGF0ZSBsYXN0IGlmIGl0IGlzIGh3LXVu
YmxvY2tlZCAqLwo+PiAgCWlmICh3bHN3ID09IFRQQUNQSV9SRktfUkFESU9fT04pCj4+ICAJCXRw
YWNwaV9yZmtfdXBkYXRlX2h3YmxvY2tfc3RhdGUoZmFsc2UpOwo+PiAK
