Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60663441D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhCVMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:33:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g24so12094811qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tylfcxECJZP31c4RSnnvxS0KkHn7aB+u1Ic56YVdIuo=;
        b=rH9qUsPgW6cE3AOHHep9mv5GCwPYVoda2tozm1XFrhrmw8tvYjI5WvGlSjkED5GALR
         KNR6X1S9Z3SzMvwkC7MCqS9z4tLuaeua3JkZvwxMnswcagOalHaQWPxOzpsNGJaSg4y3
         2g9bmy9loh2dBx1l8p+Pc+e51vlk1QNTbmOkZdToXRAdX75Nmt7LXm4DQ80PEZIjVV/D
         SpABqqGCcrJ0PulXZ6CPQesOMeboU/vRRzvY1K8BsatgG3p/ir5bOk6lA8DUbMa7oXia
         fVMNcG8NBMolhiOu1vQMNgMbEDG5kj4dafMwK5yeFObepbinzDVO5cvVdw41LMpwTkgY
         DuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tylfcxECJZP31c4RSnnvxS0KkHn7aB+u1Ic56YVdIuo=;
        b=sVcyDHjJs1zjTz2G2dqisXNvtuZfdOXbDirfR+dYUkUEB3hxNmZIFFmAAOtjqf3zqi
         +hWGyJULjxfV3DzKWU2bACc418/H1vJ9/1YVNgRH82IToH+llvm/UnK1FMDxCynVKbEB
         QBXtpc8vTx/eiw9JZ+Hyevix2xYV0fTnJmEXNEoyUNGyUGkYmvlRG+K/ckAT8JQz6rH8
         ENFY8aTUMFuhlpm12FDACYXosq+0I7bmquUwTymWZvnZoQICCIWl0NiK24bwOYkcPLMp
         3ecw1r68yDxwuFiWVUfNr41YYeQHgfOhVwoYSJ5RKNsDW25n2mtRyTHyKOZ3ryMJ6wAU
         WiUw==
X-Gm-Message-State: AOAM531XDMhYdvksp0pKquLnSYeKhik+0iD8kBow+Ktk1+ZS7SZU3Rzw
        XG+mCk0NQowbt3DA5JxfCGM=
X-Google-Smtp-Source: ABdhPJzOSAYoV4CVQmg0IM11726ZDkB3l1jN4DwIE5aV4BhdqCXHohaHnKRDTfOcwqYiTzEIJvu65A==
X-Received: by 2002:ac8:7089:: with SMTP id y9mr9246287qto.264.1616416391503;
        Mon, 22 Mar 2021 05:33:11 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id l8sm8755852qtr.19.2021.03.22.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:33:11 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     vgupta@synopsys.com, rdunlap@infradead.org, unixbhaskar@gmail.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arc: include/asm: Couple of spelling fixes
Date:   Mon, 22 Mar 2021 18:02:59 +0530
Message-Id: <20210322123259.2894194-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/interrpted/interrupted/
s/defintion/definition/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arc/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 9b87e162e539..dfeffa25499b 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -116,7 +116,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
  *
  * Technically the lock is also needed for UP (boils down to irq save/restore)
  * but we can cheat a bit since cmpxchg() atomic_ops_lock() would cause irqs to
- * be disabled thus can't possibly be interrpted/preempted/clobbered by xchg()
+ * be disabled thus can't possibly be interrupted/preempted/clobbered by xchg()
  * Other way around, xchg is one instruction anyways, so can't be interrupted
  * as such
  */
@@ -143,7 +143,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 /*
  * "atomic" variant of xchg()
  * REQ: It needs to follow the same serialization rules as other atomic_xxx()
- * Since xchg() doesn't always do that, it would seem that following defintion
+ * Since xchg() doesn't always do that, it would seem that following definition
  * is incorrect. But here's the rationale:
  *   SMP : Even xchg() takes the atomic_ops_lock, so OK.
  *   LLSC: atomic_ops_lock are not relevant at all (even if SMP, since LLSC
--
2.31.0

