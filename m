Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8258A45A45C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKWOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhKWOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:07:25 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C415C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:04:17 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m192so17483287qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pelz0/bmCMSCu6rWTgejbKvJkGPF4AA/IxYbeA6W6OU=;
        b=AyvP3vCGOcJCMgThxmQeFTjsdWCRgkujCmtS2IhhQQTeg53nROIVmYCl5vEZZUrlQq
         NorYEfdluFQHOEaE4XkncpKNTRXFlmyCE5z8+dr6GC20ylYvAdz5qrgac5dyrx9FYogJ
         sGj5rTbcAuzFz1v5z4VV0g/eU+qUoounLPBs9NqoYnUH0Ox/tuzRj1kOisXNushN4Isb
         /nWFICqmnaoh4zfg6cmB4vC4PeKYX5mkDvBAwb8suUZJpUJ+G4cXL/ayY2cHpPpZQmtr
         ApEnUXwzot72ZLKblL4uAI7BZGXY6tqY1yVhYRq9ioOKUJmGQ67RRfN/viuZs6n3shvm
         lWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pelz0/bmCMSCu6rWTgejbKvJkGPF4AA/IxYbeA6W6OU=;
        b=6+eOdfPRRGtPF12m+dN8/c96ywTagNg3hnVujlS1uLxHeeJaEB3tDPqyUbLSM9+NiR
         ueIMHti3Ibw9sJsCPJmUGfzy0Q2rqlMu1yxCTjmGAScGuqPH1wboagxmrd3Y1+X2H0kz
         6ijsNhUw9rGInrrdnR6fcy8TBy/hzRTTn5nhiw8+TuIGcKC09fTKZoH+gi9u44wvcoF/
         TTNezDj0IS8d1EtEsu4TtI2Vxnc8V8LPt2dkhiHXd+hd1vfJw0KZJDv2w2qBwJDW77S9
         09gQzhGYmrbAc3+AVKseMbzSz9ucceOX5mPV9LwARQAVEePdP+ElguXofifVs0j0h61Y
         5FOA==
X-Gm-Message-State: AOAM533bbjW1N8dnSUXeWe09FTBjyjie79e8raS/5B/w0gRWAjLmEQcq
        zSxoW5uGQXiTqWVE5lUhyWg=
X-Google-Smtp-Source: ABdhPJwGPVNYT0gtW2vZvLW8xdcBh0/G3YYvjXKUVg2ET/EdVE6cHtaes/rFbu3Kl3YB+gmbQ3x2IQ==
X-Received: by 2002:a37:6d3:: with SMTP id 202mr5073624qkg.16.1637676256225;
        Tue, 23 Nov 2021 06:04:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v16sm5895000qkj.93.2021.11.23.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:04:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org, mingo@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] delayacct: fix incomplete disable operation when switch enable to disable
Date:   Tue, 23 Nov 2021 14:03:43 +0000
Message-Id: <20211123140342.32962-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn> 

When a task is created after delayacct is enabled, kernel will do all the
delay accountings for that task. The problems is if user disables delayacct
by set /proc/sys/kernel/task_delayacct to zero, only blkio delay accounting
is disabled.

Now disable all the kinds of delay accountings when
/proc/sys/kernel/task_delayacct sets to zero.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
---
 include/linux/delayacct.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index b96d68f310a2..c675cfb6437e 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -131,36 +131,54 @@ static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 
 static inline void delayacct_freepages_start(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_freepages_start();
 }
 
 static inline void delayacct_freepages_end(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_freepages_end();
 }
 
 static inline void delayacct_thrashing_start(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_thrashing_start();
 }
 
 static inline void delayacct_thrashing_end(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_thrashing_end();
 }
 
 static inline void delayacct_swapin_start(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_swapin_start();
 }
 
 static inline void delayacct_swapin_end(void)
 {
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
 	if (current->delays)
 		__delayacct_swapin_end();
 }
-- 
2.25.1

