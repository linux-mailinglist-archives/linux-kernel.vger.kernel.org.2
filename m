Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF454189B6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhIZPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhIZPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2BEC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y5so7532763pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8/bPqEiuBtXwUz8LmSO+JFkF0uMBlZkzgLMIyOWGew=;
        b=FhfXLsft0o4RRGuPmxjCBCicjFDEynzdehTflyxHPwo+gLPFSrSn5T2SLBB23/rent
         JUdVao4O4zp/UoCYXHi08kpV0U94RliJQEtPEldYOpHzPxOHv6Oqoicxl6XsFANXapMg
         Vqay85Zeif6CKXLrvhfGQUdtXT7fKH6RpGgVHAy2dmfs7STq+UwwqFij/pW1NnGh5Yhg
         olHWR0L9qBlyaAooXuNY5huQLXuZD8oHe/i3XHV7I0/dbc8zxD9wk7iTMUpkBTMKRxOi
         0wCKxoElotZ/FePo1kyx+5aV9iJynCrTY6jnsxHiZNoVNr4beVi+OB/Ic/VDzpesSHgU
         yusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8/bPqEiuBtXwUz8LmSO+JFkF0uMBlZkzgLMIyOWGew=;
        b=0yM5MxE22+lnZ7UtipDVH0jxRHZ55+NiW+Guy/Yr+2hN4FA+6PwIrY7E9pdJ3vQ0vL
         4mo/KJ14BaCGNaq7tn53IS4yD4jNxQodFMWui8IBRY7XYT+vtFIqd1EaiDCxpfHEsf8r
         2VrX3AjH14PGCZ6dm8ncnDgRpNRyY15zNCeGTVvftWzBbZh88F7Sz/zl1Js/GbV5i4lK
         +fgeF3hQtwLsOU/NwWFyOoGKRFvIrYfyAiDwlNvUw1TNCQD3p7/X3HxaAS3+2v5qKeOS
         2iBQh6D7+AjqhW+lyzjDEjSR3krUFMzyja+zoXcDWUHgJYhX8WgKSxETQdl2hI1+f9pr
         5t+A==
X-Gm-Message-State: AOAM533YXFDs2VeTao14gmZlCKrPI2q56HAbf1sdMtN8LINr2q8hn3mF
        RYjBnuWsS93oLj1VRngwqqZVbY+ICpEXWA==
X-Google-Smtp-Source: ABdhPJypD3MrH67BwL3WiwH3dHAxSoKZOxqEBmJkfk6oNDz46bnhS/jsKiHf4D4dCE1mRyoWPErGHw==
X-Received: by 2002:a17:902:b583:b0:13d:e495:187a with SMTP id a3-20020a170902b58300b0013de495187amr13663723pls.9.1632668942452;
        Sun, 26 Sep 2021 08:09:02 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id 201sm13963572pfw.37.2021.09.26.08.09.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:02 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 04/41] x86/entry: Introduce __entry_text for entry code written in C
Date:   Sun, 26 Sep 2021 23:08:01 +0800
Message-Id: <20210926150838.197719-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in C files.  We need __entry_text
to set them in .entry.text section.  __entry_text disables instruments
like noinstr, but it doesn't disable stack protector since not all
compiler supported by kernel supporting function level granular
attribute to disable stack protector.  It will be disabled by C file
level.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..6779def97591 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
-- 
2.19.1.6.gb485710b

