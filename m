Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1243B4DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFZKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:15:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229518AbhFZKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:15:34 -0400
X-UUID: 0be8d16d27ea4fc1b96c603a54785184-20210626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZbumjD0dXA8Fvx3qJdhEZ3HssG9IGyRmQDz1YHlIfM8=;
        b=LBZCFEQVBy6TcLtHJIdgWJMMmB9MkAoCK1UwLMVZKtGzjmUmnQywzA6WEZcPdS9BOVIN55XJReJ/UK5WK5XdAkYYi425/sbZ+VjRJhFG9GWxzXSLB2xkuHQ2F2A30yfvirJQeB3NmIR/PF2c2OpvijbDl5cNhjjq837+9D/I+8Q=;
X-UUID: 0be8d16d27ea4fc1b96c603a54785184-20210626
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1866582415; Sat, 26 Jun 2021 18:13:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Jun 2021 18:13:08 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Jun 2021 18:13:08 +0800
Message-ID: <9e906af1182a9039886b0f86525106df381a6255.camel@mediatek.com>
Subject: Re: [PATCH v3 0/3] kasan: add memory corruption identification
 support for hw tag-based kasan
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        <kuan-ying.lee@mediatek.com>
Date:   Sat, 26 Jun 2021 18:13:08 +0800
In-Reply-To: <CANpmjNP9n8-m4MhY6Cdnfx_SYLVtG8NJ7raMUR+3rBoNyyfs+Q@mail.gmail.com>
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
         <CANpmjNP9n8-m4MhY6Cdnfx_SYLVtG8NJ7raMUR+3rBoNyyfs+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTIxIGF0IDE0OjQ1ICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToNCj4g
T24gU3VuLCAyMCBKdW4gMjAyMSBhdCAxMzo0OCwgS3Vhbi1ZaW5nIExlZSA8DQo+IEt1YW4tWWlu
Zy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgbWVtb3J5IGNvcnJ1cHRp
b24gaWRlbnRpZmljYXRpb24gZm9yIGhhcmR3YXJlIHRhZy1iYXNlZCBLQVNBTg0KPiA+IG1vZGUu
DQo+ID4gDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gPiAgLSBQcmVzZXJ2ZSBDb3B5cmlnaHQg
ZnJvbSBod190YWdzLmMvc3dfdGFncy5jIGFuZA0KPiA+ICAgIHJlcG9ydF9zd190YWdzLmMvcmVw
b3J0X2h3X3RhZ3MuYw0KPiA+ICAtIE1ha2Ugbm9uLXRyaXZpYWwgY2hhbmdlIGluIGthc2FuIHN3
IHRhZy1iYXNlZCBtb2RlDQo+ID4gDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPiAgLSBUaGFu
a3MgZm9yIE1hcmNvJ3MgU3VnZ2VzdGlvbg0KPiA+ICAtIFJlbmFtZSB0aGUgQ09ORklHX0tBU0FO
X1NXX1RBR1NfSURFTlRJRlkNCj4gPiAgLSBJbnRlZ3JhdGUgdGFnLWJhc2VkIGthc2FuIGNvbW1v
biBwYXJ0DQo+ID4gIC0gUmViYXNlIHRvIGxhdGVzdCBsaW51eC1uZXh0DQo+ID4gDQo+ID4gS3Vh
bi1ZaW5nIExlZSAoMyk6DQo+ID4gICBrYXNhbjogcmVuYW1lIENPTkZJR19LQVNBTl9TV19UQUdT
X0lERU5USUZZIHRvDQo+ID4gICAgIENPTkZJR19LQVNBTl9UQUdTX0lERU5USUZZDQo+ID4gICBr
YXNhbjogaW50ZWdyYXRlIHRoZSBjb21tb24gcGFydCBvZiB0d28gS0FTQU4gdGFnLWJhc2VkIG1v
ZGVzDQo+ID4gICBrYXNhbjogYWRkIG1lbW9yeSBjb3JydXB0aW9uIGlkZW50aWZpY2F0aW9uIHN1
cHBvcnQgZm9yIGhhcmR3YXJlDQo+ID4gICAgIHRhZy1iYXNlZCBtb2RlDQo+IA0KPiBJIHRoaW5r
IHRoaXMgbG9va3MgZmluZSwgdGhhbmsgeW91IGZvciB5b3VyIGVmZm9ydHMuIEhvdyBkaWQgeW91
IHRlc3QNCj4gdGhpcz8gRGlkIHlvdSBydW4gdGhlIGxpYi90ZXN0X2thc2FuIG1vZHVsZSB3aXRo
IGJvdGggU1dfVEFHUyBhbmQNCj4gSFdfVEFHUyBtb2RlPyBJIHdhcyBhYm91dCB0byBydW4gdGhh
dCBiZWZvcmUgYWRkaW5nIG15IFJldmlld2VkLWJ5Lg0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRl
ci4NClllcywgSSBydW4gdGhlIGxpYi90ZXN0X2thc2FuIG1vZHVsZSB3aXRoIFNXX1RBR1MgYW5k
IEhXX1RBR1MgbW9kZS4gOikNCg0KPiANCj4gQW5kcmV5LCBBbGV4LCBpZiB5b3UgaGF2ZSB0aW1l
LCBwbGVhc2UgaGF2ZSBhIHF1aWNrIGxvb2sgYXQgdGhlDQo+IHNlcmllcy4NCj4gDQo+IFRoYW5r
cywNCj4gLS0gTWFyY28NCg==

