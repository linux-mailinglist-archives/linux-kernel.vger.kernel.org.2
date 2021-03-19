Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77AB341447
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhCSEjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhCSEjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:39:22 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73021C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:39:22 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y5so133203qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pJOhHalCOQI7CNPLCF/MfvREiZP5xjm22JkU7T65OE=;
        b=Hv93RUXh1Z3Q+tEkyOUfj/GacorwdT6MPFwGz4Hw++Tte9u0iwDT06L+7NAmYrpiIg
         65eBbqriV1rPDWaF/HiGBGd/Pd/cWQzTuplSVdkmLCOsRSkDI3vMCKdQ6dDlv6sxS4qk
         Hp7EFbHZexEYu6QzcNHtSjYXRwsF31GP7b2BcaYgNOX67gsdSY6zMRTtqxMC/vHxrEd6
         o5Sg1xQB9lqzXL4sEmTBe4dCNPSgpxsRL/xDtvsMdWJtNddk+YnpmdbueKznCRpLDAUI
         wqAh8LEAaRPtZJvqmJME/F9yO6tgUsKmaS8muz5tXV/5MIkVDv1LI5ae1rcQWoS4yKf5
         iIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pJOhHalCOQI7CNPLCF/MfvREiZP5xjm22JkU7T65OE=;
        b=pExEJrwRsQ6tntrjTvm0qf49Dr1P7GRUc2/+TQcIXYHDgpKC+IGTd4VGloL0El4mQo
         w3msk0LYXdqmZNUec6WsDwqmYHHrxSbQeoIOZam+gZpkou8IW7Szd15wzKBDx+bHQuQf
         sEJ9czpI/s6ea4NZHsBjp8MG3Y4FalwZVAA4xQW7HhsMbd48lLfgYAPuBCv8ElsIXxUf
         3xMVXsLUDWU4kobHgKMUqNOnRehG8rUE4+nOnCD6jQpe63qtQJi3aKWyvXzN3Hjgv9jI
         +ZllwB2kjRkB0OetYtYJd1XPILJytjfpstbbkinqFeloNyaYwFJTa9SNhtMBR55m9P1n
         Ci8Q==
X-Gm-Message-State: AOAM530VXiFrsCdm4o7oXlle4fzq+PVBETUi1yjXLgfW9NooNrB3eAEH
        ERjep3ZX2vNw4TTb0CTr3oePAkMt0Z81nmzR
X-Google-Smtp-Source: ABdhPJwhAX/SxVXTbcrANn/VyOtQy7E2wW3G14TkgDUJqG0oDLj9RKl7BlGO6nXO10tgqLmxWJEfHw==
X-Received: by 2002:a37:8906:: with SMTP id l6mr7814754qkd.232.1616128761345;
        Thu, 18 Mar 2021 21:39:21 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id m25sm3024917qtq.59.2021.03.18.21.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:39:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        imre.deak@intel.com, ville.syrjala@linux.intel.com,
        lucas.demarchi@intel.com, matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        aditya.swarup@intel.com, anusha.srivatsa@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm: i915: Fix a typo
Date:   Fri, 19 Mar 2021 10:07:01 +0530
Message-Id: <20210319043701.14105-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/nothign/nothing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index f6ad257a260e..14d784a6fae5 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -4185,7 +4185,7 @@ static void icl_pll_disable(struct drm_i915_private *dev_priv,
 	/*
 	 * DVFS pre sequence would be here, but in our driver the cdclk code
 	 * paths should already be setting the appropriate voltage, hence we do
-	 * nothign here.
+	 * nothing here.
 	 */

 	val = intel_de_read(dev_priv, enable_reg);
--
2.26.2

