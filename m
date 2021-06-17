Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBCA3AAD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFQHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFQHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:33:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:31:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so3057576wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oD7WDBfksAob2uZAfcWpNAeg423Dg1GjH5fkSqNC5wM=;
        b=dmcjOxA0mi2L+tbtJzma0ccU3XNkduDfY0HLx+3yKvLU77NYaVHKruZylatcJ/WWnF
         DYxmQVSu6lJL8JoD7+z9W8qKPkz+H5qgOUUSWYwYbyZZwro6JKtu5P/cG87tctm7PSL+
         XxmCjTzb4x9bn7MreZdwwAzgHkh4jxmFzcjSedIsVN9cMAifrDb/s1qMYbWiA1YUogLi
         x5vW/3TiYWch6rZzrf4w2/T84vEn0Bpy/8geRltOgfPMyWHUHD+d3Zkzm2LL7ZT/5cI9
         qTYqk6Qlf5UmyWL7hPHbq0nSwSYDS/ELb6YNQMmBUoXo8gkGBsyH+DZt/fp9f4vDckJd
         KdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oD7WDBfksAob2uZAfcWpNAeg423Dg1GjH5fkSqNC5wM=;
        b=KqqwG3rm9zgUU50n/AzSmnq3iJ6HG2cZoGLCxu+nlmk8sEP8rk8oFxpBu3l1EWbrdR
         liqDXtyk19gul1XVQ69se5VXmZ/90GDyznBZopdGk15H5yAmgLfo8PtOPTlzJ2uGyder
         M9pQJYQbE2J3nYIOaO6N1oZ57RJHOLUWuh49jAdWxCQikIQmKWHa5KIvfCUkWB46H5K2
         o34Zo5ARGphvBAClGgCpefFNCctHFrGCPo4KGJEd1eNDmI8D0kUMpr0m38+Sx6GKrTK8
         C7HvJQPa8S58do5xssGfYCWGSl74dfhFbhzGpnIFtfaXxoUm7Q4KwZMyw+zI89CTLNiX
         3jAw==
X-Gm-Message-State: AOAM531Bqvp5nMbZ/CSzZ1G1RzMho4cxVGp8gklxaIXnzXb+eEyQRg5K
        uHg5aMlwdLsKv5vUK9/tQEOjtQ==
X-Google-Smtp-Source: ABdhPJwJf8qVlb6hUI5k1EBTGLPeoFc3WMybe9sFed2u3OyI7D5giPPASvHC23WoHajEWbNv9i4lYA==
X-Received: by 2002:a05:600c:1908:: with SMTP id j8mr3446015wmq.86.1623915069448;
        Thu, 17 Jun 2021 00:31:09 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id z10sm3896549wmb.26.2021.06.17.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:31:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/1] arm64: KVM: Bump debugging information print down to KERN_DEBUG
Date:   Thu, 17 Jun 2021 08:30:59 +0100
Message-Id: <20210617073059.315542-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sort of information is only generally useful when debugging.

No need to have these sprinkled through the kernel log otherwise.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 46e710bef5174..6f6ff072acbde 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -344,7 +344,7 @@ void __cpu_die(unsigned int cpu)
 		pr_crit("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
+	pr_debug("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * Now that the dying CPU is beyond the point of no return w.r.t.
-- 
2.32.0

