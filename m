Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5303E3A1193
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbhFIKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbhFIKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604EC06175F;
        Wed,  9 Jun 2021 03:51:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so46115pjb.0;
        Wed, 09 Jun 2021 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Um4qaxD6KeGekRGDWrNdCAWK1jv4XJcjCF5+Sh3WM4=;
        b=WCjW2nLb90HvrvyB5myLNMHfT7qqM4OHz8LiIqXVQYnPzNc3FneSc2CX3V1ekybpkJ
         6jeyVA2aj6oT7QPjxotIYbfj2ijeCjaifzTbNqcU0qXpMdoVjcJN5KXhmegBjV6VAc7m
         gXnXanNvk1DplgwOwiGImoy0aKocpEkjxW1xvLOT1jOwvySY+UMNB3vBBFVqBstbnlZk
         vcL+4nXRv7lwMi3mjKEyZ14v9FcPB8Ppjeu1gFV8sbxYC4g9w/jGVsJlfoLqRaCtMeCX
         lt4vrsY8sv8Zt5s1fedo4TyFsZ488FvLEmapacTjyjHhtj7SN9UhZ5iILzoaqtb4ZEov
         1/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Um4qaxD6KeGekRGDWrNdCAWK1jv4XJcjCF5+Sh3WM4=;
        b=VlI+Ct6UR8CfW2KzP/OkHfp0SQvzS7cHiVct2f6PH40LpAsEsfiLnSSsJgKfUcVUEQ
         0MdLnP/f1sV6HlIR/OxcwI1ERdxOPplhn7TrJY3N0xH9TozS1oAHgCu26SLkZVcp7J/Z
         nrdVukxMw7Cb1ugU6UoA2KMm8hpuW67Oq/gfAND4ddUxYm0OGgWZra6RxIjGiGz1IuN+
         MnEsdM9fXJoCrvS08rnVBjZ60AN1nMmA6NSSxI89zxPniZ4p/5QLFiPShmxtkA95sl4N
         evgrkiUClttzjHI4yvAQUexL4G69H+Xj4JpxlGajwkgVUSTYXGt6iePihhckf7xMoFZc
         PYIg==
X-Gm-Message-State: AOAM530eeV14Cc/ZLioM6RV0L+w6UD2RFbrwlF9MuBybgzG+/07BPetK
        ejg/6pGVNh8UWpP3iQaATVU=
X-Google-Smtp-Source: ABdhPJxAqUrqL2GyQmY8ZkmuYOawbXFVjYJM+epYMVdY+QOe1nWU7PjWzmOvwUqhDw/qO511f1h2jw==
X-Received: by 2002:a17:902:db11:b029:110:a7cc:ff46 with SMTP id m17-20020a170902db11b0290110a7ccff46mr4737079plx.60.1623235870524;
        Wed, 09 Jun 2021 03:51:10 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id v22sm13115353pff.105.2021.06.09.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:51:10 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 4/5] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
Date:   Wed,  9 Jun 2021 19:50:18 +0900
Message-Id: <20210609105019.3626677-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609105019.3626677-1-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
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
Cc: Guo Ren <guoren@linux.alibaba.com>
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

