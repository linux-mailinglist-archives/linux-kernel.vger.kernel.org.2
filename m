Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6976B35C2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhDLJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbhDLJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:34:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC1C06136E;
        Mon, 12 Apr 2021 02:31:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h25so8919962pgm.3;
        Mon, 12 Apr 2021 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hnbI4HTxy5h+9wDfXPCcQHa6zzBSTTZbMcq2PaN8c1I=;
        b=HtwrWWFDbFwS9xUN3hU5q5cxt7V3HjRLojvzWMaJ/+Q7zxE0hWxz4n1PDmChYQ/EMq
         Ak3U1MP/lV0CYn9AmEqHZz+ifgkH6I6+/QmhECchXang6IFWQAEHW9A6hD7hagYiMEz4
         H/kK3/agJLcFRlFvNxuYtb9f/xIjVG1zuPoLQ4rMOmw4QWNCSu6I3BWtAO9Dlj8WKL6i
         Co3WFHvM9aygZHnLFYSrk0+EqAdDReQa210+u9fTjB4qfHYT1hB6rb5M7LqBjuj7O1oH
         ZYfP6CC3uCwx2zqZFM5zEWg3FfKqKfRehj1eQNcK8hf4ymWvRwSMr9xzt6ulIU9gqIuD
         seSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hnbI4HTxy5h+9wDfXPCcQHa6zzBSTTZbMcq2PaN8c1I=;
        b=HFyEMf116ARbD/I66f7ex4ah76o6YHjwkhCVMWEAntIzFTf78Nq/M65/eRqNXfeKKP
         pgRvgyrs8JHAl9vfEFnibZXts3tilB3j1r+XelXJR1lJ+A/ff/4PtE9Rx6r6Wb+1u3ru
         Jp2+AodNKvqfZvmGi2p9Ta+pXlFmmz5ND9ZC9Y5rIvx3+SsYTOL2IOTaOJAcf4ATKO8R
         OT3NL5pSPufRH7Op/Me7oLNtGlkSYRhcXBmhUW/ae9rRUSvNfuPFHkbbKHUQHHXvv0on
         GjH9qQAL18/xzmbq9Gtg1sDefG0pSCJavIQaOaK2faOiStmBpw0xgo61vdrlTKM59dU/
         pmsw==
X-Gm-Message-State: AOAM533crW5lZP5ZOAClVzLj+m+jROE1T2LI4Zw6yZUEVQl4kQsQnHCz
        cOCK+eh3l9f5hSWvbCPyNGc=
X-Google-Smtp-Source: ABdhPJwrTzAtgMMxUCRMcseHM+9n719hVrbqnEqDcTiqRlECpevvVYQUFcWEy8URy2tQJXlZxa0hxg==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr9891189pgt.236.1618219904290;
        Mon, 12 Apr 2021 02:31:44 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id r6sm10511879pgp.64.2021.04.12.02.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 02:31:43 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        lkp@intel.com
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        dillon min <dillon.minfei@gmail.com>,
        Gerald Baeza <gerald.baeza@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>
Subject: [PATCH v2] serial: stm32: optimize spin lock usage
Date:   Mon, 12 Apr 2021 17:31:38 +0800
Message-Id: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To avoid potential deadlock in spin_lock usage, use spin_lock_irqsave,
spin_trylock_irqsave(), spin_unlock_irqrestore() in process context.

remove unused local_irq_save/restore call.

Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Gerald Baeza <gerald.baeza@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2: remove unused code from stm32_usart_threaded_interrupt() according from
    Greg's review.

 drivers/tty/serial/stm32-usart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index b3675cf25a69..b1ba5e36e36e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1354,13 +1354,12 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	u32 old_cr1, new_cr1;
 	int locked = 1;
 
-	local_irq_save(flags);
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
@@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int stm32_usart_console_setup(struct console *co, char *options)
-- 
2.7.4

