Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31213444F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhKDGs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhKDGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:48:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3EFC0432C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:43:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so5658558plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBsVpIeoKh0sTMGeYR1OGBuaaXo60zHbiz7Q8ZYUHK8=;
        b=gk3SJKqZ9wmmXnXnLnHgeWbm1IgkXdvkGXBXOv3C9F8skGQBCrc2JdUaWDNEUH/5lg
         6AXl/PkThq3+vB/zTLVsTUAWFgve0hLDmYiPiPnUw1mTG5L5bm1Ue49TJeVfsjWHcKTx
         Xlkh+q9bJWzBw1T8ZAICmOFfv8Jx0DmMojM2fp0wOP3kxbgsp1zzxVs2tNE3IwihPAuY
         wSmVJiX9XdISlHTMxZxNLX2BmCnTiGlEGj7bpsFZzTH2KI0Fp7vZhAguxw6He/WyHS+W
         Lm6TilMPc1fS0WNDHFz8OIyFAS2YOioCuVyMnCGa60p8uDbarapCYIBEfKQZLyObmsey
         MJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBsVpIeoKh0sTMGeYR1OGBuaaXo60zHbiz7Q8ZYUHK8=;
        b=wBl70cN5POMTCe9vLF8kd9dMtAHNaExb8avvD+On/J7OBQTlekDwQDoAKcBMimCPx3
         OLW56+bq+yuFSk00dCCPuehp7Lr2uupKMf5lH49Qb4lViDIO+NpntmI4AmkYXGqpJvxa
         7Q5UHh5JxYnDHIlOdXINNqzlPuA+F+5YtRNDPw/mi0pVhtm7FggRcFM15E7XCTWx1jUL
         5K57r/UClIoJ+qxN+nkydzPwNoNFKdtblJXX1SViM/Alh21gXu/7bS1Eo6fjdqmmpqan
         aXqTtB5I3fftQmi+Qt3i9Lv+Bgf22y6RmHFYMxsJsIMaTaI/5TJHfJqOsIyTtufBdDdl
         zsxA==
X-Gm-Message-State: AOAM531hi1+8nc3xa1XMc6fbSeMA32AtDPz3IvIcCEl+u3DvsUyMzL4Z
        r86wmiQR1Hyv7APZ77gGAdmszsm939g=
X-Google-Smtp-Source: ABdhPJwkLPoIjmYvQFUplZAw8iNvXxFBoPJfMZpLIFbD4rWpwX4bYcFNqymtnjdhEwnCN8Xr7YZztw==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id v10mr19906415pjj.130.1636008217311;
        Wed, 03 Nov 2021 23:43:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g13sm842480pjc.39.2021.11.03.23.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:43:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] genirq: Remove duplicate assignments
Date:   Thu,  4 Nov 2021 06:43:30 +0000
Message-Id: <20211104064330.2995-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The variable has performed the same assignment twice.

The clang_analyzer complains as follows:

kernel/irq/matrix.c:289:25 warning:

Value stored to 'end' during its initialization is never read

change in v2:

Repair the sending email box

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e..0469f30 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -285,7 +285,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
 {
-	unsigned int bit, cpu, end = m->alloc_end;
+	unsigned int bit, cpu, end;
 	struct cpumap *cm;
 
 	if (cpumask_empty(msk))
-- 
2.15.2


