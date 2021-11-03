Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA22E444AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKCWPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:15:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKCWPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:15:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC17ED1;
        Wed,  3 Nov 2021 15:13:04 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7535D3F7D7;
        Wed,  3 Nov 2021 15:13:03 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org
Cc:     arnd@kernel.org, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] arm64: cpufeature: Export this_cpu_has_cap helper
Date:   Wed,  3 Nov 2021 22:12:56 +0000
Message-Id: <20211103221256.725080-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Export the this_cpu_has_cap() for use by modules. This is
used by TRBE driver. Without this patch, TRBE will fail
to build as a module :

ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!

Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ change to EXPORT_SYMBOL_GPL ]
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f8a3067d10c6..82e68c69bb99 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2839,6 +2839,7 @@ bool this_cpu_has_cap(unsigned int n)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(this_cpu_has_cap);
 
 /*
  * This helper function is used in a narrow window when,
-- 
2.25.4

