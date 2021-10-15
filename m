Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3642EF40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhJOLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbhJOLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:05:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37871C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:03:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d3so36427657edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6vSL2TaHk4f5VyyfBBfiPqOex1pQv9XVqbuGM1Nzks=;
        b=dlQ5ko2tTQ+2yjfKscMdxyLodnebmkVd6Naj22fr9hTrqt4vSpXBJDCbTmuk6px7M2
         oimLiTVr1nPm/9REJzy5pF4vE9c0YMzAweXVlB7tecdJfZzHTMN//mzhckl1RUlIssqP
         mft5exblCl3z8HyS1zIkej+FBmfn3rjsp363QFvkmod7oA/XabTy80QdgbIyVox1Nf9V
         gp3RkXiq3c2x4ctwR9PFh3BxLnKOsgoLgVUzvfRUu2Ldsh6/MlVkP26I4kqQFZV7M8lX
         admTbuYxyq0JMYYIHOtn9OKyqt9t7hGYsiX7KF7s+ofto49X9K8ql7c4fvLuHEhA5ssx
         Vgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6vSL2TaHk4f5VyyfBBfiPqOex1pQv9XVqbuGM1Nzks=;
        b=WuvlbR8L6+S4iCcl6L9zc+aeidDCmVM94sDYHLV6DmPYTyKNmcxzMDHOkkaTB1F6E+
         wuVO0m65eeSoN7Pj7eijH8jUNsgq/1dkGuQ8dwwIMyA/1pOM0FKDxcXj03oHXoEDEsfO
         usk4Mq1w1auCbszc1FfALRv8OX7gHQVAfdACw1EU76VuN418HBDMiCKHI2J7R+4nNjNk
         tUbrCljQJiH32iLWRbdeDsPki2i8DktiukCFNHs6ZtfXfiRYmFZtu75ECGKMjviIV0u2
         +fF+JivY5mmZwmDWDFkvKm8mY5osW3KtvaAAQSxcPhWAz4qEDKkBKDwTOr+sHhTt3wDP
         RR0A==
X-Gm-Message-State: AOAM5324HtxTowbPT0IR2hzHxwCe6bxWflTIDjT3TNzdsithnm9wBtcJ
        jvrGKyPXzZ5P3ToD2iqNKpA=
X-Google-Smtp-Source: ABdhPJw8gN9YmA+pXpY97vQOGFgMkgRDQAM4cpLGl9OpQPUGd+lXQ3BP8hRHGFU5dAxRgoWRkwpr4g==
X-Received: by 2002:a05:6402:5187:: with SMTP id q7mr16619531edd.374.1634295780348;
        Fri, 15 Oct 2021 04:03:00 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id w11sm4477283edl.87.2021.10.15.04.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:02:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH] staging: r8188eu: Use completions instead of semaphores
Date:   Fri, 15 Oct 2021 13:02:38 +0200
Message-Id: <20211015110238.1819-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
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

This is an RFC patch because I'm not sure that changing this code
from using semaphores to using completions variables is actually required.
After all, the code was working properly with semaphores and, at the same
time, I'm not sure if the Smatch warning about duplicate "up(s)" should
actually be addressed.

I'm waiting for Maintainers and other Reviewers to say if this patch is
actually needed and, if so, also for suggestions about how to improve
it. In particular I'm interested to know what they think of using the
uninterruptible version of wait_for_completion*().

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

