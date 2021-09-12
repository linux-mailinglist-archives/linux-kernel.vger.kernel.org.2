Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46DF407DAD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhILNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhILNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:40:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CAAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 06:38:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y128so10433596oie.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5ZWGZmPnammQ04Toa5uVC3kIpyJsyrgJg39bwT6488=;
        b=IOsk+hvpEYnvUmtgxv+3zhefOSuJqSbkV8JnhMqNpoTFlAAny766aYeMs8aeaJFIq+
         QbNjJAYcaSiQjoe1FlgTeW96zaKBwZHshnt1D1UTgvydoQVoG7p63L02AHtlsB5OW7lz
         7YEGRX/AUsVkHQJixisAHwGbcTD/K2DbP8IBz+huCSFzEp+xn+CB6uiCr5clFuvLmJti
         ix2TWb0CqP8xyK+zvvMuN0f3TVLVB/hcTOTrP4nWEkmT6eCWikHzwPAaG2TuoPnBYm5F
         R7mXYhfh4XD/XqKsYGqhvA3MxV19N1s+WqWJikojfCXIx+IQyMgO3/2EqtwV8RJkGIvH
         +XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5ZWGZmPnammQ04Toa5uVC3kIpyJsyrgJg39bwT6488=;
        b=E3EO2ypuxvXVDuDGlFRYNY8xpdWXyf0NSqkOnFlWVRQGu8z3npwWi96Q0W0GF0k6EQ
         S4yvcug9Xhaqz8epfjpwEYmskQ6RYBjRtghZ3luyfXdHs7Wyc8xPqjSazGvQK6gKPqSt
         qLkFv/ty3WhnJGifwRt2sRn2wK3U6mDjfozDtLV79LUDop9QE+K/3UMf5wgB3A3WTi+L
         +xoP35R/mILoJ8AJUqCuctsKWAVufAliB3YkfP9N5NwXSlKMT8tQ7lUAa9FsqItDyQpT
         GhyLw+vndtaDWklrRU+itvqSR/x6MD/KpwHfAdyk7J4aYnBRpCKiioC+7zCojnbfopVj
         iGrQ==
X-Gm-Message-State: AOAM532J1v0feK3O+rku843/Fimf6BswRRIjTsShux7J+35x0WSZfH4z
        jVu6ww3gyXWsJBJrWthaqzE=
X-Google-Smtp-Source: ABdhPJyAVNxu9oL4gcklUE+FcSb5eLgLwLCJZhG3eBTWK+U1uAqSp4QI/5iiwnXlQW7Q+YgqGgwL6Q==
X-Received: by 2002:a05:6808:1910:: with SMTP id bf16mr4617945oib.56.1631453931619;
        Sun, 12 Sep 2021 06:38:51 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id a15sm1131853otq.13.2021.09.12.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:38:51 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH 1/2] staging: vchiq_dev: remove braces from if block
Date:   Sun, 12 Sep 2021 10:37:50 -0300
Message-Id: <20210912133751.269885-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces from if block.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 788fa5a987a3..c990d5d7bfb5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -447,9 +447,8 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 	DEBUG_INITIALISE(g_state.local)
 
 	DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-	if (!instance->connected) {
+	if (!instance->connected)
 		return -ENOTCONN;
-	}
 
 	mutex_lock(&instance->completion_mutex);
 
-- 
2.33.0

