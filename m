Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72D433A9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCODWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhCODWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:22:03 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2845C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:22:03 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l15so7141565qvl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQcMG5LLxTg6nVFwEd1izOqUkx+QGUyBmxbcMRP29T4=;
        b=lK3AtlER+6LnsHJB5aMPze3Ua1gnhBGD44EnvsvH9T4gnS9qP9a7gPthBvg4Obzkgv
         2Wffxwga3H2+qhbIqKMizVdeWMPZ1OSugoaZP/nT4iJfX+0TDChHhX0H0+LUI0zZFYk6
         O1PPwcGEJgk4f5R+sgS9SxkzUZG7tlsTUasCEFF+nw7mGNklsNolsVq4iBYFP6MJX7MM
         pk21sMrglcsqqqto6J4uU94WzAUuR3O2yx+HTkwOz9OB8VzG/oOvW+HBti+EFTGVMVF/
         KhHbjwKi6jm45cRByW1XRnYSvJPWGzW88FK4/391k0Zk3lU2XMoA37DpGOSKSXxJSga2
         Zpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQcMG5LLxTg6nVFwEd1izOqUkx+QGUyBmxbcMRP29T4=;
        b=TjO1uyAdBQ6SKlLfmGa5dWaq5E2tqEMo0QekRj+SJcNpWtphCG/mIqSDR99N/8Ufcx
         lFJ88lb6DUCH0dldVTesLFcR3GN9cQ15pVDIfjoJJn3cbfyqMOzBHROaXfLOncWPTlSu
         2XB40N24RTz7jyzzV7NTK+pm3kjr+au/2acc8YuZn4UsbxcF1ScEH9wMoCMoRMQqXtfn
         jdJLwR92ulXPKXKynfq1qUoW2ijqydzjh3sWFrKDyIlCIpaIPSZuSAITzOkgFNHl9HEn
         L57DHlUZXAUCuxAEjL9zsQWejFU4k/b1whMkhHJgnoWyqqsNtDSyJifARXcRgrI134PC
         CL+A==
X-Gm-Message-State: AOAM533AsAM7dHtUqVeBG33xWxF3CM439z5NKHC8AwSmww9lNfSgGGON
        82mjTUGsSrLWX3VXEUC1daw=
X-Google-Smtp-Source: ABdhPJyFJI/FWkYaSq+EV0B1lGJ/91vBmhZsHYT1zGgcWinemhjAv4EbeXzw9sNtw+NTbcnBf9J53A==
X-Received: by 2002:ad4:4d92:: with SMTP id cv18mr8704294qvb.5.1615778522920;
        Sun, 14 Mar 2021 20:22:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.217])
        by smtp.gmail.com with ESMTPSA id t2sm10098763qtd.13.2021.03.14.20.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:22:02 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
        Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] drm: amd: pm: Mundane typo fixes in the file amdgpu_pm.c
Date:   Mon, 15 Mar 2021 08:51:36 +0530
Message-Id: <20210315032136.3669883-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/"an minimum"/"a minimum"/
s/"an maxmum"/"a maximum"/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Randy's suggestion to adjust the subject line text
  And missed out a spell too,which now included

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5fa65f191a37..308249ae1a22 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3315,9 +3315,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
  *
  * - pwm1_max: pulse width modulation fan control maximum level (255)
  *
- * - fan1_min: an minimum value Unit: revolution/min (RPM)
+ * - fan1_min: a minimum value Unit: revolution/min (RPM)
  *
- * - fan1_max: an maxmum value Unit: revolution/max (RPM)
+ * - fan1_max: a maximum value Unit: revolution/max (RPM)
  *
  * - fan1_input: fan speed in RPM
  *
--
2.30.2

