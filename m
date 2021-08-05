Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF03E0FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhHEHvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhHEHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:50:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C4C06179B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 00:50:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c16so5227536wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCSL/LzkhNi9/Yo+HPZHeRZeUrOizjlzKGlapanJ1xM=;
        b=EGafhqL1Z5qYCyFU9z7qCD4nHfiAFaHvh7zujYFKyXSfInrII2dGXP77Je5mwrf/ot
         ROPPuNlOtT3GtNKXrSrIxPLiNnEkUiOxxvxQ7C7E79JNOMr5elb/t0U4KCc3raZNxWdU
         bTPvtPuCdUXKSQTZuJOa4/AQbKomztVCvJo30PunNBkedhCyJYgSJsbJ/DhGx+caypLn
         EYu0RaDOohf6aLBMsdqOfid7cuf5bckmNiWA7By44CkPYFW/2zTXbPjEwpdwEiXw3BRO
         /MvzZIdIHEya9M3y1fd9S0zJB7e8NvDnPYw5fA+c+YKmATmvdaI1z1lx54f30adYdNMU
         /UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCSL/LzkhNi9/Yo+HPZHeRZeUrOizjlzKGlapanJ1xM=;
        b=m2jXsWz4kRbRly2wugCm9NhZ3S81GwYsIbPVvQZiVeOtuKfNvlsG3URZee0rbjKhEh
         qJMkaP6qTR7yOfuhn3oSnlRqjXg/QBM35fdF08SgD5BIb8NdMuI9xekA/gKWXvCbvqsx
         O2w370ddkR/ptf7Rns2GjezqS4AGEsnXO1T1zIbzgZ9vN1JeKkDc2kRZLXoAjxqbhPya
         BkwVu4ZAToJtL6k0ZVTOx8C480LOMVNaKrz15FqeM6ydP/+iSusdjHZcCPdveJpWQ8Bp
         7Uk6m1tOynxtNSOF3nI6d93rJiFj3D7/oiAC/DK2KVD21bWEJI+341bfrF1Nuqkk1AR0
         DF2A==
X-Gm-Message-State: AOAM5323jCfyZC8UnLQqHrrhShS+fvS2aPVAhHyU7qqqEnEAcaQtJtj/
        uPnc8XT0GfRzeUcvAHOTUHAWQw==
X-Google-Smtp-Source: ABdhPJyXq2uFNzdT1Lkr6Bc6wkcyQlArBSXonBxiZ9uC4RsgaiSryy2j2LFgganO1LozKse60VZKYg==
X-Received: by 2002:adf:e9ca:: with SMTP id l10mr3635782wrn.37.1628149839997;
        Thu, 05 Aug 2021 00:50:39 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id h16sm5154491wre.52.2021.08.05.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 00:50:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/3] power: reset: Enable tristate on restart power-off driver
Date:   Thu,  5 Aug 2021 08:50:32 +0100
Message-Id: <20210805075032.723037-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210805075032.723037-1-lee.jones@linaro.org>
References: <20210805075032.723037-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elliot Berman <eberman@codeaurora.org>

Since reboot_mode is an exported symbol, restart power-off driver can be
compiled as module.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4d1192062508d..e155b2e2a75c4 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -192,7 +192,7 @@ config POWER_RESET_REGULATOR
 	  power regulator defined in the devicetree.
 
 config POWER_RESET_RESTART
-	bool "Restart power-off driver"
+	tristate "Restart power-off driver"
 	help
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
-- 
2.32.0.605.g8dce9f2422-goog

