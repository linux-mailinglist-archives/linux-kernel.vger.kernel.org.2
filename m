Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62FE3BF8C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhGHLS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhGHLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:18:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 04:15:44 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d1so4537048qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vmo30/la7scJy15aMKEWRjp03N3Gpd58pVaVpDZ9X+U=;
        b=thQMTBElLsrgI44FHcjaR1bIBGNDtZjsSMlVDQV67nE9TruGqx5xYL70e4tBQ7Emiy
         205/B+vPv/3uuwlUCLLB5LgzC0tOqXTFa5Ncn2zSRd2wxIMw6kaPYdW2ixYAZ55jYeTs
         qOhcoy0ltoox44n6V2OUC7QJs2Mh4sRDchjYgnG1YUiQnvmuwrV9Ebw2Ps1IxWBVKKLc
         GmkIs2PcddjMzTbnnDWkQfRF5y4Lfe9dUKF9eVqNH2V2Sru1IbpXjiS5ptlxzqdtSedC
         LQpdQLhLhmFGKQEYpUrnvyVOPvR9PRUwnzVp/4XAHVCPNmJohbu+j1olFwhhR0Voo0xo
         2fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vmo30/la7scJy15aMKEWRjp03N3Gpd58pVaVpDZ9X+U=;
        b=Zu+U5TYXY0CWvPt42+tK2DfCMFkZjhDw8aJA1aDTFR/5+/Aqb5PX78j3L6hucvCAwR
         kvQogLO3YH//flhPXvpW7aNYQ7hHw/esmMbMN3WnBQu7Vox/W3F6oPzeJ0lkYc4oqTMJ
         7Gnlk7kOKwI/609xddVcCjJdL4wADB39SsnMdJ2rGwLefMDnEDVxAJZGcuaiiFFqfkwl
         upuI88JP24mru7H2tqo3YTI3f07iMtr4wPmgVpw/okEo0fNHgPmXlty21A5cUqhcUzlo
         Hzjq9ARmTidx91OMe2HpIQZwhSHdGfPb4jF7a6osQTNNGVhiLyGg4X6LM5WPuNSnwfO/
         szEA==
X-Gm-Message-State: AOAM532qqGYkWiauQsLqsXEqlmh7nkjKFFCdnkQFk+SlQMjnEEU6Xgz1
        yzbBArfIzZB3tdkE3737anxsYg==
X-Google-Smtp-Source: ABdhPJxfg3MyUD3JcQ3luvSXNJOxkeEl+AFkYe1VgWCMo9Ihf1LHNZibfezSoUiW+Ycw+3nL9nII7g==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr13661497qtx.219.1625742943442;
        Thu, 08 Jul 2021 04:15:43 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id a20sm845965qkg.44.2021.07.08.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 04:15:42 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        linux-arm-kernel@lits.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1.1] arm64: Add missing header <asm/smp.h> in two files
Date:   Thu, 08 Jul 2021 07:15:42 -0400
Message-ID: <4325940.LvFx2qVVIh@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <20210708093340.GB24650@C02TD0UTHF1T.local>
References: <5726396.lOV4Wx5bFT@iron-maiden> <20210708093340.GB24650@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing header <asm/smp.h> on include/asm/smp_plat.h, as it calls function 
cpu_logical_map(). Also include it on kernel/cpufeature.c since it has calls to 
functions cpu_panic_kernel() and cpu_die_early().

Both files call functions defined on this header, make the header dependencies 
less fragile.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
Changelog:  
v1.1: Include the header in alphabetical order.
---
 arch/arm64/include/asm/smp_plat.h | 1 +
 arch/arm64/kernel/cpufeature.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 99ad77df8f52..97ddc6c203b7 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -10,6 +10,7 @@
 
 #include <linux/cpumask.h>
 
+#include <asm/smp.h>
 #include <asm/types.h>
 
 struct mpidr_hash {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 125d5c9471ac..0ead8bfedf20 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -81,6 +81,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
+#include <asm/smp.h>
 #include <asm/sysreg.h>
 #include <asm/traps.h>
 #include <asm/virt.h>
-- 
2.25.1







