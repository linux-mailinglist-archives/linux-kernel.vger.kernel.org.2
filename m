Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B73931424F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhBHVxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhBHVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:49:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03433C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:49:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y9so27831850ejp.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWYcI2k6BmggzR5FLvxq8R3B+Jr0PxsVDYjZmlhSenw=;
        b=CcRtoULZ4bVTbDP3su/8RJgn4CwaKtr/IKD5c2GLPd2dKiJtKSALvPJA4pd52Vkq7J
         +St/Y+puC7jqHjcfQ0kcse3HEVLiyVGBzKwkI6UOQOOqnBSZQF0Dt+XexTZBFVTVp31t
         FqsVYTlCA5aZ46thVuiAJkYX3ohQE7cMSrmvP0TD6hL3UVuPhz666tcQsee7pejtWYLJ
         cc0KNB0T1auRWeKhTN/tLnof0auNdJg164EnStHgG8KCWAVIo5C7s/u5iLqbhhOGhOXh
         ln7KxSN2vEAykkX0Ytngl4dZpiPNBqn7APbyqeHvrZJKlfMJtrcyRTvlv7+mryxAaGov
         JmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWYcI2k6BmggzR5FLvxq8R3B+Jr0PxsVDYjZmlhSenw=;
        b=q1qYM6l6uLaz3t6aiivzYPYfE1SBEVeHyt7Uu3Efb22GdLuo5PaWL2k22laWQwFYAZ
         qSIM1Nwa0vn1yCgL1lwD9MFSz3SfUjlw6UcHUjGfc5rubfgetp5gXPwD6/FIjujUXlQ7
         LwzWjC9/98CSxVNYgK4hZYfDmXvraIh47UEYKtpPeRdzaOruyTfLYX61aoTtTeU0thyl
         Z1w1ZIqhL9pzSYCw7/A+j5AIAxtd/zVTh7na/tmWY9zfR8KAoQqehtVUZQNrZETUiROb
         jTkgv63dVhrg7SfYcSFe50fN5tmZxZHWKCwp8LPwSdS26HOunGbHcayE6v9Ed7LUjMed
         GP4A==
X-Gm-Message-State: AOAM532tQgXhklqoTqmBFermBIeye3dKA1AKf1wqRj1QioeHaBQfAJHo
        693wsNgdVeYoUomCUT+Le4E=
X-Google-Smtp-Source: ABdhPJwrPvuDGpHkL2nE2LTGEpDoBodGcnYi3a/jwazE2dJnDQCt2dnPIsWUkm+cu5YcHp8ZbKDpZw==
X-Received: by 2002:a17:906:b284:: with SMTP id q4mr18688313ejz.507.1612820942722;
        Mon, 08 Feb 2021 13:49:02 -0800 (PST)
Received: from localhost.localdomain (ip-109-40-67-210.web.vodafone.de. [109.40.67.210])
        by smtp.gmail.com with ESMTPSA id q14sm10259447edw.52.2021.02.08.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:49:02 -0800 (PST)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Kyle Huey <me@kylehuey.com>
Subject: [PATCH v2] x86: entry: Remove _TIF_SINGLESTEP define leftover
Date:   Mon,  8 Feb 2021 22:48:48 +0100
Message-Id: <20210208214851.65597-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6342adcaa683 ("entry: Ensure trap after single-step on
system call return") a _TIF_SINGLESTEP define is obsolete for arch/x86.

So, remove the leftover in arch/x86/include/asm/thread_info.h file.

Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return")
CC: Kyle Huey <me@kylehuey.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Changes v1->v2:
- Add closing parenthesis to Fixes tag

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

