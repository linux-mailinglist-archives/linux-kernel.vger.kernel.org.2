Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE639E73C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFGTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:11:07 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33500 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhFGTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:11:06 -0400
Received: by mail-pl1-f174.google.com with SMTP id c13so9293230plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FzXIDnzKXRSrBY8Kk8hJH7reALJLs5lmYw6nUaN5uc=;
        b=t+W6xrNNSjfNOCvYsUQEVXevI7eJShRDECWAbs1R/BLAVY7EagUS1iKwYvm7b0WGiv
         dMiKzZPgWq+qHj30En2acgVajhuR7W+4xbwBkfnRjutecmsVPMRtRQxYMGK/zRxzz7w/
         /H8ElvbZssb7d9PdDeUPK4hDApDfyWSFBEpL5G96l4Izy/GiERnZ6KCk6sftRXt/5fjf
         7/tF/heBi8mM4YY6vyruyl/svuMdbQJspgPOVNb8q7pRWwEtyZvp8b3SJNbxyuxvG8P2
         DqxsomQNaPgULs5kkEyeMpqj+FOD8p0VpQAU8RowUegwiUbwfWUbKQBt05NNby2HcKIq
         0vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FzXIDnzKXRSrBY8Kk8hJH7reALJLs5lmYw6nUaN5uc=;
        b=VR8zu+jTwZxmS3GRNvaiuUbXTavkauH+xTtytyQe42xVEr79IykxqJdybycEEl+79O
         lbKJJkvFKCanDYkK1FvQ3yEY+nd2Aw9+xfnAO205KEEMdsmxp2H1uJXbT1gAtAcPUOjQ
         TYB1NfmZNXJiyQIAdEqjsaOneqvm8WvPa6KGsUPFF2jSWuXXNfk6gC07tw8t2z4hFOA5
         +VD9HD9s07XT+40pvvG7u5LEDWkdFvK+2guQ4k7rGTp7vBu6Vn3XCq6Udjco0j4QVcqz
         yZzfr6MsWZJ1zOnfQtmm9DckHL77WZw/kFdVvxhtuHEv5YREAIfcHx1s24gmGPxWoxMx
         3Nkw==
X-Gm-Message-State: AOAM532OW2ijpH7Hm9f/Ip+iF39whFo2sJtsTrEp/9RE+q3H9LZc61BH
        2z5K1Y/avX/E2v2912TJPVYCY2n8o3tKKg==
X-Google-Smtp-Source: ABdhPJwDxcNV9QzGcvVYMSqvZD5/AXHA6iscVWHj+JEY65hjgA3g3ZzFMc6bqEz+LF3TW+VyFm0RIA==
X-Received: by 2002:a17:902:8a83:b029:10f:45c4:b435 with SMTP id p3-20020a1709028a83b029010f45c4b435mr18173780plo.17.1623092894407;
        Mon, 07 Jun 2021 12:08:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:a09b:9c7c:331d:38fe])
        by smtp.gmail.com with ESMTPSA id s22sm8588876pfe.208.2021.06.07.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:08:13 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] drm/rockchip: remove of_match_ptr() from vop_driver_dt_match
Date:   Tue,  8 Jun 2021 00:38:00 +0530
Message-Id: <20210607190800.3992-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot throws warning when CONFIG_OF not set.

>> drivers/gpu/drm/rockchip/rockchip_vop_reg.c:1038:34:
warning: unused variable 'vop_driver_dt_match' [-Wunused-const-variable]
   static const struct of_device_id vop_driver_dt_match[] = {

Fixed it by removing of_match_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index ca7cc82125cb..1f7353f0684a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -1124,6 +1124,6 @@ struct platform_driver vop_platform_driver = {
 	.remove = vop_remove,
 	.driver = {
 		.name = "rockchip-vop",
-		.of_match_table = of_match_ptr(vop_driver_dt_match),
+		.of_match_table = vop_driver_dt_match,
 	},
 };
-- 
2.25.1

