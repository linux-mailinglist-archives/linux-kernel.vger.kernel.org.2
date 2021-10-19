Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E527D433C67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhJSQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJSQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:37:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B18C061765
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:35:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so3830080wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lGbUk9scuSolc0mMC7O3O5jKEdhtvYf+nI62abO4j4=;
        b=ppRTjWSzYtJqN0FzfUhvG4tLw/33KSdRGOXyf0A972B6B9Qqo8wsj6RBVzmuuqb/wW
         GwNSwmXgm9JVb512/caLZjdGQeYjwLQJpKqRkxTPjAXApdz0Jj8cG6gPgzIzibmQ4LPb
         VDMb35EslXmp7JmscSylFEmQY60WdVrn4uOIZ3AZXnt7nFCqcHV58xzIocbGEZMkAcOx
         sGwcWTkiQtLyDJ23NKScPp5QxBFih7YB0A6Xbq7YnDhZOryF3SFot24TLJB2LMzJOPWB
         r3+3xQozGKC7oswJO0f2E98ameFHg+zigQHiyvRqraVCu60IP7tBnXyHDqauaDVY2qZC
         13Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lGbUk9scuSolc0mMC7O3O5jKEdhtvYf+nI62abO4j4=;
        b=uYvLOHPhk0aJ7SpG0r9YYxR+/ahx8us8xJpziQv6yCt+JkiNTJ0kdQYRW+jaIarr2t
         0neMOd7Kvu0sgCv6FWoHQOPwOMUg5ZtLsnjnSy2BmuGK13Sd/iSkm/VlOelHVrwX+tIM
         x8K0b/xv90zMdFKA/XmVJoZHOQLPbY4CSSWE4N/uGp0QcUjEMXlQPYOGKtq+umSjv6Ts
         wL+obyNzE2I4B7jikhVFrmtCKQco55x8JnFOP2B0iromQ/WgOgg/5QmLTXg92K2wGfmY
         /28FO+eASIZK1St0eFpR8UY+ncSQv97mqQDdFytCqtNababtXywr8GilEUDSiKyd2Uvl
         iSCw==
X-Gm-Message-State: AOAM532l5RnOWmebHkjMKNq9fIHXDJgHFjPN+ob9elQyQJqn+fNhUk6T
        CDIoRJ9fdlgH+d5ZDggGUluAnzfMfbhPal70
X-Google-Smtp-Source: ABdhPJz4qYyTxSplorxLWlOxOc1azR2uKhPM6L83bGXJ4bXdXMR5I0XYlkeHzwIxpQijTU0pclODLQ==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr7301002wmh.135.1634661320770;
        Tue, 19 Oct 2021 09:35:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.gmail.com with ESMTPSA id n7sm15377389wra.37.2021.10.19.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:35:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 2/2] thermal/core: Deprecate changing cooling device state from userspace
Date:   Tue, 19 Oct 2021 18:35:06 +0200
Message-Id: <20211019163506.2831454-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling devices have their cooling device set_cur_state
read-writable all the time in the sysfs directory, thus allowing the
userspace to act on it.

The thermal framework is wrongly used by userspace as a power capping
framework by acting on the cooling device opaque state. This one then
competes with the in-kernel governor decision.

We have seen in out-of-tree kernels, a big number of devices which are
abusely declaring themselves as cooling device just to act on their
power.

The role of the thermal framework is to protect the junction
temperature of the silicon. Letting the userspace to play with a
cooling device is invalid and potentially dangerous.

The powercap framework is the right framework to do power capping and
moreover it deals with the aggregation via the dev pm qos.

As the userspace governor is marked deprecated and about to be
removed, there is no point to keep this file writable also in the
future.

Emit a warning and deprecate the interface.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..f154bada2906 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,6 +610,9 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
+	dev_warn_once(&cdev->device,
+		      "Setting cooling device state is deprecated\n");
+	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
-- 
2.25.1

