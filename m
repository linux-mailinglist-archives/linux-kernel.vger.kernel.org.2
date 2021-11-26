Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7945EB85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377342AbhKZKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377126AbhKZK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:28:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CCC061377
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9579551pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=PMEpPf1KkP8FZmDY7dTI3nxwiiFOK+K8g14MTr08HP77QbgVutqyemrh3D/5GwmaJ/
         r0Yy8DzFpzZhMKaSyv9snzGxn99xBxn2u9aremG2nr+joTM077TsIOvojg6Hwm4oV26y
         zwU98MI0CxWwCeRVQITnvkQAOxJ2algjW6/YFCNo/+LM/V39uOhgWmita222rE4w+QR3
         CWOXZA6ko83y90UpTj88JlGTuPDPgutCgcJwiALyj2cLxMsp5H8PICn8hV24ON44JhGp
         v2eqI+xFL5qvq3u+GxkAVp+OWoG991etMEWFXsAdq/zDJbPYoe8QtScwDU+R9t/9KTMt
         KDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=KuhzIFIWQqnHO9eAMp7inMWsOTT9RcxBrYxKYLC1AZEFezG5QuMx3dK2LxIowLo/wS
         IxyAvPK+1lUsJFx3hm/FfXwuOVQIi1PelHqLAcJPESn0XAoCELm2GlwPgtZLr2Ur0hHm
         3tV0tMX0NRuqS+y9ej64rqUiAT4raA+LlSvgWxsWVMCZeS3hYruO0mi783RYNP4EafJJ
         KA4VlCvSazWKjpt4/O74gMIrUPh7Eody4XS4lLHIXZ7TIiomWKWhoskHg1XyHpmLoz0I
         KHXoiks5GFUDE6Ry1w5p6ReL7BIC/JwTg0xkosUQWQla0AMfmqYQ0VMsR+YMWpD4fuQu
         WDVw==
X-Gm-Message-State: AOAM532PWOfmS45SgHH0OaXDPxIAOkAW8eabyUs7BRPDi0Lix9PxXRPz
        AO+HS0+7LSCPjFLoQC39KKXLpccGxbI=
X-Google-Smtp-Source: ABdhPJxW9bnBGe2hnff7vJ+oY5uH/06AyCwE97tHSHPqFDsDsmjmMrX3rwUb3XP9/KFUxAIXl/gJRw==
X-Received: by 2002:a17:902:d703:b0:144:e012:d550 with SMTP id w3-20020a170902d70300b00144e012d550mr35723235ply.38.1637921769480;
        Fri, 26 Nov 2021 02:16:09 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id j38sm4524667pgb.84.2021.11.26.02.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH V6 40/49] x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
Date:   Fri, 26 Nov 2021 18:12:00 +0800
Message-Id: <20211126101209.8613-41-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

