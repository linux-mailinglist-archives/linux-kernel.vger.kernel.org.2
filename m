Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E63ACE81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhFRPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhFRPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:29 -0400
Message-Id: <20210618141823.161158090@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3QSTFnLmDCaDo2BSry6gh962IV7Ui8ng9SM51PdA1i8=;
        b=CM0iXyTiVm/Y22tnUXkPyUmpaoexNO8fK44fGdWC0iP6he/grVD1nFE/ERK4qDcrutBlFO
        s+BBpVpf30dhZjDrhZnJ9/X16oAlJIIVqCK5Snfp4IS4Cv2Fs2LoOsOP0jtffCgJxwkDAp
        Wd3YtadS6s1L8XDMK4f1cYAJ22PjE7GsEGzKN8YR5Xs+1zdmBrXkeVO3KRdsH0hrfkYMI8
        RH+Zwk0XT+XqCvxVOZ5qXoLJcgYbtdseJTRQBNzIbG/AIKb5PpngypcUOCP6jqeWHm0sjp
        dYQ/qgJ0Q2Oit+LuuIqvLm26T4n3FxI7SWVjcI6PvYPKj/QAvwlqV/pBAGMIMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3QSTFnLmDCaDo2BSry6gh962IV7Ui8ng9SM51PdA1i8=;
        b=aeNXaAdRzCk7ggrqBcfUHagaFrCvVoXwPKQ+J8mOfdOwX2sX2qBAtLzlTz2Li1uwa0zJ30
        DN6OT8UgtChETrBA==
Date:   Fri, 18 Jun 2021 16:18:23 +0200
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
Subject: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
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
bHkgYWRkcmVzc2VkIHdpdGggdGhlCiAgICBzZXJpZXMgYXMgaXMuCgogIC0gQ2xlYW51cCBvZiBm
cHUgc2lnbmFsIHJlc3RvcmUKCiAgICAtIE1ha2UgdGhlIGZhc3QgcGF0aCBzZWxmIGNvbnRhaW5l
ZC4gSGFuZGxlICNQRiBkaXJlY3RseSBhbmQgc2tpcAogICAgICB0aGUgc2xvdyBwYXRoIG9uIGFu
eSBvdGhlciBleGNlcHRpb24gYXMgdGhhdCB3aWxsIGp1c3QgZW5kIHVwCiAgICAgIHdpdGggdGhl
IHNhbWUgcmVzdWx0IHRoYXQgdGhlIGZyYW1lIGlzIGludmFsaWQuIFRoaXMgYWxsb3dzCiAgICAg
IHRoZSBjb21waWxlciB0byBvcHRpbWl6ZSB0aGUgc2xvdyBwYXRoIG91dCBmb3IgNjRiaXQga2Vy
bmVscwogICAgICB3L28gaWEzMiBlbXVsYXRpb24uCgogICAgLSBSZWR1Y2UgY29kZSBkdXBsaWNh
dGlvbiBhbmQgdW5uZWNlc3Nhcnkgb3BlcmF0aW9ucwogICAgICAKCkl0IGFwcGxpZXMgb24gdG9w
IG9mCgogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAv
dGlwLmdpdCBtYXN0ZXIKCmFuZCBpcyBhbHNvIGF2YWlsYWJsZSB2aWEgZ2l0OgoKICBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgeDg2
L2ZwdQoKVGhpcyBpcyBhIGZvbGxvdyB1cCB0byBWMiB3aGljaCBjYW4gYmUgZm91bmQgaGVyZToK
CiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDYxNDE1NDQwOC42NzM0Nzg2MjNA
bGludXRyb25peC5kZQoKQ2hhbmdlcyB2cy4gVjI6CgogIC0gRml4ZWQgdGhlIHRlc3RpbmcgZmFs
bG91dCAoRGF2ZSwgS2FuKQoKICAtIEZpeGVkIGEgZmV3IGlzc3VlcyBmb3VuZCBieSBteXNlbGYg
d2hlbiBnb2luZyB0aHJvdWdoIHRoZSBsb3QKICAgIHdpdGggYSBmaW5lIGNvbWIsIGVzcGVjaWFs
bHkgTVhDU1IgaGFuZGxpbmcKCiAgLSBEcm9wIHRoZSBGTlNBVkUgb3B0aW1pemF0aW9ucwoKICAt
IENsZWFudXAgb2Ygc2lnbmFsIHJlc3RvcmUKCiAgLSBBZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRz
LCBtb3N0bHkgY29tbWVudHMgYW5kIGEgaG9wZWZ1bGx5IGJldHRlcgogICAgbmFtaW5nIHNjaGVt
ZSB3aGljaCBub3cganVzdCB1c2VzIHRoZSBpbnN0cnVjdGlvbiBuYW1lcyBhbmQKICAgIGNvbnNv
bGlkYXRlcyBldmVyeXRoaW5nIGVsc2Ugb24gc2F2ZS9yZXN0b3JlIHNvIGl0J3MgY2xvc2UgdG8g
dGhlIHdheQogICAgaG93IHRoZSBoYXJkd2FyZSB3b3Jrcy4KCiAgLSBBIGZldyBjbGVhbnVwcyBh
bmQgc2ltcGxpZmljYXRpb25zIG9uIHRoZSB3YXkgKG1vc3RseSByZWdzZXQgcmVsYXRlZCkuCgog
IC0gUGlja2VkIHVwIHRhZ3MKCldpdGggdGhlIGFib3ZlIEknbSBub3QgaW50ZW5kaW5nIHRvIGRv
IGFueSBmdXJ0aGVyIHN1cmdlcnkgb24gdGhhdApjb2RlIGF0IHRoZSBtb21lbnQsIHRob3VnaCB0
aGVyZSBpcyBzdGlsbCByb29tIGZvciBpbXByb3ZlbWVudCB3aGljaApjYW4gYW5kIGhhcyB0byBi
ZSB3b3JrZWQgb24gd2hlbiBuZXcgYml0cyBhcmUgYWRkZWQuCgpUaGFua3MsCgoJdGdseAotLS0K
IGFyY2gveDg2L2V2ZW50cy9pbnRlbC9sYnIuYyAgICAgICAgICB8ICAgIDYgCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9mcHUvaW50ZXJuYWwuaCAgfCAgMjExICsrKy0tLS0tLS0KIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL2ZwdS94c3RhdGUuaCAgICB8ICAgNzAgKystCiBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLmggICAgICAgfCAgIDU3IC0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa2V5cy5o
ICAgICAgICAgfCAgICA5IAogYXJjaC94ODYvaW5jbHVkZS9hc20vcGtydS5oICAgICAgICAgIHwg
ICA2MiArKysKIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oICAgICB8ICAgIDkgCiBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmggfCAgIDE0IAogYXJjaC94ODYva2Vy
bmVsL2NwdS9jb21tb24uYyAgICAgICAgIHwgICAzNCAtCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L2Nv
cmUuYyAgICAgICAgICAgfCAgMjc2ICsrKysrKystLS0tLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUv
aW5pdC5jICAgICAgICAgICB8ICAgMTUgCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jICAg
ICAgICAgfCAgMjIwICsrKysrKy0tLS0tCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25hbC5jICAg
ICAgICAgfCAgNDIzICsrKysrKysrKy0tLS0tLS0tLS0tLQogYXJjaC94ODYva2VybmVsL2ZwdS94
c3RhdGUuYyAgICAgICAgIHwgIDY5MyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyAgICAgICAgICAgIHwgICAyMiAtCiBhcmNoL3g4
Ni9rZXJuZWwvcHJvY2Vzc182NC5jICAgICAgICAgfCAgIDI4ICsKIGFyY2gveDg2L2tlcm5lbC90
cmFwcy5jICAgICAgICAgICAgICB8ICAgIDUgCiBhcmNoL3g4Ni9rdm0vc3ZtL3Nldi5jICAgICAg
ICAgICAgICAgfCAgICAxIAogYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgIHwg
ICA1NiArLQogYXJjaC94ODYvbW0vZXh0YWJsZS5jICAgICAgICAgICAgICAgIHwgICAgMiAKIGFy
Y2gveDg2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9tbS9w
a2V5cy5jICAgICAgICAgICAgICAgICAgfCAgIDIyIC0KIGluY2x1ZGUvbGludXgvcGtleXMuaCAg
ICAgICAgICAgICAgICB8ICAgIDQgCiAyMyBmaWxlcyBjaGFuZ2VkLCAxMDYwIGluc2VydGlvbnMo
KyksIDExODEgZGVsZXRpb25zKC0pCgoK
