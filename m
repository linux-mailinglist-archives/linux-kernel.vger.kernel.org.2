Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1816C3DEC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhHCLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhHCLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A3C06179A;
        Tue,  3 Aug 2021 04:36:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso1519783wms.1;
        Tue, 03 Aug 2021 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PnI+xpj+tguuxhwECLNvUTwNInWMqG1pkkM+TYmvSjg=;
        b=NvpkBpgyvq8U/+BAhz73CUo1alYLmpRGSyMroht4sD/rfiJ/iRN9mWReSOtWqGoMbz
         nfpOJHFRe0NLbT9uN6OzxEtoEWptxxNoEe/IlEYiTJdswl2SMa9WvtbxhzUAGY81sRTp
         romfHNN1fXLKp1x8bbfQmsuZbjlTs3Ifl5nDM779BG0aKulZpZ4gq6RLxvIRcusUVK2Y
         TFScGKOkvxgQEimyB6ngc2EB8WIxwkRXiZlq6z9dVdnndN6wYQSJcr1T9k9GU+gem9Wm
         vU+cksyQs3okmALu9B6fB2zJHHOr5z3XMKqyMqfXFZ49tZPuOiDUu63ZdZyE9owV1lkv
         5erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PnI+xpj+tguuxhwECLNvUTwNInWMqG1pkkM+TYmvSjg=;
        b=dy2hZB56pKhXmxl9CEHDl2lS5hs0D7C3qU8SJ3HXbU7Xcsra1b/uTaiXHpO+IeHJ85
         cYC6/Yp9kPTFuPk0fBFM8lLdgS7a3apWQMOvHzPpvd73hN9ezf9D5lnT5X3AWqY8grHe
         H0DOABM/rGFus4hbuGeqb5A/JyF6GmIbPrQqRQ6qDW3M/EjRjeyxgfbWFNf+s5R/ntiG
         1Loj52wcBXLLAebB/iMJJQfvMJMs8aGvtwaOVYn9Vr+qwmNvrNqjRuMmN8sZQfgEzq5o
         JB5p6mZIxHWL2lMYT+L6fzm0+LgGgR7jApy7nzhBKN6220xk0ThKj7l3I19/M8WcGjgD
         vxxg==
X-Gm-Message-State: AOAM530Soih1Nue02QSKgiMf1Ft9f6E77M535k41aS2XjIxK5/kzP1RS
        K6wjjEUjzDbzfWWfbvLoj/4=
X-Google-Smtp-Source: ABdhPJzNIytWoPgjmoQqVBAzQ3LD/dm1XNvLdz6ZY+nvAwf/c04PoZ22pBHRezmdM66Oyl8/vRQ8wA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr3767101wmj.93.1627990575850;
        Tue, 03 Aug 2021 04:36:15 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:13 -0700 (PDT)
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
Subject: [PATCH 3/9] x86/Kconfig: correct reference to MWINCHIP3D
Date:   Tue,  3 Aug 2021 13:35:25 +0200
Message-Id: <20210803113531.30720-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 69b8d3fcabdc ("x86/Kconfig: Exclude i586-class CPUs lacking PAE
support from the HIGHMEM64G Kconfig group") intends to exclude the Winchip
architectures and refers to CONFIG_WINCHIP3D, but the config is called
CONFIG_MWINCHIP3D.

Hence, ./scripts/checkkconfigsymbols.py warns:

WINCHIP3D
Referencing files: arch/x86/Kconfig

Correct the reference to the intended config symbol.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 45962aaf2b2c..79e7457db5c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1401,7 +1401,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !WINCHIP3D && !MK6
+	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !MWINCHIP3D && !MK6
 	select X86_PAE
 	help
 	  Select this if you have a 32-bit processor and more than 4
-- 
2.17.1

