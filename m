Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7443EB705
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbhHMOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbhHMOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CBC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:52:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so20995138pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcrPB/u3ACgDbGVdJ6D8+owgN09TOJjUPqJ+1q/GnDg=;
        b=Os7e1pr0caHY2klblJ3wNkF1Zdk8usWhBzvwf680YyMEjzhHtqDTxpQYvfDNdjHkeG
         FEwtXSFD0dO+tImQ078aFzs5rk8B5eXcOQTqu0BLUs/ajvHrNrNC7st3xX/jND/Lmij0
         /6zUaXeC4P2vTCN05hYMj+QEM0mqarWQqAq41JGfLFgr0lXPXJkUdXlYEYVgCsU+oiq+
         dMMqoodNaSJv/JUnrYnvXZnRW2dIT7t4J1Z3ne94LKguZOUamRL0/J/87EUKF0rLUJz7
         GVdqEcAMezXNw5ibn+f2D5eh2uFP/ia2jJ6znuoCmEkfauZqtn2AUCBYzAJVl5H3W+Su
         y5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcrPB/u3ACgDbGVdJ6D8+owgN09TOJjUPqJ+1q/GnDg=;
        b=Uz4QN483kdfIo1v6X8Q4a0cpY/eQwf737fASA9YfJS2UM5S8SYOtVNSMJCayyjKVoa
         bwd2PHyrXl5SGFp+sxjUhlC5styCcseRnLxj778oaxkA+/97EommKrcGJPTj0bgPJ48j
         aeEm7YGoXt4g3jTkLHgpEre1pq/HNBwVexTAn37We61qzzbt2fqJ5717dGI0BdRfIeXZ
         /IcoCDnWRM44TaqASxtqKQD48JHDMQsR5A+NcUzWXWuUD+p8YCANQN5y8pFicJo06vMD
         cxcZKU9oANL8KPO4c+p64zgMA7zx1Kaw6F8zyqvo59hEp6n0E37lZscBN9erh2NlcqWU
         6Ymg==
X-Gm-Message-State: AOAM532nHFfCDBdrTCqexZfJbsbN2spY54JONR5M3xEaGNLQK/wIWyjM
        GQxyQ5j1HVbWpsQ66mPL4ZA=
X-Google-Smtp-Source: ABdhPJxqWtVWJfFUQYrABSADG4W5DQobHTzVnDZI5AcP33Sjaf/7fmEyjBck+sQr9r0ga/cw1kUqMw==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr2402832plr.82.1628866378659;
        Fri, 13 Aug 2021 07:52:58 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id q11sm2490535pfk.32.2021.08.13.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:52:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm: in_irq() cleanup
Date:   Fri, 13 Aug 2021 22:52:45 +0800
Message-Id: <20210813145245.86070-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 mm/highmem.c  | 2 +-
 mm/kmemleak.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 4fb51d735aa6..4212ad0e4a19 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -436,7 +436,7 @@ EXPORT_SYMBOL(zero_user_segments);
 
 static inline int kmap_local_idx_push(void)
 {
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	WARN_ON_ONCE(in_hardirq() && !irqs_disabled());
 	current->kmap_ctrl.idx += KM_INCR;
 	BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
 	return current->kmap_ctrl.idx - 1;
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 228a2fbe0657..98d0be54628d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -598,7 +598,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	object->checksum = 0;
 
 	/* task information */
-	if (in_irq()) {
+	if (in_hardirq()) {
 		object->pid = 0;
 		strncpy(object->comm, "hardirq", sizeof(object->comm));
 	} else if (in_serving_softirq()) {
-- 
2.30.2

