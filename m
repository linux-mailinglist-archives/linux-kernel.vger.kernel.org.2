Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE8398636
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhFBKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhFBKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C4C061763
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so1736086wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpdMnI6lZJkCsy5Zu72i+Sr+X0vOIx3MmORUdfJ8hyo=;
        b=qo69oY96cVUgH8CpEF59JQYnnYv8mujBkgwt6mI0UM9Ft4rpPiJVpF3/ba9d0F/VWp
         L9FyXSWm1qMTX5tTrEYMOVMoSnt7amQatRyAXHjUrb+Fo0zLT/SkHNEjSVL5CLbo0cwu
         sM94BJzV5T+oXjhDiLZJMmZVUy+9XpegtpAl0AkDWJewnPL6kGFDxX3NBb127iv1JbF6
         depeUZtcFTTJIl1UvHaBEMQnMhbJURuxwlMt+1tCBXKpuYVBInsqz17O2ThoNFiGmtP9
         TosOsEmGLtJ+TEHCtLSJg1rbTa/x3cf2Dl2pwpLsbzHYylMToTjlOWt5qMVdHwJ6pWJ9
         DkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpdMnI6lZJkCsy5Zu72i+Sr+X0vOIx3MmORUdfJ8hyo=;
        b=EZe4nYmm3pWxyqUwv8xZKxnX51wm/WA77vu7hvhMHKYZc5FU/7d3P0KTbP85MPYkC9
         OsO749EpZyxIBej4X1LVmjQuu560w5V9n8X2Wii1sxbjJ9WXEHUvoLvUU8BOH5eI46TI
         1sWXObYX5Pnk87ELIbxUyKfQ1ljnZz917zjt3qT57T+biiRibK/3JN4kepT7EshpoWQE
         VN5mvq3JPdp3enHkJBf7irhQBDoWcnZMChRrv9+VTpUa2lf9Nmn4ByWmxu6eVIeeoWLX
         3Fnq8s5W5Bj5GNRW/HkMKobqnV7VyiInuJeYbp3ArscVMjsMbtb7+eMw1w+3FAro18SK
         bH7g==
X-Gm-Message-State: AOAM532kPrv5CqcCSetF3WvkoAOjUOvzOuSq3z14RJ558F5p0MofuhhO
        EJw+Qf4GA6SCYxq3zDKVn8F0iOpIHbJ/HA==
X-Google-Smtp-Source: ABdhPJyqhVwJ6SErn3vAKpl//MuZ6EJt1iRS2OS+xAv6VopJ6veIdjnTf69oRlL5y6+EI+yzQuWlgw==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr33511361wrr.248.1622629057868;
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 04/21] ide: ide-io: Fix a few kernel-doc misdemeanours
Date:   Wed,  2 Jun 2021 11:17:05 +0100
Message-Id: <20210602101722.2276638-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-io.c:268: warning: expecting prototype for execute_drive_command(). Prototype was for execute_drive_cmd() instead
 drivers/ide/ide-io.c:320: warning: Function parameter or member 'drive' not described in 'start_request'
 drivers/ide/ide-io.c:320: warning: Function parameter or member 'rq' not described in 'start_request'
 drivers/ide/ide-io.c:618: warning: Function parameter or member 't' not described in 'ide_timer_expiry'
 drivers/ide/ide-io.c:618: warning: Excess function parameter 'data' description in 'ide_timer_expiry'
 drivers/ide/ide-io.c:775: warning: Excess function parameter 'regs' description in 'ide_intr'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 4867b67b60d69..bd3e78985bcc7 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -252,7 +252,7 @@ void ide_init_sg_cmd(struct ide_cmd *cmd, unsigned int nr_bytes)
 EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
 
 /**
- *	execute_drive_command	-	issue special drive command
+ *	execute_drive_cmd	-	issue special drive command
  *	@drive: the drive to issue the command on
  *	@rq: the request structure holding the command
  *
@@ -309,6 +309,8 @@ static ide_startstop_t ide_special_rq(ide_drive_t *drive, struct request *rq)
 
 /**
  *	start_request	-	start of I/O and command issuing for IDE
+ *	@drive: the drive to issue the command on
+ *	@rq: the request structure holding the command
  *
  *	start_request() initiates handling of a new I/O request. It
  *	accepts commands and I/O (read/write) requests.
@@ -602,7 +604,7 @@ static int drive_is_ready(ide_drive_t *drive)
 
 /**
  *	ide_timer_expiry	-	handle lack of an IDE interrupt
- *	@data: timer callback magic (hwif)
+ *	@t: timer callback magic (hwif)
  *
  *	An IDE command has timed out before the expected drive return
  *	occurred. At this point we attempt to clean up the current
@@ -748,9 +750,7 @@ static void unexpected_intr(int irq, ide_hwif_t *hwif)
 
 /**
  *	ide_intr	-	default IDE interrupt handler
- *	@irq: interrupt number
  *	@dev_id: hwif
- *	@regs: unused weirdness from the kernel irq layer
  *
  *	This is the default IRQ handler for the IDE layer. You should
  *	not need to override it. If you do be aware it is subtle in
-- 
2.31.1

