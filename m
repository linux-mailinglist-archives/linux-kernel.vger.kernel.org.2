Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3445B272
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 04:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhKXDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhKXDMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:12:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:08:58 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v22so1303985qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK/4cFthG4GJZS5AoKb8+SGtl+JeDjxoi5HKvVoykfE=;
        b=ZJb492LZe89rR2WaruNnhZ/39u+ri0ho//jl7PjlGu5Im4kGo1Wn6q8ZZJsGtGCWI5
         X6k/Vq+S/Y7DrXWQ9MJR5hrqpu0X8DKrDK+q6Vvv04TIDuj3z0gJWpWTIgFBReYbMYsG
         ENHOwWrS/MfyoAnGuTYBJgOoI6Rvd87MGb5/mOa+5tyeobp3tAcowUfq64lr+M+d62lg
         VnmUPay0qlZoS2X1BGVvCNbs//iHsZg8XgTwWUbxGwQc3sD/MJI99jzVlQ2cGbSg32FG
         viqwPKvW0QuAcbAxKDJdXdjozFKXVvBNXTufsuC5yYtjCK+1Nyd5WXdjdj4lPKmD3Kao
         /GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK/4cFthG4GJZS5AoKb8+SGtl+JeDjxoi5HKvVoykfE=;
        b=ItPv/zR4m3fBw62+m2343nUbvKjjUmI9k91xhnxbA45A7Ij+UVfREc2CKJR8Iu6N13
         xjtEuG8KhYxpoWtVZvuvv/CVLFo9cK6vC6wiap6gZsHJiVfSb2ULNT15RFVl/W6RiE0+
         1EZ2LxH8OX19jc6X82dKzRFm3XANW6Tk7hSmw4+7I3RAq/DN0mDX7Xwdza0rCAB0IqMU
         5OpUrLTs3F2lweK41BCn3uJY65SxUN3FtP550eKpK/O5SumEPM/MnyobV3AM11ONcBTf
         SbyM5aNvLF6sY+Vqh9Mv6sqHBw/ZGzPvFPtR2lqlIrTV8N51yVbvhZ8FD9YuHnbgeNQL
         aXaw==
X-Gm-Message-State: AOAM530FVWRuJ1sb5Xk1mf7pw6EnJienTvNlHqSq7oXbN51WssUa2S+Y
        V1ZpBY6mhPCK3BsiTxV+9Ek=
X-Google-Smtp-Source: ABdhPJym6t493UbXUooiE7EnMqyNJdAJRxfOGzuIU2Qx01ZWNBkJpVFJ//H085l9Thw8DPPk9z3X0g==
X-Received: by 2002:a05:622a:1901:: with SMTP id w1mr3035938qtc.134.1637723338163;
        Tue, 23 Nov 2021 19:08:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o10sm7216884qtx.33.2021.11.23.19.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 19:08:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Date:   Wed, 24 Nov 2021 03:08:49 +0000
Message-Id: <20211124030849.34998-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccinelle report:
./mm/memory_hotplug.c:2210:2-5:
WARNING  Use BUG_ON instead of if condition followed by BUG.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 mm/memory_hotplug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3de7933e5302..aecb12bb7513 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2212,8 +2212,7 @@ void __remove_memory(u64 start, u64 size)
 	 * trigger BUG() if some memory is not offlined prior to calling this
 	 * function
 	 */
-	if (try_remove_memory(start, size))
-		BUG();
+	BUG_ON(try_remove_memory(start, size));
 }
 
 /*
-- 
2.25.1

