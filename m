Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4493ACD45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhFROQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:16:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:14:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7236629pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II8CESjac+2BHRhdj6Fakm9t+Cyr5Rk+P7JcjZB40QA=;
        b=07h/VUSUeaTOOVeoUuQhTpvx037wbZoyuatyADlG29lIWdtTX4hVAbxxvEgOb/OZ3y
         rs3w2cAMfzrliWE9NKH5+tcZYICsYQckic7AtP2YYil1/LbQRpDcSmMJ+ZbzcZwqFW7I
         lbFDD1Leu902Ug4cMqDIIFLTbTuiOdUfpc8SsiYjuDkMPeWFc8Sx90XTKP/0IYsQv1o1
         tKPHmSQMu4V6G+5d+qsY5Ee0V95JJrnrwjEP+rrO8ac6LIwrZVUQSoLKsvFGZwK1Sovj
         XAXX8m8UgHRCjPqVa6leN2orrnG9Xiru1ZIwr4qr9PaFBrKboRneFF0jpGKmE1UyJCWp
         mRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II8CESjac+2BHRhdj6Fakm9t+Cyr5Rk+P7JcjZB40QA=;
        b=bWsSkqk2AsQM4ww8Zz0SqrymYWLy4BS95VqlGP+dfX0g3BcCy1swlL1Ew207xhzS/I
         FXoNZMCcc4l/W+olttUMCxydktYG3qIkqHAbAJ4hmHuc0dc3pNycoxI0uoIop2GC3Vvn
         GNtiHuF8DZXPkqsMDoraztfyD7TcqanZbjoAbLdpz78Fp2Vs0aGxSOAqtr4YpM+K+R/P
         1UCb+rYUsh5u7sEhS0cUZnMk5UfFy1eC2mdZxsK5l2fRGCI2dIiJ+qU4AB+e6PSO0W9u
         c6jkd7L19jZ43sjjcUra03yHQwlp5gU617MyfSz2JxDvaET+1s5ra4Lo0jBz2C+DTRt8
         xLJA==
X-Gm-Message-State: AOAM533qrtECAYENtu9TpOl+rnokBMhPPseHXXpNez3k+i+JZXwvVsMw
        6V2XtpGyieGH+tqLVB7lGEKC1g==
X-Google-Smtp-Source: ABdhPJz/LPpdlMuTiGjQWwf56UfZa181aNgoyzUTiiFBYzZ5kLak9ow9UvOIcOxpH60I+e2cQp6r6Q==
X-Received: by 2002:a17:902:ee06:b029:11f:f229:1a5d with SMTP id z6-20020a170902ee06b029011ff2291a5dmr4895651plb.61.1624025663538;
        Fri, 18 Jun 2021 07:14:23 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id y7sm2431874pja.8.2021.06.18.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:14:22 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9052: Ensure enough delay time for .set_voltage_time_sel
Date:   Fri, 18 Jun 2021 22:14:11 +0800
Message-Id: <20210618141412.4014912-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_UP to prevent truncation by integer division issue.
This ensures we return enough delay time.

Also fix returning negative value when new_sel < old_sel.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9052-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index e18d291c7f21..23fa429ebe76 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -250,7 +250,8 @@ static int da9052_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 	case DA9052_ID_BUCK3:
 	case DA9052_ID_LDO2:
 	case DA9052_ID_LDO3:
-		ret = (new_sel - old_sel) * info->step_uV / 6250;
+		ret = DIV_ROUND_UP(abs(new_sel - old_sel) * info->step_uV,
+				   6250);
 		break;
 	}
 
-- 
2.25.1

