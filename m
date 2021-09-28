Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0341AEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbhI1M0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhI1M0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:24:26 -0700 (PDT)
Message-ID: <20210928122339.502270600@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E0xAeuB5PBw7fgp3qQq5IN4tyaWZ7mgVLPUsreHrp6E=;
        b=4rc5xPQeWKMKv3eil1ulkxqz7WiZeewc2P158sMFFfF2uRvCrTNNzitXjM+6mBCGqZTsi6
        c4HZ7cvyqqRrSo/KSKkAhsFee2Mwkgeo4W1p/kUckOUCILtoywYl+mzw87VCkrH78ngZGK
        xN61nJTJNvIQ8SxmE1TrDcuAgjjw65TfN4B9ZbiUAg8X0BvBKDaui6wuOR8BHOs4IJTPsT
        f3uGKq2ttCCIFtdGrW5+70+x2CeYZEeFqJdu2hkdWaKBcvAVMM0mwsMnRE8TTk8z8uUJzK
        ww4ZpxyUGqulKJX/QFeuuVXUkVNg0g3wtSfpRQvbmMWxNlrXBW6DqJqSI1lbvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E0xAeuB5PBw7fgp3qQq5IN4tyaWZ7mgVLPUsreHrp6E=;
        b=PiyFmdxMsEGQq9p1YQwpHXMdwtwRvq5EYzsGYzdBEaVLo+7EH8LS7iHCZFZPoYc4WAIaId
        W4c6N6O4kwVno8DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 0/5] sched: Miscellaneous RT related tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 28 Sep 2021 14:24:23 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UlQgZW5hYmxlZCBrZXJuZWxzIGhhdmUgYSBmZXcgaXNzdWVzIHdpdGggdGhlIGlubmVyIHdvcmtp
bmdzIG9mIHRoZQpzY2hlZHVsZXI6CgogICAtIFRoZSByZW1vdGUgVFRXVV9RVUVVRSBtZWNoYW5p
c20gbGVhZHMgdG8gNXggbGFyZ2VyIG1heGltdW0gbGF0ZW5jaWVzCgogICAtIFRoZSBiYXRjaGVk
IG1pZ3JhdGlvbiBsaW1pdCBvZiAzMiB0YXNrcyBjYXVzZXMgbGFyZ2UgbGF0ZW5jaWVzCgogICAt
IFRoZSBjbGVhbnVwIG9mIGtwcm9iZXMsIHZtYXBwZWQgc3RhY2tzIG9mIGRlYWQgdGFza3MgYW5k
IG1tZHJvcCgpIGFyZQogICAgIGxhdGVuY3kgc291cmNlcyBhbmQgZXZlbnR1YWxseSBjYWxsaW5n
IGludG8gY29kZSBwYXRoZXMgd2hpY2ggdGFrZQogICAgIHJlZ3VsYXIgc3BpbmxvY2tzIGZyb20g
d2l0aGluIHRoZSBzY2hlZHVsZXIgY29yZSB3aGljaCBoYXMgcHJlZW1wdGlvbgogICAgIGRpc2Fi
bGVkLgoKVGhlIGZvbGxvd2luZyBzZXJpZXMgY2xlYW5zIHRoaXMgdXAuIEl0IGlzIGFsc28gYXZh
aWxhYmxlIGZyb20gZ2l0OgoKICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBzY2hlZAoKYXBwbGllZCBvbiB0b3Agb2YgdGhlIHBy
ZXZpb3VzIG1pZ2h0X3NsZWVwKCkgY2xlYW51cHM6CgogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDIxMDkyMzE2NDE0NS40NjY2ODYxNDBAbGludXRyb25peC5kZQoKVGhhbmtzLAoKCXRn
bHgKLS0tCiBpbmNsdWRlL2xpbnV4L21tX3R5cGVzLmggfCAgICA0ICsrKysKIGluY2x1ZGUvbGlu
dXgvc2NoZWQvbW0uaCB8ICAgMjAgKysrKysrKysrKysrKysrKysrKysKIGtlcm5lbC9leGl0LmMg
ICAgICAgICAgICB8ICAgIDcgKysrKysrKwoga2VybmVsL2ZvcmsuYyAgICAgICAgICAgIHwgICAx
OCArKysrKysrKysrKysrKysrKy0KIGtlcm5lbC9rcHJvYmVzLmMgICAgICAgICB8ICAgIDggKysr
Ky0tLS0KIGtlcm5lbC9zY2hlZC9jb3JlLmMgICAgICB8ICAgMTYgKysrKysrKysrLS0tLS0tLQog
a2VybmVsL3NjaGVkL2ZlYXR1cmVzLmggIHwgICAgNSArKysrKwogNyBmaWxlcyBjaGFuZ2VkLCA2
NiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCgo=
