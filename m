Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55E4203D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhJCUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhJCUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:02:36 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD2C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:00:48 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id h132so6733606vke.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bFrZAcb9WzVQXID1RbOeEU4t3ZJiJEDIEoV1+0KG6A=;
        b=PeYJuSC835yzUsOygkosppyw7q6a2uwDvrdu1o+SLSy0kj7bW+aPEoLJTW63y8cjKc
         diojPyG8dxepMI0yFVqdL/xBT74Szk7J7T873AJ7r7BAYGTMUQFz2TIcz8EPClCIh2Gn
         xmvlHuo7F70vEjaMTRDJRUi8/41C2dXjtflousMrGlfDpKGj5qZlsnE7I/WhE5KlddH0
         138HTfXp17QeH2G2SCDKFSLoenjF0wfC1+XVoe0WSLFuPxZ8hNdIwkMOuqMYp9OQPOFI
         0BLWiUBEPx2peHjhCoerMcgCJB8cyUmPCb1rA2r8BLzVqQPtELnjwRXzq/c75CTuf8sT
         ImIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bFrZAcb9WzVQXID1RbOeEU4t3ZJiJEDIEoV1+0KG6A=;
        b=s68fJGzA9FiJ57rskCDXR5ghW9yHRZVfM0k3DoyS7RRGo6+jrbrnPSckNkWY4D1N9O
         1rlsyolVkZt+wEH9RKbcuA0n/jEL8GwphP4GjLs8paIUSS0Q+g1y/rR6Jm8zwXc8GOXh
         qNbe5eMRjmtZgb9GjsHiurb1FP9nIBlTrq2dNzYVTLoEhYN5qoXYX/FTsumfq82+/WK7
         WLY51h6ADaDX+/Ks2mfCnfN9o6fZ6GcbyKZYbENwCYQ6+4fQbTcS6RVQUz9K63ONBrGY
         FyZhgPe6+YW5YEUpMXZhvJ1BFpg987koLeUhaSVSKDWuOWfpbez/qr1fCgS87yH+MVie
         W4GA==
X-Gm-Message-State: AOAM533YUmsQVmURpiziVrukJWnIkKORXW6Drvjted/5/ANiPzfJ1AuK
        9c8fm3askhvNdh3mdclfz6E=
X-Google-Smtp-Source: ABdhPJyP18cz+60Uf30VXcI02hfHj8l4puTSHVQi3EurvqOZiDksxwbM9fYGxmTufcNT6WSWd1BVgA==
X-Received: by 2002:ac5:c5b7:: with SMTP id f23mr13266663vkl.20.1633291247566;
        Sun, 03 Oct 2021 13:00:47 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:00:47 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 3/9] staging: vchiq_core.h: fix CamelCase in function declaration
Date:   Sun,  3 Oct 2021 16:57:55 -0300
Message-Id: <20211003195758.36572-4-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming function declaration to avoid CamelCase use.

As this was already fixed in the function definition in vchiq_core.c in commit
801b1aa002d3 ("staging: vc04_services: fix CamelCase"), the current change make
the names of the variables in the function definition and declaration match.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 893b07698268..383c3bcf787e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -622,7 +622,7 @@ extern void
 vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
 extern void
-vchiq_log_dump_mem(const char *label, uint32_t addr, const void *voidMem, size_t numBytes);
+vchiq_log_dump_mem(const char *label, uint32_t addr, const void *void_mem, size_t num_bytes);
 
 extern enum vchiq_status vchiq_remove_service(unsigned int service);
 
-- 
2.33.0

