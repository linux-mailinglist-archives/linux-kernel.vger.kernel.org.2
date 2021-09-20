Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFB412CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhIUCvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhIUCVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:21:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69BC09CE67
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:44:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 17so18296204pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHfHQauHmNVTH62EJRiOmjlj8cX06wogXZw+8cv7rQg=;
        b=F+Frtu3eStEhPavma0G6scJvXrZGDmhISuvEbr3iGtw++fqJEEzyQ+IgKj9LDxSHxy
         xIQERh/stOtpXc7dXqOQnMMG2A1LvfMtmuVQuVrVdfP98a7stZ22VQ4k2FABMz1CRfWu
         IvN12mfD4gUoa88PM7zci2J4M0wcYQWdXX4E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHfHQauHmNVTH62EJRiOmjlj8cX06wogXZw+8cv7rQg=;
        b=Sfi+TX56IqS3GfVvaGUCP5pBi3IF3a8MU3nau4V+iKmKGVr6uORcmddketOz1lBwdh
         E31LoqgnONpXu9+WLPWsveJ2i+bE0jpvEjXFJHYwMjpsY9h2HZ2sOSYMo4iAFTfuaW9X
         scisRc+x6TEPD142d1PavdurprbeQu2BXSxdycfOoBtTfewD+aZRxY+RZ8H0OziRIOcN
         iGhUO+uKeLoi+r9jPENyJXG9j4M5Iu3+dyIdEQY7XsiR0MJZZNy3JWGLFoaA/BFi1BIz
         q56ANd0uAwJIMmMX1zJ6yi8c/Cr3E5gbFOXscymzYjy8iP9vCr+/X/vcDrpwGND7EC7D
         Et9Q==
X-Gm-Message-State: AOAM530iuKRjkdF65zqIxa2uRzi7uHZj6N47GU2o8t9kQiRZN/+vtCT7
        wz3nXgjdUe5XMY5kMHolYH5oEA==
X-Google-Smtp-Source: ABdhPJyhNpqs2TkWGHtsku9LQz/63J+ofiMo9SWOeOTIcmDMIl/GQIShyx2vkQgI4k/IFixbA2jXoA==
X-Received: by 2002:a62:ea0a:0:b0:412:444e:f602 with SMTP id t10-20020a62ea0a000000b00412444ef602mr26736384pfh.85.1632163490547;
        Mon, 20 Sep 2021 11:44:50 -0700 (PDT)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:3cc6:73d2:6230:9d05])
        by smtp.gmail.com with ESMTPSA id u10sm163955pjf.46.2021.09.20.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:44:50 -0700 (PDT)
From:   Benson Leung <bleung@chromium.org>
To:     enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com, bleung@chromium.org, mricon@kernel.org
Subject: [PATCH] MAINTAINERS: Add Prashant's maintainership of cros_ec drivers
Date:   Mon, 20 Sep 2021 11:44:34 -0700
Message-Id: <20210920184434.3809271-1-bleung@chromium.org>
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

