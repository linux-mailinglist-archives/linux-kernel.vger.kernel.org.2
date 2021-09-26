Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E944189D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhIZPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhIZPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA40C06176F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so13399964pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=QT7Z7CZ4ihmbLovTThiqZIERzntEpx9oj/qwcJH+6tD5ezTzaSRw+ZptiBpfcrbesQ
         hOUhclJxS9zaukZMLvKHx8u1ri8RsW4wllB0u1aC1tsA7N/lK7drAOcOVuFigXljGrNe
         pIA7zP96NlRxm6gc9PUZMGdQ9SZY3BNp1P+OIVv1eH9M96B6JI4g0YXywv9+BepyOUkO
         CNQ02G/MY7h2vno3TQ1v2Ho16pOh9B2XnP7AaW/95mMCwTyqG+pCcqaKOBUnJyuWZgt1
         z3QPHMBuGFwh5qYZ7bULp/SukkmHL6AkOp0+RQKo/cEt27mwcJKQ29V79nl13nKtF2kt
         V0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEODT4cHy8v1YRxwVEuwYrnWfee/2o+OJs75MXKU8sk=;
        b=ZcE2SonJ+K15/yCct4efT6gUwlyTNMh6jO6M6FiRxrLK/lcwXk0fOHA5Ooc1mgG8Az
         9RaC0XH3K4ofPEtjNbWThyIXQyUwMqoQCvRgKtdhgCcJnmuL6Hy9GBIX26WKQ9mBpKDC
         eicNOHx/dRtEfMVHFXGjsALuqvUA1DtAn6Fa9rAc0/VNJ+BFxypAwtsNN1OaR0laEj4I
         wHirQkXvwnCcLKYRqZPCOCw2zhkJxnO4sQdvatKaPCrd0d/M7IDSROkyZZ4+hC1dOsZg
         e9aQUVFPU16IsEKGBksvDx8SMlD7lmUqIl379YmuWsEPOF7ucjk1/BXowzJUQcw/iX8u
         SZUg==
X-Gm-Message-State: AOAM530Wkj2MDBexJzHDii6h1gVHct8jjO9Z4w2eXlqQ9Motf/qOtV7o
        dHNkoFupI7HL+Z1ffYp2juBtqHkGd9CdgQ==
X-Google-Smtp-Source: ABdhPJyBVYg745ZpAVF30X/EBjPrvfWtxMaD44sd+1WQt4tFuPuNZx7IStB+TrddTP+c27E70KBHnA==
X-Received: by 2002:a17:90b:4901:: with SMTP id kr1mr14521293pjb.80.1632669121110;
        Sun, 26 Sep 2021 08:12:01 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id k9sm14296324pfi.86.2021.09.26.08.12.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:00 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Libing Zhou <libing.zhou@nokia-sbell.com>
Subject: [PATCH V2 30/41] x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
Date:   Sun, 26 Sep 2021 23:08:27 +0800
Message-Id: <20210926150838.197719-31-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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

