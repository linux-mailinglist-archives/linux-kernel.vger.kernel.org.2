Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B868631424D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhBHVw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbhBHVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:44:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E7C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:43:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so27787911ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCHaqdrNh7KfGEZpdwLWF7BAVJkWkCxZ6kAA1vNAmPo=;
        b=epNwTiTtH3853z+FmzxmD7uQC7Us9C+Z+7Ls7gzU1Yu1rIXAjLTijEGum7wz99p13l
         xTi9EsbEiTc71irbPD6AsrWTh3yAyOHa6TBULasDDUH8JTQNtZ+KbBXU7+KudKBK+Oqn
         2xVCHRVHlXKE4Gwz8WvLk4JiZRwPC+CUZLAzHsYOBj9GvVKwDByP3rQPpnTPVLT7QnZ9
         FoRejZzfGHhq27YNE/8PR7DNS0BA2p91CYvRgCm5EKvbMUK0HGV9NJOt+/EkXWNuqR9u
         mhFmVpFK+TZc84xR0T3DU9XbIsz22TXj7zyRLS8Fkzyv7DiY0Xzp/TeoxzmiSbLNcwil
         oNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCHaqdrNh7KfGEZpdwLWF7BAVJkWkCxZ6kAA1vNAmPo=;
        b=r9U2Hy36rrFVtUGAJjUrapSqhZlzNt1BQi8W+8q8XpDtiyMGOXRTLVHouVpxgM1XjE
         ZhivUCGx52qANdmWsBsrkLVr2RI57sCabCJ2kR5hKTww/hMF+PfVoDY3QKTSZcf/RiMW
         ECQJ6nTltgqRxCvJBh386YJQXlHGt7dYD2a700Yp1WXf7rfXI0Lcu4AdEcLi7uZQO5z0
         ESbs8yt7pZyDeXYtOhHpGohLWG5QaXxLJPkKPnY8YgjNPMe5HfH3qv63Z8CsfsCdZpb+
         zP4o7F1FfDiJogoj9di94BjN0lJcL2Rg/vZX3ZZJj78V3kAexCHqzHVhfs3Tx7bgjEml
         2/Tg==
X-Gm-Message-State: AOAM530736AEy1qfGbu/GxUSwbEcD6vGHpU+SPB0LBf2bIb56CqYMijO
        DownKVZEz2l0BNL1MsTZ1is=
X-Google-Smtp-Source: ABdhPJwjA4DS9cQTxYM5Pjp2Os3XyeqROzTdB95k1PEhJgZImjfeSeCh6IEx6ITY3+6fOGC3QMr6Aw==
X-Received: by 2002:a17:907:7346:: with SMTP id dq6mr18518232ejc.230.1612820619327;
        Mon, 08 Feb 2021 13:43:39 -0800 (PST)
Received: from localhost.localdomain (ip-109-40-67-210.web.vodafone.de. [109.40.67.210])
        by smtp.gmail.com with ESMTPSA id x17sm10258244edd.76.2021.02.08.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:43:38 -0800 (PST)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     Kyle Huey <me@kylehuey.com>
Subject: [PATCH] x86: entry: Remove _TIF_SINGLESTEP define leftover
Date:   Mon,  8 Feb 2021 22:43:16 +0100
Message-Id: <20210208214327.65287-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6342adcaa683 ("entry: Ensure trap after single-step on
system call return") a _TIF_SINGLESTEP define is obsolete for arch/x86.

So, remove the leftover in arch/x86/include/asm/thread_info.h file.

Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return"
CC: Kyle Huey <me@kylehuey.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0d751d5da702..8861967e0305 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -101,7 +101,6 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
-- 
2.30.0

