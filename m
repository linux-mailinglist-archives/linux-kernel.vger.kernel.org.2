Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07AA33C525
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhCOSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhCOSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2245C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x21so5779326pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=IZStnNpq1/I+ApuVpBVeH4hTznoN9Pd5vpXdIm0izXjHtNEcMzEuAYg41LcLk9C0+C
         4RaxVzekvwiR+yHdBedERs25Xriog5muJpUH5K6JdeX9j4F6uIxI1HnTzLwzXVy4GixD
         yO68+I45kj3k99yhSaNpqzHD9Fp3KVDrGCmF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=L0VvyrtrNSrlQNV+z3/+AMb3usjqtNGcY4cI5MOy7uubnLCAAGwJzSXIRt6g68Con1
         igDLBlBvEY3gMt3kC0L5/kEBvzzMeIgkrPgQGBgm0WJ8tKYbM36hK4d/VBACD0aST4uJ
         FINmfNk+wylv+gu+p6sd6j/6yq0PIJYJVhGx8/YK0W2MtJgqzykWU1/qLaQeklg/vw1Z
         Vy9a3HGQxDwvldDtd8tV+cyeEP0TAWoofTwHYsNXcdFRyI7gWSwzRQuZHZLOBASjQQLI
         9ZbHC8DeDnl4qGlFZVWmKxzTkAaq4eKG77+naWTOE67tsA+4dMnNnoN7E5r3RODFKL5A
         20mA==
X-Gm-Message-State: AOAM532fP+G4sbAc1x3WmK1gNaNKOMIKrkmLNrxQ42y65sMATfTiama9
        rnK8hMyXeq5d9rT7UTmfvCZTBw==
X-Google-Smtp-Source: ABdhPJyQA+JEIQNoei+K1ch/V+Zx/sc+/gT6R6NcnBEpYJ9MDfdGQ4iDqBvG3w0PI692mwod3mWynw==
X-Received: by 2002:aa7:9281:0:b029:1ec:48b2:811c with SMTP id j1-20020aa792810000b02901ec48b2811cmr11326584pfa.18.1615831360251;
        Mon, 15 Mar 2021 11:02:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm13898829pfa.35.2021.03.15.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] lkdtm: Add REPORT_STACK for checking stack offsets
Date:   Mon, 15 Mar 2021 11:02:29 -0700
Message-Id: <20210315180229.1224655-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=fb815901a1ccc1d9c4ca5c3e3cd3729b7f382fe2; i=b69wRsxT78r/3tM1mGa7N6ME6+rlXyFg15giRWRwPAQ=; m=aFqgiEE+nAZdug79A1F+fVTg9ZceUb0WPE8cbHqssVg=; p=ZQ32/kILkW5AD3nBZHO0VMTp4prIPkm7+DdhCHX8KdA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTUACgkQiXL039xtwCaMtg//W3C jkHw9FCj0GjqFApbcxCL3jl2YwAAjXV58G4rDQYeWzbKEMXoLxCT/GGn17D3xXysAm9/dW2wqXTwB DG47+LfnvFEwMr8RG/1Z5TwURvUpKzo4uwvMAFeALrh34TQr8FiHicEsnh7Zae9vlUtfOkpjOA0vk oWbnFMRoe2jSxYPdZZWVAJAbGIfnrwvaALfb5oL+LyeL8u9+7EEUHGIVMp/HlXNDGQcTYwzqUwi/W IlCP4WjLrZDgvazHIfc7eY8ZGfvY6ZX7SGPb1u5ybkYUnEpCZrBY8RHqYDX244saxallSVPgEheQu 7q/IEyY2F5UKVUFi1R/O83XIrt6Jn35gkynezZltDe1PxA981dpO/TA3pJ2tTRW+p0F4kEIKWaCmM mF77WJRwHkMXTwKX1ML6GCELxA1bznMv4TRKyDgplEklsd4I2jZ40a2nFTBoucQzVW9f8zmYcjHT8 JEoRplIfyQytFfxYLXw6aP3v/1tYFd+I2VfHzz9c7J/e2nXELr/T2i7irF/iSqDAjeuyOLPbdiXgT sEzmOOw9gtVo6TZYCuVVUcf9tYRJPBKAe/ZMzrQRtkwaIoh2jdHhlIKiyROpgq1wfNdpT02SXsE8K FItAad3A/9tYuy56EOrjN/EilPKLKKCvHuOFdIOMXqVOAyqGJVMN2C1mhd7p+ziM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For validating the stack offset behavior, report the offset from a given
process's first seen stack address. A quick way to measure the entropy:

for i in $(seq 1 1000); do
	echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
done
offsets=$(dmesg | grep 'Stack offset' | cut -d: -f3 | sort | uniq -c | sort -n | wc -l)
echo "$(uname -m) bits of stack entropy: $(echo "obase=2; $offsets" | bc | wc -L)"

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c  | 17 +++++++++++++++++
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 110f5a8538e9..0e8254d0cf0b 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -134,6 +134,23 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
+static pid_t stack_pid;
+static unsigned long stack_addr;
+
+void lkdtm_REPORT_STACK(void)
+{
+	volatile uintptr_t magic;
+	pid_t pid = task_pid_nr(current);
+
+	if (pid != stack_pid) {
+		pr_info("Starting stack offset tracking for pid %d\n", pid);
+		stack_pid = pid;
+		stack_addr = (uintptr_t)&magic;
+	}
+
+	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d87c01..8024b6a5cc7f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -110,6 +110,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXHAUST_STACK),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c64df24..99f90d3e5e9c 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -17,6 +17,7 @@ void lkdtm_LOOP(void);
 void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
+void lkdtm_REPORT_STACK(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
-- 
2.25.1

