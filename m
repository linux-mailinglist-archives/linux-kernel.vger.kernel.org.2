Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E201F342734
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCSUvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCSUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:50:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:50:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g20so4360555qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcM6ggTK+Er1AJgCwL8fduwHmBm20BhwDOZjTH0qDPQ=;
        b=Avlz29gGZchCPVMGYeTRS8La1qM8kJKDot41P2nQuOQ7gwAsvrrvhw5ukYkNYvBPHS
         8V2Ec+Xnw3edxuve1Q9AekwGgG/niQ9eUAPsMt5cem5FgeJvh6uVjJXezGsK39nn7fym
         f5RI+S55Fpr4kzeVKkz39Jbt9WzfWoVHKU25eBquAS+uM5yGpGoRhTfoEPD8AQxVd2QV
         tAqSGyRJk2u2h8nVr8Ztrq1NbcY/UPOYdzt+fzvSZQbgwHQpeomf5YRf24DQzzHRJHBm
         RYNHdFyrKhTTFPdOhj1DMel5dIiSqDcfb6z6t8BSZgCeze+2J00z/4xnWMokj/By0lrL
         9GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcM6ggTK+Er1AJgCwL8fduwHmBm20BhwDOZjTH0qDPQ=;
        b=YXBlrFepQz6aU+jx0TrrZO7iPs2XSbqcaNbRL16oSbmDAp4m60XdUO/2q7yZDFxaaQ
         vbtpnnYb3iFodB2PWoLlRQiDKH5M72UTEAowTgYddvHMM/iAw2JXCYT/NvENMBusk02a
         hEnoFK6xtmP/jCN1vY1s9dIa/HDm3BSxtsJdYM9ulekXhHGJNqCK5kWHJY+CrSJaoRuO
         9AK8j7XFnFj0NbAJKwqEqEgkbK9In6TutSFAO8bJIVhl6W8oQLmf0aSDNqGZoW0ywPet
         5hx4whjf0m7XIct0mH1B7qhoC3kHqFD0ujHQ2qwXuBaCHHuUL/tn1x3z5It5yWo/TvWY
         o1Ag==
X-Gm-Message-State: AOAM531xHfQsOP+ClOS+wkzVI5dj+Jvgybke4N0imVQgL4p22EWh+re/
        4l8Mtj1s+7ThhGDS2lvcMpk1jQOxUwJLTA==
X-Google-Smtp-Source: ABdhPJzToMfT1lGPZE9W2Mh+M0tteG83XeQfh8DT5oShrLFvKCsEoqg1xpw2pSn/pY3wqzQsPYAI+A==
X-Received: by 2002:a37:41ca:: with SMTP id o193mr527919qka.56.1616187055404;
        Fri, 19 Mar 2021 13:50:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i25sm5299518qka.38.2021.03.19.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:50:55 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kdump: update ppos when reading elfcorehdr
Date:   Fri, 19 Mar 2021 16:50:54 -0400
Message-Id: <20210319205054.743368-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ppos points to a position in the old kernel memory (and in case of
arm64 in the crash kernel since elfcorehdr is passed as a segment). The
function should update the ppos by the amount that was read. This bug is
not exposed by accident, but other platforms update this value properly.
So, fix it in ARM64 version of elfcorehdr_read() as well.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index e6e284265f19..58303a9ec32c 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -64,5 +64,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
 	memcpy(buf, phys_to_virt((phys_addr_t)*ppos), count);
+	*ppos += count;
+
 	return count;
 }
-- 
2.25.1

