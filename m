Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027E381697
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhEOHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEOHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:36:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CCC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:35:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so1028893edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=geXezWqksF0Uu4Gfw0bG+etU54O5YchybuMDVSDksHI=;
        b=kwQ/SVjmnqRJ3+EoQRvgUyjg+vjn/YSB99zKLdNaqZ/qD4hIPvedd89Q2WPsz3fevh
         dHPRgffNKbT7tNRAsUSE0vleInzZX8SfuKzTtBhmbO0gi0JNup6m8jMD4CYdLf0OnJKj
         bsL2lD/WZVcITtOzM2Trgr9OQqm0/i/b/yrJF6chBInidCzh5JJUXZpy9jytPTcA+Afu
         z2k7WOa3TEZrkrIb+cWnNdSLyg61pXNjkMeJ1nGU7/4MfQtps+wemlTzUHwWBVSrI3Nw
         tscYvrteV9VGm5oiIrC0aLhjxjZRlPwhSfRsUDlNuJWe2fN62yxwR+MrguiqjZAkerzj
         AEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=geXezWqksF0Uu4Gfw0bG+etU54O5YchybuMDVSDksHI=;
        b=Wa/dfcGGbs8gPhukaT86/7PbDZ7q60g6oOk/2ce6QKNBfVRfcuiIzD6xMBS1wkpFis
         K5CXOXOQGW/WrszSCZlLwFaWHz0FaskKOw9OgtrA8+A4BgYzNrhDx7udPCpcoXeJbcMk
         JVOxsFTMGfhQOGlK2rx58olDPl+q28m/yt0zPeoBEjBBinzellKQTmaDl79k4qAMsIQk
         LZyhpHDEYuykFWT6U7nAHUQ0XRt5Pa1G4zOAisTRaqnWo6/77Joz/2aoswEKlnMgbiMS
         rNbOb6AOwUzsbVW2mSNP6dA8ZFuRK2S8IFv1Y5nXcLvn2EvABwcVrS3gHRsycZn9n8+6
         vtYg==
X-Gm-Message-State: AOAM530nxvgBeqZVoRHbXyP6rdPCVAFoaE4ZBIVSZrqddkeaQchdurV3
        nGqnwwgPwLU9dZX9o99w+/A=
X-Google-Smtp-Source: ABdhPJyUNoTSLHgY2ceugNpIEu4LrHVuiP3FweB1+1DVow+SjZ46+GstglM7/5Cvn9XEksrksH1iLg==
X-Received: by 2002:a05:6402:944:: with SMTP id h4mr10219520edz.319.1621064098998;
        Sat, 15 May 2021 00:34:58 -0700 (PDT)
Received: from gmail.com (178-164-188-54.pool.digikabel.hu. [178.164.188.54])
        by smtp.gmail.com with ESMTPSA id i8sm6239983edu.64.2021.05.15.00.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:34:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 15 May 2021 09:34:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Stack randomization fix
Message-ID: <20210515073453.GA78379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-05-15

   # HEAD: 2515dd6ce8e545b0b2eece84920048ef9ed846c4 stack: Replace "o" output with "r" input constraint

Fix an assembly constraint that affected LLVM up to version 12.

 Thanks,

	Ingo

------------------>
Nick Desaulniers (1):
      stack: Replace "o" output with "r" input constraint


 include/linux/randomize_kstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index fd80fab663a9..bebc911161b6 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
 		u32 offset = raw_cpu_read(kstack_offset);		\
 		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
-		asm volatile("" : "=o"(*ptr) :: "memory");		\
+		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
 
