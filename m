Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4344E1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhKLGTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 01:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhKLGTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 01:19:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C098BC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:17:00 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so7632905pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 22:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTlvF4aJyyBVvpF5MzM91QUQSnsEWekyAttC+hNhxt0=;
        b=EL5+LlxnlvReaYBhiejsr1zFND5Oab45kcPyAjDopD22f7pDXXPd087rMz6BKug2ao
         2h25n6bt0a24gD2a9B0kEbbIDfNp4gNSKx8//L6ONNyicFNpvHbIl5Pv+zgQjm7e+m1i
         rE0OtT0ipEOW5s4IZsayNvkpb3aebdtbeHHWcr/iQcAL5Bu72OazuevJWGGzkWkDZtN3
         1HO/03I5/i/YKp1uu0l2asR+0bexVG4PIcCWc4zR3/Ga9ixF+Dp2Jmo7iZqQxBnM7O8P
         jGkwx5Fi1Dqp4biuQnmBpJXmHh5tsA+SVGPyfIvjUfnr+su/VUfV3wVAib6VpN8bbKWW
         sjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTlvF4aJyyBVvpF5MzM91QUQSnsEWekyAttC+hNhxt0=;
        b=KyFmCSpKtJ93d9Ekz7xZq07revj1bKEVjDU4e9t/wbdnTV9MB4NRdripHdnSYFr/9r
         w3oMr0cVGNfm8yleCRK0L1O0xM6YbbLfvNyM1gwZPyEfITsOA7ani3E4awVX83Afxqjt
         Vj4O8lVd/8B3724xUxa2gQorUKZPDBYPG+1ZWfAbmD7ysoDyQYHmdY7dLEXH8vCzB/Y0
         HhOBLcZKZW1bSyKio1zmRsfcSiWtnq5csaSfS3ICjDCbUkz19PBm6s5BtVITzcG0nr5a
         y+PB2HoMDbHdbKPYKlFvl3t9ZWda2lxcsYs3GaAh+lQhyuIviT22krFtVdcH7Cb3jL52
         TdcA==
X-Gm-Message-State: AOAM531p1/zbpyQjBqktJy5u1DL2rp2JIraxylMzzOeGcE1LALGuG3+H
        WaKdnNPMBVVEw6vNJQIMyc4=
X-Google-Smtp-Source: ABdhPJxkOxAft+m9QreNLLuSoiEnM7+2OnxWlWqcVG4wSOaUHimcvgfO1FMGP0U4nwVSfUeIFaVOfw==
X-Received: by 2002:a63:5009:: with SMTP id e9mr2651164pgb.346.1636697820324;
        Thu, 11 Nov 2021 22:17:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mg12sm9939611pjb.10.2021.11.11.22.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:16:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Jun.Lei@amd.com, mario.kleiner.de@gmail.com, Jimmy.Kizito@amd.com,
        aric.cyr@amd.com, nicholas.kazlauskas@amd.com,
        vladimir.stempen@amd.com, Dmytro.Laktyushkin@amd.com,
        Jerry.Zuo@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/display: fix cond_no_effect.cocci warnings
Date:   Fri, 12 Nov 2021 06:16:51 +0000
Message-Id: <20211112061651.6509-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

This was found by coccicheck:
./drivers/gpu/drm/amd/display/dc/core/dc_resource.c, 2516, 7-9, WARNING
possible condition with no effect (if == else)

hdmi_info.bits.YQ0_YQ1 is always YYC_QUANTIZATION_LIMITED_RANGE.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fabe1b83bd4f..564163a85d2c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2509,17 +2509,7 @@ static void set_avi_info_frame(
 
 	/* TODO : We should handle YCC quantization */
 	/* but we do not have matrix calculation */
-	if (stream->qy_bit == 1) {
-		if (color_space == COLOR_SPACE_SRGB ||
-			color_space == COLOR_SPACE_2020_RGB_FULLRANGE)
-			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-		else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
-					color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE)
-			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-		else
-			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-	} else
-		hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
+	hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
 
 	///VIC
 	format = stream->timing.timing_3d_format;
-- 
2.25.1

