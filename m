Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83E3320E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:40:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15070 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhCIIjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:39:42 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvpY74qvgz9v0Yp;
        Tue,  9 Mar 2021 09:39:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6ZPySg4uw5U3; Tue,  9 Mar 2021 09:39:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvpY73LQxz9v0Yt;
        Tue,  9 Mar 2021 09:39:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 78B298B7D4;
        Tue,  9 Mar 2021 09:39:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lo25lReMKuyY; Tue,  9 Mar 2021 09:39:40 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3655E8B7D9;
        Tue,  9 Mar 2021 09:39:40 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 03A016753F; Tue,  9 Mar 2021 08:39:39 +0000 (UTC)
Message-Id: <8d7d285a027e9d21f5ff7f850fa71a2655b0c4af.1615279170.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Fix missing declaration of [en/dis]able_kernel_vsx()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        alexdeucher@gmail.com
Date:   Tue,  9 Mar 2021 08:39:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stub instances of enable_kernel_vsx() and disable_kernel_vsx()
when CONFIG_VSX is not set, to avoid following build failure.

  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o
In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:37,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:27:
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_apply_registry_override':
./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:64:3: error: implicit declaration of function 'enable_kernel_vsx'; did you mean 'enable_kernel_fp'? [-Werror=implicit-function-declaration]
   64 |   enable_kernel_vsx(); \
      |   ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:640:2: note: in expansion of macro 'DC_FP_START'
  640 |  DC_FP_START();
      |  ^~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:75:3: error: implicit declaration of function 'disable_kernel_vsx'; did you mean 'disable_kernel_fp'? [-Werror=implicit-function-declaration]
   75 |   disable_kernel_vsx(); \
      |   ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:676:2: note: in expansion of macro 'DC_FP_END'
  676 |  DC_FP_END();
      |  ^~~~~~~~~
cc1: some warnings being treated as errors
make[5]: *** [drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1

Fixes: 16a9dea110a6 ("amdgpu: Enable initial DCN support on POWER")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/switch_to.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index fdab93428372..9d1fbd8be1c7 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -71,6 +71,16 @@ static inline void disable_kernel_vsx(void)
 {
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
+#else
+static inline void enable_kernel_vsx(void)
+{
+	BUILD_BUG();
+}
+
+static inline void disable_kernel_vsx(void)
+{
+	BUILD_BUG();
+}
 #endif
 
 #ifdef CONFIG_SPE
-- 
2.25.0

