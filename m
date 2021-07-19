Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558DD3CCBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhGSAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhGSAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:20:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF589C061768;
        Sun, 18 Jul 2021 17:17:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v14so8680485plg.9;
        Sun, 18 Jul 2021 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHNRWvNe8lxqEgkTN+Pq/ZUg7iyzUjJYcM1nQZBO3r0=;
        b=k3hAZ7iqpFgkMGOAGroPjCxgHstNs+5xyNCahw7Xj3c+jAavEmpZ0wCwZmIeoxI7qd
         Juvgbbkg+ATLTkqJiw6rEf4mXqjq0C446LPSKpVvgGEMdFnoKcV0Q+2xFxBzAaif25eS
         ppkybrMSDj96k/gHhQG5I0Ee6Vo++IQJ2Xvm+5tUDFbCiLQIyoPhoBssAJ4GogxBJrDj
         aotH3459/JHkWa4g7h8wrXpOWRUEUWYLgOof12xgQe75SDnZr/ZFre9ZrYe4TzRZDpBz
         f//HWZCtpI053N9OEVkaCddVZOyC8F8EEGxoCJePGE5qkCWv35/mveosI1XwHny2oo8e
         qXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BHNRWvNe8lxqEgkTN+Pq/ZUg7iyzUjJYcM1nQZBO3r0=;
        b=EOWf2kIhrjsyo7eYVohEllJO74Aeh93ATpU86Ax0QopPom/LVYlWTHXbES/RcAPIlZ
         lOLYNLl1H3MLPNGeOife3H6TD/ky9QmP9eTAoTg9Ue9Ry5sAWTOTct3TXsA4JWg2nK2K
         WsuF3gQXoThBL5rVlA3iH5DJoBo0nI+uqi8/ootPHJNocFwQWEcAtSaLfkfCc7Q41xDh
         SXb39yjvjPHNB5eRPhYyKIIwh6UevcVi5DVeRoL1Ys5GlzShml4MThAn+o7DK/D1tpTA
         v6bMY0KP2rYQZTbtdT57Qd+2mJOCH/9Am0LU+xW5faUvz4l1M6q0zYxP3ouUx+b6YSmN
         HWDw==
X-Gm-Message-State: AOAM531QfOc7ITdJtqLtvQDXm/P/G43rLdrKjJHwF3MevhkYKf2IGGWh
        BsNTBMJxDzvGe8Y0gdrEQZU=
X-Google-Smtp-Source: ABdhPJyDbFhNMaG8afSEbgfqPufO9cEJD4fReUGCqFjKkqqzCPigl143R1J2U8F0abL2KLgCinfzzQ==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr27060197pjo.97.1626653859124;
        Sun, 18 Jul 2021 17:17:39 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm1059847pfn.70.2021.07.18.17.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 17:17:38 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/4] ARM: dts: aspeed: wedge40: Remove redundant ADC device
Date:   Sun, 18 Jul 2021 17:17:22 -0700
Message-Id: <20210719001724.6410-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Remove ADC device from wedge40 device tree because the device is already
enabled in "ast2400-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 2dcfeae3c92a..6624855d8ebd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -23,10 +23,6 @@
 	status = "disabled";
 };
 
-&adc {
-	status = "okay";
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.17.1

