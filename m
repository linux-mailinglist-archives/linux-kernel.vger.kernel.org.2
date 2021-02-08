Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9A312EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBHKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhBHKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:05:01 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A34C864E8C;
        Mon,  8 Feb 2021 10:04:20 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l93Iz-00Ck14-1b; Mon, 08 Feb 2021 09:58:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Hector Martin <marcan@marcan.st>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v7 16/23] arm64: Add an aliasing facility for the idreg override
Date:   Mon,  8 Feb 2021 09:57:25 +0000
Message-Id: <20210208095732.3267263-17-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208095732.3267263-1-maz@kernel.org>
References: <20210208095732.3267263-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, marcan@marcan.st, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to map the override of idregs to options that a user
can easily understand, let's introduce yet another option
array, which maps an option to the corresponding idreg options.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2da11bf60195..226bac544e20 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -16,6 +16,8 @@
 
 #define FTR_DESC_NAME_LEN	20
 #define FTR_DESC_FIELD_LEN	10
+#define FTR_ALIAS_NAME_LEN	30
+#define FTR_ALIAS_OPTION_LEN	80
 
 struct ftr_set_desc {
 	char 				name[FTR_DESC_NAME_LEN];
@@ -39,6 +41,12 @@ static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
 };
 
+static const struct {
+	char	alias[FTR_ALIAS_NAME_LEN];
+	char	feature[FTR_ALIAS_OPTION_LEN];
+} aliases[] __initconst = {
+};
+
 static int __init find_field(const char *cmdline,
 			     const struct ftr_set_desc *reg, int f, u64 *v)
 {
@@ -81,7 +89,7 @@ static void __init match_options(const char *cmdline)
 	}
 }
 
-static __init void __parse_cmdline(const char *cmdline)
+static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 {
 	do {
 		char buf[256];
@@ -105,6 +113,9 @@ static __init void __parse_cmdline(const char *cmdline)
 
 		match_options(buf);
 
+		for (i = 0; parse_aliases && i < ARRAY_SIZE(aliases); i++)
+			if (parameq(buf, aliases[i].alias))
+				__parse_cmdline(aliases[i].feature, false);
 	} while (1);
 }
 
@@ -127,14 +138,14 @@ static __init void parse_cmdline(void)
 		if (!prop)
 			goto out;
 
-		__parse_cmdline(prop);
+		__parse_cmdline(prop, true);
 
 		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
 			return;
 	}
 
 out:
-	__parse_cmdline(CONFIG_CMDLINE);
+	__parse_cmdline(CONFIG_CMDLINE, true);
 }
 
 /* Keep checkers quiet */
-- 
2.29.2

