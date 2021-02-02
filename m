Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B893A30CC46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhBBTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhBBTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:48:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85064C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:47:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a20so2952045pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19MA6VmZ1TXGx8xgl9B9Clwb3xJWJIXQ38902RwSETk=;
        b=EL9fLzJ5P3xbNoPG8Vlm3VM/gRsuPNy/rlkgBwqU+bfbZUtgTS8ZiUYTrOCFk6Tpdt
         /2Ivlcgw/W5ksz7SjXnpr+qapDNeWulA/kGj/NkvEiLhh9o8p37NXDSt3Ip71keOqeDf
         z/4COF+i+KNTUQ8Dw+uakxac8ZS7upbcIPJic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19MA6VmZ1TXGx8xgl9B9Clwb3xJWJIXQ38902RwSETk=;
        b=SQS43US8lvEguJfoo6dI5LyzuGHHgEdQlVAYp8/toqu9gCEfCcBx1xU3/GCzoP2AvF
         hOviBQOEpclULsOAaBe+LJGASPb5l9+gBxF5VPhCfefHmReUolM9vz9vd1W9ooaEPMcv
         eWH0qF54PvgNGgJ7dsIGL/peajFCQigqIKlUh8vySODjMtIEBBAoF8hb/2uN0O7IxTFf
         7DZ+3YQZ44fangH9PzmT/v1PdmavGFmuWD7SrtRaHkmcOvk/v7KqbrxiQgnb3Q+lleUw
         l7DhhthX1yfuZ+cmHm9fviZN6Jv3A+FUuuiK992PpABpwUDatDx0y+jSzx7aNC9LrQRo
         /cOw==
X-Gm-Message-State: AOAM533pYnzpWut/bREstJNranyY3SQc2kcbHCIjSSA1XrX3GWQR7fK3
        T8DrTV5SiiwUme8EAbxbMkJlmA==
X-Google-Smtp-Source: ABdhPJwSL9tHYTjbifQL+Zy89Yj6xktCPVIn0O5ReEMsqIDmMMYCKbhDZN7ISmPAgxVTvhZ/nTKhog==
X-Received: by 2002:a17:90a:5318:: with SMTP id x24mr6051241pjh.226.1612295274185;
        Tue, 02 Feb 2021 11:47:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id j4sm17021751pfa.131.2021.02.02.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:47:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH -next] media: venus: Include io.h for memremap()
Date:   Tue,  2 Feb 2021 11:47:52 -0800
Message-Id: <20210202194752.247301-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file uses memremap() now, so we should include io.h instead of
relying on any sort of implicit include elsewhere.

Cc: Dikshita Agarwal <dikshita@codeaurora.org>
Fixes: 0ca0ca980505 ("media: venus: core: add support to dump FW region")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/media/platform/qcom/venus/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1471c7f9c89d..915b3ed8ed64 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -5,6 +5,7 @@
  */
 #include <linux/init.h>
 #include <linux/interconnect.h>
+#include <linux/io.h>
 #include <linux/ioctl.h>
 #include <linux/delay.h>
 #include <linux/devcoredump.h>

base-commit: 0ca0ca9805055bb0efc16890f9d6433c65bd07cc
-- 
https://chromeos.dev

