Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0186E37FC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEMRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhEMRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:18:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g13so20281120qts.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtcWXueKeAtIy7pr8ysMAsDhI84/bQavYtJj4cDVdxg=;
        b=XJaZw0EIaBW/QFexRuVnVyBbRmNCRJ2gJtFJ6vLkDp4n14A1Y6bWlnc6ZR5L0DVZG8
         X75BViMl3jg4gOdBBtTGwgtYR37li3MzpCTRnm4m3LethmNnNqUrSEiPqoNwpFesXGXa
         hiuTiCGqUi4uwNJ5OVf3Hb7AIFgT04OsRO3pbLxgXV8V1DmzxGWtTd7CW7gOu+HNit8O
         Vrtrw99qFaE/aTAlcrUJEvBCPWqEcbID/UNmgAJ7Xh854aSdDAPZ3/RtFS2brZ8+j+/l
         4TbzE1nuVZnx/kaMKcAOqL8g8K9ShjvQecZ4TLiyWIHYSuZ1vCVClO+C1JCVfKaKE07N
         e0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtcWXueKeAtIy7pr8ysMAsDhI84/bQavYtJj4cDVdxg=;
        b=n3UmJ4A5GH0Gh/UxXZqeeRCcmo1WBxtglIgTgWAovlXbBapGVFjU4hijxR4Oe8RHfB
         lxiepHpG9W5LqSUwmZ8c8MXx8tBgO+NIDJQIOBHDjTTbuxOqppf8yZiw4YX8+yELIdoD
         0wdK4wk1DyJMUl9P2z8geBscqE1+sMXXBOgnE7pCrUTaih3/9dJH82mEEr4Ju6vHSnt+
         Mr5WfHoqsRuDGImbABOtPPK/Q/Mu1U15+hLg4ZONeBDJW//QGiAIRViIxSHOKkc6AGSx
         eTE2Xffb2zkoIUSusr7sO/idic5axKsoF9S1qB9OnWyM6Ssq7A+0tPpn3EqL8jlyT56P
         ZvUQ==
X-Gm-Message-State: AOAM530ieQN5QYKiwDULkvfSmxL9f6RPFmnKMBhF8sJgH/rXy4x9JhNm
        QT7eN8kETYfi1WOyuCbUMl9PZg==
X-Google-Smtp-Source: ABdhPJzvUuhCGoKvD75q243OUY0ynqEWiKx0cDPEphR/pkhflStoU/KRIs60dR7Z4UpNDm+m3/n3DQ==
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr38430161qtu.295.1620926265600;
        Thu, 13 May 2021 10:17:45 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:45 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] drm/msm/a6xx: avoid shadow NULL reference in failure path
Date:   Thu, 13 May 2021 13:14:00 -0400
Message-Id: <20210513171431.18632-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513171431.18632-1-jonathan@marek.ca>
References: <20210513171431.18632-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a6xx_hw_init() fails before creating the shadow_bo, the a6xx_pm_suspend
code referencing it will crash. Change the condition to one that avoids
this problem (note: creation of shadow_bo is behind this same condition)

Fixes: e8b0b994c3a5 ("drm/msm/a6xx: Clear shadow on suspend")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 909e3ff08f89..ff3c328604f8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1284,7 +1284,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
-	if (adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami)
+	if (a6xx_gpu->shadow_bo)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
-- 
2.26.1

