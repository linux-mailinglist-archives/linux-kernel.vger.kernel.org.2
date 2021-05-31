Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3B395892
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhEaKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhEaJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7304861220;
        Mon, 31 May 2021 09:58:03 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lnegL-004Z7v-MZ; Mon, 31 May 2021 10:58:01 +0100
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
Subject: [PATCH v2 4/5] kernel/resource: Introduce walk_system_ram_excluding_child_res()
Date:   Mon, 31 May 2021 10:57:19 +0100
Message-Id: <20210531095720.77469-5-maz@kernel.org>
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

Introduce a new helper called walk_system_ram_excluding_child_res(),
which does the same job as walk_system_ram_res() but excludes
overlapping child resources.

Again, nobody is interested in such a filtering, so no functional
change is expected.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..f9638d085349 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -320,6 +320,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_excluding_child_res(u64 start, u64 end, void *arg,
+				    int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 0e4d2ca763cd..92b765eaba58 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -492,6 +492,21 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     false, arg, func);
 }
 
+/*
+ * This function calls the @func callback against all memory ranges of type
+ * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY,
+ * excluding RAM ranges that have overlapping child resources.
+ * Same constraints as @walk_system_ram_res apply.
+ */
+int walk_system_ram_excluding_child_res(u64 start, u64 end, void *arg,
+					int (*func)(struct resource *, void *))
+{
+	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE,
+				     true, arg, func);
+}
+
 /*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
-- 
2.30.2

