Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84F38991E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhESWNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:13:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF599C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:12:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v8so16412914lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceQR8hYPjYrgQYD5rEgrxfQGfqurUqS273stWfVpCuE=;
        b=vBnXb3MuylCi321OtI1JdFeyzhXwLoinuOS0YOEmKPgZn4D/IcAFwxAaKC0usMqOr9
         Ut4mL4PieCom9lu6ybNO6vU4BHblNF8gF2i2bZ+tIThTq/aJ4RHwqQh4AFDCWmt46I/f
         OeSbZOJFftJhtBkLVyh74p4acCdCKnwfRYDZXqYZSpNGS078HD83Yg9wPptoNr3VigZd
         kwPiSJGaIwiIxUQy4UBOi6vz20PeNHu4HvidimalZOHOTGPxODoqJAkvvQzyotKHIQzr
         T1djgniAdQ0mNVE/T6oeQOR6XHaNFAsPU8Y+iRWUvh+A/ST5TnuZfbtXe9TsVDuUxs2y
         FUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceQR8hYPjYrgQYD5rEgrxfQGfqurUqS273stWfVpCuE=;
        b=gbdJVivauRSlpDcA0EAVvhcxeNmxdEbm00jAVjb1kux03rnmUPymUytotPBOhRtAF0
         HK+dbflbAEEsMaLViY1wYz2HswUi7H9vlUL2uxagS4NOcVtXCWj0a3opX9UlP/beiHwR
         7F2NLMO0P9cqD30Ag6r3XHLKQwBwXTWwd2OcvUMj9ivJDI5fqOLjrytTyg0TD1KT7CSa
         sUrMzYZyDLs/SsZQV+BZCAes0NL8QAyG+NyaiSNbl2ZvXec8JjMEBAGVqyDBgxLRU60r
         anTJQb/e/0+pMvT4YhMHSoYi6Jz+rj+yHDbJWtg+CW7pH5YrI8gZSXyWKZT02yY0TPoW
         +5Pg==
X-Gm-Message-State: AOAM530euNxLzvE9hYABVlkpfPUN1/XHEeQWGYiFkcwrsk3EXkXALUdP
        tN38bZntN3MOpFZJ21JgOTolx7aIGMYi+g==
X-Google-Smtp-Source: ABdhPJzRjAyQZ1TeIcaV5nKNg8uG/55epWQ4rXNtI7CJ31pOoB9SkheLypTkyGafXM91vjry+PBy9A==
X-Received: by 2002:a19:8083:: with SMTP id b125mr1134434lfd.204.1621462346223;
        Wed, 19 May 2021 15:12:26 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16sm97512lfl.83.2021.05.19.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:12:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: core: always use enable_delay when enabling regulators
Date:   Thu, 20 May 2021 01:12:24 +0300
Message-Id: <20210519221224.2868496-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
References: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators (e.g. fixed) do not have .enable callback per se, but
use supply regulator and enable_delay. Do not return early from
_regulator_do_enable in such cases, so that enable_delay is properly
handled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e20e77e4c159..66c465bd00ca 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2516,7 +2516,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		ret = rdev->desc->ops->enable(rdev);
 		if (ret < 0)
 			return ret;
-	} else {
+	} else if (!rdev->supply) {
+		/* Still handle delay if the regulator was just turned on using the supply */
 		return -EINVAL;
 	}
 
-- 
2.30.2

