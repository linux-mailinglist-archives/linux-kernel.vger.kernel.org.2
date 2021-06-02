Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71CF398D17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhFBOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:37 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53842 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhFBOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:13 -0400
Received: by mail-wm1-f52.google.com with SMTP id h3so1449086wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4QyaYMBoYLFq2bECv9NcJDq+15DdDgMC7JcY/MSiHQ=;
        b=ZHA4IONbN+kviuc/7VbXytRPaVxiy3BtnnGuE9xq9bBqBdkVFCTn/zFV85GqT3Mpk7
         RoiU7RBUA/zqv8ZPFH/ojovuu8ys/TwIs8hJnDW9d5sT8rBc5EDQH33XMKlg0Sla41xe
         tAqsWaYceMT96z79m6Zipp0DNqpxVxdOi4rPXeRVacyHcb5WZPeSC7WvHPUKb/5ADF6N
         xPkiFTvs2wJa72Y8kr4r/ImovYGj512DKk+WQHX4HC3ygj8mmPOMp6pgLvyFOWhWqJYq
         QP0oiKEaR63hfoNtZ2vgcAQjf9J80Naq5moBuvB4884j/3Rv+Ot6vplisPpHKYazkESt
         fIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4QyaYMBoYLFq2bECv9NcJDq+15DdDgMC7JcY/MSiHQ=;
        b=MoX+Qmu3BBJVHygcysvDYI/iD7HSjt8VDPD/C0LzCb71+csoCnGZuETJ2BiVk5sg+W
         bEpDOkxAkxUGCmfDYUO74po4SOWh9H6U3a1BRo6RAQO7AsOUr+PiFtzYrBV+xAxSPwZu
         Ve23evnPWFq74s6VjCTdGw2cLmGsh7j7epC5BY4T0J/xLWS73mxPOa0NA8+jwKnp6Wss
         sOs8w7CF/rkN3wdSNyZAcb8R12J1xz6M/1k9/4KTxQFsqn4SRfKOtCBU2+m1nkn+LTkF
         qEkqz/5F/ycbQLLFN+URnt2VkZHh858/MPSWJN9/Hni2+5I5lbK+rlM8AEYtSX2Z+IjO
         A90Q==
X-Gm-Message-State: AOAM530vGTi9rkoOAJnpYZKk6wlatfduIAJspxPT/NUO3wwcXN1QMtLK
        5vFjrWxnrLJPCWtsmL+jrNvkvEuG7YUkiw==
X-Google-Smtp-Source: ABdhPJz9yQsFXiAFF7uLV3aeeBapyXs4piTHs0jC4AWBx1IuzK7GHp9xp5K+NUdA8RoxwTP+oOfcYQ==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr15312997wmf.143.1622644410082;
        Wed, 02 Jun 2021 07:33:30 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 19/26] drm/ttm/ttm_tt: Demote non-conformant kernel-doc header
Date:   Wed,  2 Jun 2021 15:32:53 +0100
Message-Id: <20210602143300.2330146-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_pages' not described in 'ttm_tt_mgr_init'
 drivers/gpu/drm/ttm/ttm_tt.c:398: warning: Function parameter or member 'num_dma32_pages' not described in 'ttm_tt_mgr_init'

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 539e0232cb3b4..682c840c9a517 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -415,7 +415,7 @@ DEFINE_SHOW_ATTRIBUTE(ttm_tt_debugfs_shrink);
 #endif
 
 
-/**
+/*
  * ttm_tt_mgr_init - register with the MM shrinker
  *
  * Register with the MM shrinker for swapping out BOs.
-- 
2.31.1

