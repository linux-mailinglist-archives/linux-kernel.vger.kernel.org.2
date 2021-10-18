Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9804312C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJRJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:12:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB9C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:10:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so14241298pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xioT+koXIxebA9dspAm78A75nR8cRoqI0SF6RXcJ5RI=;
        b=ndajlqSWHaZlQB94T2zSV/2oF/POlNDLh4sHSMX1VYoaQK/DcxxIWZFMkEaPEihcRu
         a4sKtBIXRAyK0ThUKX4iC6iMspSo0DiGCa+PzyeLeALzknBHQCrPXFTfhs9BYRgZ8VyS
         OCk2W4IvZjSYg8PDOmUAnKFRcuz1D2vzBl25x9gxB2+YrpZDkoYINcoq0KMwNv1B7Ol/
         0A3KGhemmwPlt1eAKIwW/fF0aeIDpIIucf5b51XGIJ0HaZnva7LeaYs9NuLJYW06KswI
         gqbhPm7/QEqP+NB0lU4WWjY5e3g77FWwN0Jtk6HoY/70jjZk/+j76z6DZzH0b3qKGTCr
         y4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xioT+koXIxebA9dspAm78A75nR8cRoqI0SF6RXcJ5RI=;
        b=F6CzTJlVnGcLfyPEGdMXBlkuAE2PHwBNfLM+f3UtjcRlxjMEGq00ylTa6nY5ZH0i9g
         SugqyXBkyqq1bsJkjFTg1QXymRBB6F25L4Xy7+ba+IWRmFi2aFtjnK9U4Ed12RJiUQnI
         21XQfGuGtwd2Q3xUwoxd6iYEu/ChilDQl28nb82IwABVcKZaZrVvorN1ddumLwVnUSaQ
         RjIyRpWEFgzDh4zLXcksOcA3MCKHMlGrdG/ho6xNAWnd8zgx0W/PZ3nzaiJyMshpKxtY
         1WEW8T5DNsH7nl9BkpJ/VZRVkBGUoOLPW4TazFU6vWbUHkTggKlcZ5R9qhHfKVG/fIh+
         r+fg==
X-Gm-Message-State: AOAM532f7068zBbzzVVI6H87EHLlYNxe8baQsw658Afd+5kdci+qWTb8
        IxUVJ56vKPfhCZNcz1US1vg=
X-Google-Smtp-Source: ABdhPJzPhb9/VAhFuUK1JCWy5DyAO3aciKsybxFH6aVt3H8C6TeL3QHPzDv/I7RJYRUD3IewBK+1uw==
X-Received: by 2002:a63:e516:: with SMTP id r22mr22994185pgh.197.1634548201705;
        Mon, 18 Oct 2021 02:10:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j198sm12264705pgc.4.2021.10.18.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:10:01 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, penghao luo <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915: Remove redundant assignments
Date:   Mon, 18 Oct 2021 09:09:55 +0000
Message-Id: <20211018090955.857276-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: penghao luo <luo.penghao@zte.com.cn>

The assignment of variables will be overwritten later, so the
assignment here is meaningless.

The clang_analyzer complains as follows:

drivers/gpu/drm/i915/gem/i915_gem_userptr.c:291: warning:

Although the value stored to 'ret' is used in the enclosing expression,
the value is never actually read from 'retâ€™.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: penghao luo <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 8ea0fa6..f6f944d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -288,7 +288,7 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
 	if (!i915_gem_object_is_readonly(obj))
 		gup_flags |= FOLL_WRITE;
 
-	pinned = ret = 0;
+	pinned = 0;
 	while (pinned < num_pages) {
 		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
 					  num_pages - pinned, gup_flags,
-- 
2.15.2


