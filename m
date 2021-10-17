Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41604309C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbhJQOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJQOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:30:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BAC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so60017306edj.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMkDUCm16/LUUgJOBcLWZuUN1/iLLBPOlfRNhPBC994=;
        b=eo/dNwDGp4mkCRYFmm0lB+TQl2xlpftB+kG4oiAzE3cmE5W1fW6RJZnvMCadCj32um
         oQrPiWsoWzY94aMwPuUa2L/os0dv/gInQKp8uz6ZhRgU4njn7E8PPxdgfhHe36mGaxOo
         gMWkWmQp8E6/iM7WHUvTX8DLq48LfRLeRaXmfEhyMRLo+wF5Qux9go+qPx45epBt3sqt
         5In6YCEtnRXOPWRWaznvOwUd9fphsqETrzrx/1H9beoZyDMGkETCgp4RUFXSUgzMSvPJ
         QFGnoMh3YYMonOkzweLeMws2QCCbdM5zuC95Sa8yOIGLFt/YEL7LOFa7uYt0LycqQZ1g
         d78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMkDUCm16/LUUgJOBcLWZuUN1/iLLBPOlfRNhPBC994=;
        b=7t0byHCD8gvzhW8n8sjeILzWv7dm55pZ8yT0d+UsB019hlFZiWk17h6vYyGoyjNKZl
         k8qQDvuuf5oX8LoQVaC5aP5C1Hx2ZMkat3Yh43EjXpyEfQKvi6cZQ8aZftQHlODcKpKW
         5l0LzjFLu0LqpmYLuWdS0oiPk+d1bkr7l8jI8ZLdTUwAywO+8hdsvyw8tUv1DbcTm9FE
         tRV/WmK/2bAVbB0WoOL1bkVtvh8duNyeMW6HQ9JHnD9DKzB9DKCVEbHhjIYinirOtipz
         TKcGPlSRP/IcB+gVw6ruobTKdLnWyIZuRlPxfaKhBRtQ6uVvFRVVmT9UilceZXalh2MR
         IckA==
X-Gm-Message-State: AOAM5325NxFB1xJ1WJ6OVJPEcsbfiF7x1GX/InH+NcvCEXObMH9tLfjX
        hipm/ImtAf4A88YLaN/hSOU=
X-Google-Smtp-Source: ABdhPJwkAcgWdpSD5YNV8E3AqEBp1s/4I09R6T/zSdp3T2sEMG7IZJTT3hXrgmRU4dbO1wA227YOwg==
X-Received: by 2002:a05:6402:32c:: with SMTP id q12mr32293708edw.378.1634480913885;
        Sun, 17 Oct 2021 07:28:33 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p23sm9094537edw.94.2021.10.17.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:28:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: Use completions for signaling enqueueing
Date:   Sun, 17 Oct 2021 16:28:11 +0200
Message-Id: <20211017142812.4656-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017142812.4656-1-fmdefrancesco@gmail.com>
References: <20211017142812.4656-1-fmdefrancesco@gmail.com>
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

Acked-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 7 +++----
 drivers/staging/r8188eu/include/rtw_cmd.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 195390449502..6fb79d711692 100644
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
 
@@ -252,8 +252,7 @@ int rtw_cmd_thread(void *context)
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

