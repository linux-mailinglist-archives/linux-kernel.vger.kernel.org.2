Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE64323B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhJRQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJRQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:22:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684BC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so1311824edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a8FvhaU3LoJd61Y7dd7nMTqRhhLF9T/evHMY4HHQ+s=;
        b=eH6QRPgTukPjQ4/AJR6IQGiVgYSotYIC8UHFV1SARhdx+dQmUB1hjmLDfMWx6RWi04
         8akRPiOp/d5JpV4NWKiXh8T23jwYruIzLiqwvw3/2b/uPdiTFQb5j6nH9EIyZm0Zr28l
         F7jWlWpREE0/fJr+XrKIa37hiXftKB+8znuUmNMcLE0tA5rqV84PngdwX+I27DVgbOtA
         KudyJ4+8RD50P6CoT47deD9GIe7TYgz58xB++IM6a1xYSwzckxlzXN0bSZ9GZHNSnaab
         G4LEgemt+ug7Lby5F5V/cTVtgKMbDaWFPnBmscrc5SKjODSjWqVrLNXx6PYzR3S0p3cY
         FWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a8FvhaU3LoJd61Y7dd7nMTqRhhLF9T/evHMY4HHQ+s=;
        b=nexn7h/mTNZnapn3h65FL/kRD2ytes7GPY+f0WetIC/1xQ8oUSLC7QhBiCCL9wJP5n
         qfhFaGKd+d5PmzMybTpJiatHcB6S+EUcE1ugXhBbMdZzSdjSPX4jz2zHosSx6ZhHakXY
         vbQXOWb1S+qeBlqxMURUHq/kTmfezuss2X6YM+HTaqcg5UzFlV/iw4Ac5gD3jLQtmYU5
         sl/M91Hg6HKrWM27T4GWHjISfqwDrhDF6GdeagomAo7O8l76W/F17ffUmcJZjnqrWhnO
         N0t9P0zA8OScKKXPkMQVwpSBhijNGHK3fRZgSyZNHvdlZBVCJuh9R8Z924pu/e6Ruemx
         1z8A==
X-Gm-Message-State: AOAM533I9SPvleynhmIk5i2SrA/F71RXwW5/9fSaCJet5eueGItm6TEf
        G13LkGXDs98OdbAFFuBQtFs=
X-Google-Smtp-Source: ABdhPJyWYYndXJUSND3rAO+YbNhcCnbZB5VJZp0qZf/K8hs99FaTi8rC+/qcyT1VRea7aff8mGuPJQ==
X-Received: by 2002:a17:907:9727:: with SMTP id jg39mr30912883ejc.271.1634574011852;
        Mon, 18 Oct 2021 09:20:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p7sm10045791edr.6.2021.10.18.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:20:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/3] staging: r8188eu: Use completions for signaling start / end kthread
Date:   Mon, 18 Oct 2021 18:20:04 +0200
Message-Id: <20211018162006.5527-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018162006.5527-1-fmdefrancesco@gmail.com>
References: <20211018162006.5527-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_cmd_thread() "up(s)" a semaphore twice, first to notify callers when
its execution is started and then to notify when it is about to end.

It makes the same semaphore go "up" twice in the same thread. This
construct makes Smatch to warn of duplicate "up(s)".

This thread uses interruptible semaphores where instead completions are
more suitable. For this purpose it calls an helper (_rtw_down_sema())
that returns values that are never checked. It may lead to bugs.

To address the above-mentioned issues, use two completions variables
instead of semaphores. Use the uninterruptible versions of
wake_for_completion*() because the interruptible / killable versions are
not necessary.

Tested with "ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]".

Acked-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 7 ++++---
 drivers/staging/r8188eu/include/rtw_cmd.h | 3 ++-
 drivers/staging/r8188eu/os_dep/os_intfs.c | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index b834fac41627..bdf0d0160070 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -23,7 +23,8 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 
 	sema_init(&pcmdpriv->cmd_queue_sema, 0);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
-	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
+	init_completion(&pcmdpriv->start_cmd_thread);
+	init_completion(&pcmdpriv->stop_cmd_thread);
 
 	rtw_init_queue(&pcmdpriv->cmd_queue);
 
@@ -246,7 +247,7 @@ int rtw_cmd_thread(void *context)
 	pcmdbuf = pcmdpriv->cmd_buf;
 
 	pcmdpriv->cmdthd_running = true;
-	up(&pcmdpriv->terminate_cmdthread_sema);
+	complete(&pcmdpriv->start_cmd_thread);
 
 	while (1) {
 		if (_rtw_down_sema(&pcmdpriv->cmd_queue_sema) == _FAIL)
@@ -327,7 +328,7 @@ int rtw_cmd_thread(void *context)
 		rtw_free_cmd_obj(pcmd);
 	} while (1);
 
-	up(&pcmdpriv->terminate_cmdthread_sema);
+	complete(&pcmdpriv->stop_cmd_thread);
 
 	thread_exit();
 }
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 83fbb922db2c..b6266e3e2c40 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -34,7 +34,8 @@ struct cmd_obj {
 
 struct cmd_priv {
 	struct semaphore cmd_queue_sema;
-	struct semaphore terminate_cmdthread_sema;
+	struct completion start_cmd_thread;
+	struct completion stop_cmd_thread;
 	struct __queue cmd_queue;
 	u8	cmd_seq;
 	u8	*cmd_buf;	/* shall be non-paged, and 4 bytes aligned */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index e7964a048c99..0bcea66f550b 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -385,7 +385,8 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 	if (IS_ERR(padapter->cmdThread))
 		_status = _FAIL;
 	else
-		_rtw_down_sema(&padapter->cmdpriv.terminate_cmdthread_sema); /* wait for cmd_thread to run */
+		/* wait for rtw_cmd_thread() to start running */
+		wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
 
 	return _status;
 }
@@ -395,7 +396,8 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 	/* Below is to termindate rtw_cmd_thread & event_thread... */
 	up(&padapter->cmdpriv.cmd_queue_sema);
 	if (padapter->cmdThread)
-		_rtw_down_sema(&padapter->cmdpriv.terminate_cmdthread_sema);
+		/* wait for rtw_cmd_thread() to stop running */
+		wait_for_completion(&padapter->cmdpriv.stop_cmd_thread);
 }
 
 static u8 rtw_init_default_value(struct adapter *padapter)
-- 
2.33.0

