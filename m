Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47E9331B02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhCHXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhCHXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:39:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD3C061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:39:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4829117wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqyLkN28+VbZJ1BodN0k6GRf4WGaBBOV7lcLbkfiJBQ=;
        b=Xh+k5bGSptAyjUDGZQnXgFqbHzAG1QPvOAA81X4+86hLvLLPcBkxJp7PAp0mXyk8gI
         yAvz8MiX/7rbhLuhxHMMxcYXxEfCti/hBoXil6MGBKkmQ7gkro9wSdEKf2JNbhliCu0i
         VbGbqiqJfX8rUQjvkdQPoX6VJcl7sHNQuPGt309aH7ih1/9xWv+z297uaGFlfS+3Rijh
         del9/iXKRiBxWOGvTcprNCOUtJ6jMglS3lo8yhrgrim/WBjV+AUkG5L2AEQx8hro87Wr
         NRIbt0HqoqkQMZi1jxQpNbkKrBHGUatDDf4hPFqyXQIcIxSQ12Z2yRweL5U8hyLgpJ3+
         +Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqyLkN28+VbZJ1BodN0k6GRf4WGaBBOV7lcLbkfiJBQ=;
        b=OreympI/B3QDu8JJEQLhgMXdwDa8JdzRyHvsIcljU5/US3Xk+SjH7CBwxt8TQcM9Qo
         N2wSpdtCbi9uWauxNK1lKPEFjSlg63iSjyJXRD5Mg5oDbd8ZnM4vpAPWTgYdq2r4WI/P
         Sbat1vUMJX3jPwCIRYhcaSvqPbGcYW9dU5Ltyf7BD9VSD+aV1GD8XgPmU1WCKQTejpST
         aZO59+tOPStFLL+FLhGV0tzNKo2BVO/rszGlQVg0uSz95dVnd6NSywuUntguEbXVUhak
         OY5eUm6LuGyNhNuY13hRssU3mVogCxWzoWE4d9LYHj0GNRvethTMaVWEpnLOdU/88YVL
         ltmw==
X-Gm-Message-State: AOAM532FLh0thR/eYiMbZdX6BqOYMsVbZ4BvNuk5wLd15dOprDXcaKXZ
        CS4N/Dbzz+aZL1mKXhudC8sK2xFy1jZ0XQ==
X-Google-Smtp-Source: ABdhPJx6PRCVhueYee+s5rTUuSEOQ5BGaZfr6qtVs+qF+7WlrvYJ8gsYqpzm7ZADmb/sCt4UW4mj3g==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr1108634wme.48.1615246761430;
        Mon, 08 Mar 2021 15:39:21 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id b186sm1145408wmc.44.2021.03.08.15.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:39:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v5 1/4] dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
Date:   Tue,  9 Mar 2021 00:38:55 +0100
Message-Id: <20210308233858.24741-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
general register files to know the DRAM type, so add a phandle to the
syscon that manages these registers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index a10d1f6d85c6..a41bcfef95c8 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -12,6 +12,8 @@ Required properties:
 			 for details.
 - center-supply:	 DMC supply node.
 - status:		 Marks the node enabled/disabled.
+- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
+			 files".
 
 Optional properties:
 - interrupts:		 The CPU interrupt number. The interrupt specifier
-- 
2.17.1

