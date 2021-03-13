Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2995433A165
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhCMV0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhCMVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:25:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40EFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z1so12874230edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+K/1uSnUGVSiFRaoQdC2GPSMmeIYTJlFU+BR6lSivvQ=;
        b=Pxngu4sHGiKOtCL8vvhDF5FgGHwHj5CtWzkHELfrBjf4sfULU37bjskfvdcZ96lqym
         5zrH4J6KjACJL6KHWC9ZEWfpBnSlyizvYshVgR8pTP2wNIJ/UQwCw6s0K3VHdaWK45Wv
         uGhMNmFkSYJAef1RJIIJv6d2udHxNg0157w+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+K/1uSnUGVSiFRaoQdC2GPSMmeIYTJlFU+BR6lSivvQ=;
        b=a1aMPGFXFfU9npMmdquExrtgRfp5M4il3KzaZjVoGrM79eHvjRzX0rEE8AeiYBf+cY
         NRpmugXE4iza4kC/QWI25GtqU5PegzbVpR/Dwjifd8OB9Ndu7kJeUwidpfY01Zqj7n+P
         fe+VNpAZk6a0LvKABHDhuFFboBcH01mc7L46oJnzvalJut6HOe2n1mm454QudQ7nCWS+
         KdwootbShiu7ItzMbhNxFEgnpd5IgE93fo0kW9PRgiYZqOG6ddnsSkzpZAmts4lgsZDI
         tsHTkxjsIP+EPGY8ATEYbTFpMFJMH+ySnHJEqQ57hxELEVXC/w5TgFrG4NOdafL+FMhb
         duHQ==
X-Gm-Message-State: AOAM531SqVEza99mzkohvSe5q6jPHusACjx1c+iogQpCogtmMfSkIqtz
        wnpQWY7QmlJ+caMpv1piCNKQsg==
X-Google-Smtp-Source: ABdhPJw9rMw7K2vOccJzeQyNb1dIIvdu9sv5d1tykjjJT6lLNOZLQVTJJcGGSrk0hBmrz76BMcIY6Q==
X-Received: by 2002:a50:bb47:: with SMTP id y65mr22313004ede.305.1615670734713;
        Sat, 13 Mar 2021 13:25:34 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gr16sm4827997ejb.44.2021.03.13.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:25:34 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 2/2] modules: add CONFIG_MODPROBE_PATH
Date:   Sat, 13 Mar 2021 22:25:28 +0100
Message-Id: <20210313212528.2956377-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
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
which made the initramfs unpacking asynchronous - for that to work, it
had to make any usermodehelper call wait for the unpacking to finish
before attempting to invoke the userspace helper. By eliminating all
such (known-to-be-futile) calls of usermodehelper, the initramfs
unpacking and the {device,late}_initcalls can proceed in parallel for
much longer.

For a relatively slow ppc board I'm working on, the two patches
combined lead to 0.2s faster boot - but more importantly, the fact
that the initramfs unpacking proceeds completely in the background
while devices get probed means I get to handle the gpio watchdog in
time without getting reset.

[1] __request_module() already has an early -ENOENT return when
modprobe_path is the empty string.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/Kconfig  | 12 ++++++++++++
 kernel/kmod.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 22946fe5ded9..18b4ec7346d4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2264,6 +2264,18 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 
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
 	bool "Trim unused exported kernel symbols" if EXPERT
 	depends on !COMPILE_TEST
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

