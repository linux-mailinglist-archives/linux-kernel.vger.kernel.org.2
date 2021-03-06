Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2532F928
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCFJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCFJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:37:31 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B109C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 01:37:31 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t26so3028088pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2jA3Z2euzS0jDO3UMNxRqQMszkJNAoTkrHs5Bculcw=;
        b=UdqlpecHpc7MBxvkbBX3oAxOcjLbxt6i7uW5DT6Ih4b/yBMxoOt+KEHjAyGRDUYL2L
         fhzrnO3vRH2yn5sZcz6q3wzfeLR6SaVM/inZ4m1tWr8MJ9hRK3WV6gufSzdnwWt+V03H
         PYNRYZQb3IwSFAGtCJYBx3saJTEpBBJNUuV4RpXdADGKSafET5XG62RwNHiHMOKvCdQ1
         Kfn/uABu4zf5UjfuQNBsl9rZX2WWD8F/I2bYSCrP0AfRXsfzU5m0PV3J6OIbTaAPTU02
         IXXRL1t7EliOZCH+gWQO70xR7Ly5+bfFmDJyCP9yj7l3dAVBh77KhYrtxlry+IQB9RDG
         253Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2jA3Z2euzS0jDO3UMNxRqQMszkJNAoTkrHs5Bculcw=;
        b=pDgv+64yzUoWHGwMy77taNKl6E2bFXSs2LSiylfkhOjTwYU+ZfjUlnm50tEIFORaEv
         mwLjr5+MeIptI15o4dBe6d48y6dJwulL44FsUd1YKZSzckMwL4tdUGkzMJci5fCUrsen
         mzj+9ozt4G9pZlfjNkwk0JNV9GUULB84gdKzxyCuzAwOr1L+HZDcjQ9JyD1RLj9l7BfR
         NYANuIzfN9PjeneT6oWJjPLfmF5KR0mE5xJ6G33EMdTV9D99kRkeGjOe83KwdP2FVEwZ
         bZkf6g/9Z7tmY+fsbvIAQpwW5VRu87QfYstCrtplUBeoFtFnw5YGLri/HeV9GclmMmaQ
         eu/Q==
X-Gm-Message-State: AOAM532pRivCkyk+boTXGa1sfgUP3n4KN5zyQ3yMMFZ+R550au07hD6S
        rFgzaYO3rS75jRkll+laJdZea+21aVU=
X-Google-Smtp-Source: ABdhPJyp30zM7I6ZGxm/6d4golWobzH5EmOIAyypiJyonYUkUnjJWbmHsvDtSjPZOd5seznz9npzaA==
X-Received: by 2002:a63:1f1e:: with SMTP id f30mr12631306pgf.141.1615023450825;
        Sat, 06 Mar 2021 01:37:30 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id i11sm4988665pfo.29.2021.03.06.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 01:37:30 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     Sergey.Semin@baikalelectronics.ru
Cc:     arnd@arndb.de, zhang.yunkai@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bus:bt1-apb: remove duplicate include in bt1-apb.c
Date:   Sat,  6 Mar 2021 01:37:24 -0800
Message-Id: <20210306093724.214673-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/clk.h' included in 'bt1-apb.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff941e7c7..74b1b712ef3a 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
-- 
2.25.1

