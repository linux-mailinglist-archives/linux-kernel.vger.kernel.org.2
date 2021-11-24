Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8829645B26F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 04:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhKXDJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhKXDJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:09:30 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DCBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:06:21 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m192so1364703qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCenGapdn8pT6BA4FKRLRxExah4bAbpes3InHq8HGvg=;
        b=UawLjgDp7UuXebp108LzicGASAjyfMpWQdBSpYTCyay8pEQuUdaTl92noI/5GKMkPl
         uzjxtoE2Hxvmmhjce1XE9VK5adj0kjToackYRsvIPi1e0uGWKMHAVRKt4tfH4o7IqEi0
         TC9iq4szjHrO4XPZhsCamPu40+A7rP/2dC01+lSPyQqBRGR+TvqdUXcJSnIJxGgSTVNf
         pgQcspc3raIjtUJIXzq6fqlz70ImZFHiv28ZdjV5EN6qcb9L/01H7BMxz64TerS+cWiB
         Fnfl+KNyv54cf11oNRs7WXnFu6MrMHV1Z4DZuKaEZo8mMLYoyMFrzUaSgzwjTFPXzfdk
         HrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCenGapdn8pT6BA4FKRLRxExah4bAbpes3InHq8HGvg=;
        b=4neDFdVB1WjQ3NzcbgtS63cqqmgbnNi+e9wJ5fcE1wwKc8L5YK0Va5Gm5WYyhR8COo
         abtW+csMyxV3/QM/maAWVAcTcecNfz4LKr4Gnd5VgWeD09EFhhuN7GPcpmM6hyR8xIWV
         rbMmKDuZotxFGemIhgKMDg5JtIOCYUmkIzE8aNEFjwCkaEmfIdRoI2juTQ/FZ4ZQiJB+
         Fee2KP8es3BZAtC6VIb8vsMZgNEzOPcgCfGANULh/8ZUK80nGppYhTQL89uY3tntpEva
         rnNkKbGTJoufALvBUfAoO9ZVp4tiYENT8Myjyhs0uVmpZLrtHhtxQsl57UnvG5+B7frS
         qkRg==
X-Gm-Message-State: AOAM530gdOkb1WJw2luo0mv4+LuE1syQzk+t8L2HDs9n9sGGU+20hK2G
        6c4s90FX5adLIljnZqCvFymV3Mrz0Tw=
X-Google-Smtp-Source: ABdhPJwZTAzMHM0RV0zs9uZ1TEV8MK2HEv7somuIawMXs6UxXRsg4W9y1/otfg50ZrxFMeP2k1Gyeg==
X-Received: by 2002:a05:620a:223:: with SMTP id u3mr2434295qkm.158.1637723180323;
        Tue, 23 Nov 2021 19:06:20 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d15sm7234780qtd.70.2021.11.23.19.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 19:06:20 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jason@jlekstrand.net, chris@chris-wilson.co.uk,
        maarten.lankhorst@linux.intel.com, yao.jing2@zte.com.cn,
        gregkh@linuxfoundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/i915/dmabuf: remove duplicate include in  i915_gem_dmabuf.c
Date:   Wed, 24 Nov 2021 03:06:07 +0000
Message-Id: <20211124030607.34914-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yao Jing <yao.jing2@zte.com.cn>

'asm/smp.h' included in 'drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c' is
duplicated. It is clearly included on the 12 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yao Jing <yao.jing2@zte.com.cn>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index f291cf4c3886..5712b6b5f285 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -17,9 +17,7 @@
 
 MODULE_IMPORT_NS(DMA_BUF);
 
-#if defined(CONFIG_X86)
-#include <asm/smp.h>
-#else
+#if !defined(CONFIG_X86)
 #define wbinvd_on_all_cpus() \
 	pr_warn(DRIVER_NAME ": Missing cache flush in %s\n", __func__)
 #endif
-- 
2.25.1

