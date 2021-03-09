Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EA332022
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCIIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCIIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:00:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:00:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q22so307458pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 00:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lERI+RcuaOVUthLZgXka9OjhdpFhCMhKR8vi0cIl6ww=;
        b=NvUD4rFi4rvV6hM1VQa0YAY5Q8LaxeDW3AMbLKTmTwHhD4jTciYnLNkdQ16rsomfbT
         AaVPSxu4VQILbLirVzi7k+Y0BHj8SzNKGrC2rW/J7M0D50fXiSGsaY7oVj3c1Dy2usNj
         vtBjZjvlG8l/sNo3q3hfWhenlnq2OSPCm6t3J9E2Xn/bWKzFkj4o5NWChSpHM/spNEn4
         /YFiiRDupyghowzX1ka9UF+Xk2iViPpeTj02WENFpgVko3UdPe88GWKJpLUm4E/+gKqK
         zsO/B0JkgzICroANm1rsiMiQBkswLedjhCU1P15FUcxQikCtrPaY+fLzxcVDuK5BjBK/
         U11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lERI+RcuaOVUthLZgXka9OjhdpFhCMhKR8vi0cIl6ww=;
        b=QXpyGaNjk3oG5Cnnxs1u7R19qmL8oqAWsud7wkJS9a23oq3uoPoiAlXBn9C3XYnggC
         PM8hujlMiaU80Yj2WJwc2FxIPIRicUIPa/MdrkbjVXWFMuVTMxAUQcx/sSgyFJbOd42N
         UckrUa0gYKlYtIPz+yUYCHK2LjHgXFqpiMEDw2g6qik1FRa59wUtbR3bvcQuX8NuTRtM
         yG1IAUkX5ZvpbvJIukOlByNrCsMbvP5cCHwm6YniBnsCYT/N/fT8W7CNIOWyxhyVn2XD
         AE94/ixhRde4UbVPzIyfT4h37wwo2XNVL7oT2iGmoWbBR286RNpU1SptaUEhsbNmU08d
         YkUQ==
X-Gm-Message-State: AOAM533HIJaMpAUJcFVVISplT1mOFToHkSmnHDOYepgqBaoQUI46v97h
        cZvw8fmB8kCYBT8eqshuBUPtzxwwWJj8Tg==
X-Google-Smtp-Source: ABdhPJzEEHiVC8/3ka886QY1ky/wLbA+A4+/mU24Rsf/GbrqRTIQcrjAm+/P9sB7YJIjEQEvfgZV+A==
X-Received: by 2002:a17:902:e2d4:b029:e4:be01:1d9a with SMTP id l20-20020a170902e2d4b02900e4be011d9amr24992691plc.43.1615276828666;
        Tue, 09 Mar 2021 00:00:28 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id cp22sm1942020pjb.15.2021.03.09.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 00:00:27 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: orangefs: fix error return code of orangefs_revalidate_lookup()
Date:   Tue,  9 Mar 2021 00:00:20 -0800
Message-Id: <20210309080020.23014-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When op_alloc() returns NULL to new_op, no error return code of
orangefs_revalidate_lookup() is assigned.
To fix this bug, ret is assigned with -ENOMEM in this case.

Fixes: 8bb8aefd5afb ("OrangeFS: Change almost all instances of the string PVFS2 to OrangeFS.")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/orangefs/dcache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index fe484cf93e5c..8bbe9486e3a6 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -26,8 +26,10 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 	gossip_debug(GOSSIP_DCACHE_DEBUG, "%s: attempting lookup.\n", __func__);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_LOOKUP);
-	if (!new_op)
+	if (!new_op) {
+		ret = -ENOMEM;
 		goto out_put_parent;
+	}
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
-- 
2.17.1

