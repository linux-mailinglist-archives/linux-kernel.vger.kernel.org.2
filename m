Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7C32BABE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbhCCLyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhCCFDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:03:07 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF77C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 21:02:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id a23so5639589pga.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 21:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxs4zdW6EpTQ1WfyGGPHPV1+xFIcOWqo8CYwcjQtMxA=;
        b=bV4dO9I1oawjEP9Qq7F/QgMlby/KIy4G26dTxfaz6xHrODvzgOMgEIeq9xmT6siMn3
         kEclcKGR5nSJViY7RKiyLE2BKMcPGytbNemHDqx68z5CYe+QSEuu0w2fYfmZ8crhqHDm
         adJwkkKwSBiB7qGySwUH0Krn2fdrZuuvfpk0Z4Vm3cE7x/7WY+oqZzgIL/9k4Ot+NjJf
         uMGtdLJCDPso50e4BXmFwABJ+KbJ+TBk1R/QdgYtieL1aFiOf7IGvU9XCOKs39Ql42TT
         28AEHWXQI5Ltd/MfLKyWYlxQFjVmzw7yQJRaRoCCz7k6f2YcMVPa5Vb1SfDwotvwPt5c
         EPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxs4zdW6EpTQ1WfyGGPHPV1+xFIcOWqo8CYwcjQtMxA=;
        b=Q+ElDv0pTofJAEHgtxjFKEkrB9gT0uhmvixQKznXNsI92CoToedd+hvODzGK9loXkF
         wXs632qHuDb+iM9DoWlgfinAZ5GNF7zlYU0IFcAzaEhiG8afQyaWVa53Z5QkJAjb88Db
         a+cid3bQTu9QtWrv0cyk6yIH3QGvKwXJmGEeyHjb5lL6rl0pwpqmhjr2H+lMkY13gdSw
         5s5B8UsFcOGJp9FchmUGbqbJCY6c452NA2WkuwUAdoC6RTFSptooQn1Xy25LylxaVA66
         3eiBlIxn2reGH2sbhDcf2gF3zMgPo87qZ80R5i6uoKe0RZszc3DQNgAKfPAk3vUfCaDE
         mu6g==
X-Gm-Message-State: AOAM532yXzo4ctqGVG8oQGZywoi5IPygzxkXiMfQM6DxqGGeuatYLbut
        Jkqk5pH/frtuA59Lzp6rwvZHgzLVRQ5ODA//
X-Google-Smtp-Source: ABdhPJzyEC1xG6CI9hXhjtN0nDSDSGYy4pYdU4SzeMAPYfSFTPG+xWIdCLZtmgJuUh4KrQhPr5NCMw==
X-Received: by 2002:a63:d618:: with SMTP id q24mr21086317pgg.283.1614747735788;
        Tue, 02 Mar 2021 21:02:15 -0800 (PST)
Received: from localhost.localdomain ([116.246.26.51])
        by smtp.gmail.com with ESMTPSA id a199sm13844738pfa.49.2021.03.02.21.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 21:02:15 -0800 (PST)
From:   Youlin Song <syl.loop@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Youlin Song <syl.loop@gmail.com>
Subject: [PATCH] powerpc/prom: move the device tree to the right space
Date:   Wed,  3 Mar 2021 13:00:54 +0800
Message-Id: <20210303050054.3343-1-syl.loop@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device tree has been allocated memory and it will
be in the memblock reserved space.Obviously it is in a
valid memory declaration and will be mapped by the kernel.

Signed-off-by: Youlin Song <syl.loop@gmail.com>
---
 arch/powerpc/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a4797d1d40d..ef5f93e7d7f2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -121,7 +121,7 @@ static void __init move_device_tree(void)
 	size = fdt_totalsize(initial_boot_params);
 
 	if ((memory_limit && (start + size) > PHYSICAL_START + memory_limit) ||
-	    !memblock_is_memory(start + size - 1) ||
+	    (!memblock_is_memory(start + size - 1) && !memblock_is_reserved(start + size - 1)) ||
 	    overlaps_crashkernel(start, size) || overlaps_initrd(start, size)) {
 		p = memblock_alloc_raw(size, PAGE_SIZE);
 		if (!p)
-- 
2.25.1

