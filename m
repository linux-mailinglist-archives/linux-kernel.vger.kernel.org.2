Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77844B99A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhKJAcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKJAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:32:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C74C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 16:29:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c126so1066037pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 16:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEzErmitUUc1WCRwF90GY08l0xszb/xghqlykO8h5XQ=;
        b=HoUfE9FMPs9FbWg+kuLPHy/L4ScIui5grCU8JXDkrj4jNnMmSBVDJH9ybI+5cI5KyM
         kiyqA9oGfmaiIp0bg7woJAxlerKajDVP0Qk/XBfycWTsDVEnm1Ig5L4uf/WmUu841bRT
         aNkR/veAg2w3ULbimJTbQGJEpcF5Bo9bGvdaS3Hf7dsxkwwBaE7ip0vnfwZv8XFHmCcc
         e57WL3zXoxDqavdn1mSjovQXAXN0QC3Tk6KmEJPh+BtWVmMDtqURDnpB9os97UMcTwr0
         BAlnEEVb28PTC+hW82HQT5m9w4tC7U+/pinOH0TFk24abX3MYyx4ZcJMfaNlYxmeY9Q0
         km0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEzErmitUUc1WCRwF90GY08l0xszb/xghqlykO8h5XQ=;
        b=Ub6F+hHdLUUM+tt+ntOcKaeA5td8QFJZl8YbJgSL0vpANC6FtOEUfJJEkaG9j/QFKI
         hAz0AzvPaw+CewAkhmWVBm5tw069lw+IaKuTpCaMY/3W9TpzXS3A5oMmCr+WfUxnO5Au
         6/6cCrxn1hUrOdMVOgBuJfzMqkBqK2pE8GIKqS4NdWjn6tM+ma+n6d+Md0M8W5p7t9rQ
         lo+HMPDVugRODQEtspyfauV98wcq1vKUN6Rv2D9ttI7KzWQtnbDPsqb4It2QgW0bEynR
         NntAUmwA+I1C6KrRbjeeMBe5iNGV9T73HOTgbMTV+M51UTHWqrdZ0IYkPVC2zyWmiJX4
         TuMA==
X-Gm-Message-State: AOAM532J5V1WwhCCKa26hypwL1M8O47CtJDmFC2YOHpGE+NBN9W5y4Kx
        xedKfuF8lTvLlMqq+zQuEZM=
X-Google-Smtp-Source: ABdhPJye/VUSnlCLCAknWO+RWaynEg+Kow/VhPktmT23o2DuN4Tmpy6jXdqg82E0C967zkissHr4bg==
X-Received: by 2002:a05:6a00:1a50:b0:49f:fc2a:fa9f with SMTP id h16-20020a056a001a5000b0049ffc2afa9fmr8630020pfv.43.1636504159274;
        Tue, 09 Nov 2021 16:29:19 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f185sm9515716pfg.39.2021.11.09.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 16:29:18 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     nicoleotsuka@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: imx-hdmi: add put_device() after of_find_device_by_node()
Date:   Wed, 10 Nov 2021 00:29:10 +0000
Message-Id: <20211110002910.134915-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

This was found by coccicheck:
./sound/soc/fsl/imx-hdmi.c,209,1-7,ERROR  missing put_device; call
of_find_device_by_node on line 119, but without a corresponding object
release within this function.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 sound/soc/fsl/imx-hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index f10359a28800..929f69b758af 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -145,6 +145,8 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 	data->dai.capture_only = false;
 	data->dai.init = imx_hdmi_init;
 
+	put_device(&cpu_pdev->dev);
+
 	if (of_node_name_eq(cpu_np, "sai")) {
 		data->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
 		data->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
-- 
2.25.1

