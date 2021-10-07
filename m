Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9911425CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhJGT6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhJGT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:58:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9CC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:56:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n8so27765943lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqpcvvl386bx1gPuTlre4q9J/DGcDYFjm1lcO6usPDw=;
        b=w0x3HtI6PyLR/xm5MhD0TIPZNUaafPUX84ca78HYmn7HdYOgNTKuPs7YJHh3WErDIk
         KmLCMcgEJYWewlGi8PP8ssYhah1SBVbWLTsryOIU025XgiLUJWauzhdYboIb6iPutKWH
         hLOLtvK/9Wie6IR057gqUDa82peq1IkysorOhcRs6YI0m2kCtnvNLHvcb9hvhwMTFR79
         he8LJ2QRredO3HIrnbs9oPO38zwboCi/zGBZDSh+9qfKFI7xdIFEjj1jTqE7JeG6ic6r
         q716cF4lIumj6vcRu5UDlVszSSOSKH5Pbs3bfUn7nwFGpMhNaIAaSKBo9GYzfBHiXqhc
         1kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqpcvvl386bx1gPuTlre4q9J/DGcDYFjm1lcO6usPDw=;
        b=kFpVZ3JwZSEjtp17KgrwUagiJaunxKYQ69uig/K5iAAYYN1LSOw+1LAxyVfZViWSW+
         sDcskNUb3nWrejf/elKCdc+0Q6Aizh/+TRKZwXCcaW+5DJEbV1boeR4SokaT1cGqsMVN
         2V7Zf/9Vgn5HtnLUhjDs9HLCMIdvCE8yd1EClEnOFaRhcJAOZ2GhhfbxmxPP9QSjP5VN
         LPhAE7Y8BrOGGqQIdQNEIuDDdCYex7YsC8XAGzVBtCpkSdyWy+/s2zbCOMuXmmk8p/qU
         XdB0/glbF+cbJdupd5/hWEFr8ojGpRvwKC6ThS7DNefRCi0TY2DlC7NvZkHVlgrVzOk2
         pKGA==
X-Gm-Message-State: AOAM533stRaswTyz2lrr+mcBmlXm0VhsKj2I6/Bf0EAKMbdCqmdXIoBd
        QG3Yz0l8jsy68+eP7u6f+R4CwSVT97N8XQ==
X-Google-Smtp-Source: ABdhPJxybQdrT1W7cgKjvNrBAzn+LLbQt2R8iC0c/F8kfdJI+F5d/FMNMnqnHoGJsuiNttUR5BDjwA==
X-Received: by 2002:a05:6512:2202:: with SMTP id h2mr6335380lfu.151.1633636563739;
        Thu, 07 Oct 2021 12:56:03 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id t17sm25439lfl.223.2021.10.07.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:56:03 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: asm: setup.h: export common variables
Date:   Thu,  7 Oct 2021 21:56:01 +0200
Message-Id: <20211007195601.677474-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with sparse enabled 'C=1' the following
warnings can be seen:

arch/arm64/kernel/setup.c:58:13: warning: symbol '__fdt_pointer' was not declared. Should it be static?
arch/arm64/kernel/setup.c:84:25: warning: symbol 'boot_args' was not declared. Should it be static?

Rework so the variables are exported, since these two variable are
created and used in setup.c, also used in head.S.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/include/asm/setup.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index d3320618ed14..6437df661700 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -8,4 +8,10 @@
 void *get_early_fdt_ptr(void);
 void early_fdt_map(u64 dt_phys);
 
+/*
+ * These two variables are used in the head.S file.
+ */
+extern phys_addr_t __fdt_pointer __initdata;
+extern u64 __cacheline_aligned boot_args[4];
+
 #endif
-- 
2.33.0

