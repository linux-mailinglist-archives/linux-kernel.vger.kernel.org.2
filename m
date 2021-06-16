Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358E23AA393
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhFPSyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhFPSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:54:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB75CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:51:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4585999pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiO7wVtqwSbhSBe9q3e0UTZ4c4t10jq6vILtIaBfZqg=;
        b=YL3AHamnnGGXNmFBN0EQunbQdIMrNTPqf87APo4JdqUQ49vZ+mNeCUondDWM97H7iJ
         IrQoUKvrdxR77siZ/IrpgYDaaVXvC7Q1sCzpwLxtzBDaj7d8JHUGB+h/toyqc7dJo2tV
         6jVJNoLwvryiss+zACIRfh0czkBagjVTM2NGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiO7wVtqwSbhSBe9q3e0UTZ4c4t10jq6vILtIaBfZqg=;
        b=cQsfamxTjjj2i5rV7apvDR14hhwzI4jArpv6hcsLxQ6qejydQdCCMOSPKUByZFhCLv
         xNFxxCvg5M1N0pBvKfeHekH06nLNuDxNkVe4FirIXhSNzLsCtlzWRizFv1GhPp3KyT+l
         7FXkPYBPNU63f/524TDecc0z4vhgUnGuP5LDof/q8MwXFKT1pXKsDhldfDIXNVKNR8E5
         JElaJb25ZECSYVWrMCD5h4nKwqttJ2h9kk4YfNQfQQDK38lR2lcrkKofkVaU2ejj3fBu
         d34mpkh4WmrIVTXBu7nvBC4iV0kJJtI86RRCTKkaSB/47yF3ZUI3otskFpc6v7vfAWuj
         cReA==
X-Gm-Message-State: AOAM532TaUw0dEe2uQKHktF6lpQZuLcOGnwbF7/NsOctJFj5lRxPh7xA
        1rNr96NeHHc+x9+EUYV97D//3g==
X-Google-Smtp-Source: ABdhPJw19tz6zr1R5bCnQgxhIK+v0PEhBXPFMy3/ahYSDgz6+/LtOJqr466e+MLPR/LUZfEOslCO3w==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr12367191pji.121.1623869517307;
        Wed, 16 Jun 2021 11:51:57 -0700 (PDT)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id z14sm2895574pfn.11.2021.06.16.11.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:51:56 -0700 (PDT)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Wed, 16 Jun 2021 11:51:25 -0700
Message-Id: <20210616185131.1792509-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616185131.1792509-1-dnojiri@chromium.org>
References: <20210616185131.1792509-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
---
v2
* None
v3
* None
v4
* None
V5
* None
V6
* None
v7
* Rebase on torvalds/master.
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d07b43d7c761a8..9c14413bdf9b5d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -114,6 +114,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-debugfs", },
 	{ .name = "cros-ec-lightbar", },
 	{ .name = "cros-ec-sysfs", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.31.0

