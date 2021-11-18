Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F343456094
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhKRQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:37:30 -0500
Received: from smtp1.axis.com ([195.60.68.17]:58831 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhKRQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637253261;
  x=1668789261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fgixBB9fzWHHYd6pk0F6KCPvRNJYPGIKx4FByoZWSnQ=;
  b=C0/FUwY9bYD4vaZDvZiUtmV5k0MwTy2E5OhCh4JhlKjifrIfQuPdVHO8
   6G9ebRFvoATTZkFGnPqMFkAD+jQNclrxqhWBRGf+Pj690TOP3I2DNX9Z1
   JBGzWf5YgKQt3/nl8blkmHZu4btD6ynf3gdvXQKKzp3vRfFo1LJMoKgjN
   5G0tC9k6giW38Yl8jLcnCWBcjPy9f4vh65lRSdrMv6WCosr3kw9OQ+F3L
   5gC3cWlJbB62MGNz9UKqn0xbraeNiAlD+VaLdEnTjOXJ8KgMc97dn2SMP
   W5k6DWhcjX+aUFFFBpcS/OCMDSyFhgO3k4od/a48NbQwEabVndjZrfqCM
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <kernel@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Date:   Thu, 18 Nov 2021 17:34:17 +0100
Message-ID: <20211118163417.21617-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value argument to put_user() must be evaluated before the TTBR0
switch is done.  Otherwise, if it is a function and the function sleeps,
the reserved TTBR0 will be restored when the process is switched in
again and the process will end up in an infinite loop of faults.

This problem was seen with the put_user() in schedule_tail().  A similar
fix was done for RISC-V in commit 285a76bb2cf51b0c74c634 ("riscv:
evaluate put_user() arg before enabling user access").

Fixes: f253d827f33cb5a5990 ("arm64: uaccess: refactor __{get,put}_user")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6e2e0b7031ab..96b26fa9d3d0 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -362,10 +362,11 @@ do {									\
 #define __put_user_error(x, ptr, err)					\
 do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	__typeof__(*(__p)) __val = (x);					\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_put_user((x), __p, (err));			\
+		__raw_put_user(__val, __p, (err));			\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
-- 
2.33.1

