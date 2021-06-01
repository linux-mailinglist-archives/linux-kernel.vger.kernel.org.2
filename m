Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C53979FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhFASXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhFASXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ABEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:22:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l1so57949pgm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbZ3vTsrf7AL1s4OczZvI0d4Xr6vFtsv5qsCFIFr27E=;
        b=gl9HxPe/5Z8AZ2F4lr8ZOQp71MrPbaaCd3bdahqNcnUNrrTlGjg5u/ICfWAiyRjVew
         ASq2B4Gz6GujPk3KXnFH5fOEp8Z1NMTELKHy8lWKksJWVQlCZ4Pp7UNfjJCWha2HgcDA
         NniNd3QIrYT4zBskN6hBzikQ4+SKWS0mscod0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbZ3vTsrf7AL1s4OczZvI0d4Xr6vFtsv5qsCFIFr27E=;
        b=oJJ8aLZkFCVFM9OA62HokFWz4DwuE9cee2LIGpIRHBQ3jd704bBGMSw86bBc4lBZEG
         UOC3nCEU+62NwOGzBKAIx1Mx5aZTFwzZJ8BloPgXKHp5E6IlrhefyC8k6lxXobSsoI6H
         kltiGULE7vdOTi2qO/zoGsdMQmfxKKvSKx+PtzA3hKbH234kr03kSAqHD2yz8pPCHsf/
         r5jgujKl6fARjcPmu1F3hRsZqxJ3J6UrhyJlGvz4JxfMZ4sr32K0GBw/ez/yLOKho3hn
         ItiQrkcqwVUVw1YsUV75b7vIQOtzIqiesdg33C0D/4DLlvv5E2QhqHCIfJyyn/UFYamr
         HLug==
X-Gm-Message-State: AOAM532GrUMdmFKQ0AVTlMHgGqmaxlKAGX4InnQuWKE+V5hjpl0HNHeb
        iUFf5HVE6TWtWThgL/pzjWtNeg==
X-Google-Smtp-Source: ABdhPJzvfjCxaSvx+ixy+qezmQZI5gNBZyHO3mHp4A+To1c+U0lrFaUSUqRwdNIxEQ6QmDq4d3KE4g==
X-Received: by 2002:a62:3344:0:b029:24c:735c:4546 with SMTP id z65-20020a6233440000b029024c735c4546mr23503691pfz.1.1622571726225;
        Tue, 01 Jun 2021 11:22:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id g29sm14510982pgm.11.2021.06.01.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:22:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/4] slub: Restore slub_debug=- behavior
Date:   Tue,  1 Jun 2021 11:21:59 -0700
Message-Id: <20210601182202.3011020-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210601182202.3011020-1-swboyd@chromium.org>
References: <20210601182202.3011020-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing slub_debug=- on the kernel commandline is supposed to disable
slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
where the default is to have slub debugging enabled in the build. Due to
some code reorganization this behavior was dropped, but the code to make
it work mostly stuck around. Restore the previous behavior by disabling
the static key when we parse the commandline and see that we're trying
to disable slub debugging.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Fixes: ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 438fa8d4c970..2f53e8a9c28e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1396,6 +1396,8 @@ static int __init setup_slub_debug(char *str)
 out:
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
+	else
+		static_branch_disable(&slub_debug_enabled);
 	if ((static_branch_unlikely(&init_on_alloc) ||
 	     static_branch_unlikely(&init_on_free)) &&
 	    (slub_debug & SLAB_POISON))
-- 
https://chromeos.dev

