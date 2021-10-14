Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17842E43B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhJNWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:32816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234301AbhJNWeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:34:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23917D6E;
        Thu, 14 Oct 2021 15:32:01 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4E4B3F694;
        Thu, 14 Oct 2021 15:31:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 15/15] arm64: errata: Enable TRBE workaround for write to out-of-range address
Date:   Thu, 14 Oct 2021 23:31:25 +0100
Message-Id: <20211014223125.2605031-16-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211014223125.2605031-1-suzuki.poulose@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the TRBE driver workaround available, enable the config symbols
to be built without COMPILE_TEST

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f72fa44d6182..d6383ef05871 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -743,7 +743,6 @@ config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
 
 config ARM64_ERRATUM_2253138
 	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
 	depends on CORESIGHT_TRBE
 	default y
 	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
@@ -762,7 +761,6 @@ config ARM64_ERRATUM_2253138
 
 config ARM64_ERRATUM_2224489
 	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
-	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
 	depends on CORESIGHT_TRBE
 	default y
 	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-- 
2.25.4

