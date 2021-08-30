Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA73FBA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhH3Q2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3Q2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5223CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:24 -0700 (PDT)
Message-ID: <20210830154702.247681585@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sL1aEreOcMJvcUj9TxNa/or3zcQkdTbG0FipmP2mvLQ=;
        b=h33UnqwJztLIGznkD8XTv9S0ZRDFl8iBP3svGvY2MHjerQgI0arxvSnsfoIqsi47X3n/mq
        7C0j7JtdKwMdkT4Iu3dCy333FrS6t8NbSxxZMmwVWbzaf8myv6s6tAbxW/UtOkZ8lDCVSg
        9l0BpTw6GMZlgQ3GImBTHmCGMiruZS9j+gPsQRvPNARkB0qSyXwlClHxnw+h5gnWUkrQ9g
        FLLDwmXlyzd8guUIk3kHlEvkMJm3zfMZwTHiyeuvp/8OWSZijrViYus5sWH6yaaVPuOs4E
        zJqoQXSgz8/D1V6ITS2Aj+wsmMUdQiOdgR8dlNIgYsoJWwmhhs/sxItYzt3H9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sL1aEreOcMJvcUj9TxNa/or3zcQkdTbG0FipmP2mvLQ=;
        b=fXzq12W6ytbv8jvyXug0v0GSk0XD9F8kWI4WyVEcmid1h3NR1xXQj395N+EoB4nRM/S0cu
        0b8Ju/dwxtzmxPBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 00/10] x86/fpu: Clean up error handling in sigframe related code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 30 Aug 2021 18:27:21 +0200 (CEST)
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
IGZhdWx0CiAgICBkaXNhYmxlZCByZWdpb25zLgoKVGhlIGZvbGxvd2luZyBzZXJpZXMgY2xlYW5z
IHRoaXMgdXAuIEFzIGEgc2lkZSBlZmZlY3QgdGhlIHJlc3VsdGluZyB0ZXh0CnNpemUgb2YgZnB1
L3NpZ25hbC5vIHNocmlua3MgYnkgYWJvdXQgMTUwIGJ5dGVzLgoKSXQncyBhbHNvIGF2YWlsYWJs
ZSBpbiBnaXQ6CgogICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RnbHgvZGV2ZWwuZ2l0IHg4Ni9mcHUKClRoYW5rcywKCgl0Z2x4CgpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci84N3IxZWRnczJ3LmZmc0B0Z2x4CgotLS0KIGlhMzIvaWEzMl9zaWdu
YWwuYyAgICAgICAgIHwgICAxNCArKy0tCiBpbmNsdWRlL2FzbS9mcHUvaW50ZXJuYWwuaCB8ICAg
MjEgKystLS0tCiBrZXJuZWwvZnB1L3NpZ25hbC5jICAgICAgICB8ICAxNDUgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBrZXJuZWwvc2lnbmFsLmMgICAgICAg
ICAgICB8ICAgMTggKystLS0KIDQgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKSwgMTAw
IGRlbGV0aW9ucygtKQo=
