Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066323EC258
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhHNLTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhHNLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:19:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601EFC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:19:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so7060399wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZ69q09bn2xEf1TqZCPUcfRfCHjRetOH+6+HNvKhL0M=;
        b=HQz1a4FgWiX/OhEGVsSfXYfG0zLrk7UYbO2Sr1M1fChwDbgHiNo+DjBy7DmyceH3hW
         Fuu+85yF4GeBZmnjgyX+vNxeBjbLJOMyS3TwjFisfprRpdl9PzVhO78XU++ABTOL4BvF
         kdBqHM8gdku2IJCPDzsE7Q7Ra0bTZW1A/w5jXYL0bxo6gQf4LxcZDX/TiQv0NmcSdPmV
         tKob0jTHg0kZpl7jnj6WkEKY9NxTQ2pyZWe7D1uS252cheLhqlaAq8uwbogDF8b/A6xI
         VzJY63VsODgvKC7K0t35cXzPf3g+nEggjiFimEXAcH1VX6IeSspN4ZFwIekcexQaeCDc
         Ch0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZ69q09bn2xEf1TqZCPUcfRfCHjRetOH+6+HNvKhL0M=;
        b=T9/sTlXZCaPAlFhcIiCOIgkqWBZynfyKI0QyjB1X06Y0KS9OGOmeMZ6cFA8QjqxqO6
         +/KIMgShHOBWh48np4sxbfmg4CodlBli0q0so1nMnUwC82g/2YCMEHoJtBvGOCIxlyIW
         P5uW+7aWjJwvEi4j0vcQOl2u9kldECkHnJl3+0OC1NxWUJS7Pl3sWBimD2px+ZmBYGzu
         Z7WLvjeXP5nFarLef4Hn/THAR/DaMyvskaJOhkRw6cJUpFnkVHd2zaZW74rBY6FVylk9
         dx1skuME7zFW69AooGne4KB9VTuKZ3roS8fYJJAIZjrvfTUMa0AQ/zuIR2VrbKMrHeES
         PCLQ==
X-Gm-Message-State: AOAM5308/UGbVH1k/Dm0owZecrqaL6PEYziCywajFrp8mqkS3kY8GmUP
        GMgdeRI4Whrcz3ar80s/aVXhrRofkP8l1DtU
X-Google-Smtp-Source: ABdhPJwpBXpx/U1uJ8HwNa3nTvc2VQiBr5VqQpHd+0b2VODh43dfRwrwliTm/Vd7AWVTM8YhgSt1+Q==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr6563901wml.16.1628939943826;
        Sat, 14 Aug 2021 04:19:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.gmail.com with ESMTPSA id q17sm4147199wrr.91.2021.08.14.04.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 04:19:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, eb@emlix.com, mmayer@broadcom.com,
        jolsa@kernel.org, acme@redhat.com, jkosina@suse.cz
Subject: [PATCH] MAINTAINERS: Add missing userspace thermal tools to the thermal section
Date:   Sat, 14 Aug 2021 13:18:56 +0200
Message-Id: <20210814111856.3060957-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2149399.oOxd0sxVbX@devpool47>
References: <2149399.oOxd0sxVbX@devpool47>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches related to the tmon which is in tools/thermal are floating around
since years because it is unclear who takes care of it.

Add the missing userspace tools directory related to thermal to fix the
situation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..a78f490fd128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18358,6 +18358,7 @@ F:	drivers/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
 F:	include/uapi/linux/thermal.h
+F:	tools/thermal/
 
 THERMAL DRIVER FOR AMLOGIC SOCS
 M:	Guillaume La Roque <glaroque@baylibre.com>
-- 
2.25.1

