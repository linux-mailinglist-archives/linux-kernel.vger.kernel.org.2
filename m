Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205C3FE646
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbhIAXjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbhIAXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:39:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3CEC061796
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:38:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so188452pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=np9yXpAi1Pec3CPMJHXf2bgsvhEwG3KDrK8xe6dniXY=;
        b=XrDUvfaSRPhHFu6OiKJ+27rYlUA0tUaReZeBT55d/ORmDSKJaTXk91lZY+JNJlUOJb
         +PJv1QNbBU7vYs5ti8mCSoRW/wDEeasD9IobeBp76vkrymBFbimOgJpu27INFRTPdLiz
         rNFK8xucPOAXRSmJiaopBLC6ZNIBSBdUEdaBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=np9yXpAi1Pec3CPMJHXf2bgsvhEwG3KDrK8xe6dniXY=;
        b=EhrwkbuQNzqgiANpSzm9IiFujOTbRbJUe1tPBhw+/Ne+JQRKDIPFdK1lmtKsepsNHH
         Rwhu9MjDAVRjioDa2m94KwEJ31XU0wtQmTULPG76sx6F2CQyIFbCQmPEJ7ygEqP5hhxu
         sklQjhmZ5zYNa3LUv/kkv8XM+PAdx3ivXmdp5sLwDXx3rk4VvaYsey3D1/FDWWKD/khr
         ZkMxKccCFCIB6DZSzzlRyrXONBw9rHykubfZPVWGWmbEkba63UAGT/rRV/ssfTuMtfYG
         AqrhyLIK3prxjmkd0hb1Rj2o8lCN3/x/qDawpWqA7DSQbNLQkkDIAQLztG//Q0nXAFEV
         ZQzg==
X-Gm-Message-State: AOAM530aDxbMRjEF9V5nsIT3Dp0UG/d6xReuznvA/rlsieBGF2Q9oA2e
        VVudsqyrdw/r160PvM09VhHcqQ==
X-Google-Smtp-Source: ABdhPJx4jrm3+NKpnau+9R6qA75ParitjlgXKNplEdsHenp19e3xfX1dbfLz0+I+njbB3AyLDuvPYg==
X-Received: by 2002:a63:a517:: with SMTP id n23mr208818pgf.412.1630539482268;
        Wed, 01 Sep 2021 16:38:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10sm81784pfo.75.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] module: Include .static_call_sites in module ro_after_init
Date:   Wed,  1 Sep 2021 16:37:57 -0700
Message-Id: <20210901233757.2571878-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901233757.2571878-1-keescook@chromium.org>
References: <20210901233757.2571878-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; h=from:subject; bh=4jSl5dHsXqTpG4oJluProg2yWmW/Ve+LsdCZEC6e1Dw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7VAXOzsg3zZLmJUMu5Lg5kAnuK37eBljxDh1gM k8eqI7iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1QAKCRCJcvTf3G3AJgzgEA CGmpZ6bb2D5q7shwYr1JAXzYhtqCHxJNX7EJneeUy97bxESmDfaxW1AlZ2Ouv9CgYRQ/56ddioBKcH ytiVv/2ldJYkGni7UJGjrrqEZqcfogWk5Rgc9pkNMomcMy8YzaExDVTsFngO5uUVMmxPZh9pFCmYPF 739g20bAf/lei3iNuofJeBkeZvLPxPr1bEG4eoTZYFlG7nY2MAs4azGi9c7TdgckdRQxp39qR/WciA zOlE1iScu/DjIeLFgKcRf+sBCRQMF5PZGGAwfZCym53bEA8WCDZ4VX0MVPwvkNlBpaY+Wfe+D8C60S J0BLAHR3CLfLQorVgbgsGw8uSUDiGeZgM+nvHE2+WdC6OD8MSkM9LfVu0fafzNG3CKCuqXymGUwSv3 ik6nygeHYenOM95zwzzIEggz3OnFUXtarqKuBroLjaP4qAjeI9O19Ki1pjyrrgMP0Yxn0l1cMoHXD/ dMXp31CKkiwuQTl+Rppha4bpx4A8SHfu419J0M9//Z5xwGUO32tVISPwMppxQhs2sqdAAj2WVle+Hk J67cHnId7+fDQoxVe9SkYBrz7IbtBlysGNgSi4jzjDT12EWR5xUfpVb8Ac9ELjgxngvR16PBbDxGhm 3bVi4RZDN1E/FGGKtkQf9hx7lLArSYIpkT4GXvA8mcDwYLQZZWY4uOG9chVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RO_AFTER_INIT_DATA macro and module_sections_ro_after_init[] need
to be kept in sync.

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index b0ff82cc48fe..06410eb68dea 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3521,6 +3521,7 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 static const char * const module_sections_ro_after_init[] = {
 	".data..ro_after_init",
 	"__jump_table",
+	".static_call_sites",
 	NULL
 };
 
-- 
2.30.2

