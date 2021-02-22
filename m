Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44867321A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhBVOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhBVOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:08:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C76C061574;
        Mon, 22 Feb 2021 06:08:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so19223384wry.2;
        Mon, 22 Feb 2021 06:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHpdDwi1tvHtdUt7JS/xQ2o+l1NtZtKZiQlCl89/YrI=;
        b=Y/OrMnvXXNxqt2sUE5GEzzjhOwrzyzeIAWIJC7l1tbQ6WgswCNczcPlmTv0+OAqXcv
         JXsJvY6YFT8uY04Oeya7uTdl88AmNNQyKDP480hP3Q1qZTwXdT9I6M0ozhyZLU/TMRQJ
         GHulwdecPx/Ohi42uxJcKpoe2mFSOMtTNCgPzoNZ4i5XXVRdMVLXvvELpJTgmtQENphQ
         a6FW+6QF6Msdg6b1zP684HHPSy2fG32zGT4vnqagyFrnCqiJVDfu4X3H904Lv4gcjuzZ
         mGOTLkSudUywy3kB8siWrBmduYT3c2xZEXE06Uyyk53b9QlHwOpcQYE4W9STtOBSQJVs
         8SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHpdDwi1tvHtdUt7JS/xQ2o+l1NtZtKZiQlCl89/YrI=;
        b=AAtdnKlahv5gQIyjXZlVm5Q1gnsIlububXX/hAW0x2MGjes8dpSMG9ypIbG4GUDkiW
         J/3F7BxG0WJlyesHcNXo/jDfgE4QkY/l1khWkeJaoT9n/LT32cAlZU9gw8vZQjlKJte2
         4HxOP1Fdp0h4vKROXL01krme2MWPXuEZArL1EgR1Xt0prpjQdK9pJe6IqoKLuIC0jfd/
         1W48UtTZd0hImlvVYLUsWKc8PdO6sWIpoeZF9htNDtuAKilLgnFGfcSmuOS0d8JckwPr
         ZJrq5qr3jKaOOMOZCYta7opsefOKFI4IBZnVlGMnePFHCEE62MoGNUndjLvHiBQNkHZ4
         AGgg==
X-Gm-Message-State: AOAM531DNlPsu0ZpHH3KEdTIR3Qz0GG9NrD282mwNgWRDsHGSBlEUj0w
        0HKwzYTzjFpnS/AlK0hAdCsmkYYcCLLtoqV3
X-Google-Smtp-Source: ABdhPJzyAWXD9U4AEcw7PvQx49jZSPW5+fBOqocI0yWw5puv+9mfPwp7mWu5OgCmX1KSSBpjiyewCQ==
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr22214634wrz.109.1614002882147;
        Mon, 22 Feb 2021 06:08:02 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id g18sm27966308wrw.40.2021.02.22.06.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 06:08:01 -0800 (PST)
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
Subject: [PATCH v2 0/2] add Kontron pITX-imx8m board
Date:   Mon, 22 Feb 2021 15:07:54 +0100
Message-Id: <20210222140756.713-1-heiko.thiery@gmail.com>
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
 .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 641 ++++++++++++++++++
 3 files changed, 643 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts

-- 
2.30.0

