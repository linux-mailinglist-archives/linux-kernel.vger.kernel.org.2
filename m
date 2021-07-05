Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFC3BB527
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGECbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 22:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGECa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 22:30:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E69C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 19:28:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso10641341pjx.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 19:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AE+ZaDsZOY/6RJQa01DMCt5X83pmNsyIgZ8cL0q4kcU=;
        b=ptFwdY+QE9Q2Fs4pdQrSLNmhhiK7ix8K2eiaV1ArfSjvxpc6iiWe53ct+WPS071DVO
         +rv98M0FhRvaA4jT98AFzskzYK2CZuIp9gLf3JfpZ2ganlmLyxUxgulb4E0+WMk9w/FY
         FvouV+9tdk5mWBlGJKH3whnbVNciHJ8OXseBxOaY12a953oHiXU8rnISJvRp6iUcPRHs
         i77kxyjDI+ZJtI39UD23EOKry0vPgPj7oxT749FBUMC2MmVjBbqqkiKXxECMk0i9uJr7
         0U7sU2P2j4fniaM6mCZhbQMqxSVR7/TdlqYCY0QyQ0FiPLsA/QKE9mgjkNBdMzIyBELm
         bNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AE+ZaDsZOY/6RJQa01DMCt5X83pmNsyIgZ8cL0q4kcU=;
        b=BvtpEoCvbIInaxfKsIZE17090M/zjFsQn6ds55A5w5UEWmeDrNmbPURYqvhYubb0uP
         bAbXntYKfUePae8Q2YJdylgS/IKp0GWjl4NnLDzUluA9r8jHJFU0YgX4PeDe69tBLuGi
         uyY+6oWorh5kpnhmd7etC4F6UfvbwdKrdF2V4ATLLOGNYxsQlhPd0ju6Itzithz6suf7
         AYxnQ1fOH7skArBoKpQ57NNJFv+VJH8PjHsOD0YjMBWtbGgCMTgvZHFDjrW7cTp0DxYg
         Nv/xsPowGxbNuUxhX54aUVcJlQik7boY4FzxxRbqJe6cUHOEeZmAHNFfN0rMZUff0QYI
         lOQw==
X-Gm-Message-State: AOAM531I61Qj65fcwFUzwRBVVMUMZilye3iwdFcxVCqF6zIFjKMdlclA
        iKknibrAM4Kix5YEidscI7o=
X-Google-Smtp-Source: ABdhPJy/QgiNAbZf728UfcoR0blWQR6E3M0O/x/OHxmZDsYwT+m2VX7u3rEeCC3FHt1IX6sJG97gAQ==
X-Received: by 2002:a17:903:2452:b029:129:33a0:399d with SMTP id l18-20020a1709032452b029012933a0399dmr10642987pls.31.1625452100043;
        Sun, 04 Jul 2021 19:28:20 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm10921614pfi.179.2021.07.04.19.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jul 2021 19:28:19 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: n_gsm: delete DISC command frame as requester
Date:   Mon,  5 Jul 2021 10:28:07 +0800
Message-Id: <1625452087-12655-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it need to send DISC command ,as requester,there is
no need to send the DISC control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..f8e5935 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2050,7 +2050,8 @@ static int gsm_disconnect(struct gsm_mux *gsm)
 	del_timer_sync(&gsm->t2_timer);
 	/* Now we are sure T2 has stopped */
 
-	gsm_dlci_begin_close(dlci);
+	if (gsm->initiator)
+		gsm_dlci_begin_close(dlci);
 	wait_event_interruptible(gsm->event,
 				dlci->state == DLCI_CLOSED);
 
@@ -3014,6 +3015,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+	struct gsm_mux *gsm = dlci->gsm;
 
 	if (dlci == NULL)
 		return;
@@ -3024,7 +3026,8 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&dlci->mutex);
 	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
 		return;
-	gsm_dlci_begin_close(dlci);
+	if (gsm->initiator)
+		gsm_dlci_begin_close(dlci);
 	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(&dlci->port);
 	tty_port_close_end(&dlci->port, tty);
@@ -3035,10 +3038,12 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 static void gsmtty_hangup(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+	struct gsm_mux *gsm = dlci->gsm;
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	tty_port_hangup(&dlci->port);
-	gsm_dlci_begin_close(dlci);
+	if (gsm->initiator)
+		gsm_dlci_begin_close(dlci);
 }
 
 static int gsmtty_write(struct tty_struct *tty, const unsigned char *buf,
-- 
1.9.1

