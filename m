Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114EB3EEE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbhHQOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhHQOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:23:51 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C02C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:23:18 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GptYF06MmzQkBq;
        Tue, 17 Aug 2021 16:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1629210190; bh=LMKHFV6EMcxLt3KlplMbGkL9YzX+WZRS3
        dhPIn6AycA=; b=kXK0UK9iDipFs8c6vYxCfteegaIkg+W1bjna9Y2E501NCXTM/
        N3PKHeb8KZl4Wlvw9Eoc0nrj4oIMwyDdoEyxed/f0YHCZj/MUOcd1xgAWldVgOex
        GtwOyMROJf/IBMf/IqcgxPuzHKthn90SRq4IdL25ejIppgznaq8dj+uhbCIPt1EH
        KPIe0U3YVmyOTcDbzkBgheOdj8CO59T1e4Zgr33qIjTX6DNTzW8bFtfUjSO/ziIJ
        81kayPQ2Pnw80OcphC3ivcU0trXFUd6qk8ubgsxwUPq5a7yLZ2KlyP+4wsGbIlRX
        cUXXcG43gl6ubetZezTRA1IepscIUe5L4ir1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629210191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w2ReuPoV//dwBiuFzBjXQTkWqHhZgldVzQtsCYRhJSY=;
        b=wEOHrpA79mcFHVf+b4CQqU2KrApYAhjNLqFv/KFj/X4z1NNMIzCt/vSA4kGPL4Eo1GjW/w
        SdyNLOGsu1VjqrwlkJb791RRht6TLIuzNCNXD+XITH9/VDVBbDJtH9UcpgDYk0ZtqoMgxo
        UFqfcHVJ+YyLNlwws+iekqqKOw82ikdYWlb/ZUOJZQGHt2uQ/bZ55oCZG8xov+1Q9Ehxpy
        95eTtisiQTCXClDBTfgayYXtKq1mS5NdM/5sQp8GAAjXxOCuCG8cDOd5mNxs3s0ji+ODav
        2Liu7CqSUQUd1h2Y5t3Cuex6I6IsyuqapUNG7Kv/RwMrY2a0Z4lTbaTZDXu0rw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id bxxjERrquUke; Tue, 17 Aug 2021 16:23:10 +0200 (CEST)
Date:   Tue, 17 Aug 2021 16:23:09 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Message-ID: <269701460.117528.1629210189833@office.mailbox.org>
Subject: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 2E219189C
X-Rspamd-UID: 318201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the FIXME comment in arch/x86/Makefile, move the
CPU-specific 64-bit tuning settings to arch/x86/Makefile.cpu.

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 arch/x86/Makefile     | 11 ++---------
 arch/x86/Makefile.cpu | 12 ++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/Makefile.cpu

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307fd0000a83..94105d7ad22c 100644
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
+        include arch/x86/Makefile.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
new file mode 100644
index 000000000000..fb407ae94d90
--- /dev/null
+++ b/arch/x86/Makefile.cpu
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# CPU tuning section (64-bit) - shared with UML.
+# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
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
2.32.0
