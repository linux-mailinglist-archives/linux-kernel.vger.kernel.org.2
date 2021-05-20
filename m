Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CF38AF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbhETMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbhETMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647B6C068D92
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so5108466wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXZz+5yWrMW3ckUzijLAYIHOvD2B9pCMMGt8aJib/OY=;
        b=iJlJWNZBFfzltcffrREDnTHYrHu6JdeahSQLlDEN2dGCa/N4LkY414/WeINd8thD+E
         Ge3cQgLRdAU344p33q3PiDzXiDMzEmVq7qjoQ31uRbHflgy0gHSFGStKYoCsAdrL6xAf
         VFjhYl0eI8EZ+hRQBLcTW57CuEsaRnPDpLsNxk2XxVFTvsCnTDq8myBQyREj0teGFgDA
         MRIhJy4r0o1MBxkW8hS9do5M2dboojSqcXAlJptMcxKLhZn3C7GCxTFPKs/sPbUx3SF5
         lGenLdrwBWtK/8y9OuiblduAMxnenkCH9G1DWauvbsoBrqgmh3FVVrmmHWbEwXtFWerT
         oogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXZz+5yWrMW3ckUzijLAYIHOvD2B9pCMMGt8aJib/OY=;
        b=JhDt09BeVOWM/HfLrmiQ68fQMc7ZH375PSzLD5c136MkuOz98bZ+hFhMZKgS/Udsqc
         r2kQcX8AAjPbt+jH/huQE+HTypiG3PFn12h23qm2o9v6553aLCOg+9r+1arpbPOwcVjl
         JVWL0yTjbGrKb6MlJbZAnZMXu3GlTn5SVdvCjV9HJZ4IGPmOzp0M2vwDK2GZNsCp0CD9
         nIrs9N7we3JMFrEsFYPJTCLPGF1KBW5R50TO5MK4pHnp6MPV+DjKSH1zS+0YdKG+vRnc
         XvQl66A6FpUkK5YIpMDzq8OJmSr9ls4dH3Zovx5vk9edb8MjdcoBmKkiFhExo0sKcjBK
         KCag==
X-Gm-Message-State: AOAM531e6jOuTAerxiBm/Nh43JtxPH3Imc3nGFLp3T1zzc/N1XKoyojd
        UYOq5VxMV6UXNyt3n2zoxOgmhQ==
X-Google-Smtp-Source: ABdhPJzdEGkkdefKKXJZbYYh7d1kgENAcYQXqFb7cVLSorjvZgOM0qomI2MSn4W0VVQaI5uW578gZQ==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr3440744wmi.154.1621513153039;
        Thu, 20 May 2021 05:19:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrew Morton <andrewm@uow.edu.eu>
Subject: [PATCH 03/11] tty: tty_io: Fix a few kernel-doc related misdemeanours
Date:   Thu, 20 May 2021 13:18:58 +0100
Message-Id: <20210520121906.3468725-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_io.c:785: warning: expecting prototype for stop_tty(). Prototype was for __stop_tty() instead
 drivers/tty/tty_io.c:816: warning: expecting prototype for start_tty(). Prototype was for __start_tty() instead
 drivers/tty/tty_io.c:931: warning: Function parameter or member 'iocb' not described in 'tty_read'
 drivers/tty/tty_io.c:931: warning: Function parameter or member 'to' not described in 'tty_read'
 drivers/tty/tty_io.c:931: warning: Excess function parameter 'file' description in 'tty_read'
 drivers/tty/tty_io.c:931: warning: Excess function parameter 'buf' description in 'tty_read'
 drivers/tty/tty_io.c:931: warning: Excess function parameter 'count' description in 'tty_read'
 drivers/tty/tty_io.c:931: warning: Excess function parameter 'ppos' description in 'tty_read'
 drivers/tty/tty_io.c:1115: warning: Function parameter or member 'iocb' not described in 'file_tty_write'
 drivers/tty/tty_io.c:1115: warning: Function parameter or member 'from' not described in 'file_tty_write'
 drivers/tty/tty_io.c:1115: warning: expecting prototype for tty_write(). Prototype was for file_tty_write() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
Cc: -- <julian@uhunix.uhcc.hawaii.edu>
Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
Cc: Bill Hawes <whawes@star.net>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.eu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_io.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8f9e89715a68e..defea9cc20ce9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -762,7 +762,7 @@ int tty_hung_up_p(struct file *filp)
 EXPORT_SYMBOL(tty_hung_up_p);
 
 /**
- *	stop_tty	-	propagate flow control
+ *	__stop_tty	-	propagate flow control
  *	@tty: tty to stop
  *
  *	Perform flow control to the driver. May be called
@@ -798,7 +798,7 @@ void stop_tty(struct tty_struct *tty)
 EXPORT_SYMBOL(stop_tty);
 
 /**
- *	start_tty	-	propagate flow control
+ *	__start_tty	-	propagate flow control
  *	@tty: tty to start
  *
  *	Start a tty that has been stopped if at all possible. If this
@@ -909,12 +909,8 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 }
 
 
-/**
+/*
  *	tty_read	-	read method for tty device files
- *	@file: pointer to tty file
- *	@buf: user buffer
- *	@count: size of user buffer
- *	@ppos: unused
  *
  *	Perform the read system call function on this terminal device. Checks
  *	for hung up devices before calling the line discipline method.
@@ -1093,12 +1089,9 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 }
 
 
-/**
+/*
  *	tty_write		-	write method for tty device file
  *	@file: tty file pointer
- *	@buf: user data to write
- *	@count: bytes to write
- *	@ppos: unused
  *
  *	Write data to a tty device via the line discipline.
  *
-- 
2.31.1

