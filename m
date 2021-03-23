Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3B345F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCWNVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhCWNUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3407D619BD;
        Tue, 23 Mar 2021 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616505634;
        bh=nPwiWO5rWIEWx3azZjgsrJ8G5mHv0HQF/NHZR+FmaMs=;
        h=From:To:Cc:Subject:Date:From;
        b=U1gkt9hdcmVySja+r/DRV8vG2QEd2/YLya3UDgQSUcEU8+clxHUftMfgo0B/g05L4
         t6DwK4bykTWThKrW9Z/LupBgn6nVgNcZcqzYkucPYJN6NNMCPHHobqt3Mc/t4p4bxe
         n9hsWvg1POWu5jNa6a8/h1c4KudZmyJ8wTOQG/ofFuo/UmR5Gihz9XLht4eG1tYMa4
         Gj/js8835MQcKnGp0RrdAHDzTc5XUVgqxzPK9OioHiAdIRDSWtZ2tMDVycV0sKjQ7D
         VAyZEApXKbVv4QjFblwrQcKdafB0Q8yKnzW+qahjc156DGPe//BJ/dYcDcvcrtSWtb
         yTObbUhzp9oXA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: delay: avoid clang -Wtautological-constant warning
Date:   Tue, 23 Mar 2021 14:20:23 +0100
Message-Id: <20210323132031.2858996-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Passing an 8-bit constant into delay() triggers a warning when building
with 'make W=1' using clang:

drivers/clk/actions/owl-pll.c:182:2: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        udelay(pll_hw->delay);
        ^~~~~~~~~~~~~~~~~~~~~
arch/arm/include/asm/delay.h:84:9: note: expanded from macro 'udelay'
          ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :              \
           ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
arch/arm/mach-omap2/wd_timer.c:89:3: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                udelay(oh->class->sysc->srst_udelay);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shut up the warning by adding a cast to a 64-bit number. A cast to 'int'
would usually be sufficient, but would fail to cause a link-time error
for large 64-bit constants.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/delay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 4f80b72372b4..1bb6417a3a83 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -81,7 +81,7 @@ extern void __bad_udelay(void);
 
 #define udelay(n)							\
 	(__builtin_constant_p(n) ?					\
-	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
+	  ((u64)(n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
 			__const_udelay((n) * UDELAY_MULT)) :		\
 	  __udelay(n))
 
-- 
2.29.2

