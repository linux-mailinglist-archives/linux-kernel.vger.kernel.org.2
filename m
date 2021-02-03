Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2502530E035
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBCQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhBCQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9CC06178A;
        Wed,  3 Feb 2021 08:52:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q2so406643edi.4;
        Wed, 03 Feb 2021 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=o8/fzD2S/d8LoSZrTQrPH9tV5gx9H7WTtioRDMhBmVkPGxm6j/s92sxTsLrkEjY1vH
         LnU75m6o6ba5aPfKJUSFfPOEnD3Di8qQVRS96xUilv4kHsws9LXqOXtYxO6N4atUI30y
         kj2CfK2OtvnnlYQiEkJW0AtengxgJVo+fKeaNiK0Z5J24qTVdnvGJ0VFzIPoLb5YnauJ
         yuebdd7xxu3ptQWQ9zaw0TdIjVihaLn/OyP7YjpTcgV0dS+/tqa0rF4BADUU2C3ZH8t0
         LZfPLSHtmxt6q7DYoWkC7wrO5FKWC/tQZjWrcsQripcPxidp3UTTZT+8jfnrPb5eUBM9
         OXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=WxB+a/GATi+KYvmV63XnEQ8YsqzNmfgbMy/JYTJ3eSllt4CTADcv2WXQmxkHG1pk+y
         erhKJ2hcsV7rruWyX1EytrZMcNOOV2eZ0LT88PKOLbpthZoCQTHwIuGo3mHqv3naICoL
         d/4Wzzvg5pcqxxUJsU8Qf0x3EQXgoI+jn686A+c9GJHNdsHI4e8hLajwMX2lIkGGtAlM
         DZkZUv0UnUzYrJua+ZlvTXtDzNrl3CPBd4aD0jpQavcnxT+c4N2mOOhIE5s/RioyLsKM
         os2JtKJD6C8HVA9YFJdOggzUfyBZd8Qbs0w4U48MYzrusMiDWBZ+izIpDTt8XC7UoKub
         k+CA==
X-Gm-Message-State: AOAM532W3AjKTaj181xyIAkyGDf4fR/J4DJm/U4Zvn+C7ledjUV+3KtP
        lf5mNBL1gR+aAeoli4DxBNA=
X-Google-Smtp-Source: ABdhPJzTgDqt1ssHuoUoFiEUrOATMDbYckqfoEHbqtFgG8DiQ8X/zQJTy1QpJaV5fm9ul+FVLXn2iQ==
X-Received: by 2002:aa7:c34f:: with SMTP id j15mr3958007edr.120.1612371165676;
        Wed, 03 Feb 2021 08:52:45 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:45 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] usb: dwc3: of-simple: add compatible for rk3328
Date:   Wed,  3 Feb 2021 17:52:31 +0100
Message-Id: <20210203165233.22177-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future and old device trees must
remain compatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b..93bc34328 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
+	{ .compatible = "rockchip,rk3328-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-- 
2.11.0

