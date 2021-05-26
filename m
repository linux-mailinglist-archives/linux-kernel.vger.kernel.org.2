Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75BF3912B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhEZItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhEZItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BDC061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z17so197805wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6noTtcFdzAM4mRtKAmNKqowB17kNzJ46dcIfcnLdMB8=;
        b=RZRDWvzHNmKISbyL/y7tncGD6OlregtD8vbp5d/rmc0PNGq6sghfzAZpXIe2PuELFw
         Bl1gg68glEy2naNn9LnTRH2OEEqMjSt2RTKm/7jbmXscdFxuK8CWcUGb/vXCoQfWtJTk
         /aQCyRZ9whXV/5z0rECrM+Xhv7rb8OCYw5pWY7z9cnUp9F4RSx6QshjN30+bDnJ7f5/U
         FM45gqEUoo98DgxJer6yTzB/Razb2X3ch0zQNmp85X4rpnSrCDr8+ICEhSO3EPBjU5of
         GQMhOB5m59Zl9sLle9jZmHDPMyzPnptje0Xt7a9qjMhnYHHKm1eSSNeIPMNm2d2PrSMH
         boSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6noTtcFdzAM4mRtKAmNKqowB17kNzJ46dcIfcnLdMB8=;
        b=HWplH1jbgTYiL5hGWpEkAUojg2eplBycI5Cx4y6mWKHhjdN9dqsMMpqtyPt6l4xhyf
         T88Jvrsm1k6OBSmXYe+9iLCFu3+Tbo0hkppQ2PZt2b2Qxz+ZVsnq0zoPa0qXEjS44UBm
         JuJpo+PRvGmygVNEwT/UPz491tTqg2hyJUh/o2jdAmhjctpmacxfNr5SyM+9/etnbYfE
         M9SnNu9R7yZVOoNGv7YpiD2gLfu8VbQryia3tK9q51WseWJFioX1YX5WDZN2EJN4Ie15
         /0bPV6L6c2VXS0rX1UV+yMnW/HOB/xdAxXAoEgr7Q9hEZKw3UUc23UgOl+yucvjcTGOO
         8jtQ==
X-Gm-Message-State: AOAM530XZLihgvIU5hW3JzpjdGoTvOKevyKqPn9+Cp8eGKazx3Qd8Pa9
        b5/NZFiMW4D85p6+ZtLdNs+hyw==
X-Google-Smtp-Source: ABdhPJwiod43TqTsfuNXme67KiMrAR6fRFT9Vr9f58QWqFwUO+ulOBWEvlceFKoeCsGC21ORHtaxVw==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr31088295wrn.219.1622018851572;
        Wed, 26 May 2021 01:47:31 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/34] drm/amd/pm/inc/smu_v13_0: Move table into the only source file that uses it
Date:   Wed, 26 May 2021 09:46:53 +0100
Message-Id: <20210526084726.552052-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0.h:54:43: warning: ‘smu13_thermal_policy’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Wang <kevin1.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             | 6 ------
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index 1687709507b3d..6119a36b2cba0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -51,12 +51,6 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
-static const struct smu_temperature_range smu13_thermal_policy[] =
-{
-	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
-	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
-};
-
 struct smu_13_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d62cc6bb1a305..d6ce665baaf3b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,6 +78,12 @@
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
+static const struct smu_temperature_range smu13_thermal_policy[] =
+{
+	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
+	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
+};
+
 static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
-- 
2.31.1

