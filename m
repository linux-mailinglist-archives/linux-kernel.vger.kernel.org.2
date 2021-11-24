Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4EE45B4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhKXHEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhKXHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:04:07 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85E7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:00:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j9so1101194qvm.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2wUoUIkYgpdGmZvGPYtcM8koKkr/7DwO6pYlMvQjqU=;
        b=kK3zczeytpGCxtxsI1BtjDZ7pQfTguhAydAjAjoOuFBBdyCKlKWjFEdglEG3Xo+kx0
         y9ZlRAp+1V2T/BeUyYQgMW4cgm9wpN5OxPMV1sryieGsqJykfajC1TgKuo982NkRmEeK
         KubxSTMOZh729uzItgRBFomlwUbAaDRUrE3ea7/6W/hVY9uakGVeCf8eks/LqvJOp4zx
         MrDdctHOzJR7RzkHK2Ouy7IH+4C1/QWeOS+6noE9v9rXMq0G7Yf8REAXtq4vNFZspoSi
         4DlgduzW2fZVja45sd/ylSXG/uzauVpdAwNyXSLPF35rlBwrYH7Wp+wl2O725g0BX62o
         7+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2wUoUIkYgpdGmZvGPYtcM8koKkr/7DwO6pYlMvQjqU=;
        b=il4/nqsQtWSTBNSlp0m3yunuT8UgmqbTb/tMmjm5PlFbU5xdl4aD4tXBj00xwjKIe7
         feVMINZiEUhtyNmyltcgNtqL0e5g557UNrtU3hHE27L+RxY3Hue9H7Nt+4NtoUBGhZwO
         Dvs13eb9K5nTcGMjd/RcjdRjykoGaw8SeEtSAwPLBZnLJiV83M7gFdeHWITnSy5KZ5Ua
         UXWg4Q6vFmAVq/MlBGrIoPdZrzOo6tgzIVUHkclnxoO2vksOv1PF1BLA9BiuBHH/rcMS
         CypgP0IZNRzOtu2QyZB2WdZ+H1vSxccGv/ZQskTOrhjA5FxZrnlToZn1AAPt73FXZpKa
         tYEg==
X-Gm-Message-State: AOAM531Raiyy0aTuVPpuwwcNG/7Zn6yTwWI0ML21V+mhYGXrkfv9min7
        rMUE+X8KzY5MCnpIr/F/gwc=
X-Google-Smtp-Source: ABdhPJyCOHIFDqt/3OQgtkvroDVDaUIhldwN9QqoRzOGyOUHIZV9zwc/QJxEhcbOF7o0MsS5PK9AVA==
X-Received: by 2002:a05:6214:1d26:: with SMTP id f6mr4492864qvd.19.1637737257896;
        Tue, 23 Nov 2021 23:00:57 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c13sm7602952qtx.51.2021.11.23.23.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:00:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org, mingo@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] delayacct: cleanup flags in struct task_delay_info and functions use it
Date:   Wed, 24 Nov 2021 07:00:00 +0000
Message-Id: <20211124065958.36703-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Flags in struct task_delay_info is used to distinguish the difference
between swapin and blkio delay acountings. But after patch "delayacct:
support swapin delay accounting for swapping without blkio", there is
no need to do that since swapin and blkio delay accounting use it's
own functions.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/delayacct.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index c675cfb6437e..435c3654a0ff 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -12,7 +12,6 @@
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
 	raw_spinlock_t	lock;
-	unsigned int	flags;	/* Private per-task flags */
 
 	/* For each stat XXX, add following, aligned appropriately
 	 *
@@ -74,18 +73,6 @@ extern void __delayacct_thrashing_end(void);
 extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 
-static inline void delayacct_set_flag(struct task_struct *p, int flag)
-{
-	if (p->delays)
-		p->delays->flags |= flag;
-}
-
-static inline void delayacct_clear_flag(struct task_struct *p, int flag)
-{
-	if (p->delays)
-		p->delays->flags &= ~flag;
-}
-
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
 	/* reinitialize in case parent's non-null pointer was dup'ed*/
@@ -184,10 +171,6 @@ static inline void delayacct_swapin_end(void)
 }
 
 #else
-static inline void delayacct_set_flag(struct task_struct *p, int flag)
-{}
-static inline void delayacct_clear_flag(struct task_struct *p, int flag)
-{}
 static inline void delayacct_init(void)
 {}
 static inline void delayacct_tsk_init(struct task_struct *tsk)
-- 
2.25.1

