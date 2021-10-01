Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D341F314
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355382AbhJAR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355325AbhJAR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:29:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87575C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:27:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so7018977pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRBnsHOhY3RkJJ55kOa8agH19+hjBWLoI6XvdfNnFos=;
        b=Xs8sPOBzwVsKgvPcUPiIaBbVcEdNF4tbxTxnktn84mfih9aV47w/so/YleDQRpQAJC
         /CnQ0q8FsP8iuXeeKHZvCHmNYJ1elS0RvFHMO8qFCQ2+Wvvob7KstVA6mNdT56h2JxQO
         2EQ/LxBYwe24CZb5TPhKBLeMueOniJs8UV69c6BTFU8s23AD18pgmko8c6Aq39EvG1Sx
         9qoV6CK4gt9OCuM/Gijdmi7B+fdWZm5GjA3DD+LQdb18/jwHp2o4fWASpcgMJsnWzbRH
         s3HqbwISyAlkqWvdSK4/34OC4fhzSGf9i0XpDnWOArFsLEFG1Yp9trTJiXLsOKDBo186
         dOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRBnsHOhY3RkJJ55kOa8agH19+hjBWLoI6XvdfNnFos=;
        b=5InU0YCWjf/3fQeOYaNsQSyOMfLPBxA/S0Bc9zVLC6YgJDq2AzMU/BMz7qVSEiKpfx
         nY40FeV3SvsJlvVtzN+6Xw5gSaCHcLhVq1im3i6VmS7MjuaAyHqGbw99DA3PQplS2/lY
         yF6vmYc0riaW8IegaRa/TT1cGXH42613XmGun0/leP28WmLunxEQ0m4Qr400S3dZiqvW
         MrVM+f8MuTuXkycZ2vWKj7QkNA5zjQ4DV82DHYApH5nj77SYP0ejj4L9FvGChK3MACpf
         UIxCxkZThqZk8l128u+PhwhB2UxPrDpEZAdY7NAn1bf5484R1ChBvDLB3E6/OdEBhcr0
         zt/Q==
X-Gm-Message-State: AOAM530vT8bveu57Tygr+YQCMbz1Tc0Mi178sy40IPCpsRpIr25AbEQ0
        tKGr2oFEsdrhbcLvcjVUiEM=
X-Google-Smtp-Source: ABdhPJyyXeSOdt74N1gvq+sNdXSJlSUV655jdthXg4d5APRzI8ZT5khDmtWhi+G1pdDi+1VxrxM4qQ==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr21097288pjb.33.1633109249113;
        Fri, 01 Oct 2021 10:27:29 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:63c:b112:55c:f7f4])
        by smtp.gmail.com with ESMTPSA id w6sm7243589pfj.179.2021.10.01.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:27:28 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH] mm/vmalloc: make show_numa_info() aware of hugepage mappings
Date:   Fri,  1 Oct 2021 10:27:25 -0700
Message-Id: <20211001172725.105824-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

show_numa_info() can be slightly faster, by skipping
over hugepages directly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 mm/vmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 42219f3d12b567fc64f54cd3e2f1e3398e261a2c..d51f5e1c95b4e01add8b952b6c5e2de2a1139e46 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3853,6 +3853,7 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 {
 	if (IS_ENABLED(CONFIG_NUMA)) {
 		unsigned int nr, *counters = m->private;
+		unsigned int step = 1U << vm_area_page_order(v);
 
 		if (!counters)
 			return;
@@ -3864,9 +3865,8 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 
 		memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
-		for (nr = 0; nr < v->nr_pages; nr++)
-			counters[page_to_nid(v->pages[nr])]++;
-
+		for (nr = 0; nr < v->nr_pages; nr += step)
+			counters[page_to_nid(v->pages[nr])] += step;
 		for_each_node_state(nr, N_HIGH_MEMORY)
 			if (counters[nr])
 				seq_printf(m, " N%u=%u", nr, counters[nr]);
-- 
2.33.0.800.g4c38ced690-goog

