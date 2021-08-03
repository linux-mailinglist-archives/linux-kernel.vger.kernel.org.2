Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0103DEC18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhHCLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhHCLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AEC0613D5;
        Tue,  3 Aug 2021 04:36:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so1918371wmg.4;
        Tue, 03 Aug 2021 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jw/zAD+G0EYtvZdLF/eapWXWUaaUrlByZMO74Rk9hpg=;
        b=JTCpUSb0kHrUgVjhn79HPjGsWwGG3eB37sTnqU/bfdSUvxeGhuaehOq5KIyk4TG44s
         N98mEhTy3GmS8gjQYqxy04tCQktxiFpGEpG2KhM3FQ1NsAEKQPUx+OBwi20M7DiH9BWX
         Q4iFv2+AxPR64IrGkGL8I9OY+O1Dgmc0vycEVICrTzmf1XY1S55NsuRLv7WLX4LnWdPu
         /Salc/wFdxFzI4NXz3gv/U41HGP3bDt+g1QGKsKy3dN1w//NnWGOHit6usKsMC9vXvDg
         tJs0fXppcVj0ALpK3lYyym5T1ACqp5dTbvICXnHvWiMdhjtdFpXXzyGf39ebRDmIZ2vI
         Z3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jw/zAD+G0EYtvZdLF/eapWXWUaaUrlByZMO74Rk9hpg=;
        b=mZ0gC3DfVsoT1SxQ6Xm3QAS/b6HpfYsBSkbVudhoUWnYA+BH210WtTPrRscF3Czmx2
         4aUgmQyXH/8Fhxm9R4EJVs0RucD+fYe4bIC6ZMSkd8Vx6ia7KaEbj4eXm4pThx3vgkFW
         f5tW2WszHaSdeP5m8fC9f8Rpo8XNI+xaX5ZAQMypDC4Jqo8dSCGxJiyKbSFUedDuR2rG
         M6U0CHMmxuQr0C8+0eZ7GNXpMvf/rxG8l+0kRpD0woGvY4RrzsA9FB5bubBRO1OanliM
         o3UYc/J1xVHYzT0o3sHWn+mEow66k7sYkP5dD2BQ6gVXhrNS8AXOxFTJVuAO5M/Uczzr
         g30Q==
X-Gm-Message-State: AOAM532wZ+yhkdVrBCeKol5PphN/q4pOMruhfWOXTrGE20WrLCs8l/gt
        7DMVMbvEHEnzPHjbMFWF7jA=
X-Google-Smtp-Source: ABdhPJzHifKXpUDNbKkNw1u72KhO2AHpnuPT8vhR5rWIA/h5bRy0P5WPjG9lxMu6fJuxLIbg6cBcHw==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr3858978wmg.130.1627990583850;
        Tue, 03 Aug 2021 04:36:23 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 6/9] x86/irq: fix slightly wrong reference in comment
Date:   Tue,  3 Aug 2021 13:35:28 +0200
Message-Id: <20210803113531.30720-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0cfc74d0b00 ("x86/irq: Provide macro for inlining irq stack
switching") refers to CONFIG_UNWIND_FRAME_POINTER, but the config is
called CONFIG_UNWINDER_FRAME_POINTER.

Hence, ./scripts/checkkconfigsymbols.py warns:

UNWIND_FRAME_POINTER
Referencing files: arch/x86/include/asm/irq_stack.h

Adjust the name in the comment.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/include/asm/irq_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c60808..8912492a78f1 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -58,7 +58,7 @@
  *     the output constraints to make the compiler aware that R11 cannot be
  *     reused after the asm() statement.
  *
- *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     For builds with CONFIG_UNWINDER_FRAME_POINTER, ASM_CALL_CONSTRAINT is
  *     required as well as this prevents certain creative GCC variants from
  *     misplacing the ASM code.
  *
-- 
2.17.1

