Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC010379BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEKAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhEKAkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7FCC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h127so14803099pfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgjLxTMswgoGuX5Ufpd99mf4WDXQ7EH22iq7Xe02XNg=;
        b=dcOuNbwYF0Gx39rUQ1LtfVzL570ONPhcBdCR6gY5BlnQKv6OhYsGd46n2N8A6wYPFa
         Gnsa2lvi4UlWAGlkSsrtzsD0ntlsUrK2el8McGmiOLh3YGW22E/QD/eERL7aWQG52zzF
         3Xrsj7RFk9wY5rWHeixC2mVDmJyEffS/gRePg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgjLxTMswgoGuX5Ufpd99mf4WDXQ7EH22iq7Xe02XNg=;
        b=fLJlKN6u2QnNVLfVQd5K1sFGKTmuxNShHnteMerZW1Q+jOyYvUVVJFRF4ygg2Cm6IR
         qX7u+6nP4AEeZq5FVAMfNzUti8OOHBlE1XFm/qOSGxsUyCWK8GQy5QluEzngjhYNygAB
         oF6YcyzcMa6O7K6HH4t0zbyIvKI8sgHUP0Iw7BRLP8cHsU5VTj1zDDnsY2/o43+aqR9y
         rBEnYfKPIqnNyrKzYPQ/+Xz+npGSVRHs4t8oDiaKstOgTDOO9cZvNUuxm0Vdf5EgWNdX
         y59iJLGlaBA96YbF4SV9fA1aaprVisU6nzLqMr9f25dfuMyFo0rNjlj+NwlPZp109JB1
         NaPw==
X-Gm-Message-State: AOAM533ClM/h1H12zZ/xGts4rdbYe+66h78SXJFL1wtIPw1MLI69fkGS
        AR5Y5JKglttR4gVdqnpheQFcEg==
X-Google-Smtp-Source: ABdhPJyHt5qlJ9+eyPJ3RPR/xsZlWOh7q3rszrBTTqz+L2USBt8zLlTuePU1ywaDYI5ytDBuk/AOXw==
X-Received: by 2002:a63:a41:: with SMTP id z1mr4145256pgk.115.1620693536911;
        Mon, 10 May 2021 17:38:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 07/13] x86/dumpstack: Use %pSb/%pBb for backtrace printing
Date:   Mon, 10 May 2021 17:38:39 -0700
Message-Id: <20210511003845.2429846-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the new printk formats to print the stacktrace entries when
printing a backtrace to the kernel logs. This will include any module's
build ID[1] in it so that offline/crash debugging can easily locate the
debuginfo for a module via something like debuginfod[2].

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <x86@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
Link: https://sourceware.org/elfutils/Debuginfod.html [2]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 299c20f0a38b..ea4fe192189d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -69,7 +69,7 @@ static void printk_stack_address(unsigned long address, int reliable,
 				 const char *log_lvl)
 {
 	touch_nmi_watchdog();
-	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
+	printk("%s %s%pBb\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
 static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
-- 
https://chromeos.dev

