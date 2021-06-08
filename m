Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5639439F98B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhFHOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhFHOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:19 -0400
Message-Id: <20210608143617.565868844@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ot1Q1zefd/zaAtJg7GVY8sdI4qtA+CpzvvUDCHO3GSE=;
        b=1DMRnq9jHsbfilOuwHDDmyJllsmP2sAH7XuRPIDyZwfKgZyW2w9Pl3+7SSsLc5dllS4KCT
        gir/vMcxmzrQC8x5rqslca3bMUlWZryzvSMcz13GpRC2zGBp4HLQboOM0wcwJl7VAWOWn5
        ppA9B/IiE85qn0BX2u0nzSUcBWC4M2fWoc0tj7zVJzc1LigcHmrj8un9c3tdMIMZZNsA+i
        PkfE2/V6o8KHiu/gisUzr7/mFRYrZvlOR1wSj321NjJvvWDL6ATDMC4QH9HVhAmds9b6bN
        WFH/Ugt+AV3iJKdzOrgN/gQJY9SwgxaibXvFG3z0pW3F7DSmuth+hbFQlVrXrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ot1Q1zefd/zaAtJg7GVY8sdI4qtA+CpzvvUDCHO3GSE=;
        b=b6MFDJXGEbu8RuTiBH93C2VhprXSMtKwK8EMblpCfew3D3s2V1nsW40GN7dwbqjrVvbnc5
        rnWB/Kse6ynF6UDA==
Date:   Tue, 08 Jun 2021 16:36:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: [patch V3 0/6] x86/fpu: Mop up XSAVES and related damage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3lzemJvdCByZXBvcnRlZCBhIHdhcm5vbiBmb3IgWFJTVE9SIHJhaXNpbmcgI0dQOgoKICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzAwMDAwMDAwMDAwMDRjNDUzOTA1YzMwZjgzMzRAZ29vZ2xl
LmNvbQoKd2l0aCBhIHN5emNhbGxlciByZXByb2R1Y2VyIGFuZCBhIGNvbmNsdXNpdmUgYmlzZWN0
IHJlc3VsdC4gIEl0IHRvb2sgYQp3aGlsZSB0byBkZXN0aWxsIGEgc2ltcGxlIEMgcmVwcm9kdWNl
ciBvdXQgb2YgaXQgd2hpY2ggYWxsb3dlZCB0byBwaW4gcG9pbnQKdGhlIHJvb3QgY2F1c2U6IFRo
ZSByZWNlbnQgYWRkaXRpb24gb2Ygc3VwZXJ2aXNvciBYU1RBVEVzIGJyb2tlIHRoZSBzaWduYWwK
cmVzdG9yZSBwYXRoIGZvciB0aGUgY2FzZSB3aGVyZSB0aGUgc2lnbmFsIGhhbmRsZXIgd3JlY2th
Z2VkIHRoZSBYU1RBVEUgb24Kc3RhY2sgYmVjYXVzZSBpdCBkb2VzIG5vdCBzYW5pdGl6ZSB0aGUg
WFNUQVRFIGhlYWRlciB3aGljaCBjYXVzZXMgYQpzdWJzZXF1ZW50IFhSU1RPUiB0byBmYWlsIGFu
ZCAjR1AuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhlIHByb2JsZW0gYW5kIGZp
eGVzIHJlbGF0ZWQgaXNzdWVzCndoaWNoIHdlcmUgZm91bmQgd2hpbGUgaW5zcGVjdGluZyB0aGUg
cmVsYXRlZCBjaGFuZ2VzIGFuZCB0ZXN0aW5nCnNpZ25hbCByZXN0b3JlIGFuZCBQS1JVLgoKVjIg
b2YgdGhpcyBjYW4gYmUgZm91bmQgaGVyZToKCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDIxMDYwNTIzNDc0Mi43MTI0NjQ5NzRAbGludXRyb25peC5kZQoKQ2hhbmdlcyB2cy4gVjI6Cgog
IC0gRHJvcCB0aGUgY2xlYW51cCBwYXRjaGVzIGZvciBub3csIHNvIHRoZSBidWcgZml4ZXMgbWFr
ZSBwcm9ncmVzcwoKICAtIEZpeCB0aGUgUEtSVSBjb250ZXh0IHN3aXRjaCBjb2RlCgogIC0gQWRk
cmVzcyByZXZpZXcgY29tbWVudHMKClRoYW5rcywKCgl0Z2x4Cg==
