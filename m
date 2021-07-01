Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19B3B9525
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhGARFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGARFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:05:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0DC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:02:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g7so9108653wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJh7FVYjBCdjPmtoOdvfEtFDITIvKo/TmmTk+wz8FwY=;
        b=cjqFxg3v1zZF3wtBoDE/4jCV14OwVtVivTacqhPCZYFXa5fHUMwH9GddxteGcnpCmk
         QzEhtYqKec0j0Lk5Y9YZLqAeXl1cPhZXH0BIfRkGLw+Lc/TVfMD/Pf6Ai4mm3jqzWcG5
         Q2wfBP7rHlTpQ1kkbdHxc9k+26fEhuPJ+Q+mFsdYfINWNGswOxsrzdNF8MdtYL9Osbn3
         SeARqap8D8f5SikgcNJeXd8LLtrES/TzcpRTisd8M7rgFUHrOqLGvuQRQatyfcl+wTG8
         AVBInElg4lDhZ6Z79kHeIGwxnyCB9KdFJD/2E6bCG5z79RvQO1wdo9k4yZ7YafCLMcgW
         zipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJh7FVYjBCdjPmtoOdvfEtFDITIvKo/TmmTk+wz8FwY=;
        b=rlO7C08ITdrYISO8AGzEVKRTJcMTA57BtJZZItU4Dp4He8dwl40iCXBMm4G+7tpjJF
         89J1Llug5Bf7cZxnUOvNKBAnVemu5euRnVjhhzwyunexrxZPx/RdXO+l2gXUAYlm5AsX
         7/8ewcm1P0SN+k9e2wblPcvYEXWI1xmWN4pa648nVvPhK/AE6PVAJ21RPsTbYp7koFnv
         1iktKEeWeICFDEqwLO1ZhCpJmAgBUKqcMeu0qzdtVbKIJjMyGJmyqhm9l6R0KsWYliU/
         XsUNsnmNd3EvUloHpyolM/LZSXVNpWraz0iggRrEj495p02JyrSu4NiQeb4bEg8Tc7OB
         pS7w==
X-Gm-Message-State: AOAM531gq36BqVtetZfo+wkzygeNXGUqEfD7jyCP2xR0cSGaKxNIY7Jm
        9rPUhbgdO1s2nN007N37cdI=
X-Google-Smtp-Source: ABdhPJzLws09u4c9E3LZw1Gyuf6AzC7yiwkotpB9uGpOXkKY+G9fDUG00ZywHHzO0aQ4yf7+jYrCiw==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr805000wrw.370.1625158951522;
        Thu, 01 Jul 2021 10:02:31 -0700 (PDT)
Received: from othello.cust.communityfibre.co.uk ([2a02:6b64:80a9:0:1be:22d4:3c1d:bcad])
        by smtp.gmail.com with ESMTPSA id f6sm527442wrs.13.2021.07.01.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:02:31 -0700 (PDT)
From:   Cassio Neri <cassio.neri@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Cassio Neri <cassio.neri@gmail.com>
Subject: [PATCH] time: Fix help message on TIME_KUNIT_TEST.
Date:   Thu,  1 Jul 2021 18:02:15 +0100
Message-Id: <20210701170214.133015-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'RTC library' to 'kernel/time'.

Signed-off-by: Cassio Neri <cassio.neri@gmail.com>
---
 kernel/time/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 3610b1bef142..aa07f59809a1 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -69,7 +69,7 @@ config TIME_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
-	  Enable this option to test RTC library functions.
+	  Enable this option to test kernel/time functions.
 
 	  If unsure, say N.
 

base-commit: 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
-- 
2.32.0

