Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE83B8C87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhGADHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGADHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:07:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:04:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id a7so4835366pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oxC57II9/3NytBfD6hLTnrYmWC4kfAXYd+KvwhE0c6g=;
        b=e9CnhX1cD3eOwYxzddfuNkqMINYmuT7YEgUAlEAbaNd+z1cm8zS6i26t2KXARUmgCe
         VTiwYjcbvMEhZXzH5EHzLurtnrUKsUSSAHLrrKziT24NHLWZ1Et+J6M1Zm/65aHPn3zi
         j9klIjjlcAr7gqe6aTHnkHHdonNF7a4pAIYXBQ+vUSz9S6B6EWzI7uzyJMnzh3CTs3b5
         d/dSOtzbZj41Xi6c+jnWQSkAooMBSmPoJtzxzcuvTeKu2S0CRgb/2enWVqmVbt78XhWQ
         8WPNFx9PPq5w9RxnjNs20CeuvJPCnCPhHMWnCyXdWZRnZkhJeRpF47BeybbIsJzzqEeI
         7SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oxC57II9/3NytBfD6hLTnrYmWC4kfAXYd+KvwhE0c6g=;
        b=p10oraKT8OKcAQ0/65le4gYyvOVvfnuE9AsKifXzk4sne3qVA03hTV8OFsXkkpm9I0
         Nb3sFFf8bXrFAeRfGwGApSUePydpPJREA+UXrd60J2DTuSmwrEQoWLXWm+ViXUQKbyJh
         nR2bxbxEkI15J4H2iLFO8GqXGtXUR+2Vg2zK403cMaWMgU5pZCflWOvvgYFp8rvspJ/8
         QB4a+VGr5c7ZBwoOXvh9YiHctvPKNluSilVIVvqgOxyJJ4m9PksSz9p8RX64TiCqAjBY
         qW58wNXJP7IwYXMW/js0f4yKJHpkgeL1UMtTjRa/oCeBFxuszNZqAASvqOpnTlZ5z1jo
         40OA==
X-Gm-Message-State: AOAM532DU92CRc2rLIN4WSYIWOjf0FG5F6pN7JbaawZUUtxuLO2SEZg3
        eYjuXIhMCFQemd/FJl/XJdw=
X-Google-Smtp-Source: ABdhPJy4al19sOoCM2NIcn6d9uBWkDSOYyA5V+4kFKJeU+JX8oIK6RreIRXiN3UyVj3g4Esnbn5+FA==
X-Received: by 2002:a65:5603:: with SMTP id l3mr19026496pgs.7.1625108682029;
        Wed, 30 Jun 2021 20:04:42 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w123sm22720158pfb.109.2021.06.30.20.04.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 20:04:41 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: delete DISC command frame as requester
Date:   Thu,  1 Jul 2021 11:04:35 +0800
Message-Id: <1625108675-16706-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it need to send DISC conmmand ,as requester,there is
no need to send the DISC control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..9447148 100644
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
+	if (gsm->initiator)
+		gsm_dlci_begin_close(dlci);
 	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(&dlci->port);
 	tty_port_close_end(&dlci->port, tty);
@@ -3038,7 +3040,8 @@ static void gsmtty_hangup(struct tty_struct *tty)
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

