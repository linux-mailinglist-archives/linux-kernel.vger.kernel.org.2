Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159DB3457BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCWGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCWGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:24:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F00C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:24:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u19so10659204pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fD7whzkga1n41mwitAEf7/1mswAaRzgKbqj4Zkf0V/A=;
        b=MC8sooYLny5rS+7RToJWnhVsZIkCg8zZZTFJ5d48OhDqeMEm68Lu/GJRIUFlp4axjj
         lupKxK+O2gJlX0D35KwF47CBsKiRfxgFZoVMKcjwaGy60vHe48zRq9Nhb+FKpEVNMRmy
         rTK4G/+eXMQ5haMt6ShJCh57mfq+XGp73Lfy7GSbnr0GtQXL0Lbb7ZMfBb43I676Ytg1
         vEavQo8F9iYxi9SRoPs3gq39Yyt+EfYEyTQNQDuLbuvr2gOd4PZjGlH35v8A4Bd+tK6P
         V3kOkKKW9s8hwP/nw3ooakWOfLr6f6/VxuPRLRKg18kObCaxkrXl6wPY9DZjpy9Iz79c
         5QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fD7whzkga1n41mwitAEf7/1mswAaRzgKbqj4Zkf0V/A=;
        b=e99gkZJrmvJQHdbauWKjg5h8Lq6UI62pgoTtjjueeBEP6twTHWtz4TZC8QofIV9Jb+
         YLTd4Kf4oLOfp6x6vn9OYG8mYlfdkIaP6a2GEPcDMrA5fYC5O/S5Kgq/cGEwXCCfNNWV
         8QB4xTDs0QapbTzUOfzgbNKSBmr1Ld5lNxPiYqjgA6v+7WtSMFg+Z5zkzq2ytaGNIHCp
         c6iBsPQ0i4H2gYvR9E/+syh3/HCTu17hyyfKaztjMlaffC+XsBjSDJC3yuogN4ujMutc
         YEl03jUwY85kvFxwXvq1HS1MFLHPG6uvCz+TnmqDfWAIMaR4i0WWjwS6JT8A2S3NVOhz
         9VeQ==
X-Gm-Message-State: AOAM5325leLOtVX8N9Gc16JsxyrzEULyqfzbvnb/88lpYwvUV1giu1jy
        O2XzILJrq2R8QFybnx7UnUU=
X-Google-Smtp-Source: ABdhPJwrM5HDJXb26zdE2bur1Q555CtwO42neRLXvDUtxhE2+sWzRGJ6Q3SD/mWf5jN74UUN2+cl2g==
X-Received: by 2002:a17:903:304e:b029:e5:d43:9415 with SMTP id u14-20020a170903304eb02900e50d439415mr3765538pla.42.1616480666254;
        Mon, 22 Mar 2021 23:24:26 -0700 (PDT)
Received: from localhost.localdomain (ctf2.cs.nctu.edu.tw. [140.113.209.24])
        by smtp.gmail.com with ESMTPSA id t17sm14999564pgk.25.2021.03.22.23.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 23:24:25 -0700 (PDT)
From:   tl455047 <tl445047925@gmail.com>
To:     dvyukov@google.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        tl455047 <tl445047925@gmail.com>
Subject: [PATCH] kernel: kcov: fix a typo in comment
Date:   Tue, 23 Mar 2021 14:23:03 +0800
Message-Id: <20210323062303.19541-1-tl445047925@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a typo in comment.

Signed-off-by: tl455047 <tl445047925@gmail.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 80bfe71bbe13..6f59842f2caf 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -527,7 +527,7 @@ static int kcov_get_mode(unsigned long arg)
 
 /*
  * Fault in a lazily-faulted vmalloc area before it can be used by
- * __santizer_cov_trace_pc(), to avoid recursion issues if any code on the
+ * __sanitizer_cov_trace_pc(), to avoid recursion issues if any code on the
  * vmalloc fault handling path is instrumented.
  */
 static void kcov_fault_in_area(struct kcov *kcov)
-- 
2.25.1

