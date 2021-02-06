Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2483312075
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBFXWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 18:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBFXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 18:22:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F38C06174A;
        Sat,  6 Feb 2021 15:22:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e18so12046725lja.12;
        Sat, 06 Feb 2021 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEe8sA86stKjEUM7UT7CywXr/sNsULZzMz+ZrqPM7Zc=;
        b=ofEjoMZ1XO6PBjCDnQBFZX9e5zJrn9LiFUUBQa2mwwsWQ7yNrEQmasQPT5QKvDnkOX
         1BMm1PYYAl6+z1u8ZpRO3deM9Yfr3F7eiqDM57bXSmZpNBsCMSe+UnSl4W7ynwW1KQaA
         Xu7i1p8wlbAMxUuuRP+PewrykNQEWSJu/RzK1AjU9fm1JfWPRvWWacxD/8mqE3CjyA0v
         aN8zgkyP7y6/TbgwJ45CWc4W6WfbCFgHt+uEDiKzFM1AtV8m+piwLNBzDZCbLJzew+mm
         sEbI14MwhvmewUCPTUlJREiwkC862L2zZFe7iasUBToPLFmve92/EOZ1yozV7s18cZ5x
         pj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEe8sA86stKjEUM7UT7CywXr/sNsULZzMz+ZrqPM7Zc=;
        b=dbRhRclWgz0EbmEmzfe9P9Rvh2T8ihx6oz2cewv7IJkBYmU5wUZzw8f3rMteiKlVth
         eZ1xLc0O4RrV8CkELrPxdjui+CVxorxuY/bhukTGt/+RH2gEJGbNs4RLnq7+GPN6RHtW
         n/uy1UAQV45SoHST22wgbl3rYiUeLiebR1ZrklImrggTxbIPb1ALnUE6vPVBzU72XcJa
         G0oK5FsMy7hdzl8gP69KZi9OjSt9H/VY4FnMtgEL+O6ajy1vpk1I4LpPTe3J2If7Azs2
         DS4xWrfZ7ySAYnIHnWm4bMo7ti6Rykr1NsaB51cJ3CjHUz6eOKnAS74ISDLyl2xNv4Om
         JIQA==
X-Gm-Message-State: AOAM530y43kw/ItVJqhdyGVMz70jaobmIpEWr7XdknLtVs0f0x5ZYKLz
        xcqr2rWKsAV+HEtQtxVyNyA=
X-Google-Smtp-Source: ABdhPJysd8SX+EMl9kmqsQMOdj6beJk2YbcL8OhsPRHHKXu+wD8VSJzlHHgUVrUPb59RLEeyNM5ijg==
X-Received: by 2002:a2e:b179:: with SMTP id a25mr6639934ljm.425.1612653718696;
        Sat, 06 Feb 2021 15:21:58 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c23sm1465565lfi.241.2021.02.06.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:21:58 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] Platform: OLPC: Constify static struct regulator_ops
Date:   Sun,  7 Feb 2021 00:21:52 +0100
Message-Id: <20210206232152.58046-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of it is to assign its address to the ops field in the
regulator_desc struct, which is a pointer to const struct regulator_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/olpc/olpc-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 72dbbea0005c..4ff5c3a12991 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -386,7 +386,7 @@ static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
 	return ec->dcon_enabled ? 1 : 0;
 }
 
-static struct regulator_ops dcon_regulator_ops = {
+static const struct regulator_ops dcon_regulator_ops = {
 	.enable		= dcon_regulator_enable,
 	.disable	= dcon_regulator_disable,
 	.is_enabled	= dcon_regulator_is_enabled,
-- 
2.30.0

