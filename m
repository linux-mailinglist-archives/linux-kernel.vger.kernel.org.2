Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684E3059EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhA0Lf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhA0Lan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:30:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E96C061220
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m2so1234125wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRGqS1Ub4m0YbvVmKTGmVzBFWciGxN2mIYxOHlmuFFQ=;
        b=aFxHUHZG0if3sG9m3uw+QqOVHvX6FbbHalFoG7h6dCnk8s42nSq/jKBdsJWQ0Hbq4p
         Z1SlStAl/veU82UOU+zuLWWwwPLQ3cGM4aWLgam854/2L3ZjWICBDEz8GSvXFWMtWsCw
         Czr1b/cwT6ymhR4o6GQV05OUSWK+jB0PPmbzyMn97mKM6dRLyTMzBxAm/9pvaE+vm+oV
         T2X1eeb0gUgd1xgKH2lKqpimfTvBfTzOfy4i8/qK8IEUbSGBt1z/FaOn6uDoIwgZt4sj
         362O5PTo2SMXRygxmUwFf4dcnefnUgODnQurChgh1grzCXnDzJn5TQwuWRiFYMVZ8Y4k
         N77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRGqS1Ub4m0YbvVmKTGmVzBFWciGxN2mIYxOHlmuFFQ=;
        b=l8E9hJ0r38ZWGSZ+isyyU1fHwHZU3erEannGo3OPpLWrIApuMc4xThpqElvVvA5IE0
         G02mj64c3gmK4H7eOSfmVEwqAsdyyPuLB6BPQbbRKb3TjDjHa7Q97uPDuqx5cHJiiZZ8
         VCoDz4NoyoNBzFhkF1RMPQCGKqOmTAW3OxJLgPGuspOOsfVXMr3SlNkrGQ9Mrz+64nBi
         wH7O9uwzYkyDvTN8rGioFTjcOfsFwHoxjCm8Z8km2uS94R3h4fG11rZ+UYGeTnIkDdZy
         uKFKn06Js2hnWnqUcsrUlIwZVBwLbCOwG80hTAGUp4Zi4rCgQ1cgbMOQrX23jQWV+Mkk
         sFtA==
X-Gm-Message-State: AOAM533vwxTh+OdRBZRgRrwI8P65dfagtJ0Rqww8KMllTDpuy+3+Ozvs
        54uW00guZShB8E3ndFO/CaspsA==
X-Google-Smtp-Source: ABdhPJzG1p4TDwfwkVY8TRuVEWbSgCecvhUfiUzcBZpZEG7669W9TlG+ARfXy+Ebey91FVQPSqnGog==
X-Received: by 2002:a1c:dd08:: with SMTP id u8mr3766904wmg.121.1611746772007;
        Wed, 27 Jan 2021 03:26:12 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 11/12] thunderbolt: tunnel: Fix misspelling of 'receive_path'
Date:   Wed, 27 Jan 2021 11:25:53 +0000
Message-Id: <20210127112554.3770172-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/tunnel.c:841: warning: Function parameter or member 'receive_path' not described in 'tb_tunnel_alloc_dma'
 drivers/thunderbolt/tunnel.c:841: warning: Excess function parameter 'reveive_path' description in 'tb_tunnel_alloc_dma'

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index dcdf9c7a9caed..37943b0379abc 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -830,7 +830,7 @@ static void tb_dma_init_path(struct tb_path *path, unsigned int isb,
  * @transmit_path: HopID used for transmitting packets
  * @receive_ring: NHI ring number used to receive packets from the
  *		  other domain. Set to %0 if RX path is not needed.
- * @reveive_path: HopID used for receiving packets
+ * @receive_path: HopID used for receiving packets
  *
  * Return: Returns a tb_tunnel on success or NULL on failure.
  */
-- 
2.25.1

