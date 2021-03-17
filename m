Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD333F7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhCQSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhCQSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DED64F40;
        Wed, 17 Mar 2021 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004770;
        bh=tAOWHqC9P/wCJfEc7pwTm0f6ZDZ3W3seZrEz5rIOACQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1AU1pJHHE2V6GJnv0oZiXQma+HCVhTPSEa1JU5j7KWFjzdp+hNqAw5P+moVYYuft
         y4NqpYtYluHyQqhnSVQiZgMrW34mLRObLbI9ixWUooSmvrtilrF5aJeMMA+LaDoIt0
         c80GidzYk0mfIFN7MaNsuxFgmdmhgDvM5YpZLAdoxo5DIDPQsRcoFPkdMFUCVpuwkj
         6Dao2J9YFfHbleJ8erzXAo2KhUADiEoPfvvBed9s2EnY23a7B0rOk/sTme1Z0hxoaw
         x2EXjht3DoowV84+WWg2dnZi0pT6Rc+k92+OHMYm2ALHkLHKiAHXfZyYYfvTI9v+cH
         bw493HEW/2FRQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 1/9] x86/dumpstack: Remove unnecessary range check fetching opcode bytes
Date:   Wed, 17 Mar 2021 11:12:40 -0700
Message-Id: <0a7892ea337e40d464ff291b264e40fbcd39f4af.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org>
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
2.30.2

