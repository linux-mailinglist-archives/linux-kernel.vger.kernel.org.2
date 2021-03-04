Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90D32DB78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhCDUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhCDUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:53:42 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FDC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:53:02 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p15so12969wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4CjcEvJ61GkUIoAFgSTKRu5Tq1H6wn08RVLBK2Lt0I0=;
        b=kQcOCQ/cMB/X2WRSuwsg8LBq8X+nEul9d6IKcKn7tPT4uxnd5PINYXXdeMrZdAE3Ej
         zqbHl++wLZTRVvYlU6lwOasPy3DOcMt0FVu+/aCX6o2vfuEpE1DFuOUHZh4FoD0sx7MW
         dgZQizaqek8333Yq8IIeacWBNyot8v6B/FdhLhlW8Aju/OFuVbxcPdSIkysxPYTK6KdC
         ceAmKMO0lt/2+V3pFnTKJRcKZRgFbg0XO5rCQKb8OkxZRW2o/I0qYJnCezuIQiYNe3dz
         6xinkRvy1YAnPfeZjNGHpn2UaEQw67OZisxF6BqziY46z7vtzn27GihW4JeIN601IeB+
         jtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4CjcEvJ61GkUIoAFgSTKRu5Tq1H6wn08RVLBK2Lt0I0=;
        b=FZEQNN8s1ZcJYCpqteykVDlZdu95dB3/p17uux46AyW/+HnIB0lMRh7e1LoPDcuWCk
         hUtAX3iqjfhl0fPnVS69OA0vCQvsC5m4g013srV1u5C8oHFrEKeHoi5mdHD5jgz7zu/p
         oxhuMLIHs51oa2eiesR5i5j4Er1GhDPXWWy4INw2wxmZ7dZphDf4DVZ0S/SsuBW92Iz3
         MbDHB6vu3BJFqF50YwNQ754ZBKgDwytie7sHgLY1qac+mh4pJ5WlpjBFSfEEHJzzCww4
         q82bxHk52GhYGBb8AvhcJt46/mEAv+rc74YsUkH7kFd9IB8IBGCIGyZvof4Y4a78DxxG
         x3wg==
X-Gm-Message-State: AOAM531vblGQxor67Low/cx2AmzAygOb0HEp8DlfaD/qcX4Ff3TVp2d4
        ofXLeVeVdHYtg+PBs9ZpH2GHtIKiZA==
X-Google-Smtp-Source: ABdhPJx7HwfiRm3Q+u5arI/IWcJ3KLG5rJXKgeoYlpazKcjtB/gExGHlBdBa1ZrXsLoc4m0JMTrmb82jKg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:adef:40fb:49ed:5ab6])
 (user=elver job=sendgmr) by 2002:a7b:c18e:: with SMTP id y14mr1459027wmi.1.1614891179563;
 Thu, 04 Mar 2021 12:52:59 -0800 (PST)
Date:   Thu,  4 Mar 2021 21:52:56 +0100
Message-Id: <20210304205256.2162309-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH mm] kfence, slab: fix cache_alloc_debugcheck_after() for bulk allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cache_alloc_debugcheck_after() performs checks on an object, including
adjusting the returned pointer. None of this should apply to KFENCE
objects. While for non-bulk allocations, the checks are skipped when we
allocate via KFENCE, for bulk allocations cache_alloc_debugcheck_after()
is called via cache_alloc_debugcheck_after_bulk().

Fix it by skipping cache_alloc_debugcheck_after() for KFENCE objects.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 51fd424e0d6d..ae651bf540b7 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2992,7 +2992,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 				gfp_t flags, void *objp, unsigned long caller)
 {
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
-	if (!objp)
+	if (!objp || is_kfence_address(objp))
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 		check_poison_obj(cachep, objp);
-- 
2.30.1.766.gb4fecdf3b7-goog

