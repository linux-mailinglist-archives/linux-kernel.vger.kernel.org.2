Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C63A86E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFOQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFOQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:54:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB2EC061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so19119289wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uI/pvHsTTyZh3fHaDustrSZwRrihBhp8OG6erc+b6b4=;
        b=hoTnGfb+m4geMCZOBOrWzbmU1Gq/amOTtwODvcF9OOIIuN12EU5V6PEogeiyGyg1BT
         jsjboT4FriHBs26cJvNZYC7uamgXkv9VOEdIczn2LfFcVF1Jv7XAZjMZEdbJwWgk/qKb
         xb8XufN9y8PyxT8UqlhRlZ93PztCVIzyqtGaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uI/pvHsTTyZh3fHaDustrSZwRrihBhp8OG6erc+b6b4=;
        b=CDoAUYMbhH+1BDcBrFluiFqG8l9kokICY1Jmij0ttbvvBV4yECuK2hqNzGoR+AQ/c2
         MakfTsTXrGUe7rp1tFW0XbqS6NZYKWgkGnRtgmcpQ+FDCsTNnELPxmWTAhoS/0zhwcQP
         UvmQL+S1j5OOFdUYeG5mHWv1+Y+ZfPSaoylWw3sZ9I/MxRzGpoSAZJuPegD6Uw2Qh145
         efID0m9neVBe9yRmQhOj9Hj+YjVgasauN0o0ZRb+9xYnWbMMTSu2MmblX9eCkXuqjTy4
         88cVod6Kf4cNikx5tW88r90vv9FXivc4wZ7LAHsFX7EvhAeu4HJwIjywO+7hcCnI0bEU
         8IGQ==
X-Gm-Message-State: AOAM532UBp0ZnW7zGcDeR7Sr5cdJg+mENlzv4rXkpu7tq2fiwhP9jfRR
        u5ofadX+Ww8awDFJt3FHmwpvlpH1kvykLYAeheI=
X-Google-Smtp-Source: ABdhPJwuUh+TKB8Wdu3KJPGjTP7pIQ2u6YckzDa0KDpO77RIuts/2KFyxnmguvCyxgn+/oV27n9MjQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr82258wrr.26.1623775972146;
        Tue, 15 Jun 2021 09:52:52 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id a1sm1006399wra.63.2021.06.15.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:51 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: [PATCH v7 3/5] printk: Rework parse_prefix into printk_parse_prefix
Message-ID: <b22ba314a860e5c7f887958f1eab2649f9bd1d06.1623775748.git.chris@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse_prefix is needed externally by later patches, so move it into a
context where it can be used as such. Also give it the printk_ prefix to
reduce the chance of collisions.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 2 ++
 kernel/printk/printk.c   | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 1075e60fcd98..1596e2837318 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -57,6 +57,8 @@ bool printk_percpu_data_ready(void);
 
 void defer_console_output(void);
 
+u16 printk_parse_prefix(const char *text, int *level,
+			enum printk_info_flags *flags);
 #else
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3201bb0c269c..26d52aea9969 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1957,7 +1957,7 @@ static inline u32 printk_caller_id(void)
 }
 
 /**
- * parse_prefix - Parse level and control flags.
+ * printk_parse_prefix - Parse level and control flags.
  *
  * @text:     The terminated text message.
  * @level:    A pointer to the current level value, will be updated.
@@ -1973,7 +1973,7 @@ static inline u32 printk_caller_id(void)
  *
  * Return: The length of the parsed level and control flags.
  */
-static u16 parse_prefix(char *text, int *level,
+u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags)
 {
 	u16 prefix_len = 0;
@@ -2019,7 +2019,7 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	if (facility == 0) {
 		u16 prefix_len;
 
-		prefix_len = parse_prefix(text, NULL, NULL);
+		prefix_len = printk_parse_prefix(text, NULL, NULL);
 		if (prefix_len) {
 			text_len -= prefix_len;
 			memmove(text, text + prefix_len, text_len);
@@ -2068,7 +2068,7 @@ int vprintk_store(int facility, int level,
 
 	/* Extract log level or control flags. */
 	if (facility == 0)
-		parse_prefix(&prefix_buf[0], &level, &flags);
+		printk_parse_prefix(&prefix_buf[0], &level, &flags);
 
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
-- 
2.31.1

