Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC75A3531E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhDCBYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhDCBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:12 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA704C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h7so4790480qtx.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=dLgmoYEp2PRd8X53a4Uz8F5fbf8luOTd6G7/woDeQ3aDqyqqibERZuI3D5NxuPXoDp
         ukqPEg7VuChx/2BQxZFvlknhm4fshQUdo6vSz5uCKt7xrtXrNeh7hW4NS57JyFahGSvZ
         gRHOI++gG2OvTbCk8IiFQ3AcujlAiatpPPmydeuJfnulMPi8g/xHIbqNQu+eaCa21LL7
         X4s61gInLKZwNflfPRbVQGWh8vgNl0lmuVQ9ePf4+9jMN9zHfNpHNIvfT3KAhoyJE0d6
         7SVOkT7l+5l+og9s4hdewh6ZuGaIWttRVNDqif6DoXMm4SmLSHqN1E2gnIBhfYok4530
         uAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxUwJprpafXvqxQ24FtKstnVbwXECMiYhwtxCk/m/jg=;
        b=kwbeHDfuJTfaT3pp8efj2ODm42z5IRbcYAGBe4GsScm4/Qwv8ans+ejjBDnwpBzjkE
         Tg46T1+2dsGMIL08n0DqYC0fVEQ2iPlT3Cxqcz/HpbEDLudfD0AP7u6ZaFqjrJRzkk0C
         cedWOoMlCwzDNOm+GHPOuBDAajvlXIJ11PsAWXwmNVBDf7/A2aPeUfnjBIsXidlflSLO
         SqCWKRROOz/Ml3ttXmYSEtXt5FFnZca/4/f14skXpCg7TsuPrwmQsF/IrjlDqnXZ7MCu
         m68s2ejHZkiPwjXggsYA9Kx+ahdlYRx6biJBmzIu6rQrAanK9lR71JvVamDpA4IFrrZ1
         Yagw==
X-Gm-Message-State: AOAM531VgLWDMcwXlyk+ydJzb7wZTwAFUnoca/2Db6QMd8rOWtVdrDpN
        +eFeIMG/gNq4uS6B6J0yWPRIXIYotyvZg0eZ
X-Google-Smtp-Source: ABdhPJyj4bL4e2H257pnx869aS+JHyECu+WhsUk5MH/n0l0oTIgw6PM1sCM81C5XfWFKVsTumxKnbA==
X-Received: by 2002:aed:29e1:: with SMTP id o88mr13812239qtd.228.1617413047988;
        Fri, 02 Apr 2021 18:24:07 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:07 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 2/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:39 -0300
Message-Id: <20210403012446.381516-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 148921fb9702..a5bb53042c93 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

