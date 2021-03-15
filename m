Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFF33A980
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCOB6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCOB6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:58:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:58:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s7so30279963qkg.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEq1nIOHRCQkXvtkmDo9v/3Ggs6bIqM/j9NOZW0701k=;
        b=QyGrYx8/LpnaR1V4o6lf3/SZcBVHP++EDzVR3Owqy/86npDEO/9bcpH8DZDb2M2c5+
         4hGA2rQGZ2fNGXV80UJ/iDPjwG78p/eAZ4RDposli0S0n4GXjrXaTJxUC3fMfgojHA1+
         iw41PR9FgXLTsd1vcOVREj2+6NAJVBTE4lRnuscv78bIVx/ph4uDKR312SkcaVE4FThG
         t6pdov9/6GCTPePScJ3rKiXa9d2mWuHl83+g4aRB3BxmEbchtnAiA6cTKdagc861o1ZF
         7jNAtgsGk+4blGLPqDIUYdLNVnKgJCmSNqwjaUEMQnS552yx3mOf4QdzFFl6dpiZvI3I
         D49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEq1nIOHRCQkXvtkmDo9v/3Ggs6bIqM/j9NOZW0701k=;
        b=MipWk+xqK3x98jlVTRjitdYGZowTenwbbFXaivUSFfO//UYHVJS0YlU0wuttfzbeVE
         dR9avkfceMhM+BB89ErPxYGBNPc18gVOWxy/eq54FwI6uu6UBlYJ1FCZNLtBO4dbQuxK
         2MMtVNGIcw5YqclxY8LTzAWuBls81fdiBu8jQVAXmjp8DYtZ0aVGV9EHSXLKdeokiXkV
         j2DK6LfW/9foJS7hZXUr+Tv02bgndNaBBfEYhLowUFeb3vYSCb2tqtagRe6pfEnFsojc
         u6fFXwxiRauYt98ZherInebpfBJMv1RPPBDnWlsH/qCdGAXV6a9hig60tIPCio7BB/kr
         5K+A==
X-Gm-Message-State: AOAM531pmWDtbESf5SX/PSlsejMRVK43Avr+yWHUlOGU6YoxSzBURK/a
        H9UFBltF/rOLGp18B7IeK+I=
X-Google-Smtp-Source: ABdhPJwg7PZYKtG8jV8HRZA19cx6JKKvFePrWIHclNm9sk2Y4WwBnAcQWYCGIPYUcI/wfugFhPt8WQ==
X-Received: by 2002:a05:620a:1645:: with SMTP id c5mr22321100qko.63.1615773485066;
        Sun, 14 Mar 2021 18:58:05 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id v35sm7516936qtd.56.2021.03.14.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:58:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, Hawking.Zhang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] gpu: drm: amd: pm:  Mundane typo fix in the file amdgpu_pm.c
Date:   Mon, 15 Mar 2021 07:27:48 +0530
Message-Id: <20210315015748.1380807-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/maxmum/maximum/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7b6ef05a1d35..7af74d236600 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3143,7 +3143,7 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
  *
  * - fan1_min: an minimum value Unit: revolution/min (RPM)
  *
- * - fan1_max: an maxmum value Unit: revolution/max (RPM)
+ * - fan1_max: an maximum value Unit: revolution/max (RPM)
  *
  * - fan1_input: fan speed in RPM
  *
--
2.30.2

