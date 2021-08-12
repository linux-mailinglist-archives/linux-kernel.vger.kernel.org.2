Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1C3EA4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhHLMfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:35:16 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53704
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhHLMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:35:15 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 7D2AA40C9C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628771689;
        bh=fXksQPpDuH6T7x4BT558ZGGix2k0x0Rejn/yRv3oga8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IIhG2uAXgGCTKLClJVk//cM5thqXj+TdlzM2/jqpIYBYA1N791/3SJ2bnhMEN/zbW
         tjvF1ja4XkFs8xhGqhVwHwKt1t9WREiv7gTJaurgDysK1HueEF9TCAa3uDnU1b3kG2
         f0d2M6EV5DxSVFoR3Y0fdFV9B2BUmyLnGbjaUhgEdbfYljrCcltdx/+3ZjhULjo5hD
         oTVVLSj+T+/9YG0YU8bHXBuxGJVHvzi6c0vLJxicDswgdgn4lF3zI84JvV/w1ELHs0
         PCgB1yqQxOt8H0Zq+ZvmKkYMhCOLANJPKGB8s6kIXg6dylq9R33KKQCEe19fWFtYAY
         HSHE0fPBmsRJA==
Received: by mail-wr1-f72.google.com with SMTP id d12-20020a056000186cb02901548bff164dso1770008wri.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXksQPpDuH6T7x4BT558ZGGix2k0x0Rejn/yRv3oga8=;
        b=ZSmUEL6r/+/H3//BTeQ7zpRDTTcjNlzl95toB/UY4fup8Xbj5TlT0PhVOT9kZJRwTn
         KqVO3zWV1xUs1nyYg2z6riijNNJuXM08TmhhSmUcGf5ckQXtoH7vcSQnQLp1al/wAYfD
         aZBEzWCQRjcsQvOERp/dU9nQBnK3YM8HzoJ21WgT7MVF0GW8c1bHcxVluup0RJGUidz4
         buMCqfsYN7QY5P4YWDq30cuJKz6bjL/Jkra6LHvMG6hVNLp1/e4K+VVUx+LixLZfQFH9
         KXE9lhL7YmGvcp6FiBSeNyKzVZpb7gkypnhLyHOvYbOR3ZsT18S0QZutTvnfzZca+Ee7
         pVmA==
X-Gm-Message-State: AOAM532E5/lKIesKOIM5mnsVpGn91hUGb+npPb/dFzJcoDSbCLlFtpXr
        nTowjmeN+YWXlTb5IWN8nk1S//2P3FREtEi8+I+9KLj1CZG0MNl7l7o8YKGKwilgDm25o3ZdBIA
        lDdONPlqTuBbOfcU7H++hMxX+QDL2wQVOCPOUf8aVaQ==
X-Received: by 2002:adf:f08e:: with SMTP id n14mr3655708wro.427.1628771688823;
        Thu, 12 Aug 2021 05:34:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF/ZR5C1BtBNd4kJJCPmKateoDi+EtUFQPs23ytvlz7wdG1g2X3iPF4mV40XLyvZ9KL1CdDg==
X-Received: by 2002:adf:f08e:: with SMTP id n14mr3655691wro.427.1628771688574;
        Thu, 12 Aug 2021 05:34:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:1220:9591:5798:fefe])
        by smtp.gmail.com with ESMTPSA id 129sm2646812wmz.26.2021.08.12.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 05:34:48 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pierce Andjelkovic <pierceandjelkovic@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: prevent sbi_send_cpumask_ipi race with ftrace
Date:   Thu, 12 Aug 2021 13:34:33 +0100
Message-Id: <20210812123433.27871-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

ftrace will patch instructions in sbi_send_cpumask_ipi, which is going to
be used by flush_icache_range, leading to potential races and crashes like
this:

[    0.000000] ftrace: allocating 38893 entries in 152 pages
[    0.000000] Oops - illegal instruction [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-1014-generic #14-Ubuntu
[    0.000000] epc: ffffffe00000920e ra : ffffffe000009384 sp : ffffffe001803d30
[    0.000000]  gp : ffffffe001a14240 tp : ffffffe00180f440 t0 : ffffffe07fe38000
[    0.000000]  t1 : ffffffe0019cd338 t2 : 0000000000000000 s0 : ffffffe001803d70
[    0.000000]  s1 : 0000000000000000 a0 : ffffffe0000095aa a1 : 0000000000000001
[    0.000000]  a2 : 0000000000000002 a3 : 0000000000000000 a4 : 0000000000000000
[    0.000000]  a5 : 0000000000000000 a6 : 0000000000000004 a7 : 0000000052464e43
[    0.000000]  s2 : 0000000000000002 s3 : 0000000000000001 s4 : 0000000000000000
[    0.000000]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
[    0.000000]  s8 : ffffffe001a170c0 s9 : 0000000000000001 s10: 0000000000000001
[    0.000000]  s11: 00000000fffcc5d0 t3 : 0000000000000068 t4 : 000000000000000b
[    0.000000]  t5 : ffffffe0019cd3e0 t6 : ffffffe001803cd8
[    0.000000] status: 0000000200000100 badaddr: 000000000513f187 cause: 0000000000000002
[    0.000000] ---[ end trace f67eb9af4d8d492b ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Where ffffffe00000920e lies in the middle of sbi_send_cpumask_ipi.

Reproduced on Unmatched board using Ubuntu kernels. See
https://people.canonical.com/~xnox/lp1934548/ for sample images,
kernels, debug symbols.

BugLink: https://bugs.launchpad.net/bugs/1934548
Reported-by: Pierce Andjelkovic <pierceandjelkovic@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
cc: Paul Walmsley <paul.walmsley@sifive.com>
cc: linux-riscv@lists.infradead.org
cc: stable@vger.kernel.org
---
 arch/riscv/kernel/sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7402a417f38e..158199865c68 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -562,7 +562,7 @@ long sbi_get_mimpid(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
 }
 
-static void sbi_send_cpumask_ipi(const struct cpumask *target)
+static void notrace sbi_send_cpumask_ipi(const struct cpumask *target)
 {
 	struct cpumask hartid_mask;
 
-- 
2.30.2

