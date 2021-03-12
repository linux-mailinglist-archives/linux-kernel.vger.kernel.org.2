Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698BB338845
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhCLJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhCLJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:08:05 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42782C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:08:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t26so15449630pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVdnIbcoJeRY7zG01KJHr0aWovTe0PwWaJyS9+ofD9Y=;
        b=VOGOGyF+0BHCuPwwQN51gS1oELJE6My2QJYnQ6NkUo5VsP6K1xLbni67bVg2Z3qIgM
         fg39/NfyiAOtcx6U5iO23sByQGpNOdpWGU7N3VtTLiA9hhsoQ/jRAlIUeJ1L2Acbdw1A
         8BDA22NhpFGZ/evW14CSpGZ/SKPlGpu3poIx1Jc4XC0lV/EEbG3p9GCsrX2Fla9lFDxp
         32R7PplkFrriXTO3IJNA6LDx58YGV9rsOKVOQ1CXyu3SYbUESriBOgHL4wrSQpK0VZ3E
         UCTRRH+LZM9wmObHHiUywRN+Dc/aPwrFmUlGyh7fH6BwKMjo6S7lrZdJeqIEOxzOfGKz
         oQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVdnIbcoJeRY7zG01KJHr0aWovTe0PwWaJyS9+ofD9Y=;
        b=IXgFpkQdbCJ4fAlern+wYbaBvjDZbidtYnrw+9knR7WMB5YG5oBSZggQhJsE73d2iq
         a9Cw9N4nxaRXFaO9VZU8HLdMKMunqhWwJRrzeWKH1SENE1j72foBAUjYsYdbkFxkA2jK
         3wa7RTznbH8qlIyFEcMiMzmCQOBaMwGVA+dNx4YGUQ/Bo66YuCsvzB2GzCTI5npEe8RN
         CWU5xnma5yTGV/8/WyFX0ZzAsINyffVWCqGab9ySZ7e8jhF52H7lO1ARpzYZ9DmOWKJD
         veageqRe3XpdLPlt2bVaA0eJ6nAFYEQrXLMw/PMxYFJns/mlrVGEX4iwoN62iOr5Vk6B
         OYtw==
X-Gm-Message-State: AOAM53005AuWtND2ycBwpoGWoZLiVvaWjJGzqMy4VPEFHp8vVVx83mu3
        DdTN2cryUnqRTULZu1BsQWbeKSqqoWhHAH8R
X-Google-Smtp-Source: ABdhPJzOC7z7g1osI9KxiZBgm0jSUf5wVfoDot8fzFMT5TbgA0eQmW1mwxNtLwHemEF3EljlOq55NQ==
X-Received: by 2002:aa7:8b48:0:b029:1ec:a315:bdbd with SMTP id i8-20020aa78b480000b02901eca315bdbdmr11620104pfd.51.1615540084871;
        Fri, 12 Mar 2021 01:08:04 -0800 (PST)
Received: from localhost.localdomain ([114.85.216.137])
        by smtp.gmail.com with ESMTPSA id e1sm1662907pjm.12.2021.03.12.01.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:08:04 -0800 (PST)
From:   Youlin Song <syl.loop@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Youlin Song <syl.loop@gmail.com>
Subject: [PATCH] powerpc: memblock alloc fixes
Date:   Fri, 12 Mar 2021 17:07:47 +0800
Message-Id: <20210312090747.3381-1-syl.loop@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory starts at 64MB physical address,the memblock
will not be allocated.Because it was in the range of 0~64M
(according to TLB) to alloc when the system was started,
but the memblock calculates whether it is in this space
based on the actual physical address(offset 64M).

Signed-off-by: Youlin Song <syl.loop@gmail.com>
---
 arch/powerpc/kernel/prom.c         | 2 ++
 arch/powerpc/mm/nohash/fsl_booke.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a4797d1d40d..addc05c6f8ff 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -785,6 +785,8 @@ void __init early_init_devtree(void *params)
 
 	DBG("Phys. mem: %llx\n", (unsigned long long)memblock_phys_mem_size());
 
+	memblock_set_bottom_up(true);
+
 	/* We may need to relocate the flat tree, do it now.
 	 * FIXME .. and the initrd too? */
 	move_device_tree();
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index 03dacbe940e5..f6f36e78ec41 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -264,7 +264,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	phys_addr_t limit = first_memblock_base + first_memblock_size;
 
 	/* 64M mapped initially according to head_fsl_booke.S */
-	memblock_set_current_limit(min_t(u64, limit, 0x04000000));
+	memblock_set_current_limit(min_t(u64, limit, first_memblock_base + 0x04000000));
 }
 
 #ifdef CONFIG_RELOCATABLE
-- 
2.25.1

