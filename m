Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3313E4104C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbhIRHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:32:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E854C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:30:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j14so555727plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+ms2zx5gjqrigcEXONGuqB+Z9qoGz9QhB06yxINceE=;
        b=FglJf+t0wY4UQMK7gDJanlQ0+HotsCN2Lqj4eh90NrOmxNZGZZSQhOxxOsVsMW1tfq
         5vPw7rPhpeBQsLVnSrK+OyZj3QMwDauNEsZSzM7TUqCwz3elHvfDqm//kb67vaJeUzwE
         AbT0trTeJyEEakLbz/zagm3217ww2dVA/B+V1dPJF8rgD6o1G8dKNZa6hr6p6yHweSg4
         KpYkM6gjNf8hdxzId03Xgxqeq3aPzNKQz3BM29WhxBcf9U1U7k7t0fHQveOziosRRweB
         kDPPoa6KMxLJgDy1ocGQYyJJXdhY2bKjjtyzQMs0qNfjeeBhE4vXlsHWduOqpxhomw4/
         BM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+ms2zx5gjqrigcEXONGuqB+Z9qoGz9QhB06yxINceE=;
        b=NYNS2HSTkhrFZUwKar2qeTXEKl5GwwmT8FBNgCpWBb7CJMSM6J6D/vLPiUv2IpiWLB
         nwsYzd2WwZgQ0PUmxtAjeVHMsvDdgaC2XIqbf5ow2RkBUdYojbSAqRnRPr7KLobXagR0
         jqcpuv6xyzBNSGR+OvTraRvR2a7+fRgqGNvJpt3kwySZisZgrwQWTkgh0gECdt73X3RQ
         UWPIbNGuf7qmmg8uQV6WBSec+ifjtevZ+2V79YczHmlEnmtydghm1nDZIgIgvMNl2bvF
         IFifzmF3l7yNI6bkFV05gsh3xbNao0MvRbgUfylL5YLE8lx2+y91ANmSECPKMZYrv3Wm
         bllQ==
X-Gm-Message-State: AOAM533haBEhJcM5XLX/7K8CaY+969IlLjl3JHdn+9iy20yMjU8Snnhk
        XSTXuGTwsNm24ybYH0+pbYs=
X-Google-Smtp-Source: ABdhPJzXfQaecTYw/n/y8UpQoZmhvQXtoLnCRDitYSeqdkiS4jOyaa5mbV6zTe2gPVWGs3pQZ7qhhQ==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr25120385pjq.205.1631950246831;
        Sat, 18 Sep 2021 00:30:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x8sm8122553pfq.131.2021.09.18.00.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:30:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH] Fix the bool convert to int issue
Date:   Sat, 18 Sep 2021 07:30:37 +0000
Message-Id: <20210918073037.239634-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The int value which convert from bool true is 0xFFFFFFFF. Causing the
__sc_insn return wrong type.

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ea028e736831..f608e6710300 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -89,7 +89,7 @@ static inline enum insn_type __sc_insn(bool null, bool tail)
 	 *	  1  |   0   |  JMP
 	 *	  1  |   1   |  RET
 	 */
-	return 2*tail + null;
+	return ((tail)?2:0) + ((null)?1:0);
 }
 
 void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
-- 
2.25.1

