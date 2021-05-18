Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D4387841
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhERMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhERMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:01:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB6C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r12so9937012wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RUky6X8awkeDj+Xt+A9z1Fk1fbtjfOdoB+X/SXUlhVI=;
        b=xSQyk7LCiSvsLnuImEyhOtv/I9KSQbMbyTd5lTa6GIddrOr+9miJEF6TZbpNTPunOc
         ww7G1ngIEY9mKVaFl1j0WEgiBH7e6pygVIGO9/QWM9wO3NkgQLyLxfxcdBooNNtLsDO5
         nMQHlvpTFW4g5XuijRIY9Z8w6jxHrxgfSabv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUky6X8awkeDj+Xt+A9z1Fk1fbtjfOdoB+X/SXUlhVI=;
        b=H28qzEZ5HOs9e4NVjYs0GqxlfsZU1OnWYGYTOuqHk+E9bMaFqGiaKPno4/E8yQxw/B
         Gd+TPhkHGUDo6FLKe4c45sRcQc5hz8L8wHULV5OjJJXk/ATa4/ERdXqeSJbAgFRLOONR
         HuDT8FAYe2ZA4maJTb0vDEQiXbErsRL/+Oi5AkdnqHavkkHdGkp1P1W6LQwvrW9bY1aB
         LTwjSgPXew2eQs6uWwjtuFsQEa7NU5ybWivSY5Eq5PhStFX8XvnoqIgOFeigsl8VJBNP
         nrE12Rye/BpVwxCKx8MO7kgAFcXxc7cjMpbzPGaYg/c7H86eMIF1/l5ECkkB0ARog6B0
         h7lA==
X-Gm-Message-State: AOAM533EwxWs4Q0ZDfTfKXanW9FbGKatGYgo4qoegWhqECV5D0GcoQ/4
        2cxsJdSBpRB/prxffYNKICYZLXPxGZE2qOr+iaU=
X-Google-Smtp-Source: ABdhPJyv82GntYd2tF15jNKMkA7iw9K0kZ7vPA3fJdeEP8+E/TxwRS+oUxWVvkAnn0K3fElknZLgdw==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr6682771wrx.53.1621339239211;
        Tue, 18 May 2021 05:00:39 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5c4a])
        by smtp.gmail.com with ESMTPSA id d9sm19604770wrx.11.2021.05.18.05.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:38 -0700 (PDT)
Date:   Tue, 18 May 2021 13:00:38 +0100
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
Subject: [PATCH v6 2/4] printk: Straighten out log_flags into
 printk_info_flags
Message-ID: <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621338324.git.chris@chrisdown.name>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past, `enum log_flags` was part of `struct log`, hence the name.
`struct log` has since been reworked and now this struct is stored
inside `struct printk_info`. However, the name was never updated, which
is somewhat confusing -- especially since these flags operate at the
record level rather than at the level of an abstract log.

printk_info_flags also joins its other metadata struct friends in
printk_ringbuffer.h.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            | 43 ++++++++++++++-----------------
 kernel/printk/printk_ringbuffer.h |  6 +++++
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 114e9963f903..3201bb0c269c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -350,11 +350,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  * non-prinatable characters are escaped in the "\xff" notation.
  */
 
-enum log_flags {
-	LOG_NEWLINE	= 2,	/* text ended with a newline */
-	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
-};
-
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_RAW_SPINLOCK(syslog_lock);
 
@@ -1966,19 +1961,20 @@ static inline u32 printk_caller_id(void)
  *
  * @text:     The terminated text message.
  * @level:    A pointer to the current level value, will be updated.
- * @lflags:   A pointer to the current log flags, will be updated.
+ * @flags:    A pointer to the current printk_info flags, will be updated.
  *
  * @level may be NULL if the caller is not interested in the parsed value.
  * Otherwise the variable pointed to by @level must be set to
  * LOGLEVEL_DEFAULT in order to be updated with the parsed value.
  *
- * @lflags may be NULL if the caller is not interested in the parsed value.
- * Otherwise the variable pointed to by @lflags will be OR'd with the parsed
+ * @flags may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @flags will be OR'd with the parsed
  * value.
  *
  * Return: The length of the parsed level and control flags.
  */
-static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
+static u16 parse_prefix(char *text, int *level,
+			enum printk_info_flags *flags)
 {
 	u16 prefix_len = 0;
 	int kern_level;
@@ -1994,8 +1990,8 @@ static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
 				*level = kern_level - '0';
 			break;
 		case 'c':	/* KERN_CONT */
-			if (lflags)
-				*lflags |= LOG_CONT;
+			if (flags)
+				*flags |= LOG_CONT;
 		}
 
 		prefix_len += 2;
@@ -2005,8 +2001,9 @@ static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
 	return prefix_len;
 }
 
-static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
-			 const char *fmt, va_list args)
+static u16 printk_sprint(char *text, u16 size, int facility,
+			 enum printk_info_flags *flags, const char *fmt,
+			 va_list args)
 {
 	u16 text_len;
 
@@ -2015,7 +2012,7 @@ static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lfl
 	/* Mark and strip a trailing newline. */
 	if (text_len && text[text_len - 1] == '\n') {
 		text_len--;
-		*lflags |= LOG_NEWLINE;
+		*flags |= LOG_NEWLINE;
 	}
 
 	/* Strip log level and control flags. */
@@ -2039,7 +2036,7 @@ int vprintk_store(int facility, int level,
 {
 	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
-	enum log_flags lflags = 0;
+	enum printk_info_flags flags = 0;
 	struct printk_record r;
 	u16 trunc_msg_len = 0;
 	char prefix_buf[8];
@@ -2071,22 +2068,22 @@ int vprintk_store(int facility, int level,
 
 	/* Extract log level or control flags. */
 	if (facility == 0)
-		parse_prefix(&prefix_buf[0], &level, &lflags);
+		parse_prefix(&prefix_buf[0], &level, &flags);
 
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
 
 	if (dev_info)
-		lflags |= LOG_NEWLINE;
+		flags |= LOG_NEWLINE;
 
-	if (lflags & LOG_CONT) {
+	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
 			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
-						 facility, &lflags, fmt, args);
+						 facility, &flags, fmt, args);
 			r.info->text_len += text_len;
 
-			if (lflags & LOG_NEWLINE) {
+			if (flags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
 				prb_final_commit(&e);
 			} else {
@@ -2113,20 +2110,20 @@ int vprintk_store(int facility, int level,
 	}
 
 	/* fill message */
-	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &lflags, fmt, args);
+	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &flags, fmt, args);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
 	r.info->facility = facility;
 	r.info->level = level & 7;
-	r.info->flags = lflags & 0x1f;
+	r.info->flags = flags & 0x1f;
 	r.info->ts_nsec = ts_nsec;
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
 	/* A message without a trailing newline can be continued. */
-	if (!(lflags & LOG_NEWLINE))
+	if (!(flags & LOG_NEWLINE))
 		prb_commit(&e);
 	else
 		prb_final_commit(&e);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 73cc80e01cef..71918d47ca95 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
 	unsigned long	next;
 };
 
+/* Flags for a single printk record. */
+enum printk_info_flags {
+	LOG_NEWLINE	= 2,	/* text ended with a newline */
+	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+};
+
 /*
  * A descriptor: the complete meta-data for a record.
  *
-- 
2.31.1

