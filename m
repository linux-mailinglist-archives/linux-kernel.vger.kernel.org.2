Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B6376E13
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEHB1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:27:18 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13906 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229775AbhEHB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:27:18 -0400
X-UUID: 49f2a9260c924ab29931aaf303c27f0b-20210508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nutVWr3hj7bZu1jyL7Kcy7LCd3FoB69So5Jsa45A8nc=;
        b=BYF36mNPSelcP304PLje7S0wjlCSl23pAaIDJNWoIRqd8bwWXurX6E21u1xTXDM18X0W+n8zWsjg9OjnqwtNvUqJe2LyA3gbzqU6qt3y8eATN88hZaZcN08WuGXOrqt87GeJ44HyRRu2Gu/91qhf0hNZaa4g3GQwV9tgzVB+jd4=;
X-UUID: 49f2a9260c924ab29931aaf303c27f0b-20210508
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 837447625; Sat, 08 May 2021 09:26:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 8 May
 2021 09:26:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 May 2021 09:26:08 +0800
Message-ID: <1620437169.10796.10.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: fotg210-hcd: Fix an error message
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <gregkh@linuxfoundation.org>, <shubhankarvk@gmail.com>,
        <lee.jones@linaro.org>, <gustavoars@kernel.org>,
        <vulab@iscas.ac.cn>, <john453@faraday-tech.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date:   Sat, 8 May 2021 09:26:09 +0800
In-Reply-To: <75002e1a-bca7-8726-de2e-56905f255693@wanadoo.fr>
References: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
         <1620354030.10796.6.camel@mhfsdcap03>
         <75002e1a-bca7-8726-de2e-56905f255693@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 97B07E1BE83D35AEE515145D4491D420241A3ED52927466B5CF9C472810CFB982000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTA3IGF0IDA5OjA2ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IExlIDA3LzA1LzIwMjEgw6AgMDQ6MjAsIENodW5mZW5nIFl1biBhIMOpY3JpdCA6DQo+
ID4gT24gVGh1LCAyMDIxLTA1LTA2IGF0IDIyOjM5ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQg
d3JvdGU6DQo+ID4+ICdyZXR2YWwnIGlzIGtub3duIHRvIGJlIC1FTk9ERVYgaGVyZS4NCj4gPj4g
VGhpcyBpcyBhIGhhcmQtY29kZWQgZGVmYXVsdCBlcnJvciBjb2RlIHdoaWNoIGlzIG5vdCB1c2Vm
dWwgaW4gdGhlIGVycm9yDQo+ID4+IG1lc3NhZ2UuIE1vcmVvdmVyLCBhbm90aGVyIGVycm9yIG1l
c3NhZ2UgaXMgcHJpbnRlZCBhdCB0aGUgZW5kIG9mIHRoZQ0KPiA+PiBlcnJvciBoYW5kbGluZyBw
YXRoLiBUaGUgY29ycmVzcG9uZGluZyBlcnJvciBjb2RlICgtRU5PTUVNKSBpcyBtb3JlDQo+ID4+
IGluZm9ybWF0aXZlLg0KPiA+Pg0KPiA+PiBTbyByZW1vdmUgc2ltcGxpZnkgdGhlIGZpcnN0IGVy
cm9yIG1lc3NhZ2UuDQo+ID4+DQo+ID4+IFdoaWxlIGF0IGl0LCBhbHNvIHJlbW92ZSB0aGUgdXNl
bGVzcyBpbml0aWFsaXphdGlvbiBvZiAncmV0dmFsJy4NCj4gPj4NCj4gPj4gRml4ZXM6IDdkNTAx
OTVmNmM1MCAoInVzYjogaG9zdDogRmFyYWRheSBmb3RnMjEwLWhjZCBkcml2ZXIiKQ0KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5h
ZG9vLmZyPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMg
fCA0ICsrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9mb3RnMjEw
LWhjZC5jIGIvZHJpdmVycy91c2IvaG9zdC9mb3RnMjEwLWhjZC5jDQo+ID4+IGluZGV4IDZjYWM2
NDI1MjBmYy4uOWMyZWRhMDkxOGUxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L2ZvdGcyMTAtaGNkLmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9mb3RnMjEwLWhjZC5j
DQo+ID4+IEBAIC01NTY4LDcgKzU1NjgsNyBAQCBzdGF0aWMgaW50IGZvdGcyMTBfaGNkX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+ICAgCXN0cnVjdCB1c2JfaGNkICpo
Y2Q7DQo+ID4+ICAgCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+PiAgIAlpbnQgaXJxOw0KPiA+
PiAtCWludCByZXR2YWwgPSAtRU5PREVWOw0KPiA+PiArCWludCByZXR2YWw7DQo+ID4+ICAgCXN0
cnVjdCBmb3RnMjEwX2hjZCAqZm90ZzIxMDsNCj4gPj4gICANCj4gPj4gICAJaWYgKHVzYl9kaXNh
YmxlZCgpKQ0KPiA+PiBAQCAtNTU4OCw3ICs1NTg4LDcgQEAgc3RhdGljIGludCBmb3RnMjEwX2hj
ZF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAgIAloY2QgPSB1c2Jf
Y3JlYXRlX2hjZCgmZm90ZzIxMF9mb3RnMjEwX2hjX2RyaXZlciwgZGV2LA0KPiA+PiAgIAkJCWRl
dl9uYW1lKGRldikpOw0KPiA+PiAgIAlpZiAoIWhjZCkgew0KPiA+PiAtCQlkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byBjcmVhdGUgaGNkIHdpdGggZXJyICVkXG4iLCByZXR2YWwpOw0KPiA+PiArCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBjcmVhdGUgaGNkXG4iKTsNCj4gPj4gICAJCXJldHZhbCA9
IC1FTk9NRU07DQo+ID4gSG93IGFib3V0IG1vdmluZyB0aGlzIGxpbmUgYmVmb3JlIGRldl9lcnIo
KT8gdGhlbiBjb3VsZCBrZWVwIGVycm9yIGxvZw0KPiA+IHVuY2hhbmdlZC4NCj4gPiANCj4gDQo+
IE1vc3RseSBhIG1hdHRlciBvZiB0YXN0ZS4NCj4gSSBkb24ndCB0aGluayBpdCBhZGQgYW55IHVz
ZWZ1bCBpbmZvcm1hdGlvbiAodGhpcyBpcyBub3Qgc29tZXRoaW5nIA0KPiBjb21pbmcgZnJvbSBh
IGNhbGwgY2hhaW4gb3IgdGhhdCBjYW4gaGF2ZSBkaWZmZXJlbnQgdmFsdWVzLCBpdCBpcyBqdXN0
IGEgDQo+IGhhcmQtY29kZWQgY29uc3RhbnQpIGFuZCB0aGUgbGluZSBhZnRlciB3ZSB3aWxsIGFs
cmVhZHkgaGF2ZToNCj4gCWRldl9lcnIoZGV2LCAiaW5pdCAlcyBmYWlsLCAlZFxuIiwgZGV2X25h
bWUoZGV2KSwgcmV0dmFsKTsNCj4gd2hlcmUgcmV0dmFsID0gLUVOT01FTQ0KPiANCj4gU28gdGhl
IC1FTk9NRU0gZXJyb3IgY29kZSBpcyBhbHJlYWR5IHJlcG9ydGVkLg0KWWVzDQoNCj4gDQo+IE1v
cmVvdmVyLCBoYXZpbmcgZXJyb3IgY29kZSByZXBvcnRlZCBvciBub3QgaXMgYWxyZWFkeSBub3Qg
Y29uc2lzdGVudCBpbiANCj4gdGhlIGZ1bmN0aW9uLiBGb3IgZXhhbXBsZSAiZmFpbGVkIHRvIGVu
YWJsZSBQQ0xLXG4iIHdoZXJlICdyZXR2YWwnIGNvdWxkIA0KPiBiZSByZXBvcnRlZCBhcyB3ZWxs
Lg0KPiANCj4gDQo+IA0KPiBCVFcsIGlzIGl0IHVzZWZ1bCB0byBoYXZlICdkZXZfbmFtZShkZXYp
JyBpbiBhIGRldl9lcnI/DQpkZXZfZXJyKGRldiwgLi4uKSBpdHNlbGYgd2lsbCBwcmludCBpdC4N
Cg0KPiANCj4gQ0oNCj4gDQo+ID4+ICAgCQlnb3RvIGZhaWxfY3JlYXRlX2hjZDsNCj4gPj4gICAJ
fQ0KPiA+IA0KPiANCg0K

