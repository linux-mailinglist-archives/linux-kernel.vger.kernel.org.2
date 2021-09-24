Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE6417088
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbhIXK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:59:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60410
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245679AbhIXK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:59:16 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C2824402DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632481060;
        bh=5qaBnFV4UUYxgISb8cWftr5quOXHWqv70CjWCUQzcvI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=rEbFlMU8mo7ueYnR6LSvRkBXiK7Mzhn5rOBhF0q8zil8+IvCBjtYCXRXavPw0uEC5
         60Um72p954zqWnRo8UExZ9gmxQuxUqVJTcTUBPsI1SQ7+fxyUxXxQTGPAWaijBjZXV
         0UO7Ogza2SRWMjswM7NljWef0H9VEB7jgA/IQZTsLaqA6DtWZlpWsBYz7VxDCeOI+B
         NTzc9ggJRHuRQM8lY+gQz/vtz5vuVL3j+tsj1t4pcVkxz4KHEiBQ2gTa7PN6E/Pyrh
         tQ/oUNAJ3u1aZ7ZpBWppKnR2vILDsykKNlOEfvY4eh7NAoLnylfgZ3BqM2p2fRf9GJ
         XxjHhftkNr1Rw==
Received: by mail-wr1-f72.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso7741096wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 03:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qaBnFV4UUYxgISb8cWftr5quOXHWqv70CjWCUQzcvI=;
        b=5qQA2LluMB7yg8PpYXK/M/PSVhxNiBXjbYL09DzPY8kUD2CUrb0rbWlfcFDJika+3g
         aeRPSSMT3E2W/4A7SdWKRoDzrJ/l9IcBdhQM1CWZvUsAz84tEe2nlOyhq1drGrV/hKgJ
         Msw2sMk5ad9u1p9peyX/iJS7BtDYpws8F/7fuYwzrN+4SUdjDvSvesRYXUlEXbkbgIVy
         CeQM1vYJe2zYlVuXr6Fp/8OXY3bhIaKMKZkByED/ETvgXZAr0T/mHaIDVr6BF/h6kpTE
         PDethFMiLnniHR7kTZssSYbar0b61A2VXaY9Go3q6UnPtAcauVdZqyUks7an+4ogTrxp
         RqFw==
X-Gm-Message-State: AOAM531OTsiFNUjCdRzgFCG3vQQ0MOxHI8rdfknGJ7o0wEsHj7JW+Zou
        tKLL2J1gHXF6VCOvSzg3GhBGMkB7ZTYpUIZNxYPxIr5Q3YuMCe3/Xe4JdQxLK5fL2t3vvNcYgrb
        9dHUWUcXGjdL5WkFaqt/2zLBg5s76xTf8LvpTA2z8Fw==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr1372343wmj.76.1632481060502;
        Fri, 24 Sep 2021 03:57:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDVTGZH5QCPK7kyu8GVnvvhqoDPEvq8MgewAmm21kiS/2XNKEsaKIMI9R6BZZAQ/A08Z3BPw==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr1372317wmj.76.1632481060111;
        Fri, 24 Sep 2021 03:57:40 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id x17sm8188836wrc.51.2021.09.24.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:57:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] powerpc/powermac: add missing g5_phy_disable_cpu1() declaration
Date:   Fri, 24 Sep 2021 12:56:52 +0200
Message-Id: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

g5_phy_disable_cpu1() is used outside of platforms/powermac/feature.c,
so it should have a declaration to fix W=1 warning:

  arch/powerpc/platforms/powermac/feature.c:1533:6:
    error: no previous prototype for ‘g5_phy_disable_cpu1’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v2:
1. Put declaration in powermac/pmac.h

Changes since v1:
1. Drop declaration in powermac/smp.c
---
 arch/powerpc/platforms/powermac/pmac.h | 2 ++
 arch/powerpc/platforms/powermac/smp.c  | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 0d715db434dc..be528e0e507f 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -14,6 +14,8 @@ struct rtc_time;
 
 extern int pmac_newworld;
 
+void g5_phy_disable_cpu1(void);
+
 extern long pmac_time_init(void);
 extern time64_t pmac_get_boot_time(void);
 extern void pmac_get_rtc_time(struct rtc_time *);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 3256a316e884..5d0626f432d5 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -875,8 +875,6 @@ static int smp_core99_cpu_online(unsigned int cpu)
 
 static void __init smp_core99_bringup_done(void)
 {
-	extern void g5_phy_disable_cpu1(void);
-
 	/* Close i2c bus if it was used for tb sync */
 	if (pmac_tb_clock_chip_host)
 		pmac_i2c_close(pmac_tb_clock_chip_host);
-- 
2.30.2

