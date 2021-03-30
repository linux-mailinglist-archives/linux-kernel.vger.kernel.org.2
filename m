Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F534E47C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhC3Jdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3Jd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:33:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39191C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:33:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f10so11288839pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lduqHFKp9S7OaYsssCl48xW0vplLrq2DOjVcnyfygg=;
        b=EqDEf509qty9+NAV5sKxmDwkQd2jmI/epVeNxpEhmZ3BfS26Ts4cm5hjcL7ge1lYxU
         9GDJUvGx2pJ7AK//wzvSfVvYwqkFP7L6d1U6cC5F1nSkWjHjpnozyXTeH+doeH3CG0XD
         GEPRFsdWgdFLKqRpIu0leO6zGhVjKIBSJnq2GF1UuKxFVdYhhwz5Fxj/091JuK1zI0Ql
         HHz5FtM0d35TPPkY+NW1BDkPOP0mh2zLGEIAWlQIf5tNBYMLiIW+67ylgO4yoLSexUK5
         V94ypGjcatp9LTrYyyTbIPCWFyfWhqGaMBBDbWDkS1zu3LPuzw07VAy5Oy55w0a7q6Sw
         5nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lduqHFKp9S7OaYsssCl48xW0vplLrq2DOjVcnyfygg=;
        b=VeWANEpca0hvWTt4y/0B2XYR6/yWUrx3GQ4Lh/uP8zuElnbxTbUyzRXyJHZ6xhQoxf
         QFxPUQxbQrDVmRfDRkFYr0ZprxyNNZHvHh2ICP5WPTMmcBiqgBOx1eJHjqf0wSPXo6pc
         3eBJHiI6ynTXVJDylVWTw/zt39BqQVxk9p6K2hXUIb38Q7eMVRU5Xrs2V69lucX/OQAE
         orcaN6Lx/IFjCoJpc2n2Yq7uF3d7CiAiLs3gAtMZlIkuCKfqnA7nYaSjyc601aNVEW5q
         Xs97K08moTgLH06zQDfmsHm8I4+k4ETcO4DpnuYad9N5EgJ96N5RpyiIxsEVs87jB3T5
         40Fw==
X-Gm-Message-State: AOAM53335MACgUbNFZMHQVb2B3Sfg2VDsOlE7wqRGvl6V+G9TTg/Fk/M
        3svE79vNDUch8VbB6YkbgmXEqg==
X-Google-Smtp-Source: ABdhPJx3zYEHC3B3E6bmDyTk5AnudTf5JJxNoCftwZMlikdxmizHWKJGJAi9Ehkrak2z9QZCYh/X8w==
X-Received: by 2002:a62:8707:0:b029:227:55d6:c8f9 with SMTP id i7-20020a6287070000b029022755d6c8f9mr11912172pfe.76.1617096806790;
        Tue, 30 Mar 2021 02:33:26 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id t1sm19940192pfc.173.2021.03.30.02.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:33:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] writeback: fix obtain a reference to a freeing memcg css
Date:   Tue, 30 Mar 2021 17:29:33 +0800
Message-Id: <20210330092933.81311-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of wb_get_create() should pin the memcg, because
wb_get_create() relies on this guarantee. The rcu read lock
only can guarantee that the memcg css returned by css_from_id()
cannot be released, but the reference of the memcg can be zero.
Fix it by holding a reference to the css before calling
wb_get_create(). This is not a problem I encountered in the
real world. Just the result of a code review.

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/fs-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3ac002561327..afa658ffc09f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -506,8 +506,10 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	/* find and pin the new wb */
 	rcu_read_lock();
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
-	if (memcg_css)
+	if (memcg_css && css_tryget(memcg_css)) {
 		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
+	}
 	rcu_read_unlock();
 	if (!isw->new_wb)
 		goto out_free;
-- 
2.11.0

