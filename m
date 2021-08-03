Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD443DEC15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHCLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhHCLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E0DC061757;
        Tue,  3 Aug 2021 04:36:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z4so24990344wrv.11;
        Tue, 03 Aug 2021 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQ8vue6fvePMAW2zE+EriRZE784Xc3JbHkYfkjzxFUQ=;
        b=U5DrcrBtLCR2LZG04BiBqegO6VfLThHoSlNe5cIZBfScmMtYXltUsEWEG2Gv2hWzWJ
         Eq0tAt47FMNoGXOjVsjFuGiyzoMRBPpatgs3DfPU+2BClyySGh1Y0dBwdXedFZS9wbeK
         gnJFifK+/LohDFBryenMV6cVKXY/5sure+duIAqInqcJBT7g6UNn7nqhZ+xCmWFAnQj+
         XzT/hPuRC240e8HqaCmuLIUuznecvV/nxmBkc309443mWsNCXPTqAPDFF6yRHKGw/Rjz
         lfN7EGkFd8PXj0yPAQQAv6DQXk1HT5xDc1A2lZ3jPT1MCNMgmk8xmytxvLxHQPaVn8oV
         8sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kQ8vue6fvePMAW2zE+EriRZE784Xc3JbHkYfkjzxFUQ=;
        b=ROqaOA0TgiEeVOCQkcr90rBVzUkgMtSujQbrlqqoweAbSZJSPKVRRA5ufZLwXm5iq3
         dGQEuQAGu/klElP7rI2EEzkn/9T0PaQg/5/+K2c7CeXidgxd8OEuD9+brKsH/qjQspht
         M0G5Nt/+cLHOE6JSpvHMstHgWUUIluALASfBEqs3JrWJYs9EUBgtfLKFD0N8LlbxuIUe
         N8RVjNdOFa5WXeOq8ROXj1vlRZSHNmuQ+w/hGQtrVgPtzx532hQ1z0XX7vHdJ7ABHVPt
         JJrL3reVpAlI55A+kY4TnyIlW9uS5DZXddxisFIsAlPkoIF+J0Rho0vf4iGvzIe/UsDW
         X9dg==
X-Gm-Message-State: AOAM532bQVwzmYs1pk2xlQY+oXPIJGu/r0COcBpJDtzJr3Tk/3eSYWjo
        ib6fMiJ2izOAEzwhhrpto6s=
X-Google-Smtp-Source: ABdhPJxovVr9QubKgVz8Wsxxme3z1n9O27j2FQ2gJw6hhe+hKI5mWMV3hSLVzo3zd0v0p1T+j2bhfQ==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr22275620wrk.355.1627990581647;
        Tue, 03 Aug 2021 04:36:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:20 -0700 (PDT)
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
Subject: [PATCH 5/9] x86/Kconfig: remove reference to obsolete APB_TIMER config
Date:   Tue,  3 Aug 2021 13:35:27 +0200
Message-Id: <20210803113531.30720-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated
platform") removes the definition of the config APB_TIMER in
./arch/x86/Kconfig, but misses to remove a reference to it in config
X86_INTEL_MID.

Fortunately, ./scripts/checkkconfigsymbols.py warns:

APB_TIMER
Referencing files: arch/x86/Kconfig

Remove this reference to the obsolete config.

Fixes: 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated platform")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b553e8b4df4e..cd466223c557 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -606,7 +606,6 @@ config X86_INTEL_MID
 	depends on X86_IO_APIC
 	select I2C
 	select DW_APB_TIMER
-	select APB_TIMER
 	select INTEL_SCU_PCI
 	help
 	  Select to build a kernel capable of supporting Intel MID (Mobile
-- 
2.17.1

