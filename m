Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24E833F00C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCQMMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:11:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB24C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:11:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso3254573wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldblq7Vb7cxp8+wcYSniKSm/VJ2FDNg1/QRrPmH/VVY=;
        b=FL48WkTHhMJJIkroO5yH5Ojgj73oIdrWpr+6pn/UaB2n0DtHjj0f0QktOGb8fBCgYC
         QvAgRvoDWDcoLxWCX19KabbE9ygEhsnqqQ2sreY2p5gaAlfhkt0hDt584gVIlpXB4bCm
         mAes8UKFiUwZIetZFDuEzCtS7HLhF5jql8triChy082V5RD5gFfL5rrgaE+nrM1uQ/rd
         IJNA2jM5XTfGL7J548uBw+CIhookRCvmZ8IHSOOtqRcs7Bx77fW95lQWiu2PZ+UwrJwi
         rV+WIBig7+SCxEE98np2cZdK2HhQ8P/OAoBz4ajhx6FU2Isg6zDMcZ9D8exQx4BS+ow6
         F9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldblq7Vb7cxp8+wcYSniKSm/VJ2FDNg1/QRrPmH/VVY=;
        b=dJre5zGyJWscv6T4zzncVAfaxR4CwoXMs6IE/DqQLYxS3Ie+NiaM5WaJ4CrFAgZQuC
         xiaGKMdHaVVaEufaM/4cEZfz/5F5IUw03hA5/BA5j0oGhHwC2z5fgPajpjE2jDNzXrY+
         MnrP1gkAMpGPOFJc9ThRBj58OgBvQF6nUQ7Oe+MRq7BN1pK69AEnCf4Vsv2HWaKeZ1Ru
         HMn/H2XsIx1ueyjkpk7sE0r3Iw6lHFcmC8RGUBex7VqXX/PeGL0SRs7bpCmOieiU0kzG
         9t3BLayuEOIOZjH4SSPc3iJ7DNdymOy+JC5Ju2c+I0iVSIK1hwNK3r9eZa+OMKqTPJVT
         g+Ew==
X-Gm-Message-State: AOAM531HXJDXc4MLsSpXyy+VVlVxFM7DnsM4DIwP/nyvY/BhpZcs6JPZ
        svsYxNkGxDcErmTyHdyJKc6+YVYk2kcuM1Xn
X-Google-Smtp-Source: ABdhPJz5iMgHCktM9jfXw+fxxb1Fud4xod4WnnNL+5gN9m+1BpIL+LvnHOofsQTsX8eZwI33zryuaA==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr3451490wmk.82.1615983111000;
        Wed, 17 Mar 2021 05:11:51 -0700 (PDT)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id f7sm2239586wmq.11.2021.03.17.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 05:11:50 -0700 (PDT)
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
Subject: [PATCH v3] arm64: configs: Enable PCIe support for imx8mq boards
Date:   Wed, 17 Mar 2021 13:11:37 +0100
Message-Id: <20210317121136.7023-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.

The driver only has build-in support and cannot be compiled as module.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
v2:
 - slightly modified the commit message (Fabio Estevam)

v3:
 - add comment in the commit message to clarify why the driver has to be
   build as built-in

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 72ba52ad5a3c..54445b936066 100644
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

