Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0E3EA3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhHLLgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:36:43 -0400
Received: from m13101.mail.163.com ([220.181.13.101]:17991 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhHLLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=fLaen
        5fGJjy5YBS58lcE2pqFVuwftBf/jg4QjtkP+Lo=; b=njaD9bRlYbCgaZipIkC/C
        ktZiSNeBcTmAiFw0lBYA5Kn2T98LT+zxRsKvTHgXI/pyD4mh0utr+XU1W99mAyCZ
        Hx8H4IFEdfwfpfdN0PYSicEzSW5S+98+mp4O8Nka5aJ24C9qNhAzV66n4zzM5Kbq
        oz31h4K1nnhXk7tUR01tqQ=
Received: from slark_xiao$163.com ( [223.104.68.9] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Thu, 12 Aug 2021 19:35:46 +0800 (CST)
X-Originating-IP: [223.104.68.9]
Date:   Thu, 12 Aug 2021 19:35:46 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     hmh@hmh.eng.br, "Mark Pearson" <markpearson@lenovo.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] [v2,1/1] Fix WWAN device disabled issue after S3
 deep
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <70e53b58-4785-5a3d-9525-a7f9e93cd0d2@redhat.com>
References: <20210811093407.5583-1-slark_xiao@163.com>
 <70e53b58-4785-5a3d-9525-a7f9e93cd0d2@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1e3450a4.7c75.17b3a259499.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowADnUjWSBxVhzkKDAQ--.51803W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiowTsZFUMYhCaxAABsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDIxLTA4LTEyIDE2OjAzOjUwLCAiSGFucyBkZSBHb2VkZSIg
PGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlOgo+SGksCj4KPk9uIDgvMTEvMjEgMTE6MzQgQU0s
IFNsYXJrIFhpYW8gd3JvdGU6Cj4+IFdoZW4gV1dBTiBkZXZpY2Ugd2FrZSBmcm9tIFMzIGRlZXAs
IHVuZGVyIHRoaW5rcGFkIHBsYXRmb3JtLAo+PiBXV0FOIHdvdWxkIGJlIGRpc2FibGVkLiBUaGlz
IGRpc2FibGUgc3RhdHVzIGNvdWxkIGJlIGNoZWNrZWQKPj4gIGJ5IGNvbW1hbmQgJ25tY2xpIHIg
d3dhbicgb3IgJ3Jma2lsbCBsaXN0Jy4KPj4gSXNzdWUgYW5hbHlzaXMgYXMgYmVsb3c6Cj4+ICAg
V2hlbiBob3N0IHJlc3VtZSBmcm9tIFMzIGRlZXAsIHRoaW5rcGFkX2FjcGkgZHJpdmVyIHdvdWxk
Cj4+IGNhbGwgaG90a2V5X3Jlc3VtZSgpIGZ1bmN0aW9uLiBGaW5uYWx5LCBpdCB3aWxsIHVzZQo+
PiB3YW5fZ2V0X3N0YXR1cyB0byBjaGVjayB0aGUgY3VycmVudCBzdGF0dXMgb2YgV1dBTiBkZXZp
Y2UuCj4+IER1cmluZyB0aGlzIHJlc3VtZSBwcm9ncmVzcywgd2FuX2dldF9zdGF0dXMgd291bGQg
YWx3YXlzCj4+IHJldHVybiBvZmYgZXZlbiBXV0FOIGJvb3QgdXAgY29tcGxldGVseS4KPj4gICBJ
ZiB3YW5fZ2V0X3N0YXR1cygpIHJldHVybiBvZmYsIHJma2lsbF9zZXRfc3dfc3RhdGUoKSB3b3Vs
ZCBzZXQgV1dBTidzCj4+IHN0YXR1cyBhcyBkaXNhYmxlZC4KPj4gICBUaGlzIG1heSBiZSBhIGZh
dWx0IG9mIExFTk9WTyBCSU9TLgo+PiAgIFdvcmthcm91bmQgaXMgYWRkIGEgV1dBTiBkZXZpY2Ug
Y2hlY2sgYmVmb3JlIHJma2lsbF9zZXRfc3dfc3RhdGUoKS4KPj4gSWYgaXQncyBhIEZveGNvbm4g
V1dBTiBkZXZpY2UsIHRoZW4gd2Ugd2lsbCBpZ25vcmUgdG8gZG8gYSBzdGF0dXMgdXBkYXRlLgo+
PiAKPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+Cj5U
aGFuayB5b3UgZm9yIGRlYnVnZ2luZyB0aGlzIGFuZCB0aGFuayB5b3UgZm9yIHRoZSBwYXRjaC4K
Pgo+SSdtIG5vdCBpbiBmYXZvciBvZiB1c2luZyBhIHBjaS1kZXZpY2UtaWQgbGlzdCBoZXJlLiBN
YXliZSB3ZSBzaG91bGQKPnNpbXBseSBqdXN0IG5ldmVyIHVwZGF0ZSB0aGUgc3ctcmZraWxsIHN0
YXRlIGFmdGVyIGEgc3VzcGVuZC1yZXN1bWUgPwo+Cj5JIG1lYW4gdGhlIHN3X3N0YXRlIHNob3Vs
ZCBiZSB1bmNoYW5nZWQgYWZ0ZXIgYSBzdXNwZW5kL3Jlc3VtZS4KPgo+T25seSB0aGUgaHdfc3Rh
dGUgb24gb2xkZXIgZGV2aWNlcyB3aGljaCBzdGlsbCBoYXZlIGEgcGh5c2ljYWwKPnJhZGlvIG9u
L29mZiBzbGlkZXIgb24gdGhlIHNpZGUgbWlnaHQgaGF2ZSBjaGFuZ2VkIGR1cmluZyBzdXNwZW5k
Lgo+Cj5TbyBJIHRoaW5rIGl0IG1pZ2h0IGJlIGJldHRlciB0byBqdXN0IGRyb3AgdGhlIHRwYWNw
aV9yZmtfdXBkYXRlX3N3c3RhdGUKPmNhbGwgYWxsIHRvZ2V0aGVyIGZyb20gdGhlIHJlc3VtZSBw
YXRoPwo+Cj5NYXJrIGRvIHlvdSBoYXZlIGFueSBpbnB1dCBoZXJlPwo+Cj5SZWdhcmRzLAo+Cj5I
YW5zCj4KSGkgSGFucywKICBUaGFua3MgeW91IGZvciB5b3VyIHJlY29nbml0aW9uLgogIEkgdGhp
bmsgeW91ciBzb2x1dGlvbiB3b3VsZCBiZSBiZXR0ZXIuIE15IHNvbHV0aW9uIG9ubHkgZml4IHRo
ZSBXV0FOIGRldmljZSBiZWhhdmlvciBmcm9tIEZveGNvbm4uCiAgQW5kIE1hcmssIHlvdSBjYW4g
Y29udGFjdCB3aXRoIGdpY2F5QGxlbm92by5jb20gZm9yIHRoZSBkZXRhaWxzLgoKVGhhbmtzClNs
YXJrIFhpYW8KPgo+Cj4+IC0tLQo+PiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNw
aS5jIHwgMTYgKysrKysrKysrKysrKystLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9y
bS94ODYvdGhpbmtwYWRfYWNwaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNw
aS5jCj4+IGluZGV4IDYwMzE1NmE2ZTNlZC4uZTNiN2JjMGU3YTMzIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni90aGlua3BhZF9hY3BpLmMKPj4gKysrIGIvZHJpdmVycy9wbGF0
Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jCj4+IEBAIC0xMTU5LDYgKzExNTksMTMgQEAgc3RydWN0
IHRwYWNwaV9yZmtfb3BzIHsKPj4gIAo+PiAgc3RhdGljIHN0cnVjdCB0cGFjcGlfcmZrICp0cGFj
cGlfcmZraWxsX3N3aXRjaGVzW1RQQUNQSV9SRktfU1dfTUFYXTsKPj4gIAo+PiArLypGb3hjb25u
IFNEWDU1IFQ3N1cxNzUgcHJvZHVjdHMuIEFsbCBhdmFpbGFibGUgZGV2aWNlIElEKi8KPj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBmb3hjb25uX2RldmljZV9pZHNbXSA9IHsK
Pj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9GT1hDT05OLCAweEUwQUIpIH0sCj4+ICsJ
eyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfRk9YQ09OTiwgMHhFMEFGKSB9LAo+PiArCXsgUENJ
X0RFVklDRShQQ0lfVkVORE9SX0lEX0ZPWENPTk4sIDB4RTBCNCkgfSwKPj4gKwl7fQo+PiArfTsK
Pj4gIC8qIFF1ZXJ5IEZXIGFuZCB1cGRhdGUgcmZraWxsIHN3IHN0YXRlIGZvciBhIGdpdmVuIHJm
a2lsbCBzd2l0Y2ggKi8KPj4gIHN0YXRpYyBpbnQgdHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZShj
b25zdCBzdHJ1Y3QgdHBhY3BpX3JmayAqdHBfcmZrKQo+PiAgewo+PiBAQCAtMTE4Miw4ICsxMTg5
LDEzIEBAIHN0YXRpYyB2b2lkIHRwYWNwaV9yZmtfdXBkYXRlX3N3c3RhdGVfYWxsKHZvaWQpCj4+
ICB7Cj4+ICAJdW5zaWduZWQgaW50IGk7Cj4+ICAKPj4gLQlmb3IgKGkgPSAwOyBpIDwgVFBBQ1BJ
X1JGS19TV19NQVg7IGkrKykKPj4gLQkJdHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZSh0cGFjcGlf
cmZraWxsX3N3aXRjaGVzW2ldKTsKPj4gKwlmb3IgKGkgPSAwOyBpIDwgVFBBQ1BJX1JGS19TV19N
QVg7IGkrKykgewo+PiArCQlpZiAocGNpX2Rldl9wcmVzZW50KGZveGNvbm5fZGV2aWNlX2lkcykg
JiYgaSA9PSAxKQo+PiArCQkJcHJfaW5mbygiRmluZCBGb3hjb25uIHd3YW4gZGV2aWNlLCBpZ25v
cmUgdG8gdXBkYXRlIHJma2lsbCBzd2l0Y2ggc3RhdHVzXG4iKTsKPj4gKwkJZWxzZQo+PiArCQkJ
dHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZSh0cGFjcGlfcmZraWxsX3N3aXRjaGVzW2ldKTsKPj4g
Kwo+PiArCX0KPj4gIH0KPj4gIAo+PiAgLyoKPj4gCg==
