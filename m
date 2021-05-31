Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082D395895
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhEaKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhEaJ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0376861249;
        Mon, 31 May 2021 09:58:05 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lnegM-004Z7v-UL; Mon, 31 May 2021 10:58:03 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH v2 5/5] arm64: kexec_image: Restore full kexec functionnality
Date:   Mon, 31 May 2021 10:57:20 +0100
Message-Id: <20210531095720.77469-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531095720.77469-1-maz@kernel.org>
References: <20210531095720.77469-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, akpm@linux-foundation.org, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an arm64-specific implementation for arch_kexec_locate_mem_hole(),
using the resource tree instead of memblock, and respecting
the reservations added by EFI.

This ensures that kexec_file is finally reliable.

Reported-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/kexec_image.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index acf9cd251307..2a51a2ebd2b7 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -156,12 +156,31 @@ const struct kexec_file_ops kexec_image_ops = {
  */
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
+	int ret;
+
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	/*
-	 * For the time being, kexec_file_load isn't reliable except
-	 * for crash kernel. Say sorry to the user.
+	 * Crash kernels land in a well known place that has been
+	 * reserved upfront.
+	 *
+	 * Normal kexec kernels can however land anywhere in memory.
+	 * We have to be extra careful not to step over critical
+	 * memory ranges that have been marked as reserved in the
+	 * iomem resource tree (LPI and ACPI tables, among others),
+	 * hence the use of the child-excluding iterator.  This
+	 * matches what the userspace version of kexec does.
 	 */
-	if (kbuf->image->type != KEXEC_TYPE_CRASH)
-		return -EADDRNOTAVAIL;
-
-	return kexec_locate_mem_hole(kbuf);
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		ret = walk_iomem_res_desc(crashk_res.desc,
+					  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					  crashk_res.start, crashk_res.end,
+					  kbuf, kexec_locate_mem_hole_callback);
+	else
+		ret = walk_system_ram_excluding_child_res(0, ULONG_MAX, kbuf,
+							  kexec_locate_mem_hole_callback);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.30.2

