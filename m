Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1EE31922A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhBKSXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhBKSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:11:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:10:59 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z32so4821034qtd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p28ioQ+e9LHUnarIWjsDgJkyQXx4nxF9gGosol0T7po=;
        b=UwYtniy3iBeG53LcuIBx4wjxwoQHKPU4Rgm85/PHBTfohw6DR1WNz1AUBjcFHrv8o8
         5aHqWY1QUFKouKZNBF31XFBq6huTUxNT3ZWBGLWz1iq+e67yKhZCVuQkaKU25nTTXuuH
         PQKGNQFOGQw9gjLBXbstpBc0tYnm4HNA46wwOi6A0fCQU0/5fDOJrAzzHzl7M158yYeP
         0kll2nrz6zJ21fEHJmOEucqxuscULxP9wrO0PiVteogiepbqc51Ty8+Yfk18UfPb+n7B
         Pvt7mF9A+zzs9okPKsZSiAbqnO0zo1+Nk6pFjs21PZC26vRHduZD9m8qTsysHSojdLTu
         V77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p28ioQ+e9LHUnarIWjsDgJkyQXx4nxF9gGosol0T7po=;
        b=cwH8IW3Gr7hr6J/ZDfichs9aANinm9yVOkxhypUhMNtCwlSSRDOtOgqZ82Y9UAxaX3
         DPzExGZMJxJEhXO0NCDTo3YZdkRYTLvhCh0UkfcFv1fhGx//cOBvp2lmtlkT7WrhJiYt
         bDphV0txzMYUG1GXAdAQZ3P7GqKgG0jWSKAHlTrJ2ZOgqrog2ZzYesoa1XLMp438e9R/
         qnx042At9u32LP/NysAz+PnpuVzwr3otEFMAgesdem+i7Og4JE55ZdeoMXw/zk/B/kVI
         IgcJvsDuWqwYSkJ2zFP5sDKNahpfDvixnkj5Zbj4uvgm+DRBgl6UsUw7R+ts85NuaUG1
         23jw==
X-Gm-Message-State: AOAM531z0Q2Fou9I3IjNhjfWmk40ndjbc7MF221glD6oBPvyFHEsj822
        1BSgCqSkGVbbeGfWsIgZHVJHRg==
X-Google-Smtp-Source: ABdhPJxmKNRv94AJ/XLaNW2w9nibweQfdsOQu8zjlxout63qljBv8i0xys4lG7QLNdpAy0qCg/HNlQ==
X-Received: by 2002:ac8:51c7:: with SMTP id d7mr8575626qtn.302.1613067058455;
        Thu, 11 Feb 2021 10:10:58 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id 11sm4615412qkm.25.2021.02.11.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 10:10:57 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Drew Davenport <ddavenport@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Eric Anholt <eric@anholt.net>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list),
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Tanmay Shah <tanmay@codeaurora.org>,
        tongtiangen <tongtiangen@huawei.com>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8250: fix display nodes
Date:   Thu, 11 Feb 2021 13:09:57 -0500
Message-Id: <20210211181002.22922-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8150/sm8250 compatibles to drm/msm and fix the sm8250
display nodes.

Jonathan Marek (2):
  drm/msm: add compatibles for sm8150/sm8250 display
  arm64: dts: qcom: sm8250: fix display nodes

 .../devicetree/bindings/display/msm/dpu.txt   |  4 +--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 34 +++++--------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  2 ++
 drivers/gpu/drm/msm/msm_drv.c                 |  6 ++--
 4 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.26.1

