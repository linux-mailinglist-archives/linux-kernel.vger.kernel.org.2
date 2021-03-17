Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFA33EC76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCQJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhCQJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g8so1013219wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kpxpj9RY3Tz1buvtlliu/SfUSZOzhZdJwGgmrjmjL4c=;
        b=ENZefxfvp2SbLaisye3tgbpbWWpQrCXHaTbdFnQ7jF7oVLFWuLPED510b4pzbTPx6T
         qJ5UbDkPqrEpjwDmL0+UAsVELrgLAvENpJPTWWlfYh2eQlxjTRuPukX5GWJKNpEghVUT
         W4Q1LEGGpAYTMeQkwi1t1LW6I/GWJB5BSOfowD1op7cj4/CdhHZTn1iAR+CMfkBYyT6s
         GbNmu/FnHvKkj+bOPh3PZKlJ2/C7BtTB5lvFL0si86sLj3r33gFpxhMQAAL+DuV/6OsL
         6EYXH8JojSR2IBU8VJro4y67zxHzg5ab2q9OSE56Z8HtpjPSKA4x/mhmRZ8zpOeY7Ly1
         befw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kpxpj9RY3Tz1buvtlliu/SfUSZOzhZdJwGgmrjmjL4c=;
        b=cQsZuDnqSMfgYY50965DmLEiG2nc+uXwKF2REzYUQ6RhevQspNXfAjYWzqJqflX37J
         sP3nzGctQ5pTWFF0Idtdbm7FbbUfG5VyE9z83+oXky0DeE7hURyhaqrN/er7cV/ET7il
         9RLb9ZC+L4g8LuPuwgBJChQ2WYe2BS+kqLZpMdgVn4ZZSosDAVoPB2H+goepGIurf9XS
         XFF22ZStpqpq7fEvAhxTGWOYl1/+J1Vn5RfeDKwYs/TyG0qkoN5UsS888l0vYbRUKxnP
         oCYLRRvXJ8uUt8ytjDotAsoolo3nERyB9zHcYlCnRn7cMjMKkfBqbyMavJyXMgqxAc9O
         /cRw==
X-Gm-Message-State: AOAM531gPfDVm1mZRR7J2pfrIgeQXDwHUlETevdb61c1I8j4GCt0UiOa
        WF+G3HFLdrcQqWwBdsHb3thoeg==
X-Google-Smtp-Source: ABdhPJzZkiEitRE+GZC9nr/Ly46A/COTSQRSLSiOZArjHnJgIdgU28VIcHakoCp3CXIHDbEsxPBJCg==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr2675160wmj.109.1615972371169;
        Wed, 17 Mar 2021 02:12:51 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org
Subject: [PATCH 11/36] scsi: a100u2w: Fix some misnaming and formatting issues
Date:   Wed, 17 Mar 2021 09:12:05 +0000
Message-Id: <20210317091230.2912389-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/a100u2w.c:278: warning: expecting prototype for orc_exec_sb(). Prototype was for orc_exec_scb() instead
 drivers/scsi/a100u2w.c:596: warning: Function parameter or member 'target' not described in 'orc_device_reset'
 drivers/scsi/a100u2w.c:739: warning: Function parameter or member 'host' not described in 'orchid_abort_scb'
 drivers/scsi/a100u2w.c:739: warning: Function parameter or member 'scb' not described in 'orchid_abort_scb'
 drivers/scsi/a100u2w.c:915: warning: expecting prototype for inia100_queue(). Prototype was for inia100_queue_lck() instead

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/a100u2w.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index c99224a128f82..c9ed210d77b39 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -269,7 +269,7 @@ static u8 orc_nv_read(struct orc_host * host, u8 address, u8 *ptr)
 }
 
 /**
- *	orc_exec_sb		-	Queue an SCB with the HA
+ *	orc_exec_scb		-	Queue an SCB with the HA
  *	@host: host adapter the SCB belongs to
  *	@scb: SCB to queue for execution
  */
@@ -586,7 +586,7 @@ static int orc_reset_scsi_bus(struct orc_host * host)
  *	orc_device_reset	-	device reset handler
  *	@host: host to reset
  *	@cmd: command causing the reset
- *	@target; target device
+ *	@target: target device
  *
  *	Reset registers, reset a hanging bus and kill active and disconnected
  *	commands for target w/o soft reset
@@ -727,7 +727,7 @@ static void orc_release_scb(struct orc_host *host, struct orc_scb *scb)
 	spin_unlock_irqrestore(&(host->allocation_lock), flags);
 }
 
-/**
+/*
  *	orchid_abort_scb	-	abort a command
  *
  *	Abort a queued command that has been passed to the firmware layer
@@ -902,7 +902,7 @@ static int inia100_build_scb(struct orc_host * host, struct orc_scb * scb, struc
 }
 
 /**
- *	inia100_queue		-	queue command with host
+ *	inia100_queue_lck		-	queue command with host
  *	@cmd: Command block
  *	@done: Completion function
  *
-- 
2.27.0

