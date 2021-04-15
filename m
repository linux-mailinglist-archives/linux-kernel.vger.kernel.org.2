Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8236735FEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhDOAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhDOAMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94387611B0;
        Thu, 15 Apr 2021 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618445520;
        bh=B2BChFkSHtl3xDqCBN8vP8mhZzyRVBYFIvZ4j6MWArQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mZ9mNCKOQATACX7SPn93qpAqt++UXOYSG9EVgNYOoDFuq8iZB/SsERVTNDnpPOBWX
         53DyH64jWJM/Dj8Jv+duUMgDzDgutCQjo68prhaQsbTqu2l5giTpYqXXS1C3hHgKIb
         xqrV7FAYsVT62n6sQ3BLUoiND/gonTh1nagu6s08jZZ2q6Q1wMvbW/kdXI6FPvkWr1
         zCDBbkzJfEVmxFKEKhxMX1ty/4pUc8q6/44rLxxeHIINfhqpA0LlVsVRWdjpMTehGT
         rrz2DStm5vV4e5dRIPIEe8j1xweyMrSs3FWcjCdy6HTtqRPHCVIH4Lr+G8Vnfr3Z8d
         UjMrQxJfiqjRA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] x86/events/amd/iommu: Fix sysfs type mismatch
Date:   Wed, 14 Apr 2021 17:11:11 -0700
Message-Id: <20210415001112.3024673-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_attr_show() calls _iommu_event_show() via an indirect call but
_iommu_event_show()'s type does not currently match the type of the
show() member in 'struct device_attribute', resulting in a Control Flow
Integrity violation.

$ cat /sys/devices/amd_iommu_1/events/mem_dte_hit
csource=0x0a

$ dmesg | grep "CFI failure"
[ 3526.735140] CFI failure (target: _iommu_event_show...):

Change _iommu_event_show() and 'struct amd_iommu_event_desc' to
'struct device_attribute' so that there is no more CFI violation.

Link: https://github.com/ClangBuiltLinux/linux/issues/1350
Fixes: 7be6296fdd75 ("perf/x86/amd: AMD IOMMU Performance Counter PERF uncore PMU implementation")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/events/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index be50ef8572cc..6a98a7651621 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -81,12 +81,12 @@ static struct attribute_group amd_iommu_events_group = {
 };
 
 struct amd_iommu_event_desc {
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 	const char *event;
 };
 
-static ssize_t _iommu_event_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
+static ssize_t _iommu_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu_event_desc *event =
 		container_of(attr, struct amd_iommu_event_desc, attr);

base-commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
-- 
2.31.1.272.g89b43f80a5

