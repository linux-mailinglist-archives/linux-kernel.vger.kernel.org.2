Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004AD423432
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhJEXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhJEXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:13:34 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A04EC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 16:11:43 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so281609oof.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQpkJbXdp5NaD5qxiGom/Wfq8wfmW/3aS/lr+Qb5xRs=;
        b=oqueMNzGUkR0//cRE4HSJcINwQU73pQ04AVYh5mEi30ciDFiUR7SdlfNFHjRM1fuB9
         3D5Oh6BvUVktSBS608uBVmqAPMRPeuNYY6NIcQNSApWe0jxdI85bNGZAzvVirv++hoBy
         iLzxcGCco/T4vqO1tWmBEv1E6dW6Y496l/uk3QfVWiZYZ7dL5PYkIIShrjWHdztByYWF
         7P9ydFYcXIEEmO+HpdGpkyCdbsO7TpqstsYzsAJxWvHuITuVIJ6LFeeqD3A7JuMQX1Xt
         IjTiBX3zxBQfvkKdGaWzMgv8XpfYec4Ev9IO1c2Hcg3LnOR/9VCLlX7H9EejfX2XGytz
         Gfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQpkJbXdp5NaD5qxiGom/Wfq8wfmW/3aS/lr+Qb5xRs=;
        b=74OCk8n4v9FgKVw6FXKUnONAKOz2sCfUtmdW9r4g4JlDeV1eOySieliGL10oHOFpab
         S3hxSJcKRR3ffyH0kdvmWLkEbrhhU8HdUipOMzU/Y2WnhQIr2W1r/M7D2aHdtFpm89j6
         VCR7I/iXItxSQhPqbBOu7hWi5c42Z5Enrn+LftFCHZlo+U3ng2hUSNgaRGGA9KN4bVP2
         Spas5TV4hNrPTBMlmhzzKQ8eXark0UvzVWjk8WnzFKt1W2NldK92AiVBF08NlFfLPwqo
         xiw0X6082SolH7HyhZUWl9s9kmxxXdnGXFShgPGkK0+XO4QgRDP2QZqkNNQptTOilMrP
         SbPA==
X-Gm-Message-State: AOAM533UInDrD9GVGfkGhwtlwLGWTiFXsiOqHEy9PCZjWozoI24MjJJ2
        Jnc7SbiWNoCQ3V5wC94dPvi3E7RGpCPZIA==
X-Google-Smtp-Source: ABdhPJyyWLaV9KUdV30ySmf3HQps056UZvaj3bt/VAjhu9J/UFlwoxSolCJwEnrtnJ7mikzLiPkREA==
X-Received: by 2002:a4a:e0c4:: with SMTP id e4mr15716360oot.24.1633475502788;
        Tue, 05 Oct 2021 16:11:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id v9sm1665141oth.62.2021.10.05.16.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:11:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] drm/msm/dp: Support multiple DP instances and add sc8180x
Date:   Tue,  5 Oct 2021 16:13:16 -0700
Message-Id: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation supports a single DP instance and the DPU code will
only match it against INTF_DP instance 0. These patches extends this to allow
multiple DP instances and support for matching against DP instances beyond 0.

With that in place add SC8180x DP and eDP controllers.

Bjorn Andersson (7):
  drm/msm/dp: Remove global g_dp_display variable
  drm/msm/dp: Modify prototype of encoder based API
  drm/msm/dp: Allow specifying connector_type per controller
  drm/msm/dp: Allow attaching a drm_panel
  drm/msm/dp: Support up to 3 DP controllers
  dt-bindings: msm/dp: Add SC8180x compatibles
  drm/msm/dp: Add sc8180x DP controllers

 .../bindings/display/msm/dp-controller.yaml   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  23 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  66 ++++----
 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c           | 153 ++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.h           |   2 +
 drivers/gpu/drm/msm/dp/dp_drm.c               |  13 +-
 drivers/gpu/drm/msm/dp/dp_parser.c            |  30 +++-
 drivers/gpu/drm/msm/dp/dp_parser.h            |   3 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   2 +-
 10 files changed, 194 insertions(+), 108 deletions(-)

-- 
2.29.2

