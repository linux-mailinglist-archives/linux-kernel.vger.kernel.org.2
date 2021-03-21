Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092713434A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCUUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCUUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:23:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:23:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z10so8599780qkz.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Azz1+KJ6iHDbiNubJr6vQN+jRfGqnnMUzOkJsouhv8o=;
        b=WeYSmgqRYCnhtymjx9z7xY4sIn06c04FFKcSAH7Jd5nzgv0wOHsNKpOjSR5zwHa/3Y
         8jSDOyuOjjuS8AXwhdXmR8X2ICWmazbhhMZu5sO+HRi9sMEcL+1QtC13vUMOzZsNafZZ
         YNkOSCPwufk70/ykzvMMiPfzJJXwddKChAnw3Vp5jxNC+WaB4XPUiFb05yyV/DveIXth
         PwU4qRhLPx6Z4EYqoYmZBgEolUXIGGZ3ltQaVdbN9H5ub1O7NDOV2kdRebBNRpwxHZAY
         9zAkEU+XUxoPkLx5GlMiI+GyIgURpSzGY/vKiC1dVHwn42iJhwgVMnjm0SIuGrKwG74A
         Ibcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Azz1+KJ6iHDbiNubJr6vQN+jRfGqnnMUzOkJsouhv8o=;
        b=kKFN+FLdf9AGzuAxExC4APm/Nj5F1A8YsDbgoDGo/PnzHjyMNvQIA30XT93M2RKQ5o
         WjIj9UpEzS5O5aUuN4J+i7xH2L8Gr5LcU7ZQ9g+ihBvw9MeIhyYkeqh1+LaRJrwYIoG5
         m+//rUWca1DFDbutSkQJALHofX51ln6qzFasupDbVqSl0tIyKVu65/Km/DxOs3moTRob
         PuvZE8y317eEgxYRZAD7b2RD+cxd9uCh2Ao6Pl864aotQwYuB1WH//dmyGFMxtsyy3+X
         m+44jT3ZRl1/xmGkJOqBTAFs9AP8LcwiXwKd/qsswF7ZzVphRbPInFl6UZGQldYOepBL
         4NpA==
X-Gm-Message-State: AOAM530VJp/BeS8eYZ2+bqoc04p8Yarvy27MYGBNKM7oQlLAfxzLEZWl
        xcMHeR4eSk6+Ce5QyevV0Z04qINPJXvB84Nk
X-Google-Smtp-Source: ABdhPJy/3Y8iiMEjf5tL/n3rnZlWClvxcf/1h/GcUq6Q59HCcpr8bjq49okrREbedjeefssU8/F5HA==
X-Received: by 2002:a37:5f04:: with SMTP id t4mr7886110qkb.440.1616358185450;
        Sun, 21 Mar 2021 13:23:05 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.163])
        by smtp.gmail.com with ESMTPSA id z188sm9279566qkb.40.2021.03.21.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 13:23:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] x86/entry: A typo fix
Date:   Mon, 22 Mar 2021 01:52:53 +0530
Message-Id: <20210321202253.1393665-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/definitly/definitely/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 400908dff42e..0a7e9647e84a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -511,7 +511,7 @@ SYM_CODE_START(\asmsym)
 	/*
 	 * No need to switch back to the IST stack. The current stack is either
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
-	 * so it is definitly mapped even with PTI enabled.
+	 * so it is definitely mapped even with PTI enabled.
 	 */
 	jmp	paranoid_exit

--
2.31.0

