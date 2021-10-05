Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886A7422C88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhJEPdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJEPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:33:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C6C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:31:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id t11so11714811ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tVuQHObub2YNkMXj0VdNY1wP8i2BNR3veQbUik+SlKs=;
        b=tr0pADEUH6MVI60YI4iYvD82dol4p6zxiEPt9Uvw8Qn05LlXRqJhO59D0SIKDngSfw
         zmV8locsvef2a6+reUDFlrasoUwklCU52eE+O+MPVZF9kfAkhm4Ad4w52+kI+y6h67iV
         sG73suJbBtfeU/bhksIXMH7daeyuKOlSaV90+CUL+ux9/0eEbjiyQ0VfgUvRXAlCNgMB
         Zh9sW8jfYW9CkmVII+Nny1So2AakkStn7UaZI/rPd/qDlefxQEsoVqiV58eWws/yun3G
         lzJPZDyCMjVw38lcLlPxXFbKYHcSaDqJdN+lCWnjYHSuHrybjNglHaJ15IIIGNl2hvxo
         Ycfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tVuQHObub2YNkMXj0VdNY1wP8i2BNR3veQbUik+SlKs=;
        b=UpcrPnoKOZMj2qcB65f3e08Pgo6W/KuJPupkQP/J0AKZ4tacUpDdCs0xDhWqvVZOEZ
         FAYoSeN2I9e6D9h8kFq6LrnDMaSd9govnekipQZIYhCqfQpV0cR4Xp3OCMwIdF8H6XZM
         RtgRz9j/NBiqxLfuFOCuouvZNMXoTqIvLJR/Qzm5AB0M2PuCRiFNJwHnfi1W9mevtRK4
         KOjt4So2dB87ZioRYQ5LP30L7zM5QO+FxOD5vKVVOXe70XTHlc3Ukx7HthF6ateKk5jN
         DJnjM8ImLsXskLVJG1XvntSvPUy4/a3M8f+nxeG92LPIz3pAt+OdAR7C2utC6AYQ6mnZ
         GZkQ==
X-Gm-Message-State: AOAM5319ftQTAtDB/0VQ67de2sFffyPWpq/2L9luQkKm0XbHBFhI3EQh
        wxE2buWJ6DPxNAt6wwHJ8AlD91FCW1fD50P4W98=
X-Google-Smtp-Source: ABdhPJzLni+rsnmQVPlhbLAVIyVjpQ14PZPb7Tizzee1xyL/Z3EPYMktlTDKiaprnhaEjLOh/4ItlA==
X-Received: by 2002:a92:2902:: with SMTP id l2mr3149258ilg.276.1633447904257;
        Tue, 05 Oct 2021 08:31:44 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm10858206ilh.67.2021.10.05.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:31:43 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
Message-ID: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
Date:   Tue, 5 Oct 2021 09:31:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocations can be a very hot path, and this out-of-line function
call is noticeable.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index e525f6957c49..3128d2c8b3b4 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -64,8 +64,8 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
 
 struct kmem_cache;
 
-int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #ifdef CONFIG_FAILSLAB
+int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #else
 static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..92fd6fe01877 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -491,8 +491,10 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 	might_alloc(flags);
 
+#ifdef CONFIG_FAILSLAB
 	if (should_failslab(s, flags))
 		return NULL;
+#endif
 
 	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
 		return NULL;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..c21bd447f237 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1323,6 +1323,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
+#ifdef CONFIG_FAILSLAB
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	if (__should_failslab(s, gfpflags))
@@ -1330,3 +1331,4 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	return 0;
 }
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
+#endif

-- 
Jens Axboe

