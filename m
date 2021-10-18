Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCD4323B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhJRQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhJRQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:22:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0808C061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so1096705edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfDWDFeFGdgMNaeAlke/qLDYd5627lfl/99SW8lb31M=;
        b=HUJhR5sNHN7Lf8SrLlhjko+hMTXYzj+Ze63SxuBIkeKPP1pOE+W5DZINNvaAHZHn98
         guViZl9wHeOzZH3ZQ/aTbL4VLIHx2tr4ra+uZBI742UHJrrpUZw/ihVo56P7prF9fkiL
         kmpuxW6qpzb0kY9PEOlqHojQhxOqk7h7BhdvlistUd+Q2Uc/54iUgzGO+ON3tbj4VuuL
         ZEfgpV8+fwnai6N8tc1qkVz5Lj4IDIzPt40eeXJiJerGJ9XJ0fumCYlKUs6tctP03HGC
         YssnNIUWFCd0O1Zvqin6XTL+10KhRW+OUef0iCXjc9xsBwkKOHyscfuBV+cClCWMbgXx
         0jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfDWDFeFGdgMNaeAlke/qLDYd5627lfl/99SW8lb31M=;
        b=HNPhpuD1KoKRQ3LJvle6uSzU5VflSDAjJff8m+EakK3zzXW9p1bGzlhih6QJGEqKOq
         PtbH6r2hq8hs1XgXYuZmKD2QjnOZdYVN/eagmammmiQPsHmgi+TjpTcmU/5F/0JdE/cH
         8e0QjS1w5u0nUM8sAfGn2e25p474lwYXGxi8JVnBDzCmb2juDAmEPaX7i1HoY5P5AUiW
         qLJliPHMQlRcc3qlEPYMRjkpvJzmTfrBHWobxQo4HCsqvFXN9vQ+4BNZ7rKi+JRfOX5w
         hysimbDUt5qwY/fnq4kNEb3Hz0aO9eQA7Fhhj4zQbw9HtqX1I53BcUrQmfz8jHW4fqYF
         glSA==
X-Gm-Message-State: AOAM533kEP0fslTlJjkXmzCG/d5GYbTJ0TM4Ym1VsQp3u0NjvgDgg8yI
        a5anVc6FS18gaKJCr8bQvPA=
X-Google-Smtp-Source: ABdhPJyshXgYjnNcEYwVb/JeHOD4oq2wETO7bA7IiR6MPsRzpn4yE8Rzxi84G0JU++t0jXwFtYX4jw==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr17870365ejc.440.1634574013135;
        Mon, 18 Oct 2021 09:20:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p7sm10045791edr.6.2021.10.18.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:20:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 2/3] staging: r8188eu: Use completions for signaling enqueueing
Date:   Mon, 18 Oct 2021 18:20:05 +0200
Message-Id: <20211018162006.5527-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018162006.5527-1-fmdefrancesco@gmail.com>
References: <20211018162006.5527-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_enqueue_cmd() uses a semaphore to notify rtw_cmd_thread() that it
has enqueued commands. rtw_cmd_thread() "down(s)" in interruptible mode
to wait to be notified.

Use completion variables because they are better suited for the purpose.

In rtw_cmd_thread(), wait in uninterruptible mode, even if the original
code uses down_interruptible(), because the interruption of
rtw_cmd_thread() is not allowed and unwanted.

Tested with "ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]".

Acked-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 7 +++----
 drivers/staging/r8188eu/include/rtw_cmd.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index bdf0d0160070..3b07328704bb 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -21,7 +21,7 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	int res = _SUCCESS;
 
-	sema_init(&pcmdpriv->cmd_queue_sema, 0);
+	init_completion(&pcmdpriv->enqueue_cmd);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	init_completion(&pcmdpriv->start_cmd_thread);
 	init_completion(&pcmdpriv->stop_cmd_thread);
@@ -198,7 +198,7 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	res = _rtw_enqueue_cmd(&pcmdpriv->cmd_queue, cmd_obj);
 
 	if (res == _SUCCESS)
-		up(&pcmdpriv->cmd_queue_sema);
+		complete(&pcmdpriv->enqueue_cmd);
 
 exit:
 
@@ -250,8 +250,7 @@ int rtw_cmd_thread(void *context)
 	complete(&pcmdpriv->start_cmd_thread);
 
 	while (1) {
-		if (_rtw_down_sema(&pcmdpriv->cmd_queue_sema) == _FAIL)
-			break;
+		wait_for_completion(&pcmdpriv->enqueue_cmd);
 
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index b6266e3e2c40..47c3c80cc24a 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -33,7 +33,7 @@ struct cmd_obj {
 };
 
 struct cmd_priv {
-	struct semaphore cmd_queue_sema;
+	struct completion enqueue_cmd;
 	struct completion start_cmd_thread;
 	struct completion stop_cmd_thread;
 	struct __queue cmd_queue;
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 0bcea66f550b..96e9897085fe 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -394,7 +394,7 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
 void rtw_stop_drv_threads(struct adapter *padapter)
 {
 	/* Below is to termindate rtw_cmd_thread & event_thread... */
-	up(&padapter->cmdpriv.cmd_queue_sema);
+	complete(&padapter->cmdpriv.enqueue_cmd);
 	if (padapter->cmdThread)
 		/* wait for rtw_cmd_thread() to stop running */
 		wait_for_completion(&padapter->cmdpriv.stop_cmd_thread);
-- 
2.33.0

