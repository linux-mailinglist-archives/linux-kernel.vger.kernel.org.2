Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81593CA28E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhGOQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:43:17 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:54608
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbhGOQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:43:13 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E2DF640666;
        Thu, 15 Jul 2021 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626367219;
        bh=uc6vqNzYpIOeLZJmcJkkuLJwSOwkwnW/xayvsUoJ5hw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=h8YYOxOj/sX4kxryH7r0bb2umD2NKquSbF1r25wzHN1fqXURTu8GQSyyymkHhdyG3
         CqrN+ocOuHpVOGialoWpPnoIdlmqvYpAFeg/dODtoNUx1n83Ra6dxwYa+v8zknNfeP
         Z0kYGXjFj/yyPRT0856sVHBPrdB7MxFSxPX51+nF9IP7x8sOokFQxmkPa1ma/kn5R/
         VkNxt/hes8ZVyCvBO7MLS3/H72kikkDxuntBIxqNC1T5koxip02o/RoS902vwJo4Uk
         gm8YiRIn/kc5hzEcdwtLCQhDfPWDm22xRvmz/ZKw71koODg8uu9vnTz3gXetvvbVWI
         liwEFqUpVUn5w==
From:   Colin King <colin.king@canonical.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] smpboot: remove inline from __always_inline'd function idle_init
Date:   Thu, 15 Jul 2021 17:40:18 +0100
Message-Id: <20210715164018.62712-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Declaring a idle_init as inline when it is __always_inline is redundant
so this can be removed. Also swap the order of __always_inline and void
to match the more usual coding style.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 21b7953f8242..cf6acab78538 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -47,7 +47,7 @@ void __init idle_thread_set_boot_cpu(void)
  *
  * Creates the thread if it does not exist.
  */
-static inline void __always_inline idle_init(unsigned int cpu)
+static __always_inline void idle_init(unsigned int cpu)
 {
 	struct task_struct *tsk = per_cpu(idle_threads, cpu);
 
-- 
2.31.1

