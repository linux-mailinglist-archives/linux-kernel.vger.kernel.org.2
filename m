Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39EA42E43A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJNWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:34:19 -0400
Received: from foss.arm.com ([217.140.110.172]:32866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhJNWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:34:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732D51515;
        Thu, 14 Oct 2021 15:31:59 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2D583F694;
        Thu, 14 Oct 2021 15:31:57 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 14/15] arm64: errata: Enable workaround for TRBE overwrite in FILL mode
Date:   Thu, 14 Oct 2021 23:31:24 +0100
Message-Id: <20211014223125.2605031-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211014223125.2605031-1-suzuki.poulose@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the workaround enabled in TRBE, enable the config entries
to be built without COMPILE_TEST

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f30029f4a9f9..f72fa44d6182 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -672,7 +672,6 @@ config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 config ARM64_ERRATUM_2119858
 	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
 	default y
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
 	depends on CORESIGHT_TRBE
 	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 	help
@@ -691,7 +690,6 @@ config ARM64_ERRATUM_2119858
 config ARM64_ERRATUM_2139208
 	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
 	default y
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
 	depends on CORESIGHT_TRBE
 	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 	help
-- 
2.25.4

