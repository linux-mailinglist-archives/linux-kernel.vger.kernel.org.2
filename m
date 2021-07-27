Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9903D3D76E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhG0NfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhG0NfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:35:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C94C061765;
        Tue, 27 Jul 2021 06:35:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so15719886plg.11;
        Tue, 27 Jul 2021 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxXx64wJh9J8hPn+gePi5qyiWEe29yS7cUbB8TFfcfQ=;
        b=KIp3kED2zcd3Q97ZIE9u4TsFWHZ8B+fo3nxr8vHqxBDPjhBRAvJt+sITxIicIWd7EO
         oLOAMoCZcU041JLG4C30aTY5OB5wLLPVbQu6T7fQlzI/fV47CI4UCZNa+B9NqAiqI8Hv
         CSIjKhniHZS69QyKPeRfqX9S3PQx9mdtAGalvQxfnXnVmF2bw7/R8QEGOHjHBtbeUnig
         0+QMubVIBjylxsMt6SIQwIn/HHcHLbBuY0rfMlhvyZMVeEKr9mqFkkCU7vlekPDuAupE
         tyG1IwWtKNncpXp3sb7Zw1biVmEBmlkGOmLZpWvQfotnq8iL2sY3pcn+4XsI8mY+HOcy
         k1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxXx64wJh9J8hPn+gePi5qyiWEe29yS7cUbB8TFfcfQ=;
        b=Yka8vRL23cZGf7662/yO+0VYoIf2wXnWNMQZNPGIRe2LBnPOa3tOW5r8g0pLiImJUZ
         QgxDxNzvHXqK0K28GIW37TQp9TUNAz9NDxWBErnR+P+72zjHywT+UB7+wYYz+TVUZDAz
         79nz65GlI9/UX+oKf6vfXsVzZJs8lpA4TuIfGLuAnYVBT5YXNSx28OVCRT1mnZbycL3s
         yPOnTjHmBXm/Qqk5d2etr/Oh+Bn6VnxCkqjFR9++mwNMHY5N33kGSD8kBdzjGQyg4ZA3
         EDQgn/ogFUOuMttoMf1oO6ZrVvTfBOTB5YTB5ErPuJe56l4ipmYKAoBAHbXlPPDzlcaC
         QLfQ==
X-Gm-Message-State: AOAM5313pG1kRjBQFbFZYUHBSYZM4kJ3dZ3r1b8ikdizaggNNRuxXtxm
        +mlWif+izYXiE1KEKeqm41Y=
X-Google-Smtp-Source: ABdhPJx/RBSPsY+7cD9g/UJXQC9t+wSvrU1yUaSdoRVfqgPPXHQv2qs9rp9wXH4390nP0qXFpX2QIw==
X-Received: by 2002:a17:90a:a418:: with SMTP id y24mr4382304pjp.116.1627392912006;
        Tue, 27 Jul 2021 06:35:12 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id q31sm2979743pjh.13.2021.07.27.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:35:11 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 4/5] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
Date:   Tue, 27 Jul 2021 22:34:25 +0900
Message-Id: <20210727133426.2919710-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csky specific arch_check_ftrace_location() shadows a weak
implementation of the function in core code that offers the same
functionality but with additional error checking.

Drop the architecture specific function as a step towards further
cleanup in core code.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/csky/kernel/probes/ftrace.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index ef2bb9bd9605..b388228abbf2 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -2,13 +2,6 @@
 
 #include <linux/kprobes.h>
 
-int arch_check_ftrace_location(struct kprobe *p)
-{
-	if (ftrace_location((unsigned long)p->addr))
-		p->flags |= KPROBE_FLAG_FTRACE;
-	return 0;
-}
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
-- 
2.30.2

