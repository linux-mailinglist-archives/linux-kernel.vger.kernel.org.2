Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D7403A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbhIHNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:30:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347055AbhIHNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:19 -0400
Message-ID: <20210908130922.118265849@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bKqpFg9bKfrQ7Ws59aTdjPW+KohgF4YujOpP/RdziPk=;
        b=QdCph5blTynRiyvvUZO6ywyjV/vlJrTKz/+zUKuAnOk3JTVA40qAjTN6EKcMHm0XhOsuPI
        mAVmMqK3KHQ0hQlkjqf48JGdJR0spKl+tGM9V23t9xJE0pb24k8JKxFKIq87r7g1fXLp5J
        N5YgBO2RJtpHVpTCCWdpuk9WvaQRkLdmsfbwe0m/IVMTTDseu2G4/Hem+yQS9vNFieA4Vs
        tpWYyZSBdBTgRC4nObEKId0AHAhfTWW7zpC6AgKeHpuQR7OhDdnphhf1ve+T5iOolOh8gu
        c0djxuEdv6DSnM+epmXLAhPDEqR6AAvphN+dpSCqNbmAiVGEMv9Pg82jctlf7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bKqpFg9bKfrQ7Ws59aTdjPW+KohgF4YujOpP/RdziPk=;
        b=onSLLJOHIHjJ9iMFgg8G6+MIFQVLgb75BBL2UbPQEq7W8gRrCKRQJplKllWWstWB3WkY6F
        j1Cjw7HxbsXtskBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed,  8 Sep 2021 15:29:10 +0200 (CEST)
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
IGZhdWx0CiAgICBkaXNhYmxlZCByZWdpb25zLgoKICAtIFRoZSBNQ0UgYXdhcmUgZXhjZXB0aW9u
IGZpeHVwIGlzIGluY29uc2lzdGVudCBhbmQgY29uZnVzaW5nIGVzcGVjaWFsbHkKICAgIGluIGNv
cHlfbWNfNjQuYy4gSXQgdXNlcyBhIGZpeHVwIGZ1bmN0aW9uIHdoaWNoIHN0b3JlcyB0aGUgdHJh
cCBudW1iZXIKICAgIGluIHJlZ3MtPmF4IGp1c3QgdG8gb3ZlcndyaXRlIHJlZ3MtPmF4IGF0IHRo
ZSBjYWxsc2l0ZSBzcGVjaWZpYyBmaXh1cC4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGNsZWFucyB0
aGlzIHVwLiBUaGUgcmVzdWx0aW5nIGV4Y2VjdXRhYmxlIGNvZGUgaXMKc2xpZ2h0bHkgc21hbGxl
ciB3aXRoIHRoYXQuCgpJdCdzIGFsc28gYXZhaWxhYmxlIGluIGdpdDoKCiAgICBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgeDg2L2Zw
dQoKQ2hhbmdlcyB2cy4gVjIgWzJdOgoKICAtIEZpeCB0aGUgYm9ndXMgbGVmdCBvdmVyIGNoZWNr
IGZvciAjUEYgd2hpY2ggY2F1c2VzIGJvb3QgZmFpbHVyZXMKClRoYW5rcywKCgl0Z2x4CgpbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci84N3IxZWRnczJ3LmZmc0B0Z2x4ClsyXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy8yMDIxMDkwNzIwMDcyMi4wNjcwNjgwMDVAbGludXRyb25peC5kZQoK
LS0tCiBhcmNoL3g4Ni9pYTMyL2lhMzJfc2lnbmFsLmMgICAgICAgICAgICAgICAgfCAgIDE0ICst
CiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9hc20uaCAgICAgICAgICAgICAgICAgfCAgIDQ5ICsrKyst
LS0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZS5oICAgICAgICAgICAgIHwgICA0NCAr
KysrKy0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZV9maXh1cF90eXBlcy5oIHwgICAy
MiArKysrCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvaW50ZXJuYWwuaCAgICAgICAgfCAgIDg0
ICsrKysrKysrKystLS0tLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oICAgICAgICAgICAg
ICAgICB8ICAgIDQgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmggICAgICAgICAgICAg
fCAgICAyIAogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICAgICAgICAgIHwgICA0
MCArKy0tLS0tLQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZXJuYWwuaCAgICAgICAgIHwg
ICAxNCAtLQogYXJjaC94ODYva2VybmVsL2NwdS9tY2Uvc2V2ZXJpdHkuYyAgICAgICAgIHwgICAy
MiArKy0tCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25hbC5jICAgICAgICAgICAgICAgfCAgMTQ0
ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMg
ICAgICAgICAgICAgICAgICAgfCAgIDE4ICstLQogYXJjaC94ODYvbGliL2NvcHlfbWNfNjQuUyAg
ICAgICAgICAgICAgICAgIHwgICAgOCAtCiBhcmNoL3g4Ni9tbS9leHRhYmxlLmMgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTMxICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9u
ZXQvYnBmX2ppdF9jb21wLmMgICAgICAgICAgICAgICAgfCAgIDExIC0tCiBzY3JpcHRzL3NvcnR0
YWJsZS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0IAogMTYgZmlsZXMgY2hhbmdlZCwg
MzAxIGluc2VydGlvbnMoKyksIDMxMCBkZWxldGlvbnMoLSkKCg==
