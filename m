Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B46531069B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBEIZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBEIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:25:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D96C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:25:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s26so2020856edt.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DiMCyj8mPuiR2R7d8EODBHiDVU1BHhxBJV3p3VRw0+8=;
        b=ZRcnTr65e7MXCGTJxkL+dk4SXN57KJkmxavPQ/8P3g3yZ9CzRQLGG0sQaEiUcG69aD
         AuUY5GuFHaQ1dViKNHBdCNfZqWvgIPGqIg+l5gbGS++Cpv1ijO36RG4UDUtLllJw0KnT
         oQ5GMH1kCzpQofnSKSzu7Sn9v4Ao3JxpBb2Ntt7cTPcbzUFjkZvSlzLdAMaIvGEKTpQJ
         bIC7j5eH014x+px0QibTRDlI6DcxHWRfiaV3CO0a55EI7w9YypTtjbvAYDNlMLwMJcs8
         xKy4s4wOmniaQye0ctv+9VXoPAp3UQaUf7ULLcibXAxYa7FpNn/RuxkczviHcldSGsDC
         +xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DiMCyj8mPuiR2R7d8EODBHiDVU1BHhxBJV3p3VRw0+8=;
        b=tmp2FXSHQzm/r/FcJN/TUUSMXBv1Y9dPEBETPyOE09eN0lT5ynMxTrSGgyv4OS0XPF
         jHqpJTfaEhKG9d5hC4YcMIW9DV0MAaYoZ+zcqz2RiWJa8ORIxf0pjfZb0CopqIjbAMBl
         uTGXp50Sgk5URDhft9IFPzt2+Qud+Zdmw43FovtdpjS4t9PCmVcsknfvJHaqtQqcu4pD
         XvyuhwgI3i4c83qyq0nxMeE0GB7G6TkAwrvc/dyKs38GqXsmxd0zrVzaQSNCVeBwCE55
         R2CGzn6UERxJjfv7er4uJboNGJfqStY3mIT/BXv4M4Y3ms+ThpT/3R/mBYOrMx+DACsS
         jT+A==
X-Gm-Message-State: AOAM533nQbx9zuPs1CPHywKdJhTnIB3mKJGC0rkCQV3e6zycOydckEIT
        w1X2h80J7jYdEA==
X-Google-Smtp-Source: ABdhPJwG32tODhpFldn6+AHdyN+KvCAwDG2DoyslWHZP8/R6rG5AMgIqrq6sEH4BA+3ZEV8uT1I0WA==
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr2483725edd.0.1612513505905;
        Fri, 05 Feb 2021 00:25:05 -0800 (PST)
Received: from md2k7s8c.ad001.siemens.net ([2a02:810d:9040:4c1f:e0b6:d0e7:64d2:f3a0])
        by smtp.gmail.com with ESMTPSA id p16sm3616007eja.109.2021.02.05.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 00:25:05 -0800 (PST)
From:   Andreas Oetken <ennoerlangen@googlemail.com>
X-Google-Original-From: Andreas Oetken <ennoerlangen@gmail.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Andreas Oetken <ennoerlangen@gmail.com>,
        Andreas Oetken <andreas.oetken@siemens.com>
Subject: [PATCH] nios2: fixed broken sys_clone syscall
Date:   Fri,  5 Feb 2021 09:23:38 +0100
Message-Id: <20210205082338.584931-1-ennoerlangen@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oetken <andreas.oetken@siemens.com>

The tls pointer must be pushed on the stack prior to calling nios2_clone
as it is the 5th function argument. Prior handling of the tls pointer was
done inside former called function copy_thread_tls using the r8 register
from the current_pt_regs directly. This was a bad design and resulted in
the current bug introduced in 04bd52fb.

Fixes: 04bd52fb ("nios2: enable HAVE_COPY_THREAD_TLS, switch to kernel_clone_args")
Signed-off-by: Andreas Oetken <andreas.oetken@siemens.com>
---
 arch/nios2/kernel/entry.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index da8442450e46..0794cd7803df 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -389,7 +389,10 @@ ENTRY(ret_from_interrupt)
  */
 ENTRY(sys_clone)
 	SAVE_SWITCH_STACK
+	subi    sp, sp, 4 /* make space for tls pointer */
+	stw     r8, 0(sp) /* pass tls pointer (r8) via stack (5th argument) */
 	call	nios2_clone
+	addi    sp, sp, 4
 	RESTORE_SWITCH_STACK
 	ret
 
-- 
2.30.0

