Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1F3410F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhCRXVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhCRXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:20:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7773C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:20:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m7so5431783qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OQr5EWF14LJSJDPiUoRbhnzYOObAaD7LteF3BV720o=;
        b=BH2GYsC7xrZSawjjvrKi7E1Kc0MBUY8y3HbDcq5CoOVdgvAqd/ZFIB91Cgc4k24rxm
         Jzwfs4OmkG9SSzow3D9RFnInet04tcVAHbS/kvSsZo/n3wxPB0ZblXDe3S2OibEmd00+
         2wsux6NTtdhAS8FBJSVsSQ3LhL8Gz6KcRjYaQRvxrpQ/CdLD9OilEIqqorp2N5IIlFgQ
         vSfj3p9QLGIcCjJ3T6/sZS8Wc6WdrI2KjRy68H3dlh3MLK8Tuu55nd7bh4U3mJAvrkV8
         mietxE68ggbzTJUQQQoU3iZg2WPP9J/kj8U1ZCpLkuFHBhwTnOAJ+EVDGJfNYbTOR4C3
         OztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OQr5EWF14LJSJDPiUoRbhnzYOObAaD7LteF3BV720o=;
        b=g0dyJZ4HV40/5lNfl2Mzd96x5qjprCEJ9jHrjCJmk9OwcNKaqMvbjTvZL6iIDMaW2c
         hd3jSKSXqzjLnczElwXo15r0HbwtL8hjueZ59Urrpo0FtbWI5M/xgZBxVZqPlJe8j7xa
         vP//9QxKu/i0KuygqWdN6c7IYONmHIM3CNsEMGzlU7MYq6aFD3/jbaLyVMW9H7X+BBek
         M9vWa08eqd7TTXE7GgF01U03cw9rI0heRXzz83DmJeCJvYutwf5g05MSNRtl4+2lzICp
         qqqGX6m9l1DxBDf0Cx07TcPhU0kTCz2OHrz3T4PIJrPGvGqoqUX6hV59jHSrtqnBkX5G
         m+7A==
X-Gm-Message-State: AOAM5308nPh2VrKDlp11gEYhD5dzUmWXdGM4i2fukdh0ncR9NqqNuC6O
        xIEEJiauNREsQsV15DSApZg=
X-Google-Smtp-Source: ABdhPJxfhehGR5xA4asaV7R/Ng3L0bjA7nfBuq/tPpOKrgowt4gEhjUFzXDP4Br4uw7hPIybSiRzxg==
X-Received: by 2002:aed:38a2:: with SMTP id k31mr6157793qte.187.1616109630065;
        Thu, 18 Mar 2021 16:20:30 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.63])
        by smtp.gmail.com with ESMTPSA id b17sm2438571qtp.73.2021.03.18.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 16:20:29 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        John.Clements@amd.com, guchun.chen@amd.com, tao.zhou1@amd.com,
        Likun.Gao@amd.com, unixbhaskar@gmail.com,
        Bhawanpreet.Lakha@amd.com, ray.huang@amd.com,
        Jiansong.Chen@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] drm/amdgpu: Fix a typo
Date:   Fri, 19 Mar 2021 04:48:15 +0530
Message-Id: <20210318231815.19546-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/proces/process/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bf3857867f51..c1d5a3085bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -598,7 +598,7 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 }

 /*
- * save and restore proces
+ * save and restore process
  */
 static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 {
--
2.26.2

