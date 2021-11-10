Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15C44BB86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhKJGDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhKJGDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:03:08 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32459C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:00:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so1105362pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5R9okxssD0vfhiwsid3Cwq/cLq+VDAa4MyoGCFyY/RA=;
        b=QA3ze0QcRwVMuS/McRMZQzLUZCFSz4qaiO5rTHLKS+JJUDhTyUI/pJbF0MokcVf5yG
         j9KYsz4e5mfETXBWeFp5b8HF+njbP0RQXqwXgrqqXr/hVU9k6lVSbxWxvgRMeX8TcYCV
         AqHdcSTjI7DFFImVgoUw3YEGJLKSIOcvnazfnu9vCFvYkPWp8htx4CPN4glk5v7E1mc4
         WDfSijhpf8nt03VVcXKVe01g9sUJSbaSVNsNUTlfmt4g16x1dBC+hfMSK8l4YUh14ZYl
         M2AU0BQ0u/GuW00oELys0M8YOOHBO9Nhvt6Ug13bkc7PI9WDxoGmJ6MCq/DvCX01pSw/
         +SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5R9okxssD0vfhiwsid3Cwq/cLq+VDAa4MyoGCFyY/RA=;
        b=vkM/r6sPZle6fGNnVkpyloPBK1GJTh1wHKqr31QtssQOucfQjRByNiICd3oYbOakIF
         ZfXW+Pss6r3muAhVZKHtIi5VPdhgDtrCkK68b3C//NvrYOo0SM7QndL1j5JTK7RG0xxr
         xutqNNS3tEezvhz/1J7W5OfRL1/BXy8IVQFzAmFsEkDo6x9K/USLFXUuUIR7PCXQVikn
         3UgPQ27AEWovb2zXILuxumDkqMP1Gj1PajoyR9F2/lvfXPl7DH4pkxLQz/vje9yymyQ8
         AcoZ8La4zufk14LiDrQrOaLPvIdiqYGQykeg7C2H5IwrqHFgLLWXeirJWU+CTnC98O+0
         EmhA==
X-Gm-Message-State: AOAM531WpSp5u4lLyInXlVsS5fKT/I91p4dgNigUAHEonL4lzLL2+44B
        P+TlbP7qcKUF9SWsVJDEIwg=
X-Google-Smtp-Source: ABdhPJwzJn8lLRXSrdbCLORvjC/K4pMBhZMBbQkGlF8eQr+Ty/sIuVjOhO9TvhGuEkmUvBpKdTHBAg==
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr14310972pjo.134.1636524020755;
        Tue, 09 Nov 2021 22:00:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g14sm16679424pgo.88.2021.11.09.22.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:00:20 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] kernel:locking: use swap() to make code cleaner
Date:   Wed, 10 Nov 2021 06:00:15 +0000
Message-Id: <20211110060015.137121-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccicheck REVIEW:
Use swap() instead of reimplementing it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 353004155d65..fa021b8a9edc 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -389,7 +389,7 @@ struct stress {
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -400,11 +400,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = get_random_int() % (n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.25.1

