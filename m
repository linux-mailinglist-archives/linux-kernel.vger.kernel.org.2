Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0D42D113
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhJNDiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJNDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6EC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x4so3208579pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lwz3W6gdRhlQ67BdKOZO6Xlc6cjt/VXhoMM+nLKwRyk=;
        b=Q+YvSeKXVPe1e1nhwpt3i3iqRXP04p5DTP9+BX/agT2WglrZU7zOrb8uD+c9RoTa7q
         7eQNHvCkwpDQM6QtVkchgK3CJLa94XqQa+bT1EUUnIYwfYX4PwggFMSR7HsWnLzSjvWC
         JdzFbHayV/Y8q5Mcnbwuhla0jIuhocUQ5ia+wc4FCT68h5n9TRQ1Onc2+KNXedxGFds1
         Y09uWOqF30+QrM64TYr4XeBFxJWM2QzbPvbiJucKIMs8io/SzIuJFD33oSiXQNwQh3YK
         D7KZ09ijLGOp1ff49qFpluKMVkvmUptStu52dWzz0G2EXJa0PEU2g9KEGMjzjeFZ7Jcs
         UIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lwz3W6gdRhlQ67BdKOZO6Xlc6cjt/VXhoMM+nLKwRyk=;
        b=m4ooW/7qA14mUB2G8/vJI7Ltfbu1qFMh/sheLHcUwGdfSRaBaZ2lsEne2TS+Wel7Vx
         Ym/uECFZcy4iITa0yNU2azT8yslw8BISVdnJnFuBNCQZfglAPtohmT89NjgQ+HP11XQo
         AdFHEr9jynovApouDHDaguicf4uFWM337F8mrmHYdbPw+kQf58+aV+h0/ZPmqf3CJeI6
         FxVSuJnZHpj9H/zLFbhUxtmy57goClYuDDiUkNGFj9Dw6dCUkstqt+WQpLYMfRS7w0ex
         QSJYQZJiUbLoMZv6Ze7kadysWBCvB2nQpF8K+pOU4zlEI8yoitfG3oGOrGgP8Cl5sXWd
         L5Pg==
X-Gm-Message-State: AOAM532B4wKo4vfDU/89vRvEEjy9ZJ0NfArUu38APWlr7t8Z58hUvRve
        ur/nFVaePKD1xwdq3s1bwHGhV4joyY8=
X-Google-Smtp-Source: ABdhPJzaVi+TM/zRikwGDWXlIWoZ30O6cZW/C55OfOirhLmH/3crtz3+uFCbKVNjE2qy4LCu6fhRmw==
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id ij16-20020a170902ab5000b0013f4c709322mr2772708plb.89.1634182596874;
        Wed, 13 Oct 2021 20:36:36 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id me12sm2542121pjb.27.2021.10.13.20.36.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:36 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 26/49] x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
Date:   Thu, 14 Oct 2021 11:33:49 +0800
Message-Id: <20211014033414.16321-21-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV has its own entry point for SYSENTER, it doesn't use
entry_SYSENTER_compat.  So the pv-awared SWAPGS can be changed to
swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64_compat.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ad20302246e4..0b9661edf652 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-- 
2.19.1.6.gb485710b

