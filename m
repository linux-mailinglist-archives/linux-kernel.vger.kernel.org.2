Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5B4189C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhIZPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhIZPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1787C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so11338166pji.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9REc692rzVNUtBvgBuX3Ic1YNzni9WvqvFJTpPW8xic=;
        b=CD2HJeGI/20PeGAPj/BbiwSdCEsCZYFYM+LtM2RhvkCTFnkrUBSfIKKJp5Ln8ctsvT
         hC0Gp+7Ygctwzu/1Mt+PYFGzC68/4UnlAMvfre1YXyvSEns2Nzm+i8KXy/S+P2lxMe6j
         9Glz6ojP0N+kyYcBHB0ITDGa9NQ+vLAZ1SYJ55lb13qf6cY2QL8JTd30rT14Nc7JmUcP
         aTdgcEAnewBk/RtVsz1yZzK2mVq/BhoGoLtVu9Lo6Mi4/QyTA9kDmR+rjseyaKpiIGnQ
         9ntObezhU1K21tywvdAyEEnlGGaPVupuN9OwjfnPsbfpM+h8BsUmJ8wz6FoICWTS7NvW
         komQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9REc692rzVNUtBvgBuX3Ic1YNzni9WvqvFJTpPW8xic=;
        b=DM8KcnzTsFZ8Ez8aISzLNgd1oQGcCAaHhq0TfalvTiClaDaWRfUcv/POBT1mUgpmJC
         8ISvPpMB0w+C7E5XoTC6Bl+ThHIX8FOI/ogdTNorPsggoPzbqI0AjOEmNySTHrGltH1D
         3O3fAtJ3ijLMH530hqaurFPi6m6BT9Nd45bYptZKweM/UM0ucwjJ5uR0wl2h1e/WSaBR
         O9eHo72iCCRxESVrIqfIoU9XNjCT+DMht45m9GlG55DXdUyeCJvP1gCTXF9q5RAvHlcb
         shX8bvwMZBq2T/QmJrrs6weYIhSqjam9bqfSmMBWNi+AytqSNW3hIPIKxfPMBY8a5SRT
         S1ew==
X-Gm-Message-State: AOAM532eZGXdEXftyrCGmdMwqf/zL3VFMG5syTNI578rOk5pikegJncB
        GxrS08Xhr8s3r5XdCdYT4aELiwbVR/xf+Q==
X-Google-Smtp-Source: ABdhPJyU3wJu9+keY/WKQcopXN3mQxj+skUMncBfsHO8QwnedkX0BbAvEr5wcdfGtyTG49bp5JsPiQ==
X-Received: by 2002:a17:90b:3692:: with SMTP id mj18mr3132008pjb.12.1632669052119;
        Sun, 26 Sep 2021 08:10:52 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id h15sm13849810pjg.34.2021.09.26.08.10.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:51 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 20/41] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Sun, 26 Sep 2021 23:08:17 +0800
Message-Id: <20210926150838.197719-21-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It switches the CR3 to kernel CR3 and returns the original CR3, and
the caller should save the return value.

It is the C version of SAVE_AND_SWITCH_TO_KERNEL_CR3.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 5f2be4c3f333..faee44a3d1d8 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -32,8 +32,23 @@ static __always_inline void switch_to_kernel_cr3(void)
 	if (static_cpu_has(X86_FEATURE_PTI))
 		pti_switch_to_kernel_cr3(__native_read_cr3());
 }
+
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3 = 0;
+
+	if (static_cpu_has(X86_FEATURE_PTI)) {
+		cr3 = __native_read_cr3();
+
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			pti_switch_to_kernel_cr3(cr3);
+	}
+
+	return cr3;
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

