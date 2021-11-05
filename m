Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5962446013
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhKEHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhKEHYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:24:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:21:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2781559pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y/fywMTV/av3QXQO285nEaIk6kylhyDDn7HWAL1SK9U=;
        b=J9VsG7BpA6Wg/aBCbNB4mmVu5FmAEJbjHtLlusYN6JPzObDF5l374arxs4VAMU8Kcb
         GzhyBVVASdsJvLPo5Zh5WMYIOaB0Yfge2PzMR9fJUiYPXq29dvfQ6g/CVYYO6dwYtYh0
         b79D1f5BL4ZLk6tWHoDvqCHBdDH5N5KgvHCjfQQk3ezEDrcPA9N9jWyjXOU4vBN2NTtH
         59EYARqhDRYHGPXzd/1qDMq0YWyUDpDES+Fxm5U/eD/9gzykQxOfnfoQ3hnlM/7z3bzq
         jkuzgt/xEi/LoTM/xHshf7Oa66JGZXvdgLad7KOJZDtkkqGheBd+u1QH4vqHiSmXXUvI
         ehCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y/fywMTV/av3QXQO285nEaIk6kylhyDDn7HWAL1SK9U=;
        b=C37FHwnq/u2VTIKteWkpzo5kEMRxrZ8TQ3dkdaLrG4BBP5H88CeeKxbAZNGDLpjlKW
         vjBXfrsri8R7ZgavA1v81OoiM2UGKMOikXmanIiVF7Ig5uHwJ6Ma6/AiZnkC6NkcmJrF
         OGJFjR8UOPSxIenaHPIk3BOgL9E3Pkcx9uuDEM+VE/7F42XvzM9r0WiYB0rF1XI6NJIR
         odaB88l0GShjt2GAtKjpq8K5Gb5isNymNuupfXjUclrypE4vQ2s91jZOxFtxV/7H3POy
         KiHGto5sHf/NC7+e59S2O+qiLzcRF9+wWwbZNSp7wgtuCRZ3bQetcdHHSnc0Zx8Nqkv7
         M9Vg==
X-Gm-Message-State: AOAM530TImj+UID3LIBJaRNmfHrmMqIoAHYIk0jYB4j12obQ9WjkgCIS
        4LGTGNiG6u5Dky949/6dgvPG+fcOd7+FPQ==
X-Google-Smtp-Source: ABdhPJz7QGe8oVhDc8shfWD7/Seoydn1BU8ePIuBHSHFbz01FHU7wMIFeJDN6rod7LqAkqT3zQqxBw==
X-Received: by 2002:a17:90a:a101:: with SMTP id s1mr27504550pjp.48.1636096902018;
        Fri, 05 Nov 2021 00:21:42 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.111])
        by smtp.googlemail.com with ESMTPSA id v16sm5368020pgo.71.2021.11.05.00.21.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 00:21:41 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Like Xu <likexu@tencent.com>
Subject: [PATCH] perf/x86/lbr: Reset LBR_SELECT during vlbr reset
Date:   Fri,  5 Nov 2021 00:20:51 -0700
Message-Id: <1636096851-36623-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

lbr_select in kvm guest has residual data even if kvm guest is poweroff.
We can get residual data in the next boot. Because lbr_select is not
reset during kvm vlbr release. Let's reset LBR_SELECT during vlbr reset.

Cc: Like Xu <likexu@tencent.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/events/intel/lbr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 9e6d6eaeb4cb..1076de93a2f5 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -279,6 +279,8 @@ void intel_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
+		wrmsrl(MSR_LBR_SELECT, 0);
 }
 
 /*
-- 
2.25.1

