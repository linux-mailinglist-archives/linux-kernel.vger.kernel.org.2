Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347C7381AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhEOUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbhEOUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:24:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B1C061573;
        Sat, 15 May 2021 13:22:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y14so338418wrm.13;
        Sat, 15 May 2021 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H3kWxqXuQEnL5DwEXyW1diyp55Y75IrB9TmE8vDDQPI=;
        b=ZlhWDjC76HNmk5S8sor/OnXsNso5eH3Xci1o/M3QRWhDoAAiFrGgQwvC6lkIRFeg0z
         jSm+TaL/2Hk3R014/3DbrBNq6Oojr77Pcy+RqNtx/ZuoCu/S8eTnJ/vIr/Smmn/mqKIU
         yo33WUnlfIVUm9HGkiUHwo+q663s9YTqzmBXp/+lM3lP1Uk+pSxtlxJX0/9C0cBGTV/q
         gOpHfW+0uJwIi3gmF6/nOwck1vxSH+9Ol+84Bp2Yc55f+gw8+Ri2vn4CYnVDUV4sdYt0
         IXvhZKG+L0EiTtn1oAfU4g4YqaSxwQRHQk3fxEoAx5X69v07SrmKRtkXIpb2h0OE7Wq3
         S1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3kWxqXuQEnL5DwEXyW1diyp55Y75IrB9TmE8vDDQPI=;
        b=q6i6M7xocXivvRYEpLgGEZ32rosdsND0DcegUI42JE5U+vtBERqBz2IVmH9we1NjGQ
         qbXRLy1/3NXAPID5MtKUtj7RucCss2hHBCf3F5vE748r3Elm5tHTFen1EUEit3MuwzsV
         0A42ZPJT5yZ9FvrWEWCTlTsREwO/NZLoJA9/jM2icWErCVW8iJhbyii+zdgUljhgyM9T
         dD7+xf0aZnjAS7XgylMYSllrhBWHUpZg77/2NFo42q7lp3zjdosRtavHRWGbB9HgvYlm
         DyXLdms1iYMotcvZ91M/JvJIhtfZH9lD92XdCv/30LMXkeM7raKHyX6atptfGJvgAHaD
         l4bw==
X-Gm-Message-State: AOAM530Hw/lm5+78ginj0q15u1YXe8J9vGSNHHv80JaOuAy/u5U5ZQ7m
        b5cD/obxu+U/Pi6g9/p95Bk=
X-Google-Smtp-Source: ABdhPJwWL6Pc3XcA4SLfv6dgWbVgS6bfmcVMz5d9A4wn2g/oh1i3O2pezMq+T6EWvhOB2cR3RsDiuw==
X-Received: by 2002:adf:de09:: with SMTP id b9mr23880827wrm.340.1621110170114;
        Sat, 15 May 2021 13:22:50 -0700 (PDT)
Received: from localhost.localdomain ([197.240.82.148])
        by smtp.gmail.com with ESMTPSA id r5sm9910503wmh.23.2021.05.15.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:22:49 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     peterz@infradead.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH-next] x86/kernel: Fix unchecked return value
Date:   Sat, 15 May 2021 21:22:12 +0100
Message-Id: <20210515202212.24836-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the coverity scan analysis, the return value from
insn_decode_kernel is not checked. It is a macro constructed
from the insn_decode function which may fail and return
negative integer. Fix this by explicitly checking the
return value.

Addresses-Coverity: ("Unchecked return value")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 arch/x86/kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a762dc1c615e..bf0ea003b6e7 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -23,7 +23,7 @@ int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
 
-	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	WARN_ON(insn_decode_kernel(&insn, (void *)jump_entry_code(entry)));
 	BUG_ON(insn.length != 2 && insn.length != 5);
 
 	return insn.length;
-- 
2.17.1

