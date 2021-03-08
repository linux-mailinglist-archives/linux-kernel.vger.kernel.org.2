Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEE3309E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCHJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCHJDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:03:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFBC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:03:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u187so5555853wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuyZs6M+UzCVfDj2nK0tA2CpdT68UL1xPL9B0b4Wjbc=;
        b=AFWBxZi7hSnSDe6mZMb4EFVw2s0UVsmV/3Zm4R60eyQKdCQlXLddsXa5e70221H9bg
         wAVEPi7yNZdMoVvW7LHyv5ZARSne30L3r/QdofaIlmC1MrUXp1JKzWD2FLpfuuJlCmJn
         AfwirH+iQg5XuxPkndHeM9XcrD+xSOQfIzdsuaCXN/IhDs5KJ8qcyGng/vlUs52rpPfl
         417Rnk2CpmHxp7BaP8t070u6q6jynus0rJ2FMawbNdWLfVF6+tVo8l2XCRTvv5NJtllR
         pAo43f50S1G2TiCOAYd170YkJXv4MZqVfN/ZXjlyeoH/s3ErBFKeY00Nbk8vgt1OiYP5
         6M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuyZs6M+UzCVfDj2nK0tA2CpdT68UL1xPL9B0b4Wjbc=;
        b=K3i9d5Lq6c9Vw4BrsDKUjHThVEUFMVbIY0/zhnZQD/GSsNMIvC8kA3QZC6BxpwCNHW
         QIA5LpcTAX231vKLFWztq+TBdtQpAiCyDUvhdcFWOxd67ygD3ulq/9jWXMYqOys+q3bU
         5QSJKHtfnRInxPMOdxEP9TsdulJTALGUyqnGOCA0BgFNifOXv5gFFjhz6PdbbArkccqi
         NR7AEappGcXJE0NXrwwLlwA2jtGNenaJpbxo0vdFvhSWIfHu7dxFD5kO8IB3FIr3olfL
         +ry29r2dZu9kJC8gW8MxyHbSXS7KJM2OiFsur2jmeSUXvjswalDSH7DF0mae0bMULptm
         XzGw==
X-Gm-Message-State: AOAM533tVrMU8Jyo/IkeM5dihwkGJ5BEEMRTaxPAPDXWsytlAphsXS3M
        0J3PEDN5zM61YcDv3vspLNg=
X-Google-Smtp-Source: ABdhPJy/xQ8AjCQdjH88S6wYDSGuP8h58oLTJ4NjjdwvaqvF93GH7qHf2sQLILF2RrTyvrEpE/maTw==
X-Received: by 2002:a1c:28c1:: with SMTP id o184mr20402728wmo.183.1615194215756;
        Mon, 08 Mar 2021 01:03:35 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id j9sm17854477wmi.24.2021.03.08.01.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:03:35 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH] arm64: configs: Enable PCIe support for imx8mq boards
Date:   Mon,  8 Mar 2021 10:03:30 +0100
Message-Id: <20210308090329.17507-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra. This increases the image
by 64k.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..4b7b4a8f1860 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=y
 CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCIE_BRCMSTB=m
+CONFIG_PCI_IMX6=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_HISI=y
-- 
2.30.0

