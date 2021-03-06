Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5838932F741
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCFA0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCFA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:26:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965DC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:26:43 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o38so2444483pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnpC6f7BpJ8tZNLRp5Cw3z8Kw07+oTU7VTtXi15iO+E=;
        b=jq1Lw6tgvNAk9hkISI/vE38aIwoYVIf0ldffXAOzjjMLMAFsY1E1xwsn5sYNYhJMXv
         w+f+/HJ96aPz1nGb/W0K4TmbIx1yzm+KrATFMa5hlXh7tqsf2F9sdUJOVcnJ8AetWJAY
         frywgkx4ti1iVC19r6plKwgpfS8LySG8CkUb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnpC6f7BpJ8tZNLRp5Cw3z8Kw07+oTU7VTtXi15iO+E=;
        b=SIC0KivVzvPD7zJsTkr+IhEfRyfL5/N6qmJu3oXDR41VcnN06dcSp/VpZE+dp5cC2O
         95G0bIM3uCbdJfHYB9uSU+VTgv4dc0HOjf/FWY/Ap/RanLaJ4r/ZQeRTL+KheDl/FBHR
         V4WmaDiXsPfdW2kOZkxLlJtjRyEul5zgI8oseykA9TKXaRAK+wwImkj63ulYInunC/UY
         YqoD5niLE0PSlV4YgyWzbcUqm9ZUpBhGhqtE/O2rJcPLgVC1JX73/W1tViCNNlnbrWIH
         zUfA7pMHJO0ZiWEJtYs8Svvvko1ipS6wk0S/TbJqe/prZwkXDUG5UpchFjecIMzopsFE
         KxjA==
X-Gm-Message-State: AOAM532Dcnh1PVh7Fzgul7YdBUVHgCtE2znjVPRoU3DtQ8YSUowQq6yo
        XcBAYqjfA8/bNGlgAuHE4j6GPQ==
X-Google-Smtp-Source: ABdhPJzBIFwqkw60RxxzGbz2ZZTXuBOwt5iqDwSUgfGViCIoDu5mwu/y3DnzPCgRutYL0MesqDnn2Q==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr10633599pgg.195.1614990403493;
        Fri, 05 Mar 2021 16:26:43 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:48f0:8f48:7388:d921])
        by smtp.gmail.com with ESMTPSA id 192sm3608905pfa.122.2021.03.05.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 16:26:42 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/msm: Use nvmem_cell_read_variable_le_u32() to read speed bin
Date:   Fri,  5 Mar 2021 16:26:21 -0800
Message-Id: <20210305162546.2.Id496c6fea0cb92ff6ea8ef1faf5d468eb09465e3@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
References: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the newly-added nvmem_cell_read_variable_le_u32() to future
proof ourselves a little bit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This is based on my previous patch ("drm/msm: Fix speed-bin support
not to access outside valid memory") which has already landed in
msm-next. In case it's not obvious, this patch has a strong dependency
on my previous patch and also on patch #1 in this series.

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0e2024defd79..e34705d17559 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1351,17 +1351,16 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
 {
 	struct opp_table *opp_table;
 	u32 supp_hw = UINT_MAX;
-	u16 speedbin;
+	u32 speedbin;
 	int ret;
 
-	ret = nvmem_cell_read_u16(dev, "speed_bin", &speedbin);
+	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", &speedbin);
 	if (ret) {
 		DRM_DEV_ERROR(dev,
 			      "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
 			      ret);
 		goto done;
 	}
-	speedbin = le16_to_cpu(speedbin);
 
 	supp_hw = fuse_to_supp_hw(dev, revn, speedbin);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

