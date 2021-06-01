Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBB3970FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhFAKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhFAKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:11:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:09:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i5so10356784pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9TQCjSk6qjzQInZaTzGIIT853Ru8WorkvRQwfDFQFWY=;
        b=Guc7yUhhkCon9MON1Y0Cs6oNBGVSC2TQ0Nom9FKV6NvekJOHfDM+lZ6hZo5mQ73oKF
         s+qeH5OKnLTlzj/BaspFDL1ds0wP+tMBUT8b4sIADit3C3DnoRBvzyyRBATwhfz0HlDf
         4GvDUWFHUHC4cIBIhODaLbmGtBsW7tuHfYRM4NwZF8dtS5MrlGsT93l+Tpl+ujM0benR
         wZG6b+hyYRxzlTnPspkl8s7YxxlSOZ5rhAFSAgvWECKJGlY6qzm8lCfbSV3+s8ht+5mj
         QOTQh5qU2yXib5va4B7EDqYgKVfSQwN0x0KxZvMrwQmE/xp29DNo6guNwMtR3rK/9j/O
         AFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9TQCjSk6qjzQInZaTzGIIT853Ru8WorkvRQwfDFQFWY=;
        b=Jh5VH09sG0s5RmMckF/WmdzBLgj11vjwpkmF+FAUKmU9tf5sOPhZJxzQo1M6l9eHC9
         3h4eFEN7UpVIxX4qvlzRkdWPoPLD8zDPOJaAZwNNWLaryTCRmfVwDU/LPFb6CuoJFYNq
         WG9oiq25qeQZHdmqmZyeF45f2tCOS0UIoNj3vL7Bs217/AyXJ+WYXLmVabVxGZUTURIr
         u35mirhhJovfWz3iPnvGTp8HbRKVmaDWKJhiyDwu5Np+nMOnn7Zw07NV7TqwPRJApgcH
         UXSExCXDEc09osjwfLulJvE/H672TURRRYczfrKAN9O0jp8V+HU+50lrsXGW+hS9y2aW
         oqgQ==
X-Gm-Message-State: AOAM532CTkx/PxFMOQkyU/HdAC1tqYBobI9ruTn3g90OXlGEqajtxHaC
        WwOIOFGIAl4Gb0JXedURgOy8IJB7BcU=
X-Google-Smtp-Source: ABdhPJzUSSffPNYqwHVrHvbv+E+q55z0a0smeF8d0Coosz0K0YnTOhwN7oBDsWbCp/Qon5rZWxJGRQ==
X-Received: by 2002:a62:2987:0:b029:2de:b564:648d with SMTP id p129-20020a6229870000b02902deb564648dmr21688245pfp.48.1622542168626;
        Tue, 01 Jun 2021 03:09:28 -0700 (PDT)
Received: from localhost.localdomain (1-171-14-152.dynamic-ip.hinet.net. [1.171.14.152])
        by smtp.gmail.com with ESMTPSA id g19sm12484113pfj.138.2021.06.01.03.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 03:09:27 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com
Subject: [PATCH] regulator: rtmv20: Fix to make regcache value first reading back from HW
Date:   Tue,  1 Jun 2021 18:09:15 +0800
Message-Id: <1622542155-6373-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

- Fix to make regcache value first reading back from HW.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Due to init property function always write the regval, this patch didn't affect the normal
operation. Just used to make sure during the cache init, the regcache default is reading back
from the HW.

---
 drivers/regulator/rtmv20-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 852fb25..b37c29c 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -27,6 +27,7 @@
 #define RTMV20_REG_LDIRQ	0x30
 #define RTMV20_REG_LDSTAT	0x40
 #define RTMV20_REG_LDMASK	0x50
+#define RTMV20_MAX_REGS		(RTMV20_REG_LDMASK + 1)
 
 #define RTMV20_VID_MASK		GENMASK(7, 4)
 #define RICHTEK_VID		0x80
@@ -275,6 +276,7 @@ static const struct regmap_config rtmv20_regmap_config = {
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
 	.max_register = RTMV20_REG_LDMASK,
+	.num_reg_defaults_raw = RTMV20_MAX_REGS,
 
 	.writeable_reg = rtmv20_is_accessible_reg,
 	.readable_reg = rtmv20_is_accessible_reg,
-- 
2.7.4

