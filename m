Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A15361BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhDPIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:36:11 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43602 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbhDPIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:36:06 -0400
Received: by mail-qt1-f172.google.com with SMTP id i6so10642946qti.10;
        Fri, 16 Apr 2021 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+SWBg6vyMpiCnh+pmxIKMewgtfrKgyoDu1G+uKhgXY=;
        b=Gvd5U83C5yAmbzFGgWs3hrDnIXYi4wszHRWe15B1/4Saig01uy+40zvG2c+htkZgsA
         NeksPHgm4s7xOXGhkmX2IKW3h6QFiqQPgYTn18Aaj+PhBpGQzDbgIPSfm+3d74AfZSPQ
         7k1l+ltc3rnR7ozh4C3w1RMSClRfYTOgjG8Zuyo/Mh7c6K7/vmhUg7aVkiawsMPsldYj
         8IVDetaMYM40i3QkBo4Dk9dFZ3wsohpVvg2A9GKkscSlndrIbaOSry5hZQ4UFf3GaHXs
         HmQ1qIb7h1Ws7J0XJQM+V34FNabld5krLsN8gedTMmsi5ax6Lf8lkdg+sBR6qwiT9XIq
         0h+g==
X-Gm-Message-State: AOAM533S8v8RDoo4zgZ32yZEo14050rBB07/rjKvvLoVIsi9/YDGhkDM
        LIaM4wON67NNV8IGM50oBedQv9qG1BI3jg==
X-Google-Smtp-Source: ABdhPJzjExvhu/I5GIUQUhSCBRi2Pixy4GZxIyjyqNjqh5gIXeoJtku2qLNwqK2NG6sZkq485CcydQ==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr6854950qta.15.1618562141372;
        Fri, 16 Apr 2021 01:35:41 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:41 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] floppy: cleanups: use memcpy() to copy reply_buffer
Date:   Fri, 16 Apr 2021 11:34:48 +0300
Message-Id: <20210416083449.72700-5-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
References: <20210416083449.72700-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memcpy() in raw_cmd_done() to copy reply_buffer instead
of a for loop.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c58b0b079afc..c584657bacab 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2988,8 +2988,6 @@ static const char *drive_name(int type, int drive)
 /* raw commands */
 static void raw_cmd_done(int flag)
 {
-	int i;
-
 	if (!flag) {
 		raw_cmd->flags |= FD_RAW_FAILURE;
 		raw_cmd->flags |= FD_RAW_HARDFAILURE;
@@ -2997,8 +2995,7 @@ static void raw_cmd_done(int flag)
 		raw_cmd->reply_count = inr;
 		if (raw_cmd->reply_count > FD_RAW_REPLY_SIZE)
 			raw_cmd->reply_count = 0;
-		for (i = 0; i < raw_cmd->reply_count; i++)
-			raw_cmd->reply[i] = reply_buffer[i];
+		memcpy(raw_cmd->reply, reply_buffer, raw_cmd->reply_count);
 
 		if (raw_cmd->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
 			unsigned long flags;
-- 
2.30.2

