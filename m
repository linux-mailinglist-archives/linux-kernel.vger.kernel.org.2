Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF0402F33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbhIGT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbhIGT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B59C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:17 -0700 (PDT)
3Message-ID: <20210907193229.370353258@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WX2c8ey0soR7LuoenXyxcuqTS5xYFCHWSYtOkKQBkSY=;
        b=sNot4wtiDYsw2/QD6spqyeWXTf/mcFAQpczxFez+Cf3+BJGqX+HRZb/Qc3z9TX1gFX1/n8
        jeOU27L57jjhBD0zyfgyneJa7TZwZEpml/JZ+p9qJ7AniIPPN+dtDN96UI7aQMof87oy1v
        rDgP0Ra7UCK3+NSBsAeVhEJx+WRV+78HcnDJwYZQYM/Gl+5nAHsgDz/FTUXl9o6aJYohAm
        k1+bXYfSZTjY0nw3SCetjSKsd5rnt1oco5AS/NU85aFyspGXpo2EEDMbXyfHoNrjbSXxuX
        GV4PxQIFipKrT8CBCpTCO+A4s9GVze/EDGGXY6wSur1/+EcxPnxCzJww7ZlgWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WX2c8ey0soR7LuoenXyxcuqTS5xYFCHWSYtOkKQBkSY=;
        b=1f+lOO/K5vFljQVDCu82jxMee98QLJrDQvQ2FwYEiUW15RdaFho2j9QODhB3OeMeL1SJ3M
        DwwzhlD/lDcdY0Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Message-Id: <20210907195612.321345EED@xen13.tec.linutronix.de>
Date:   Tue,  7 Sep 2021 21:56:12 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSByZWNlbnQgZGlzY3Vzc2lvbiBbMV0gYWJvdXQgaGFyZHdhcmUgcG9pc29uaW5nIHVuZWFydGhl
ZCBzb21lIHNob3J0CmNvbWluZ3MgaW4gdGhlIGVycm9yIGhhbmRsaW5nIG9mIHRoZSBzaWdmcmFt
ZSByZWxhdGVkIEZQVSBjb2RlOgoKICAtIFRoZSBlcnJvciBleGl0IGZvciBleGNlcHRpb25zIG90
aGVyIHRoYW4gI1BGIGlzIG9iZnVzY2F0ZWQKCiAgLSBUaGUgZXJyb3IgY29kZSByZXR1cm4gdmFs
dWVzIG9mIHRoZSB2YXJpb3VzIGZ1bmN0aW9ucyBhcmUgcG9pbnRsZXNzCiAgICBiZWNhdXNlIGFs
bCBjYWxsZXJzIGp1c3QgY2FyZSBhYm91dCBzdWNjZXNzIG9yIGZhaWx1cmUgYW5kIHRoZSBlcnJv
cgogICAgY29kZXMgYXJlIG5ldmVyIHByb3BhZ2F0ZWQgdG8gdXNlciBzcGFjZS4KCiAgLSBTb21l
IG9mIHRoZSBidWZmZXIgY2xlYXJpbmcgaGFwcGVucyBuZWVkbGVzc2x5IGluc2lkZSBvZiBwYWdl
IGZhdWx0CiAgICBkaXNhYmxlZCByZWdpb25zLgoKVGhlIGRpc2N1c3Npb24gYXJvdW5kIFYxIG9m
IHRoaXMgc2VyaWVzIHdoaWNoIGNhbiBiZSBmb3VuZCBoZXJlOgoKICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjEwODMwMTU0NzAyLjI0NzY4MTU4NUBsaW51dHJvbml4LmRlCgppZGVudGlm
aWVkIGEgZmV3IG1vcmUgaXNzdWVzIGVzcGVjaWFsbHkgaW4gdGhlIGFyZWEgb2YgZXhjZXB0aW9u
IGZpeHVwczoKCiAgLSBUaGUgTUNFIGF3YXJlIGV4Y2VwdGlvbiBmaXh1cCBpcyBpbmNvbnNpc3Rl
bnQgYW5kIGNvbmZ1c2luZyBlc3BlY2lhbGx5CiAgICBpbiBjb3B5X21jXzY0LmMuIEl0IHVzZXMg
YSBmaXh1cCBmdW5jdGlvbiB3aGljaCBzdG9yZXMgdGhlIHRyYXAgbnVtYmVyCiAgICBpbiByZWdz
LT5heCBqdXN0IHRvIG92ZXJ3cml0ZSByZWdzLT5heCBhdCB0aGUgY2FsbHNpdGUgc3BlY2lmaWMg
Zml4dXAuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBjbGVhbnMgdGhpcyB1cC4gVGhlIHJlc3VsdGlu
ZyBleGNlY3V0YWJsZSBjb2RlIGlzCnNsaWdodGx5IHNtYWxsZXIgd2l0aCB0aGF0LgoKSXQncyBh
bHNvIGF2YWlsYWJsZSBpbiBnaXQ6CgogICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IHg4Ni9mcHUKCkNoYW5nZXMgdnMuIFYxOgoK
ICAtIERlZHVwbGljYXRlIHRoZSBleGNlcHRpb24gdGFibGUgcmVsYXRlZCBjb2RlCgogIC0gQ2hh
bmdlIHRoZSBleGNlcHRpb24gdGFibGUgc3RvcmUgdG8gdXNlIGEgZml4dXAgdHlwZSBpZGVudGlm
aWVyIGluc3RlYWQKICAgIG9mIGEgZnVuY3Rpb24gcG9pbnRlci4gVGhhdCBhbGxvd3MgdG8gdXNl
IHRoZSBzYW1lIGZpeHVwIGZ1bmN0aW9uIGZvcgogICAgZGlmZmVyZW50IHR5cGVzIGFuZCBhdm9p
ZHMgYWRkaW5nIG5ldyBnbG9iYWwgZnVuY3Rpb25zIGFuZCBleHBvcnRzIHRvCiAgICBzb2x2ZSB0
aGUgaWRlbnRpZmllZCBpc3N1ZXMuIFRoaXMgbWFrZXMgdGhlIGNsZWFudXAgb2YgdGhlIG9kZCBm
aXh1cAogICAgZnVuY3Rpb25zIGluIGNvcHlfbWNfNjQgYW5kIHRoZSBmcHUgY29kZSBzaW1wbGVy
CgogIC0gTWFrZSBjb3B5X21jXzY0IGFuZCBGUFUgY29kZSB1c2UgdGhlIG5ldyBmaXh1cCB0eXBl
IG1lY2hhbmljcwoKICAtIFJlbW92ZSAjTUMgaGFuZGxpbmcgZnJvbSB0aGUgdmFyaW91cyAqU0FW
RSBmdW5jdGlvbnMgd2hpY2ggd3JpdGUgdGhlCiAgICBGUFUgcmVnaXN0ZXJzIHRvIHRoZSB1c2Vy
IHNwYWNlIHNpZ2ZyYW1lIGFzIHRoZXNlIGNhbid0IHJhaXNlICNNQwogICAgYWNjb3JkaW5nIHRv
IFRvbnkuCgogIC0gQWRkcmVzcyBhIGZldyByZXZpZXcgY29tbWVudHMgYW5kIGFkanVzdCB0aGUg
cGF0Y2hlcyB0byB0aGUgbmV3CiAgICBleGNlcHRpb24gdGFibGUgbWVjaGFuaXNtLgoKVGhhbmtz
LAoKCXRnbHgKClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzg3cjFlZGdzMncuZmZzQHRn
bHgKCi0tLQogYXJjaC94ODYvaWEzMi9pYTMyX3NpZ25hbC5jICAgICAgICAgICAgICAgIHwgICAx
NCArLQogYXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLmggICAgICAgICAgICAgICAgIHwgICA0OSAr
KysrLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGUuaCAgICAgICAgICAgICB8ICAg
NDQgKysrKystLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGVfZml4dXBfdHlwZXMuaCB8
ICAgMjIgKysrKwogYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L2ludGVybmFsLmggICAgICAgIHwg
ICA4NCArKysrKysrKysrLS0tLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaCAgICAgICAg
ICAgICAgICAgfCAgICA0IAogYXJjaC94ODYvaW5jbHVkZS9hc20vc2VnbWVudC5oICAgICAgICAg
ICAgIHwgICAgMiAKIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyAgICAgICAgICAgICB8
ICAgNDAgKystLS0tLS0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmggICAgICAg
ICB8ICAgMTQgLS0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL3NldmVyaXR5LmMgICAgICAgICB8
ICAgMjIgKystLQogYXJjaC94ODYva2VybmVsL2ZwdS9zaWduYWwuYyAgICAgICAgICAgICAgIHwg
IDE0NSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogYXJjaC94ODYva2VybmVsL3NpZ25h
bC5jICAgICAgICAgICAgICAgICAgIHwgICAxOCArLS0KIGFyY2gveDg2L2xpYi9jb3B5X21jXzY0
LlMgICAgICAgICAgICAgICAgICB8ICAgIDggLQogYXJjaC94ODYvbW0vZXh0YWJsZS5jICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEzMSArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQogYXJjaC94
ODYvbmV0L2JwZl9qaXRfY29tcC5jICAgICAgICAgICAgICAgIHwgICAxMSAtLQogc2NyaXB0cy9z
b3J0dGFibGUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCAKIDE2IGZpbGVzIGNoYW5n
ZWQsIDMwMiBpbnNlcnRpb25zKCspLCAzMTAgZGVsZXRpb25zKC0pCg==
