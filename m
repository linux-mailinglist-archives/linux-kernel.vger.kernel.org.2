Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8288C34E33F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhC3If5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC3IfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:35:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3666C061762;
        Tue, 30 Mar 2021 01:35:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so15424452wrn.0;
        Tue, 30 Mar 2021 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+MDobgqAHU4DF2GJOTfJhDoQLuE9PjIussFb0vZJaQ=;
        b=tNofScY5rVKT5ELJJM4pGQ1RvW4rdFJm0C0urILnvbYrb/Nf013J35ghyNZKcODaS1
         rF8K12E/zVITR1f7qn/dnsBkP1bmfcgCOtEb9RiNpIapSdZznSyjA5dx2cuz0GlbGI3k
         hm5aXR3FMTOj69dQ7M/RgqVxH+dwnmQgTtusWrrGOfbdi1/XFQ4XOEtZOXpICrpcKDA7
         hrTYGqI8WRcguqtLgi8/0BffoODJMkYTKB03Bny5UJgRR1jqHckuWo4dWLc5071G5XD7
         glZ0GEeckU8rj7T3LxKH2kLaLicfRGG26geKgUX3Qx7uRZwUgH8EKSG+BeU49rqdesVS
         QB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+MDobgqAHU4DF2GJOTfJhDoQLuE9PjIussFb0vZJaQ=;
        b=Z4L282fn2tde9GDkRbC3i7EEyd9aDJM4Y+ZnG+tOVUsrDvsZDqaMBzXln81UDQGH7F
         Tw1i1kCoqpyLqnyL+jnJCRiTsMLv+kRL25pAoe2A2hssZayTcrYcRBKbAIAzY7kdWNwj
         OxW7cExpv+ljeYJD5kMV9XNfmJ1zHC/MdVyOi37+QKnCVoWwiGh7Aw8hvDfZHfGOu1va
         KCe3hn2CQRXDXjDQc3FiJDz/aemAZST0T9Yvax5AeqqSWeztJyndTTDZEWCMh6IBpipU
         TXOhc8CpYVoeK4PPqQN08Tu7vGaeAvFqHRSBG4Vk8Cqw5jYZ2GVb9rBl5sRE9KYBGG6y
         T6wA==
X-Gm-Message-State: AOAM53215XOjPorauZ4/HSmjPNZnNfFkiJuv/Cj1PFTcajsZP8ixZnP2
        0o0v/3bgu55AYDopzX5ItEIFYGho7JU=
X-Google-Smtp-Source: ABdhPJx02AtiHbnSVyb7F4AvrvRXUWYku4CEXBdH0AJ15jDZJAFpeIgQqPvQoDyKOzLbJSFuQX4uow==
X-Received: by 2002:a5d:6d48:: with SMTP id k8mr32654768wri.93.1617093322781;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id g9sm32830263wrp.14.2021.03.30.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 4/4] arm64: defconfig: Enable LT8912B DRM bridge driver
Date:   Tue, 30 Mar 2021 10:35:14 +0200
Message-Id: <20210330083514.5874-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330083514.5874-1-adrien.grassein@gmail.com>
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8 SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3f059bca9e24..39bddac5e44a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -690,6 +690,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_NWL_MIPI_DSI=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_SII902X=m
-- 
2.25.1

