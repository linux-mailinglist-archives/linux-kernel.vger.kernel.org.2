Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9579D3A6BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhFNQjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:39:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhFNQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:39:49 -0400
Message-Id: <20210614154408.673478623@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9DmInKGdwliNu4OWT76ZVubFVe/qP+O3lIqVt9WvDO8=;
        b=3DU5jWpJlNtW2QCmvv3FfA/yUAyT+6txOxC8ebftn4u5JLq76Vyrk/exXIN6fooP3+QDOv
        8+uK96QFiqyW6DjP2JzCuv7Gn9iqOqVj2otAIThsXYvIFU6lxzNCSeUQOtNMHiKwVRuESx
        zEi5oOk6F4gsAHtCP3/DAt7t0r+al5Z6A87Sy40Pw6L7IIzgSLrf7y6rsI/hoLToenF0FI
        0/eh9Lvjj/piMmJAperajNWnzjzLB55kKExUPOT6cJHeLmZ+7AOAD/Hsvyu2EeIEicAwLT
        OPvnHaq98I6X+Udr939/1jwUUzY0R42pEZ/xdXnBkTglxEK/jM930JfilieMhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9DmInKGdwliNu4OWT76ZVubFVe/qP+O3lIqVt9WvDO8=;
        b=y7teIuVLud+m/79S7lRzdXLB9YeEwSHRCJQArJtMH6tM6KukDBaUCxgrqIBdBVEusTxent
        B/mzTXnmqKwraSBg==
Date:   Mon, 14 Jun 2021 17:44:08 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 00/52] x86/fpu: Spring cleaning and PKRU sanitizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1haW4gcGFydHMgb2YgdGhpcyBzZXJpZXMgYXJlOgoKICAtIFlldCBtb3JlIGJ1ZyBmaXhl
cwoKICAtIFNpbXBsaWZpY2F0aW9uIGFuZCByZW1vdmFsL3JlcGxhY2VtZW50IG9mIHJlZHVuZGFu
dCBhbmQvb3IKICAgIG92ZXJlbmdpbmVlcmVkIGNvZGUuCgogIC0gTmFtZSBzcGFjZSBjbGVhbnVw
IGFzIHRoZSBleGlzdGluZyBuYW1lcyB3ZXJlIGp1c3QgYSBwZXJtYW5lbnQgc291cmNlCiAgICBv
ZiBjb25mdXNpb24uCgogIC0gQ2xlYXIgc2VwZXJhdGlvbiBvZiB1c2VyIEFCSSBhbmQga2VybmVs
IGludGVybmFsIHN0YXRlIGhhbmRsaW5nLgoKICAtIFJlbW92YWwgb2YgUEtSVSBmcm9tIGJlaW5n
IFhTVEFURSBtYW5hZ2VkIGluIHRoZSBrZXJuZWwgYmVjYXVzZSBQS1JVCiAgICBoYXMgdG8gYmUg
ZWFnZXJseSByZXN0b3JlZCBvbiBjb250ZXh0IHN3aXRjaCBhbmQga2VlcGluZyBpdCBpbiBzeW5j
CiAgICBpbiB0aGUgeHN0YXRlIGJ1ZmZlciBpcyBqdXN0IHBvaW50bGVzcyBvdmVyaGVhZCBhbmQg
ZnJhZ2lsZS4KCiAgICBUaGUga2VybmVsIHN0aWxsIFhTQVZFcyBQS1JVIG9uIGNvbnRleHQgc3dp
dGNoIGJ1dCB0aGUgdmFsdWUgaW4gdGhlCiAgICBidWZmZXIgaXMgbm90IGxvbmdlciB1c2VkIGFu
ZCBuZXZlciByZXN0b3JlZCBmcm9tIHRoZSBidWZmZXIuCgogICAgVGhpcyBzdGlsbCBuZWVkcyB0
byBiZSBjbGVhbmVkIHVwLCBidXQgdGhlIHNlcmllcyBpcyBhbHJlYWR5IDQwKwogICAgcGF0Y2hl
cyBsYXJnZSBhbmQgdGhlIGNsZWFudXAgb2YgdGhpcyBpcyBub3QgYSBmdW5jdGlvbmFsIHByb2Js
ZW0uCgogICAgVGhlIGZ1bmN0aW9uYWwgaXNzdWVzIG9mIFBLUlUgbWFuYWdlbWVudCBhcmUgZnVs
bHkgYWRkcmVzc2VkIHdpdGggdGhlCiAgICBzZXJpZXMgYXMgaXMuCgpJdCBhcHBsaWVzIG9uIHRv
cCBvZgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlw
L3RpcC5naXQgbWFzdGVyCgphbmQgaXMgYWxzbyBhdmFpbGFibGUgdmlhIGdpdDoKCiAgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IHg4
Ni9mcHUKClRoaXMgaXMgYSBmb2xsb3cgdXAgdG8gVjEgd2hpY2ggY2FuIGJlIGZvdW5kIGhlcmU6
CgogICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA2MTExNjE1MjMuNTA4OTA4MDI0
QGxpbnV0cm9uaXguZGUKCkNoYW5nZXMgdnMuIFYxOgoKICAtIEZpeCB0aGUgYnJva2VuIGluaXRf
ZnBzdGF0ZSBpbml0aWFsaXphdGlvbgoKICAtIE1ha2UgeHN0YXRlIGNvcHkgdG8gcHRyYWNlIHdv
cmsgY29ycmVjdGx5CgogIC0gU2FuaXRpemUgdGhlIHJlZ3NldCBmdW5jdGlvbnMgbW9yZSBhbmQg
Z2V0IHJpZCBvZgogICAgZnBzdGF0ZV9zYW5pdGl6ZV94c3RhdGUoKS4KCiAgLSBBZGRyZXNzZWQg
cmV2aWV3IGNvbW1lbnRzCgogIC0gUGlja2VkIHVwIHRhZ3MKClRoYW5rcywKCgl0Z2x4Ci0tLQog
YXJjaC94ODYvZXZlbnRzL2ludGVsL2xici5jICAgICAgICAgIHwgICAgNiAKIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL2ZwdS9pbnRlcm5hbC5oICB8ICAxNzkgKysrLS0tLS0tLQogYXJjaC94ODYvaW5j
bHVkZS9hc20vZnB1L3hzdGF0ZS5oICAgIHwgICA3MCArKy0KIGFyY2gveDg2L2luY2x1ZGUvYXNt
L3BndGFibGUuaCAgICAgICB8ICAgNTcgLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa2V5cy5o
ICAgICAgICAgfCAgICA5IAogYXJjaC94ODYvaW5jbHVkZS9hc20vcGtydS5oICAgICAgICAgIHwg
ICA2MiArKysKIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oICAgICB8ICAgIDkgCiBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmggfCAgIDE0IAogYXJjaC94ODYva2Vy
bmVsL2NwdS9jb21tb24uYyAgICAgICAgIHwgICAyOSAtCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L2Nv
cmUuYyAgICAgICAgICAgfCAgMjQyICsrKysrKysrKy0tLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUv
aW5pdC5jICAgICAgICAgICB8ICAgIDQgCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jICAg
ICAgICAgfCAgMTc3ICsrKystLS0tLQogYXJjaC94ODYva2VybmVsL2ZwdS9zaWduYWwuYyAgICAg
ICAgIHwgICA1OSArLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMgICAgICAgICB8ICA2
MjAgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gveDg2L2tlcm5lbC9w
cm9jZXNzLmMgICAgICAgICAgICB8ICAgMTkgKwogYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQu
YyAgICAgICAgIHwgICAyOCArCiBhcmNoL3g4Ni9rdm0vc3ZtL3Nldi5jICAgICAgICAgICAgICAg
fCAgICAxIAogYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgIHwgICA1NiArLS0K
IGFyY2gveDg2L21tL2V4dGFibGUuYyAgICAgICAgICAgICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9t
bS9mYXVsdC5jICAgICAgICAgICAgICAgICAgfCAgICAyIAogYXJjaC94ODYvbW0vcGtleXMuYyAg
ICAgICAgICAgICAgICAgIHwgICAyMiAtCiBpbmNsdWRlL2xpbnV4L3BrZXlzLmggICAgICAgICAg
ICAgICAgfCAgICA0IAogMjIgZmlsZXMgY2hhbmdlZCwgODE4IGluc2VydGlvbnMoKyksIDg1MyBk
ZWxldGlvbnMoLSkKCgo=
