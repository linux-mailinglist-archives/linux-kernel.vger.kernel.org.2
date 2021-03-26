Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA534A5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCZKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:50:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73512C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:50:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx7so5752551edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnN4HDTE/OP9zJ6OV36guzUAEtJnzv6MpFzJEJUrPLw=;
        b=B18QJBnnb117DXQheOLg84WWvVAPVYBuiqGyY8mTCRM9Zy/JqsLiEWRjPZPiBAN07Y
         cTE7G7XD/j4chJmMM56c3ZFYAN2hRw77yRO7vZPLD5NSe+HacS/qkshg6j3QtShlC/Xs
         Vu084TQHM6i5NORsz60ZgYEy8nvIj/Mg64kVZ9swMkC8KvL6UbkaJ4pdKg6XTQymwGMT
         T+xJydzJRyi1A1dXeu0m3QoTQEX3TFfn5PwEPyvcWp6kSBPmsp3Kw9Uj/gMN7vquZt+I
         yeXWzvIkwdW9iSJ/Ifh0PrO381XT0nMkRhdaY5c5QTeri+SKb5HKEWA2ytwqFjL0VTwz
         ciaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnN4HDTE/OP9zJ6OV36guzUAEtJnzv6MpFzJEJUrPLw=;
        b=WIVZqnz4wUyE1Lg1zuEBg+TM1fLkh+zJH6jojt+/UvB0mzLCl+mT9G3mnL5+Rzxl+O
         Z2XK/kf0+DU3lPqTlg0/4xTOsppFS1Nckg3Xm0SpTV7GbNZpNjS8026QqUayLJQRZ8lG
         9hLvKJe7AdThgxo0HyCXzqAhgilZ2I7FN6soFyTo3nqjnRBrXmKLgPIueNwLYWaGpwyb
         5Ss2yySwHvmuQasZW+BwbvwKXYMEAmxD2CD+wIA2MxRPn2QzPKdivhOlluBhrxl1mQ/P
         bdF7q0jBKisDYKfYoaHVhgTiK5qaJ1I1igj+9VLt6Ea+C2hNqLFwf3e/UtlNH96Od46M
         8ncg==
X-Gm-Message-State: AOAM530LBPWwDjEl885n1Z04vi3PIi0yzQyHvoBAMSbCcmBPbovrhlfp
        oDeo/w6q8jp31MbWbQInaERL/9Ud7hyEhbCw
X-Google-Smtp-Source: ABdhPJw5MdUWe444Bge175oRpRaQIaKp36OSrPWhr9fCPE9BkzlvGuVBRZkHDEagW/ekCuHiaHnnPA==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr14366810edd.103.1616755857213;
        Fri, 26 Mar 2021 03:50:57 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id h17sm3987165eds.26.2021.03.26.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:50:57 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH mptcp-next] static_call: fix unused variable warn w/o MODULE
Date:   Fri, 26 Mar 2021 11:50:23 +0100
Message-Id: <20210326105023.2058860-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the warning converted as error and reported by GCC:

  kernel/static_call.c: In function ‘__static_call_update’:
  kernel/static_call.c:153:18: error: unused variable ‘mod’ [-Werror=unused-variable]
    153 |   struct module *mod = site_mod->mod;
        |                  ^~~
  cc1: all warnings being treated as errors
  make[1]: *** [scripts/Makefile.build:271: kernel/static_call.o] Error 1

This is simply because since recently, we no longer use 'mod' variable
elsewhere if MODULE is unset.

When using 'make tinyconfig' to generate the default kconfig, MODULE is
unset.

There are different ways to fix this warning. Here I tried to minimised
the number of modified lines and not add more #ifdef. We could also move
the declaration of the 'mod' variable inside the if-statement or
directly use site_mod->mod.

Fixes: 698bacefe993 ("static_call: Align static_call_is_init() patching condition")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    Feel free to modify this patch directly if you prefer. I can of course
    send a new version if needed.

 kernel/static_call.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 2c5950b0b90e..723fcc9d20db 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -165,13 +165,13 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 
 		stop = __stop_static_call_sites;
 
-#ifdef CONFIG_MODULES
 		if (mod) {
+#ifdef CONFIG_MODULES
 			stop = mod->static_call_sites +
 			       mod->num_static_call_sites;
 			init = mod->state == MODULE_STATE_COMING;
-		}
 #endif
+		}
 
 		for (site = site_mod->sites;
 		     site < stop && static_call_key(site) == key; site++) {
-- 
2.30.2

