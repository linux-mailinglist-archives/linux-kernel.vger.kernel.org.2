Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD93A86E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhFOQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFOQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:54:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso2235304wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4GocuRtQwJ1GiA79Kj6IXq5l9/qhn5iLdZBTqQtPHY=;
        b=HaGzoaNTa7kWVD1h9MEHOfmmFGu2NYUyEkgRcKJn0rToOQt3YrXNBkRLgQP/PnoYdW
         fCg6n/YofRcT4x60GuVsJHRNYAr6IYmSsHXF6Vk/CbHS0uU5X8Y9MfIN8vIhcA8pbg8P
         cw4YnxumnjVUqv21aipsAc73GWlDtwMJLpqeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4GocuRtQwJ1GiA79Kj6IXq5l9/qhn5iLdZBTqQtPHY=;
        b=UeDw2/hO41qlYn8I6HDE+8iy3NlZcav2bPM6dMOQHS/UmkettPr/ROoH/U1PAy6Sd0
         tyKexaOywfIniVOQoABXZlx8OAKBXmDUdiEkyCdFY0v59392tsOobELAISXxdtnk3KXS
         sHT+/YypCXf4H2gCSx/fUP1qmQxtYuke60ip0wvtO/INxW13LAd6hOzI+wQOGOGLfmON
         MmBwP6/aKzEdlOsVIWHfV7m0U4XWK020aXdJ3SnBQ54HrB/9QkkQ0cGKmuPRMBuSkQ9V
         C9NVrfxV/O4SX71oYUpTtvFjRDMFw+ERHWpg45XR+DCh/q3y6QiKXwjcYL/MDeLg3nVC
         Rc/g==
X-Gm-Message-State: AOAM533eP6O41GQeJdRjCugqmQNv0IH42l2SAwUrhKwsJ0AkGotbZp5m
        R82JahfrQZv0+zKxSVLiveAlQtOr0SbkKd4WME0=
X-Google-Smtp-Source: ABdhPJyp4HP4NF/g8oPrrS7KiwbslXJQ+nnT3fNmIr4nQLR9TiDeYu3Z/55YmVnebgKnk4UStoMaiA==
X-Received: by 2002:a1c:2584:: with SMTP id l126mr6233999wml.83.1623775969401;
        Tue, 15 Jun 2021 09:52:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id u20sm15765451wmq.24.2021.06.15.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:49 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:48 +0100
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
Subject: [PATCH v7 2/5] printk: Straighten out log_flags into
 printk_info_flags
Message-ID: <3dd801982f02603e6e3aa4f8bc4f5ebb830a4949.1623775748.git.chris@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  6 ++++++
 kernel/printk/printk.c   | 43 +++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 51615c909b2f..1075e60fcd98 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -12,6 +12,12 @@
 
 #define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
+/* Flags for a single printk record. */
+enum printk_info_flags {
+	LOG_NEWLINE	= 2,	/* text ended with a newline */
+	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+};
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
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
-- 
2.31.1

