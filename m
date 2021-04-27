Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73C36C4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhD0LRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbhD0LQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:16:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE25C061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e15so4337565pfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGCi4wgyNmOswZhTsUzcguHV+B0Lp+oepbJNaLdIIQs=;
        b=eM/J7FTNEqy/zfDU2sn4V/mLvs/9ZVj7P8OeX8GYnAg1OLcd/aZi3pIJ34tMwyGLTg
         ttZdQQSMaCDyhPcEOUdUT7UqSweFwjsZgymNQ2cqZ4t4cMdUNC8ACJqw+MqWwPw3TOqE
         XFZY6A4SL+Bh4dfHH3MxZaUUhPfMk/rCzWt8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGCi4wgyNmOswZhTsUzcguHV+B0Lp+oepbJNaLdIIQs=;
        b=o0Ck1xe8utyf7ttN8/RVlEez+v5F9/d4Dc+vUi2AOQpR6CVWpvVXvXsTU9JbnAcNgM
         mOwC3CQGgpaptYISuh0tEYt9mWBx4DLmtZk2myLzC+g1nTzHM10n6bvJZGmBPG4lZ6j4
         u4l48kp6Q+0d1gzleN4b5NsV8jCYMJdzqKYebWNMKOt1kA24S/r+JAnPmbL0kmRPcdEr
         BLMmpIlZ8AQvP1s0HwkVojQyoOVGOwMyUFml2FvkOAt8QoIpq2CowQ4eUSD2XA0d+h42
         FRAisDlluTYdRCW8IljSXUW2BvGTnr5Sj8lPVQTH3FM3WcrN8f1S66GTAbwol9bTEsUM
         2N0w==
X-Gm-Message-State: AOAM531K2EmXwOuURm7qvZ8w7P6bAUb34FaAYdieXrtrDW0gwpeSb8I9
        Q6LaMhAHoXl3H1iC8tnnnJtMOQ==
X-Google-Smtp-Source: ABdhPJzMT5Fck/ahyuMY+JNQxL/9oUgdrbw/UDDbspnGnAl+oGo6sz77U5W7LGN1CgNLep74HZAJZA==
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id g136-20020a62528e0000b02901f5c5eea487mr21962939pfb.7.1619522161753;
        Tue, 27 Apr 2021 04:16:01 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:b182:d363:32d0:53a2])
        by smtp.gmail.com with ESMTPSA id c21sm2347210pfc.165.2021.04.27.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:16:01 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 09/15] media: mtk-vcodec: enable MT8183 decoder
Date:   Tue, 27 Apr 2021 20:15:20 +0900
Message-Id: <20210427111526.1772293-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427111526.1772293-1-acourbot@chromium.org>
References: <20210427111526.1772293-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Now that all the supporting blocks are present, enable decoder for
MT8183.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
[acourbot: refactor, cleanup and split]
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index e942e28f96fe..e0526c0900c8 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -383,12 +383,17 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 }
 
 extern const struct mtk_vcodec_dec_pdata mtk_vdec_8173_pdata;
+extern const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata;
 
 static const struct of_device_id mtk_vcodec_match[] = {
 	{
 		.compatible = "mediatek,mt8173-vcodec-dec",
 		.data = &mtk_vdec_8173_pdata,
 	},
+	{
+		.compatible = "mediatek,mt8183-vcodec-dec",
+		.data = &mtk_vdec_8183_pdata,
+	},
 	{},
 };
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

