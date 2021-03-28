Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58C34BC11
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhC1KpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1Kor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:44:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B8C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 03:44:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so9913968wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zSdvYuufHuv8g8BJEfkgwXRBjUhdu0Zl6tnzVeqIHSA=;
        b=Uv9JkF5LPmL7R8WcvXQ2eBNTMpQGj5TS1cxvAPm9Qox+KYpOvUjwZ03vogfAVAZ/+n
         A6XQGYkIfgNCjSf9KBDdxhnZbC14JSRxMMwQnTXMHCv2eGy7yUXztgRUuf7byD3nSIo1
         IoAJRLjFRgQXg8fY5bWy53hnOFGaouCrKIq6gMANSra7BOypRrPhl/2TOSga5wzDoG71
         eTSDMEVFrFn0hVH/p2dsnlp5xHX1Epf4wWORZUBzq6y1TbVtN6/RigdpXULnpGjof4U7
         iZRMnpU0f2AF8xD0e3d5P+m7769wo0WLAw4FxjkJh/D5/ZAYjLbmOX49cwUIoHy77rMm
         NjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zSdvYuufHuv8g8BJEfkgwXRBjUhdu0Zl6tnzVeqIHSA=;
        b=JrEdJxWmbXE06RhVWOG+es6c/XJ3vMTnCqfXXO+TVahje3XRrFtKQ1bbwIRb6Vsd3y
         h0GT5ZI5xSnekmYicdbyukUa/8t0X+sGRLcIsfdqEYHcbumvM+uGp8ppGigG+OYHcZxg
         UL5gf47XO3w9vg9OEO+rGwto+PwjXoz7+RUQ2b0qORK859NQ0IiHLmUxoOPS1DuRjNpz
         s4xixVszCqoYMoTq8zLTJ/ZvxnJy8cd2ziyTJPUH7R+jQcTSaEgClNpauIKcFs6Ow9az
         u75NiB6vnQZgxSSNoD6Y3mvQFOCniLzAA10ynl5HP89oGebwML/1a7/ISsv7fb5aMxB9
         iz6w==
X-Gm-Message-State: AOAM532r0eeXy7g4zsgArDGckRiAqU6rT0zCURtI7r8e/3iJwpSXSsnp
        Iu2I1ZbaCbwJq+HzdpWO+3o=
X-Google-Smtp-Source: ABdhPJybetk0o9IDLj6rGjCpmJHyzcu8xTDzmbD3P5PBSa91maRD1pKuk4at2me1Gr6MZJtLZwCghw==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr23694207wrv.348.1616928285569;
        Sun, 28 Mar 2021 03:44:45 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id m15sm21768644wrp.96.2021.03.28.03.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 03:44:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 28 Mar 2021 12:44:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20210328104442.GA480587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-03-28

   # HEAD: 9fcb51c14da2953de585c5c6e50697b8a6e91a7b x86/build: Turn off -fcf-protection for realmode targets

Two fixes:

 - Fix build failure on Ubuntu with new GCC packages that turn on -fcf-protection

 - Fix SME memory encryption PTE encoding bug - AFAICT the code worked on
   4K page sizes (level 1) but had the wrong shift at higher page level orders
   (level 2 and higher).

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/build: Turn off -fcf-protection for realmode targets

Isaku Yamahata (1):
      x86/mem_encrypt: Correct physical address calculation in __set_clr_pte_enc()


 arch/x86/Makefile         | 2 +-
 arch/x86/mm/mem_encrypt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d6d5a28c3bf..9a85eae37b17 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,7 +27,7 @@ endif
 REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse
+		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
 
 REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4b01f7dbaf30..ae78cef79980 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -262,7 +262,7 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 	if (pgprot_val(old_prot) == pgprot_val(new_prot))
 		return;
 
-	pa = pfn << page_level_shift(level);
+	pa = pfn << PAGE_SHIFT;
 	size = page_level_size(level);
 
 	/*
