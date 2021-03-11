Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109C0336E42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhCKIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhCKIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:52:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC93C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:52:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so8727781pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUt2TWqdGp7t2ye7WIV2P3sdJDz7NTpwsILTlpmv/jA=;
        b=Qdu2wv/3CD4QM0BcTBIl0QiRcNzz9Z1HfUTEpNYl6V52t36FbanLuD6q+LDSEUty6A
         G/V19iODiR5t8O28STx4z0w/7GZvVhrp9WezYW0xqcy0JZlIFsyK+V9x1uYmDeo/4RhH
         080ENDEXwudb/M81MY19Lq+gTlY+Nnm4eh+4DygCdyqqRRs4u35oiaEynA3ePkdLVltZ
         SUH+teHqQ6apEcHLjysgAEp4OHxSjlJdq04ZXEZm7YpS6MGPSCcak29DLkMBvDQ1HWh6
         b2G+qqRs2sd3BBbVZYD7Z1rKl+nu93gGJgfw+K7FlWbWYnOFtUGrP8O8afLzm6MniMyy
         SMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUt2TWqdGp7t2ye7WIV2P3sdJDz7NTpwsILTlpmv/jA=;
        b=dcf5m9ePxFE7NnVCROb+oDclEYWaNUo/wVr0L71Ez1nyVyHKL5qIDpd4GJGz+/+rj4
         KYWUcQLDfZ4917EwMNTChsqB62YZEnEZ2TKkhtkV4zHMpathy3AyGr4eHyiZBTLnLjFO
         oB/Ni71Ne5JaxTcVQEjcWqnKVqpEX3dXFO8e6aet6ANGYgOwHTRktCPgxwLlzYQj7rdt
         PcndFI55C1eP4+OYgYwBaSkHx7FfrMXhFxoZ9zjIi0OiaWYJ7nGkYl6+d3a7E5QHJN5l
         tymKdFgS3dQXLUnVTg2p+Xxrsr2ge+St+rzSG1hT5q1SiFmbBBb+5Zo8MdGb/xsrtnnW
         V/Eg==
X-Gm-Message-State: AOAM531WthaFzojmDmmPNJAOabYq0m3xoPmxBc9Z/Peskc0YrZ30kdb8
        2ZaG2bwtPqLNsC633/n3AL65skf+2bqW3JqB
X-Google-Smtp-Source: ABdhPJxM75d4YuJipHQA2R5EOAd1uRdk3xsyrY2tj2sgT1Y5cTdiyiD+G20hiPpH8NiW8sCK2ptRIA==
X-Received: by 2002:a17:902:dacd:b029:e5:cf71:3901 with SMTP id q13-20020a170902dacdb02900e5cf713901mr6759976plx.23.1615452736369;
        Thu, 11 Mar 2021 00:52:16 -0800 (PST)
Received: from localhost ([98.126.155.250])
        by smtp.gmail.com with ESMTPSA id b140sm1830457pfb.98.2021.03.11.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 00:52:16 -0800 (PST)
From:   Cao jin <jojing64@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        rostedt@goodmis.org, keescook@chromium.org, vbabka@suse.cz,
        Cao jin <jojing64@gmail.com>
Subject: [PATCH] bootconfig: Update prototype of setup_boot_config()
Date:   Thu, 11 Mar 2021 16:52:13 +0800
Message-Id: <20210311085213.27680-1-jojing64@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter "cmdline" has no use, drop it.

Signed-off-by: Cao jin <jojing64@gmail.com>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index c68d784376ca..621a11ed18fb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -404,7 +404,7 @@ static int __init bootconfig_params(char *param, char *val,
 	return 0;
 }
 
-static void __init setup_boot_config(const char *cmdline)
+static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg;
@@ -471,7 +471,7 @@ static void __init setup_boot_config(const char *cmdline)
 
 #else
 
-static void __init setup_boot_config(const char *cmdline)
+static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
 	get_boot_config_from_initrd(NULL, NULL);
@@ -869,7 +869,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
-	setup_boot_config(command_line);
+	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-- 
2.29.2

