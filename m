Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355BD43B45C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhJZOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhJZOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D877C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l186so7896388pge.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=o1sJN1AFqrdXLaqurxRqdppR+FV+CuIQLyam4uavSIvzzeaScHSHgnVF9JMMbdNEE6
         xG74JY9I3+BVH53/zWLSlJJxw1bBftbAbysJddziA+BXm44BGSkAreFmviAas+R3sBmo
         2ZAyGInQHxVULGrWQfZCIQH5KI7i/7abHHutV9MlsjT0SffIc1K/cF5UqXeg5a5swLBd
         Ny0VT2f7Rc/HlrKLFxjBBQd7GaMm0pkOke2WURv4QN82RVgxU2HHyR9XPdfTpXtKEagm
         ZIyIUBVccVKWMWv3IA7nxrl8/garx3nuML4W9CJKEi4lG90+9meGZSEzm9sT/PBzzdCJ
         rA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=T6djyju4UYrlaWxQ/3AN7WeUqxPJRTRbNlluMyhLvyVAaOVr+831LJhp1iLAiTc8ho
         lYjUez9olJJLiIYHISwu38gN3S23DCGir+XGtS59hzDGbG3I7tvTzlhrVYU4PCCN/OVV
         YVu822Ka1Lng2bdQLlUZ7dZFHGBGpSZqwY7GK9gVehO+Cey5x+T0IDwrbBVOO3pEHUrC
         DdKCBMOlh+RmtlKfL8FU6dfof0Va6DXo6JG6D76xwXAPdHa+UBDJY9B6DN0UW8tK/K6H
         +b5g6d3IYfy4dQ7+99A2jqW4ZDexJ5fvnDKfOjuvgstRDdsWOUVQs4IuTEtzVsl9c2oG
         fX/g==
X-Gm-Message-State: AOAM531rvppzMaJMf3Jg3BSQi9qtRUAE+w0wbVselkl/+6jqqJAMb0de
        RPcn8OGu2f+lpSqYZjHZQBSYGJZRzxI=
X-Google-Smtp-Source: ABdhPJw+bJqLut9sSw5p+8i+UPWULexjKC3RuvYJQtYKhWH+3tQ3jBcYlD3O2QgjWVpm6m4wA0tXIA==
X-Received: by 2002:a63:7a53:: with SMTP id j19mr16571388pgn.275.1635258994494;
        Tue, 26 Oct 2021 07:36:34 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id z6sm1157266pjr.35.2021.10.26.07.36.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH V4 41/50] x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
Date:   Tue, 26 Oct 2021 22:34:27 +0800
Message-Id: <20211026143436.19071-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

DEFINE_IDTENTRY_NMI is defined, but not used.  It is better to use it.

It is also prepared for later patch to define DEFINE_IDTENTRY_NMI
differently in 32bit and 64bit.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802d25fb..44c3adb68282 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -473,7 +473,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_RAW(exc_nmi)
+DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	irqentry_state_t irq_state;
 
-- 
2.19.1.6.gb485710b

