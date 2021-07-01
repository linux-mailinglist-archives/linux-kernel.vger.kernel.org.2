Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B63B9355
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhGAOax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:30:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9DC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 07:28:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c5so6056426pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCgP763lhHmu2Zi9rE7V5pAQrFC+jTrogD4P+Vwy7DI=;
        b=i46/qIP5TjrqiOY4TvpqCWNlERAIoyVjth9QViWTorv91EwQq/p1kyWMt+g4B6ZCkK
         tm3ShyjOm2L2kPjOTEhR0JeueEhOyMXexcVAWxM/srVSyLX1EhSwqu2GFiK9Smvg8Jbv
         D0BNk95l7VcWxj9YsApSRg4oUt6IwgWhBNfpDzyMNRIuYrJQWW1YBlynLu2AAAdBK5n+
         xO1zkzx82iptjsDAcLX5NJ5wu0cCIcU8Pfn1PFEvT0cKENHsGQDnZWCPLzUgCgb2xOkG
         4UBSlMgDGTF/8xrv9C0y5ediIM4svMs8acdoAJJpaOjrfoBiAInLsAtmHp1Ks+5AbqoX
         cvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCgP763lhHmu2Zi9rE7V5pAQrFC+jTrogD4P+Vwy7DI=;
        b=Jbx6fm+yLmCsb8U+ePHTui7ovR8mFJgQ1Jv666EHSgRqS7Zv8tAWtzuAgslI0oI1/1
         MB6V99+Tb3jxUU3r70H+kkSmO00Soxb8CVPMavywBWbF72e9IlQrCS6mc7ROOCqiuwMM
         Ur9rY/WpMlm545rGwfJeXa9T4rbB84Qbo6kA2HwpIv0KvYhg3+D6A/+10FKpWcu3geOk
         3KjcjF4gipg+9gd+5UsOU8i7DwoLtz2P4neUXgOPmX4v/2kDjPYSmLWZOI2oNNqiLxGZ
         VGnIBY9i4jNi+hYmNo5YS7hL2PQqpJFdOM41oBjKOSlSHV+gmsu+880kKQI56JJ1959B
         YxWw==
X-Gm-Message-State: AOAM533FNpfn043JBS/5syUulpW0iaAro4rSQ0S89FJFMZjFcwfSB8oj
        uMk+eozQ3sFgr17XV41UzRM=
X-Google-Smtp-Source: ABdhPJyz4xlLKRPuYbJ26xKiV6i7fzmTIkLBZoegoxJ/RIqDZcO9c4Rgvfxwt75f/kM/O0TbDr/H5g==
X-Received: by 2002:a05:6a00:23d0:b029:2de:c1a2:f1e with SMTP id g16-20020a056a0023d0b02902dec1a20f1emr1642pfc.60.1625149700331;
        Thu, 01 Jul 2021 07:28:20 -0700 (PDT)
Received: from localhost.localdomain ([61.98.234.207])
        by smtp.gmail.com with ESMTPSA id m10sm180307pff.215.2021.07.01.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:28:19 -0700 (PDT)
From:   Jeongtae Park <jeongtae.park@gmail.com>
To:     broonie@kernel.org, ldewangan@nvidia.com
Cc:     linux-kernel@vger.kernel.org, jeongtae.park@gmail.com,
        jtp.park@samsung.com
Subject: [PATCH] regmap: fix the offset of register error log
Date:   Thu,  1 Jul 2021 23:26:30 +0900
Message-Id: <20210701142630.44936-1-jeongtae.park@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the offset of register error log
by using regmap_get_offset().

Signed-off-by: Jeongtae Park <jeongtae.park@gmail.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..2fc826e97591 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1667,7 +1667,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 			if (ret) {
 				dev_err(map->dev,
 					"Error in caching of register: %x ret: %d\n",
-					reg + i, ret);
+					reg + regmap_get_offset(map, i), ret);
 				return ret;
 			}
 		}
-- 
2.25.1

