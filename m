Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9D38AF26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhETMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbhETMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBABC06137B
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2554396wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEzB7gTHrWqORyhx09JqRSjOeMlQtTq6ka3eRikoOfE=;
        b=UpZ/VNVYlGIKfLnk6k1JCdE8x5m4yriNk6bOFLJUi27MaZ5U58XCJxMMkW5pk4W610
         u1vvptZH3t5ElLh8HK4bw4oUmqoMC7+NJFcN5/LXW5YgI8L3ShaZU75veKqF+Q30EGn/
         192Vr2LqYY7ENIGzCSyEqQc2ivCCAoK4/54KRHTAKaqLEhP0a5bDPKIZEjmbF7oF/dYs
         OcaN8CODi8paulOEI+vOsNauam8fh+7p8KWNNQN60j4YILqSllsELiQAIV7VnIfH1dOz
         ZjG9yrdVnfUzzob2Mle4ytBv9PxXGcvu1b5AAtE1wSemalDLeMPLdOxB0D4IwHQLF+5T
         W9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEzB7gTHrWqORyhx09JqRSjOeMlQtTq6ka3eRikoOfE=;
        b=VLSQU4FU1m14GCUM+SDJNesmNx2/g661JzM7e9kbY4YNBCllHXNff+CatbuW+uXDxK
         gT1xYQ7uKOtun0YpptTJZvqEPIhy32g0Yc3s5K5lS+DR+PqyqBfuWA5XyB7Gixes9LEx
         ZslYluq/U2oHIeEvU3AEOI4RUjbbVF60YSuWAUYVp6N7sO1Rng4QOl7oqBDXARmbh25g
         spp6tfIxshR3mZ6mn8eyQPjirHQ1hLxFXcH6Ck09GNK/z9pjupQdY/KMTXow6/xB3cOT
         vti9ccsvBDU/T2FlWUjx1mt2e63VA8V4IgcOqLJhyuY6xy3hzfI4s4kKaBitAnCFvpDQ
         5ELQ==
X-Gm-Message-State: AOAM533F5Gb3kBI5IuHDiGelfPSZD8pVueVbIUQJ+A6qgLJyT1asVuOu
        Fj11BifxIN3hDpxqHc0lbWlWaw==
X-Google-Smtp-Source: ABdhPJwxSCl47cNJ5jARhlS0JP+KLmBAn01Z7e2l0gNQa53oThjb3H213j0NaozSwY6GNh8pIc7Hsg==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr3800044wmq.148.1621512841962;
        Thu, 20 May 2021 05:14:01 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dwmw2@infradead.org
Subject: [PATCH 06/16] char: applicom: Remove 3 unused variables 'ret' and 2 instances of 'byte_reset_it'
Date:   Thu, 20 May 2021 13:13:37 +0100
Message-Id: <20210520121347.3467794-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/applicom.c: In function ‘ac_register_board’:
 drivers/char/applicom.c:131:25: warning: variable ‘byte_reset_it’ set but not used [-Wunused-but-set-variable]
 drivers/char/applicom.c: In function ‘ac_read’:
 drivers/char/applicom.c:540:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/char/applicom.c: In function ‘ac_ioctl’:
 drivers/char/applicom.c:703:25: warning: variable ‘byte_reset_it’ set but not used [-Wunused-but-set-variable]

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dwmw2@infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/applicom.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index deb85a334c937..2d4ab42a986cb 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -128,8 +128,6 @@ static int dummy;	/* dev_id for request_irq() */
 static int ac_register_board(unsigned long physloc, void __iomem *loc, 
 		      unsigned char boardno)
 {
-	volatile unsigned char byte_reset_it;
-
 	if((readb(loc + CONF_END_TEST)     != 0x00) ||
 	   (readb(loc + CONF_END_TEST + 1) != 0x55) ||
 	   (readb(loc + CONF_END_TEST + 2) != 0xAA) ||
@@ -157,7 +155,7 @@ static int ac_register_board(unsigned long physloc, void __iomem *loc,
 	apbs[boardno].RamIO = loc;
 	init_waitqueue_head(&apbs[boardno].FlagSleepSend);
 	spin_lock_init(&apbs[boardno].mutex);
-	byte_reset_it = readb(loc + RAM_IT_TO_PC);
+	readb(loc + RAM_IT_TO_PC);
 
 	numboards++;
 	return boardno + 1;
@@ -537,7 +535,6 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 	unsigned long flags;
 	unsigned int i;
 	unsigned char tmp;
-	int ret = 0;
 	DECLARE_WAITQUEUE(wait, current);
 #ifdef DEBUG
 	int loopcount=0;
@@ -568,7 +565,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 
 				/* Got a packet for us */
 				memset(&st_loc, 0, sizeof(st_loc));
-				ret = do_ac_read(i, buf, &st_loc, &mailbox);
+				do_ac_read(i, buf, &st_loc, &mailbox);
 				spin_unlock_irqrestore(&apbs[i].mutex, flags);
 				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&FlagSleepRec, &wait);
@@ -700,7 +697,6 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	void __iomem *pmem;
 	int ret = 0;
 	static int warncount = 10;
-	volatile unsigned char byte_reset_it;
 	struct st_ram_io *adgl;
 	void __user *argp = (void __user *)arg;
 
@@ -762,7 +758,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		
 		for (i = 0; i < MAX_BOARD; i++) {
 			if (apbs[i].RamIO) {
-				byte_reset_it = readb(apbs[i].RamIO + RAM_IT_TO_PC);
+				readb(apbs[i].RamIO + RAM_IT_TO_PC);
 			}
 		}
 		break;
-- 
2.31.1

