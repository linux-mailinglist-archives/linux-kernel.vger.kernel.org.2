Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46BB389397
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355208AbhESQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241786AbhESQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621441440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EeHDvehrcAfnCdGLmf+MzWzadCUiTeclwhruqOxSY5g=;
        b=LK3bSlp8P/p+/ehbuvQH5eH28vrIGXfPXgGZlFETojPwHrw6c9+ICta4f3hwqg8jOJqZLh
        gMM+zRNkx4W3XAyYbOi/Zm/4famn2FbBaASj6vjxO6aziuvrYVjrG5NAna+gPUyuWeacqc
        wLA12a4KE9XfXHMJ4qioFpMGyNR8Qto=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-QJ_tusFSOmG0hJA4gUctjQ-1; Wed, 19 May 2021 12:23:58 -0400
X-MC-Unique: QJ_tusFSOmG0hJA4gUctjQ-1
Received: by mail-io1-f69.google.com with SMTP id i13-20020a5e9e0d0000b029042f7925649eso9698017ioq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeHDvehrcAfnCdGLmf+MzWzadCUiTeclwhruqOxSY5g=;
        b=pCbWWqhgkK7MhG95C2+izXMeW7ye1PPELM5fQT0N+Lx8VaZpdOn5OmlpK92DMgJLM5
         4qVSjUESw15CsQ6Cwbuqf39twGuArzu0SG/0JYtXve2o6VQnzgzfbBFazkyxBR0cP66m
         WVH0bYGRBPvwyYB21g4k7QjTlN2C9r3zc8CQdJmeN1/ZNdZa3tosnn6AAAyeq1h3svCr
         cCgytm4ReuAQBrtu4h9oTKzRzYvYAR9eu3e6g5aQ9NboaB33M0f5H7uFF0SrtbC/5/2S
         xF+81aadlJcElBgJI6Nx2kMm7IqTtkwwcQsbQjRP4O6GQM/+rKZn/DLwUbL3+5zX3esh
         vaTw==
X-Gm-Message-State: AOAM533lzpa4n1+o6snCa+V5++xqfPRk9R4E4NJu2Zc5vIgwcfgMOgTk
        L+2r5+mEyVag34a86ujJttDUD9ptnKbpFLkvXHh+i7uxrSt/X7i3PmfvPEGVLXnujIWF0OCXESB
        /0+ZZv5zERlXIIN4snlH6VQPM
X-Received: by 2002:a02:ca4b:: with SMTP id i11mr3705683jal.77.1621441437039;
        Wed, 19 May 2021 09:23:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4fXyp819wDC8aw4NaVd2SSs4uJqkEOZbWavkt4027H+IWg2LXC/+l7i69msPj2CHZvqyLxw==
X-Received: by 2002:a02:ca4b:: with SMTP id i11mr3705667jal.77.1621441436892;
        Wed, 19 May 2021 09:23:56 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id q13sm31091ilm.82.2021.05.19.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:23:56 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] init/main.c: silence some -Wunused-parameter warnings
Date:   Wed, 19 May 2021 11:23:41 -0500
Message-Id: <20210519162341.1275452-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bunch of callbacks with unused arguments, go ahead and silence
those so "make KCFLAGS=-W init/main.o" is a little quieter.
Here's a little sample:

init/main.c:182:43: warning: unused parameter 'str' [-Wunused-parameter]
static int __init set_reset_devices(char *str)

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 init/main.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..4c26f0ea5073 100644
--- a/init/main.c
+++ b/init/main.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(static_key_initialized);
 unsigned int reset_devices;
 EXPORT_SYMBOL(reset_devices);
 
-static int __init set_reset_devices(char *str)
+static int __init set_reset_devices(char *str __always_unused)
 {
 	reset_devices = 1;
 	return 1;
@@ -229,13 +229,13 @@ static bool __init obsolete_checksetup(char *line)
 unsigned long loops_per_jiffy = (1<<12);
 EXPORT_SYMBOL(loops_per_jiffy);
 
-static int __init debug_kernel(char *str)
+static int __init debug_kernel(char *str __always_unused)
 {
 	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 	return 0;
 }
 
-static int __init quiet_kernel(char *str)
+static int __init quiet_kernel(char *str __always_unused)
 {
 	console_loglevel = CONSOLE_LOGLEVEL_QUIET;
 	return 0;
@@ -478,7 +478,7 @@ static void __init setup_boot_config(void)
 	get_boot_config_from_initrd(NULL, NULL);
 }
 
-static int __init warn_bootconfig(char *str)
+static int __init warn_bootconfig(char *str __always_unused)
 {
 	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
 	return 0;
@@ -504,7 +504,8 @@ static void __init repair_env_string(char *param, char *val)
 
 /* Anything after -- gets handed straight to init. */
 static int __init set_init_arg(char *param, char *val,
-			       const char *unused, void *arg)
+			       const char *unused __always_unused,
+			       void *arg __always_unused)
 {
 	unsigned int i;
 
@@ -529,7 +530,8 @@ static int __init set_init_arg(char *param, char *val,
  * unused parameters (modprobe will find them in /proc/cmdline).
  */
 static int __init unknown_bootoption(char *param, char *val,
-				     const char *unused, void *arg)
+				     const char *unused __always_unused,
+				     void *arg __always_unused)
 {
 	size_t len = strlen(param);
 
@@ -723,7 +725,8 @@ noinline void __ref rest_init(void)
 
 /* Check for early params. */
 static int __init do_early_param(char *param, char *val,
-				 const char *unused, void *arg)
+				 const char *unused __always_unused,
+				 void *arg __always_unused)
 {
 	const struct obs_kernel_param *p;
 
@@ -1301,8 +1304,10 @@ static const char *initcall_level_names[] __initdata = {
 	"late",
 };
 
-static int __init ignore_unknown_bootoption(char *param, char *val,
-			       const char *unused, void *arg)
+static int __init ignore_unknown_bootoption(char *param __always_unused,
+					    char *val __always_unused,
+					    const char *unused __always_unused,
+					    void *arg __always_unused)
 {
 	return 0;
 }
@@ -1440,7 +1445,7 @@ void __weak free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-static int __ref kernel_init(void *unused)
+static int __ref kernel_init(void *unused __always_unused)
 {
 	int ret;
 
-- 
2.31.1

