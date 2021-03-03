Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F632BE26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbhCCRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350266AbhCCMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:46:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EBC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:46:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n22so5073842wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHIHpoWITKla/9IZBsvp5706Sa7D3rYHp0QL+y3tf4c=;
        b=Sisvz3NrnqtlrK/NrwfvMh2IsHBgzMb+URq0HB3Rp611Z3MFBAI5WPTShD8NSfxQze
         fOkvPU7NbqDykF9U1MaCEBI2w9cA4RQNTKSvg5ksFbOzyVtV9AYLkyMAUtngE/yjJEwt
         slR4phu1ikc8lvCi/eYGq3gZiOGrKR6kEiFl1WpwZsQCbRVAfT5/tdCK08WZokyA+XNh
         wxhUpdYmn2GomjNBXUgYOjaqpOAcVXOfXuvpH9ZgI/N3sJsLQL/WrzMuHKstBKZ+/4dF
         DWbi4+VA9azhmMpCHlnUcAqsArhj5Aquoe+ZMcBUfYcpShEInuLa2qov/7A9rKSqLYQJ
         Ke4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHIHpoWITKla/9IZBsvp5706Sa7D3rYHp0QL+y3tf4c=;
        b=XKLiPTrmaEuSGCR4hq4Lp97AWBMul+gnIQqnXx/PDiG32uHaaocohXsA6IN/7Iom82
         nBTDVzqIjVBaF1vv7GrjOL2FXUk18rZ4eOm/CuHaiGLLnIarcDlUFFemqSs5ezr0St6t
         Ajl3D2Y7GK/C2rEsCyom2Mc1ieBuyZM8T2P0Su8FN34FAWC8yLnOHM8GrNCWALpcTG/i
         RNjaC13uTgP6X5RHqgzTkJoCBSHUGdyAOqOBcgIF5En4YgsC9sbO5QMVSBZi1NeGAwbr
         tU3PM+7itR/tva0pF1yXebvtal0/yMBZbZxno3S+zrNAQJMfUXsqp69ioxAUOQ/m+xJM
         DMRg==
X-Gm-Message-State: AOAM531ky9sFP9nAxt/S+o5GMuqotjiysLrcc1slfRrvMb7WvzSVptOZ
        L5ehU/AwdB9ahiuAJMRtaRlQCA==
X-Google-Smtp-Source: ABdhPJxvfbyWe0xKuFVo6LR++FxzOh/nkBH2FsnVXfGIznDO0CIRicI/8mERVJR35yjKLHD8RhP8fg==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr9011294wmk.27.1614775566661;
        Wed, 03 Mar 2021 04:46:06 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id 18sm5581353wmj.21.2021.03.03.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:46:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [RESEND 1/1] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to shared location
Date:   Wed,  3 Mar 2021 12:46:03 +0000
Message-Id: <20210303124603.3150175-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
 385 | void __init hvc_vio_init_early(void)
 | ^~~~~~~~~~~~~~~~~~

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvconsole.h     | 3 +++
 arch/powerpc/platforms/pseries/pseries.h | 3 ---
 arch/powerpc/platforms/pseries/setup.c   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
index 999ed5ac90531..ccb2034506f0f 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -24,5 +24,8 @@
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
+/* Provided by HVC VIO */
+void hvc_vio_init_early(void);
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_HVCONSOLE_H */
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 4fe48c04c6c20..a13438fca10a8 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -43,9 +43,6 @@ extern void pSeries_final_fixup(void);
 /* Poweron flag used for enabling auto ups restart */
 extern unsigned long rtas_poweron_auto;
 
-/* Provided by HVC VIO */
-extern void hvc_vio_init_early(void);
-
 /* Dynamic logical Partitioning/Mobility */
 extern void dlpar_free_cc_nodes(struct device_node *);
 extern void dlpar_free_cc_property(struct property *);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 46e1540abc229..145e3f4c999af 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -71,6 +71,7 @@
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
 #include <asm/dtl.h>
+#include <asm/hvconsole.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
-- 
2.27.0

