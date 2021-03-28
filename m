Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB734BAEB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 06:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhC1Enq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 00:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhC1EnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 00:43:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC3C0613B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 21:42:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g15so9384001qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5igONXEO98vO4FM78LS4gCrljh6JLaa7Yhx+y94h5KA=;
        b=nQabloX2KA8lOYy/hCAP3squLsBt46DkSx8Vj4i2dtY0E0f2J0rKktQ6p3jCr9zrj4
         +ZrWuHbI1yHk67FMnZ8fJClT3iQWfjIBbK8SyW18CVVucx0m4uZ5kY1qCFkHKNor19ey
         UNb4kjw4+7x4jQyWfxLcoXM1iMCvixwl3T2cWt3h9fLPs8KA2y1W0iliE206svQrrvI0
         FN7P82SnVksQpNwRa9appzQwxapWHCtSsXRbyUquBx5aBfWKurlEgqY+TV6SA6Vf7jLc
         wn1pmbfWPfMQchbMccVLNChjzmoQF8YKVq6WutO8FNNagKCsb/u2FXZqNhR5kxIb+WB2
         5IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5igONXEO98vO4FM78LS4gCrljh6JLaa7Yhx+y94h5KA=;
        b=jOPwlI3lWl0GF7qNcHDPwGkp4HNZkywP5jGo2GPAriVTyyFQfRAPDRW3oCdC8fujhY
         9ed1f5aNrfgHZJGqfLaQp3ON42/2vQnaquLqwqtxGCf5krQQ7fkAccsibxU3kwd3aLAp
         kOu3Z01ZQ28MuTL1uoP57CjAT0haQycqwX3GYMC0d9i9Ss3zhqtYIji1hbIW/dELZt+o
         0yZDWXXHRM9gH+BI7ygRtDmustxW5gtU50tu5bxJ2K1W/lhW/gL/0GFnOgV+6WUzogNc
         9IRi3K71JWdn3ds58lQhDmb6MR2CP0aJHbWGLuQG+hoPMDxZg4RzG8CQwVE734HK3nwQ
         mEaQ==
X-Gm-Message-State: AOAM532VBI70/GlQwILGwABF+HteBCtoOZjd7CHKY9XIh+JydT1OdzVr
        L/A3Tj375a/zXExVqEG93DA=
X-Google-Smtp-Source: ABdhPJwhHKNePU6EDnUH6cL3XMcMOd9iXTQx74JSo0GF66mPVq7Y2GfUubDdX5a80QQpfR/3epZ8oQ==
X-Received: by 2002:a37:ef09:: with SMTP id j9mr20556263qkk.390.1616906576754;
        Sat, 27 Mar 2021 21:42:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id l27sm10158915qki.133.2021.03.27.21.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:42:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel/printk.c: Fixed mundane typos
Date:   Sun, 28 Mar 2021 10:09:32 +0530
Message-Id: <20210328043932.8310-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/sempahore/semaphore/
s/exacly/exactly/
s/unregistred/unregistered/
s/interation/iteration/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/printk/printk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 575a34b88936..95d31886e0d7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -262,7 +262,7 @@ static void __up_console_sem(unsigned long ip)
  * definitely not the perfect debug tool (we don't know if _WE_
  * hold it and are racing, but it helps tracking those weird code
  * paths in the console code where we end up in places I want
- * locked without the console sempahore held).
+ * locked without the console semaphore held).
  */
 static int console_locked, console_suspended;

@@ -2262,7 +2262,7 @@ static int __init console_setup(char *str)
 	/*
 	 * console="" or console=null have been suggested as a way to
 	 * disable console output. Use ttynull that has been created
-	 * for exacly this purpose.
+	 * for exactly this purpose.
 	 */
 	if (str[0] == 0 || strcmp(str, "null") == 0) {
 		__add_preferred_console("ttynull", 0, NULL, NULL, true);
@@ -3042,7 +3042,7 @@ void __init console_init(void)
  *
  * To mitigate this problem somewhat, only unregister consoles whose memory
  * intersects with the init section. Note that all other boot consoles will
- * get unregistred when the real preferred console is registered.
+ * get unregistered when the real preferred console is registered.
  */
 static int __init printk_late_init(void)
 {
@@ -3467,7 +3467,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		seq = r.info->seq + 1;
 	}

-	/* last message in next interation */
+	/* last message in next iteration */
 	next_seq = seq;

 	/* actually read text into the buffer now */
--
2.26.2

