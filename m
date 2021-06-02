Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12905398650
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhFBKVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhFBKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF86C061352
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:54 -0700 (PDT)
Message-Id: <20210602095543.149814064@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hTZs+5AhR4bwy/7d1vxzkJY4gBmS4CGWka4Ym2pOIc4=;
        b=ASk+kjB/i+0e/UQbuf2P5AQuAo7cd3xWOWr9M+c1zxnov42wfil8ShDoQQqdZuf6o7rIZo
        dYVW7mAcVBb+I83TERb3FAwn9WNcIleul5ghWo3hUcuFW+eeqzYVRLvaRjARVB45wSSMZ3
        PHWyBFPsWuZHij4T5fY4NqlHqljkqYzM58kyxRMAyddWu3qQZfUXKQsGntdYMq8HF8ofe7
        dNvx81i0rwI4NerL37IpghSu/36VVhKzLPnqVySmjNpagAFeAwZFEFCg2dLFhRXPtbyDj2
        LRwsaSyFJvJwBujWqyupHsRJLJxxyiprr1eGNamIr0e9o3eBSf6cen+sijukaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hTZs+5AhR4bwy/7d1vxzkJY4gBmS4CGWka4Ym2pOIc4=;
        b=8+la6rb8tyVwa9BXGEOyVI7a97aZiACF4RpfzuuU9ryldcJKWEXhW3JLBHBFSioUinCRqu
        tdhseqwF2qAxupBQ==
Date:   Wed, 02 Jun 2021 11:55:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3lzemJvdCByZXBvcnRlZCBhIHdhcm5vbiBmb3IgWFJTVE9SIHJhaXNpbmcgI0dQOgoKIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMDAwMDAwMDAwMDAwNGM0NTM5MDVjMzBmODMzNEBnb29nbGUu
Y29tCgp3aXRoIGEgc3l6Y2FsbGVyIHJlcHJvZHVjZXIgYW5kIGEgY29uY2x1c2l2ZSBiaXNlY3Qg
cmVzdWx0LgoKSXQgdG9vayBhIHdoaWxlIHRvIGRlc3RpbGwgYSBzaW1wbGUgQyByZXByb2R1Y2Vy
IG91dCBvZiBpdCB3aGljaCBhbGxvd2VkIHRvCnBpbiBwb2ludCB0aGUgcm9vdCBjYXVzZTogVGhl
IHJlY2VudCBhZGRpdGlvbiBvZiBzdXBlcnZpc29yIFhTVEFURXMgYnJva2UKdGhlIHNpZ25hbCBy
ZXN0b3JlIHBhdGggZm9yIHRoZSBjYXNlIHdoZXJlIHRoZSBzaWduYWwgaGFuZGxlciB3cmVja2Fn
ZWQgdGhlClhTVEFURSBvbiBzdGFjayBiZWNhdXNlIGl0IGRvZXMgbm90IHNhbml0aXplIHRoZSBY
U1RBVEUgaGVhZGVyIHdoaWNoIGNhdXNlcwphIHN1YnNlcXVlbnQgWFJTVE9SIHRvIGZhaWwgYW5k
ICNHUC4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGFkZHJlc3NlcyB0aGUgcHJvYmxlbSBhbmQgZml4
ZXMgcmVsYXRlZCBpc3N1ZXMgd2hpY2gKd2VyZSBmb3VuZCB3aGlsZSBpbnNwZWN0aW5nIHRoZSBy
ZWxhdGVkIGNoYW5nZXMuCgpUaGFua3MgdG8gQW5keSBhbmQgRGF2ZSBmb3Igd29ya2luZyBvbiB0
aGlzIHdpdGggbWUhCgpUaGFua3MsCgoJdGdseAotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2Zw
dS94c3RhdGUuaCAgICAgICAgICAgICAgICAgICAgIHwgICAgNCAKIGFyY2gveDg2L2tlcm5lbC9m
cHUvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2MiArKysrKystLS0KIGFy
Y2gveDg2L2tlcm5lbC9mcHUvcmVnc2V0LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0
MyArKy0tLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAzMCArKystCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgOTUgKysrKystLS0tLS0tLS0tCiBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3g4Ni9jb3JydXB0X3hzdGF0ZV9oZWFkZXIuYyB8ICAxMTQgKysrKysrKysrKysr
KysrKysrCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICB8ICAgIDMgCiA3IGZpbGVzIGNoYW5nZWQsIDIzNCBpbnNlcnRpb25zKCspLCAxMTcgZGVs
ZXRpb25zKC0pCgoKCg==
