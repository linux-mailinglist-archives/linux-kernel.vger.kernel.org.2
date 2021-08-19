Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC53F1611
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhHSJV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHSJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:21:55 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:21:19 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Gqzlw6kCXzQk3T;
        Thu, 19 Aug 2021 11:21:16 +0200 (CEST)
Authentication-Results: spamfilter06.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629364875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HFOcrXl78c6yHPjNwqyC9icUkgDQSOnkggANphEmzkg=;
        b=I5cy7rqEZcuViFFxFTRzZIkqocNTL/JMPMq82x188aLq5ebURjQP9L2teZswgoBw7MJhLB
        ZNPByEXU013GjZLk83qN4n4PybBtFrvOyZGvr/q5oCjIRzG5nS7NtBRsEp0/zWcwMm3z3w
        0wxKyGw9sbRtfwzpMxB0Eq5BwapqvL8Ki10sEhMA00Kv6eth3lqTX1G/9ZnywCBbqMHBwf
        l3SSJpiWelmaIszUssyezrienhRpCDK8zsDA+HhZynDwalrfACYjE/eylRAEFMK8tpPriU
        1pHR9kYXx/5IADJBHI8ug5sxa+2hFQqWG+HY8WQRQoamSxNmFJGHn5wLlFBLSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1629364874; bh=0Q9HkaFTyKPqUCkKJjnjcyGSZ9WJz5mQv
        PT3L8XE1SU=; b=cc9timhpQp+tXtt2vdIJ0z9cnFJT+7KsmjlnsJYtRIq7FjwOa
        E6OxzoPN1yQwTtkxwW1Gv3IrUBKK+f6zkmUIYxvbaMu0pgo+3QygiXqGYRBDcVah
        Asf9CZ1NU8n+4S/0LaAlfnSu9ZI++Xju1RyLcEG4GWWqK5YsigG8o5BGjvZd2elY
        R+5vkMICwWtDKyaO7uFihnMVyESRXv+pxGWJElHNxewY29NtFaLfpxKKGoluxAKe
        xbt0jTdK0YLI+W0le/b6O8zPKVpcBRCWGYI77kTrbpW1gM0jL+cJtR4CQkUw/PnG
        s19abs+VXkDVDs6H3BsueAW923oOA/lZ/Gfvw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id SKA1mXJZCwaq; Thu, 19 Aug 2021 11:21:14 +0200 (CEST)
Date:   Thu, 19 Aug 2021 11:21:13 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvic9@mailbox.org" <torvic9@mailbox.org>
Message-ID: <1456566961.33591.1629364873255@office.mailbox.org>
Subject: [PATCH v2] x86/Makefile: Move the CPU-specific 64-bit tuning
 settings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: F03CD18CF
X-Rspamd-UID: b96211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the FIXME comment in arch/x86/Makefile, move the
CPU-specific 64-bit tuning settings to arch/x86/Makefile.cpu.

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
v1->v2:
* drop the second patch in the series
* use srctree with include (Masahiro)

 arch/x86/Makefile     | 11 ++---------
 arch/x86/Makefile.cpu | 12 ++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/Makefile.cpu

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307fd0000a83..0cc5363831b6 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -119,15 +119,8 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
-        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
-        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
-
-        cflags-$(CONFIG_MCORE2) += \
-                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
-	cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
-		$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
-        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
+        # CPU-specific tuning (64-bit).
+        include $(srctree)/arch/x86/Makefile.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
new file mode 100644
index 000000000000..9c3be14b6c88
--- /dev/null
+++ b/arch/x86/Makefile.cpu
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# CPU tuning section (64-bit).
+
+cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
+cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
+
+cflags-$(CONFIG_MCORE2) += \
+	$(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
+cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
+	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
-- 
2.33.0
