Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A844631EAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhBROUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhBRMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:35:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC85C061574;
        Thu, 18 Feb 2021 04:33:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n10so3563343wmq.0;
        Thu, 18 Feb 2021 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zc+bBISyXXpr0HLyGKIPaYDYfH+oSojiNj1Qu7o39ZE=;
        b=jv0bgLLDQQB/8FmHplWu56DUPCGVJSfgXxtduuEOPINd+TolnxhB1RV7ILRD00+KNW
         S8BfxxeR8ni+l53vJAP8mxqPSDEqPf8/G0S92slYW1+KWEYPqzUPfza2AkmaOzcZ3N0r
         eb8G4pMx43ImFCyJyAiI1rcz1iHCQOMxZXMqva8E1w9kLP8Fasqg+7Tc4hUnzF0Dh7E3
         wdsNnCneQIHN+dljVmTRa4FmZOyw6TVveDIlHB6c33cghed3l71iWlSEVSReUhNs6nP4
         DZg3K73oYDcFRxe9Sn0Ke5XV90Lu8JYWsqVzV8WeuFq2xorsV/JU4GigHbDYULs3WU17
         x/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zc+bBISyXXpr0HLyGKIPaYDYfH+oSojiNj1Qu7o39ZE=;
        b=F4eK9dZDT2P8Iex2tE7b7Td0V+f9DlaJVevOc/EKt6VFFmaXuWx/r39ONiGJX3XMI6
         AO7w0/g8zHhYJ+tL3XO62FV8945lPici2mRpBBkApMZzXp1cFxeAh1z60MtoD4kR8h8m
         +5w3Rn30QPF5QlDquwatyzOs0dCaEM1di8qdZVYsKSjm/CH6qI1wUDR1KJo7DSBv5jrv
         VnUzP2e/KE2VRkDVvkDCVoq98ggK2f1jOrfMdFI0s/SwieyI2Wy6MUWI+rnnQIYABGLb
         jut2f6IgPORU/bkDpSnU1hQUDhb21iNKcSeDDOlM2+x81/xRmJzFTqWFgXpmyY4yHeoM
         udVw==
X-Gm-Message-State: AOAM5306h8Jf1PE1pbyG6rTegd7JtdZKsrbjn6oRzP+GBWZ18GR9UeY6
        Umkp51tD+QFr5ZclGHNfRHE=
X-Google-Smtp-Source: ABdhPJyZtXtl5M9bLxhQKmtVvEcbzbZexycq/sh/mxaRkLjyUH0Ok2XKwob1WsM7N3Lw3wPxhcdwsg==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr3414935wmj.54.1613651624439;
        Thu, 18 Feb 2021 04:33:44 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id z2sm7110818wmf.46.2021.02.18.04.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:33:43 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH 0/2] add Kontron pITX-imx8m board
Date:   Thu, 18 Feb 2021 13:33:25 +0100
Message-Id: <20210218123327.25486-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Kontron pITX-imx8m board:

https://www.kontron.com/products/boards-and-standard-form-factors/single-board-computer/pitx-imx8m.html

Heiko Thiery (2):
  dt-bindings: arm: fsl: add Kontron pITX-imx8m board
  arm64: dts: fsl: add support for Kontron pitx-imx8m board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 675 ++++++++++++++++++
 3 files changed, 677 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts

-- 
2.30.0

