Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F274163A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhIWQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhIWQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:54:36 -0700 (PDT)
Message-ID: <20210923164145.466686140@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f05Si0mMmtCsJecBRDb7NV/Oz8Bt5X4+rjVIhG9DxYM=;
        b=jk4Z7b2DUu/ZDE72AbQsz90H/N9mAtfSyJYNAo3iAgQiCgYsGWKEd5jxG90tP/ESV792/Y
        ZWJianxzBkHDUVB7sBrJfoiJKWXg5Uw/LWfyOfbivyRCVMVYTifW+0PIHWoxzNjsuhBhsE
        g7YZapoVuv61Ld0DmG8E9rXWE4VaE3H3bMIEtg5kRwv/UDdpfJom0+4Z8bV1zQTD6gY3TJ
        fkjRn6leQ6bvzd1LjVxx4h83DPEM/cX2vs2uA0bXudOF7Rg3WOyjSwzp/UGxRXNvJ0+5e5
        0gjQHJlqVE633LTqdFmpjYnxh9spgImcEbwcA4rzcwDBsbi4MltRluNVTv2fww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f05Si0mMmtCsJecBRDb7NV/Oz8Bt5X4+rjVIhG9DxYM=;
        b=hwjXM9ViKbLKH4K6oCgLT2J4McVaEsLV6MjxAqyYoy43H8Uc4nAQ85BX7aVT47+0iGRG2/
        iEeWnkAh3Tsu4tCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 0/8] sched: Clean up might_sleep() and make it RT aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 23 Sep 2021 18:54:34 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1pZ2h0IHNsZWVwIGNoZWNrcyBoYXZlIGdyb3duIHNvbWUgd2FydHMgb3ZlciB0aW1lIGFu
ZCBlc3BlY2lhbGx5IHRoZQp1bmRlcnNjb3JlIHpvbyBpcyBoYXJkIHRvIGZvbGxvdy4KCkFsc28g
dGhlIGRlYnVnIG91dHB1dCBpcyBzbGlnaHRseSBjb25mdXNpbmcgZXNwZWNpYWxseSB3aGVuIFBS
RUVNUFRfUkNVIGlzCmVuYWJsZWQgYXMgaXQgZG9lcyBub3QgcHJvdmlkZSBpbmZvcm1hdGlvbiBh
Ym91dCB0aGUgUkNVIG5lc3RpbmcgZGVwdGgKd2hpY2ggbWlnaHQgYmUgdGhlIGFjdHVhbCBjdWxw
cml0LiBJbiBzdWNoIGEgY2FzZSBpdCBtaWdodCBldmVuIHByaW50CmNvbmZ1c2luZyBpbmZvcm1h
dGlvbiBhYm91dCB0aGUgcGxhY2Ugd2hpY2ggZGlzYWJsZWQgcHJlZW1wdGlvbiBkZXNwaXRlIHRo
ZQpmYWN0IHRoYXQgcHJlZW1wdGlvbiBpcyBhY3R1YWxseSBlbmFibGVkLgoKUlQgaW4gdHVybiBo
YWQgaXQncyBvd24gbmFzdHkgaGFjayB0byBpZ25vcmUgUkNVIG5lc3RpbmcgZGVwdGggYmVjYXVz
ZQp0aGF0J3MgcmVxdWlyZWQgZm9yIHNwaW4vcncgbG9jayBoZWxkIHNlY3Rpb25zLgoKVGhpcyBz
ZXJpZXMgYWRkcmVzc2VzIHRoaXMgYnk6CgogIC0gQ2xlYW5pbmcgdXAgdGhlIHVuZGVyc2NvcmUg
em9vCgogIC0gRW5oYW5jaW5nIHRoZSBkZWJ1ZyBvdXRwdXQKCiAgLSBNYWtpbmcgUkNVIG5lc3Qg
ZGVwdGggYW5kIHByZWVtcHQgY291bnQgY2hlY2tzIGRpc3RpbmN0CgogIC0gRml4aW5nIHVwIHRo
ZSByZWxldmFudCBwbGFjZXMgdG8gaGFuZCBpbiB0aGUgY29ycmVjdCBleHBlY3RlZCB2YWx1ZXMK
ICAgIGZvciBSVCBhbmQgIVJUIGtlcm5lbHMuCgpUaGUgc2VyaWVzIGlzIGFsc28gYXZhaWxhYmxl
IGZyb20KCiAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dGdseC9kZXZlbC5naXQgc2NoZWQKClRoYW5rcywKCgl0Z2x4Ci0tLQogaW5jbHVkZS9saW51eC9r
ZXJuZWwuaCAgICAgICB8ICAgMTMgKysrLS0tLS0KIGluY2x1ZGUvbGludXgvcHJlZW1wdC5oICAg
ICAgfCAgICA1ICstLQogaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgICB8ICAgMzkgKysrKysr
KysrKysrKysrKysrLS0tLS0tLQoga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfcnQuYyB8ICAgMTcg
KysrKysrKystLQoga2VybmVsL3NjaGVkL2NvcmUuYyAgICAgICAgICB8ICAgNjcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQogbW0vbWVtb3J5LmMgICAgICAgICAg
ICAgICAgICB8ICAgIDIgLQogNiBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCA0NyBk
ZWxldGlvbnMoLSkKCgoK
