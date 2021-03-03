Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE232BE97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385894AbhCCRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242278AbhCCNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD1CE64EEA;
        Wed,  3 Mar 2021 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779422;
        bh=7d+Bxyv00D2lLEcDWyCJi5fgzFR8y+Ha366pC3YYcKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olkUNSwbSMc79HqTU7Z42PyxUVbZfJb+BVlid9PQ8fyw8VwAgnv2u5t1u/pRrDAPC
         unPqRC/wMuAv1tQED6/RvC4LPIoV8FzLPs25EOyOsf5uMruwgrGvALCNm9aT2bu4Pr
         qJd0dVx8G+/CHIMuoIxsV9ieQs1o7rNLO5KPkdKAmpr7E4xEtFc1PK+OaitiOwjdob
         l610xTwbQ0hDd8Zgm6DUaSldARrecY4uzWrG15dz7nyaZfhH9ptWVIBr9r6sgweNLU
         9bfgwssg4KTP3wMEZvrcVhj7WGlE6bpCi+xl6tXNYydeq0MCz2awOUjTX77RxnSn2V
         mylAuIXTsRfJQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Max Uvarov <muvarov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: cpufeatures: Fix handling of CONFIG_CMDLINE for idreg overrides
Date:   Wed,  3 Mar 2021 13:49:26 +0000
Message-Id: <20210303134927.18975-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303134927.18975-1-will@kernel.org>
References: <20210303134927.18975-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The built-in kernel commandline (CONFIG_CMDLINE) can be configured in
three different ways:

  1. CMDLINE_FORCE: Use CONFIG_CMDLINE instead of any bootloader args
  2. CMDLINE_EXTEND: Append the bootloader args to CONFIG_CMDLINE
  3. CMDLINE_FROM_BOOTLOADER: Only use CONFIG_CMDLINE if there aren't
     any bootloader args.

The early cmdline parsing to detect idreg overrides gets (2) and (3)
slightly wrong: in the case of (2) the bootloader args are parsed first
and in the case of (3) the CMDLINE is always parsed.

Fix these issues by moving the bootargs parsing out into a helper
function and following the same logic as that used by the EFI stub.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Fixes: 33200303553d ("arm64: cpufeature: Add an early command-line cpufeature override facility")
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/idreg-override.c | 44 +++++++++++++++++-------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index dffb16682330..cc071712c6f9 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -163,33 +163,39 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 	} while (1);
 }
 
-static __init void parse_cmdline(void)
+static __init const u8 *get_bootargs_cmdline(void)
 {
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
-		const u8 *prop;
-		void *fdt;
-		int node;
+	const u8 *prop;
+	void *fdt;
+	int node;
 
-		fdt = get_early_fdt_ptr();
-		if (!fdt)
-			goto out;
+	fdt = get_early_fdt_ptr();
+	if (!fdt)
+		return NULL;
 
-		node = fdt_path_offset(fdt, "/chosen");
-		if (node < 0)
-			goto out;
+	node = fdt_path_offset(fdt, "/chosen");
+	if (node < 0)
+		return NULL;
 
-		prop = fdt_getprop(fdt, node, "bootargs", NULL);
-		if (!prop)
-			goto out;
+	prop = fdt_getprop(fdt, node, "bootargs", NULL);
+	if (!prop)
+		return NULL;
 
-		__parse_cmdline(prop, true);
+	return strlen(prop) ? prop : NULL;
+}
 
-		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
-			return;
+static __init void parse_cmdline(void)
+{
+	const u8 *prop = get_bootargs_cmdline();
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
+	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
+	    !prop) {
+		__parse_cmdline(CONFIG_CMDLINE, true);
 	}
 
-out:
-	__parse_cmdline(CONFIG_CMDLINE, true);
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && prop)
+		__parse_cmdline(prop, true);
 }
 
 /* Keep checkers quiet */
-- 
2.30.1.766.gb4fecdf3b7-goog

