Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D862441C3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbhI2LxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbhI2Lw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t11so1314477plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ikf7fVByEJKZspDKJs9uWwvbKIOIx9YgMwV54xQl3hM=;
        b=btZvicR6OZjifbPzESVKzfNz08HNfq4EUibv9GmJgb1MUA7lyyCXRSbB/zd0CsQN/i
         1Jams8WrLhHedfCUw9MUDulAlm+sHkzOX6dD9U+roSrYX/zIf49+0MctwVV2RmkVgU6Y
         Big0r77K4R4WHeUjUXccDH1aSLRxyIVI3sGVjaVE2gW1x/WgaZLWznuVNHyfxsGct+uw
         vxSAGPx1MspRS4zHIDBDw0JcnvFVddRM5Ybce01h9K2WTeGY8HL30Swn2cpRfA9BVYku
         KkH52xMw6etth/rCOL8LYbj4kNI3ibYsO30hdFP7vZ1swyRXibN1N6qNcpOg0nJPC7jQ
         ALfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ikf7fVByEJKZspDKJs9uWwvbKIOIx9YgMwV54xQl3hM=;
        b=OxGFE12G4m0hogNHVRlU9PM/gQ/PLKcRybiUgI+mHtZGangxU/WuoTCaBllGymRnGC
         MKQv8gbstJmlu/UX36jMTyHYR39mcb0vnHRNnFx0Q8LyNdRiq78CbdocebH0c3Ok8HT+
         SxfelP7cJFNKB+bsDOSBK8UZEZgkKdrj2qQGS5lmcs46ZOUEuK+PmizZO3pFP61qFYA5
         u6LyxFrSGMdymTaRkFp1lJ28EgNGU1RgkNiZWB3eJi++hfpxHO4G8mgxB3XYoqzhzs4s
         U7t9Pina6vk2+1yFSAwcVT+1uMmNvvm59+SS9IFDxUNObIzOCUhcRBC2O55AT13NiDTW
         3yvA==
X-Gm-Message-State: AOAM53272LpPBovYGHhKgxaaiTxpz9S6DRhEcDJk0mu6AS67O9oTGtUH
        fbu2FwpDc0wUutXju4eNWd4=
X-Google-Smtp-Source: ABdhPJzDKV3JHquItgU/3MOE1X6mUzInt9JmVz3Owv/qzjDAr6iP9bc3q7GiOc0uckrFhAXbK4F8LQ==
X-Received: by 2002:a17:902:a38b:b0:138:d329:27ac with SMTP id x11-20020a170902a38b00b00138d32927acmr9738399pla.7.1632916276769;
        Wed, 29 Sep 2021 04:51:16 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 3/5] kernel/sched: improve the BUILD_BUG_ON() in get_task_comm()
Date:   Wed, 29 Sep 2021 11:50:34 +0000
Message-Id: <20210929115036.4851-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we really want to guarantee is that the buf size can't be less than
TASK_COMM_LEN. While the size be greater than TASK_COMM_LEN is
acceptable.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b387b5943db4..959eaef248fc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1931,7 +1931,7 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
 
 extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
 #define get_task_comm(buf, tsk) ({			\
-	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
+	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
 	__get_task_comm(buf, sizeof(buf), tsk);		\
 })
 
-- 
2.17.1

