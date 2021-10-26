Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A683943BC68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhJZVbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbhJZVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:31:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F400C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:29:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso516000pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=/rggbZqE5Rg53L9CWqTqFtP/omYvr2W+TYTAvnb1AJ8=;
        b=YYG5EFToI18HDvmKWoho9CXqxrIukv1G1OFNYY7ppapxl2/8Qo6w76wNNlYQDtC+PH
         TZOAyFHdjelYBkK6ckpXQQWWCZz+dDOnjlTyW/a/7Cgn5ZeD4Wo9EnQ4wYbrTM+TwZGt
         VdchOWOBKXov5bGwJoJYJj1RdL2T6CTIL4+qcO/Zugr18t/cSkHeutn/SgbFOov4y/ke
         kyrSvrGNgK9tdLyVrSPBvVaQKliTli0ymqtDxN6yRXPQIdeU92fndygK/utjZ/S6Mowi
         6RMVeobFGLbDeGUzBo4oeEaEdxULO5U3Y7J1wNDAphiHC/x8scm8cR5FW4oiI2Y2maHf
         zdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/rggbZqE5Rg53L9CWqTqFtP/omYvr2W+TYTAvnb1AJ8=;
        b=5QRyNA2xCSRcTYRu5SteS1NSa6KCFQBLZVjR8WpL6YRjx9oL+L7cTRmJHVqUw+FLgC
         8kdNpIQJ7EVwLMPnqk6GPHJKNQ/ItiIqKKalSUfcsPkqb4MgPLS7G3JMfh3keQjP9Gf6
         YJsVTsexv3gZmPVpwrBx6BWBtrfZyKqPKM0a+xkZjFBI5LHQrOFboG+3DrAwYMIIzq+7
         qQwcqtyHZalx3zym2ryste4sCRyHmHczwKXyU/k9q/UqstpswSt2zN6gR12/fazyRIcS
         vcHf0UwtSX2b94kg1S/9gh3gkmG/rKTdguaXDm3x5Vof9HPsLhIVHHvZ3bKeteZ0Iky9
         kqTw==
X-Gm-Message-State: AOAM5309aicDMEPCXZQ+smvpKz02Osxm6ghIjY4dnTVIGdzPRsOZGEZa
        2KVhAxpOOh+t3w/wA2+YhwcuUQ==
X-Google-Smtp-Source: ABdhPJyqrIYUJF2En9mUPq6NoFdbkk/mublkErVsHXvtRUfBsqo2RFhZff/2wn1BzxkEVGWFKkx+mA==
X-Received: by 2002:a17:902:8b81:b0:13f:3d30:f624 with SMTP id ay1-20020a1709028b8100b0013f3d30f624mr24709007plb.51.1635283758910;
        Tue, 26 Oct 2021 14:29:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id mp14sm1706539pjb.17.2021.10.26.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:29:18 -0700 (PDT)
Subject: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
Date:   Tue, 26 Oct 2021 14:28:47 -0700
Message-Id: <20211026212847.43108-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This should really be up to the user, as it trades off portability for
performance.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5dea03549493..f8a36034d54b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -212,18 +212,6 @@ config PGTABLE_LEVELS
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config RELOCATABLE
-	bool
-	depends on MMU && 64BIT && !XIP_KERNEL
-	help
-          This builds a kernel as a Position Independent Executable (PIE),
-          which retains all relocation metadata required to relocate the
-          kernel binary at runtime to a different virtual address than the
-          address it was linked at.
-          Since RISCV uses the RELA relocation format, this requires a
-          relocation pass at runtime even if the kernel is loaded at the
-          same address it was linked at.
-
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.erratas"
 
@@ -433,6 +421,18 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config RELOCATABLE
+	bool "Build a relocatable kernel"
+	depends on MMU && 64BIT && !XIP_KERNEL
+	help
+          This builds a kernel as a Position Independent Executable (PIE),
+          which retains all relocation metadata required to relocate the
+          kernel binary at runtime to a different virtual address than the
+          address it was linked at.
+          Since RISCV uses the RELA relocation format, this requires a
+          relocation pass at runtime even if the kernel is loaded at the
+          same address it was linked at.
+
 endmenu
 
 menu "Boot options"
-- 
2.33.0.1079.g6e70778dc9-goog

