Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556523FA2B9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhH1BMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 21:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhH1BMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 21:12:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D84C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 18:11:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 2so2242369qtw.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 18:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbKjJi+SjlBlvBWeuYSN6P3GgzXQjaFRsk5Xet0fqF4=;
        b=otEH4Zf3r/yrdw9fwNxLDZFbEn2KbGIc1rnCbtRcunDXhwOxyooauliDHc4vQ3vM5R
         poWfKM5LepAL+e8+WgwObuhWn/Jm8NgGKEFSq/nKDJzWr7V6oBzXRIwXRsnXP36zwqPX
         09OM6mAvBfhQnv0WQ59X+Ba5Hvle2A3OYtDiTRrUhLDPt3n8dILsRigiV3DBnG00PoJ0
         d76Vvvb9U89Lax8Q6DNzE/Eykw5slTbCZLYUdnr6FqEL0OavkpXVr+9niREO0PnU7dpG
         YjGt52HwHk8YndxBx7IiK28sXT0XBsLqzLsA+/0zXlwhGRnvyYmTsAxY/BgEmxGqBroh
         twEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbKjJi+SjlBlvBWeuYSN6P3GgzXQjaFRsk5Xet0fqF4=;
        b=UOS0hjhc4eLcHjtMi+Rm/2OQ3ERaQ5UGcDyEeptI7nqbEPbA1Mi601SE0io8XQfaja
         PyMUERmmHKHOYCrkv20fuF2Y7NmqI0uLb5PugJZrg6rCaxu/Cx7fC80irN3fExNmKkWu
         y46CzHdUjc72xdG7KicTjeL0Se9eoSrkQizn339ZTHu9+/RphW3nagGI1uo/Wvtiyqhw
         nhFDnea4nx2MIdQzdVAx5wkTsjfAfjn2sU3jbwprg9NMmayNAzVDR47Lw+uCPz8NzdEi
         O0saY4GyM7wwDpwMuba7bZ1KiJjxnjjsF8yVjdk7ntOez7605ZuxMf7kRJJFtImJHZcQ
         peSg==
X-Gm-Message-State: AOAM533q9yZMylNzhfn8w5aufal7/eoy3op/G3CPIOxWSPPg+XE1/XAf
        vG/sRI4hsGcYzUYFh5NY18g=
X-Google-Smtp-Source: ABdhPJwIwrrPhRFtDeJwcwFAYL0p4jwDMGhBkLRQedTlZTJESvAvn/2GegNe/WfdH9vRVWQnc2RXsw==
X-Received: by 2002:aed:304c:: with SMTP id 70mr11104623qte.2.1630113076555;
        Fri, 27 Aug 2021 18:11:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w14sm6069193qkm.81.2021.08.27.18.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 18:11:16 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Jeff Dike <jdike@addtoit.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] um: Replace if (cond) BUG() with BUG_ON()
Date:   Fri, 27 Aug 2021 18:11:08 -0700
Message-Id: <20210828011108.11232-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccinelle reports:

./arch/um/kernel/mem.c:89:2-5: WARNING: Use BUG_ON instead of if
condition followed by BUG.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/um/kernel/mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8e636ce..1810e69 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -85,8 +85,7 @@ static void __init one_md_table_init(pud_t *pud)
 		      __func__, PAGE_SIZE, PAGE_SIZE);
 
 	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
-	if (pmd_table != pmd_offset(pud, 0))
-		BUG();
+	BUG_ON(pmd_table != pmd_offset(pud, 0));
 #endif
 }
 
-- 
1.8.3.1


