Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADE3DEC0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhHCLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhHCLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11606C06175F;
        Tue,  3 Aug 2021 04:36:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso1927629wmp.1;
        Tue, 03 Aug 2021 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7B9xwFz7QV/+u2CYKsWFbtd8WRnRlInr3OMPs/MwIsU=;
        b=qIb55S6k4eHKWDqOLQLSvj2Vs8LnfPq2GyJzK1gmB+vKZ0IVLto2M+kg1BFbGFF3sq
         e2Tbkvbt+FxngWgfP9S2+WmvEROMZll8V8mPVYoswxW7dtBGxyKFkL5v6yvUCah2Rers
         qY0yuW3x5Mzccg6Litik9h/FgsJVMxumlxhX0hGITCzRBYIwFnlQD7l0cuR2+1xoOXQH
         9+bDZ3gUrz71O7DLFY3vzfx0/Dz2dZAiTxYsvGr105mhELIoTjE/+uicUJcE+lou+BZr
         0vtk2C3YayfPvc+fwVLa5/tWnocqpJPCp6ZopLy4kI4VV+OrpKz+a8uL+Iwrus4lbDEy
         rBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7B9xwFz7QV/+u2CYKsWFbtd8WRnRlInr3OMPs/MwIsU=;
        b=a6eL/6o4qf+1Q9W6Vi0LqAGbBVOFJEQpnWJrca7Lyy8JfXIBpu70xNfW3yxHY9JbQI
         p7jQSxiHqU3ya8qJ9Otevu9c7yPvd39mWVU6+nqMLAmUUJ4Oxe5s3UtTv0mopxzmpxmP
         hDBQfA1uJBT80K480cwkCB2yySz0smQGHIJMAdUdg9ogopgjcIIRUqk0N82Umm0OSjf2
         jRZJQJ9G8H0RfU6skidJQTsI68phT4Y7FW5+U2yrDnKcy3DvVUm24kVcK+RHIE0aIwNs
         D/R/+SUKBK80NCMDT9gHSWbZVr73i/RNmMCXioCuP1HT/g59PrQqNEhp/hlJstilHi/+
         4g1A==
X-Gm-Message-State: AOAM533JzkKyerWI9AVCwhXue9lp/cNebfpVUZyo3YME0fgN3kDyFLy6
        QZfsLlUGie28b54vFOFeE9k=
X-Google-Smtp-Source: ABdhPJwUXZO8wH9rEhbY60lgep7gdCU6wj97O5eDW2795KzijsrCD5N6HLeWE3nkMGGqfoJeo76o2g==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr17085752wmq.45.1627990578659;
        Tue, 03 Aug 2021 04:36:18 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:17 -0700 (PDT)
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
Subject: [PATCH 4/9] x86/Kconfig: remove reference to obsolete MFD_INTEL_MSIC config
Date:   Tue,  3 Aug 2021 13:35:26 +0200
Message-Id: <20210803113531.30720-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ef3c67b6454b ("mfd: intel_msic: Remove driver for deprecated
platform") removes the definition of the config MFD_INTEL_MSIC in
./drivers/mfd/Kconfig, but misses to remove a reference to it in
config X86_INTEL_MID in ./arch/x86/Kconfig.

Fortunately, ./scripts/checkkconfigsymbols.py warns:

MFD_INTEL_MSIC
Referencing files: arch/x86/Kconfig

Remove this reference to the obsolete config.

Fixes: ef3c67b6454b ("mfd: intel_msic: Remove driver for deprecated platform")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 79e7457db5c9..b553e8b4df4e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -608,7 +608,6 @@ config X86_INTEL_MID
 	select DW_APB_TIMER
 	select APB_TIMER
 	select INTEL_SCU_PCI
-	select MFD_INTEL_MSIC
 	help
 	  Select to build a kernel capable of supporting Intel MID (Mobile
 	  Internet Device) platform systems which do not have the PCI legacy
-- 
2.17.1

