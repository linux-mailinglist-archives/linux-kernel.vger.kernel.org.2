Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82E13BBC89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhGEMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhGEMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:02:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85219C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:59:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b12so15393493pfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l/KzdgfsHTBGCwQ+xgOiOYGUYS3BWCzkmqNVoPjohio=;
        b=N8h52w/FikBbwqyeY8qfQHcahexbfZwwOL261Iy9SFz2ugfqsOoRFvcOK3VhNHNHJ3
         5GwGlzpQ3jHWUsogYIgiaOQdogu5K+aav4RAwaTQ3IIB7cOd+9SJ4gBpyrhwes8NrC7x
         mmtmKSHTUe20Y+OTTLKdqzxu7uhqj+29GPcoUlJHO0k5/jLSkXKaDVAtx2A5qyq6pOJg
         9uUc+ySVYdesGf54weX001dcrLwsMnhGLwRiESGlofp6mPlRVRb4XLGGUb+GP5sRi8tq
         NtQIsCONvxMcs6677Vk9nAUhAtkjahqtDBdGNW6GwI80SKscWjzW5ZLWfkyFEadqq1KF
         Ui1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l/KzdgfsHTBGCwQ+xgOiOYGUYS3BWCzkmqNVoPjohio=;
        b=kxAoANWn+fkDbATUJ73Pv7o6eMTch+IdcHUdgmWUMcLGHSOuyOHizI7DPy+WyT9cfy
         V2XKHbEZ7RCY0s2qSO3ieRmsd6GLnOr2ekZkcVdBa/DO++tSTqoojrnYCMiX00bS/OG0
         T3b1Zl1ytFpydZZR/uIZz2C35ozEPMnJi405yDqqVMMFSyddCDNdbegHTkzWYbQtwZHj
         IIDkP3JwMX9KZNW31e71PbBAgEPehloOGXRbPNMWNmu58iza32r2NeHQxZrKdfgf64cJ
         J61Z0ApaDSK8Me6NgIWO1k9MsyK65FAa/D6iShdiXo2SpleTTHz7rvsgV3LWJX6Qk3Rv
         mXDA==
X-Gm-Message-State: AOAM5313OSx7slMIRDpF10WY6NIPCcPsCdiq7XR5zSG1sLOYtMy9caAL
        cxzZ+K+j8wIrbkLVZ26mfNY=
X-Google-Smtp-Source: ABdhPJxVz62oVDVPiYix9nh/w7bS7wBgcZfoeMnkqHFk7DvfMw7xvDQGWpEj0fHg4eRFTPUwZBHEaA==
X-Received: by 2002:a65:6a16:: with SMTP id m22mr15604869pgu.29.1625486394118;
        Mon, 05 Jul 2021 04:59:54 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f3sm7888740pjm.15.2021.07.05.04.59.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 04:59:53 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4] tty: n_gsm: delete DISC command frame as requester
Date:   Mon,  5 Jul 2021 19:59:42 +0800
Message-Id: <1625486382-19051-1-git-send-email-zhenguo6858@gmail.com>
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
index 5fea02c..ea9c750 100644
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
 
@@ -3024,7 +3025,8 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&dlci->mutex);
 	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
 		return;
-	gsm_dlci_begin_close(dlci);
+	if (dlci->gsm->initiator)
+		gsm_dlci_begin_close(dlci);
 	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(&dlci->port);
 	tty_port_close_end(&dlci->port, tty);
@@ -3035,10 +3037,12 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
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

