Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C399441D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhKAPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:07:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AAC061714;
        Mon,  1 Nov 2021 08:05:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gt5so4036292pjb.1;
        Mon, 01 Nov 2021 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JvI1APfJ2Z4YO1WwA6tzvkiNOy9PkeWYVBi4ViBASk=;
        b=oHNFfNSHgrgr76VMdo3rwU2/yhbyDUkn2ljNaENac/0Xn6Yx8jDCKQ0eP/niTZs0Wz
         s3T2Q+sX4knJ2mcPr1xGjURlq7eP2VcwaQ5EdeaLZ5yoGYuuY2pOlnd8HmhuE2tnlzXE
         8nSD1sZp7oTqUn0L5aDPG1Xg+EaiH4/yQ+H9iNcu79/vTarrdu1KeG5UYHNCmTdUOXIh
         m07EllhUruAW33ZUTloTTeqciTw4FAUGVMLvp1KOi1n1HNMDAateEWTJAKUGkIeWIaEP
         s0gw4e2oOCw8tc3Bb8Jis2B966bVyEMxBluvx6T3I3sl4aiZwne/JMLdr0eN1dWU1tUc
         K8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JvI1APfJ2Z4YO1WwA6tzvkiNOy9PkeWYVBi4ViBASk=;
        b=s99Ck0ufjP9UEVOsKl7UtsJKGR8AiAsb4xApvWHHc8z3wpEVz5sg3MMH0ZO6qxlaLW
         SfGl582KXgb9mC7Zyj+KUQM8Qyf6i9+U9ZeTrJs5oNID6iG9DIzW6emP3hDBawwbW+kR
         rBhVMjhR3rs1J+DVqf60hClOkdMtVMJV9KfSHAUQx+V9voJYnISfION7mX7Ox4uvp+0m
         j1tpgWaJeOESJvQoz2DsTvHkYHbNCVx9C5YwYFFGgTBpEBY0WwF5CBGNAjdy6NUq/W3v
         hL4xisisqn4/OPye7QGE5tMzLsaNWi3RewzW4xm+6Efu2o6ocXoy4VepRwZkPLNSeXQ7
         viWw==
X-Gm-Message-State: AOAM531B3fjXbqWKWZHusQ9iWo3VZ6uhFQ4kBwoXVM5RooFVP0hiIVNo
        UpLAtlbxoz1YeKQuuBZBuxqNjGqBxSk=
X-Google-Smtp-Source: ABdhPJw3ke8rzLYkmaUBtBdN6z/bUY4XAgZAovOT2+dm/gRwMmGOgyGgn8yBY2hlvYw7ufZQO/MEpw==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr10443684plh.15.1635779106040;
        Mon, 01 Nov 2021 08:05:06 -0700 (PDT)
Received: from localhost ([14.116.71.218])
        by smtp.gmail.com with ESMTPSA id p6sm4257941pfo.96.2021.11.01.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:05:05 -0700 (PDT)
From:   Kelly Devilliv <kelly.devilliv@gmail.com>
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Devilliv <kelly.devilliv@gmail.com>
Subject: [PATCH] csky: fix typo of fpu config macro
Date:   Mon,  1 Nov 2021 23:05:02 +0800
Message-Id: <20211101150502.222969-1-kelly.devilliv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo which will cause fpe and privilege exception error.

Signed-off-by: Kelly Devilliv <kelly.devilliv@gmail.com>
---
 arch/csky/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index e5fbf8653a21..2020af88b636 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -209,7 +209,7 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
 
 asmlinkage void do_trap_fpe(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
 	return fpu_fpe(regs);
 #else
 	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
@@ -219,7 +219,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
 
 asmlinkage void do_trap_priv(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
 	if (user_mode(regs) && fpu_libc_helper(regs))
 		return;
 #endif
-- 
2.25.1

