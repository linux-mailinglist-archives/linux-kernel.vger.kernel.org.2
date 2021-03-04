Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904E732DA0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhCDTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236972AbhCDTGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:06:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D47964F6B;
        Thu,  4 Mar 2021 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884770;
        bh=7LrZWfNLol5t2kvnpVyfLtni2s7+fi4sO40UtEpltH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3QynV/GJPQswWurxr5/JAjmkjfcmhnYgq27jl4BHFJQmtXR7KQsmbP5b7JsOMr1o
         xHCpi2yCvl0+wpxFwBN46tOD9rAO08dJjy/vIyR+8HmEGEbgkxpN8PEb5CY8kTQaVy
         bBeahgurMMa4G/nedwjKP4pV61PAbXljmoOBcoVYrswh+BIrm7i9r1qCAk80GhOctC
         lyvEETN/+sfYeco38jPfAyY9E+31yA6YzJpm69DIs4Al7Ee9PCN6Uq9z8z+UJDi9B+
         BYUO7iCrP0VQuMt+oI8eEtyyZ6+aD1tU6GORoWHKVDT3vAoKvWYluPw0FLB2jPr9+u
         WYBh7ibJHZ+yQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 03/11] x86/dumpstack: Remove unnecessary range check fetching opcode bytes
Date:   Thu,  4 Mar 2021 11:05:56 -0800
Message-Id: <b2872f67cbfc649229ddc4e6c3418ec03d3707e3.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614884673.git.luto@kernel.org>
References: <cover.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_from_user_nmi() validates that the pointer is in the user range,
so there is no need for an extra check in copy_code().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 299c20f0a38b..55cf3c8325c6 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -81,12 +81,6 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	/* The user space code from other tasks cannot be accessed. */
 	if (regs != task_pt_regs(current))
 		return -EPERM;
-	/*
-	 * Make sure userspace isn't trying to trick us into dumping kernel
-	 * memory by pointing the userspace instruction pointer at it.
-	 */
-	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
-		return -EINVAL;
 
 	/*
 	 * Even if named copy_from_user_nmi() this can be invoked from
-- 
2.29.2

