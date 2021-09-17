Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90D40FAE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhIQO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhIQO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:58:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE871C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:57:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so31058687edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjqYg/kdIxuTkYi0sI4jFtVCecYard36mD+kDvRG+ak=;
        b=QuoPWUTBeExD9Yyv+njE9H5YTxnkC9RgV62XWwYjuzdyXelG8ZZG/NUFK9NSgOX5lV
         p/SpC5vdJccRvPjj/7u/jOClsUV/6IuKaGa/NqoBOc9SHD8UrKhPH/K2IZTpvyMb8SsU
         Bqo/jmnWrq9z+Nu2dZLP1FOT8VCpMtFbH60L1oule0IF7ZmilZxlYW5JzIa7/xdbPlZ3
         t35GdF5Aq4cymaXd2c5RZeUURgvRKWSh/x8fF9SqXUaoRiNCfRutu3z8kvznrmTEEtxJ
         RpSo4NScvmHhkNWJ6/R6YPaNyVh/8bs7VeB2nDd7NSQk0qzkq9gd9cVUOkdIHtCCX9ND
         /pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BjqYg/kdIxuTkYi0sI4jFtVCecYard36mD+kDvRG+ak=;
        b=Qe+LCy5Lg/ztPN82DDWfv4y2Y2lIXrjc6EMFIQLwBLCdQdFIHfuwVi6iBfvizYpyFM
         fO3NmwMoR+U7KU7EbB2E+jjaH7eArnc3ZAcduFr8XO+A0ngZpLlq3NExrClV7AYgGmN0
         KOCVjNDMaCuBmywmk8WlDc/3UtnTAj9O/nDf6wCuaodJID+vC6FoEIZjhdkxWkXqI16V
         wnhutjkyXTH7Lau6aZ2ciwEe9sDbjbfvy53ypX6toAqzwgy5K2Vk2YbQwNJ44s3hk15g
         okuAhVcG+amStHK6SvdIvt1IFDzugHYw0mwKvur7UjhtxcZ1UR5zfzEWfyhLv0ATfbjx
         sN6A==
X-Gm-Message-State: AOAM531JfqW5Cko2wNDmKvJ9L9IKGyhzY7dHhX6rJtELf635klWN4nhP
        tZD6vKq2gcTNB7Lc1Vtupj4=
X-Google-Smtp-Source: ABdhPJwze+2NJY8kzwJukoJQS8+nR/sEZR0dphNK5/pdY8xAR3arPpb7pLJoDBajz/QYBhRsnqp3IQ==
X-Received: by 2002:aa7:c7cb:: with SMTP id o11mr12647452eds.137.1631890639607;
        Fri, 17 Sep 2021 07:57:19 -0700 (PDT)
Received: from cerbero.fritz.box (93-41-150-160.ip82.fastwebnet.it. [93.41.150.160])
        by smtp.gmail.com with ESMTPSA id s11sm2722223edy.64.2021.09.17.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 07:57:19 -0700 (PDT)
From:   Mario <awxkrnl@gmail.com>
X-Google-Original-From: Mario <0_Awx_0@protonmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Mario <0_Awx_0@protonmail.com>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for GPD Win3
Date:   Fri, 17 Sep 2021 16:57:19 +0200
Message-Id: <20210917145719.24466-1-0_Awx_0@protonmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f6bdec7fa925..f6177c1d9872 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -185,6 +185,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 3 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.33.0

