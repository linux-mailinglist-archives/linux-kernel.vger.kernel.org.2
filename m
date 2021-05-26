Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C2391259
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEZIdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhEZIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:33:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B36C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:31:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so161229wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9K2ZcaJ0UvKBWGL+DeoaKZZOV/me504do+MmjS7kGQ=;
        b=P70uwTkXc4vT2c5pOT9UmXAbxVfDBayRnjnwKwb5i7xU93GCfNy57HkEeIDQDX9kyr
         oGV3731A637cYdMYRfYKRmso14jvlvYj2Hv2+JvBWrmC2f8g+Zvu8Z07NusMsWY3GPhc
         UKmwoOnj1kuWVpOi1yblzuJ09IedkNgv40hsi0IbNutDC+tUeoLExdQEkLkUw/yivu5X
         7AyciQWIxE6XD/2+z7F+tutFB0FiQnVj5DLOfvTB5a+Q0dk6wcOut7y1lJlSMlbDGK7/
         MNd4rgdmsA8VDeVVg1zxVlukBaMXeXhNfLO/NNjaEBd0LXxpxnVg48MMhrqz55ts+ajA
         tNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9K2ZcaJ0UvKBWGL+DeoaKZZOV/me504do+MmjS7kGQ=;
        b=DhCmdex0T8PWcb0PEiAdb0s1Io6IfTKdX0pRFJKOwVNOTCKFRISyufxPli6KfYwono
         BMOZdYBtZl+I4RANJGbvuNFF15FbrKnWtMiHk9X1LYM/OWhn4xeD+p6RkdFaAlErWM9i
         CE+4vUFc9gQWaC1ecL0DR8taXTH1ovQFMtX6MsxOnM++xa9fMMnrbN4GXNYzXKPKgZSJ
         uU5XlK71NzCWZOK7Nl2p7jYkSus8v+JaZN/hS8xvsWiW9XgJ5DYNZIVNlqMjXi/iX+3u
         IEAlplard3KCCdimYz7ZglNTc8QH5L4sva0JfsbafNCunU3yyMJSlntIzU/7mDMpwBv0
         DB0Q==
X-Gm-Message-State: AOAM532B8+lRoW9b2qvOgNY5jaT+IdxDUJBCoxlTwNf1qhIkPJufGyxF
        ISk9k8iQaV8ZCYeHcrkJ8ATbtw==
X-Google-Smtp-Source: ABdhPJyPsFXwbE1eTXxhQ/j5Y7oVhYsoZXPs/ZRPePhKsZQ/rDuz008HdVucTiMSLr9J9LdkFn9Rgw==
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr32015361wrz.165.1622017889499;
        Wed, 26 May 2021 01:31:29 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id r4sm237828wre.84.2021.05.26.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:31:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
Subject: [PATCH v2 1/1] tty: n_tty: Fix some misdocumented functions
Date:   Wed, 26 May 2021 09:31:25 +0100
Message-Id: <20210526083125.549626-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_tty.c:623: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
 drivers/tty/n_tty.c:1109: warning: expecting prototype for isig(). Prototype was for __isig() instead
 drivers/tty/n_tty.c:1268: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
 drivers/tty/n_tty.c:2132: warning: Excess function parameter 'buf' description in 'n_tty_read'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

v2: Rebased

 drivers/tty/n_tty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ec93f1a61f5d..56d3b43d8a3a4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -596,7 +596,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 }
 
 /**
- *	process_echoes	-	write pending echo characters
+ *	__process_echoes	-	write pending echo characters
  *	@tty: terminal device
  *
  *	Write previously buffered echo (and other ldisc-generated)
@@ -1092,7 +1092,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	isig		-	handle the ISIG optio
+ *	__isig		-	handle the ISIG optio
  *	@sig: signal
  *	@tty: terminal
  *
@@ -1248,7 +1248,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 }
 
 /**
- *	n_tty_receive_char	-	perform processing
+ *	n_tty_receive_char_special	-	perform processing
  *	@tty: terminal device
  *	@c: character
  *
@@ -2042,11 +2042,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
 }
 
 
-/**
+/*
  *	n_tty_read		-	read function for tty
  *	@tty: tty device
  *	@file: file object
- *	@buf: userspace buffer pointer
+ *	@kbuf: userspace buffer pointer
  *	@nr: size of I/O
  *
  *	Perform reads for the line discipline. We are guaranteed that the
-- 
2.31.1

