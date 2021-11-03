Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73F44444E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhKCPtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhKCPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:49:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EE3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:46:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu18so6165851lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV9n4SAdLEPMCU6YdxAxZdpvS/qm0AKbvMHLYxZ1SKY=;
        b=LNGBCYqb9btktEt6GOoLG5Uw8L6T4ZwogV2BButHAeApQWoPxhyzQ1M0nZI/4dwYKb
         YJNKAh1gN9bCmPox0wyYSzUksGqb8ialH/wVa7S0iiEr1QpadlOMnhc+SFWrULncmsBu
         9AM/6bQYeJ87bxfvyj/8/saVCZQeCzEoVIeo9oJ51wK2B0DAx+W3e3D8nxlCAJV5XKVp
         LV6a3KGPFYKZjo87vyZ1c/NaPgLkvmYIzQ93T5eROQ2V2MSvYFK0Hhf1zOlrBqxRwA9D
         VNejM9OBwVW8ukJEK7UaJA2Cg9/D6o0mrfKX4Tz3PXcxhDWDc8YFby1ip8a9I/NNHSRJ
         gwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV9n4SAdLEPMCU6YdxAxZdpvS/qm0AKbvMHLYxZ1SKY=;
        b=XUXSA8oWobMT5i7QiaNkMJuCh6AAxOSx9qy9Jllwj4ZsFrSvmbYa5qdIHVDdfuVmRg
         gUWmymOHyWGGsVT+3VHBkYGVqM96vtCCS8U4VoWs0wi1njFeru4tpGSrICMdQIsD+j0J
         Yujadi64UDvAFYoyhpfMNgZCMSDpGpFRWYdzFTnlBCuZNefw2VMIXA566He3/g6IH7FG
         2zNfoHK+Uu7aBBbm9ra9jd9F8ajASrKJ/XjbQQh/19i2CDMmgE0iG1gvLxcjNrVKy1TL
         cHG75Imn8npk4gCuHrpekPLm0JYcJ+91zAdvrTq45/7V1WVephzUb9BnqV3qrkpR48rK
         iPQg==
X-Gm-Message-State: AOAM530s7rOUBCB5dx/OOccEJl4/HDQQR1rkrIQ3NgmrPCJwr5BHTFla
        h8ADKdgIkwhPTKZzISSR/5Udmw==
X-Google-Smtp-Source: ABdhPJzzl3X1NQAtWIZXAzzDlzWIJQaUmJ3J4KK2GglNTxy5pm27aHbK3e+X+n2WD1x7iITIeK5v+A==
X-Received: by 2002:a05:6512:a93:: with SMTP id m19mr43696013lfu.574.1635954382620;
        Wed, 03 Nov 2021 08:46:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p8sm237723ljn.54.2021.11.03.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:46:21 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 951EE1033EA; Wed,  3 Nov 2021 18:46:18 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 1/4] x86/insn-eval: Handle insn_get_opcode() failure
Date:   Wed,  3 Nov 2021 18:45:52 +0300
Message-Id: <20211103154555.23729-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
References: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_string_insn() calls insn_get_opcode() that can fail, but does not
handle the failure.

is_string_insn() interface does not allow to communicate an error to the
caller.

Push insn_get_opcode() to the only non-static user of is_string_insn()
and fail it early if insn_get_opcode() fails.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/lib/insn-eval.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a1d24fdc07cf..8b7c2f2ea8f4 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -37,8 +37,6 @@ enum reg_type {
  */
 static bool is_string_insn(struct insn *insn)
 {
-	insn_get_opcode(insn);
-
 	/* All string instructions have a 1-byte opcode. */
 	if (insn->opcode.nbytes != 1)
 		return false;
@@ -1405,6 +1403,9 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	if (!insn || !regs)
 		return (void __user *)-1L;
 
+       if (insn_get_opcode(insn))
+               return (void __user *)-1L;
+
 	switch (insn->addr_bytes) {
 	case 2:
 		return get_addr_ref_16(insn, regs);
-- 
2.32.0

