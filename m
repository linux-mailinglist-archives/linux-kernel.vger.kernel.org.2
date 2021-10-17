Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E44309C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343877AbhJQOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbhJQOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:30:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53704C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so29587229edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Njyk3f9AJQy4o4xJEQKzkirW5yDLSwZCU8SS23ozgfo=;
        b=gTSHXlJ17C8ju6urUNynQIaEhra0CLIUbqtM9z2qA+FMU6lpukqZLB39YXutSEGuo+
         SErLzHDUQRqF9/lrB/+bb3yU5+Dcm+x22GKIdcg0OQXAbv6FrV92irJo5LeZ0jvVPOzQ
         y+10Rppwv8zSnlpqtHMLwDNnUgRXHSD8PBHR5dcCAJgdWIvrLlieR/0PqgXKePb3DzWH
         bkBbBSOwxWQ0O7TRLf3QgjxHFf3zfKDZi7MjZiq7MQbEJ85HpPKlIFXBDsChlQ4ZVEkp
         BBYzIlMTBRf9/24dIzuXMtgxep4IaZmmxSuHJs8UcYdYj40jKZ+CZhYd/YeVmADoBD+B
         /m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Njyk3f9AJQy4o4xJEQKzkirW5yDLSwZCU8SS23ozgfo=;
        b=c+pme9rb5nfMHUJ+AkXtxXyKfNopvyCMFZTEwOPYL8ks0ZbT2tFJOQsKtN2LUfw7af
         uLzTjCGJBqA6ASP4uYVu831L4DqeGhjjxrgHlXS0bOI4fExLzVO1LgpWwhFWTCz4C7ot
         mHSfFdhVguFJqrK+LUc5DPVkxXiWM2owtVydfzGyzcaHeN3YGYyIG3tkhAcuXZf3OQfJ
         xF2ZWFNDNi8/Fvly7gSmgbk5lq4N2eXJ9ZG1tsoWOxlPLqQ5SZAq1vX9kotUdDOgSHNw
         fqsCO3UgTCKxtWhrRHZa55/tMKdJiE3L9w4BeI/9ROtmoeO4nz3UqUUq591XJVDbmuYr
         Wlnw==
X-Gm-Message-State: AOAM530tmfCP7fNXCLcr0ptANtUKppeJLxfiJWE/mlZZkdc9PMLdvytK
        oag/TSKeLLWEuY+UcmxZcEc=
X-Google-Smtp-Source: ABdhPJwjRC4gkNnzjDUJgF76uMVc+kFFkb54jRIySN99gb+OHVjq8FMhihkJBnIhaRRY6Qd/4wlbpg==
X-Received: by 2002:a17:907:96a3:: with SMTP id hd35mr22759955ejc.222.1634480912654;
        Sun, 17 Oct 2021 07:28:32 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p23sm9094537edw.94.2021.10.17.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:28:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/3] staging: r8188eu: Use completions for signaling start / end kthread
Date:   Sun, 17 Oct 2021 16:28:10 +0200
Message-Id: <20211017142812.4656-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017142812.4656-1-fmdefrancesco@gmail.com>
References: <20211017142812.4656-1-fmdefrancesco@gmail.com>
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
index e17332677daa..195390449502 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -23,7 +23,8 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 
 	sema_init(&pcmdpriv->cmd_queue_sema, 0);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
-	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
+	init_completion(&pcmdpriv->start_cmd_thread);
+	init_completion(&pcmdpriv->stop_cmd_thread);
 
 	rtw_init_queue(&pcmdpriv->cmd_queue);
 
@@ -248,7 +249,7 @@ int rtw_cmd_thread(void *context)
 	pcmdbuf = pcmdpriv->cmd_buf;
 
 	pcmdpriv->cmdthd_running = true;
-	up(&pcmdpriv->terminate_cmdthread_sema);
+	complete(&pcmdpriv->start_cmd_thread);
 
 	while (1) {
 		if (_rtw_down_sema(&pcmdpriv->cmd_queue_sema) == _FAIL)
@@ -329,7 +330,7 @@ int rtw_cmd_thread(void *context)
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

