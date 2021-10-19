Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02DD4336EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhJSNYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhJSNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:24:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEBC061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:22:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e3so47425346wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UKF3mA+2sn1KUeTv9URlDlCn8qXzv/raYyGlxYAPS8=;
        b=dCXIUuRijAaM1PKctpqvTL6Kkslc+fgDcuIVt5VTpx0x744coxjy3ElKDSG9HYqo2b
         3jRKs093CGEewmTnLmxlQc9I7HDW1n5mLFtCirdZ2syjBM4BEKHSkV6IGEcnm7xUU5fX
         oM1jdbX5JAoSAfEBPKO2UdN/fCB5egF1mFvlEvQRMB4i3q0iXqFrib2OeLfk4s47f9ID
         lyA0cEq6h42Nqh7DVbbg0EoD5yQz2Ikk/hMxJfFH8qwObs+RXJNLbu7hHU/AgWyAIDhk
         OH3fkT3skWxFGTqqIA/bLlUq7xSYP5eUO3G6g+rpMUHL6rqz/59iNgYEWtfcIzWrU+9S
         rtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UKF3mA+2sn1KUeTv9URlDlCn8qXzv/raYyGlxYAPS8=;
        b=z/JbQgF2Z1FejW7nenf/gGx1XTFuGb6a6GMrNXnaFubXsIGY/klAtohc9J7qLZ+v7U
         G5svJznZ/INp8tBIItB6RDLO1s26fdz5PT8yqRfIqhuXDacxUigc7RH2Kw1fV5AFpZ3p
         HF5d+bZQREs8rXGZFblmc9Ke+stz6DBtGWeOAXz3XPslokgJeaAXNFHxmAHVsmjDrIUt
         +qmHc/E9hg10/2bcVeMHGh3d+tZBY2cbM5YT349+FQcr0vT0IaF35nUpycV+zsYWFus9
         hXw95F3orjLL41mfOmPcdFp0A7NVCCpwnN/2hv4nBEUVdNvRsQL0Pf3ThqSwtEUv0gTW
         MBCQ==
X-Gm-Message-State: AOAM533Y8Kw/T/yhTRYxagmf2bsvbSHh/7f3LsF6tiA8YCnjl4keIpJ3
        IFYws1sO+kcxmu4yTHZKN0qqzQ==
X-Google-Smtp-Source: ABdhPJxmkEkPNVlK2zbcJVrV9Tf6cLZih7yrfssvqR0afKxspytoQBlAhrDeSn9+o9K49kl2qTEZrw==
X-Received: by 2002:adf:e706:: with SMTP id c6mr44813179wrm.377.1634649745347;
        Tue, 19 Oct 2021 06:22:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.gmail.com with ESMTPSA id n7sm14982426wra.37.2021.10.19.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:22:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/2] thermal/core: Make the userspace governor deprecated
Date:   Tue, 19 Oct 2021 15:22:10 +0200
Message-Id: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace governor is sending temperature when polling is active
and trip point crossed events. Nothing else.

AFAICT, this governor is used with custom kernels making the userspace
governor co-existing with another governor on the same thermal zone
because there was no notification mechanism.

The new netlink thermal notification is able to provide more
information than the userspace governor and give the opportunity to
the users of this governor to replace it by a dedicated notification
framework.

The userspace governor will be removed as its usage is no longer
needed.

Add a warning message to tell the userspace governor is deprecated.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_user_space.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 82a7198bbe71..95d6d3d6b8f7 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -15,6 +15,14 @@
 
 #include "thermal_core.h"
 
+static int user_space_bind(struct thermal_zone_device *tz)
+{
+	WARN(1, "Userspace governor deprecated: use thermal netlink "	\
+	     "notification instead\n");
+
+	return 0;
+}
+
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
@@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
+	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
-- 
2.25.1

