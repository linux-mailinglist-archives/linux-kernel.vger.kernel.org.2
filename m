Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99F402F97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbhIGUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:25:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhIGUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:48 -0400
Message-ID: <20210907200722.067068005@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H8NhQX75Fj++SmpyDPl9Ar5TDNEziKIKky5QS/GHTzI=;
        b=VRFIhi1KbWuiUQwa8VdNhQEnNzc82ldFvVSFBcx931UrURJxn/9qnSwgxeWaxFe+w27pFR
        VIwAdKJq0yfJMDgzE9jTuF/gBtT3lMuYrDGOgXEDK6tOHWWLUudQpvbkI/m2yDorojMFva
        UMAKsT17mXnWRuPr+b4K8GOFPt99rw7JRwe8AWTn62CM/PQgfJC+NsSk5HwgVx5bfgmXGG
        W5jxIPv3aReNcsZM61hq8NQ5YHIla6ri0b0cNdzdy3u4MOiug+haVKyXixBCjQ0hVn8zOm
        yeBSPIok152IjnxaPzS+m4KmHPoqWmD+yZtCDJ3G5ItX1Y+ui4xFIJNN3n8TFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H8NhQX75Fj++SmpyDPl9Ar5TDNEziKIKky5QS/GHTzI=;
        b=4GjHFVGowYkGaIruGMM/Gl3nvEdB7gUTrO0NlQ3jG6M1ojR9aFxkLlruWQj6Ne0SelLLiM
        v+9NEQFgsPfj/jDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue,  7 Sep 2021 22:24:40 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVzdCBhIHJlc2VuZCBvZiBWMiB3aXRoIHByb3BlciB0aHJlYWRpbmcgYW5kIGludGFjdCBtZXNz
YWdlIGhlYWRlcnMuCgpBIHJlY2VudCBkaXNjdXNzaW9uIFsxXSBhYm91dCBoYXJkd2FyZSBwb2lz
b25pbmcgdW5lYXJ0aGVkIHNvbWUgc2hvcnQKY29taW5ncyBpbiB0aGUgZXJyb3IgaGFuZGxpbmcg
b2YgdGhlIHNpZ2ZyYW1lIHJlbGF0ZWQgRlBVIGNvZGU6CgogIC0gVGhlIGVycm9yIGV4aXQgZm9y
IGV4Y2VwdGlvbnMgb3RoZXIgdGhhbiAjUEYgaXMgb2JmdXNjYXRlZAoKICAtIFRoZSBlcnJvciBj
b2RlIHJldHVybiB2YWx1ZXMgb2YgdGhlIHZhcmlvdXMgZnVuY3Rpb25zIGFyZSBwb2ludGxlc3MK
ICAgIGJlY2F1c2UgYWxsIGNhbGxlcnMganVzdCBjYXJlIGFib3V0IHN1Y2Nlc3Mgb3IgZmFpbHVy
ZSBhbmQgdGhlIGVycm9yCiAgICBjb2RlcyBhcmUgbmV2ZXIgcHJvcGFnYXRlZCB0byB1c2VyIHNw
YWNlLgoKICAtIFNvbWUgb2YgdGhlIGJ1ZmZlciBjbGVhcmluZyBoYXBwZW5zIG5lZWRsZXNzbHkg
aW5zaWRlIG9mIHBhZ2UgZmF1bHQKICAgIGRpc2FibGVkIHJlZ2lvbnMuCgpUaGUgZGlzY3Vzc2lv
biBhcm91bmQgVjEgb2YgdGhpcyBzZXJpZXMgd2hpY2ggY2FuIGJlIGZvdW5kIGhlcmU6CgogIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA4MzAxNTQ3MDIuMjQ3NjgxNTg1QGxpbnV0cm9u
aXguZGUKCmlkZW50aWZpZWQgYSBmZXcgbW9yZSBpc3N1ZXMgZXNwZWNpYWxseSBpbiB0aGUgYXJl
YSBvZiBleGNlcHRpb24gZml4dXBzOgoKICAtIFRoZSBNQ0UgYXdhcmUgZXhjZXB0aW9uIGZpeHVw
IGlzIGluY29uc2lzdGVudCBhbmQgY29uZnVzaW5nIGVzcGVjaWFsbHkKICAgIGluIGNvcHlfbWNf
NjQuYy4gSXQgdXNlcyBhIGZpeHVwIGZ1bmN0aW9uIHdoaWNoIHN0b3JlcyB0aGUgdHJhcCBudW1i
ZXIKICAgIGluIHJlZ3MtPmF4IGp1c3QgdG8gb3ZlcndyaXRlIHJlZ3MtPmF4IGF0IHRoZSBjYWxs
c2l0ZSBzcGVjaWZpYyBmaXh1cC4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGNsZWFucyB0aGlzIHVw
LiBUaGUgcmVzdWx0aW5nIGV4Y2VjdXRhYmxlIGNvZGUgaXMKc2xpZ2h0bHkgc21hbGxlciB3aXRo
IHRoYXQuCgpJdCdzIGFsc28gYXZhaWxhYmxlIGluIGdpdDoKCiAgICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgeDg2L2ZwdQoKQ2hh
bmdlcyB2cy4gVjE6CgogIC0gRGVkdXBsaWNhdGUgdGhlIGV4Y2VwdGlvbiB0YWJsZSByZWxhdGVk
IGNvZGUKCiAgLSBDaGFuZ2UgdGhlIGV4Y2VwdGlvbiB0YWJsZSBzdG9yZSB0byB1c2UgYSBmaXh1
cCB0eXBlIGlkZW50aWZpZXIgaW5zdGVhZAogICAgb2YgYSBmdW5jdGlvbiBwb2ludGVyLiBUaGF0
IGFsbG93cyB0byB1c2UgdGhlIHNhbWUgZml4dXAgZnVuY3Rpb24gZm9yCiAgICBkaWZmZXJlbnQg
dHlwZXMgYW5kIGF2b2lkcyBhZGRpbmcgbmV3IGdsb2JhbCBmdW5jdGlvbnMgYW5kIGV4cG9ydHMg
dG8KICAgIHNvbHZlIHRoZSBpZGVudGlmaWVkIGlzc3Vlcy4gVGhpcyBtYWtlcyB0aGUgY2xlYW51
cCBvZiB0aGUgb2RkIGZpeHVwCiAgICBmdW5jdGlvbnMgaW4gY29weV9tY182NCBhbmQgdGhlIGZw
dSBjb2RlIHNpbXBsZXIKCiAgLSBNYWtlIGNvcHlfbWNfNjQgYW5kIEZQVSBjb2RlIHVzZSB0aGUg
bmV3IGZpeHVwIHR5cGUgbWVjaGFuaWNzCgogIC0gUmVtb3ZlICNNQyBoYW5kbGluZyBmcm9tIHRo
ZSB2YXJpb3VzICpTQVZFIGZ1bmN0aW9ucyB3aGljaCB3cml0ZSB0aGUKICAgIEZQVSByZWdpc3Rl
cnMgdG8gdGhlIHVzZXIgc3BhY2Ugc2lnZnJhbWUgYXMgdGhlc2UgY2FuJ3QgcmFpc2UgI01DCiAg
ICBhY2NvcmRpbmcgdG8gVG9ueS4KCiAgLSBBZGRyZXNzIGEgZmV3IHJldmlldyBjb21tZW50cyBh
bmQgYWRqdXN0IHRoZSBwYXRjaGVzIHRvIHRoZSBuZXcKICAgIGV4Y2VwdGlvbiB0YWJsZSBtZWNo
YW5pc20uCgpUaGFua3MsCgoJdGdseAoKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvODdy
MWVkZ3Mydy5mZnNAdGdseAoKLS0tCiBhcmNoL3g4Ni9pYTMyL2lhMzJfc2lnbmFsLmMgICAgICAg
ICAgICAgICAgfCAgIDE0ICstCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20uaCAgICAgICAgICAg
ICAgICAgfCAgIDQ5ICsrKystLS0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZS5oICAg
ICAgICAgICAgIHwgICA0NCArKysrKy0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZV9m
aXh1cF90eXBlcy5oIHwgICAyMiArKysrCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvaW50ZXJu
YWwuaCAgICAgICAgfCAgIDg0ICsrKysrKysrKystLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNt
L21zci5oICAgICAgICAgICAgICAgICB8ICAgIDQgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdt
ZW50LmggICAgICAgICAgICAgfCAgICAyIAogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5j
ICAgICAgICAgICAgIHwgICA0MCArKy0tLS0tLQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50
ZXJuYWwuaCAgICAgICAgIHwgICAxNCAtLQogYXJjaC94ODYva2VybmVsL2NwdS9tY2Uvc2V2ZXJp
dHkuYyAgICAgICAgIHwgICAyMiArKy0tCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25hbC5jICAg
ICAgICAgICAgICAgfCAgMTQ1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiBhcmNoL3g4
Ni9rZXJuZWwvc2lnbmFsLmMgICAgICAgICAgICAgICAgICAgfCAgIDE4ICstLQogYXJjaC94ODYv
bGliL2NvcHlfbWNfNjQuUyAgICAgICAgICAgICAgICAgIHwgICAgOCAtCiBhcmNoL3g4Ni9tbS9l
eHRhYmxlLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTMxICsrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tCiBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMgICAgICAgICAgICAgICAgfCAgIDEx
IC0tCiBzY3JpcHRzL3NvcnR0YWJsZS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0IAog
MTYgZmlsZXMgY2hhbmdlZCwgMzAyIGluc2VydGlvbnMoKyksIDMxMCBkZWxldGlvbnMoLSkKCgo=
