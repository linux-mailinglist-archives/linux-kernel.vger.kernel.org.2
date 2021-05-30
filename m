Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74036395264
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE3Rtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhE3Rtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 13:49:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 10:47:55 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ez19so4515915qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fshUAoDzNCJvEinz9UdwS5Q3jLQ7SgLs/p1WmXhsTkQ=;
        b=O2R23C5fM4vk8su7bQhGQbobJWAE9e7fBr9qq/RX472jpbI2IncJwfszSVmuJEoy/N
         m4OIP5V2sEaHTLVaxDSpdkmhABu2DgqSojQ3asSJKt+6F1UWQLrHJOZk4RAaPZxgwePX
         K0Wvf2gXU6KHl6lY04HXBk9yQ71284UAg65ZRx8AhnfAVMkaT5govChXDZhxMjty+s1h
         nRfsUZV/UUs4ZOYnJeODyMZn7mMz0HGBugz5BqhxzPD3U8AaL7BvGTJOFItyIBM1/hOW
         QWn7sg1MPEdk+jzWK2/qx6KVC17rER6yI2IfEQhPzYIIdvbS6JOZWEJRv8aohv0Jb7mv
         itRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fshUAoDzNCJvEinz9UdwS5Q3jLQ7SgLs/p1WmXhsTkQ=;
        b=VIwIlJDa28qPN/1NGjV6f7Eh0h2qG85G3wbuhkz9hmVAVfu9zm1GickUqxJ0fNMldp
         FLa4VYSSecIUVy1P/QPlpaUARbywr8kjnSLJs3Kh2cfEIlwX/rqeumvNx+5sUR/DuaGY
         L5254RDDqHlX5WcTqKkW1c5IiXS25Sb4STdZ3f7SPH8lUr2w08B2KxqwtJVuYt1XYXfY
         yvGORUERoajzbNlSMeI0AnHwjkM5f/5NOFXyZVVqPvC7PlRpEdQi1Kre4H14ijSWZh4a
         IBjUwoPcrm2OwPzhDxlHMxE7UpNNg8pTPZ0RUfVJaNp5flZCz9k2mpM1wm340IY/Iz5A
         1ztA==
X-Gm-Message-State: AOAM531cb4zLWVONHrJBjzPvay2YPpmDMffQjJurE8E9GI2fYqpl4Prs
        aRVLjqFCcVMx1BPlz0mCjfIbdJd6755mqw==
X-Google-Smtp-Source: ABdhPJygL14c6NBsFrnE+a4h7OAxL+X0x1BLLsuPDZNALNrdCeJFpqRzDURDk4IhgAYo08zZZe5+lA==
X-Received: by 2002:a0c:80c1:: with SMTP id 59mr13454411qvb.31.1622396873156;
        Sun, 30 May 2021 10:47:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:e7cc:9ca6:297f:9600:ca1e:b66e])
        by smtp.gmail.com with ESMTPSA id c185sm7537329qkg.96.2021.05.30.10.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 10:47:52 -0700 (PDT)
From:   gkis <gabrielkis65@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] My First Patch - Gabriel e Felipe
Date:   Sun, 30 May 2021 14:47:39 -0300
Message-Id: <20210530174739.17066-1-gabrielkis65@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: gkis <gabrielkis65@gmail.com>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 598e278b4..bc366b166 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1082,6 +1082,7 @@ static int __ref kernel_init(void *unused)
 	numa_default_policy();
 
 	rcu_end_inkernel_boot();
+	printk(KERN_ERR "###################################\nI can hack the Linux kernel!\n###################################\n");
 
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
-- 
2.17.1

