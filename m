Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9FA43FB65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhJ2Lc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231754AbhJ2Lc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C7926115C;
        Fri, 29 Oct 2021 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635507028;
        bh=cIT0bnNlx5iIGJokoXgfb/yoQCHCSxX07PLQuki70OA=;
        h=From:To:Cc:Subject:Date:From;
        b=L6KvY7tmqblCDW5SxY8H6iNxB1OceRmAUsy+CmTf8afiQS2RNvPqrlQLfiol8UT0x
         88aHItvZjoig8dnSCDAQfoKFjZCaZ9LsyFQDhBi7gUHJtQHwAmfpBKEsOkv9tcJX6S
         ZTRx8+cjbM/CnOrBCVBLu1GG2STAxJKUiQ2utb7/DyIesJIKZdqTIbaC5o7Af58lt4
         3ufTQE2k4kSK97SjyDSonPsE74Olxzm3ehqFDeuSTtudsU0XPAJyb88az3I3eC1XDO
         bM1dYglU8DQNv7bdqje1v8M9buBCXOrIZYjPXnr+nnbYg865qEo4ePTQkzvba5uhL3
         fhRBDd9dUlDiQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] arm64: export this_cpu_has_cap
Date:   Fri, 29 Oct 2021 13:30:16 +0200
Message-Id: <20211029113023.760421-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It's now used in a coresight driver that can be a loadable module:

ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!

Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if we actually want this to be exported, this is my local
workaround for the randconfig build bot.
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ecbdff795f5e..beccbcfa7391 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
 
 	return false;
 }
+EXPORT_SYMBOL(this_cpu_has_cap);
 
 /*
  * This helper function is used in a narrow window when,
-- 
2.29.2

