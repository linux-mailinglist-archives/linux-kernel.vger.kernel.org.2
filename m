Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380ED395890
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEaKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhEaJ7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:40 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89713611AC;
        Mon, 31 May 2021 09:58:01 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lnegI-004Z7v-Fx; Mon, 31 May 2021 10:57:58 +0100
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
Subject: [PATCH v2 2/5] kexec_file: Make locate_mem_hole_callback global
Date:   Mon, 31 May 2021 10:57:17 +0100
Message-Id: <20210531095720.77469-3-maz@kernel.org>
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

In order for architectures to make use of locate_mem_hole_callback()
and avoid reinventing a square wheel, make this function global
and rename it to kexec_locate_mem_hole_callback() to match the
other global kexec symbols.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..4b507efdb623 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -204,6 +204,7 @@ int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+int kexec_locate_mem_hole_callback(struct resource *res, void *arg);
 
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..960aefc4501d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -517,7 +517,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	return 1;
 }
 
-static int locate_mem_hole_callback(struct resource *res, void *arg)
+int kexec_locate_mem_hole_callback(struct resource *res, void *arg)
 {
 	struct kexec_buf *kbuf = (struct kexec_buf *)arg;
 	u64 start = res->start, end = res->end;
@@ -634,9 +634,9 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 		return 0;
 
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
-		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
+		ret = kexec_walk_resources(kbuf, kexec_locate_mem_hole_callback);
 	else
-		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
+		ret = kexec_walk_memblock(kbuf, kexec_locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.30.2

