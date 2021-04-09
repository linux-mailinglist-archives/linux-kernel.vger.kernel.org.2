Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA435923E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhDICxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:53:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E796C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7/Dg/Cn4hiezfT7+yxq/CWqT5OzdKAeGHnycR9UW/GA=; b=Jr4/rSPhfT3L9ql2PEAbL6w2A7
        r/qhJVfAac+QgSq2/pPRzC30TG5FLXzQTHVYBySsQJ6fj5mZhdjgRA8dt5UTjjZqqEjGVPDLT8dJA
        DBmS0qShj6JZ1ZhpRl8AXqloh2Gh+L0EbHXRAOQZsvyO5nV7Xl5jo7jBxT5w1DdhlWZyIDDi9f1EK
        euFZj3KS/0UF8UjG2gTezMH9cTVKm5B0Ks7lB9SrPACu08W3zDRXovR9KRt4C1g0amPt5za5pveMb
        rP+5GAg+NMbHIYX/uY5j/lpSB5ggVsZs3DdeXPKUFYIQENcGmpIGYxtuFJYZr4X8zKpTIaSwnxkCq
        QCjqvOQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhFj-00HGJL-Ha; Fri, 09 Apr 2021 02:52:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] x86: Rename split_lock_init to sld_init
Date:   Fri,  9 Apr 2021 03:51:15 +0100
Message-Id: <20210409025131.4114078-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use split_lock_init() for a global symbol, so rename this
local one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/cpu/intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fe0bec14d7ec..44ed490c8a49 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -602,7 +602,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
-static void split_lock_init(void);
+static void sld_init(void);
 static void bus_lock_init(void);
 
 static void init_intel(struct cpuinfo_x86 *c)
@@ -720,7 +720,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
 
-	split_lock_init();
+	sld_init();
 	bus_lock_init();
 
 	intel_init_thermal(c);
@@ -1080,7 +1080,7 @@ static void sld_update_msr(bool on)
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
 }
 
-static void split_lock_init(void)
+static void sld_init(void)
 {
 	if (cpu_model_supports_sld)
 		split_lock_verify_msr(sld_state != sld_off);
-- 
2.30.2

