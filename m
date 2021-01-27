Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A5305A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhA0Lqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhA0L2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:28:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EACC0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so1517255wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+pPf3toKEse/9kjih6DD2KI63boeMHUYd5sQ1L4808=;
        b=EGJZw7wfgtfz2CzYV3daPIlaKtUeDRxMJKKiGrIQERCjYN8FFDybJWgKh+/vMdQQrJ
         b6SCg1l3YXhZXlopKmQdPBzFnGCbNaPosS9Uesaf5BLBaAOA1HU8U9lBp2L2ISjZsgCa
         5o0HN+fm8nRkPPPugdclK7jLUYV+oZgQcAs8eP3P2gjMQ8yGkW/lXwDk3MJpegB9HoLx
         lQ2H8GMIpvmHiinVSyYKKcvwPwSJbIk5A9/bUXYNE8b2dfor0bUnG+Dblsofa2KoN5x4
         Wch8x4suZCfNuj5TF3lwLXJuCRcAIOsN7i6+Zvm3HLP1HrJ9jvAfky34e2pNwJsS0gfF
         dUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+pPf3toKEse/9kjih6DD2KI63boeMHUYd5sQ1L4808=;
        b=UwLzyy82XatqmOH0lBdyEziHLspws06PDU+Ddg5uzp4ziouwideqY2bvbo56sAvqhr
         ldNQBkHw+qO8EyRer1UJuQpClFJ6dynjGYOyAnU9W+KV9fSxFHq41KsbBJT82IbwIG5+
         7UlJjNLA3GUpeIscLbKU+qk4LgMZVQ/zk6A0pD0NimwajVVVrrAAjZUJNla19c5zQpMU
         gRsdpKIg5Bg3Zri8r7R9J8A/Dw1EHHO0lrroZbS9z2M5751mdQCKXbjAjuQmNP0fzAlX
         7arc05BKzh0dBPAdPizFgJkYvJRk0m0zG91D9SvHR1FLK6kATg3hb/QpFCj5wg5BVhlE
         +/KQ==
X-Gm-Message-State: AOAM532xJSccFz6YLJymePgrd2L6JvDkaBc4JPSvfpCEP1WcAZUrfj/m
        fOogrGBXpuyyo7F7R8ynVVSjdA==
X-Google-Smtp-Source: ABdhPJwLt9fF+Qd6gWqSi22t+tjPmJ1gbZnyZUHjpQhmago9hDtiktK4oYSqHo90oUJdK/kuU2kzmQ==
X-Received: by 2002:a5d:524f:: with SMTP id k15mr10815856wrc.16.1611746764884;
        Wed, 27 Jan 2021 03:26:04 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 05/12] thunderbolt: pa: Demote non-conformant kernel-doc headers
Date:   Wed, 27 Jan 2021 11:25:47 +0000
Message-Id: <20210127112554.3770172-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/path.c:476: warning: Function parameter or member 'path' not described in 'tb_path_activate'
 drivers/thunderbolt/path.c:568: warning: Function parameter or member 'path' not described in 'tb_path_is_invalid'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index ca7d738d66dea..758b5fa0060c6 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -464,7 +464,7 @@ void tb_path_deactivate(struct tb_path *path)
 	path->activated = false;
 }
 
-/**
+/*
  * tb_path_activate() - activate a path
  *
  * Activate a path starting with the last hop and iterating backwards. The
@@ -559,7 +559,7 @@ int tb_path_activate(struct tb_path *path)
 	return res;
 }
 
-/**
+/*
  * tb_path_is_invalid() - check whether any ports on the path are invalid
  *
  * Return: Returns true if the path is invalid, false otherwise.
-- 
2.25.1

