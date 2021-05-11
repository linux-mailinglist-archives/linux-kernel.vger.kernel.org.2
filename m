Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557C37A762
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEKNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:17:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhEKNRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:17:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620738997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pd3fEfzBrzOrkq1JY1d5cYXuP5xKjB+6k3CX00vHtuk=;
        b=r/bgiUlXW9PNoPsuD0Pqvk9xQfqLyWg/STLoDWjztuGG/v9NhLlsvgP+sDXt1P1fGRJZSl
        MokOmDx+hhvqp38bWfqNTs8z9NictHfylZzTI2vetR1S3sMGzDnWjBIguPzymU9/OP8Ch0
        KNRYykuuIMf5Jku/fR5p4gadoqyA41I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF8C3B1D7;
        Tue, 11 May 2021 13:16:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     dennis@kernel.org
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] percpu_ref: Don't opencode percpu_ref_is_dying
Date:   Tue, 11 May 2021 16:16:33 +0300
Message-Id: <20210511131633.185463-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 lib/percpu-refcount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index a1071cdefb5a..af9302141bcf 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -275,7 +275,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
 			    percpu_ref_switch_lock);
 
-	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
+	if (data->force_atomic || percpu_ref_is_dying(ref))
 		__percpu_ref_switch_to_atomic(ref, confirm_switch);
 	else
 		__percpu_ref_switch_to_percpu(ref);
@@ -385,7 +385,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
+	WARN_ONCE(percpu_ref_is_dying(ref),
 		  "%s called more than once on %ps!", __func__,
 		  ref->data->release);
 
@@ -465,7 +465,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
+	WARN_ON_ONCE(!percpu_ref_is_dying(ref));
 	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
-- 
2.25.1

