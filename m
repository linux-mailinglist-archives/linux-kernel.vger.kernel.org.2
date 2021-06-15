Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D543A746A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOCyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOCyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:54:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F33C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:52:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v7so1505690pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=ZeJTQLnhfCYIF5Alb7Xcgk6mY9zzQWFwt3XhISP0PkPInYBI9a5/ZaMCsy80NCvgIn
         nSVdbGwMuO0uX84KkYEAuIPjAXkySgG3mlroYr4cGA5WGFzgNpn4J/HKXkGc8Y2d9KL2
         vaabfR/X5gDD51l49hsy4PjrGjT/drL7td3nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=a71fJUvyS9z236lgGjiX7vP3lZ1pDkhp7VBwGpGg5kzNVCw29jCaNAz78xM5d+0ux7
         pPezo0ntPU+kRihPc9sDj9W1vdytqzd3MiqBXqltE0Ji2Odfefq7sBnvxaSXyW/BRwM0
         jZDp+Ud7Fegb5UrIU059zXD0BBGxlv0+uPOsxcbJhtfnxxYWzk8rAZCdng0sSOJNMEOp
         AN5iUl9MUGcOCc9wKPWt6O3sDsglzY5+50jFQfDf7ofICvf/0/zcbNiv1+4T0beajuzB
         VMotH7fUhczloDPzfxVugy1YWyj89rXx/xtSMT0N2yJwdl3JoU4AMHgo4jVHUdQO7bN/
         2D8A==
X-Gm-Message-State: AOAM531Mg5YT6PQTH+2DwBoZJxWrke6rBW0nD2XPoHYsoRNkTrt9q4nw
        r30LJP8MuUKUHc9aikfK8PSYgesylAq8/A==
X-Google-Smtp-Source: ABdhPJwIh6iSrt+CcEWzVqr90qKul9F0AOPFTbmA3xMVJpWYKIvGycOfdzCm5eVl4SQ5y/hhcfyFCQ==
X-Received: by 2002:a17:902:728e:b029:101:c3b7:a47f with SMTP id d14-20020a170902728eb0290101c3b7a47fmr1630411pll.21.1623721651578;
        Mon, 14 Jun 2021 18:47:31 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id t62sm5508747pfc.189.2021.06.14.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:31 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v12 5/6] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Tue, 15 Jun 2021 11:47:04 +1000
Message-Id: <20210615014705.2234866-6-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
References: <20210615014705.2234866-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..42fb628a44fd 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,6 +2,6 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.27.0

