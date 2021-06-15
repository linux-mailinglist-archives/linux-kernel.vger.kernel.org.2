Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9413A8727
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhFORLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFORLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:11:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B7C061226
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:09:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k5so48250pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2WPpQkb0Q/CUvj+0ggDt0F/puvmac2TI54Vj4Jt1ao=;
        b=K9jX0lM8FjFUfl8OOo9eM98SEWQQ9vZMap1+5zVKhdTaChZUuLWI3Z0g7VlUY/hoYt
         CFN1bmWxRZ9iIBogMN96c77nmgc3zhUBZdqdm44Yrc3l36eTuDErbXTUyzGzbbd+8E3Z
         idr1yclbnaAgq3TN2Lzn09su+0uLGYRYsjNh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2WPpQkb0Q/CUvj+0ggDt0F/puvmac2TI54Vj4Jt1ao=;
        b=No7XxJrBDBnF+a8eTFsxlDVMRNlqzd1RkmQOmsmfwJTkV+2RFDR2Bnvt0zie5xIm3p
         EFauA5RzCJs+2dp+V0a2/TQaiF5QwlLxbRWOIw98nNdegh0jyYKxOCb9lL3rGcG0Gade
         Ia9t34a0d4lBbkKcyNz7EoJK8B/yQgtXQorFG2fdef9xIIZKsFZZv/4v2+tKFpzykQR+
         RWR3QH4c8X7q3kFLOvoYl2tWu/jn+znPK8NxRwDi7m5cU8E6J19xR0sfcV7kgtl+TQmI
         LWThFPb6KFyw2DBPr/CzIPkoLdQwkGTGAE07gZFEKBUklIt1hDuvld2S2vQT5ZoLqUiQ
         zZzw==
X-Gm-Message-State: AOAM530Pwkm+xIQbvEnPEUpUnVbA0T+W62wbv8cjL1QbmqU40qsShXrj
        9r8BI+xw5QkdFaWWuMAlx4Mfjw==
X-Google-Smtp-Source: ABdhPJyQOd90BQT3wyX6MoXz2HDsvqbEyKo1A/nNJDLLRGlhyblitpBNb6j6nnyS9TYLhNeXGLvECA==
X-Received: by 2002:a17:902:c202:b029:10f:b7b4:35 with SMTP id 2-20020a170902c202b029010fb7b40035mr4914534pll.82.1623776949458;
        Tue, 15 Jun 2021 10:09:09 -0700 (PDT)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id j3sm16106590pfe.98.2021.06.15.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:09:09 -0700 (PDT)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Tue, 15 Jun 2021 10:08:49 -0700
Message-Id: <20210615170854.897153-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615170854.897153-1-dnojiri@chromium.org>
References: <20210615170854.897153-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2
* None
v3
* None
v4
* None
V5
* None
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.31.0

