Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08D73531E3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhDCBYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhDCBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21158C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l13so4753339qtu.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=ljHU/tl5y9ARpxMMijUw7QOI0xzzZvHKAi4e9gqpxQvfd7dSwh89ZTZAIbrbbkaE+8
         g0aPucD7ReqXMiB+ZQQbw7R2xvIccfCAfxWkMk9x33/ZpsOh0KP71K7vI87YyQbXS+oQ
         nSSNVZzCoWKYDVOI4oJ+9Hye4/MIJ6MlqkNYsX7guXK38ODkZoGwRc/80+wDY3PZgBuL
         qpTYGgUCVlKLzj8EhO+QN4cDU86JtcD93YUuYdYfWEljLi0e+1rkt6aRfsecqoe1BzXr
         Lm2OUQJfv0zjZgb9MIioIfVAM50ucCXNKWuxzcvb/vjRuDE8vXcBK0Ar3LHQfh5DiBvH
         3p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=dYVkjsiDlQL2LFvj4Aa9j3Bt7vxpuliIOixidU4eoQT8/Eqw73XlcOcYZR8uki0Hls
         U3beWZc7NzJpsn7CHlte4/8T3mwC7thHZtmqVw1BOxdIaqi7UN4cvY/xf48gaOtf6Eib
         Uv28n/Sfu3asmksKgBk/1Kc3ovjql5XLB/SJUz8qChyTfFJY28sTd3uI/pu/f5jhRGTn
         hZ3dg5hkymM5DxzAa9gzWyWduHzDQShkWE34fSZEGrfQTAxAAybZAjlatz3oy4xH8rMe
         gdLzJO75wCq2kps3uhNCbVyDaLFj8p1VOutN7AOgVuiJcxzgTc1WkPckmBvUDcUWdnYc
         nfTw==
X-Gm-Message-State: AOAM530Dti4/oWo34Mks9xmefcGpuQLXerpbcEshPUeu48lkG9321ixw
        GPQGbz/VnLWUPAsWBSYgln0=
X-Google-Smtp-Source: ABdhPJyuAmc4plcoa89tZPTcjXyDLCczbGR8jeyCyDazGC+HFMJ2frZE9FqOLaln2M6KtYx7aKUHTQ==
X-Received: by 2002:ac8:134b:: with SMTP id f11mr13347775qtj.184.1617413045851;
        Fri, 02 Apr 2021 18:24:05 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:05 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 1/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:38 -0300
Message-Id: <20210403012446.381516-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an if statement and, if the function goes into it, it returns.
So, the next else is not required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..148921fb9702 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -154,11 +154,11 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
 		if ((status & mask) == value)
 			return 0;	/* already set as requested */
-		else {
-			/* changing bit */
-			status ^= mask;
-			perform_write = 1;
-		}
+
+		/* changing bit */
+		status ^= mask;
+		perform_write = 1;
+
 		break;
 	}
 
-- 
2.30.1

