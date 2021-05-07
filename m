Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD23767FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhEGPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:31:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbhEGPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:31:38 -0400
Message-Id: <20210507110210.147106915@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620401437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7MvJgcbH4KVTmaIxlWmRkqiZpRWthdIm4TIk5RLHd3o=;
        b=P9y6omIsoDZZZFukY799nrWfc9XF1Ul99AeMmhg/qITtwI5CkgFeXsQ8vh5iNdXQJHby4Q
        oh3LPC+1YvgbyVTBLOUD85W2Y+P7BOQtBzYWC8dnV5Q6jk4mjOUwUVmcYTfQ8LkqFXu1xQ
        RKsW6rWi5EQpHqF1HGcMShxlq7PHuN1IEpkDQwAQ3+BkW9j7tBK8tUXHzrAn3CNx1FZhHJ
        tkbEZv9RkRWcISsJt45Kg25NFi7bBOkgZPxcDhKLBtGdPWU2nR076d2i25YcynQJIZY9aN
        b7wMDXT4ocs/q5TNpxnr+AnEdDV2q80C0bI46hk8Avivt1PGqFeTSgW3QNfT5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620401437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7MvJgcbH4KVTmaIxlWmRkqiZpRWthdIm4TIk5RLHd3o=;
        b=4ayGtwuqjo1e8eGH/kdk/+yIKJr4Mz/qqZbFqp0eDOyJ7oqB2f7phts9GryXGUMo+l9heC
        ij9P7RHuBRF/0FDg==
Date:   Fri, 07 May 2021 13:02:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
Subject: [patch 0/2] x86/idt: Consolidate IDT/TSS setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIElEVC9UU1Mgc2V0dXAgZm9yIHRoZSBib290IENQVSBvbiA2NC1iaXQgaXMgc3BsaXQgaW50
byB0d28gcGFydHM6CgogIDEpIFNldHVwIElEVCB3aXRob3V0IElTVCBiZWZvcmUgY3B1X2luaXQo
KQogIDIpIFNldHVwIElEVCB3aXRoIElTVCBhZnRlciBjcHVfaW5pdCgpCgpMYWkgbm90aWNlZCBb
MV0gdGhhdCB0aGUgTk1JIHNldHVwIGluICMxIGlzIHdyb25nIGJlY2F1c2UgaXQgdXNlcyB0aGUg
SVNUIGF3YXJlCmVudHJ5IHBvaW50IGJ1dCBpZiBhbiBOTUkgaGFwcGVucyB0aGVyZSBpdCB3b3Vs
ZCBydW4gb24gdGhlIGtlcm5lbCBzdGFjawp3aGljaCBjYW4gY2F1c2UgdGhlIElTVCBhd2FyZSBj
b2RlIHRvIG1hbGZ1bmN0aW9uLgoKVGhhdCdzIG5vdCBhIHJlYWwgcHJvYmxlbSBiZWNhdXNlIGEg
Tk1JIGhpdHRpbmcgZHVyaW5nIGVhcmx5IGJvb3QgYmVmb3JlCnRoZSBJRFQgaXMgZnVsbHkgc2V0
IHVwIGlzIGZhdGFsIGFueXdheS4gVGhlIGludGVybWVkaWF0ZSBpc3N1ZSB3aXRoIHRoZQpzcGxp
dCBzZXR1cCBpcyBqdXN0IG1ha2luZyB0aGF0IHdpbmRvdyBtYXJnaW5hbGx5IHdpZGVyLiBUaG91
Z2ggdGhlIHNldHVwCmxvZ2ljIGlzIG1vcmUgY29udm9sdXRlZCB0aGFuIG5lY2Vzc2FyeS4KClRo
ZXJlIGlzIGFub3RoZXIgb2RkaXR5IHJlZ2FyZGluZyBzZWNvbmRhcnkgQ1BVcy4gVGhlIHJlY2Vu
dGx5IGFkZGVkIFNFVgpzdXBwb3J0IHJlcXVpcmVzICNWQyB0byBiZSBmdW5jdGlvbmFsIHdoZW4g
aW52b2tpbmcgY3B1X2luaXQoKSBhbmQKdGhlcmVmb3JlIGFkZGVkIGEgc2VwYXJhdGUgZnVuY3Rp
b24gd2hpY2ggaW5pdGlhbGl6ZXMgVFNTIGJlZm9yZSB0aGF0LgoKTm93IGNwdV9pbml0KCkgaXRz
ZWxmIGRvZXMgdGhlIHNhbWUgaW5pdGlhbGl6YXRpb24gYWdhaW4sIHdoaWNoIGlzCnBvaW50bGVz
cyBhbmQgY29uZnVzaW5nIGF0IGJlc3QuCgpCb3Jpc2xhdiBwb3N0ZWQgYSBwYXRjaCBbMl0gd2hp
Y2ggbW92ZXMgdGhlIFRTUyBpbml0aWFsaXphdGlvbiB0byB0aGUgc3RhcnQgb2YKY3B1X2luaXQo
KSwgYnV0IHdoZW4gbG9va2luZyBhdCB0aGUgYm9vdCBDUFUgc2V0dXAsIHRoaXMgaXMgbm90IGhl
bHBmdWwuCgpTbyBJIGtlcHQgdGhlIHNlcGFyYXRlIGZ1bmN0aW9uIGFuZCBtYWRlIHVzZSBvZiBp
dCBpbiB0cmFwX2luaXQoKSBzbyB0aGF0CnRoZSBvcmRlcmluZyBpcyBub3cgVFNTIHNldHVwLCBJ
RFQgc2V0dXAsIGNwdV9pbml0KCkuIFRoYXQgYWxsb3dzIHRvIGdldApyaWQgb2YgdGhlIHNlcGFy
YXRlIElTVCBzZXR1cCBzdGVwIGFuZCBtYWtlcyB0aGUgb3ZlcmFsbCBjb2RlIHNpbXBsZXIuCgpU
aGFua3MsCgoJdGdseAoKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA0MjYyMzA5
NDkuMzU2MS0zLWppYW5nc2hhbmxhaUBnbWFpbC5jb20KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyMTA1MDQxNzE3NDUuMjI0OS0xLWJwQGFsaWVuOC5kZQotLS0KIGluY2x1ZGUvYXNt
L2Rlc2MuaCAgICAgIHwgICAgMiAtLQogaW5jbHVkZS9hc20vcHJvY2Vzc29yLmggfCAgICAxICsK
IGtlcm5lbC9jcHUvY29tbW9uLmMgICAgIHwgICAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0K
IGtlcm5lbC9pZHQuYyAgICAgICAgICAgIHwgICA0MCArKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiBrZXJuZWwvdHJhcHMuYyAgICAgICAgICB8ICAgIDkgKysrLS0tLS0t
CiA1IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQoKCgoK
