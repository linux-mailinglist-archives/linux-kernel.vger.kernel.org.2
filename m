Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20242D0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJNDgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJNDgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:36:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820ECC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f5so4221095pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=nUm1ZuwMUbNMwIiwPOHCXpwAqkRU5EupQOyob4lUMahrMse7Xm1yYdkizsaF9Dt8j4
         mZxHVVbr36N/KW35MX+BNGaao363kmyjOQxowiqvpUiDHssR0SlbkdrM7lQgDSQso+dn
         d2NFEVnlCZxJGspBPtdOlwYSRnfGI+0Mv5JyVsUcRko0OKYekbLeCgVCzElJEgj5G+yl
         nKiYH0sv0cyGj7mBvLlN2PbH8h32gCLFKGvev0V7TIr+Re9mCzyimCEACn2ryY5li5yy
         y0hp8sImvZtPAnR1Z19hXDi29rXXncdCCa48/TjCXZyarZquOFItp4vDrwcnfG5lGUEA
         G9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=O9SsZ1vKNjUZUQaOq5V3D68YGxyVvRsT4/LQ/SWMST1BH5Oo0Z/fc9tTZq9/7n3As0
         ZTujzU7KLhi6hpmPVuKRxXNQubFm7PzjgScSOv3HK73erksTtkO9USgim1qZE+nl6EuE
         afmizkEpt++zhoGa1Rt5f3v8XcOcNuQ+3b2asGVYe7llLRQoOxNwSpvvX+NF4sGMjbqs
         TUTGZK0Kv8b8OovU+ep6cJ4qPXKGFrzQ+dDHfckyf6d9uCHycGwUpWtNurlCxIX+gMqc
         aKH8KF1Yx/H6P30XVbinQ60Zpw4Ji3K3hzt+xgfxb3xgm3oxJqgWWyGKumxVGr958SQs
         4A2w==
X-Gm-Message-State: AOAM532/YfmhPGoh3OPGo03tpZqf/YvssCNxExhJbnQqa7QZ94gP58su
        XkWiIeheC7sM7ZCQm/awE+NYrZfIQx0=
X-Google-Smtp-Source: ABdhPJyngImsQ5HuGSp1L7GGgyJNUJMNR2WlWOr/zZNen7kA4//V9SM3nTLhpqPCaiQJOl0vSy5Lcg==
X-Received: by 2002:a63:3548:: with SMTP id c69mr2445217pga.111.1634182471863;
        Wed, 13 Oct 2021 20:34:31 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id s30sm368620pgn.38.2021.10.13.20.34.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:31 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 07/49] x86/entry: Introduce __entry_text for entry code written in C
Date:   Thu, 14 Oct 2021 11:33:30 +0800
Message-Id: <20211014033414.16321-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in C files.  __entry_text is needed
to set them in .entry.text section.  __entry_text disables instrumentation
like noinstr, but it doesn't disable stack protector since not all
compiler supported by kernel supporting function level granular
attribute to disable stack protector.  It will be disabled by C file
level.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..6779def97591 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
-- 
2.19.1.6.gb485710b

