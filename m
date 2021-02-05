Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB43110EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhBERfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhBERcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:32:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419BC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 11:14:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 134so8152667ybd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=npmBBKW1fSgppgegxbQ2UWGEM0GM2JjG3Wy9uRJQQLQ=;
        b=DjDliZ2GNF1xL3OrQ8Aga+aiMXLiwuQsXYEUJYqxrI5FAufPlol/zReUe4BfGCmTbu
         KJPw1455ue25FsX3DkIH04cTAmteirbkniJHxw/fEJaWpR0MftvAM7+wB5ZDcdZWvdlF
         c58O3n7x6WQtxgj4emJvEHC5BZd5F4JSeYfpyOOBbqyxyxWQjLIt54SE1W7Iwt8wrIk4
         Flygac3k27k8QdXs3NbjH2nlPTESW3bR5CPyZm0MLhgyJfNJqgs5e/fRUtDdzQwcBIct
         DAMAj1uMjVsGOGZdr3iyYb1MpIDIg2wwnW91R7fQaFdMcbryRL6WLRaxwm/oFO3eVakO
         RObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=npmBBKW1fSgppgegxbQ2UWGEM0GM2JjG3Wy9uRJQQLQ=;
        b=Wgvib4h0lcqT/qTR5d+H3urERdGUTZ7oKMBDvB+SeqBsiJZrjmghT+SIhbjGPcjX21
         i9DTwT0VeR5/+orSiMsh+0wyaXhlUsY5sQfoyXLzenzYhki/OJfw/28tKrDC+LZw3W4Q
         KojyoeCSdDmzcjta6zwoQ3H47mHVhziStHv2rHEK7zgKlLOliB1Xr/89Ld5a725UZiQc
         e7CqAcnZ+fHX6n8KWwykYHHYsDl0738AIYOoRPss/vYW3T/DxmlZbXksrRLleL2bZ1bM
         4WUkoIyIwec44K6SaScl5TAuextCmPSKWvQ4N+aMkmY3vHaXZoekHcZUCOyLnq2+G9f2
         7JzA==
X-Gm-Message-State: AOAM5304k4wX2Lgpr03UbdQ1gnuGGQGXO1IV49i4qiVGuGlqdmVn4kVt
        toIMomr4EQ2AfVHK2mtNslSb4nGHCgf+B9mCkEckP6oFDIQBUN6Dqm0cBPZd6JzeYjAy7xEFqHx
        176e6dInk4KR/FF+smtiC6W8tAL2XaK876p7b6en5P58ZqcuDdehghbid57HD+oClqGvlpy/4NK
        w=
X-Google-Smtp-Source: ABdhPJw24IwZIi59zeab2KoOsEyIRKVsyFrqL567IiIuKLAf/cDx9C4DImvnr9p8ZuvdwqwAfS5VVqehpbLQMw==
Sender: "jmattson via sendgmr" <jmattson@turtle.sea.corp.google.com>
X-Received: from turtle.sea.corp.google.com ([2620:15c:100:202:14c9:c13c:1ec5:db47])
 (user=jmattson job=sendgmr) by 2002:a25:888f:: with SMTP id
 d15mr8822203ybl.12.1612552457117; Fri, 05 Feb 2021 11:14:17 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:13:24 -0800
Message-Id: <20210205191324.2889006-1-jmattson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH RESEND] perf/x86/kvm: Add Cascade Lake Xeon steppings to isolation_ucodes[]
From:   Jim Mattson <jmattson@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
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
index d4569bfa83e3..4faaef3a8f6c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4397,6 +4397,9 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
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
2.30.0.478.g8a0d178c01-goog

