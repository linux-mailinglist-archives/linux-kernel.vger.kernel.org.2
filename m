Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B56314E52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBILlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:41:47 -0500
Received: from foss.arm.com ([217.140.110.172]:50148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhBILfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:35:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FDEED1;
        Tue,  9 Feb 2021 03:34:09 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6BC03F73B;
        Tue,  9 Feb 2021 03:34:04 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     Jianlin.Lv@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix arm64 build error with gcc-11
Date:   Tue,  9 Feb 2021 19:33:57 +0800
Message-Id: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc version: 11.0.0 20210208 (experimental) (GCC)

Following build error on arm64:

.......
In function ‘printf’,
    inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
    inlined from ‘regs__printf’ at util/session.c:1169:2:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
  error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]

107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
                __va_arg_pack ());

......
In function ‘fprintf’,
  inlined from ‘perf_sample__fprintf_regs.isra’ at \
    builtin-script.c:622:14:
/usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
	error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
  100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
  101 |                         __va_arg_pack ());

cc1: all warnings being treated as errors
.......

This patch fixes Wformat-overflow warnings by replacing the return
value NULL of perf_reg_name with "unknown".

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 tools/perf/arch/arm64/include/perf_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index baaa5e64a3fb..901419f907c0 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -85,10 +85,10 @@ static inline const char *perf_reg_name(int id)
 	case PERF_REG_ARM64_PC:
 		return "pc";
 	default:
-		return NULL;
+		return "unknown";
 	}
 
-	return NULL;
+	return "unknown";
 }
 
 #endif /* ARCH_PERF_REGS_H */
-- 
2.25.1

