Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE13B9126
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhGALaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhGALaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:30:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A27C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:27:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o18so5139399pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bMuHHcGeaBJSx98yAiXeqgEyBO2ch07PKpmNbqX1sRA=;
        b=GF3M1Vr5YcH3y5kI5a0UyjAaGkpX+M8O0H8HH9YxdqIhpCDD//h7h+eOas7tSllJq+
         sHoYuz101xd5Y2dCyH+Gj34KpV9+kxpO7ZPFOULi1SyMHc6BQ6HkMU/QkkLN2cxyp4cB
         Ki4A5c55yZ3YlaSSErrgG1CZEm/P8K0EoGDPUnTkZ1Gl4poVxpogy+0BXvQkLduYAwmt
         O9sxg3BCzJlV0zpDE/jDdN4O8QUbDImxGpRqhnrTGNM4A5RxjeUgqVM1+Grc+rOXLMnF
         K/PdOePZq55IVi0fMfKE5Be0vocjD9/tVDFOpLl4rZTEHLRKKbLoXsMDdiREj9c/wTa0
         JmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bMuHHcGeaBJSx98yAiXeqgEyBO2ch07PKpmNbqX1sRA=;
        b=orkZEenJxcB5N/wCskB+0m8A6SnXWth2JTnL2DcoBLzTlDKe66N4PbZtB2IkS2EJ2U
         9B0iP+ppSud5/1z2QoFbxYaPVEx7M1OHgXt+0RW0KwJ8vaQ9gtIFTE+HRV+axhhHRXqn
         oT/Sl+yhvcJrCEbFNQFtb7c99WXLa3Nw9Q5IsZfOTb8Bi3QGKnzWj+dPG48SORdEaPzR
         AfjU5qXf8PJIGDFH890NOTB5Juc7zddHwC4hSVZZz6YP/CDZ1gWk+8DxrRM9vdEzzj4J
         zwz4KFmfv2NE5MH9EsX4ZKtuhmr2Vb18jwdnVuw1o0MKjVwBMdYTqc4Zv7tEBnqgQRML
         JC/A==
X-Gm-Message-State: AOAM532w6n/iyWb0ioqbxtPadtHV8w4c+vj2tObKgHOqb4SbNDbFwDOg
        dwCGS+mwFf95VTet+WzjEX8=
X-Google-Smtp-Source: ABdhPJyv1vbC+P5lXyMomiDzUSWA5A9PTL4LTHbsgOE+Ps3NoHUwPIV1PrfYJMfaOO3SBjhuC4D8dg==
X-Received: by 2002:a62:aa18:0:b029:312:28be:4783 with SMTP id e24-20020a62aa180000b029031228be4783mr3471060pff.28.1625138849436;
        Thu, 01 Jul 2021 04:27:29 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u20sm25007468pfn.189.2021.07.01.04.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 04:27:29 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: n_gsm: delete SABM command frame as requester
Date:   Thu,  1 Jul 2021 19:27:20 +0800
Message-Id: <1625138840-22974-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

as initiator,it need to send SABM command ,as requester,there is
no need to send the SABM control frame,it will cause redundant data.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..41a6501 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2997,6 +2997,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct tty_port *port = &dlci->port;
+	struct gsm_mux *gsm = dlci->gsm;
 
 	port->count++;
 	tty_port_tty_set(port, tty);
@@ -3005,8 +3006,9 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	/* We could in theory open and close before we wait - eg if we get
 	   a DM straight back. This is ok as that will have caused a hangup */
 	tty_port_set_initialized(port, 1);
-	/* Start sending off SABM messages */
-	gsm_dlci_begin_open(dlci);
+	/* Start sending off SABM messages for initiator */
+	if (gsm->initiator)
+		gsm_dlci_begin_open(dlci);
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
-- 
1.9.1

