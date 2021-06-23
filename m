Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2B3B1B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhFWNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:55:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230520AbhFWNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:55:19 -0400
X-UUID: 041a74b278754e9596b573f8f57eb514-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HAjT4udO57t+rw0LhCJdv0l55D4KZ+MMoREZAkGCEQU=;
        b=jjXHYD8KddypiZh8KgIirXdOrS5jPUMoANVD7AAvnLKxgL2tZ91DHo3V2Ki1SlPdon/KuUzDbOgLkr+V7Ade982G1oMbY+R50DZU8v4ucUbQtoihklQUrHEdkXu3NhVJ8BUlBvyOgQu+BVnDZS5QmsY8j8fNZJufTxk1npcNH+g=;
X-UUID: 041a74b278754e9596b573f8f57eb514-20210623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 282718694; Wed, 23 Jun 2021 21:52:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 21:52:49 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 21:52:49 +0800
Message-ID: <9a77839314b3c33970925b5127182c97914c185d.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] kasan: Add memzero init for unaligned size under
 SLUB debug
From:   Yee Lee <yee.lee@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <wsd_upstream@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 23 Jun 2021 21:52:49 +0800
In-Reply-To: <20210623133533.2246-2-yee.lee@mediatek.com>
References: <20210623133533.2246-1-yee.lee@mediatek.com>
         <20210623133533.2246-2-yee.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgbm90IGEgY29tcGxldGVkIHBhdGNoLg0KUGxlYXNlIHNraXAgdGhpcyBtYWlsLg0KDQpC
UiwNClllZQ0KDQpPbiBXZWQsIDIwMjEtMDYtMjMgYXQgMjE6MzUgKzA4MDAsIHllZS5sZWVAbWVk
aWF0ZWsuY29tIHdyb3RlOg0KPiBGcm9tOiBZZWUgTGVlIDx5ZWUubGVlQG1lZGlhdGVrLmNvbT4N
Cj4gDQo+IElzc3VlOiB3aGVuIFNMVUIgZGVidWcgaXMgb24sIGh3dGFnIGthc2FuX3VucG9pc29u
KCkgd291bGQgb3ZlcndyaXRlDQo+IHRoZSByZWR6b25lIHdpdGggdW5hbGlnbmVkIG9iamVjdCBz
aXplLg0KPiANCj4gQW4gYWRkaXRpb25hbCBtZW16ZXJvX2V4cGxpY2l0KCkgcGF0aCBpcyBhZGRl
ZCB0byByZXBsYWNpbmcgaHd0YWcNCj4gaW5pdGlhbGl6YXRpb24NCj4gYXQgU0xVQiBkZXViZyBt
b2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWVlIExlZSA8eWVlLmxlZUBtZWRpYXRlay5jb20+
DQo+IFN1Z2dlc3RlZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQo+IENjOiBB
bmRyZXkgUnlhYmluaW4gPHJ5YWJpbmluLmEuYUBnbWFpbC5jb20+DQo+IENjOiBBbGV4YW5kZXIg
UG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCj4gQ2M6IEFuZHJleSBLb25vdmFsb3YgPGFu
ZHJleWtudmxAZ21haWwuY29tPg0KPiBDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUu
Y29tPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4g
LS0tDQo+ICBtbS9rYXNhbi9rYXNhbi5oIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0va2FzYW4v
a2FzYW4uaCBiL21tL2thc2FuL2thc2FuLmgNCj4gaW5kZXggZDhmYWE2NDYxNGI3Li5lOTg0YTlh
YzgxNGQgMTAwNjQ0DQo+IC0tLSBhL21tL2thc2FuL2thc2FuLmgNCj4gKysrIGIvbW0va2FzYW4v
a2FzYW4uaA0KPiBAQCAtMzg3LDEwICszODcsMTIgQEAgc3RhdGljIGlubGluZSB2b2lkIGthc2Fu
X3VucG9pc29uKGNvbnN0IHZvaWQNCj4gKmFkZHIsIHNpemVfdCBzaXplLCBib29sIGluaXQpDQo+
ICANCj4gIAlpZiAoV0FSTl9PTigodW5zaWduZWQgbG9uZylhZGRyICYgS0FTQU5fR1JBTlVMRV9N
QVNLKSkNCj4gIAkJcmV0dXJuOw0KPiArCSNpZiBJU19FTkFCTEVEKENPTkZJR19TTFVCX0RFQlVH
KQ0KPiAgCWlmIChpbml0ICYmICgodW5zaWduZWQgbG9uZylzaXplICYgS0FTQU5fR1JBTlVMRV9N
QVNLKSkgew0KPiAgCQlpbml0ID0gZmFsc2U7DQo+IC0JCW1lbXNldCgodm9pZCAqKWFkZHIsIDAs
IHNpemUpOw0KPiArCQltZW16ZXJvX2V4cGxpY2l0KCh2b2lkICopYWRkciwgc2l6ZSk7DQo+ICAJ
fQ0KPiArCSNlbmRpZg0KPiAgCXNpemUgPSByb3VuZF91cChzaXplLCBLQVNBTl9HUkFOVUxFX1NJ
WkUpOw0KPiAgCWh3X3NldF9tZW1fdGFnX3JhbmdlKCh2b2lkICopYWRkciwgc2l6ZSwgdGFnLCBp
bml0KTsNCj4gIH0NCg==

