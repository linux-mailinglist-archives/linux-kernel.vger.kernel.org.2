Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA870306572
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhA0Uyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhA0Uyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:54:49 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:54:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id j11so1959899pjw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GkOvP5v/o3GajsI5MgubNi5t/flwcnqO6XOeJr4quWc=;
        b=ByN1JbanGaIqjEPno/blmbB0rR/xp916N4CWocXaaoDrbT+eTt7ZRiI9WDE/lLA8F0
         GJsZ6fmOa35TnKSvcrkpJ0YCqhgHEXKxiMJSuMxp6cCmAQ5YpDoDa3em/a3K0l4A8jx/
         3vPSDHYa2MMChTt8sPFegZy0jPeaLc+ls6v68Vi4b3bqopujtHSkVG8L+8TkfjF+GemU
         pS8oIXcvzS1R9j64LNa845LQA7qv/F7Z6KWlAq/GCMl2JLuS4w6LT3g2B1hDvXN4Qlm1
         vZ4E07AmuTk9iLtD9RXeCa9dQkJ3TnRJPjK9Kez+nxkTy4ARkp+h0Ca+MurX1VihvJEq
         LyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GkOvP5v/o3GajsI5MgubNi5t/flwcnqO6XOeJr4quWc=;
        b=dzbTKrCW+INKpMbdmRc2dXo8DGpOl0I2OWor6synZeTtcxLB461mQOO7ft38KhduFP
         YyPyVsXz4ZTwFw6nuA28YmRCJWBov0aUE/ndZ2KtGhcGqt/2uS6YqoI/KL8EQoJ8eWv2
         KUVeZI0QW9cG7B4roZZ+flqcfSD8djJNq+i1gdnP/0h1Z4czT+6oUG7bLuULZR88YqOF
         DOfOBg4onjh5czQs7fvYLQAMHuOUKvrtK2boi+yfWJopD3rLlNU4c0CihqWAInOy8e9J
         8psKWNaiqOxfEL2kYV2Ke2kTcnxziQGSjchsvzOZ7IYJDxI6sN7YmzbQiWGRf6bhamos
         LNHA==
X-Gm-Message-State: AOAM533tTJ0Fo5SJC4GvjpA5DoasEgL1Nt41uZe31nsJo/J8zZqGc7Xp
        2Y8HtfblczrsBe7OmmPYAo1DrUIcS83G8qOX4HhsR3af6dlYa7ThcLfY84sGyj8gRMNA+CvPfeK
        vXfbEPKyz0jOgbq4WKZ0/7KhM+NvnBJRZZUHQGw6wUKH9t4ms7qdl0wX1uJISXFqMBMfzw+aJ8c
        Q=
X-Google-Smtp-Source: ABdhPJwo0G4Y8YKSiLIMyagZ9KSO4YTzftWwpcmlAA6xIhbCTkikU5ODYKDZYrLgqaj0tOztBgM059aFwOhbEA==
Sender: "jmattson via sendgmr" <jmattson@turtle.sea.corp.google.com>
X-Received: from turtle.sea.corp.google.com ([2620:15c:100:202:f1a0:c0ca:d724:8a8a])
 (user=jmattson job=sendgmr) by 2002:a17:90b:28d:: with SMTP id
 az13mr7844034pjb.55.1611780848096; Wed, 27 Jan 2021 12:54:08 -0800 (PST)
Date:   Wed, 27 Jan 2021 12:53:58 -0800
Message-Id: <20210127205358.3227383-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] perf/x86/kvm: Add Cascade Lake Xeon steppings to isolation_ucodes[]
From:   Jim Mattson <jmattson@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cascade Lake Xeon parts have the same model number as Skylake Xeon
parts, so they are tagged with the intel_pebs_isolation
quirk. However, as with Skylake Xeon H0 stepping parts, the PEBS
isolation issue is fixed in all microcode versions.

Add the Cascade Lake Xeon steppings (5, 6, and 7) to the
isolation_ucodes[] table so that these parts benefit from Andi's
optimization in commit 9b545c04abd4f ("perf/x86/kvm: Avoid unnecessary
work in guest filtering").

Signed-off-by: Jim Mattson <jmattson@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/events/intel/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index af457f8cb29d..af28b2f5f895 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4383,6 +4383,9 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 6, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 7, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-- 
2.30.0.280.ga3ce27912f-goog

