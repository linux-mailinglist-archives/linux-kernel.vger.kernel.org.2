Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACAD4189D4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhIZPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhIZPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B415C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so13434660pff.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRaZEb4WEQVcbVbS1m3vczW8RLN1lVEiOfYJ6EyXKpY=;
        b=jbaI0Ei2+KoNy3UViw9dPeYuR1aBzxYoolPCrqFc9ojzXyzJ/UOufIA0iFsGaHa00l
         kCLCYc6zYdXUv6Iam4JIr5wM5gzqK19re373MjOjb75LepzHcan8CSJLVIoAS7SgMpkc
         SO1aa+rGtw9SRTmLNuMjCYI9/VtMLB/v7jvwZgtqt/gCPSl64F37Hwko+0/gBlkLuxyH
         yQhRonpezWhx2c1/2hdBuRoiXv+6dwcRIr5wltMSnHA/OrzHq62pQNbCpRXCH+aLerl/
         IuRzQ/1Kves7c7drAOksRDBxBF1II3E8Pv5xi9zhSIARhAa3kgJi3V6FGLJrWFgnDYbt
         exrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRaZEb4WEQVcbVbS1m3vczW8RLN1lVEiOfYJ6EyXKpY=;
        b=HCN2R7tIDgON550/kQxnYrE3hOL7NTNiF+icJb2ZiSa+LSCRUOR+PmkxMl6KQuWkpI
         m6QflMGhfTIqRd6J8IfvBOAsEr7JoxELK8Yui0VAQHQPeFQN+YMxbUb5vPJWn/71g4M3
         ueMGwCcNJJj0EeVav9tJo/zMwa03UtLUmq0IBlKnhgmYA/tJiomrH9UifyNS3d0YOpoW
         fmYqo4OSk7aCDrjsdKZn/dKLAOGkTrEPN39TeX2bSzb2HfzW5hDQzlsWAs0YU0JMeAwJ
         ahHyZJselTjsWKGRip5qEPlgHLA//VQMJYN1L8XnTJboFI0hcogNvaQwm6mZwgIS/KF7
         c1Cg==
X-Gm-Message-State: AOAM530w4TL910PTxOzDFKKvGSiaHs7XzVrpfR8A/GyWce7DYfW31Oot
        i/9D0ocWEUDJk5S9SP1Q4eD60cH1+GgjHw==
X-Google-Smtp-Source: ABdhPJw+j7cUun4VRUP98cvumZifnCvDT/8GnAlVeOoIJXZbSo9d6tmUsDpj2uAjwHZxmBNigrcmCA==
X-Received: by 2002:a63:8543:: with SMTP id u64mr12586181pgd.220.1632669128746;
        Sun, 26 Sep 2021 08:12:08 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id b126sm15881260pga.67.2021.09.26.08.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:08 -0700 (PDT)
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
Subject: [PATCH V2 31/41] x86/nmi: Remove stack protector from nmi.c
Date:   Sun, 26 Sep 2021 23:08:28 +0800
Message-Id: <20210926150838.197719-32-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

nmi.c is going to contain __entry_code which can not be instrumented
by stack protector.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0e054e2304c6..f56e8088c85d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -50,6 +50,8 @@ CFLAGS_head$(BITS).o	+= -fno-stack-protector
 
 CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
 CFLAGS_traps.o			+= -fno-stack-protector
+CFLAGS_REMOVE_nmi.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_nmi.o			+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

