Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B831A3A46BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFKQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFKQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:45:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:43:59 -0700 (PDT)
Message-Id: <20210611161523.508908024@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XTWLTMrY9lnGbhCpse2rIwY1lhdcMo/k7awkXdSB5Hs=;
        b=jKzKit61JdvhpFoeCya70pHxQ6O5n6Rx78lHpZ5TNEvH2vQxWS1XtDWPBceDdsz30oxSSf
        EIEQypnqnNvdeZTObx9ZbEBhdBPRSP3T67fK0XZOoLu8oisa9wZvyYVpWFMAumho/E8qAS
        FUrLw7rkxOe7VCsSkGEu+MTI9A5stds/vRLhI6BJrp80pwa46TDy9rQlTz0LYiFPiYNqIR
        yZ0dtHqpl7Q4jq1waywtnehoR6U7JcwgER+BUaV3TIhcTd2w+Zm7WTYdFfQPfR9f8rE3fW
        EwSRUYHde0MTffENvytR8k+s9X/TK1+wwvhl1/JPJoyEinP0PdwTH5DItDhi7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XTWLTMrY9lnGbhCpse2rIwY1lhdcMo/k7awkXdSB5Hs=;
        b=sWqWWiJq4Myg5BSeawcEbXGDFTARDr6dKIukRteBajqAlsg/gVwIrY6lW0EH0F89vfL5+K
        YwqBEg1oOphQveDg==
Date:   Fri, 11 Jun 2021 18:15:23 +0200
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
Subject: [patch 00/41] x86/fpu: Spring cleaning and PKRU sanitizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhIGZvbGxvdyB1cCB0byB0aGVzZSBwYXRjaCBzZXJpZXM6CgogLSBbcGF0Y2ggVjIg
MDAvMTRdIHg4Ni9mcHU6IE1vcCB1cCBYU0FWRVMgYW5kIHJlbGF0ZWQgZGFtYWdlCiAgIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA2MDUyMzQ3NDIuNzEyNDY0OTc0QGxpbnV0cm9uaXgu
ZGUKCiAtIFtQQVRDSCAwMC8xOF0geDg2L3BrZXlzOiBzdG9wIG1hbmFnaW5nIFBLUlUgd2l0aCBY
U0FWRQogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNjAzMjMwODAzLjMxNjYwQUZF
QHZpZ2dvLmpmLmludGVsLmNvbQoKIC0gW1BBVENIIDAvMl0geDg2L2ZwdTogQ2xlYW4gdXAgImR5
bmFtaWMiIEFQSXMKICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9jb3Zlci4xNjIzMzg4MzQ0
LmdpdC5sdXRvQGtlcm5lbC5vcmcKClRoZSBhbmFseXNpcyBvZiB0aGUgc3VidGxlIGJ1Z3MgaW4g
dGhlIEZQVSBjb2RlIHRyaWdnZXJlZCBhIGxhcmdlcgpkaXNjdXNzaW9uIGFib3V0IHRoZSBnZW5l
cmFsIHN0YXRlIG9mIHRoaXMgY29kZS4gVGhlIGFib3ZlIHBhdGNoIHNlcmllcyBhcmUKYWxsIHJl
bGF0ZWQgdG8gdGhpcyBhbmQgdGhlIGZvbGxvd2luZyBzZXJpZXMgY29tYmluZXMgdGhlbSBpbnRv
IG9uZSBiZWNhdXNlCnRoZSBhbHJlYWR5IHN0YXJ0ZWQgY29uc29saWRhdGlvbiB3b3JrIGFuZCB0
aGUgUEtSVSByZXdvcmsgY29sbGlkZWQgYWxsCm92ZXIgdGhlIHBsYWNlLgoKVGhlIG1haW4gcGFy
dHMgb2YgdGhpcyBzZXJpZXMgYXJlOgoKICAtIFNpbXBsaWZpY2F0aW9uIGFuZCByZW1vdmFsL3Jl
cGxhY2VtZW50IG9mIHJlZHVuZGFudCBhbmQvb3IKICAgIG92ZXJlbmdpbmVlcmVkIGNvZGUuCgog
IC0gTmFtZSBzcGFjZSBjbGVhbnVwIGFzIHRoZSBleGlzdGluZyBuYW1lcyB3ZXJlIGp1c3QgYSBw
ZXJtYW5lbnQgc291cmNlCiAgICBvZiBjb25mdXNpb24uCgogIC0gQ2xlYXIgc2VwZXJhdGlvbiBv
ZiB1c2VyIEFCSSBhbmQga2VybmVsIGludGVybmFsIHN0YXRlIGhhbmRsaW5nLgoKICAtIFJlbW92
YWwgb2YgUEtSVSBmcm9tIGJlaW5nIFhTVEFURSBtYW5hZ2VkIGluIHRoZSBrZXJuZWwgYmVjYXVz
ZSBQS1JVCiAgICBoYXMgdG8gYmUgZWFnZXJseSByZXN0b3JlZCBvbiBjb250ZXh0IHN3aXRjaCBh
bmQga2VlcGluZyBpdCBpbiBzeW5jCiAgICBpbiB0aGUgeHN0YXRlIGJ1ZmZlciBpcyBqdXN0IHBv
aW50bGVzcyBvdmVyaGVhZCBhbmQgZnJhZ2lsZS4KCiAgICBUaGUga2VybmVsIHN0aWxsIFhTQVZF
cyBQS1JVIG9uIGNvbnRleHQgc3dpdGNoIGJ1dCB0aGUgdmFsdWUgaW4gdGhlCiAgICBidWZmZXIg
aXMgbm90IGxvbmdlciB1c2VkIGFuZCBuZXZlciByZXN0b3JlZCBmcm9tIHRoZSBidWZmZXIuCgog
ICAgVGhpcyBzdGlsbCBuZWVkcyB0byBiZSBjbGVhbmVkIHVwLCBidXQgdGhlIHNlcmllcyBpcyBh
bHJlYWR5IDQwKwogICAgcGF0Y2hlcyBsYXJnZSBhbmQgdGhlIGNsZWFudXAgb2YgdGhpcyBpcyBu
b3QgYSBmdW5jdGlvbmFsIHByb2JsZW0uCgogICAgVGhlIGZ1bmN0aW9uYWwgaXNzdWVzIG9mIFBL
UlUgbWFuYWdlbWVudCBhcmUgZnVsbHkgYWRkcmVzc2VkIHdpdGggdGhlCiAgICBzZXJpZXMgYXMg
aXMuCgpJdCBhcHBsaWVzIG9uIHRvcCBvZgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgbWFzdGVyCgphbmQgaXMgYWxzbyBhdmFpbGFi
bGUgdmlhIGdpdDoKCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RnbHgvZGV2ZWwuZ2l0IHg4Ni9mcHUKClRoYW5rcywKCgl0Z2x4Ci0tLQogYXJjaC94ODYv
ZXZlbnRzL2ludGVsL2xici5jICAgICAgICAgIHwgICAgNiAKIGFyY2gveDg2L2luY2x1ZGUvYXNt
L2ZwdS9pbnRlcm5hbC5oICB8ICAxNTUgKysrKy0tLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNt
L2ZwdS94c3RhdGUuaCAgICB8ICAgNjEgKysrLQogYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJs
ZS5oICAgICAgIHwgICA1NyAtLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa2V5cy5oICAgICAg
ICAgfCAgICA5IAogYXJjaC94ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmggICAgIHwgICAgOSAK
IGFyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaCB8ICAgMTQgLQogYXJjaC94ODYv
a2VybmVsL2NwdS9jb21tb24uYyAgICAgICAgIHwgICAyOSAtLQogYXJjaC94ODYva2VybmVsL2Zw
dS9jb3JlLmMgICAgICAgICAgIHwgIDI0MyArKysrKysrKysrKystLS0tLS0KIGFyY2gveDg2L2tl
cm5lbC9mcHUvaW5pdC5jICAgICAgICAgICB8ICAgIDQgCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3Jl
Z3NldC5jICAgICAgICAgfCAgMTE2ICsrKystLS0tCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25h
bC5jICAgICAgICAgfCAgIDU5ICsrLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMgICAg
ICAgICB8ICA0NTYgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gveDg2
L2tlcm5lbC9wcm9jZXNzLmMgICAgICAgICAgICB8ICAgMTkgKwogYXJjaC94ODYva2VybmVsL3By
b2Nlc3NfNjQuYyAgICAgICAgIHwgICAyOCArKwogYXJjaC94ODYva3ZtL3N2bS9zZXYuYyAgICAg
ICAgICAgICAgIHwgICAgMSAKIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICB8
ICAgNTIgKystCiBhcmNoL3g4Ni9tbS9leHRhYmxlLmMgICAgICAgICAgICAgICAgfCAgICAyIAog
YXJjaC94ODYvbW0vZmF1bHQuYyAgICAgICAgICAgICAgICAgIHwgICAgMiAKIGFyY2gveDg2L21t
L3BrZXlzLmMgICAgICAgICAgICAgICAgICB8ICAgMjIgLQogYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wa3J1LmggICAgICAgIHwgICA2MiArKysrCiBpbmNsdWRlL2xpbnV4L3BrZXlzLmggICAgICAg
ICAgICAgICAgfCAgICA0IAogMjIgZmlsZXMgY2hhbmdlZCwgNjcxIGluc2VydGlvbnMoKyksIDcz
OSBkZWxldGlvbnMoLSkKCgoK
