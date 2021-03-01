Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA63276D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhCAFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:06:53 -0500
Received: from foss.arm.com ([217.140.110.172]:51446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhCAFGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:06:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 814111FB;
        Sun, 28 Feb 2021 21:06:05 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B28B3F73B;
        Sun, 28 Feb 2021 21:06:03 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE
Date:   Mon,  1 Mar 2021 10:36:32 +0530
Message-Id: <1614575192-21307-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already an ARCH_WANT_HUGE_PMD_SHARE which is being selected for
applicable configurations. Hence just drop the other redundant entry.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.12-rc1

 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d4fe5118e9c8..9cd33c7be429 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1056,8 +1056,6 @@ config HW_PERF_EVENTS
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
-config ARCH_WANT_HUGE_PMD_SHARE
-
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
-- 
2.20.1

