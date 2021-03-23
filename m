Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EFC346AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCWVEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhCWVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:04:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:04:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gb6so10655692pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSmm9rg40XS8aXcFe7w7ys6aRz27IkWLaqy7Q29NMuw=;
        b=CGR9N49TNeFaR0nJdlrtOBdT9ijLzIsCfZmSMexKCoOKD5RWTYITaIO9CErfkGVhTu
         HERE5lYPAh6ezg/vV6fjW3Gvw8FhHYGUFWDdXJuiL6THYIdpJJJ2YiYeF8vDzHM6QNxb
         KY2u0KLrJUpzP5uz/uf8PfTBszf1qSkZ/yFLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSmm9rg40XS8aXcFe7w7ys6aRz27IkWLaqy7Q29NMuw=;
        b=Y4orjv/A5R0cAUnuN6nSNjeWcf36VlsTXBXa2Patl4K2RdP6/wcfOZdXbLv2BCtAWo
         Qg/HR/WVf1eZNyAWpm2Gy2Wn2T1YhxN08Z+cy4jiqZplPkvOpkX4CR3NbcHDGPd6JBiD
         RB/ldHej76SzQOFNfAm1OS3tn5eQQ6eKPxxJoyGzTHp5/pZ2hrAlHcIo24wrybqNV5yN
         S4NwboboYdCqTxr+T7pdDoIqKhoDsyjF9RwLtQtpM0jdpuFeI5pgbuvUOOEt4myELfvD
         c4HeUjhyOhYkSW8xI+UJI4ZdFTGb2ybA+CT9RS9gp7vIVe71ko9PbvO+5zCjZZTbgfBo
         1zng==
X-Gm-Message-State: AOAM531slmL6zhW2siKuGFbu0Rys+RHeqTSdXPf0vOSk9/MHilGId9Xc
        e+BeNZW5LYgPAADW30b6dusxo6sn+tgT3bLQ
X-Google-Smtp-Source: ABdhPJwx2V44h64PIMvm2OqIrQoHgNrfIQwHPYB12fkIBb0twSqD9z7QxNLKVhVgXBDq0ceG5r2WKA==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr35497pjh.29.1616533447686;
        Tue, 23 Mar 2021 14:04:07 -0700 (PDT)
Received: from portland.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t12sm99891pfe.203.2021.03.23.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:04:07 -0700 (PDT)
From:   Venkatesh Srinivas <venkateshs@chromium.org>
To:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        venkateshs@chromium.org, vsrinivas@ops101.org
Subject: [PATCH] x86/cpu/amd: Remove duplicate definition of MSRC001_1029
Date:   Tue, 23 Mar 2021 21:04:02 +0000
Message-Id: <20210323210402.456329-1-venkateshs@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSRC001_1029 had duplicate definitions in msr-index.h and
amd.c. Remove the local definition in favor of the more
widely used version.

Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
---
 arch/x86/kernel/cpu/amd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 347a956f71ca..31c592e5096e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -795,15 +795,13 @@ static void init_amd_gh(struct cpuinfo_x86 *c)
 		set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
 }
 
-#define MSR_AMD64_DE_CFG	0xC0011029
-
 static void init_amd_ln(struct cpuinfo_x86 *c)
 {
 	/*
 	 * Apply erratum 665 fix unconditionally so machines without a BIOS
 	 * fix work.
 	 */
-	msr_set_bit(MSR_AMD64_DE_CFG, 31);
+	msr_set_bit(MSR_F10H_DECFG, 31);
 }
 
 static bool rdrand_force;
-- 
2.31.0.291.g576ba9dcdaf-goog

