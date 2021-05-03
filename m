Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948B9372273
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECVgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhECVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620077737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=46446gCvXI349wK5e/1GSr6sFMdA673+zPNAeBlqfRI=;
        b=PErLj1VqSmSSMA8TpvUy9QM8W3PlngvsrvSxzoXjO7ANkjb12ez+3NJmU+8ljb5/soG1oz
        69NsxISHjAVxATJ5HU7W4pPPkM3VQzqJVTYT9qfC3znt8c1CFNFDDvkXbz5GYkiB0FlYpW
        qV9VGagxfSy3ec16nwjkU/7qOQdKhts=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-lEwJZGBHO-2BxM6zJ2WB3Q-1; Mon, 03 May 2021 17:35:34 -0400
X-MC-Unique: lEwJZGBHO-2BxM6zJ2WB3Q-1
Received: by mail-io1-f71.google.com with SMTP id z25-20020a05660200d9b02903de90ff885fso4304012ioe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46446gCvXI349wK5e/1GSr6sFMdA673+zPNAeBlqfRI=;
        b=JOA6f2YYY9EKHDla2946HrtKjQNmDenH6KTxS+hQg/4JhBhpz9cDGNdvWCtb1pdrRk
         ee0C4tmyztQINIpqhU1x2X/Db6fdRPuUEEzej6abEwYjLh0x386Jy1TE1ENXprDM+b/G
         ZR4gR+yFySAhgZw7Xb89XfTObUQWzjulUuFV9/b+g3/oxPnKrPC4JW98uFrMThKOk9lH
         bleNFZ5QfU6e51Fxfl7cJENLONdaXcdLq1ikcLUJ1E2zhWYcM4Vqq+7Ch+nbBro0wIHG
         Ne+nx1xVo7r2uMkdzCYgk7YAki0tqWic49kUhRlPb3Q/dec4ZOUkCxDv+PisggPdGDIN
         En+w==
X-Gm-Message-State: AOAM530mWd+3mJJ/e6ZSj9YUxxotYU+SzFPzO44uktpR0HakMEB1nrUk
        +ZG5EywgAFJ6GpyfU6tvxrgNutjyj3ziFx2vUYl0Lvd6WhIqZIAg6LZJTQ/ykzDbzW4Wsw+U8Yl
        FX6cTZrQjE7bPcyi7wfgTU8Ty
X-Received: by 2002:a6b:f311:: with SMTP id m17mr13178202ioh.162.1620077733903;
        Mon, 03 May 2021 14:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFt+8zG9Bfyzq8qPo2QzfIb05clK5EcquIQfvOXMV7nLFnF+yJzMpkeaxhvmo1WKa6KCee9w==
X-Received: by 2002:a6b:f311:: with SMTP id m17mr13178192ioh.162.1620077733709;
        Mon, 03 May 2021 14:35:33 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id y25sm352977ioj.39.2021.05.03.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:35:33 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] init: Print out unknown kernel parameters
Date:   Mon,  3 May 2021 16:34:01 -0500
Message-Id: <20210503213400.27360-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.30.2
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

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Hello,

This idea was suggested by rostedt and bpetkov, not sure what they'll
think of the implementation :P Please let me know if you've got
suggestions (or hate the idea in general).

Piggybacking on unknown_bootoption()'s assessment of the
parameters made this pretty straight forward, but I'm a bit unhappy with
dyndbg and BOOT_IMAGE showing up. I didn't want to make an exception for
them, so I left it as is and decided that their oddities ought to be
shown in the output still. The format of the output is borrowed from the
dynamic debug statements for printing init's env/argv lines.

Due to the BOOT_IMAGE bit I didn't actually ever get to exercise the
early return (limited on my test systems right now) but I think I got
that statement correct.

Thanks,
Andrew

 init/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/init/main.c b/init/main.c
index dd11bfd10ead..cd313f1bc7b0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -872,6 +872,20 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+void print_unknown_bootoptions(void)
+{
+	const char *const *p;
+
+	if (panic_later || (!argv_init[1] && !envp_init[2]))
+		return;
+
+	pr_notice("Unknown command line parameters:\n");
+	for (p = &argv_init[1]; *p; p++)
+		pr_notice("    %s\n", *p);
+	for (p = &envp_init[2]; *p; p++)
+		pr_notice("    %s\n", *p);
+}
+
 asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 {
 	char *command_line;
@@ -913,6 +927,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 				  static_command_line, __start___param,
 				  __stop___param - __start___param,
 				  -1, -1, NULL, &unknown_bootoption);
+	print_unknown_bootoptions();
 	if (!IS_ERR_OR_NULL(after_dashes))
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
-- 
2.30.2

