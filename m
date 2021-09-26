Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0C4189DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhIZPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhIZPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C80C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f129so15325188pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vwxfl0XqN2pfXKmI2uM2NFGH9NMmpNH8gndSefAsfpE=;
        b=a5gPb196N8AwZrt40O2XXOVAQmd5LBpkHiznddUdUU7/GpOhQ89AMjY8WPRy249dUD
         gDdR4O5Rzr88ZpDL1SDsrWswQnKmdvR7cnW+Rh2R9l96P+5Fl3Eoup74ZnOhoZjPOSIY
         eLu+tigCkQ0IrG6ca/erVx4uoEthvDSEbFYuOV0ZSZJXzvkvUl8qdIbRwJ30z+18FZdB
         PZAeBVFv/VaBSUNItLtvj8tnyB5lqerZPOXYJaO/J+772NjRSrpDWLWt5nTa/VmCS7XI
         FTRtXmLITGLWSpmu16DJJMJwK7SbE8voOd0Agv/WZvMmZxOoaGfyvRTkNZ8Lz/SclAA3
         yAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vwxfl0XqN2pfXKmI2uM2NFGH9NMmpNH8gndSefAsfpE=;
        b=YpszbIHKepE70cOpdxI+unNhAryVMmDnxqR/7Zxo54dvJNWwI8Uwwt2gh530JGvOQ5
         1lfAyh5nZSvOvFn6NIX/S8FbmLXd6+DApcmjrRo3PXd6LtfugXJIIFrdWTzhpK0ALGoJ
         tqtAI2B+aW2MMXKkpV78yp+/X+ez0H31+ia0qEmUOC9q8O4Xc9yMjy2efZmySZH35DXD
         L4BM1fZzCM2M1xfPWdcaPFS2Igo1cUBLohP796hcYYQbl5nkl6MUFDghf9nmkekzWgcP
         STbxloBrXrcqW0VpRMFUoGi4NaXTFnExPKh/lGMWyj9zWxO185hx6yAPJNkSQtqRMlFw
         Xblw==
X-Gm-Message-State: AOAM531Kb7RXPWhXWid/cWlWtddUyOnBH2GlnP1DyPn8KmQwB1qHSo0G
        Adx2vMu+ZqzTJw0A3mP+3aJ29RZ84XSmwg==
X-Google-Smtp-Source: ABdhPJyFA9WvV1OaMPhnP8GCgGwAT2RtcPtjzHZk4ETkbCcctYXmJgDuNIS3epSc2i9T/dSL6ls/WA==
X-Received: by 2002:a62:6d07:0:b0:446:c141:7d2d with SMTP id i7-20020a626d07000000b00446c1417d2dmr18905946pfc.28.1632669167489;
        Sun, 26 Sep 2021 08:12:47 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id q1sm13917419pfu.4.2021.09.26.08.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH V2 36/41] x86/sev: Remove stack protector from sev.c
Date:   Sun, 26 Sep 2021 23:08:33 +0800
Message-Id: <20210926150838.197719-37-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

sev.c is going to contain __entry_code which can not be instrumented
by stack protector.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f56e8088c85d..88bbfeeab929 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -52,6 +52,8 @@ CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
 CFLAGS_traps.o			+= -fno-stack-protector
 CFLAGS_REMOVE_nmi.o		= -fstack-protector -fstack-protector-strong
 CFLAGS_nmi.o			+= -fno-stack-protector
+CFLAGS_REMOVE_sev.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_sev.o			+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

