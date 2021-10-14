Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58242D145
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhJNDxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhJNDxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:53:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A48C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so3762554pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=K5WZ4yvkHc6zr0iqAu5hEKrWzujEnn7i6Ek0NyE8EpXCOoUOflCC1n3ujFOD/F9MMk
         Qpaa74Y0zSXr+qVXVJ2hWxwhc0wGt9+PFH/0YqFatTio0aVdJkPfieYXqe++6jGEsOqT
         gnIECAbTO6Kg/G6HeNnU/d4sqvpC5iXeojNMHCth7U/JV2GGkJjO0zby+BYy91stIsVj
         uv2sFbIFiQiZwoZqh1sBVOrJsP2D2iGvgUZpOMzUd/o0pJLCyFAy7vcWvrfwiPWxIxA2
         UqGMFbga3u0DoHCmbSYps77xd8MiYkzusyWVTUPHVjyJzZ/+YiQaBCu3sPbmoqKVrsel
         MYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=ePn4aeqoYi8IV9KONPNYg+xFXxHfrpNzDU6bOga1DrrocF5S/589nNAlMYaiBCObS/
         o7DxlUv+W43jdmJ+6IBEECPbAKG8SkkSM4oOxwU1X8SsIzpiCU/Wnr9kPSJUbF89fWcD
         AsnjnE+1+ZVpEc8F0rT/hh1zXf1b1iRh9EKOSmSqCzO1QF+r/m+sPt3LIPM+iCbXkxBD
         /1dOw80oSyZb2mSIogHJX+MjmJg8Wiap7QNdptA3cIQDspTJYbTi2HMN6PNyM4JAeQhh
         Zb8ouzQhh3NyOrk7j08iPL0A5vUH3/gKdavqfs9UnxiHUcmKnxDqYNSo91Rc+PyO3Tbe
         SPag==
X-Gm-Message-State: AOAM532dOt8DQCYAMHsDGOdyeJNg+IwrGsDydQRN49dzKDGI0ordtm1C
        pUEk6d6YLVlBUBri3Kgax5QEJOLrgk0=
X-Google-Smtp-Source: ABdhPJye7ax15pGoKGbfnjpbLOSj7L8nAZ8cN/rpIe829diuyZwFayMIZO3qWvu0gWDxJEc38C9y/w==
X-Received: by 2002:a17:90a:ad46:: with SMTP id w6mr17747258pjv.68.1634183461688;
        Wed, 13 Oct 2021 20:51:01 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id b10sm865496pfl.200.2021.10.13.20.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:51:01 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH V3 40/49] x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
Date:   Thu, 14 Oct 2021 11:50:17 +0800
Message-Id: <20211014035027.17681-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

