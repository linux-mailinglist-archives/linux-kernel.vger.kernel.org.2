Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13D8353203
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 04:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhDCCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhDCCFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 22:05:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5441BC0613E6;
        Fri,  2 Apr 2021 19:05:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f29so2075539pgm.8;
        Fri, 02 Apr 2021 19:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDmDmlQgBZSIrU2MP/TQeW+PUwzt+cJeJDtCDLSCiHA=;
        b=OnLcBdwBQB9Vwo7YGX1pIgbvtTMwzG6FHwLr9UoNKV46KyvOegmt53Y89NLsaQfN21
         fO/kLXHWveE2Wi+Kx8n2b3A4NxSnHmieke1kKcPZtYxHYRBUhgL1/dp35kLQt2xUwKq7
         v/LcjRAI3bjuBvzAWVn9d8cefGj1+/6d4CSLe+5OWPSeEek6jVH4s9LRDiDjQjpoVPft
         e0ETlME1Hd6Lv5o61HHOrV1ne3BcyYxez3omCSEtdVKd1Hg7aKRh9FF7UMITMVrjrutu
         XC3YfVpvI+44CvUkjpGZFnupEFjcIjnIMGwHEQo7VlcVW0c8m/f0BOUxLU/mUIGz9m2q
         EfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDmDmlQgBZSIrU2MP/TQeW+PUwzt+cJeJDtCDLSCiHA=;
        b=Dzd+Qa0b7t7EOo4LJ+hxUxuYIkcyYnSY3bkzqgr36jdMMqW1EeBfFW7zZornc3h/4o
         Yt1QVlTa4THKmVY7fKs5FSnHTB0MX5TXjOvkDlWJDE3pJivLyVL3gdJJBDPV6eZp9MU9
         m2UZsYQY/d5X5smcrnE398DbNAl7LgrqcZgmIPHHYmowNuefM6IU2ebyNMvtHr1umyg9
         vomr3qJGVyzFagd3IM0cicoRF5CXxjShFj/BUG5732EKD50gxgbSgZXCVlCRn1KNo24i
         wVo7b60dQZQi1Moq19VnH8V51J1FiJ6EgnQk8p+bdNY5lD/FjFILNOYG5gFwaaboL3Lq
         kdEQ==
X-Gm-Message-State: AOAM530NUxzg6i9ocgAfrxcbAi7YIVSgJKvUt5/+zhPUmeOC6A+cko2I
        goPQb+3moAXZMyxtb533QBc=
X-Google-Smtp-Source: ABdhPJxTadWTrGSrAJoCwI5/jjrL5p9pjDpr4boVyEUsCc/P8xeQrl0bH2k+B/WyJY7knMMezBJqIQ==
X-Received: by 2002:a05:6a00:80b:b029:22e:e873:7f0e with SMTP id m11-20020a056a00080bb029022ee8737f0emr14588464pfk.61.1617415537687;
        Fri, 02 Apr 2021 19:05:37 -0700 (PDT)
Received: from localhost.localdomain ([116.246.26.51])
        by smtp.gmail.com with ESMTPSA id y29sm9513289pfp.206.2021.04.02.19.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 19:05:37 -0700 (PDT)
From:   Youlin Song <syl.loop@gmail.com>
To:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Youlin Song <syl.loop@gmail.com>
Subject: [PATCH] powerpc/dts: fix not include DTC_FLAGS
Date:   Sat,  3 Apr 2021 10:04:23 +0800
Message-Id: <20210403020423.85278-1-syl.loop@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to build the fsl dts in my machine and found that
the dtb have not extra space,so uboot will cause about
FDT_ERR_NOSPACE issue.

Signed-off-by: Youlin Song <syl.loop@gmail.com>
---
 arch/powerpc/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..c21165c0cd76 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -2,5 +2,6 @@
 
 subdir-y += fsl
 
+DTC_FLAGS   ?= -p 1024
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.25.1

