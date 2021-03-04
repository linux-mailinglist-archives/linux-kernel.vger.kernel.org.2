Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03832CAE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhCDDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhCDDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:38:35 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:37:55 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id b21so17988737pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwoBHUochKSoN7y5wxuuHeqVXjjHuR5y3IgAjCllxOw=;
        b=q026x+6KUHrBMJfJZiwK1XhQUrO2/YLwBhRT8ygxRCf9rE9qB7lZOuu+o0FVf2NRVy
         fF78CGKre6JeUiH3ANQxlmFzvNS0SSu0E4bQ6NPJKggcFxzxG61qr1nnlkQDoGMl6qTr
         Rh5aoq5zzvQ6pmTiFcWI8TvOLm8MGGSEiFyVkGx/AWGBsfGdPWsHrZx1s83dZLXygdTp
         NRiTcYxhhSWtgTkJXEdWvlXOsf7kXeOlnfQznw7Z5eIXk7COwDqu2I5Wg4bZj5F9GJIE
         nixKS5KKNqV/urDmL+1U5yPsofGStIfeL41fLbA7Ry7duQ9jtYFgGM9wC85rcY4FPKjy
         iu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwoBHUochKSoN7y5wxuuHeqVXjjHuR5y3IgAjCllxOw=;
        b=BYZIG4EOVaGaWNrGQk4v6hGB8EPBSbNCKQk9gPwu0Mg2s/C1vWYjKPhUZXgD6gKOjX
         SWWmtqKvf3m8TdOMLzR8E92/h1fUagYZWcOHrC+ELFkFK0Thpc+ftka+WYCmYvBysQbH
         B6nJp0BoAphvP6EBYJQ9Cxvia1FaNFBxMVnW08xjB0JJCN80FG52FVgMeJnfKfE9aRZR
         q00hHZsBW0drS2FSUEuDFvUJezGXwFeoxfkT3Hd6uAR2kPFscT62jsVt/Wv84OkuBS59
         1a4D/bu2zE1kqhN+r59i8iT9Zdmm0UqMK3J19DDeOpLF9zaqg0GJ8sSsJudeiXsoOWf1
         NZWQ==
X-Gm-Message-State: AOAM531zw6NiOZVAd76X1L/W9MT8nlSHuZR1p7Eg6bfEQxHuRT547Weo
        vI1gYmJTG1Q9/yNQywYAqcc=
X-Google-Smtp-Source: ABdhPJyDZVPlwhy/hQc/5twP4MdW4dbJKj65FddlnUK2WW7w2lrPVv3dhEqqDfg0lUUUHUvsyKbFqA==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr1971898pgk.284.1614829075104;
        Wed, 03 Mar 2021 19:37:55 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id m9sm7727382pjl.4.2021.03.03.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:37:54 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, msuchanek@suse.de,
        npiggin@gmail.com, axboe@kernel.dk, zhang.yunkai@zte.com.cn,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/powerpc/include: remove duplicate include in thread_info.h
Date:   Wed,  3 Mar 2021 19:37:47 -0800
Message-Id: <20210304033747.189298-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/page.h' included in 'arch/powerpc/include/asm/thread_info.h'
is duplicated.It is also included in 13th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 386d576673a1..9d6402402b9b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -38,7 +38,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
-#include <asm/page.h>
 #include <asm/accounting.h>
 
 #define SLB_PRELOAD_NR	16U
-- 
2.25.1

