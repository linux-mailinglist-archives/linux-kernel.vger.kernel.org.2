Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF81C3CB5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhGPKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbhGPKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:25:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB726C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso3065893wmm.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPLjK0/F2QBKjF46wFtmvCRgoQO/Uosrsnmy5GRIu/8=;
        b=AWkE/523G18vB7RHC1qa30lulwYkMTm7IbLwlGpft2WNWQikypRT/cgwCl8b1IKHIA
         4gjTdpjLA0ITiCGPqEciGnQqSQAwVmGRVNU3Z12kbzJZXyuHDtLsz60Xp7zQniRHufWa
         9SnyevkCf/LB8umJnVbhbsXx9KMJyzZ8KLmIVV1fwMwvnWbpD7PCfThTIaRbUy3DHBk+
         NvdyY7/1K94Ju1x4AOJAh9SKIOokv+B8ONdmJu12NRhV2SE3rM4ld8f5e8+SGuNMhHR3
         jbsAaLdmOcqcK7BHjPp+ShUCb5q5AZ/dwH3mad8pe8TsVXHZ1lFEQSoPmVFZCvhJtQPn
         oDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPLjK0/F2QBKjF46wFtmvCRgoQO/Uosrsnmy5GRIu/8=;
        b=Ip/dgNv5Vp3qh+Kw4gBO5EjMJW/BTmcGwXv2SadP8V8jGX5YUd7sUpz8Tooc7IP1v2
         dZUdtg/ZtCSu/Ve5npTWMoIop2orC0Yc7BjT1KxRoVYp7G6evbXjrGSk8/yT6GkDEZFY
         atjeWfljYCUslC+U5dgAR92plgpWoxAbIwdqp+/MCtYsAAqiSJb2i7NfuGLX2xMtFbCb
         dq+SDY81dsI+6ac+/Gl/+vf5Brwo7sblcv/2FeZgC1FzWhCKxN+s+zKy/nnP6Ghe4xCh
         PXjTAfoO2QE1yGOB/itsUHThSlFENBbi3ZErhqOBgwe5grQggtevR9PmK+ngU9r3HJgO
         0hEw==
X-Gm-Message-State: AOAM5306d3jx6pp83ShZ7rIs3yX4VeT+Qt2svMYDTbjdnKPwxsFfiqpq
        wTKXlcAxLsyxiMlpEw+gMEG1QvyL+/nUeQ==
X-Google-Smtp-Source: ABdhPJypvjrsZvABpnRr0qCx3Bp670YdaFauU8/HiRQm0vjzicd1v3nn5OFLoV7JZmT6HQYOSjU5eA==
X-Received: by 2002:a05:600c:4f15:: with SMTP id l21mr9666333wmq.72.1626430955528;
        Fri, 16 Jul 2021 03:22:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:22:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: ngd: fix runtime pm issues.
Date:   Fri, 16 Jul 2021 11:21:19 +0100
Message-Id: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes various runtime pm issues while testing pm runtime
on NGD slimbus controller.

During testing it was found that pm refcount was going negative and sometime
transactions are timeout after suspend resume.

These 4 patches fixes those issues and now NGD enters in supend state
and resumes properly without any data timeouts.

Thanks,
srini

Srinivas Kandagatla (4):
  slimbus: messaging: start transaction ids from 1 instead of zero
  slimbus: messaging: check for valid transaction id
  slimbus: ngd: set correct device for pm
  slimbus: ngd: reset dma setup during runtime pm

 drivers/slimbus/messaging.c     |  7 ++++---
 drivers/slimbus/qcom-ngd-ctrl.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.21.0

