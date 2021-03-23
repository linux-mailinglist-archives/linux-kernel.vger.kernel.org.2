Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59253454D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCWBQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhCWBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:16:26 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:16:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y18so12790241qky.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5pECjMsM/qvstnesb/+ZKBN9a5m4sodJTA9keXe8fs=;
        b=dzSqflgkinPRl41IH6b6OavC4s0p/5zLninBkx7jvN5x0aJcq94JpIET1747IB/M34
         /NQ5JHATUU7E2Pl5dV0kMt5gdt+RQRS5LU+f/X7EDMxiVCiFXWAij/EXKpT1w/elqHhD
         rb4eZFhPkBSBN0bIgG7ZSLW7HYN7BvToY6tZT3n40b4ucj1vYqJCWZHebwuP8H10sCmk
         GsUeQdhycaM8SPxIDYfV8dBZH+S86dibxCrrTasFH78QMmsxBZl9rLfkZPoOWLAQ8eQJ
         mC1iozFhXJBE4szBqDdCTGZcdU0VjF8metQOKmbjGoQnHrYGDrl0JhzHfMNLFXszuV44
         LP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5pECjMsM/qvstnesb/+ZKBN9a5m4sodJTA9keXe8fs=;
        b=lR48NPSNxCyiZxj8NnpQMmMX2fSykpVARqnxMFTfdrJ5D6VQ5QnlVKJQLkeCYQMBBd
         DYxzoJSUbJDkAKv+4LQ5sqWyFaUbKjus3pWNFM//vhNfz5r6s3SYIu1dAkdA8e8uUS/5
         PaLfl2gN+d87n5KGemIVwo7jceWF1uhVYlxJvj5OxVKzwIl2Ma48RQ3Hr7Se6o2WUBGP
         9m02zxOVQsdKwaT1cvrLG+Ejmvp4BmaMlwyEB1Rcb8kNsrgnHqTBLnLAEJZIm9S0zcmO
         txX+owWRoi/bzIq6Z6pbSKeXacVOj8NFIVodeVaPjOq9+2K+L3qf6JEdf+UW9WctILc5
         QKBQ==
X-Gm-Message-State: AOAM530+umD5DNaBjz+otf/sVyWCn5sQir4RAvRy7zkTCZk8QoLvYLF+
        HhGnoB+q/3IcDGwRhVzrw4A=
X-Google-Smtp-Source: ABdhPJwZ/rCncMQ46/4RmOQg6AKfgCTO4VHUsa9gsBjtXTcAf+WrZsvRdMlXLSN8z2pGmqgSqMrVpQ==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr3178972qkj.217.1616462184987;
        Mon, 22 Mar 2021 18:16:24 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id i93sm10383114qtd.48.2021.03.22.18.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:16:24 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        imre.deak@intel.com, ville.syrjala@linux.intel.com,
        lucas.demarchi@intel.com, matthew.d.roper@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        unixbhaskar@gmail.com, aditya.swarup@intel.com,
        anusha.srivatsa@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] drm/i915: A typo fix
Date:   Tue, 23 Mar 2021 06:46:07 +0530
Message-Id: <20210323011607.182803-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
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
2.31.0

