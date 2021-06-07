Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB539E6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFGSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:51:59 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45625 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhFGSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:51:58 -0400
Received: by mail-pl1-f176.google.com with SMTP id 11so9219147plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yUHFhWCcq/kgRCGJHT5yo1C2JrDTMIOj65kvK76Gco=;
        b=TqQyJo8zyp5yld5/QbvhnU3CAEFB28B+nTFE0duD3TYzp9FeaHLWO0XG2vdFDua6mh
         BfHOFGJrWZ/Jrq3oAS6JuQ3a2RZv8NSw8a9J1LgWfy5RQj7ZsIz15Q7Exrlu/9NbQcih
         N5cIq18cmNsh2TuHr7CZSg87Z4an02b2IyzUva+1dDTRkqJ1U5Esmyj94ktjG88r3PaV
         hpTS8GvrNDtGvzyKtmKfbWauHXWdUpJ0znEGNUDxqf7QY5qle3TbaUGITegWQG9dGzj3
         AjilalI8QsQXQcPXQBlM72MtW+WBJkUUSEFLNtch9/vAmtoMIIriGJXJYPaeabazpJF8
         Rkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yUHFhWCcq/kgRCGJHT5yo1C2JrDTMIOj65kvK76Gco=;
        b=UNhy5U6sBnk0HtO4ziYn/lvwq2WXhdLp/Q1MKxjh9j77EPAKIfyi4HwSileLJ8QHv1
         lmp3A95PPB0ufWW+WAJghKKEdaOm8ofsFEFzygznFOlO4c4tofwofCtkHqLqsgd1KUTs
         RuWHfj2ixEIYv8oMxV+eRI65KpRW3Qa+aQitF7cPIBV0hpfhG91wejvcSX2P40s/2TyV
         t1Ff1Ro0467243mRb6xWJrO1MVfPz9g+6sIr/BBYVHnqVcEKat4TAwfQ4NWGIB6TQdKf
         nf79aBuYtSH8QlrIoplYFFVfO2PClFlkYFhbuKAfiA8+zSyFVyPk0tcZY4obKApF8zxL
         YV2g==
X-Gm-Message-State: AOAM531i/7xaY7OCpeYLsV8ZBsY9NlLt1u8K2h2DhEGO0vjeOi9Rql0E
        j8+cle6CYFPOqFBkAcXm8cE=
X-Google-Smtp-Source: ABdhPJwtDWvQmpvtg2U50J55aazoPkaU18pviaJHRPmbRx1Jb7DUydJLScDmTuvMgIlA72tNanFNAg==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr22405507pjo.34.1623091733324;
        Mon, 07 Jun 2021 11:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:a09b:9c7c:331d:38fe])
        by smtp.gmail.com with ESMTPSA id a23sm8628028pff.43.2021.06.07.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:48:52 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] drm/rockchip: remove of_match_ptr()
Date:   Tue,  8 Jun 2021 00:18:36 +0530
Message-Id: <20210607184836.3502-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning when CONFIG_OF
is not set.

>> drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:457:34:
warning: unused variable 'rockchip_dp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id rockchip_dp_dt_ids[] = {

Fixed it by removing of_match_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com> 
---
v2:
	Address review comment from Robin.
	updated change logs and subject line.

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index ade2327a10e2..8abb5ac26807 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -467,6 +467,6 @@ struct platform_driver rockchip_dp_driver = {
 	.driver = {
 		   .name = "rockchip-dp",
 		   .pm = &rockchip_dp_pm_ops,
-		   .of_match_table = of_match_ptr(rockchip_dp_dt_ids),
+		   .of_match_table = rockchip_dp_dt_ids,
 	},
 };
-- 
2.25.1

