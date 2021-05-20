Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5738AEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbhETMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbhETMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384ABC069144
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q5so17385488wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMsBteM78sLZWfgoifTN7rbSr2W6UwGZKOyU98K9lCk=;
        b=xSRTCGcu0REc2dYZptHzRuhKcPm1H9u122v4lhRKXyyiFVkdAZ9ovsqzg0hnRDraB9
         EWpa1FP+mB8V74m/438XjQgRMh12C4wJDZOXXAyT95kTzjJcjjif1wZD2jhNcCdRTjhd
         tF7R/BcntVQUtUCaVo7NC0MbSwRBSKMWSh7YpUvC5JFpxLIbSbu94EIDF02NiLluUZ0a
         VHh+ojVGIH3DrkTiXBQaXbcwkbxwqPsGadxZ0qLQaM516IeuW6uqAMLkog+qKJBgk2an
         SfBbPaIr/eVlm9KBGjm5w6y7cZqfj/57En6BsfmOg0Vs8wdAxkgGLL3RZx5JkD93NL1w
         Ww1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMsBteM78sLZWfgoifTN7rbSr2W6UwGZKOyU98K9lCk=;
        b=MIysDIf35koH1Nj3fhC35ZwnEdhYXy8URU1SQaui+gbFHSsDvplWGjun1wRNOPYyqr
         ioLigUwr3d2OzxcN6flMljtgD5h+cDej7xPtEizhZMWoyHYa55GLxY8MH916PeNDVqik
         aC5rhprFMAj6qQAy5NjBE/Luzwlf6fSphiFX8wQYuwWQp863wj3yif5+F/hMzxKx6Edj
         UX4hXpdm6ZAxsjQzyXOe1Aq2Xihbgr9pgzd6n5x4sqFtpftVW+lIPyvrI1XZkc3sS2wf
         joE8HS7dG8hRyGkC2Y4j1lHbPDTqUKafpt8QiHvqN5d/G3OnysJfY67vSFMFuopSHJ3L
         OddA==
X-Gm-Message-State: AOAM533r9jzJ096BpbAy3TqQvPQdlmPWNA6yJB8IF+nq+iWZ9cKTR4Ll
        mBv3kNIuG8N7Gysz93dMS6etqA==
X-Google-Smtp-Source: ABdhPJwyGDhnqi/8RHVMK2lWOHVz5VhQxaBzjq2jtP5sUVYHgFuD5cjW3Am5cCQ6JmYxEbj+vwnwHA==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4011768wrq.2.1621512218851;
        Thu, 20 May 2021 05:03:38 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 36/38] drm/amd/amdgpu/vcn_v1_0: Fix some function naming disparity
Date:   Thu, 20 May 2021 13:02:46 +0100
Message-Id: <20210520120248.3464013-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:775: warning: expecting prototype for vcn_v1_0_start(). Prototype was for vcn_v1_0_start_spg_mode() instead
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:1111: warning: expecting prototype for vcn_v1_0_stop(). Prototype was for vcn_v1_0_stop_spg_mode() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 0c1beefa3e498..2c9af18683feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -765,7 +765,7 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 }
 
 /**
- * vcn_v1_0_start - start VCN block
+ * vcn_v1_0_start_spg_mode - start VCN block
  *
  * @adev: amdgpu_device pointer
  *
@@ -1101,7 +1101,7 @@ static int vcn_v1_0_start(struct amdgpu_device *adev)
 }
 
 /**
- * vcn_v1_0_stop - stop VCN block
+ * vcn_v1_0_stop_spg_mode - stop VCN block
  *
  * @adev: amdgpu_device pointer
  *
-- 
2.31.1

