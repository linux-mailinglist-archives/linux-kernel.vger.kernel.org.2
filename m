Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76663E3DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhHICen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHICem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:34:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BDC061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 19:34:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id az7so16858743qkb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvNc8KEp40u8XM5bp+0t7D+wLd2rEwsp3dCzstYaaGU=;
        b=nlnkEnMrOuWtZqj+HBSQ8uXnTHHiGWsAH91m80fdrlrjvhbG6KKsH/L1/cCrsJCJek
         tj0YvgVhbLKLhUb3+0LoTDv0L7y1Svp/+7uw5+5T+0Erv7OgmER/988Hn4S7WL0oIrJf
         k3vkisJuJ1k+oO2hXaaVhXHA2hJSaDkHEeIZKlxF13GwV0TxXXAzId+VInnpji6lfQCV
         HClkQXSnm5+z7MpwJtWPfXuwvhcH/8bpKY7SHHUQ/dAbc8BwJvpq+qfV41ov6kmiLJLY
         2XVrsBtP+nR81+YDVYufYi5L6GUBuxVzvTdzkWbswSvuW54/tFHLjxNhNhkBaQIUab+i
         rPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvNc8KEp40u8XM5bp+0t7D+wLd2rEwsp3dCzstYaaGU=;
        b=h/K9sGydmJBzv/CWYNqnLoGUXZicPdia3IKvQXIjTy8Mig7rQFeJW9RQtD7bd+h6sH
         hmXQL/FL28Kc0kOIyDiDXxyzSTGhiT+gphLS2Agyz/cG0968r9oAqIb5U2ieVwvDYa9y
         EDbHaTM5zSYKk4tf737zT2ioxqr5FNdIpyn7c3mHlibxaNh+V3vDIFIb9DSZ7gwW57qP
         AKMkdwnSauKmRIjf+/rqyOBrh1HsGERrMBFqvi9CxPb6iEuyc0BKsO4TauAuFTMlRs8c
         KpnbtoEhMhdl2/Bo2DOGg7mXenTA6I4lrYzgioGxK4lkAcpcULFDu/JR6VpXuoUz0SQc
         q0jA==
X-Gm-Message-State: AOAM533QsTyEcUc8FELGM3YzkAtCNCKFo66YxP1QfppL1z4+n0irBTOq
        BwtXkJCAWz56lLT6rD2W/hU=
X-Google-Smtp-Source: ABdhPJzY2bUH6lQr8pQrRnAPmCymeUJuoWEhinskSxMJQ5axmW91ZJ55W+jSIReeuOVzOHoElT86RQ==
X-Received: by 2002:a37:4641:: with SMTP id t62mr20756456qka.389.1628476461792;
        Sun, 08 Aug 2021 19:34:21 -0700 (PDT)
Received: from localhost.localdomain (ip70-186-197-128.hr.hr.cox.net. [70.186.197.128])
        by smtp.gmail.com with ESMTPSA id u6sm9085018qkp.49.2021.08.08.19.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 19:34:21 -0700 (PDT)
From:   Julius Victorian <julius.victorian.home@gmail.com>
To:     airlied@linux.ie
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com,
        daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Julius <julius.victorian.home@gmail.com>
Subject: [PATCH] DRM: i915: i915_perf: Fixed compiler warning
Date:   Sun,  8 Aug 2021 22:33:42 -0400
Message-Id: <20210809023342.377422-1-julius.victorian.home@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julius <julius.victorian.home@gmail.com>

Fixed compiler warning: "left shift of negative value"

Signed-off-by: Julius Victorian <julius.victorian.home@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 9f94914958c3..7b852974241e 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -2804,7 +2804,7 @@ get_default_sseu_config(struct intel_sseu *out_sseu,
 		 * all available subslices per slice.
 		 */
 		out_sseu->subslice_mask =
-			~(~0 << (hweight8(out_sseu->subslice_mask) / 2));
+			~(~0U << (hweight8(out_sseu->subslice_mask) / 2));
 		out_sseu->slice_mask = 0x1;
 	}
 }
-- 
2.30.2

