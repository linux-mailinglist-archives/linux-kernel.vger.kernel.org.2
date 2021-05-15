Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA538169D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhEOHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhEOHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:45:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A587C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:44:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c20so1883910ejm.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c/r02AiLOntXfR02hRmnU6wWAYw2AsB62bF0ltpqKBI=;
        b=tcF6q89VTGI9gMK7aJ6L24yRjCE12mM8jHT7pTsRnJK4Q8L6fl3B6zmfeB/xvYXnnH
         XPVLudFLQIggOR3k6C7iIaIJXaPcNe1Dp0eMVlWS8xnbo7m0TMqu2KVuOpYFV72lQPxr
         Cexi/lxaXnTwbVUJccs6NXuW3htuGKCHYZLI3BNa+phJtaivpg5cFXj9QY8rdOCxXKCL
         wstUuniROm0zYQNn7jR18JKgU5Fhtfs+HUp8CanHKNNuh1mqVOvG2xtYRuoTUX6jRemD
         IWHDphzZ+LGfOkA8vh5smDn0evgJon8phSX0fZlIupq65izu5ueQjKicGLp5F1ozq34V
         7Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=c/r02AiLOntXfR02hRmnU6wWAYw2AsB62bF0ltpqKBI=;
        b=URDZ/Rb+DJYV20RNYyF0j3EsUU/hHppJp1eKZl55P9L5V4qDISSSRGjriYRYhjav2i
         oepvLgLptPtbmRYr4/dPSQK8eKp9/bqHegIlkp759u+BCTuBhYrrOquw9Eni1+c3YLUm
         zRKZ7w3sadTOWaerRkuEPnbWvc9vvj0nRPzKoN0hT6LB645cbm5o703OUmjVqGTuuidO
         VvWrG8GtqqUaBhXZu4AAb/MVVZGE/TnjQXHvLVEwZYHLClQ/hqZlJ0IIg30CEVP4pf1n
         Vyu0YNkDXw09ukMCfWLNZLWOkkPJGwrQwWZmXWyTyJgfTjwH3N/tnyp2T085a1PCoZuq
         4kdg==
X-Gm-Message-State: AOAM533F8cZCtDbGxIeRe8jMTJu2GvJMTYKPhzQkTmWpZ/9B2Ow3jWaw
        +SojqjWTcnyrX121NBqOT9M=
X-Google-Smtp-Source: ABdhPJxIVU1LZjmR2F2wgztBF8oSPY/YOFmKr4ErKisBbcsBwPJjQFPxRG7M0XitE0jk+6+00Tz0Nw==
X-Received: by 2002:a17:906:828b:: with SMTP id h11mr52329484ejx.305.1621064656019;
        Sat, 15 May 2021 00:44:16 -0700 (PDT)
Received: from gmail.com (178-164-188-54.pool.digikabel.hu. [178.164.188.54])
        by smtp.gmail.com with ESMTPSA id n17sm6059862eds.72.2021.05.15.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:44:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 15 May 2021 09:44:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] IRQ fix
Message-ID: <20210515074413.GA81426@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-15

   # HEAD: 0d3ae948741ac6d80e39ab27b45297367ee477de sh: Remove unused variable

Fix build warning on SH.

 Thanks,

	Ingo

------------------>
Eric Dumazet (1):
      sh: Remove unused variable


 arch/sh/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index f5beecdac693..e76b22157099 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
 
 BUILD_TRAP_HANDLER(nmi)
 {
-	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
 	arch_ftrace_nmi_enter();
