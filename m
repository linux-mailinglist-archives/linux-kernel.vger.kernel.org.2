Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47AB3D7593
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhG0NGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhG0NGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:06:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so1821146wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdqwjTGqzKchQQQt3QfP1PL+GHEvyOfXbnCTVSNXp18=;
        b=Fxb+13wXrRshxoY4KA2GBHCNf7QgBKAmaacr37oy//Xaku9rEzb8EHaprLeCdYmzsy
         AfTygyS8xbyVWERokVK3gfJnWl2VjqF9fc3qiHDvihr7tP6ov9ZCcYIOMcgRgoLty+oN
         Z1mjIEcOibOrWY6DERaBrfnuvkT94+YPP07p2shmNVH7hXUfO3vgNGjkhohrREsbrnaW
         zv15YOv+dxOo2FLtYDCa2an0z1qIPSc12ltpXhICLgiXbrHlr/024T1BI3tYkpor2isp
         bZqeO+ap0MfBhH5V/o+DG++uLLCfPQTAzgvDk1qyOrLJls6ec3o+Bk4OpQO/C96MpW3n
         yGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdqwjTGqzKchQQQt3QfP1PL+GHEvyOfXbnCTVSNXp18=;
        b=EMKzjuO1OHjyKr6PwEADGaIVC+oMAo0iHlJGY53PFGhiZW25llSRIjk5EEGxkyXRIR
         J2Ed2zkvHueJ8Sgm1R62EMDG/WZfQPwKzhRu0PJfh+8H/RUSkkxLKj4/vMhffnBZQP5c
         FZo4VCRAXfvvU757w4Q8ireeMF8Pc9XGppMXs6x9ok3sdryMIbBuFhomJrF38IZ/0jTA
         qU95St7MNLLFlL+5nMGN1If6PI3otqPthka3vrVw/ybu2CajLnNcLDV0cbXrYfwBgwNL
         MPbKNJJm0TjBpyyGMmHt0LNB9x74pmroCiPUB1jNjo1HRep+vCNbh1ENcdPJppS2t4sB
         ahoA==
X-Gm-Message-State: AOAM533ZnPRJ3ffpWZKe9PIa/BWjFd4bcFEjgUMtWb7I1Bg35RHLOtd/
        g3QrLpofJP3Jfg7IIzW7Jy0nq9/LijgLLRo+
X-Google-Smtp-Source: ABdhPJwDAK2//CDKmLNA8yNTmAcNw+X8a6f/EXvs61QCiaL/KMyi7v95W8MfYqeIVmtrHhp+ic0xLg==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr4113540wme.61.1627391197997;
        Tue, 27 Jul 2021 06:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 104sm3421034wrc.4.2021.07.27.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:06:37 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 1/2] printk: Remove console_silent()
Date:   Tue, 27 Jul 2021 14:06:34 +0100
Message-Id: <20210727130635.675184-2-dima@arista.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727130635.675184-1-dima@arista.com>
References: <20210727130635.675184-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It' unused since removal of mn10300:
commit 739d875dd698 ("mn10300: Remove the architecture")
x86 stopped using it in v2.6.12 (see history git):
commit 7574828b3dbb ("[PATCH] x86_64: add nmi button support")

Let's clean it up from the header.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index e834d78f0478..a63f468a8239 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -70,11 +70,6 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-static inline void console_silent(void)
-{
-	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
-}
-
 static inline void console_verbose(void)
 {
 	if (console_loglevel)
-- 
2.32.0

