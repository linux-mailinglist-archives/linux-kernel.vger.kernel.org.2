Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC630F3F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhBDNh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhBDNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:36:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970BC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:36:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d16so3473533wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2wNLIUP4Xf17KhdjtkEwog/CXYEKOouf43hiUeEcDII=;
        b=Acq3HeMCg6A4IzKWo9Z8JsiKOLxtAiJP8UkpXJL3y3R0x2pfLlYRYei2qibzM+vEGG
         I3QtwSwf+60HVR3isI6kiGY/lINuuOsSUbi8rFsn8bl83va0jOTvn+BmHkUBwViPVKes
         HgeKhzIGlGpj3tvhVipCPTy1v0sDKmKcPSivTZo01uEcWYkbBM9AoPxsPoMNLg1pcyIJ
         QWwunVoC7diVVldqj6/Pj3ocxCpWP16uIqy4Phd0T0qzYP0NE7OzOvhjOePq5XglKtHD
         J+k3PuwqSashd6tuvX8AH+IlqoKmJ7lrd0dVRxMkeBMMxz1B2gLXSa1viXPc6HuAjLIW
         +DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2wNLIUP4Xf17KhdjtkEwog/CXYEKOouf43hiUeEcDII=;
        b=fgUzcoB2LhS7Zc7yYLvEHbbcvHXtIkSXU7un5/24MHEOejrp3m0L7frFQF1GxBaNzp
         VKBE+5Qgw2qjxAviK7Ns1R6vDdo6R/EefzJ89WHg5m7l/J9x/GiZHXgS4myc+3c6yY9S
         Kam83rHvKdMppa0ufuT7JVO7SyGZnf2JbOKObK5wthIrKW6C3LIxH/W52acuQr7W1CG2
         8qRYY0OzB27b69qicZGo3LK/Tko/9K6bfTFWGnm00eXG6CCPRDXhnuzA9WSjF6nKUv2r
         lKixw5kwKcPoVBq6BzN9/n8/QrekxUAWWOQRJdsK+aXjj8blnHdKs0j14CxNPAJTncxr
         RNFw==
X-Gm-Message-State: AOAM533KXkRilctEWI3q41TPmj8YTvFhrxgpVHMVMUudpzJMU1bXUB6h
        REIgVdarwV5vM37/RBGBdmuMFAPOIhDpQK0j
X-Google-Smtp-Source: ABdhPJz2G4W8/09FQulizSxZSffq8RFw/WyNnPD/E6nEF9+KBGabmxW9VIK0Pbljn9oDZPUqGM9ayw==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr9252884wrs.217.1612445773300;
        Thu, 04 Feb 2021 05:36:13 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c62sm6212065wmd.43.2021.02.04.05.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Feb 2021 05:36:12 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: xilinx-pr-decoupler: Simplify code by using dev_err_probe()
Date:   Thu,  4 Feb 2021 14:36:11 +0100
Message-Id: <666708105c25ae5fa7bb23b5eabd7d12fe9cb1b3.1612445770.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use already prepared dev_err_probe() introduced by commit a787e5400a1c
("driver core: add device probe log helper").
It simplifies EPROBE_DEFER handling.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/fpga/xilinx-pr-decoupler.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 7d69af230567..b0eaf26af6e7 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -100,11 +100,9 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io_base);
 
 	priv->clk = devm_clk_get(&pdev->dev, "aclk");
-	if (IS_ERR(priv->clk)) {
-		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "input clock not found\n");
-		return PTR_ERR(priv->clk);
-	}
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "input clock not found\n");
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-- 
2.30.0

