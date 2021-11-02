Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DACD443454
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhKBRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhKBRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:10:38 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D9C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 10:08:02 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n189-20020a1c27c6000000b00322f2e380f2so1443295wmn.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VZR4veHDB/Hv5J8c9l5kvLwMvvSzVFvPkC6CzrVLaSc=;
        b=h5ZsJTLfAG9mNnQa0xWFAL2KxUVTpouTD3NLPXa9euGiJQFSkr8NLeCyb+LPhUqP4V
         CPA2cifJNDzf9m/dmWlxblumpDSRXmGZiavxecw6BQJ96z2N8jO+p74zDsfB4VZZpLCv
         PmQc1vrw1arnNklp77e5CMB5UGoAwRo1MCEk1M6IfXh8yLkVc27xokue/B18c8j0vRAc
         KBecirNBiVNE0bMRB52sbc1zt17fEXCH1dZys8h9YwrObCrr3Hk863S5dozbA4NqD3QX
         6Yghlp9lPxhgjSIpsyDH5v1/oyULTQrrKGG4bz9Dwe9VREtkSvgGaNuyrq4T5QWD5Iti
         Ts8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VZR4veHDB/Hv5J8c9l5kvLwMvvSzVFvPkC6CzrVLaSc=;
        b=D5Sv4VBV2Fdv/SJJfrc7IeOE+LnY5rDh0bUzknK1dB2/1FDjMQ86YvM+yrEAQ3teAT
         SunWNugj7DBqG2GufWjWp+RlhKDM7aoddT1VZmdPMOewDyAZnaxsTe5Wqh9QBF4jNxnM
         tQJ0FbHzH8ko81AOWf7xLqplh7LERFJxP7QLk2Qghe5UAulGGVTMYaH5hsZYq613tiSJ
         w1XAmeZhoaOLH3Jr8lSwPf/1OCyoUq+fIvmTl/hEJcKjmIRkfaGp1xumiSj8aBfKHBFq
         YeQ/C6myfSu4lw4pGulKplO5veZ8lFry4i4RjTgjn7+egJgdpl71tmWFraZabYYv/Kld
         0WFQ==
X-Gm-Message-State: AOAM5333bZPU/X+vCB/kiAglq3KzrE2OUg9bOvIMF6eVfsdjmZgZyzuf
        +q7Hlt1A6KUqV50QMOqC1ipmab18GQ==
X-Google-Smtp-Source: ABdhPJwsVlfeyltofJcj5J/2mtf997JPKCeDSm4UOFJj0uTkZTZ3OpdauGeH/9tTUDezWE+nVfvjDDTIJA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c225:73fc:3369:a4ae])
 (user=elver job=sendgmr) by 2002:a5d:51cf:: with SMTP id n15mr38162615wrv.106.1635872881388;
 Tue, 02 Nov 2021 10:08:01 -0700 (PDT)
Date:   Tue,  2 Nov 2021 18:07:33 +0100
Message-Id: <20211102170733.648216-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] mm/slab_common: use WARN() if cache still has objects on destroy
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling kmem_cache_destroy() while the cache still has objects allocated
is a kernel bug, and will usually result in the entire cache being
leaked. While the message in kmem_cache_destroy() resembles a warning,
it is currently not implemented using a real WARN().

This is problematic for infrastructure testing the kernel, all of which
rely on the specific format of WARN()s to pick up on bugs.

Some 13 years ago this used to be a simple WARN_ON() in slub, but
d629d8195793 ("slub: improve kmem_cache_destroy() error message")
changed it into an open-coded warning to avoid confusion with a bug in
slub itself.

Instead, turn the open-coded warning into a real WARN() with the message
preserved, so that test systems can actually identify these issues, and
we get all the other benefits of using a normal WARN(). The warning
message is extended with "when called from <caller-ip>" to make it even
clearer where the fault lies.

For most configurations this is only a cosmetic change, however, note
that WARN() here will now also respect panic_on_warn.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/slab_common.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..0155a3042203 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -497,8 +497,6 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	int err;
-
 	if (unlikely(!s))
 		return;
 
@@ -509,12 +507,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->refcount)
 		goto out_unlock;
 
-	err = shutdown_cache(s);
-	if (err) {
-		pr_err("%s %s: Slab cache still has objects\n",
-		       __func__, s->name);
-		dump_stack();
-	}
+	WARN(shutdown_cache(s),
+	     "%s %s: Slab cache still has objects when called from %pS",
+	     __func__, s->name, (void *)_RET_IP_);
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-- 
2.33.1.1089.g2158813163f-goog

