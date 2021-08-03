Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4A3DEBFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhHCLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhHCLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442CC061757;
        Tue,  3 Aug 2021 04:35:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so1516118wms.2;
        Tue, 03 Aug 2021 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pe0Wggvjr6zccAFSTENi43f7OQ0HCRColzuTqpwhdwY=;
        b=oz+My935puC+gde2oAps6x7qpz4A4SjiMiezO4eFNfHPC4zze6xU8zMqqQrT06HDXd
         hSfdqvQkptKEEshuRjx5Yu/EltwmyH5UkbsmmH6bl3GS4mOQfNHBhYjsGa7UhCAk1HWB
         B0EZWjbIhZfwwqZG0EDlBbHLjn7cTn3+1yECBJTrel0BqsQt2J9kvOk5zzE0Nwf/rmpb
         IxRB1QgX46cD42uLmCIB+J5PKeJ8oLRCs+o39yRtGVuCxq+yIi4c0h8H150f0Wy7j/Qw
         SfyKosH0dXHKAlU20xoDYwneUsZsizu2KpDVEvQItsbEv48W4cod+qNbmycTMvGRhiYb
         GdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pe0Wggvjr6zccAFSTENi43f7OQ0HCRColzuTqpwhdwY=;
        b=dTbb7e8SC0NkbfGVQUwRn7ecHzYwMsR9GXyhqvpummezB9gqYLFZMV5DNJFQ5CFVOQ
         tBk5E34jvr7qUhj87BCrQ2ua68+iKKUhBGWCFC5zAl3EgTxePfspTtCxdsXOVxQudnUk
         1baboh8mqmrdKceGLHK6yhbWEHxi3U7WneREMuAZ/Z5jmCF2Fud0aQLJhdhzojCml4lY
         Es1OCuqioOx/+4cbY6Ekoss32O+WgfO9kNdOl43hiNMQW1cj6+dRE/9HXPe2CM8r2JFk
         0T0dLDXhiYWJVqYv5JwM65pPjBHCxfoHR/kiUSUznufysTpq/usR33zxyMsN0NzUvfmr
         aX+Q==
X-Gm-Message-State: AOAM5329vnjoUFUh5JlLzE9QdINE3gTTB/B5mgDY7EduU0MzoAidUELP
        SKdLPgqlMcpLXCT/CWun9Usf2bjE/2BAZQ==
X-Google-Smtp-Source: ABdhPJyBO0jfPSs/3X9jglPANMtDSkOY/81XlxXON0j0Wu8nHEKEddqh2vU+eWk6KsaB/HCicUMxRg==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr3712844wmg.35.1627990557552;
        Tue, 03 Aug 2021 04:35:57 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:35:53 -0700 (PDT)
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
Subject: [PATCH 0/9] Kconfig symbol clean-up on ./arch/x86/
Date:   Tue,  3 Aug 2021 13:35:22 +0200
Message-Id: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear x86 maintainers,


Randy Dunlap pointed out that ./scripts/checkkconfigsymbols.py warns on
invalid references to Kconfig symbols (often, minor typos, name confusions
or outdated references): see Link below.

This is a first patch series addressing the issues reported by
./scripts/checkkconfigsymbols.py in the ./arch/x86/ directories, quickly
filtered down with:

  ./scripts/checkkconfigsymbols.py | grep "arch/x86" -B 1 -A 2

It addresses some issues I considered to be "true positives";
so, issues that should be addressed and cleaned up.

The patches on updating the comments might arguably be considered of low
value by itself, but as the other patches show, checkkconfigsymbols does
detect some relevant issues in the kernel tree otherwise being unnoticed.
So, it might be worth to clean up the kernel tree to have checkkconfigsymbols
produce a rather short list of issues and then continuously follow and check
what checkkconfigsymbols reports.

Some work from checkkconfigsymbols on arch/x86 is deferred:

  - OSNOISE_TRAECR typo in arch/x86/kernel/trace.c
    This will added to a separate janitor cleanup series with other topics
    on this file.

  - a reference to STRICT_IOMEM in arch/x86/mm/init.c
    unclear to me: which exact config this refers to

  - Given some updates of the minimal version for binutils (now >= 2.23),
    the whole special detection of binutils support for CONFIG_X86_X32 and
    its speciality with CONFIG_X86_X32_ABI might be unneeded. I might look
    into that in a separate task.

The remaining issues that checkkconfigsymbols reports are (as far as I
understand it now) "false positives" (the tool misinterprets the actual
content) or "intentional", e.g., they refer to historic configs for the
purpose of documentation (e.g., in changelogs) or are in various kernel
configs that are not continuously updated to match the current set of
kernel configs.

Please pick this series of minor clean-up patches on ./arch/x86/.

It applies cleanly on next-20210802.

Link: https://lore.kernel.org/linux-kernel-mentees/295b8f8c-4264-9f32-6723-9d2d574021ac@infradead.org/


Best regards,

Lukas


Lukas Bulwahn (9):
  x86/entry: correct reference to intended CONFIG_64_BIT
  x86, olpc: correct condition to intended CONFIG_OLPC_XO15_SCI
  x86/Kconfig: correct reference to MWINCHIP3D
  x86/Kconfig: remove reference to obsolete MFD_INTEL_MSIC config
  x86/Kconfig: remove reference to obsolete APB_TIMER config
  x86/irq: fix slightly wrong reference in comment
  x86/uaccess: adjust comment for endif of CONFIG_CC_HAS_ASM_GOTO_OUTPUT
  x86: page_32.h: adjust comment for endif of CONFIG_X86_USE_3DNOW
  x86: ia32.h: adjust comment for endif of CONFIG_IA32_EMULATION

 arch/x86/Kconfig                    | 4 +---
 arch/x86/include/asm/entry-common.h | 2 +-
 arch/x86/include/asm/ia32.h         | 2 +-
 arch/x86/include/asm/irq_stack.h    | 2 +-
 arch/x86/include/asm/page_32.h      | 2 +-
 arch/x86/include/asm/uaccess.h      | 2 +-
 arch/x86/platform/olpc/olpc.c       | 2 +-
 7 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.17.1

