Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18A34401D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCVLqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhCVLqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C65561974;
        Mon, 22 Mar 2021 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413569;
        bh=f2OpoXVZq2VLNR6MAxUr6Q1I6s2tmGFmatpyYC67wZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SMaTgT2/UajX+rHFJSLyguksEtzAaOh8dvO5ge1cGMoEhpoaLW5rVviXG3JX/JXie
         g7dH9ELKvfILnLyleI5HE8SuhkuSt7GjuKX1QhBVQhXfDaMpoo9ZbTrMKNFGvDMJmf
         JRU3yQDch+LBxu99YMsLM+xvrLeNte915SNqe0Omf3zuq/+K3aQnQ9u/ViNsZGg5Je
         SAq2b1fD75WkYU9kzSHHyWA4e1APB6iJn/9hOFEy1qQ9mJDkXHw4s/6ou6nx6DWgcq
         ykPjbzouiqahhWYPUzy5NuGXmeOuOAfuSpJp0V7Z0W/6HNuDqmA9DuYW/dKdUlMY57
         G62aQ3mOVGJPQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kprobes: address gcc -Wempty-body warning
Date:   Mon, 22 Mar 2021 12:45:50 +0100
Message-Id: <20210322114600.3528031-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a warning in some configurations
when 'verbose()' is defined to be empty.

arch/arm/probes/kprobes/test-core.c: In function 'kprobes_test_case_start':
arch/arm/probes/kprobes/test-core.c:1367:26: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
 1367 |      current_instruction);
      |                          ^

Change the definition of verbose() to use no_printk(), allowing format
string checking and avoiding the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/probes/kprobes/test-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 19a5b2add41e..6e42c0dd82a5 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -98,7 +98,7 @@ struct test_arg_end {
 #if VERBOSE
 #define verbose(fmt, ...) pr_info(fmt, ##__VA_ARGS__)
 #else
-#define verbose(fmt, ...)
+#define verbose(fmt, ...) no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 #define TEST_GROUP(title)					\
-- 
2.29.2

