Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD573101EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhBEA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:58:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhBEA6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:33 -0500
Message-Id: <20210204204903.350275743@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gebrhWhSClmLop/DKx+ksU3dx5v8GfKkin9SmX+9Txw=;
        b=rlAWnQ1TJOYWrTw8GMRwlrP8kLB5sK4TgujzGVXWnQaVR5gsqFeWy9qlGe9j5TuIahQooe
        U8u7GIi1wOPpTnNCjSdndjuoW+9o/EmGWe2ZsnXo6+TLjgqThwe2rReK+gic0LgkmAPrJY
        j6Ec+X3bEXmUj/29CGt26cRb6RWzOHhItTHxAGPII8200W23Diac3pSRA0eRAHafBTIvoK
        zV4Nc5oKvFnJ53bFb9yADc/r0PnGgIm0X9863WEQ286UYZ3O3Vj7/QOhjm2L4n5mASv2TB
        4EylT+zILD94gklcBojWcDqjKRJUbeJDU7xy069Z5nim5YavyBiR71gk6/rvRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gebrhWhSClmLop/DKx+ksU3dx5v8GfKkin9SmX+9Txw=;
        b=+w1V5do2GPMucbUTyd7lezt6cLDi8ehChpLwJHYpihwsock4NJ6rR1cAFsfwqDTaLYLTov
        LEr2dgKd0Zw0DuCg==
Date:   Thu, 04 Feb 2021 21:49:03 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 00/12] x86/irq/64: Inline irq stack switching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlY2VudCBlZmZvcnQgdG8gbWFrZSB0aGUgQVNNIGVudHJ5IGNvZGUgc2xpbSBhbmQgdW5p
ZmllZCBtb3ZlZAp0aGUgaXJxIHN0YWNrIHN3aXRjaGluZyBvdXQgb2YgdGhlIGxvdyBsZXZlbCBB
U00gY29kZSBzbyB0aGF0IHRoZQp3aG9sZSByZXR1cm4gZnJvbSBpbnRlcnJ1cHQgd29yayBhbmQg
c3RhdGUgaGFuZGxpbmcgY2FuIGJlIGRvbmUgaW4gQwphbmQgdGhlIEFTTSBjb2RlIGp1c3QgaGFu
ZGxlcyB0aGUgdHJ1ZSBsb3cgbGV2ZWwgZGV0YWlscyBvZiBlbnRyeSBhbmQKZXhpdCAod2hpY2gg
aXMgaG9ycmlibGUgZW5vdWdoIGFscmVhZHkgZHVlIHRvIHRoZSB3ZWxsIHRob3VnaHQgb3V0CmFy
Y2hpdGV0dXJlKS4KClRoZSBtYWluIGdvYWwgYXQgdGhpcyBwb2ludCB3YXMgdG8gZ2V0IGluc3Ry
dW1lbnRhdGlvbiBhbmQgUkNVIHN0YXRlCnVuZGVyIGNvbnRyb2wgaW4gYSB2YWxpZGF0ZWQgd2F5
LiBJbmxpbmluZyB0aGUgc3dpdGNoIG1lY2hhbmlzbSB3YXMKYXR0ZW1wdGVkIGJhY2sgdGhlbiwg
YnV0IHRoYXQgY2F1c2VkIG1vcmUgb2JqdG9vbCBhbmQgdW53aW5kZXIgdHJvdWJsZQp0aGFuIHdl
IGhhZCBhbHJlYWR5IG9uIG91ciBwbGF0ZSwgc28gd2UgZW5kZWQgdXAgd2l0aCBhIHNpbXBsZSwK
ZnVuY3Rpb25hbCBidXQgc3Vib3B0aW1hbCBpbXBsZW1lbnRhdGlvbi4gVGhlIG1haW4gaXNzdWVz
IGFyZToKCiAgLSBUaGUgdW5uZWNlc3NhcnkgaW5kaXJlY3QgY2FsbCB3aGljaCBpcyBleHBlbnNp
dmUgdGhhbmtzIHRvCiAgICByZXRwb2xpbmUKICAgIAogIC0gVGhlIGluYWJpbGl0eSB0byBzdGF5
IG9uIHRoZSBpcnEgc3RhY2sgZm9yIHNvZnRpcnEgcHJvY2Vzc2luZyBvbiByZXR1cm4KICAgIGZy
b20gaW50ZXJydXB0IHdoaWNoIHJlcXVpcmVzIGFub3RoZXIgc3RhY2sgc3dpdGNoIG9wZXJhdGlv
bi4KICAgIAogIC0gVGhlIGZhY3QgdGhhdCB0aGUgc3RhY2sgc3dpdGNoaW5nIGNvZGUgZW5kZWQg
dXAgYmVpbmcgYW4gZWFzeSB0byBmaW5kCiAgICBleHBsb2l0IGdhZGdldC4KClRoaXMgc2VyaWVz
IHJldmlzaXRzIHRoZSBwcm9ibGVtIGFuZCByZWltcGxlbWVudHMgdGhlIHN0YWNrIHN3aXRjaApt
ZWNoYW5pY3MgdmlhIGV2aWwgaW5saW5lIGFzc2VtYmx5LiBQZXRlciBaaWpsc3RyYSBwcm92aWRl
ZCB0aGUgcmVxdWlyZWQKb2JqdG9vbCBhbmQgdW53aW5kZXIgY2hhbmdlcyBhbHJlYWR5LiBUaGVz
ZSBhcmUgYXZhaWxhYmxlIGhlcmU6CgogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTAy
MDMxMjAyMjIuNDUxMDY4NTgzQGluZnJhZGVhZC5vcmcKClRoZSBmdWxsIHNlcmllcyAoaW5jbHVk
aW5nIFBldGVyJ3Mgc2VyaWVzKSBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tIGdpdDoKCiAgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IHg4
Ni9lbnRyeQoKQWxsIGZ1bmN0aW9uIGNhbGxzIGFyZSBub3cgZGlyZWN0IGFuZCBmdWxseSBpbmxp
bmVkIGluY2x1ZGluZyB0aGUgc2luZ2xlCmluc3RhbmNlIGluIHRoZSBzb2Z0aXJxIGNvZGUgd2hp
Y2ggaXMgaW52b2tlZCBmcm9tIGxvY2FsX2JoX2VuYWJsZSgpIGluCnRhc2sgY29udGV4dC4KClRo
ZSBleHRyYSAxMDAgbGluZXMgaW4gdGhlIGRpZmZzdGF0IGFyZSBwcmV0dHkgbXVjaCB0aGUgZXh0
ZW5zaXZlIGNvbW1lbnRyeQpmb3IgdGhlIHdob2xlIG1hZ2ljIHRvIHNwYXJlIGV2ZXJ5b25lIGlu
Y2x1ZGluZyBteXNlbGYgdG8gc2NyYXRjaCBoZWFkcyAyCndlZWtzIGRvd24gdGhlIHJvYWQuIAoK
VGhlIHRleHQgc2l6ZSBpbXBhY3QgaXMgaW4gdGhlIG5vaXNlIGFuZCBsb29raW5nIGF0IHRoZSBh
Y3R1YWwgZW50cnkKZnVuY3Rpb25zIHRoZXJlIGlzIGRlcGVuZGluZyBvbiB0aGUgY29tcGlsZXIg
dmFyaWFudCBldmVuIGEgc21hbGwgc2l6ZQpkZWNyZWFzZS4KClRoZSBwYXRjaGVzIGhhdmUgYmVl
biB0ZXN0ZWQgd2l0aCBnY2M4LCBnY2MxMCBhbmQgY2xhbmctMTMgKGZyZXNoIGZyb20KZ2l0KS4g
VGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgb3V0cHV0IG9mIHRoZXNlIGNvbXBpbGVycyBpcyBt
aW5pbWFsLgpnY2M4IGJlaW5nIHNsaWdodGx5IHdvcnNlIGR1ZSB0byBzdHVwaWQgcmVnaXN0ZXIg
c2VsZWN0aW9uIGFuZCByYW5kb20KTk9QcyBpbmplY3RlZC4KClRoYW5rcywKCgl0Z2x4Ci0tLQog
YXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgICAxIAogYXJjaC94ODYvZW50cnkv
Y29tbW9uLmMgICAgICAgICAgfCAgIDE5IC0tCiBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TICAg
ICAgICB8ICAgNDEgLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5LmggIHwgICAx
MSAtCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnEuaCAgICAgICB8ICAgIDMgCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9pcnFfc3RhY2suaCB8ICAyODMgKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaCB8ICAgIDkgLQog
YXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jICAgICAgfCAgIDMxICsrLS0KIGFyY2gveDg2L2tl
cm5lbC9jcHUvY29tbW9uLmMgICAgIHwgICAgNCAKIGFyY2gveDg2L2tlcm5lbC9kdW1wc3RhY2tf
NjQuYyAgIHwgICAyMiArKy0KIGFyY2gveDg2L2tlcm5lbC9pcnEuYyAgICAgICAgICAgIHwgICAg
MiAKIGFyY2gveDg2L2tlcm5lbC9pcnFfNjQuYyAgICAgICAgIHwgICAxMSAtCiBhcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzc182NC5jICAgICB8ICAgIDIgCiBpbmNsdWRlL2xpbnV4L2ludGVycnVwdC5o
ICAgICAgICB8ICAgIDIgCiBrZXJuZWwvc29mdGlycS5jICAgICAgICAgICAgICAgICB8ICAgIDQg
CiAxNSBmaWxlcyBjaGFuZ2VkLCAyNzAgaW5zZXJ0aW9ucygrKSwgMTc1IGRlbGV0aW9ucygtKQoK
