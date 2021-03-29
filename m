Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42734C2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC2FQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC2FQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:14 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D7C061574;
        Sun, 28 Mar 2021 22:16:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cx5so5888034qvb.10;
        Sun, 28 Mar 2021 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fVbBgdpLcupl8+ZJiLOeuzM2KAPiNa9jeyTEN/kans=;
        b=SIvFzgJRZwr7aS0efed93fOjaVgd1mLbHSDxeJKah6nneRPzdCQIrb8bb+9kENi/Vy
         VJyEnMVVFAe25sfvKzt0C4zTKpj9JhEwTNH7sd4zoLzghmJv8pXIzX9+lNy5IqbNFfzA
         Gtl8iw0F2cQ51rpOq6KFymghvD4a//DEVH4qaJ1LlQwQ+JvXydLPZ4QAInP3T4MwnQZA
         lJ+bMMiNSVT3Bp+k3+R/J2/Zb4gGdMAphCZSfUbylP4h13kj+P699QlTYCYboB85vWb2
         En/+41QjNRHRfcsbexkAZ8Qj7QyNS7ve5u3qGfnRaoUd/INszlqO5L16xTb2plkOpsLb
         F+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fVbBgdpLcupl8+ZJiLOeuzM2KAPiNa9jeyTEN/kans=;
        b=en4o0a35X9qaMfrPXXytg3rYAAVFTY17/MQ+kOa+wvoQvUcBpbbivFc5p8NbtT69DC
         mGsNF/xamdUenFqfejlQydluR3QLWhLJcsKuf1eumW3mvEedzE1gHgwlMatGjhw4FcLI
         fZA8qZTLKyT19rAnW2WOV/jPvIXlNDMN8GXXvV/xVQXb69tiLaz8o+s9v66esNUJjEGH
         CpwGmz5RI89oPCneWq89iB3hgAfhc2dQW4/XXfSNZ959whXYMgQ/w9nbBh3m9ePFSfs8
         OnBgPBkbP+EIO6zkJfKV4nS+rUUJMR5UOsQsrtsLMbP5b3Lu9VibUyshTSehO6PCnKGc
         Ii2w==
X-Gm-Message-State: AOAM531Iso2Iognh8Aqex9dTW3WNcFUlxwKZp+YXEWG2pGBNEahmCztS
        QswAmAdhDfr5phz9Wm7b91s=
X-Google-Smtp-Source: ABdhPJwX8x/q3PHM1CC7nEEPP7z4t9SZd41IP4lxa384CKlOI2mEhcI3MPN46weexC9nHtguf3chiw==
X-Received: by 2002:a05:6214:f0d:: with SMTP id gw13mr20659469qvb.33.1616994973331;
        Sun, 28 Mar 2021 22:16:13 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] trace: ftrace-uses.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:50 +0530
Message-Id: <c1062acc1b90bb51b3fe7304408e44e1f9fa1a82.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/preemptable/preemptible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/trace/ftrace-uses.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index f7d98ae5b885..2903a58f5ac2 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
 	Not, if this flag is set, then the callback will always be called
 	with preemption disabled. If it is not set, then it is possible
 	(but not guaranteed) that the callback will be called in
-	preemptable context.
+	preemptible context.

 FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
--
2.26.3

