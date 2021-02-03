Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57C30D96E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhBCMBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhBCMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:01:18 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E3C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:00:16 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o63so17188581pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=kxSOKcftnvedIIGNh+Rmx/90TUe3R1oO3MkN0JUpxFJLTNpmrNHIABU4ygCSFGF9yJ
         wa8fYCx2lAbqno3BetWwbGgNuRYlXc6TnQDcfpCsYsLqbAfRCvTVBKFiR2Tctk8nhWL7
         O8eR3Vw4c9b8hzwQ//H/3YNKtg5JA6V7pwwPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=OVri8CQ0rGgVqRxKANu1KKbP5aFPQ+Du3fDXtu/nGYmHmvykHVs0xGYBgG7vQMFH5e
         aRHe7oqEKlndL9n9TOJr0VrnqLOA6o/1TjhajTbbexmEXrGwj2cwzkVvQBsm4xRLq1Wa
         icZjfFKJC3w5zWcuZ1DEYRwkzXaWsbo2bYQyPlEymcWq6xKRb7oDXNfRUeqLYVWtXePA
         F9pYaC21Yjg0Z6omCAXiHFm+VJBi1p6P6e5LmNvpWWhwCYOjzHInHWMRW9BrSybCnNPH
         ZdgtKmZKOeBLlrZwhCfHfbb97YJ5fUCcmjXccv8UrS/vQK+UmZhW3A9wwzeOKjBxGHeg
         /Lww==
X-Gm-Message-State: AOAM532zs/GSoFiWEFlEvs5uyJfXiS4TG07S6MPu6KvZcxikxP0PrM1M
        +pLv9fzc4qnASlbztdud1s6gik80W0hBVw==
X-Google-Smtp-Source: ABdhPJylOcEKYT+ONyuxZ4XMSGIDwgjVoa4qT8JnoW1O4tFZEA5p4U/CgRlYK/suDWOPVp8KZjr5cg==
X-Received: by 2002:a63:5f93:: with SMTP id t141mr3293691pgb.299.1612353615412;
        Wed, 03 Feb 2021 04:00:15 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id l14sm1991737pjq.27.2021.02.03.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:00:14 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 5/6] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Wed,  3 Feb 2021 22:59:45 +1100
Message-Id: <20210203115946.663273-6-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203115946.663273-1-dja@axtens.net>
References: <20210203115946.663273-1-dja@axtens.net>
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

