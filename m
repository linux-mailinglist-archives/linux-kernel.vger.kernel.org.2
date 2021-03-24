Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49033474E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhCXJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:43:20 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:34988 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhCXJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:42:45 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id AD7D12837D3;
        Wed, 24 Mar 2021 17:42:40 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIkA7ACRDgaC69YJCBpgk4oo.3.1616578960701.Hmail.wangqing@vivo.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFJlOiBSZTogW1BBVENIIFYyXSB3b3JrcXVldWU6IHdhdGNoZG9nOiB1cGRhdGUgd3Ffd2F0Y2hkb2dfdG91Y2hlZCBmb3IgdW5ib3VuZCBsb2NrdXAgY2hlY2tpbmc=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <YFr9a5tws6PhAjye@alley>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 24 Mar 2021 17:42:40 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Wed, 24 Mar 2021 17:42:40 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHk5LHx5NQ0gYTE4fVkpNSk1OTENCTUtMSElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JSElOSU5NQ0JDN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MhA6TDo4KT8cGjhNQiIxODkLHBBPFBRVSFVKTUpNTkxDQk1KTU5NVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSE1VSk5JVUpPTlVKQ0lZV1kIAVlBTEhPQjcG
X-HM-Tid: 0a78639d5d4b9395kuwsad7d12837d3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBXZWQgMjAyMS0wMy0yNCAxMDoxNjo0Niwg546L5pOOIHdyb3RlOgo+PiAKPj4gPk9uIFR1
ZSAyMDIxLTAzLTIzIDIwOjM3OjM1LCDnjovmk44gd3JvdGU6Cj4+ID4+IAo+PiA+PiA+T24gRnJp
IDIwMjEtMDMtMTkgMTY6MDA6MzYsIFdhbmcgUWluZyB3cm90ZToKPj4gPj4gPj4gV2hlbiB0b3Vj
aF9zb2Z0bG9ja3VwX3dhdGNoZG9nKCkgaXMgY2FsbGVkLCBvbmx5IHdxX3dhdGNoZG9nX3RvdWNo
ZWRfY3B1IAo+PiA+PiA+PiB1cGRhdGVkLCB3aGlsZSB0aGUgdW5ib3VuZCB3b3JrZXJfcG9vbCBy
dW5uaW5nIG9uIGl0cyBjb3JlIHVzZXMgCj4+ID4+ID4+IHdxX3dhdGNoZG9nX3RvdWNoZWQgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgbG9ja2VkIHVwLiBUaGlzIG1heSBiZSBtaXNjaGVja2VkLgo+PiA+
PiA+Cj4+ID4+ID5CeSBvdGhlciB3b3JkcywgdW5ib3VuZCB3b3JrcXVldWVzIGFyZSBub3QgYXdh
cmUgb2YgdGhlIG1vcmUgY29tbW9uCj4+ID4+ID50b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9nKCkg
YmVjYXVzZSBpdCB1cGRhdGVzIG9ubHkKPj4gPj4gPndxX3dhdGNoZG9nX3RvdWNoZWRfY3B1IGZv
ciB0aGUgYWZmZWN0ZWQgQ1BVLiBBcyBhIHJlc3VsdCwKPj4gPj4gPnRoZSB3b3JrcXVldWUgd2F0
Y2hkb2cgbWlnaHQgcmVwb3J0IGxvY2t1cCBpbiB1bmJvdW5kIHdvcmtxdWV1ZQo+PiA+PiA+ZXZl
biB0aG91Z2ggaXQgaXMgYmxvY2tlZCBieSBhIGtub3duIHNsb3cgY29kZS4KPj4gPj4gCj4+ID4+
IFllcywgdGhpcyBpcyB0aGUgcHJvYmxlbSBJJ20gdGFsa2luZyBhYm91dC4KPj4gPgo+PiA+SSB0
aG91Z2h0IG1vcmUgYWJvdXQgaXQuIFRoaXMgcGF0Y2ggcHJldmVudHMgYSBmYWxzZSBwb3NpdGl2
ZS4KPj4gPkNvdWxkIGl0IGJyaW5nIGFuIG9wcG9zaXRlIHByb2JsZW0gYW5kIGhpZGUgcmVhbCBw
cm9ibGVtcz8KPj4gPgo+PiA+SSBtZWFuIHRoYXQgYW4gdW5ib3VuZCB3b3JrcXVldWUgbWlnaHQg
Z2V0IGJsb2NrZWQgb24gQ1BVIEEKPj4gPmJlY2F1c2Ugb2YgYSByZWFsIHNvZnRsb2NrdXAuIEJ1
dCB3ZSBtaWdodCBub3Qgbm90aWNlIGl0IGJlY2F1c2UKPj4gPkNQVSBCIGlzIHRvdWNoZWQuIFdl
bGwsIHRoZXJlIGFyZSBvdGhlciB3YXlzIGhvdyB0byBkZXRlY3QKPj4gPnRoaXMgc2l0dWF0aW9u
LCBlLmcuIHRoZSBzb2Z0bG9ja3VwIHdhdGNoZG9nLgo+PiA+Cj4+ID4KPj4gPj4gPj4gTXkgc3Vn
Z2VzdGlvbiBpcyB0byB1cGRhdGUgYm90aCB3aGVuIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2co
KSBpcyBjYWxsZWQsIAo+PiA+PiA+PiB1c2Ugd3Ffd2F0Y2hkb2dfdG91Y2hlZF9jcHUgdG8gY2hl
Y2sgYm91bmQsIGFuZCB1c2Ugd3Ffd2F0Y2hkb2dfdG91Y2hlZCAKPj4gPj4gPj4gdG8gY2hlY2sg
dW5ib3VuZCB3b3JrZXJfcG9vbC4KPj4gPj4gPj4gCj4+ID4+ID4+IFNpZ25lZC1vZmYtYnk6IFdh
bmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+ID4+ID4+IC0tLQo+PiA+PiA+PiAga2VybmVs
L3dhdGNoZG9nLmMgIHwgIDUgKysrLS0KPj4gPj4gPj4gIGtlcm5lbC93b3JrcXVldWUuYyB8IDE3
ICsrKysrKy0tLS0tLS0tLS0tCj4+ID4+ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pCj4+ID4+ID4+IAo+PiA+PiA+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3dhdGNoZG9nLmMgYi9rZXJuZWwvd2F0Y2hkb2cuYwo+PiA+PiA+PiBpbmRleCA3MTEwOTA2
Li4xMDdiYzM4Cj4+ID4+ID4+IC0tLSBhL2tlcm5lbC93YXRjaGRvZy5jCj4+ID4+ID4+ICsrKyBi
L2tlcm5lbC93YXRjaGRvZy5jCj4+ID4+ID4+IEBAIC0yNzgsOSArMjc4LDEwIEBAIHZvaWQgdG91
Y2hfYWxsX3NvZnRsb2NrdXBfd2F0Y2hkb2dzKHZvaWQpCj4+ID4+ID4+ICAJICogdXBkYXRlIGFz
IHdlbGwsIHRoZSBvbmx5IHNpZGUgZWZmZWN0IG1pZ2h0IGJlIGEgY3ljbGUgZGVsYXkgZm9yCj4+
ID4+ID4+ICAJICogdGhlIHNvZnRsb2NrdXAgY2hlY2suCj4+ID4+ID4+ICAJICovCj4+ID4+ID4+
IC0JZm9yX2VhY2hfY3B1KGNwdSwgJndhdGNoZG9nX2FsbG93ZWRfbWFzaykKPj4gPj4gPj4gKwlm
b3JfZWFjaF9jcHUoY3B1LCAmd2F0Y2hkb2dfYWxsb3dlZF9tYXNrKSB7Cj4+ID4+ID4+ICAJCXBl
cl9jcHUod2F0Y2hkb2dfdG91Y2hfdHMsIGNwdSkgPSBTT0ZUTE9DS1VQX1JFU0VUOwo+PiA+PiA+
PiAtCXdxX3dhdGNoZG9nX3RvdWNoKC0xKTsKPj4gPj4gPj4gKwkJd3Ffd2F0Y2hkb2dfdG91Y2go
Y3B1KTsKPj4gPj4gPgo+PiA+PiA+Tm90ZSB0aGF0IHdxX3dhdGNoZG9nX3RvdWNoKGNwdSkgbmV3
bHkgYWx3YXlzIHVwZGF0ZXMKPj4gPj4gPndxX3dhdGNoZG9nX3RvdWNoZWQuIFRoaXMgY3ljbGUg
d2lsbCBzZXQgdGhlIHNhbWUgamlmZmllcwo+PiA+PiA+dmFsdWUgY3B1LXRpbWVzIHRvIHRoZSBz
YW1lIHZhcmlhYmxlLgo+PiA+PiA+Cj4+ID4+IEFsdGhvdWdoIHRoZXJlIGlzIGEgYml0IG9mIHJl
ZHVuZGFuY3kgaGVyZSwgYnV0IHRoZSBtb3N0IGNvbmNpc2Ugd2F5IG9mIAo+PiA+PiBpbXBsZW1l
bnRhdGlvbiwgYW5kIGl0IGlzIGNlcnRhaW4gdGhhdCBpdCB3aWxsIG5vdCBhZmZlY3QgcGVyZm9y
bWFuY2UuCj4+ID4+IAo+PiBBbm90aGVyIHdheSB0byBpbXBsZW1lbnQgaXMgd3Ffd2F0Y2hkb2df
dG91Y2goKSByZW1haW4gdW5jaGFuZ2VkLCBidXQgbmVlZCAKPj4gdG8gbW9kaWZ5IHRvdWNoX3Nv
ZnRsb2NrdXBfd2F0Y2hkb2coKSBhbmQgdG91Y2hfYWxsX3NvZnRsb2NrdXBfd2F0Y2hkb2dzKCk6
Cj4+IG5vdHJhY2Ugdm9pZCB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9nKHZvaWQpCj4+IHsKPj4g
CXRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2dfc2NoZWQoKTsKPj4gCXdxX3dhdGNoZG9nX3RvdWNo
KHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+PiArICAgICB3cV93YXRjaGRvZ190b3VjaCgtMSk7
Cj4+IH0KPj4gdm9pZCB0b3VjaF9hbGxfc29mdGxvY2t1cF93YXRjaGRvZ3Modm9pZCkKPj4gICog
dXBkYXRlIGFzIHdlbGwsIHRoZSBvbmx5IHNpZGUgZWZmZWN0IG1pZ2h0IGJlIGEgY3ljbGUgZGVs
YXkgZm9yCj4+ICAqIHRoZSBzb2Z0bG9ja3VwIGNoZWNrLgo+PiAqLwo+PiAgLQlmb3JfZWFjaF9j
cHUoY3B1LCAmd2F0Y2hkb2dfYWxsb3dlZF9tYXNrKQo+PiArCWZvcl9lYWNoX2NwdShjcHUsICZ3
YXRjaGRvZ19hbGxvd2VkX21hc2spIHsKPj4gICAJCXBlcl9jcHUod2F0Y2hkb2dfdG91Y2hfdHMs
IGNwdSkgPSBTT0ZUTE9DS1VQX1JFU0VUOwo+PiAgKwkJd3Ffd2F0Y2hkb2dfdG91Y2goY3B1KTsK
Pj4gICsJfQo+PiAgCXdxX3dhdGNoZG9nX3RvdWNoKC0xKTsKPj4gICB9Cj4+IFNvIHdxX3dhdGNo
ZG9nX3RvdWNoZWQgd2lsbCBub3QgZ2V0IHVwZGF0ZWQgbWFueSB0aW1lcywgIAo+PiB3aGljaCBk
byB5b3UgdGhpbmsgaXMgYmV0dGVyLCBQZXRyPwo+Cj5JIGFjdHVhbGx5IHByZWZlciB0aGUgb3Jp
Z2luYWwgcGF0Y2guIEl0IG1ha2VzIHdxX3dhdGNoZG9nX3RvdWNoKCkKPmVhc3kgdG8gdXNlLiBU
aGUgY29tcGxleGl0eSBpcyBoaWRkZW4gaW4gd3Etc3BlY2lmaWMgY29kZS4KPgo+VGhlIGFsdGVy
bmF0aXZlIHdheSB1cGRhdGVzIGVhY2ggdGltZXN0YW1wIG9ubHkgb25jZSBidXQgdGhlIHVzZQo+
aXMgbW9yZSBjb21wbGljYXRlZC4gSU1ITywgaXQgaXMgbW9yZSBlcnJvciBwcm9uZS4KCkkgYWdy
ZWUsIHNvIEkgd2lsbCBqdXN0IG1vZGlmeSB0aGUgY29tbWl0IGxvZyBiYXNlZCBvbiBWMiBhbmQg
cmVzZW5kLgoKVGhhbmtzLApRaW5nCj4KPkJlc3QgUmVnYXJkcywKPlBldHIKDQoNCg==
