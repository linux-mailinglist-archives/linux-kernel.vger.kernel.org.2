Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3B322151
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBVVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhBVVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:25:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A0C06174A;
        Mon, 22 Feb 2021 13:24:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p3so560742wmc.2;
        Mon, 22 Feb 2021 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38e+U8k/6cZuOcCMlTvlYYecFoxJcJvt1vfIHMqNNTA=;
        b=hiHr5OleGoQRG1+VZcGyJ+EPYOABsL65qLqJhJugiczONjNGl4+ixLvEt9rIDN0Tlm
         gbpzgvypNvROuhii43U+FEr+Dfa09hPg50P4zt8D9Vu4lNCGnpRa2FznVc6bxd2BmnpA
         FLea1eCvYlv55IMEsRefsUEjwZIH8Mxbv24gmqtOj8zY+7NVlArHC3Nhbc8ImGNHmFUp
         MkUz66/FPxcyJT5VyrXqfpNTkI7pt1wbDXtzPcSTHOn+iZHPZkGZTcSDL3sP9xWcSglY
         F3pFDjui+7c5EqNao6+po1XNQIXwnD+wi8JyTM2F3JekBuIn1QM4c2zzgpI3t8kEjS+b
         R0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38e+U8k/6cZuOcCMlTvlYYecFoxJcJvt1vfIHMqNNTA=;
        b=PZOPsgxIL8TYVkE0blrjCLHNEnjonbTBrPheOqhUHuy1F3cd7XKBzOpvVJOBLSEeG4
         pWw1zRcwjx6spUZpndlMpDUMtIGb14vRQ5mrYBNrWVzN/UD8oaIgo5aK36oeD77+hRCn
         mVwC2yBW+O5S7jdC/Z9wpXCJDtoEA9mV/OgCVyazlMlRBPWzBcwB1naY6g1Z0jirsNSS
         IwcupeHUfU/ph8rcVMQhthh+sUUnBwUtyCXaMNTbm9N6pu1ciCPYg1Vx/1XoLodxhOaH
         OlPxt7ncHz7H3OEVkbpKJZ3BWlSsaGMjErjm2KN5taLA8RvK9KetEgBtKXBY4901YVcm
         Sq3A==
X-Gm-Message-State: AOAM530p5MR5M7k/bM7GWlmf+3ABvAh28y/Vdqu97a3Wd73mNbpqKMMy
        sTfqvasfP9bRyOa0lIRjmzrODIlLvm7cCsMX
X-Google-Smtp-Source: ABdhPJxSKD0ALa9pqAEpe0cc+MemrnUejENnMcREw74GQmBu1rdgC2CH9xosHbhkqmptFmVIm54g5A==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr22279684wmg.149.1614029078640;
        Mon, 22 Feb 2021 13:24:38 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id w25sm478582wmc.42.2021.02.22.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:24:38 -0800 (PST)
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
Subject: [PATCH v3 0/2] add Kontron pITX-imx8m board
Date:   Mon, 22 Feb 2021 22:24:17 +0100
Message-Id: <20210222212419.25180-1-heiko.thiery@gmail.com>
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
 .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 632 ++++++++++++++++++
 3 files changed, 634 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts

-- 
2.30.0

