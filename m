Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5205E40309E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbhIGWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:01:51 -0400
Received: from home.keithp.com ([63.227.221.253]:56010 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344772AbhIGWBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 0A85D3F30866;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BrT72QuO-XSn; Tue,  7 Sep 2021 15:00:18 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id B2A033F30862;
        Tue,  7 Sep 2021 15:00:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id D53551E60132; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
From:   Keith Packard <keithpac@amazon.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 3/7] ARM: Use smp_processor_id() in vfp_pm_suspend instead of ti->cpu
Date:   Tue,  7 Sep 2021 15:00:34 -0700
Message-Id: <20210907220038.91021-4-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are equivalent when thread_info contains the CPU value, but when
THREAD_INFO_IN_TASK is enabled, cpu moves to task_struct. Using the macro
allows either.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/vfp/vfpmodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..d7a3818da671 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -458,16 +458,16 @@ static int vfp_pm_suspend(void)
 
 		/* disable, just in case */
 		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	} else if (vfp_current_hw_state[ti->cpu]) {
+	} else if (vfp_current_hw_state[smp_processor_id()]) {
 #ifndef CONFIG_SMP
 		fmxr(FPEXC, fpexc | FPEXC_EN);
-		vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
+		vfp_save_state(vfp_current_hw_state[smp_processor_id()], fpexc);
 		fmxr(FPEXC, fpexc);
 #endif
 	}
 
 	/* clear any information we had about last context state */
-	vfp_current_hw_state[ti->cpu] = NULL;
+	vfp_current_hw_state[smp_processor_id()] = NULL;
 
 	return 0;
 }
-- 
2.33.0

