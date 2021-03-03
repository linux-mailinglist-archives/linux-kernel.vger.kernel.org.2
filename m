Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A907332C2EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354028AbhCDAGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574785AbhCCVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:12:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE5C061761;
        Wed,  3 Mar 2021 13:10:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l22so6281263wme.1;
        Wed, 03 Mar 2021 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1hVb64++yJApAm3B8Tu4MMiI3NLOIPswavPPO9bVgw=;
        b=M7j5RyQpEpxkOlvJepyq4K8SkeBc0qBg0r7T9hvfQx14M8jfXYAsHCC0tQrISlGeKS
         Zxv2VgvYhn/aaanoNK8MILPpQjRF4tWUiWQi7aBQQHZ9cTYtEKP/yUZ9jxorrE+/sS3n
         EzyDS/F7gpJeId8H0PejfT+6KXlEMLpuTdkur6orNopdFFU3zfN21bSflVaaiu4PyP4x
         uX8OV6JdygxS5pNNvOk+YkRmRVlaI8LJ/5KuKvHIrJlmTzYVNQOTSpGG3Kd792/Yp4mN
         wQFW4DduuY+p8YE9VXjGtkY2K+gwmgdOw5jQP9nATBb/Oaa4ylJp8Ql30uWXZTtIYY52
         ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1hVb64++yJApAm3B8Tu4MMiI3NLOIPswavPPO9bVgw=;
        b=ShpsW8LYzokVLJyCoHa2dHU/6tyxjw0YgYz5xxc1Nl0bG8BtXbn+QhqsnNQCNcotAC
         mvpvsU3R3xe+tWIqMwqDpMAgAzrN83DUt3kdmWKcZeG7uHvFRKdnBtNNiLzWE7LKXPXs
         oef4BcJQjYpG51JFRGDLldnQYzt6LIjj2Is+A4TzPeGyducOaNc0nzpRZhVtH9lja17n
         FfNYgIw5AHmMib/rIdshDrORG/D1vdw57OwyxRn2j5nXRpu+R78WGHGpcsfkEaEdVLZh
         obulPjmerhGRIKZLNFgbsYV2u2CY8SDlOMOlnFoPrmJvyzqjsx6WuH0vuls42gndPDUp
         T0sw==
X-Gm-Message-State: AOAM530dP2Fy8/TwDjrl2qhuwrfKs5mIxSO3mVC+m734AjJWQo1d6cO/
        2i0x8HRuw9epQ1v7UbchO1gdEKCgPRTH9Q==
X-Google-Smtp-Source: ABdhPJw4CZ9pjEl4f8S4btNDtnIQX0S8QiIwzabJvbRBZo8HSLqoUM7zDKd0q60XZGwfFIMellTpHQ==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr796682wmm.42.1614805851411;
        Wed, 03 Mar 2021 13:10:51 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id y18sm32684684wrq.61.2021.03.03.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 13:10:51 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH v4 0/2] add Kontron pITX-imx8m board
Date:   Wed,  3 Mar 2021 22:10:01 +0100
Message-Id: <20210303211002.17650-1-heiko.thiery@gmail.com>
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
 .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 611 ++++++++++++++++++
 3 files changed, 613 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts

-- 
2.30.0

