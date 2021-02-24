Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD53240AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhBXPT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhBXOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:32:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E5AC0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id n1so2788788edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fe5/olgfveUojycGixqF6BS2+ojcBTB3YCOAzL6RO7Q=;
        b=Jw7+yHHwZXDEOT/Z8WdeeO0m9MBaekSxUfGnRvfXGPRDXzXNvqccJ2ZPDlk6XTrEAs
         AyBYvV5u9WmMQnuOjFEBMSzmyn7pwq0UVS8bIY1MRGlDlnj4ddwLiq0FOcAJkURoufQh
         NiSUqIRLb5hfvqhuMVQOBVkzAKa7d/cYM7c50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fe5/olgfveUojycGixqF6BS2+ojcBTB3YCOAzL6RO7Q=;
        b=AlVTOi+0TICpGElZcQ+YgbnWIAaqp7BX/itvrJ044n/u6MXCggFXTcV9QMHRuPkdiV
         F1FZOM48n7FFBEv51x3KgJxCIGENGRbd81bp7ew7L8faCAcuuANtwmLpSQG0YR6vsMsV
         tx+pV9P3c+b/Ec06frxJK3v1PMzVWveGVn5T84dGGtWHi88I3Hl5pkAfvDU7WNS/GJJH
         7BBvfUGyBywh9X9dVsobDG0Nb4qf+qEGnGW4xWLodFh4DSZFpbVU8Unleb5zyaVkU+SL
         v0a7WPnKEsaMHT0N5DdYx5cpmR+ho5paziArKn7d5qIR6zNC5jPYW0LWrjbyKVqltHGv
         2B8Q==
X-Gm-Message-State: AOAM530ac5BpPMfYGv16RealeHfGos1MLUCLI6h6fXcAGHRgeKovF741
        GG9o2Hz3vHyb3TtWE6mMSTe92/UG8tnnQA==
X-Google-Smtp-Source: ABdhPJypy0SKjnQgBwkVrlOlDrnYTdrK5GRRpGBD/91eIBS2VhxcB1efmoMTDHGBz4l1QW+Yo9tzpw==
X-Received: by 2002:a05:6402:13ce:: with SMTP id a14mr1435555edx.365.1614176980283;
        Wed, 24 Feb 2021 06:29:40 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id f1sm1493651ejt.21.2021.02.24.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:29:40 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH/RFC 2/2] modules: add CONFIG_MODPROBE_PATH
Date:   Wed, 24 Feb 2021 15:29:09 +0100
Message-Id: <20210224142909.2092914-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the developer to specifiy the initial value of the
modprobe_path[] string. This can be used to set it to the empty string
initially, thus effectively disabling request_module() during early
boot until userspace writes a new value via the
/proc/sys/kernel/modprobe interface. [1]

When building a custom kernel (often for an embedded target), it's
normal to build everything into the kernel that is needed for booting,
and indeed the initramfs often contains no modules at all, so every
such request_module() done before userspace init has mounted the real
rootfs is a waste of time.

This is particularly useful when combined with the previous patch,
which allowed the initramfs to be unpacked asynchronously - for that
to work, it had to make any usermodehelper call wait for the unpacking
to finish before attempting to invoke the userspace helper. By
eliminating all such (known-to-be-futile) calls of usermodehelper, the
initramfs unpacking and the {device,late}_initcalls can proceed in
parallel for much longer.

[1] __request_module() already has an early -ENOENT return when
modprobe_path is the empty string.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/Kconfig  | 12 ++++++++++++
 kernel/kmod.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index ba8bd5256980..e3f61e15445d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2272,6 +2272,18 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 
 	  If unsure, say N.
 
+config MODPROBE_PATH
+	string "Path to modprobe binary"
+	default "/sbin/modprobe"
+	help
+	  When kernel code requests a module, it does so by calling
+	  the "modprobe" userspace utility. This option allows you to
+	  set the path where that binary is found. This can be changed
+	  at runtime via the sysctl file
+	  /proc/sys/kernel/modprobe. Setting this to the empty string
+	  removes the kernel's ability to request modules (but
+	  userspace can still load modules explicitly).
+
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
 	depends on BROKEN
diff --git a/kernel/kmod.c b/kernel/kmod.c
index 3cd075ce2a1e..b717134ebe17 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -58,7 +58,7 @@ static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
 /*
 	modprobe_path is set via /proc/sys.
 */
-char modprobe_path[KMOD_PATH_LEN] = "/sbin/modprobe";
+char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
 
 static void free_modprobe_argv(struct subprocess_info *info)
 {
-- 
2.29.2

