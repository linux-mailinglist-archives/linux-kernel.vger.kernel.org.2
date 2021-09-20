Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529C5412AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhIUBpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhIUBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BCC059340
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:59:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so18629452pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHfHQauHmNVTH62EJRiOmjlj8cX06wogXZw+8cv7rQg=;
        b=F2y/PbWWRmGPLANOqYDLwkRslKqHvbMOz6xCmciWK0JcFAYbgxJQvFruLLPHkwcGPd
         CsQhvwvqLPfx9gRE+oKdu8Og8QosCPGuY5x21MEZGQ1Mn+I5432vn51s7ybIhJ6Jl88U
         bHNx+UDyyv/BJ2MJ1Pt9Xfpc1bYdkPeLgq7F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHfHQauHmNVTH62EJRiOmjlj8cX06wogXZw+8cv7rQg=;
        b=LoLIL8Sq/PNphyQZfBDlityZ4uiUhklVxfuPITyIlNyUg3lrV2LkLWc0f7cR3pEFNO
         tkIMs5kM2dOxgQ6s7Cj5bTEKf2abipN8PXWV2q+iHqmSii5pmc0TXjiSwx+aItTFpGdG
         4uh89fmbdNxpRdptnm7o6JFSStjxVRGhVj+hJC1gfT1iuxzhE/hzY6ZVbO2/Iiv3sOdc
         cYvjFBaCRyXBfDxv24Nks1ChJ1xi5vURYPqbn4bUG+NAYKtLiKvWPUUabnhnrrjzL31K
         bF+bq2g9ScpU0/NNQ/8F7LxTUGCZzNk1xqFYQ/N4QQ6yLEdR/299Nba8ENXIz8jrTk/6
         idNA==
X-Gm-Message-State: AOAM533EyZFjLI4Xpa2MF3ujldl+EyVlewJ4pxhOiQU64KmeJLy4G8pa
        ZXiTjm7+RWIXBBeSeRJdCmAJ3g==
X-Google-Smtp-Source: ABdhPJxwgcLOZ50RgUkbPfDY5ZgF9CU1Szt8qa6OPO3RE1dcYXlfwbnyUkN3LfzykiXMFc6fazZQIg==
X-Received: by 2002:aa7:9255:0:b0:415:ba53:e6f5 with SMTP id 21-20020aa79255000000b00415ba53e6f5mr27145251pfp.78.1632171550049;
        Mon, 20 Sep 2021 13:59:10 -0700 (PDT)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:3cc6:73d2:6230:9d05])
        by smtp.gmail.com with ESMTPSA id q18sm2208417pfh.170.2021.09.20.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:59:09 -0700 (PDT)
From:   Benson Leung <bleung@chromium.org>
To:     enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com, bleung@chromium.org, mricon@kernel.org,
        pmalani@chromium.org
Subject: [PATCH] MAINTAINERS: Add Prashant's maintainership of cros_ec drivers
Date:   Mon, 20 Sep 2021 13:54:02 -0700
Message-Id: <20210920205402.3818320-1-bleung@chromium.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prashant maintains the cros_usbpd_notify driver as well as
the cros_ec_type_c driver.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..16573a2d2fe3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4429,6 +4429,17 @@ F:	drivers/power/supply/cros_usbpd-charger.c
 N:	cros_ec
 N:	cros-ec
 
+CHROMEOS EC USB TYPE-C DRIVER
+M:	Prashant Malani <pmalani@chromium.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_ec_typec.c
+
+CHROMEOS EC USB PD NOTIFY DRIVER
+M:	Prashant Malani <pmalani@chromium.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_usbpd_notify.c
+F:	include/linux/platform_data/cros_usbpd_notify.h
+
 CHRONTEL CH7322 CEC DRIVER
 M:	Jeff Chase <jnchase@google.com>
 L:	linux-media@vger.kernel.org
-- 
2.33.0.464.g1972c5931b-goog

