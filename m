Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9635363781
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhDRUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhDRUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 16:18:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CBC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=P3jASfyCJaGy4At9UonobsYPxnlqYERhqVFY4wSxwP8=; b=kaadgowHizNRL4HX4j5Neo+MW8
        7c3QaXh6DfUM7ED+bXjFTCmxIhcp5O99ojc/GZKZ8voKc+9px4bKWvczTPLyVjBVcZPOBQJ3H1Sbp
        mqAqBu7uxSAVItL0NSLEiitU3bbY6iJy924aaQ8ax5XYo/pKJ68v8i3uJZRzckA9coIgLHCSPfhow
        k7oORh09H1r0Pk8EPkdvNt2fe8qPEuhHHPBS8iFpE/3oQZVtldnoGOF5faUrEdC3KOUnrJE8iGuw1
        exxW6E2SMng5aGc2Odi1/QiSVFDHp57M63GATwjLQVWCPYtAtyHd4AszpQNFQXXmBVJpnq5yy7GQR
        9zPPJJYQ==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYDrG-008WMz-99; Sun, 18 Apr 2021 20:17:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: add enable_kernel_fp() stub for ALTIVEC without PPC_FPU
Date:   Sun, 18 Apr 2021 13:17:25 -0700
Message-Id: <20210418201726.32130-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
there is a build error:

drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
           enable_kernel_fp();

so add a stub function for that when PPC_FPU is not set.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: lkp@intel.com
---
 arch/powerpc/include/asm/switch_to.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210416.orig/arch/powerpc/include/asm/switch_to.h
+++ linux-next-20210416/arch/powerpc/include/asm/switch_to.h
@@ -48,6 +48,7 @@ static inline void disable_kernel_fp(voi
 #else
 static inline void save_fpu(struct task_struct *t) { }
 static inline void flush_fp_to_thread(struct task_struct *t) { }
+static inline void enable_kernel_fp(void) { }
 #endif
 
 #ifdef CONFIG_ALTIVEC
