Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155E437B410
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:04:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59727 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229934AbhELCEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:04:55 -0400
X-UUID: 7dd48654e91b4cf49193b651f8a1d0ee-20210512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PwJHRqwBEarNjfAVmhlQxjauvjjxcaY8dzl8Reekzso=;
        b=mcz9/hgW/2l4XxvUCm5Q9oLOFBv60sRwPbTkKWNBTZ8u33jGbZI/5jV1pQKHZV2Ytp1302oVhmjczEKUtEQvNqerxNEMkZVTF/Stz1P7XvXwCxk7ju8/DBaHGu1rttrchgnL/bNBj8CtaNwbj4VQNXuAD/sFgKQoVfog8XhYZIY=;
X-UUID: 7dd48654e91b4cf49193b651f8a1d0ee-20210512
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1628613659; Wed, 12 May 2021 10:03:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 10:03:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 May 2021 10:03:37 +0800
Message-ID: <1620785017.25159.5.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: core: hub: fix race condition about TRSMRCY of
 resume
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "Oliver Neukum" <oneukum@suse.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Ikjoon Jang" <ikjn@chromium.org>
Date:   Wed, 12 May 2021 10:03:37 +0800
In-Reply-To: <20210511163907.GB901897@rowland.harvard.edu>
References: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
         <20210511163907.GB901897@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E3079C5BB8EAEF3DC9471B8695BAD55DD3FA211E210FA2A8C5F3E4DBC356237E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTExIGF0IDEyOjM5IC0wNDAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiBP
biBUdWUsIE1heSAxMSwgMjAyMSBhdCAwNjoxNToyMlBNICswODAwLCBDaHVuZmVuZyBZdW4gd3Jv
dGU6DQo+ID4gVGhpcyBtYXkgaGFwcGVuIGlmIHRoZSBwb3J0IGJlY29tZXMgcmVzdW1lIHN0YXR1
cyBleGFjdGx5DQo+ID4gd2hlbiB1c2JfcG9ydF9yZXN1bWUoKSBnZXRzIHBvcnQgc3RhdHVzLCBp
dCBzdGlsbCBuZWVkIHByb3ZpZGUNCj4gPiBhIFRSU01DUlkgdGltZSBiZWZvcmUgYWNjZXNzIHRo
ZSBkZXZpY2UuDQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IFRpYW5waW5nIEZhbmcgPHRpYW5waW5n
LmZhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoaXMgc2hvdWxkIGFsc28gc2F5Og0KPiAN
Cj4gQ0M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KDQpPSywgdGhhbmtzDQoNCj4gDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvdXNiL2NvcmUvaHViLmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jIGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0K
PiA+IGluZGV4IGIyYmM0YjdjNDI4OS4uZmM3ZDZjZGFjZjE2IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvdXNiL2NvcmUvaHViLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jDQo+
ID4gQEAgLTM2NDIsOSArMzY0Miw2IEBAIGludCB1c2JfcG9ydF9yZXN1bWUoc3RydWN0IHVzYl9k
ZXZpY2UgKnVkZXYsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4gIAkJICogc2VxdWVuY2UuDQo+ID4g
IAkJICovDQo+ID4gIAkJc3RhdHVzID0gaHViX3BvcnRfc3RhdHVzKGh1YiwgcG9ydDEsICZwb3J0
c3RhdHVzLCAmcG9ydGNoYW5nZSk7DQo+ID4gLQ0KPiA+IC0JCS8qIFRSU01SQ1kgPSAxMCBtc2Vj
ICovDQo+ID4gLQkJbXNsZWVwKDEwKTsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gICBTdXNwZW5kQ2xl
YXJlZDoNCj4gPiBAQCAtMzY1OSw2ICszNjU2LDkgQEAgaW50IHVzYl9wb3J0X3Jlc3VtZShzdHJ1
Y3QgdXNiX2RldmljZSAqdWRldiwgcG1fbWVzc2FnZV90IG1zZykNCj4gPiAgCQkJCXVzYl9jbGVh
cl9wb3J0X2ZlYXR1cmUoaHViLT5oZGV2LCBwb3J0MSwNCj4gPiAgCQkJCQkJVVNCX1BPUlRfRkVB
VF9DX1NVU1BFTkQpOw0KPiA+ICAJCX0NCj4gPiArDQo+ID4gKwkJLyogVFJTTVJDWSA9IDEwIG1z
ZWMgKi8NCj4gPiArCQltc2xlZXAoMTApOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCWlmICh1ZGV2
LT5wZXJzaXN0X2VuYWJsZWQpDQo+IA0KPiBBY2tlZC1ieTogQWxhbiBTdGVybiA8c3Rlcm5Acm93
bGFuZC5oYXJ2YXJkLmVkdT4NCg0K

