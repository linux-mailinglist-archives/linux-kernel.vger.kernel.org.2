Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5288F430901
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbhJQMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234724AbhJQMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:44:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D95560EE3;
        Sun, 17 Oct 2021 12:42:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mc5V1-00HKfO-QX; Sun, 17 Oct 2021 13:42:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 01/17] clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses
Date:   Sun, 17 Oct 2021 13:42:09 +0100
Message-Id: <20211017124225.3018098-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017124225.3018098-1-maz@kernel.org>
References: <20211017124225.3018098-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, pshier@google.com, rananta@google.com, ricarkol@google.com, oupton@google.com, catalin.marinas@arm.com, linus.walleij@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to change the registers that are used by the driver,
start by adding build-time checks to ensure that we always handle
all registers and access modes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_timer.h    | 12 ++++++++++++
 arch/arm64/include/asm/arch_timer.h  | 13 ++++++++++++-
 drivers/clocksource/arm_arch_timer.c |  8 ++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 99175812d903..a5d27cff28fa 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -34,6 +34,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -43,7 +45,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	isb();
@@ -62,6 +68,8 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -71,7 +79,11 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	return val;
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 88d20f04c64a..fa12ea4a9812 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -112,6 +112,8 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			write_sysreg(val, cntp_tval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -121,7 +123,11 @@ void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
 		case ARCH_TIMER_REG_TVAL:
 			write_sysreg(val, cntv_tval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
 
 	isb();
@@ -136,6 +142,8 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 			return read_sysreg(cntp_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
 			return arch_timer_reg_read_stable(cntp_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
@@ -143,10 +151,13 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 			return read_sysreg(cntv_ctl_el0);
 		case ARCH_TIMER_REG_TVAL:
 			return arch_timer_reg_read_stable(cntv_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	}
 
-	BUG();
+	BUILD_BUG();
+	unreachable();
 }
 
 static inline u32 arch_timer_get_cntfrq(void)
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index be6d741d404c..3b7d46d9db73 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -112,6 +112,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed(val, timer->base + CNTP_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
@@ -122,6 +124,8 @@ void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 		case ARCH_TIMER_REG_TVAL:
 			writel_relaxed(val, timer->base + CNTV_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		arch_timer_reg_write_cp15(access, reg, val);
@@ -143,6 +147,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_TVAL:
 			val = readl_relaxed(timer->base + CNTP_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer = to_arch_timer(clk);
@@ -153,6 +159,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 		case ARCH_TIMER_REG_TVAL:
 			val = readl_relaxed(timer->base + CNTV_TVAL);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		val = arch_timer_reg_read_cp15(access, reg);
-- 
2.30.2

