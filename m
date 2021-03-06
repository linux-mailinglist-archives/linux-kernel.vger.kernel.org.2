Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BA32F972
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 11:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCFKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCFKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 05:47:29 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A0C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 02:47:29 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id l2so3103615pgb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OVArO45cIFAZDllkGVnvJRDcrMzTd8kZJ6zshsC9EY=;
        b=cS+ut13MTQYqZC81q17e6WqC26TgE19vcCvDknXlTxQN/o/aOdlCMKbh1WS7MF7LrO
         MGpVAK9HQhFi+tImfmnY69TGVP3cjERsOmtegbYTchJy3SQyrk7FO3CmQDEO0idwbAen
         r+zfjxTdYYI0qxny+Wkr0B41QRWHAYywnT6DXK/kgqFswlcD9z81EgyG0Bc2NDr6/gg6
         JCV7ttYE0yEPud/xNvmx1iG6aG+e5c43xw7432AfpOtR0fbuO9Ag91sxptBdWhetCc3W
         dntq/r93iMWPmTNvVLUedJRUxO0fZI3L3zQD640Xh7TBlwYJs9Zm8xFaWSF8K97kDY+z
         bXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OVArO45cIFAZDllkGVnvJRDcrMzTd8kZJ6zshsC9EY=;
        b=S7TNuo8cl4giM97843jSPSN93KTlE/60K9SLOS1aVcjNRKg3Vb7qvakppFke5yPLPC
         +D8AkVkkgHSz0SJkqUT2w1zG97fSdhcW5sKe8wgANMHG7wDXnIQSoTbzTmQhs2kbjNSL
         hMiX9oon76kdACgQYX5iWQLkPyouXbLh3eoJ05D2bSkAG8tSlHC9nLb5UGUFSJ2moBzU
         XxNOLNlkrjj73VRi/3X/jCX8GpWQFZ+EoVztOrXJF8EZ/ZWOgoMVDAl48GYiiPVYjkMu
         QRPnK9q1N7XWczThWQtyOONRvar/sIFecHaR7Bgf+drsVsO9ObJz9Hfi+5U/i7MnR8n4
         9hsg==
X-Gm-Message-State: AOAM533YlBRQax5Gumw+KeIrL6vM1agOvnJw+nN4674WYmwrK3G+22jg
        /qo65HU8j26tY5N0PVu8xUs=
X-Google-Smtp-Source: ABdhPJyjym9wsWQn1eiIbQ3l+me663Tkn6GiPbKErmB1Gshj4oPC5Bw8MUW2B9eaGSZMPxxLNd8Ycw==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr12188962pgp.139.1615027648964;
        Sat, 06 Mar 2021 02:47:28 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id o62sm4677955pga.43.2021.03.06.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:47:28 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     sunpeng.li@amd.com
Cc:     harry.wentland@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nicholas.kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
        aurabindo.pillai@amd.com, stylon.wang@amd.com, contact@emersion.fr,
        bas@basnieuwenhuizen.nl, Bhawanpreet.Lakha@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] drm/amd/display: remove duplicate include in amdgpu_dm.c
Date:   Sat,  6 Mar 2021 02:47:20 -0800
Message-Id: <20210306104720.215738-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is duplicated.
It is also included in the 79th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3e1fd1e7d09f..fee46fbcb0b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -44,7 +44,6 @@
 #include "amdgpu_dm.h"
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
-#include <drm/drm_hdcp.h>
 #endif
 #include "amdgpu_pm.h"
 
-- 
2.25.1

