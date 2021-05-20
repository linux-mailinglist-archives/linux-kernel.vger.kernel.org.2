Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8C38B695
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhETTDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhETTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED5C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so18716558wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3jb6hnBmFjxzdvzWu+uBOUpuYnuQHaJ3s27d7EHAaY=;
        b=K970SYTqN8gULsm5HfoOieuvIDgrrm3n7CEDU2099SAFSAo7d709BIDDecLpOiecca
         bZROptfK6xiqhDFE+AO87zanxVe5HbR0SC5ObyMb4UZMiKMpfiYlJHffPshEvJgeA+UN
         V3XG2xCMAY2HTd6MtOFC16ArFARtEWzBocO+cq+CwiAOU6CTEJs7rBuAFIyihY62CbjH
         4GRmjZudOmwIQlDL9LvdAis8UI15SzfhgiqM4giwkY+R0L5j/YzK6biBQRaHmV7XUPbc
         v1TzOIhh4JLz8HV4xmdmBClHHOHwjha1vcMTaeTfrBjxJ31sZoVXCFtmQ5bC7/JQyJxd
         Bm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3jb6hnBmFjxzdvzWu+uBOUpuYnuQHaJ3s27d7EHAaY=;
        b=p9d3sa+/DY2aCV9SRlgkihI98TON8qSNa5ZFOFcTCMsyxSRW1Hadgi7kslSR0Pd2DB
         3KD89qbuI/nZFNL6LQYmxFduINpvMjC941eR1PkUDdazDrOEZ7Mu7d0yNYKQJcByRSAv
         E4iCv79Px+2f4l4zuFcNN2QACS6HNDsizBbU+vo20UtnWKz/a2q8DCDSr55mgGB6EfuC
         0BnGDngZ69qFbkoD4Dz1CdnJVIF1+OIuJJBMoJzHtePpy7NGf14QbBuKarTStpxQ2x2o
         q1KVWFU1jIgH7C/LKX5iq72pOZg6zX43NebyvU1BP4UZ2KORvlbshyhUVwGVoJkgV9To
         bMPw==
X-Gm-Message-State: AOAM533XbhWfPNa0J+b2l14AXvdHeLT6y6icBkW+NH3C2aAgCYmnoMyG
        gWF6kAncGhjehQhfXOkSvNNdRw==
X-Google-Smtp-Source: ABdhPJzQbZvMN96PVkWjIm1fWkUezkxoP+TDMseNMoBt1l63hdRjK8sjh/sSLwnsw30zgcUDQhuUeQ==
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr5699770wrv.372.1621537279564;
        Thu, 20 May 2021 12:01:19 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wsa@kernel.org>, Marek Vasut <marex@denx.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/16] i2c: busses: i2c-mxs: Demote barely half complete kernel-doc header
Date:   Thu, 20 May 2021 20:00:58 +0100
Message-Id: <20210520190105.3772683-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing0' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing1' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing2' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'dmach' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'pio_data' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'addr_data' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'sg_io' not described in 'mxs_i2c_dev'
 drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'dma_read' not described in 'mxs_i2c_dev'

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index f97243f022311..bcfe48e17072c 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -100,7 +100,7 @@ enum mxs_i2c_devtype {
 	MXS_I2C_V2,
 };
 
-/**
+/*
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
  * @dev: driver model device node
-- 
2.31.1

