Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3044C079
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKJMCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhKJMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51461C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1476718pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=or3jAOB1bNItBPsbmfV4gAOL85INAEE09CRqDlIF7AM=;
        b=PnF8ewyTt5bfzqsAjvKGw2OfbwgaHPbWz44Ool++CUamxcyVin55wUt2Z2i+RS1E6i
         EDqCb7j6q8ZqrvQjFU4vMiXSCaeo0/QyeGGBkhv4nvcUHjLnKnV28Xfp+v2vNKUK36QK
         XVtbo65TchM71hb6D8pSOe1Sw7cMwZvr7Vss7GgU7Es4/7BAEtoV5SUCmUcFshalTNMU
         25IBnkKgbca48NPWFqDO5BQY4qVG21rQ0WOfRFrBKU/i4IoktD4TYvt7d54VLWp3/0uL
         HsviFvKpV9vvqGM9UWPiLj40cIG1QsPOwt4XbrXAlLEIVGRNQEZtEP9SnZ6UqQM3KQoB
         cb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=or3jAOB1bNItBPsbmfV4gAOL85INAEE09CRqDlIF7AM=;
        b=lpGYUukdR0SaM/5VR3AyKEl7oaBte7EyTM8bdGtFEiQAmYnKnaVSisi0lPx1iYDSAY
         fjV4MJ2riPX9w79txB06yeFyA+2w+h/Xp9oz+pA4T+FATNOX+ZCIX4HbsOfE8qz4L25w
         huRvPriDXJwH3oVdA1o2KehQUdUPv51VA8ccTOAbSPADak71x78qYqWbiP2HJYsDxjww
         Jddfypcl6ecZn+pX6B2qRu40Ckji/ekSvrML6k9wlv56tjwzwNAKTrneHDxsFYWL13tj
         c/hawNLyNuMMX7l9P8NVOobDoM4TwD30IE4VZjgkBuqmfYZFRnKRvmNvLEqkwaoczyBu
         Yv2w==
X-Gm-Message-State: AOAM531nG/NVMzBIp79cn3XPwA6AZCS7Hp7gSh2fmr/LxrLzEpsfHIBm
        7+uGMARjF1DsjhhE0vVswT5FQCoVVEI=
X-Google-Smtp-Source: ABdhPJxeZSL956OO7lAwYvEN1osoWjfoYDtIDdMSQ6ZFzv2TPYRemlIVy5hnMyK39aLNrfe9xuFoTw==
X-Received: by 2002:a17:90b:3b45:: with SMTP id ot5mr15869785pjb.235.1636545554773;
        Wed, 10 Nov 2021 03:59:14 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id y4sm24160636pfi.178.2021.11.10.03.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:14 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 17/50] x86/entry: Add C user_entry_swapgs_and_fence()
Date:   Wed, 10 Nov 2021 19:57:03 +0800
Message-Id: <20211110115736.3776-18-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C user_entry_swapgs_and_fence() implements the ASM code:
        swapgs
        FENCE_SWAPGS_USER_ENTRY

It will be used in the user entry swapgs code path,  doing the swapgs and
lfence to prevent a speculative swapgs when coming from kernel space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index bdc9540f25d3..3db503ea0703 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -49,6 +49,9 @@ static __always_inline void switch_to_kernel_cr3(void) {}
  * fence_swapgs_kernel_entry is used in the kernel entry code path without
  * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
  * getting speculatively skipped when coming from user space.
+ *
+ * user_entry_swapgs_and_fence is a wrapper of swapgs and fence for user entry
+ * code path.
  */
 static __always_inline void fence_swapgs_user_entry(void)
 {
@@ -59,3 +62,9 @@ static __always_inline void fence_swapgs_kernel_entry(void)
 {
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
 }
+
+static __always_inline void user_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	fence_swapgs_user_entry();
+}
-- 
2.19.1.6.gb485710b

