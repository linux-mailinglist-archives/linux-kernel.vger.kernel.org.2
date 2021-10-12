Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2542A55D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhJLNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:21:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbhJLNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8CE2106F;
        Tue, 12 Oct 2021 06:18:30 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54CE33F70D;
        Tue, 12 Oct 2021 06:18:29 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 14/15] arm64: errata: Enable workaround for TRBE overwrite in FILL mode
Date:   Tue, 12 Oct 2021 14:17:42 +0100
Message-Id: <20211012131743.2040596-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
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
index 87a07e895db9..c0f7c8d19aea 100644
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

