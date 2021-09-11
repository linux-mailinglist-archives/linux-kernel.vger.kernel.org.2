Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDA40757A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 09:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhIKHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhIKHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:43:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCB7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 00:41:48 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so4038717pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+c5zhbreEU3JEkuP7TGM4ERBflvJvhTNxURFO/cwCo=;
        b=lPLI3d1ymQf6hk7pMmpxUTXWSBi7sC99IqXlpgGTWf6gsqshpqY8X94Rdmw8BufEh5
         1NuMI/2XUEUW6nvJte/JLhGsuthyM6LK3aEnlDW82iBgM/L40rjVuXoLx4I8l8s26Wy2
         F2yavnPPRHTeZYRIKied0i5Oxd2pIaGv0Akvv9YCz44OqOiQwwWHebX8wfAHkuIZkpbA
         /MfMMt/rh7hpfZAX4i3UCJGlLdqcaiNoBUa9a30uBCULle1lQLIXvSTM/TUVwC0dXVcA
         bjqQv+/89UpK3Rj97CnGvhS471+BkjB4iAmWxK8n3+2cluT9iq7MyHIEaY7LTDuzeU8p
         iTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+c5zhbreEU3JEkuP7TGM4ERBflvJvhTNxURFO/cwCo=;
        b=R4sgIdYAaHTAOQm7NBrMsgpQ7PGGuloSjFgCnzr/pYb4hABIZFe7J9AlTpifk6YhYf
         DX8FxsOYc6/4+aOcCIxpaGiU/KZv0qC3CWE0mkq4cpLY8mziJjI9HPhTlf/eY2rlazVl
         fto0Oda9JuiU46GjRlSVo1dcT6CVMHS1zOrBvf1UQPgMpX/UrgDkkzPvVaM68RAbqAhN
         +T3Uq/6NGQ4LRPbbwitO3pwIcuyxoI9i9IYpjcsJrJcGi9p7JpeCiYhf9ZIVVVXeiAyw
         OM1/RsU2TigbQLdwc5TiXn+fRaf8XgRy/x7n3NuuUic73qblEQWFR7reV097XPsb5XZs
         sJpA==
X-Gm-Message-State: AOAM533BOZBK8fV/OtpABS5Yfi3X9njaUU046kRBbWd7p/OGLhL9kVQX
        Dhd/K7JpLhBj0X105t7Y3E0=
X-Google-Smtp-Source: ABdhPJxy69J0iH8SvUT6NgUp8mV6ICQUkTCtUet8Zkf+wgSJOUWuFUxR+N5a4APLVUhSqaBqRNXoow==
X-Received: by 2002:a63:788d:: with SMTP id t135mr1470758pgc.116.1631346108058;
        Sat, 11 Sep 2021 00:41:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6sm1034454pfa.135.2021.09.11.00.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 00:41:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] delayacct: optimize delayacct init
Date:   Sat, 11 Sep 2021 07:41:21 +0000
Message-Id: <20210911074120.51914-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

In delayacct_init(), first there is no need to assign delayacct_on to
delayacct_on in set_delayacct(). Second if delayacct_on is 0, there
is no need call delayacct_tsk_init().

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/delayacct.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 51530d5b15a8..cbf80273be6d 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -39,8 +39,13 @@ __setup("delayacct", delayacct_setup_enable);
 void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
+
+	if (delayacct_on)
+		static_branch_enable(&delayacct_key);
+	else
+		return;
+
 	delayacct_tsk_init(&init_task);
-	set_delayacct(delayacct_on);
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-- 
2.25.1

