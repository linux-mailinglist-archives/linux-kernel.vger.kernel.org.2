Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A716D3622C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbhDPOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhDPOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F9C061761
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v6so41183362ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=EZGprGprx9G7TEQ68Auk+daq8vbCTAQMFTsyZFPKo4Phxj0vwWWnhuFEnSZXapOAKT
         THtuKKPY7eTB5HZr+G07ksaPqGhpWv/I38h3wy3YUFsXTZHGtn5UAvCCW+rDaGQ+sPg0
         qnsycTSyDtvv+/k5jd++8THPcSq8XE0ZqvkXHNmNQMtIyG4h0GVRs8H71GVrN92xksLj
         WUHkYR+i66WWHaxgq4KbXH8cmw0G4Fe4k0jSH77EaRzk2Q6+Nhh/QIXUi7DHa28bkcEq
         pmWJOdZEjvZovPLobeHwdyD1d75fBLv6QiyVolMRxqhWV7jviOV+Q90cSenbtYDqqeke
         +iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3+jQ9deg+F+hwlthzV/g98whTMSIMZPgh43ftXDf7Y=;
        b=ZmeQ0tIcqmLNHEAFumAVrjpfgwhuS+rApV8Fs3Sh4FN+7FPHMD/MHpGXRuanll9GZu
         YrrKaLknTa05mC7WARtn1c6lhZPmSjExGBXrJRAz02/nKgZLguVh8EURek3nChbX3svi
         o3gpWE5NHduFchNdZOm/z0LRrFYxTk5ze213sdNXARIgFbTeSev21s1pBZhz3zCNn1ou
         0sgskFYAqcg4QdS83S7fLOv+9vMyt12xVT5iJsJVUb4BEILL7G3RxIRfETjHD/I3xUfJ
         0ljn7Z/J79umrryYvTHCNq2+Wi2GG/UagNY6bPSad8j1nfq8rz0kmINBF/8Impuds3TT
         Nf6Q==
X-Gm-Message-State: AOAM532ZK7nB3A2uvfETlYo3Lrfp+otenIjG6gAggXqA4SePESNkNHgg
        P9FysOnfW6bbedTXOE6MsLPUAg==
X-Google-Smtp-Source: ABdhPJzks9fZldZx/wSb0VN/VG2NSj3lApLtnjqtRex+X74agUe6ql5EYvMhZPXct8zUnQC4X96DPw==
X-Received: by 2002:a17:907:760a:: with SMTP id jx10mr8921163ejc.126.1618583857134;
        Fri, 16 Apr 2021 07:37:37 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 06/40] drm/nouveau/nvkm/engine/gr/gf100: Demote non-conformant kernel-doc header
Date:   Fri, 16 Apr 2021 15:36:51 +0100
Message-Id: <20210416143725.2769053-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:992: warning: Function parameter or member 'gr' not described in 'gf100_gr_wait_idle'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 397ff4fe9df89..69e6008f99196 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -982,7 +982,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
 	}
 }
 
-/**
+/*
  * Wait until GR goes idle. GR is considered idle if it is disabled by the
  * MC (0x200) register, or GR is not busy and a context switch is not in
  * progress.
-- 
2.27.0

