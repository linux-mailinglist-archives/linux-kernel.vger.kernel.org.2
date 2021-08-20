Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7F3F2BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHTMUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbhHTMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:19:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 17so8966867pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUl40QSwbyX8h+29Trsi7im51Tv1W+q5vkfSePN/12s=;
        b=MxKNOJ/O5cramc8bFgS/f9kdr4vttMAzHbIWeLJL4lGSNXuxm4BL2nfGPH6HzuXozp
         2bqrwo8JbWcL+9hAaWeWP47qZmzgUw4gum5MBvXeCYoHZJQLyKC2LxltsmtdEJyLWs17
         m8DuCoWUlemUkeyovvwP/Qthd28DeVXV6lPwHkzPv3f/iE6kQt708RY+OvtgqVu54/0X
         FZELNnuufsF/DCFiM3hZHqP/ruxCt2GTe4C0AE+csCCt5cQOe9LbTWjiWYPTtnoAfSkz
         6vODf4hst/curqWeiPXUAwJUMCrHE/TitIjVCeVZA1KXFEKAPkBdJRAPkTTa8WpjydcE
         8DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUl40QSwbyX8h+29Trsi7im51Tv1W+q5vkfSePN/12s=;
        b=JBVFfks2kPa0vel9cb0ezOhGOZqfczxpXgLKDarncjCDg7jazjD6nk6ERLs4opR6he
         vHGAhauIDCKHF64no+VVhcOhNSTh72DM5+EON1KTKetpDe3IUtLvRl4P+2UsWizAflLS
         Edmxr4FkdxXZE6x3GebHYGvWxgZ+BL9fjZ+m6YyFElmZ1YwYOsVcRZFIuQBPMbdB3+QZ
         HXakw6JS/BKhUNSeXo09uXmaf6RN/++Ip9yOHlvjfdQP4ZphZ2BXv4IBHCm89XyXRQlP
         Cs++fZHBQiYbGEoeUTd+0I4op+bS71TTm3M1zrnsJvtgZmc649+YW4GMLeD6qz8hkPsh
         +lhg==
X-Gm-Message-State: AOAM533Xv4pyOiPcq+7uWNfYdIXI0SckniWV0cyPw9hF+q5wLwXABMPJ
        n2ZkimOO3gLPt3a/j2xkRzU=
X-Google-Smtp-Source: ABdhPJw0T3/7TvAGDmb40kz++iZh4bJziIy6Zhb4PtXCU7JFUpev1dUg3hR5TjewB36DQvqkqWg6wA==
X-Received: by 2002:aa7:8c41:0:b0:3e3:1279:105 with SMTP id e1-20020aa78c41000000b003e312790105mr10106866pfd.80.1629461951482;
        Fri, 20 Aug 2021 05:19:11 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t18sm6629554pfg.111.2021.08.20.05.19.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:19:11 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] tty: n_gsm: Modify CR,PF bit when config requester
Date:   Fri, 20 Aug 2021 20:17:47 +0800
Message-Id: <1629461872-26965-3-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
References: <1629461872-26965-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

When n_gsm config "initiator=0",as requester,gsmld receives dlci SABM/DISC
control command frame,but send UA frame is error.

Example:
Gsmld receive dlc0 SABM frame "f9 03 3f 01 1c f9",now it sends UA
frame "f9 01 63 01 a3 f9",CR and PF bit are 0,but it should be set
1 from requster to initiator.

Kernel test log as follows:

Before modify

[  271.732031] c1 gsmld_receive: 00000000: f9 03 3f 01 1c f9
[  271.741719] c1 <-- 0) C: SABM(P)
[  271.749483] c1 gsmld_output: 00000000: f9 01 63 01 a3 f9
[  271.758337] c1 --> 0) R: UA(F)

After modify

[  261.233188] c0 gsmld_receive: 00000000: f9 03 3f 01 1c f9
[  261.242767] c0 <-- 0) C: SABM(P)
[  261.250497] c0 gsmld_output: 00000000: f9 03 73 01 d7 f9
[  261.259759] c0 --> 0) C: UA(P)

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index becca2c..7aa10de 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -601,7 +601,7 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 
 static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
 {
-	gsm_send(gsm, addr, 0, control);
+	gsm_send(gsm, addr, 1, control);
 }
 
 /**
@@ -1786,9 +1786,9 @@ static void gsm_queue(struct gsm_mux *gsm)
 		if (dlci == NULL)
 			return;
 		if (dlci->dead)
-			gsm_response(gsm, address, DM);
+			gsm_response(gsm, address, DM|PF);
 		else {
-			gsm_response(gsm, address, UA);
+			gsm_response(gsm, address, UA|PF);
 			gsm_dlci_open(dlci);
 		}
 		break;
@@ -1796,11 +1796,11 @@ static void gsm_queue(struct gsm_mux *gsm)
 		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL || dlci->state == DLCI_CLOSED) {
-			gsm_response(gsm, address, DM);
+			gsm_response(gsm, address, DM|PF);
 			return;
 		}
 		/* Real close complete */
-		gsm_response(gsm, address, UA);
+		gsm_response(gsm, address, UA|PF);
 		gsm_dlci_close(dlci);
 		break;
 	case UA:
-- 
1.9.1

