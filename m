Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B54189B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhIZPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhIZPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21694C061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so9963053plh.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFfX9t/Gdxc8i2a3P5GGQwEy4L+EoSDF+NLXSky3JF4=;
        b=NJhQJgv8Gc3SvpbehA7iit7LoexOCx2iqMHh0zz3lYn99aEBtqfagPdf79YQRUDfRk
         pUGhgn4gpL5QcltPoVOAvzp2n/E+P9f3P+E6wL10N6bHcHuHDO6wzI5X1w9LsNPA3a0j
         TMY92jjQcFmnOM3NsoM7Z66nbr7BpTD7BtbGRRarGiCTJP6l0ZZC/uWT1rHLKqSeV+jE
         0yF30kfYXPCF4WXYshePM6Bbdqty0fl8QMDVr+e71lsHeiJv9+Mg7Et4/dYIfv6KwLqN
         gzKSAljpZJWD4fBTT1k3Ep42fc0s3n+BHDaZICai4GTg3y0g+dUmI/sMtm0Csld5JHkM
         IDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFfX9t/Gdxc8i2a3P5GGQwEy4L+EoSDF+NLXSky3JF4=;
        b=IAP/LJAgteI4HmMsRzz2Kj3gMfeI3xOFTmjwQM/ua2NNs08Xbu4L7ZwQJXr1nyv+YX
         XiCsgLVuyYyP04Z4NjUcXbSJILmvZ71gbKBrwz1TemsEZfsMax18w9Bk+lVy+tyiq2R9
         6uk40Zr6mZdFnNECU7JbVYlMLHWJg719f3CRyofu+URBb8l814fchyQbIRMVHoPr3I1u
         kUhKtrcPlms1xFPKixbYs0IomxZqwJg32Yy631VMKqMRkTPGJzr1G+YLQ7Ptry1Oulta
         UrkgSBDsXyrIdQou5rPq4hU73ta/8IUWutGsFKBomwXtpvvU2xv1K103MR0X4L754KOL
         KwfQ==
X-Gm-Message-State: AOAM530n8is6fCzRqucQwB4lAvYCqY/LE2kc6UgtWrjGvzTlxAgt8Jf0
        chHuBDpQyJ2ZWTuNvLgq7TnNcEozt/ki3g==
X-Google-Smtp-Source: ABdhPJyLNrqSF9u/d6o4nmrpwY1OCsTT1Pn8OIFuM/RXb93LNvWmUhGYmYGkh1ucAN3xOICT1ORYPw==
X-Received: by 2002:a17:902:9a04:b0:13a:1b2d:8a5c with SMTP id v4-20020a1709029a0400b0013a1b2d8a5cmr18181383plp.47.1632668958591;
        Sun, 26 Sep 2021 08:09:18 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id s3sm611821pjr.1.2021.09.26.08.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:18 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH V2 06/41] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Sun, 26 Sep 2021 23:08:03 +0800
Message-Id: <20210926150838.197719-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

We need __native_read_cr3() & native_write_cr3() to be ensured noinstr.

It is prepared for later patches which implement entry code in C file.
Some of the code needs to handle KPTI and has to read/write CR3.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..058995bb153c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
-- 
2.19.1.6.gb485710b

