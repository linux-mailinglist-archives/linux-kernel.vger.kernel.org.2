Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF13B19D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFWMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:25:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:25:53 -0400
Message-Id: <20210623120127.327154589@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jpxnLkCsAjVmLO8x6rSf120R71Y84WStaFX2t/JQQvQ=;
        b=cjmWH47mtW2BU9b3Aq+XongCpWq5hk9e3J86F/ya9/xSPUboLHndsMRCXnDv2gevNlaUjE
        j87F8dWK67YF+8TVfbqbu3jbxSxPHFjPxa/LiFZv9rVK2VhvOev3WtXwQgDaMJf1CKvdFL
        sczqFBhI01yYOgg3TIBm9+DZIG5cu0muahGkeR1UNwXCWzhwXdYlllTMcQ/Ik/aTyRCK9k
        DYzgnyyfbm712PwzEoUHjmf/TTQWW9aGI1NjdVVEmqS+C09hN65k6krl1JUR5UiccTLfFo
        bB+6TaWJlCyvx06u4Cb80XmTPdKArfZdKeZ2MAuvj1mpVsJOHXMgnKDBpB3BJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jpxnLkCsAjVmLO8x6rSf120R71Y84WStaFX2t/JQQvQ=;
        b=kED2iuPDo/Bb64eMwvjePkziirR4Vg2CmxXspOZNTKDVgq4Gcwf0foSq5bmIF+VXmelbzo
        aQ3x1LFw4c7DbnAw==
Date:   Wed, 23 Jun 2021 14:01:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 00/65] x86/fpu: Spring cleaning and PKRU sanitizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1haW4gcGFydHMgb2YgdGhpcyBzZXJpZXMgYXJlOgoKICAtIFNpbXBsaWZpY2F0aW9uIGFu
ZCByZW1vdmFsL3JlcGxhY2VtZW50IG9mIHJlZHVuZGFudCBhbmQvb3IKICAgIG92ZXJlbmdpbmVl
cmVkIGNvZGUuCgogIC0gTmFtZSBzcGFjZSBjbGVhbnVwIGFzIHRoZSBleGlzdGluZyBuYW1lcyB3
ZXJlIGp1c3QgYSBwZXJtYW5lbnQgc291cmNlCiAgICBvZiBjb25mdXNpb24uCgogIC0gQ2xlYXIg
c2VwZXJhdGlvbiBvZiB1c2VyIEFCSSBhbmQga2VybmVsIGludGVybmFsIHN0YXRlIGhhbmRsaW5n
LgoKICAtIFJlbW92YWwgb2YgUEtSVSBmcm9tIGJlaW5nIFhTVEFURSBtYW5hZ2VkIGluIHRoZSBr
ZXJuZWwgYmVjYXVzZSBQS1JVCiAgICBoYXMgdG8gYmUgZWFnZXJseSByZXN0b3JlZCBvbiBjb250
ZXh0IHN3aXRjaCBhbmQga2VlcGluZyBpdCBpbiBzeW5jCiAgICBpbiB0aGUgeHN0YXRlIGJ1ZmZl
ciBpcyBqdXN0IHBvaW50bGVzcyBvdmVyaGVhZCBhbmQgZnJhZ2lsZS4KCiAgICBUaGUga2VybmVs
IHN0aWxsIFhTQVZFcyBQS1JVIG9uIGNvbnRleHQgc3dpdGNoIGJ1dCB0aGUgdmFsdWUgaW4gdGhl
CiAgICBidWZmZXIgaXMgbm90IGxvbmdlciB1c2VkIGFuZCBuZXZlciByZXN0b3JlZCBmcm9tIHRo
ZSBidWZmZXIuCgogICAgVGhpcyBzdGlsbCBuZWVkcyB0byBiZSBjbGVhbmVkIHVwLCBidXQgdGhl
IHNlcmllcyBpcyBhbHJlYWR5IDQwKwogICAgcGF0Y2hlcyBsYXJnZSBhbmQgdGhlIGNsZWFudXAg
b2YgdGhpcyBpcyBub3QgYSBmdW5jdGlvbmFsIHByb2JsZW0uCgogICAgVGhlIGZ1bmN0aW9uYWwg
aXNzdWVzIG9mIFBLUlUgbWFuYWdlbWVudCBhcmUgZnVsbHkgYWRkcmVzc2VkIHdpdGggdGhlCiAg
ICBzZXJpZXMgYXMgaXMuCgogIC0gQ2xlYW51cCBvZiBmcHUgc2lnbmFsIHJlc3RvcmUKCiAgICAt
IE1ha2UgdGhlIGZhc3QgcGF0aCBzZWxmIGNvbnRhaW5lZC4gSGFuZGxlICNQRiBkaXJlY3RseSBh
bmQgc2tpcAogICAgICB0aGUgc2xvdyBwYXRoIG9uIGFueSBvdGhlciBleGNlcHRpb24gYXMgdGhh
dCB3aWxsIGp1c3QgZW5kIHVwCiAgICAgIHdpdGggdGhlIHNhbWUgcmVzdWx0IHRoYXQgdGhlIGZy
YW1lIGlzIGludmFsaWQuIFRoaXMgYWxsb3dzCiAgICAgIHRoZSBjb21waWxlciB0byBvcHRpbWl6
ZSB0aGUgc2xvdyBwYXRoIG91dCBmb3IgNjRiaXQga2VybmVscwogICAgICB3L28gaWEzMiBlbXVs
YXRpb24uCgogICAgLSBSZWR1Y2UgY29kZSBkdXBsaWNhdGlvbiBhbmQgdW5uZWNlc3Nhcnkgb3Bl
cmF0aW9ucwoKSXQgYXBwbGllcyBvbiB0b3Agb2YKCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IG1hc3RlcgoKYW5kIGlzIGFsc28gYXZh
aWxhYmxlIHZpYSBnaXQ6CgogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90Z2x4L2RldmVsLmdpdCB4ODYvZnB1CgpUaGlzIGlzIGEgZm9sbG93IHVwIHRvIFYz
IHdoaWNoIGNhbiBiZSBmb3VuZCBoZXJlOgoKICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjEwNjE4MTQxODIzLjE2MTE1ODA5MEBsaW51dHJvbml4LmRlCgpDaGFuZ2VzIHZzLiBWMzoK
CiAgLSBEcm9wcGVkIHRoZSB0d28gYnVnZml4ZXMgd2hpY2ggYXJlIGFwcGxpZWQgYWxyZWFkeSBh
bmQgcmViYXNlZCBvbiB0b3AKCiAgLSBBZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRzIChBbmR5LCBC
b3JpcykKCiAgICBQYXRjaGVzOiAxMywgMzUsIDM2LCAzNywgNDYsIDU4LCA2MiwgNjMKCiAgLSBG
aXhlZCB0aGUgbWF0aC1lbXUgZmFsbG91dCB3aGljaCBJIGhhZCBzdGFzaGVkIHNhZmVseSBvbiB0
aGUgMzJiaXQKICAgIHRlc3Rib3ggKEJvcmlzKQoKICAgIFBhdGNoOiAyOAoKICAtIFBpY2tlZCB1
cCB0YWdzCgpUaGFua3MgdG8gZXZlcnlvbmUgZm9yIHJldmlldywgZmVlZGJhY2sgYW5kIHRlc3Rp
bmcgKHZhcmlvdXMgdGVhbXMKQEludGVsKS4KCk5vdGU6IEkndmUgbm90IHBpY2tlZCB1cCBhbnkg
dGVzdGVkLWJ5IHRhZ3MuIEl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZQp0aGVtIG9uIHRoaXMgaG9w
ZWZ1bGx5IGZpbmFsIHZlcnNpb24uCgpUaGFua3MsCgoJdGdseAotLS0KIGFyY2gveDg2L2V2ZW50
cy9pbnRlbC9sYnIuYyAgICAgICAgICB8ICAgIDYgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUv
aW50ZXJuYWwuaCAgfCAgMjAyICsrKystLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS94
c3RhdGUuaCAgICB8ICAgNzggKysrLQogYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAg
ICAgIHwgICA1NyAtLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BrZXlzLmggICAgICAgICB8ICAg
IDkgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa3J1LmggICAgICAgICAgfCAgIDYyICsrKwogYXJj
aC94ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmggICAgIHwgICAgOSAKIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaCB8ICAgMTQgCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1v
bi5jICAgICAgICAgfCAgIDM0IC0KIGFyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jICAgICAgICAg
ICB8ICAyODIgKysrKysrKy0tLS0tLS0tCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L2luaXQuYyAgICAg
ICAgICAgfCAgIDE1IAogYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYyAgICAgICAgIHwgIDIy
MyArKysrKystLS0tLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMgICAgICAgICB8ICA0
MTkgKysrKysrKysrKy0tLS0tLS0tLS0tLQogYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYyAg
ICAgICAgIHwgIDY0NSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogYXJjaC94
ODYva2VybmVsL3Byb2Nlc3MuYyAgICAgICAgICAgIHwgICAyMiArCiBhcmNoL3g4Ni9rZXJuZWwv
cHJvY2Vzc182NC5jICAgICAgICAgfCAgIDI4ICsKIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jICAg
ICAgICAgICAgICB8ICAgIDUgCiBhcmNoL3g4Ni9rdm0vc3ZtL3Nldi5jICAgICAgICAgICAgICAg
fCAgICAxIAogYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgIHwgICA1NiArLS0K
IGFyY2gveDg2L21hdGgtZW11L2ZwdV9wcm90by5oICAgICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9t
YXRoLWVtdS9sb2FkX3N0b3JlLmMgICAgICAgfCAgICAyIAogYXJjaC94ODYvbWF0aC1lbXUvcmVn
X2xkX3N0ci5jICAgICAgIHwgICAgMiAKIGFyY2gveDg2L21tL2V4dGFibGUuYyAgICAgICAgICAg
ICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9tbS9mYXVsdC5jICAgICAgICAgICAgICAgICAgfCAgICAy
IAogYXJjaC94ODYvbW0vcGtleXMuYyAgICAgICAgICAgICAgICAgIHwgICAyMiAtCiBpbmNsdWRl
L2xpbnV4L3BrZXlzLmggICAgICAgICAgICAgICAgfCAgICA0IAogMjYgZmlsZXMgY2hhbmdlZCwg
MTAzNyBpbnNlcnRpb25zKCspLCAxMTY2IGRlbGV0aW9ucygtKQoKCg==
