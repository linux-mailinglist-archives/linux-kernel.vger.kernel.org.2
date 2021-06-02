Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F6398D18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhFBOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:40 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54966 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhFBOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:11 -0400
Received: by mail-wm1-f52.google.com with SMTP id o127so1445451wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCK0jqtaLc6j+lM4CKdqVnjdeawCrSThn6Bsjq7wZAM=;
        b=kVawvm9tl5zizmZlEJdZ0FnvSGVuL0luhzw/GSgmx6esjexCvNfHHyDG0z0L6UO6dD
         wgbWSIyuUW4QRNeBRJF/HS/Ri4n8Z/VFfaBWfyS9o8M+UBn/U4XGkh6ADyGzkR4ykU7U
         AvdY3RQaTeBiVKl0MliHWeJyl01xacXxCyqNaf4biEbfB2gwPyEvYYlyQa3lvTucU6TE
         ZkgBaZX6ywoFAJvV7Fh8RJijupn2jhRk1KyEtAbOivtycNORWqILYzmT84iwD3SS23aO
         j5F/28TV4fqpKqN1gCV0WLgLCzckqUBvdBEfgsEdAme1krhu5abpjnoQMKcNlWZwsCn/
         HJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCK0jqtaLc6j+lM4CKdqVnjdeawCrSThn6Bsjq7wZAM=;
        b=eXX1J/xh2CSwAHPQfBKblHrWvJXsNDY96eOt+kWIGDrRQYR7Dgsj/U+ncP9QL0An/2
         JvWbCc/RaVWssLkpbTeh/j6hOBszXu/03beF9E8asjH8/B9QUUE2qYrgwzCgbLTyyc10
         2S27YHQMVbViSjAKRmiclXmz3wnHT/nV2CYdeS0KFjaL1aTB4cswJr45CwW/Ek1ZADWy
         j0y7UY3nlvOsWVeyq+0haJCudiyNMIZtk5dwINH5lxMa6K6mMJJgNE+jnPWZk9B9ZxSG
         paIx48gspllRcw+WNHJ5EvBALje7FzvoZLReMvRlYYDWFZSLK2LGM0g7mSMKUQ5YuCSu
         RojA==
X-Gm-Message-State: AOAM532J5K8PvOnNR/D6Tar/4yfNEGBeIpgfqH/KFMmL0oUn5Zd/tfCe
        5YR1T0HjxFKwWwbPWbertybZ8A==
X-Google-Smtp-Source: ABdhPJxTtSEFhoNefmPKjFMRd2qURDi/HNEXhrSYPmBba4g0Ds6da+YzMYlZsUEsDWgrqcVTg9+9Rw==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr19646142wmi.176.1622644408057;
        Wed, 02 Jun 2021 07:33:28 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND 17/26] drm/xlnx/zynqmp_disp: Fix incorrectly named enum 'zynqmp_disp_layer_id'
Date:   Wed,  2 Jun 2021 15:32:51 +0100
Message-Id: <20210602143300.2330146-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/xlnx/zynqmp_disp.c:101: warning: expecting prototype for enum zynqmp_disp_id. Prototype was for enum zynqmp_disp_layer_id instead

Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 109d627968ac0..ca1161ec9e16f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -91,7 +91,7 @@ struct zynqmp_disp_format {
 };
 
 /**
- * enum zynqmp_disp_id - Layer identifier
+ * enum zynqmp_disp_layer_id - Layer identifier
  * @ZYNQMP_DISP_LAYER_VID: Video layer
  * @ZYNQMP_DISP_LAYER_GFX: Graphics layer
  */
-- 
2.31.1

