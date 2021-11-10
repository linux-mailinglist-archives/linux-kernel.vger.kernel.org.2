Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD244C0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhKJMEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhKJMEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:47 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y5so2472773pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=Zrmd7fa+3Ae0nY8/E/aUhBKEZFFRzG4u53Z+J/mky2yYqFGCZzfGqflBzVlXX98Fm+
         zvGuuY8WEk/K7JqQc7akevuDWhTiRBp/m/CVIsQ46nHu+19gPAtUq1O3Odsevy2cnX6z
         C4cIylownqw4yL3zwLFIDzf90OtWxwpWw37+091rbDiqOZOj1IxIweDFtHjwVKgRy7Ew
         c3DkjjU9IilFldgcy1RCI77j/gQ0es0Cnm+uD3NK/QrEdQQAVw+2UOuKV46lqf01AHh8
         usIfTC+Pe4M5dfQHnoORn2RRAggh0IBqG01aM/bCc3DV140xURCTyFBVOw9ZbZLMjTA+
         OJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=YbRuoEHNvkFc4wE1LQsDAA7Pyb/FdQFD5pz8SdB3BxIoFCvcBE0lwr5qWhz+J18KcL
         aRpWt2NPm0NgBDCDwq7wQYu8Pyxq2E6UfseIeQiuRmeilhQcWc+gVhwhK2KuxdzU14P0
         fdwWtPt0ekwMwdKBODblNOdOYQHNobD89jUSuaz4czgkQYKTgOP6T1yCPmrEnxT5YQJz
         dduD6TLhHsfMDEfxyR5WDFK6Mkr64mLslVWwg57h079gpSlsmcZ1o63wvpOv60tcZM4m
         ZmObje/LE6D39uH9dy9N6Xh/RMEyymE13Bs5J//dIIDV7RZHU432LhN1+UKkeUXYivmH
         hlFw==
X-Gm-Message-State: AOAM532WX67kqm3qXMqfIRuSqSKzTbYfZVye4yTT/bwrWbjoGncZYSO9
        nBbVoDHdTWa/SXsY24k+lEEqePCKdTk=
X-Google-Smtp-Source: ABdhPJwM2fBGlUjADqzW3QV/DAh3ryF1L8a9FQ2L5wYMpCqc/9J4wygtJ6p6PcVp2zDqK2PlFUla+A==
X-Received: by 2002:a63:2a8d:: with SMTP id q135mr901318pgq.167.1636545706857;
        Wed, 10 Nov 2021 04:01:46 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id p23sm5464852pjg.55.2021.11.10.04.01.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:46 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH V5 41/50] x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
Date:   Wed, 10 Nov 2021 19:57:27 +0800
Message-Id: <20211110115736.3776-42-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

