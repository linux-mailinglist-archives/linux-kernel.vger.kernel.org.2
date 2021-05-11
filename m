Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67537B091
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEKVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhEKVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620767466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+K3jFlFWTr2zex2iB2tfI8ow+Rha1HU7+6e+CF7Cupw=;
        b=DlpzL79mFUfgzrsnvrZ4icbDRVz/5lemcI6AVuxOMLU1OlSpqm+oPKwZ+22Y95rAxTM1zm
        vAi/QuHpBjZjsxNfF5JMs5HJhagR1JJYf/21o3lgymg3AhYGzjaFEOVQADyR/tPGZZdAj/
        EQffgInuHeqSH7aq11MHsd1C9GO3KsA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-ACQkZgm8N7Sa6939JSfuZg-1; Tue, 11 May 2021 17:11:04 -0400
X-MC-Unique: ACQkZgm8N7Sa6939JSfuZg-1
Received: by mail-il1-f199.google.com with SMTP id h8-20020a92c2680000b02901646ecac1e5so17752409ild.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+K3jFlFWTr2zex2iB2tfI8ow+Rha1HU7+6e+CF7Cupw=;
        b=H7vv/XT+FU25AHWWQX6ifbSQ8vuVMf8sYhNYuawx4kTR0e6gCmIQxl456BftEiY5um
         uLxIl/Dyw/DvpzRufg1HI6pXyv0w8UVICv+N9mLm6IW30G3ddokbp73wAgqAp4Y69c0b
         g/RNMCEdRdZpJqNEpwEUhTEuuys+VMKBqniijEUe/yYrDggwxaLPScbIWgZ/ZpZ49vvt
         LfwSOCVDeOvXreTGeTqRhIr0c7S/KQeG9hYB0vSgeSA0cQLaTs6xhRuC4rP8lyZChSJt
         NdCL6eSHZ/25n5wv+zo4zex3QOz4rBGUQewkH4Mx1zYmhN392VzSUirOAUIGcb4Dr/ay
         IqMg==
X-Gm-Message-State: AOAM532TKc2H9NC3vh6kupGgu/xnvud7+lk5+qOv3Ls+4GgFBA7v+QKg
        hFgIW/ZZqLTYfTl5D4bSaEUHgM5p1o1q8a4wPgvDikiBIX6mFy0cIAP3ibOdtbpwJWI23rRC/QN
        yiShn5rPYSJ5b4UWB6Xtwmdd1
X-Received: by 2002:a5d:88cf:: with SMTP id i15mr23802064iol.45.1620767463722;
        Tue, 11 May 2021 14:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhsnBLVhmxvZEiRjZQLNi0xC8XKJaIQPGHGpRvKvjgMOWroevRllIYsPwO64fMWUNVuIr4qQ==
X-Received: by 2002:a5d:88cf:: with SMTP id i15mr23802051iol.45.1620767463555;
        Tue, 11 May 2021 14:11:03 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id i13sm9906571ilu.59.2021.05.11.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:11:02 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2] init: Print out unknown kernel parameters
Date:   Tue, 11 May 2021 16:10:09 -0500
Message-Id: <20210511211009.42259-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easy to foobar setting a kernel parameter on the command line
without realizing it, there's not much output that you can use to
assess what the kernel did with that parameter by default.

Make it a little more explicit which parameters on the command line
_looked_ like a valid parameter for the kernel, but did not match
anything and ultimately got tossed to init. This is very similar to the
unknown parameter message received when loading a module.

This assumes the parameters are processed in a normal fashion, some
parameters (dyndbg= for example) don't register their
parameter with the rest of the kernel's parameters, and therefore
always show up in this list (and are also given to init - like the
rest of this list).

Another example is BOOT_IMAGE= is highlighted as an offender, which it
technically is, but is passed by LILO and GRUB so most systems will see
that complaint.

An example output where "foobared" and "unrecognized" are intentionally
invalid parameters:

  Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12-dirty debug log_buf_len=4M foobared unrecognized=foo
  Unknown command line parameters: foobared BOOT_IMAGE=/boot/vmlinuz-5.12-dirty unrecognized=foo

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

It's my first time sending a v2 via email, please let me know if I've
messed that up in anyway. I decided it wasn't worth the effort to do
"autocorrect" functionality Borislav was pondering about, feel free to
disagree on that if you have a strong opinion.

v2: make output on a single line, make function static and __init,
    include example output in commit message

 init/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/init/main.c b/init/main.c
index dd11bfd10ead..ac7b364ae8eb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -872,6 +872,47 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+static void __init print_unknown_bootoptions(void)
+{
+	char *unknown_options;
+	char *end;
+	const char *const *p;
+	size_t len;
+
+	if (panic_later || (!argv_init[1] && !envp_init[2]))
+		return;
+
+	/*
+	 * Determine how many options we have to print out, plus a space
+	 * before each
+	 */
+	len = 1; /* null terminator */
+	for (p = &argv_init[1]; *p; p++) {
+		len++;
+		len += strlen(*p);
+	}
+	for (p = &envp_init[2]; *p; p++) {
+		len++;
+		len += strlen(*p);
+	}
+
+	unknown_options = memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!unknown_options) {
+		pr_err("%s: Failed to allocate %zu bytes\n",
+			__func__, len);
+		return;
+	}
+	end = unknown_options;
+
+	for (p = &argv_init[1]; *p; p++)
+		end += sprintf(end, " %s", *p);
+	for (p = &envp_init[2]; *p; p++)
+		end += sprintf(end, " %s", *p);
+
+	pr_notice("Unknown command line parameters:%s\n", unknown_options);
+	memblock_free(__pa(unknown_options), len);
+}
+
 asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 {
 	char *command_line;
@@ -913,6 +954,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 				  static_command_line, __start___param,
 				  __stop___param - __start___param,
 				  -1, -1, NULL, &unknown_bootoption);
+	print_unknown_bootoptions();
 	if (!IS_ERR_OR_NULL(after_dashes))
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
-- 
2.31.1

