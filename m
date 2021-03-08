Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B93309DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCHJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCHJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:00:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96816C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:00:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so2598160pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pXqQKfOnSJI+qHzrd8W/hQRHzPfCp7ycjownQ6DzJZE=;
        b=RN8Xly3iPJqWRhT1m9LzPwiIP3PSnheEbTQTb5Ff4/2zoTb22P318t6wmpH+LCE7OT
         s5KdaGwJryqpLZQLzL+o1feOo/yYZX3ft4ot+YxIG3mCg23+pgM23KyqegfzLqoE+ynK
         0w6xj5pKYTSo9cL8hKPqQrawpvtNbVEYaL4oHkYpD67q16nxAyMmvscdN7UQv/biw4O/
         A4jBRKbxDyC2ZZEoLoxcfPBMGP3GFYW/+IasOlQu5KoUcsjFTw0EuJsq4Lc5IwyNfe2j
         K0mOlAQ/bjoEJqA1I+3sa2HVz0DY+DS/3OXT/0J2AuYvFz5+hTlRLt9shh9UlCfoa3PN
         xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pXqQKfOnSJI+qHzrd8W/hQRHzPfCp7ycjownQ6DzJZE=;
        b=twFPwm1hxRqmAXhYQiNV/mkNCJZWGuAYDw6JCd5HQtsX6fUwothkl6xKFTneLvjIsG
         twaT+g1IYIGOX/aK0RE1TIDVOkAu16Xr3iK8J3chmfeZDIo5RRDDMhj1Yp8jq/ZS/9lH
         7zK+fNTWsgBHQXBqRzQshzIdAcM5nDhKR7zNLCryNglg/7gZ7s5DGS/6pklZ6PoMUOE9
         z7zw6+MeBZuA8qbidnpVnb1tIzHmn0LI7cl9Rd9sRqnR8HBc+rHWd8wiVvmw8TJB7acJ
         t2+EuIao8Dev/4IJRtxROx/3k3bJ67XKDJO3UuVNCSE3basaqjfAWEOftEIbXXJyIEIu
         0f3g==
X-Gm-Message-State: AOAM532/ioLNbVLozrrMsGU9BD49uTuftJ/OjOW0G3YzzZxrnvTts2YJ
        l8bpRP5djl3T0dZDX6jCGMc=
X-Google-Smtp-Source: ABdhPJyF9yXNYPSn0ghWFrOwzE9Hw9zyuIY3fTctBT7LuUkHjewJNdiVJTnz4foHTIXJ81MEjvRFDQ==
X-Received: by 2002:a17:90a:a503:: with SMTP id a3mr15834493pjq.235.1615194009137;
        Mon, 08 Mar 2021 01:00:09 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.99])
        by smtp.gmail.com with ESMTPSA id s18sm9550643pfm.129.2021.03.08.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:00:08 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        matthew.auld@intel.com, chris@chris-wilson.co.uk, lkml@SDF.ORG
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: i915: fix error return code of igt_buddy_alloc_smoke()
Date:   Mon,  8 Mar 2021 00:59:52 -0800
Message-Id: <20210308085952.8153-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i915_random_order() returns NULL to order, no error return code of
igt_buddy_alloc_smoke() is assigned.
To fix this bug, err is assigned with -EINVAL in this case.

Fixes: 1fe3818d17c9 ("drm/i915/selftests: try to rein in alloc_smoke")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_buddy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_buddy.c b/drivers/gpu/drm/i915/selftests/i915_buddy.c
index 632b912b0bc9..cf9b551b77e1 100644
--- a/drivers/gpu/drm/i915/selftests/i915_buddy.c
+++ b/drivers/gpu/drm/i915/selftests/i915_buddy.c
@@ -318,8 +318,10 @@ static int igt_buddy_alloc_smoke(void *arg)
 	}
 
 	order = i915_random_order(mm.max_order + 1, &prng);
-	if (!order)
+	if (!order) {
+		err = -EINVAL;
 		goto out_fini;
+	}
 
 	for (i = 0; i <= mm.max_order; ++i) {
 		struct i915_buddy_block *block;
-- 
2.17.1

