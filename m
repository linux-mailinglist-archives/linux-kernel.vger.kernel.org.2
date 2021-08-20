Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05F83F2BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhHTMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhHTMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:20:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7AC0617A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so7090698pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K0hsdge6QTDoqq4MtFMoqacOsdsWCSmBNOZKuuL4SUE=;
        b=O7xFG3RaPX5387GIdtUu+oeZMJbWC1ZIVeDQczRhp90XGcFVbLumtwWsErb+c+uSlZ
         4EIpxTXLuOQPecm/5PE63aswfSWWMsz60MQnQko+Z4kZjCqNhvOPBosEIu4esSq6B8Fc
         WIEFAK3wGEC+fNPm8unJA9hXTPaxsZV3CxfqKEuKsT7+ONJP4rrRKLCS3V/Hw45+GoGB
         I7GC6/vuz+1XmRTHjsgaAJy7fN3hCQU/fsi0WCT3J9J/pu16WfnQ0eiwogXOjlu5mWbq
         R2IY1Mx2eOkQmGIba3lOUBMMzpbIuY88UgVmJQAy9s/kTzukb8PiBMasYM8mOrnnrRwJ
         WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0hsdge6QTDoqq4MtFMoqacOsdsWCSmBNOZKuuL4SUE=;
        b=Gap8dAHhjhqcM4gohcYvvRNF4zDEghq+NtyGeJntn3XTrCFNzagULfz7c/l57qWqjE
         AfYHmoyhKveFusLAbsB5ZYMSXBt6FXeAike8zmQ9t1o9c+w/o/X2WG+ZHdQZoWh5RLHB
         wzgPfWYx3Gr1tk15dw/WZiQdsd+BX0eZ88MxVBrvJbkcHxelE2OqR2WqZuQfABvBXKZ3
         CxvRK4RVAD1pBtOkVFKJwJzi6d2FHCuycyoWzvghJ9rFpVXp9sZjoeyaxHrmRM/mBtHV
         szobJrUjn1CGdu4lFoVqMF6Tx97ulbxLgocJ7NyjbFMgq59JcEv0m4FfSnmR16KI+U/h
         dsyw==
X-Gm-Message-State: AOAM530B0ZHnlTwF93nM0WV80eo3SxYGrHY+eYcb+XVjvkon7PZn58jt
        yKFAERe4ujr9yxS/5vPt+Ak=
X-Google-Smtp-Source: ABdhPJzzoHmAVE9BeRMaHE8ZlOdjhyLEKy848qP/DBkGr8ncrahZZHJRrBjvYy1OXgAWxMLAuTHXCQ==
X-Received: by 2002:a17:902:db01:b0:12d:ccb0:f8b1 with SMTP id m1-20020a170902db0100b0012dccb0f8b1mr16395581plx.43.1629461960062;
        Fri, 20 Aug 2021 05:19:20 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:19 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] tty: n_gsm: Delete gsmtty open SABM frame when config requester
Date:   Fri, 20 Aug 2021 20:17:50 +0800
Message-Id: <1629461872-26965-6-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",as requester ,it doesn't need to
send SABM frame data during gsmtty open.

Example,when gsmtty open,it will send SABM frame.for initiator,it
maybe not want to receive the frame.

[   88.410426] c1 gsmld_output: 00000000: f9 07 3f 01 de f9
[   88.420839] c1 --> 1) R: SABM(F)

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9ded99a..8d56d3d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3001,6 +3001,7 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct tty_port *port = &dlci->port;
+	struct gsm_mux *gsm = dlci->gsm;
 
 	port->count++;
 	tty_port_tty_set(port, tty);
@@ -3010,7 +3011,8 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	   a DM straight back. This is ok as that will have caused a hangup */
 	tty_port_set_initialized(port, 1);
 	/* Start sending off SABM messages */
-	gsm_dlci_begin_open(dlci);
+	if (gsm->initiator)
+		gsm_dlci_begin_open(dlci);
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
-- 
1.9.1

