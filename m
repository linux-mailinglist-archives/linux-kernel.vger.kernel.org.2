Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1B41E37E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbhI3Vw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhI3Vw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:52:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B5C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:51:13 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so9202532otu.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FYmJqhBP9Gy5I1JVDj0HW7OppwoO5pAX8Rg1hw6n6CA=;
        b=YeNEvEBk8SLRom8LultWOuQewDBu1X4/91nIAKjtOyEauCf/W3CvI0biMBm3yZ27iw
         ySMu43hW+BXzYnWZ5aSE7qE5Qd+SIVPqsmhDER1eBFE0yULqvsoEWJ6vOEbbfuSUV+ZY
         VMAiymy275ZtEGn9hUErbiuHm4ePNE2F+NeCfBMsKfeIt+Fx0ojXMnqXp8d6eC7Eoou9
         JVvZ15i8ZvFEHl9v5pPZv2GF6tOahSLL/Vo1A87pCTUvjzvDiBSXduZHYl9ARaCDpBm0
         XkiIE60aSDDz/U9FX+W6Fvwww79dreIf6hjA281+T1sBKeN2au95I1U8m0IFiIvMbBbe
         9cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FYmJqhBP9Gy5I1JVDj0HW7OppwoO5pAX8Rg1hw6n6CA=;
        b=v7GZKJ1KPkW0SJvJsJ1C9zIaKRFsRlaD5van42D5TRl2tAAGkkqWT7Ctepclp0p0II
         m/hflySESwAFsFFe+DO0DP4Qf5WFR5ghdyCuzOhTZ7afKSJLiMY/PD6of+CIRaBbsq1K
         tt2yoe6LiWx9Vl4PhRH2/eFp7mIoJyKFE5YNsGD8UC3FD4rqFyUUV3Ifmf6Xa6aGUQhL
         fa4sZ1zRs7F65g0xvGNWia/jhxwFWipGSL4+MhpI1FQmnRTXmVbkKS/wEQxIXx6fdpaT
         4G56+9+JjJ1VcqX4pkox6+oWN3Glq2EaF21IUQYfoq4Guoa8baG/IzYcIlkTGK6Aa9Ls
         thbw==
X-Gm-Message-State: AOAM533R6r5W0dzDj16YA8FJLbnSvEZ/2KcuW7+pL/+ZMj5Z05y5NNyc
        w8UBRe2FpUyUzyniPocUGjXnWA==
X-Google-Smtp-Source: ABdhPJwNJ5kqZrlgIyGNRUEqn1VIxbpJK1XB/LsvhT2fRtitc9fd94G6D8uZQPNl3VcNYORLiYbsjw==
X-Received: by 2002:a05:6830:2706:: with SMTP id j6mr7359200otu.380.1633038673122;
        Thu, 30 Sep 2021 14:51:13 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h1sm846908otm.45.2021.09.30.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:51:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH] arm64: defconfig: Disable firmware sysfs fallback
Date:   Thu, 30 Sep 2021 14:53:00 -0700
Message-Id: <20210930215300.60290-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the enablement of SDMA on the IMX platforms, '7f4e4afa140c
("arm64: defconfig: Enable SDMA on i.mx8mq/8mm")' also enabled
CONFIG_FW_LOADER_USER_HELPER_FALLBACK, to allow "firmware loaded by
udev".

Unfortunately having the fallback enabled does, due to the 60 second
timeout, essentially requiring userspace to provide a firmware loader.
But systemd dropped the support for this interface back in 2014 and
because arm64 is the only architecture that has this enabled, there
doesn't seem to be any standard solution available.

Examples of this problem can be found in e.g. the ath10k driver, which
with a standard distro can take about 10 minutes before wlan0 appears.

The alternative to this patch would be to change these drivers to use
firmware_request_direct(), to avoid the sysfs fallback. But that would
prevent other systems, such as Android, to rely on a userspace firmware
loader to pick the firmware from a non-standard place, with just a
custom defconfig.

This patch therefor attempts to align the arm64 defconfig will all other
architectures in the upstream kernel.

Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index da988a54bfb9..f9e0b3fdaf0b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -243,7 +243,6 @@ CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_FSL_MC_BUS=y
-- 
2.29.2

