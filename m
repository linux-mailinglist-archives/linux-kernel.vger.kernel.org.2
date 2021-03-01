Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5268B3281D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhCAPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhCAPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A9C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8k-00AJOK-0j; Mon, 01 Mar 2021 16:07:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/8] um: remove unused smp_sigio_handler() declaration
Date:   Mon,  1 Mar 2021 16:07:03 +0100
Message-Id: <20210301160501.365e0ec0ecf1.I479aba3ebfb7a6418255b7a51c5c2cfe3796e9a2@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function doesn't exist, remove its declaration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/kern_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 2888ec812f6e..a2cfd42608a0 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -33,7 +33,6 @@ extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);
 
 extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
-extern int smp_sigio_handler(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
 
-- 
2.26.2

