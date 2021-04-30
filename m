Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1C370248
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhD3UjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhD3UjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:39:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD883C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x5so21676499wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gtHRujbA++rmZKVlVKXeDrh5bnEaeS8o439txwjvSA=;
        b=qrc9+H+zO876EkLivwIh9Kjb21xwQnQtJBzxM3rkdwjm4Tx/1PWcOzQJ31sktAcNc+
         MS2EYrIX7e4Ha5MfqiquAQCZiF89vo4q1ATmaBX4I03ihWSEYKYZ+9/8ry7nO8WEQ3u9
         P4Nxj/HAF9l5SeDf9pVrHab0IckshPm7R+gfqxPNpk3hrOD4ViAt9JyKDFK7XvJ1yEPf
         bWA0pBQTrNJxxeA0ycbVEOVMt8IHEtmHTGdQE35HPvhtUnmZSV2U7vfjdQZYnaR//ldt
         EmzBA6zSaqGrQg/UBR0GCohMlPFdMDG2a/Y4JC1TUMT6hyBUXGnVW3FH1btv0f16Arm9
         WMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gtHRujbA++rmZKVlVKXeDrh5bnEaeS8o439txwjvSA=;
        b=D66jq17yB2LECvKSgYN1gZdNcrh7C+px/FszExI+hAs7dbFbAVa5p+ZQwCFW7Yggym
         IABiL0wiSYq33gGto5ACGN/Vl8Xoar1aPnXjCD7JLyT3hNOEoLZK7h+uj7qPUekMJM8R
         36cJQT5cZ7btuW4jBGWdHljOF9ndwgO64GUfoVklyurl0rbiH+RlGPYJOq4kqnMuY7qr
         oqTuI3WAfWQ8dGAHj62/GU3TGcqcyOUKNhE6V6fpB3ylRHpoZY4kgcfrVMuAtJCgcpQr
         UBbfPqGmTOZuTvoXALxID1NXRVi1d2BYdUVvdn14KGiGDvOpns70MRb+fW/DxYPyndfC
         TGgw==
X-Gm-Message-State: AOAM531Dr2YKz4hCe9N3X9Emxjrg8jV2nTbDRSmNY0kVEOD81Rvs0Wbo
        KQrt+2JO2eG7eP+mBp2c8us=
X-Google-Smtp-Source: ABdhPJyQ4TvSmcF9Tde8UDMJFkkUIiijwF8XDq5CyinKCWjBHcnk2B6L/sJrUzcul6NzYJNXMUCFGg==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr9357812wri.211.1619815096507;
        Fri, 30 Apr 2021 13:38:16 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:16 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] arm64: Forbid calling compat sigreturn from 64-bit tasks
Date:   Fri, 30 Apr 2021 21:37:56 +0100
Message-Id: <20210430203757.47653-6-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's impossible for this syscall to do anything sensible in this
context.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/kernel/signal32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..e2bdd1eaefd8 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -237,6 +237,10 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
+	/* Reject attempts to call this from a 64-bit process. */
+	if (!is_compat_task())
+		goto badframe;
+
 	/*
 	 * Since we stacked the signal on a 64-bit boundary,
 	 * then 'sp' should be word aligned here.  If it's
@@ -268,6 +272,10 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
+	/* Reject attempts to call this from a 64-bit process. */
+	if (!is_compat_task())
+		goto badframe;
+
 	/*
 	 * Since we stacked the signal on a 64-bit boundary,
 	 * then 'sp' should be word aligned here.  If it's
-- 
2.31.1

