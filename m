Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D43983C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhFBIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFBIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:04:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C1C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:02:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so2981098pjp.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02lHhfAhDq/BBAvi74B9e064tWGyy9vbCO1eroU+qno=;
        b=u1ryXFkSvsAEYZ+uPIFhIuVePkCzK4HehzqpdC8Am7BJaL2NRh9dd3nf+LP84yrNjJ
         NAAOuESPsyd2JOuQLAd3ayAEwFD9FKCorwfKoOppIcTaalwONFEH3Rl12W0n/Izr0yvP
         9scM2jz5fuiagQv1RMDEMTKqrLzkrOyy4Z9EJ5alV+R83ZfzkqWQi7tiBRjj8VSqD1AL
         YEEpsmzacHB+1WU6VKjkISsDc2lPfhO3GrnwDQArvXgdxZrM9a+lN9/dC1+P9afew0or
         ubUQNM5Wy5VpBUg40daz+kEBDePJm6/x+3cXcP1hKsjQnKtCletrvGZP1IOG8zH1LN4o
         GdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02lHhfAhDq/BBAvi74B9e064tWGyy9vbCO1eroU+qno=;
        b=QfL8g6WI7jhE7hBwupVUG7Oeb2Iiz6ljpsGhTEEJZTyaCnsrTA7KBhgmDwz3yZQxlh
         2GLF1EkzLJ0PYjJK/eZDWHFKaJLHFkRpRjkFAWPcYYHgldg7mycUBUbVXegtV/HcZIAb
         hKXwPIS9ai88MJXuaB7W5ZmJJIxQXUs4by6BYM8ymebSDxDZyTcblcwfdlA7HbIyp2ED
         Xa522WgWgRIlNq/TqudexsP7ocy2MRQVqgUwpmv/PTLoUEy8n5jJdZdmPMoKm2RXSYt6
         vsS4QhK2cKsQmVCa862DemJddJWBiXATRUd+KvbRkGPAqS5YU74HY5Z0Iuynv6bTvdUN
         dDCA==
X-Gm-Message-State: AOAM53319RxnxSYebUUvjxaZkRwDcn6rh/KaaB8/QUh67N8KrJT1qRm4
        XkP2Xsw4cpPw8KXoowoSRZk=
X-Google-Smtp-Source: ABdhPJwZj521mEUfCJQhdlbkixXBugXjsDZMrppxRTIFdGees+XZ69j8CuVFihztyyqUBF4Il/siOA==
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr4355874pjb.54.1622620947943;
        Wed, 02 Jun 2021 01:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:2df9:2568:9194:5f9])
        by smtp.gmail.com with ESMTPSA id h1sm15379903pfh.72.2021.06.02.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 01:02:27 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/rockchip: defined struct rockchip_dp_dt_ids[] under CONFIG_OF
Date:   Wed,  2 Jun 2021 13:32:12 +0530
Message-Id: <20210602080212.4992-1-jrdr.linux@gmail.com>
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

Fixed it by defining rockchip_dp_dt_ids[] under CONFIG_OF.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index ade2327a10e2..9b79ebaeae97 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -454,12 +454,14 @@ static const struct rockchip_dp_chip_data rk3288_dp = {
 	.chip_type = RK3288_DP,
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id rockchip_dp_dt_ids[] = {
 	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
 	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
+#endif
 
 struct platform_driver rockchip_dp_driver = {
 	.probe = rockchip_dp_probe,
-- 
2.25.1

