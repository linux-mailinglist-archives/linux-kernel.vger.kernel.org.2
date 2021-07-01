Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450A43B9145
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhGALoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhGALop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:44:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C03C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:42:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 67-20020a17090a0fc9b02901725ed49016so843423pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q38CLcv3Qc5/VnHmOJCGbwYCeyjT7BxLYBjG3lO8V8o=;
        b=nrTzjbXTJ583jwzSj7rquzxH5INOgxVWobYBAN17f6r5oUKwX7fYyMCxDV2tgb5rUm
         MT28YVfEYuUn1dXa6kzklWmNBGvJIdHlkYt+uTh1wo8be2RGDMODVYHzwEG+dABIhuQO
         6AFeNtAmNzZ6r+5oFzkmv0k68eIsBaT37zimSIl5M9e+IBWMVc+a2sruPas5Wp++hVqL
         03WKhtLyz9yk+OPuY8gKntUzdJtdof7nDSode/tf0gqkA/Ykvg4W7ruLTdlbv86kduYG
         loH/9W+J/eqcQpRjRK6p11NLAytVd1Q3Dk36xtbFTTLm4Qn/HvEpcdQH/QysxlbAzzUc
         el7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q38CLcv3Qc5/VnHmOJCGbwYCeyjT7BxLYBjG3lO8V8o=;
        b=p4mWArMNrFaeCnO32WC2Ov/0017AfWhpDbwuIcMvqajIqDaQtMYogHkQUxSHwer7Na
         5d1Te9ZuxwbvElYyT+yMBadH+UbucuWfeW7gC62fe3djaX+iKS1xQoguu/8m164LNadD
         ijAoE1xPa5B8JpRBWEaSogWEjxATZCmEG3U0orrscSJEIzn9mWHR3gP2UWHtjceyHJg5
         LJGVB0taLnOkDIGh0Vu4qE2HP2TRcRsIltZhjfC9pbQHY/uedwxCbDLYyVQIGQEJLXR3
         THSgwIWx1PpiAtfr5Ti80kDPpOwl13ohCA45ERC4Dz/5OiZUfWoIhThk6ZlhGmGV0xzU
         Gbwg==
X-Gm-Message-State: AOAM533cqvsTKC3s9E4v798lzMWWUIoui7HEfHstdmAvJeSYTm+xsdy2
        mHlkJuWWfme5qjzao3d0aWdZcdCmNdIU7g==
X-Google-Smtp-Source: ABdhPJwjPFc+IE8nAUCCt52J1ZCY4jdK5B4dlkXLqbHs/d8R0v9W64jaPedb1uQaZxDheHhf8R1qQA==
X-Received: by 2002:a17:90a:588b:: with SMTP id j11mr31801565pji.114.1625139734822;
        Thu, 01 Jul 2021 04:42:14 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z15sm27426787pgu.71.2021.07.01.04.42.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 04:42:14 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: n_gsm: delete DISC command frame as requester
Date:   Thu,  1 Jul 2021 19:42:03 +0800
Message-Id: <1625139723-23197-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it need to send DISC command ,as requester,there is
no need to send the DISC control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..1aa87d9 100644
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
@@ -3038,7 +3041,8 @@ static void gsmtty_hangup(struct tty_struct *tty)
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

