Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1A38F2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhEXSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhEXSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:18:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0CC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o9so25786992ilh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gVDiJ/2KYFrVnMq6tzMdKvmt/STTtDT9yS9CSt4Dho=;
        b=W4H9AFg5djmSz9ZTVdShBCgT0YHhSwdedvDb4TZr7fjwTz2gbTv7PZQvmlgPz1uXdi
         1tafiwO/ntENHx5t/d6hKAEcGHhXJ5M1tbQUWfegSJpXPtNU11hnsulZ+25lBwD7wp2u
         we0TJ5JaHT1fDI0eYfp8xUqI6krHz1arOCUTy5WuNzPshTG24KRJdt0SddVjqg7f0sYu
         lXB5QBGub8ecdU0tS+y3fHjK8XMQeyCm4MI7la8KjeLCMY9IWJ9ju69vD43QCMlsPJ8g
         XQ5WNQcx3CPjUXi4UdfHbG1lFo0TBKxsaSPY9tH2SBdHWr14l8SQFEcGfE2ZUi6fpfFb
         aitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gVDiJ/2KYFrVnMq6tzMdKvmt/STTtDT9yS9CSt4Dho=;
        b=UV83HaXV8DeWRwp24zxUgQSy4pJyQ/vod259xAO/UjhFtojssgJssZsKQLsD6PwBkY
         uMzTWU2HVRUIv+vwfyTBXHKKZhsCZX7CIOsoPoTMZsq7CGGo6thNAIu9wet5DgH/6UWk
         af7hldFkRJhaRo+/AncghOfU6asFLR91wmsWo7u4iTx41kj2OKcKXnBDncAAPnZ4KFxQ
         JDm3Pc2UOkf3zXnEc35TXl0xEjXfT9W8EsbuSBRX891scpu1ynlPeRRvS7+svadelM43
         7SK2yl8vEipPkNLoItoc7j5WjfOqIlN/xkq7sjQAYhQ6tegcsgUTZc8DQUgsN6NRwk+q
         V87w==
X-Gm-Message-State: AOAM5314Zie2rM5O3WXbienrMMRVH2CoenaHv9vVRjkGeHxFjoA/blY6
        aiHmcVR/oh5OLhWFPwAeXbAI1qb/WA==
X-Google-Smtp-Source: ABdhPJz9CI4hz5CfQ96XzgXPL1R3ZMH/lH7O+PCHxnx98rbZDUkOahHu4cWV8RlBCdYCaLFIo3Mj9A==
X-Received: by 2002:a92:c884:: with SMTP id w4mr19528686ilo.117.1621880243815;
        Mon, 24 May 2021 11:17:23 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id p5sm11863673ilg.33.2021.05.24.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:17:23 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/3] x86/syscalls: Remove -Wno-override-init for syscall tables
Date:   Mon, 24 May 2021 14:17:06 -0400
Message-Id: <20210524181707.132844-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524181707.132844-1-brgerst@gmail.com>
References: <20210524181707.132844-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 44fe4895f47c ("Stop filling syscall arrays with *_sys_ni_syscall")
removes the need for -Wno-override-init, since the table is now filled
sequentially instead of overriding a default value.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95dbc911..94d2843ce80c 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -17,10 +17,6 @@ CFLAGS_syscall_64.o		+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
-CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
-
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
-- 
2.31.1

