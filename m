Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47E458289
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhKUIiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhKUIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:38:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA83C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 00:35:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so11014817wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 00:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1W02faQu+Szravq8WQw5MogG6/ITT6EryqDefYAc60=;
        b=prsKTRolTZAn/eLp8jy5tA8v6BeaTxkby23xqeYZ6awHFSgKsVm13oLN/jcEZ9SyIl
         I1Ywe/CZ+wOhuip2GCVpBVBa0K7XjExRe5HJsIs/Nlligz8qyTuaIlBV9GuoGuw1Jcgk
         CQ0B/F7MnQObw0ZX5G50GwOpx8FMOVYLcag09isovlJct6uD6A45u2VOXNC0HCcN78x0
         yvxOcfI9/llc+5+ebilSShkZ9jfbd1LdHUY5KdaP7i3AayQOGN43XDAPlhJdhATs2BnB
         8o8I97bJ07mxVenWWUkjDrXe23PDh6FqOharpfFWFfoSKH47Blo0BFBEIRRkRDuRmpmP
         626w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1W02faQu+Szravq8WQw5MogG6/ITT6EryqDefYAc60=;
        b=Br/Ltmbk2MYMBpAYGY5VCLdO6y6HjhGGj0PBljOXLLEXwlMf1oPMgOZP6n9e4hYVfa
         5veqB4I6BFndyK1paac1bbg9FnuYwW4e/XEDovvitEanL4uLD4AlHFhGG1v3TE5s/0c1
         UE529vY1pnv1qX0w5/l/T4HMCnl9Pj0C11T/Lgusy442DfoanNakCPkA1PqVCh0D7SLX
         s+NKmGF1CLbP644Rww5AWe6RXOEcQHvod7h7xL3/Vy/7MEFwqqPHI0Nf/L1VMWNNOyuK
         6UC2mzh8WhMq9er1FvksnlJCWenbQnV5tyM4aYcbNEfJiDLaP0nSqdj2Ie8oZKEsNWYY
         dEjA==
X-Gm-Message-State: AOAM533wBcj2+siDs66HsILitFZhDGBZfCfP6k6TFA36uabzIm42jJp+
        Uek631y+YoZu5PaR//NcdXU=
X-Google-Smtp-Source: ABdhPJzCdBRcE5NpSYEOCmOLME4QneazaEDFzZrCDOhWB2wRMzb3iKPwCltWj7nYRNphcWEq9/+RwQ==
X-Received: by 2002:a05:600c:358a:: with SMTP id p10mr17212213wmq.180.1637483739638;
        Sun, 21 Nov 2021 00:35:39 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o1sm5100456wrn.63.2021.11.21.00.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 00:35:39 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] bus: sunxi-rsb: Fix shutdown
Date:   Sun, 21 Nov 2021 09:35:37 +0100
Message-Id: <20211121083537.612473-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sunxi_rsb_hw_exit() is sometimes called with pm runtime
disabled, so in such cases pm_runtime_resume() will fail with -EACCES.

Instead of doing whole dance of enabling pm runtime and thus clock just
to disable it again immediately, just check if disabling clock is
needed. That way calling pm_runtime_resume() is not needed at all.

Fixes: 4a0dbc12e618 ("bus: sunxi-rsb: Implement runtime power management")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/bus/sunxi-rsb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 6f225dddc74f..4566e730ef2b 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -687,11 +687,11 @@ static int sunxi_rsb_hw_init(struct sunxi_rsb *rsb)
 
 static void sunxi_rsb_hw_exit(struct sunxi_rsb *rsb)
 {
-	/* Keep the clock and PM reference counts consistent. */
-	if (pm_runtime_status_suspended(rsb->dev))
-		pm_runtime_resume(rsb->dev);
 	reset_control_assert(rsb->rstc);
-	clk_disable_unprepare(rsb->clk);
+
+	/* Keep the clock and PM reference counts consistent. */
+	if (!pm_runtime_status_suspended(rsb->dev))
+		clk_disable_unprepare(rsb->clk);
 }
 
 static int __maybe_unused sunxi_rsb_runtime_suspend(struct device *dev)
-- 
2.34.0

