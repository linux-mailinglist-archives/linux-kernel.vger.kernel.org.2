Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244AB39E434
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhFGQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233861AbhFGQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623083467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yvt56Lfcj27UjLgNQdHePTO4mUszW+U3ALSrn0EK+Vk=;
        b=A3ZKH8tDcU7JFy5SCUxLvaV/2eNDZ4hkOHwhw/C607ttStupVXaTkPFpFKQHGuIKOtZbI3
        /HIz8mAQMT080UfRSiKg/l0pd5zO0FLw3Wq8wdSwtYQCUzgO2xcidsOJ8b9YnLvPEoHGWl
        wnN4PRDZ3r2IojxEBtiH5lHl3pYppBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-1DGVfwQ6OCeMkHWHCMhJ0Q-1; Mon, 07 Jun 2021 12:31:05 -0400
X-MC-Unique: 1DGVfwQ6OCeMkHWHCMhJ0Q-1
Received: by mail-wm1-f71.google.com with SMTP id m23-20020a05600c3b17b02901b3e8a9db8eso28026wms.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 09:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvt56Lfcj27UjLgNQdHePTO4mUszW+U3ALSrn0EK+Vk=;
        b=OWXoW9WdP8Imnbpj7GaT95QauFhn+oo/ameF8b4N8eBCNEOLJcoO8ZXVoXRV6HtAnA
         Pco2nUnnocmaYkJzlHZGrcnZxPm+pSbmAoer7AUXNIi4vuFcSTpmYJOBaAtYeBfhkkmw
         ALg0zNMx9l1cz4r2QOW2E0lcuU0CuYZKa5R0FCZo+Id4XCeUr7UmJcBTHovS5xMpaf0P
         m9qq8pDtFVmlJohadmKUU5n2UqGKyRWTA81zTxCTOwTzMaWQkp3MBeuUqYB1+ocEn9tR
         C/4rtj9DS+pyuwXryvjHEDsNBIHh6ZN/vpg4VJmYAZxTL3dIEnxM98uYMkIRv5SeNHyz
         l2lA==
X-Gm-Message-State: AOAM5332Ps85mwkMuRCUAUsR+ki0wY+k4mlGbrsth5BRPgxF6Al9KvRM
        qPrHT+AAdjjGC9H56X2T8xKZxiUhgG0oaWpYuIRNI6II7aE3tuCgVrro2TaTMSOaMjq8CGk5S3j
        bWc/bYT1BDDxLyz7c4p9EHuw=
X-Received: by 2002:a5d:4681:: with SMTP id u1mr10848235wrq.268.1623083464533;
        Mon, 07 Jun 2021 09:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYVWuq/Xr6iBgRtwyhimoId1ByqwNrBAXb7ir/Ets4DKU4nAa1oB1RN752sji7WzbaAbTXDQ==
X-Received: by 2002:a5d:4681:: with SMTP id u1mr10848226wrq.268.1623083464398;
        Mon, 07 Jun 2021 09:31:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o3sm17255344wrm.78.2021.06.07.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:31:04 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        llong@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for non-global case
Date:   Mon,  7 Jun 2021 17:31:03 +0100
Message-Id: <20210607163103.632681-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the present time, in the context of memcg OOM, even when
sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
task cannot be selected, as a target for the OOM killer.

This patch removes the restriction entirely.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/oom_kill.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5fde46..3bae33e2d9c2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
 		oc->nodemask = NULL;
 	check_panic_on_oom(oc);
 
-	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
-	    current->mm && !oom_unkillable_task(current) &&
-	    oom_cpuset_eligible(current, oc) &&
+	if (sysctl_oom_kill_allocating_task && current->mm &&
+            !oom_unkillable_task(current) &&
+            oom_cpuset_eligible(current, oc) &&
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
-- 
2.26.3

