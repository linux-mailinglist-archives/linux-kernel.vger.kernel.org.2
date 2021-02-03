Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165C130DD34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhBCOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhBCOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:49:39 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E32C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:48:59 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r20so14115963qtm.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJF7claiBnCV5yaBoty/hJpOc+Gz8y6VI6rHEkoKsYM=;
        b=Ut+hS0hPeIbRNM9SgxCQ0PzAZSHKSRQrS4BAyYqJjcRm/gOkf75oZ3rnA/Vzl6yF63
         yyO8si1PaQM8j02jLpF4FmgwI1qvSUGbEA3kAD78NzdCJjnsSdOi+54I8TwR0M02TWOf
         Y0zN3G4BOzqK1KX5zUf+beXeTVe1ixtskxZgyh9vThtFSMedQad8o+EQ0yoo9muM4ExW
         gFBnb4CG/puZL5lMeTzeiU1Az7cJfsUqgjAPvg0qthKo2NZb3iBf5XQ9/HiaG+Hx9nie
         hgzK6cOYmITN1YtXTsAU8b9l1r+KYeksC+daTdJGLNB9KjCWAGHrR9hRzrQQ4dyXP3wh
         XV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJF7claiBnCV5yaBoty/hJpOc+Gz8y6VI6rHEkoKsYM=;
        b=k8SvrnkrHfXkfWRUDLAeP8/9W3Xeo+0yOscfEgIMSYWpIQEF38VERcLpayjzPoZaee
         oG9pgJA4f8z4+VWXHlqot/ZicgB82BJwBjFUNMPGbAxkCkFkW9g4R4qxQ8gqmMJ7N/9t
         gyQKrJes1Zh732YkJONVF+YY8VwT+CuSc0iwheCqPV8ez9CjiyOogla8Hx964w6LguFO
         rPPb01MarEERSLMug8WteyoC/U3jUHN1ju1hNG7nW7mP2JJE90W6sw9G8w/EgwA1VTHq
         ClzIyb15ezCrjSILk1PxwTB/9emZ3vZguKQgWiJMvvdInAR0V6gMr4i9qVhM8Gi7Ph9J
         u5BQ==
X-Gm-Message-State: AOAM530kZTFPeXiPQUFEND66p7zbCaKch8nMzUHm51Kvo9sZUBHk54UP
        KVYoi8Ux8UPjrVXaK712ZgWbXCXboAm3fSSV
X-Google-Smtp-Source: ABdhPJyuvR7xukCGLr+p5s2QkrLPIyFFWUhvnT8PsbzyupsqN9vPQMq64pStAPItVa5mDn8z7ghU6g==
X-Received: by 2002:aed:2be7:: with SMTP id e94mr2660780qtd.110.1612363738624;
        Wed, 03 Feb 2021 06:48:58 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id b72sm1741697qkc.60.2021.02.03.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:48:57 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jikos@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: x86: kernel:  Mundane spelling fixes throughout the file apm_32.c
Date:   Wed,  3 Feb 2021 20:18:37 +0530
Message-Id: <20210203144837.30246-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/messges/messages/
s/powermanagement/power management/
s/secodnds/seconds/
s/powerdown/poer down/

Capitalize and truncate space in start of the sentence.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/apm_32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 660270359d39..04204e01ff7c 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -766,7 +766,7 @@ static int apm_driver_version(u_short *val)
  *	not cleared until it is acknowledged.
  *
  *	Additional information is returned in the info pointer, providing
- *	that APM 1.2 is in use. If no messges are pending the value 0x80
+ *	that APM 1.2 is in use. If no messages are pending the value 0x80
  *	is returned (No power management events pending).
  */
 static int apm_get_event(apm_event_t *event, apm_eventinfo_t *info)
@@ -893,7 +893,7 @@ static void apm_do_busy(void)
  * apm_cpu_idle		-	cpu idling for APM capable Linux
  *
  * This is the idling function the kernel executes when APM is available. It
- * tries to do BIOS powermanagement based on the average system idle time.
+ * tries to do BIOS power management based on the average system idle time.
  * Furthermore it calls the system default idle routine.
  */

@@ -1025,7 +1025,7 @@ static int apm_enable_power_management(int enable)
  *	status which gives the rough battery status, and current power
  *	source. The bat value returned give an estimate as a percentage
  *	of life and a status value for the battery. The estimated life
- *	if reported is a lifetime in secodnds/minutes at current powwer
+ *	if reported is a lifetime in seconds/minutes at current power
  *	consumption.
  */

@@ -1121,7 +1121,7 @@ static int apm_engage_power_management(u_short device, int enable)
  *	Attempt to blank the console, firstly by blanking just video device
  *	zero, and if that fails (some BIOSes don't support it) then it blanks
  *	all video devices. Typically the BIOS will do laptop backlight and
- *	monitor powerdown for us.
+ *	monitor power down for us.
  */

 static int apm_console_blank(int blank)
@@ -2366,7 +2366,7 @@ static int __init apm_init(void)
 	/*
 	 * Note we don't actually care if the misc_device cannot be registered.
 	 * this driver can do its job without it, even if userspace can't
-	 * control it.  just log the error
+	 * control it.Just log the error
 	 */
 	if (misc_register(&apm_device))
 		printk(KERN_WARNING "apm: Could not register misc device.\n");
--
2.26.2

