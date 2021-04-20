Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61937365770
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhDTLVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhDTLVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D34C06138A;
        Tue, 20 Apr 2021 04:20:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lr7so3519780pjb.2;
        Tue, 20 Apr 2021 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wHtH4uowNcGLatA4FtFRbjnON3Vo2NBBY5rs+rY1XYM=;
        b=c4/sSzQKcasmJkJFn4h93qpMW9dQmHFZ7rEnFMeO/cWgHkP/NKVhBySiwfSEEV2h2i
         SK5MMPJeJpi1qn2almMXadtczC26Q87pnBvU37VYCMbw4W0AYEI9jBE719Dettio+HQ6
         seeW5eKU/He3sCV5m6pDsakF3+TDBLjSAHV2/F3Pc1+X+X8Q85HE3WTPoJVF1NbphZss
         bzMe0tQniY8bUcVw1a+uWbmWZRn1pZouTfonSXxir0csBmO5HlvCnPPtNSbiW0RTolww
         ETyeaXnSmqLdY45fGl0nDKhBRqiJo2RhwJJPiXXGrt2vqt2bnWjanK7z3OuaiHCqCKVY
         5PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wHtH4uowNcGLatA4FtFRbjnON3Vo2NBBY5rs+rY1XYM=;
        b=QEMPpXGIrGRX3H0BC/S8WKImA2vEncRKTO3EtpORTkb1TiOKUJTyIPwVe3it0yU2f2
         2vUNImizFijWd0gVMpwQJWK8opsi25Wp/4uXlAZJQOtlUn8xF42d/2LAriU2OgBZqJb2
         tQZNOo6aVjw8aYp4GPFxP5vOHsWGa8WCzyd0YMfOtxyyq+66thd9vG1yiY9aspakk0eN
         5oXbMyixobum7XpI6uegug5yDSzK8T8l76k9V7Kg7a2DDxgkr19XUlGeS3dA3KKH5Gc7
         X85slANcJ2+nNWL7slZFbMS+UqDaB+Lnro2ExUfGM0Aw5EP3sRMG+zrSJzaHYu9gmHKk
         mr4Q==
X-Gm-Message-State: AOAM530NTlgE5sV4DLbmvs3kv6iOzVtZBDjEUN32Yq0lmGta1h5GitRt
        rD6shFglQ6qTqUoC7I6EmvFRhcl9XKG7zA==
X-Google-Smtp-Source: ABdhPJzxpmUrNZFFmUXZ+fGDda03R/VoG50oqI7bVzBOxaMsrqDWSkfK3RjtkMGHDa/Z+yBeIgemZQ==
X-Received: by 2002:a17:90b:3649:: with SMTP id nh9mr4318932pjb.0.1618917635184;
        Tue, 20 Apr 2021 04:20:35 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:34 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] bfq: remove unnecessary initialization logic
Date:   Tue, 20 Apr 2021 19:20:22 +0800
Message-Id: <686dd8506bb511ae181a99c9b45f287233aa2ecf.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since we will initialize sched_data.service_tree[] in
bfq_init_root_group(), bfq_create_group_hierarchy() can
ignore this part of the initialization, which can avoid
repeated initialization.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 50d06c7..c8c68dc 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1429,15 +1429,11 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg) {}
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	struct bfq_group *bfqg;
-	int i;
 
 	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
 	if (!bfqg)
 		return NULL;
 
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
-		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-
 	return bfqg;
 }
 #endif	/* CONFIG_BFQ_GROUP_IOSCHED */
-- 
1.8.3.1

