Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97D337E31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCKT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:28:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53333C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:28:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y124-20020a1c32820000b029010c93864955so14137199wmy.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KT/QkJKHYYYVxuXr//3vN70MVIMoRHYSQxvNPSUosrg=;
        b=g1RFp7xXQ+dkgokIvGw2kNTSCl70VveI/aTp3skyWdUmzJrnqibOhYRM3w/KJU9oEP
         cCEt6I7vPMa8HfdsDk48TK9JxQQeKRoosGrr2Mhv7/FBkpLr8g+q97ZtwrUybAAgqJKc
         4gB7tofkKRTf5CGZPG2Yl4pMm7dMCfs7xvWhoENi32uf1cAzyjWg7ggt5pnhVU2fwEkY
         8B9jhkv4W/nvkXbNEim+Zolv0mqRVyoHZBWSh8qgBoZPBIl+QRdFUcJMrpSofgHOy/EF
         QRWZJmLgZBJ1Dbg4UiIGW9iIT3+Tp/AKFnOKCqEtdNp+T+ZhoQoR3KPkhUHdSYHJMtyb
         NiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KT/QkJKHYYYVxuXr//3vN70MVIMoRHYSQxvNPSUosrg=;
        b=DN47rekupPBoNO3nwQiVNjBMnPeTkDtkPaIDmcGFmwmqsKWlNpfVxRJTkuejVelA2A
         GgBvluuE+7z4vvkfxXUlI28N2BXkfPV5JHQ/FpN6Wagf4frqBPceTxmoPx775t/lJTnm
         H44hAo4hX8hBBRbND8efXFvilLgx9glTKDOx4McAu0VPZuz0/QbG2E47ss+FU9h6YU6f
         ioVoUqigffkpy4x6FOL/fYg4ozRxbf8m9O7GsTxk0DdUOaQquFkMFcmz4jQcaNiPayXc
         LqAE9caMrDLj1VOJk0YqbKGc6ZoxMJWe7BPDLDbaXyFOf1/mm+JK+ztvgaiISZPd54RR
         bA6g==
X-Gm-Message-State: AOAM530OgZlb+GQ1PGFR10VRlZ8j00YVNTOQZAZEp2/h4wQgkAePdKdT
        lfy2EL142EcsU/Bc6lZiXp4=
X-Google-Smtp-Source: ABdhPJwkN5ddGJ9oiEUNt4iP45Gw+kfhCqRLTAOBg+mecqd6S3I636zfbTFFC5UZlNwIAxI8TJOqeA==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr9943765wmb.46.1615490921017;
        Thu, 11 Mar 2021 11:28:41 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id v9sm5277989wrn.86.2021.03.11.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:28:40 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH v2] arm64: configs: Enable PCIe support for imx8mq boards
Date:   Thu, 11 Mar 2021 20:27:47 +0100
Message-Id: <20210311192746.7362-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
v2:
 - slightly modified the commit message (Fabio Estevam)

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f673b00c5f5..522bae6a8f21 100644
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

