Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142F3330C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhCIVRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhCIVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:17:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2DCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:17:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so23332252edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y61pDo4hxQCRtjhhncwd6DU4iUCpxDzGkHzlhmXzJfw=;
        b=MMG0vwLFflwpmehD8vTdNOoM6BC7PGxqAs13RbORxBYXQmZFqJFwBPDNWeKnighS4P
         0gYS+GuRansYWWATqgfBrp6ff4qmMZw6GTTz/TQTTsU+xcyAYsC9d9URF8K3smSu+8bM
         8Qiyz3jzn/cAToOgj8Ok9rED0oaKzCco+Vl90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y61pDo4hxQCRtjhhncwd6DU4iUCpxDzGkHzlhmXzJfw=;
        b=Da8NPSrwssQS+6VJ2Wik3Y0VIkAZOONPrFLC6wBAaaLBpizjG5ABj1L3V2Bu0lQHXL
         wJdzAvGUqUB8qzKmUGIRt3qAEIVGBbugtYoQ83BWnuGVe+IBCpAQweDpbJ7gBxHUsk6f
         PZ1Y02tC/rXmZtE7/IcDjBzM85kTnBoITO0ASSpKbGtcBPvpUTRMOQjRbNJ7hwgpaSXc
         JkcqEENK69+op+0SGU2qSpnJRBy5fi7o88/zUdHxyf984vkhu1BGHF/GbYawfO85pcZf
         PRMEjtbna3AAXxrcTqwXhnC1yG64AfwfUbgKrl7ujkHMHXKuYG3fGW0K7Da0/tGQnJWQ
         6Ofg==
X-Gm-Message-State: AOAM5326Tsl3InEQOBAe6eIM17hetIr74luEITE+Rl1IfKKmCOam6hkw
        NcLlumIVxz96CsfGSoy7sFx7Ng==
X-Google-Smtp-Source: ABdhPJzLrz10VL55KfnIQxScPivjUiBOJKwdNIpzZdmTfOvJzGAz75RRa6t/3kn+ohwSQvWWQ07gTA==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr5855026edu.124.1615324626155;
        Tue, 09 Mar 2021 13:17:06 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id n26sm5205725eds.22.2021.03.09.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:17:05 -0800 (PST)
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
Subject: [PATCH v2 2/2] modules: add CONFIG_MODPROBE_PATH
Date:   Tue,  9 Mar 2021 22:17:00 +0100
Message-Id: <20210309211700.2011017-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
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

For a relatively slow ppc board I'm working on, the two patches
combined lead to 0.2s faster boot - but more importantly, the fact
that the initramfs unpacking proceeds completely in the background
while devices get probed means I get to handle the gpio watchdog in
time without getting reset.

[1] __request_module() already has an early -ENOENT return when
modprobe_path is the empty string.

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

