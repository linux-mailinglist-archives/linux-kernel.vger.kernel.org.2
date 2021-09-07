Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44F402F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbhIGUGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:06:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhIGUGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:06:13 -0400
Received: from zn.tnic (p200300ec2f109000f263c75e826faaa3.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9000:f263:c75e:826f:aaa3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61A361EC0354;
        Tue,  7 Sep 2021 22:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631045105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Cw5yArLA1DrKFod+3QOYZpPOxsjuz61ZFWNt4Es863I=;
        b=FdXvAa0hnAp8HOUBGX5u0GJdSQTF39Mg9wCkYzOiksscFIHS4Rm64zUqT0j/EBJckY0x8T
        vcpVBv9NYRV80qhtVs4BgrqnKIXPQFphvur+kRDiE6OQSH/Z9z6f1cJFVmDvDeDgsTdenz
        a8YDJbYH4Vob0yH8SOG46pkGSgsYfQE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Marcus=20R=C3=BCckert?= <mrueckert@suse.com>
Subject: [PATCH] x86/umip: Add a umip= cmdline switch
Date:   Tue,  7 Sep 2021 22:04:54 +0200
Message-Id: <20210907200454.30458-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

And add the first control option

  umip=warnings_off

which disables warnings resulting from emulating UMIP-enabled insns.

The actual use case is for users playing games in wine, games like
Overwatch, for example, which go nuts with SIDT:

  [Di Sep  7 00:24:05 2021] umip_printk: 1345 callbacks suppressed
  [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: SIDT instruction cannot be used by applications.
  [Di Sep  7 00:24:05 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b7c0: For now, expensive software emulation returns the result.
  ...
  [Di Sep  7 00:26:06 2021] umip_printk: 2227 callbacks suppressed
  [Di Sep  7 00:26:06 2021] umip: someapp.exe[29231] ip:14064cdba sp:11b940: SIDT instruction cannot be used by applications.

filling up the kernel log unnecessarily with the same info over and over
again which doesn't mean a whit to the users - they just wanna play.

So add a boot-time control switch for those warning messages.

Reported-by: Marcus Rückert <mrueckert@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/kernel/umip.c                        | 33 +++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 828d11441ebf..815d022c3e87 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5887,6 +5887,11 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
+	umip=warnings_off
+			[X86]
+			* warnings_off - do not issue warnings when emulating
+			  UMIP-enabled instructions.
+
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 576b47e7523d..1d37dc626011 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -90,10 +90,19 @@ static const char * const umip_insns[5] = {
 	[UMIP_INST_STR] = "STR",
 };
 
-#define umip_pr_err(regs, fmt, ...) \
+static struct umip_config {
+	__u64 warnings_off	: 1,
+	      __reserved	: 63;
+} umip_cfg;
+
+#define umip_pr_err(regs, fmt, ...)				\
 	umip_printk(regs, KERN_ERR, fmt, ##__VA_ARGS__)
-#define umip_pr_warn(regs, fmt, ...) \
-	umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__)
+
+#define umip_pr_warn(regs, fmt, ...)					\
+({									\
+	if (!umip_cfg.warnings_off)					\
+		umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__);	\
+})
 
 /**
  * umip_printk() - Print a rate-limited message
@@ -407,5 +416,23 @@ bool fixup_umip_exception(struct pt_regs *regs)
 
 	/* increase IP to let the program keep going */
 	regs->ip += insn.length;
+
 	return true;
 }
+
+static int __init parse_umip_param(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (*str == '=')
+		str++;
+
+	if (!strcmp(str, "warnings_off"))
+		umip_cfg.warnings_off = 1;
+	else
+		return 0;
+
+	return 1;
+}
+__setup("umip", parse_umip_param);
-- 
2.29.2

