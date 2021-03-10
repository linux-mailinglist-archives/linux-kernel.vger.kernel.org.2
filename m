Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D933328C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCJAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:44:21 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:37586 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCJAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:44:16 -0500
Received: by mail-il1-f174.google.com with SMTP id k2so13939718ili.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZP9hhge4WzyijD3W+Otb4HaEj3fiwE5NUjCWIVxl+U=;
        b=VpO4o2BTGhnxBBOFEIcBmFMu/3+KsJjX1mKuer7c0oNHEv+FslXhAlI5B31J+rixyW
         OVI7P70I9It2E1ukojaobKh1PnwCSWfa8L0zGznLRjwxr4yLpEK7ZrZmM+qaU6S26c+X
         adKiM0kjJyoA6rctCymEa+ppwXqC8fUEIJS5OXGOYsf49Ba850Rp0iGV5LwjIsdLMDn5
         85ElPBj28akm3k2iJu36NOf3GrwBirTzDGIkIDOwqvS8hC2Psgoq3j6UZUefgax1SYOI
         JRXvVmspDMc3HG5Yjr3m4TpHWO7yFJuZkShuS0E3TBS+veBqC8SuwuV4oZl0Qnf9VZE8
         1NZQ==
X-Gm-Message-State: AOAM530CdnOlbdd3aEGq6gSvKzLzQYj+A3dLssHnwQP6SJXaE9hS3ahR
        pf0ztnlSbDXDoJECvT8Xng==
X-Google-Smtp-Source: ABdhPJzbxjq8CxdNH2tC86nnjPZSYaQ8l3zIKij7gZzKgeZ4MzGiQeCrz7cyUY9ecmQNmMraRcrfbw==
X-Received: by 2002:a92:b70c:: with SMTP id k12mr800290ili.60.1615337056074;
        Tue, 09 Mar 2021 16:44:16 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id k14sm8276109iob.34.2021.03.09.16.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:44:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] arm64: perf: Fix 64-bit event counter read truncation
Date:   Tue,  9 Mar 2021 17:44:12 -0700
Message-Id: <20210310004412.1450128-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection") changed
armv8pmu_read_evcntr() to return a u32 instead of u64. The result is
silent truncation of the event counter when using 64-bit counters. Given
the offending commit appears to have passed thru several folks, it seems
likely this was a bad rebase after v8.5 PMU 64-bit counters landed.

Fixes: 0fdf1bb75953 ("arm64: perf: Avoid PMXEV* indirection")
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7d2318f80955..4658fcf88c2b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -460,7 +460,7 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
 }
 
-static inline u32 armv8pmu_read_evcntr(int idx)
+static inline u64 armv8pmu_read_evcntr(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 
-- 
2.27.0

