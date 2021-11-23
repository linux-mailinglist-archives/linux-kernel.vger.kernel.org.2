Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B928F459EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhKWJK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhKWJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:10:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1ADC061574;
        Tue, 23 Nov 2021 01:07:19 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 71so2310304pgb.4;
        Tue, 23 Nov 2021 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUHBLf5vNSlEiUHIVpm7uW2Kv1mivoocEqGi35UzJDo=;
        b=E9Njrw0uX2NtO/86NxIMhkIFZpYymPmae0/0ncowoV1DigjBKTp8KE7VrlXbUgVbMb
         p655JEdYujbN610Z7gb2rNJyDLX6V3rvbFf45fC4wfvZIxYEyOTiNvTdmyePw9SDpECY
         c0suK9yqIdEhNZl+XLPPbv4vX4rF/JEi7x815O0F+MncTwrSRe7A35dZzGf0lKNuQHOF
         JZ55u5SCzAcPTFKX1bcX03u3EemINfdIq1OXWlsbF1io0pjAtzI2+kXSVxWxs0zJb8WN
         RYl9Op0olCnDsjdEHvsDf4dWJVqUVcIi7Akj0NET42ytdlvqNsHDIOpp1qNZYT4CvjzO
         KhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUHBLf5vNSlEiUHIVpm7uW2Kv1mivoocEqGi35UzJDo=;
        b=zf7VKTBv3iE+ztYzDLjb6wId5bGobDwjvXbnSBPOkchAlN4mfmSujFrUVGtXjpX90A
         y3nE2xGNvhQdefMagFbBuNVTAhra6h0oQiU8Nl7uueKaWXaz6oj+e3SpOTzVgBjeY4K0
         tJ9KCOIH71ivZqMl3SPvA8xhfd8WHyh9FbBf67olUMyrXBQlSQMPIxW6d5GyrZ1ARwgD
         /CHcFP/WPtqV8M4VDRHQYmC1pX4rwf4XH7KAEpB0+7Na4azWmLPnAGe6tzVmw8ZAs2S5
         mGvn19p+iHos0oLyhmJjPH1mgQnnhMPuAb3u36Tg5ImlVpi4mzUi4CEQsBAWhCzO3hZ9
         SenA==
X-Gm-Message-State: AOAM531fv/+Gagmgck62RC94l0Q8/ZiJL/aaq/8sDHjOPmDEC/dEZQcs
        /lSlZifqFyR48g5acHcH+go=
X-Google-Smtp-Source: ABdhPJyzeM1ZaQ0CZXGAIYfYbVQfDPp5pR8xK+fJZr7hkv5S6N/IyRP9kjmT3yrvPx7/bI9pBnW+gA==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id s5-20020a056a00194500b0044ca95535eamr3849851pfk.85.1637658439294;
        Tue, 23 Nov 2021 01:07:19 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id u13sm8751242pgp.27.2021.11.23.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 01:07:19 -0800 (PST)
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: [PATCH] mm: kmemleak: alloc gray object for reserved region with direct map.
Date:   Tue, 23 Nov 2021 17:06:41 +0800
Message-Id: <20211123090641.3654006-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved regions with direct mapping may contain references to other
regions. CMA region with fixed location is reserved without creating
kmemleak_object for it.

So add them as gray kmemleak objects.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 drivers/of/fdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284ceb..116c582fea7a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -26,6 +26,7 @@
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
 #include <linux/random.h>
+#include <linux/kmemleak.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -522,9 +523,12 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
 		if (size &&
-		    early_init_dt_reserve_memory_arch(base, size, nomap) == 0)
+		    early_init_dt_reserve_memory_arch(base, size, nomap) == 0) {
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
+			if (!nomap)
+				kmemleak_alloc_phys(base, size, 0, 0);
+		}
 		else
 			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-- 
2.30.2

