Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171131C445
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBOXUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBOXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:20:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1DC061574;
        Mon, 15 Feb 2021 15:19:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o82so168598wme.1;
        Mon, 15 Feb 2021 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb33F88LVPtKllDV+VocMmBqPskM1NoJ9tknfCCxZb0=;
        b=WW7R1OkRwvE80hpNJNPgl9Vor3WDSQhfWTbL64mlfHqufSWbbUDhaKBAIL4f6LydHY
         vSW6zD0+W4lKC0ND2h9TSztYFGY91W3P7Y8kRMHk3nmOao6LHjvihq2cQeTsuqZ8D/dQ
         mUv23Guwm+WucibtEWJM45HUTJpZYbf6EBd05MRS3Ugc/8XjCUqHSLBKHOEKpCLl/dU1
         SoCRlpFcL7BkwUGIVknA0D0yc6yyelg8pw4NfoV8tr61kIo8OR5gb6luxAVtwmvv+Civ
         czQLTpq7YwX2i26qbBqSs1rB7+xs0kSWvSuXDTu80kzvHp2buIwhLBdivui5Dgvn0rjO
         oRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb33F88LVPtKllDV+VocMmBqPskM1NoJ9tknfCCxZb0=;
        b=qB/QdHFi3wucHC18lZeiq3sRHqheZupzFTfJI8d9zAE+ldbF8UiHcekHE9A5Yb/LP3
         1+0mP150HWJXrrweiCJ140cR/N1QRfyOXbgVgTUfY8aHtrgagGs6UmXDeoke2v5guMC4
         Ss5tpao04AakcHL9Y2aeYkvr7zfrCqZ8wCyGGjybnRDfmxddg0MYTxrwJmb/ITq9usdn
         MUz5AiOLW2aV3/DScmwjeKZGYTalk2jOTWqpQJJvGppk4z92NDpZLuE6zCI9FS4n1ZXw
         IQ5azVrHMDOLKPHlEOIjbSGBdcTDvcYwdQzos7MeSLwB2IGrv40yGCPN9NWf5bk9gw5c
         pJ4A==
X-Gm-Message-State: AOAM533sLj2dkWfXYtpD6YxYlWFfoVvCzWi0qFK/4cJDDN1eTgVmcJim
        PLLQmoSo02fiH55oLgG879g=
X-Google-Smtp-Source: ABdhPJzlqgKQVX+8XDLJssuzBMQLfNH+ivWyTKt6e5R5yNHmJ3k92p9LDZdmElvo+2hZOM57AJU57A==
X-Received: by 2002:a1c:98d4:: with SMTP id a203mr901335wme.10.1613431191637;
        Mon, 15 Feb 2021 15:19:51 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:51 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 0/8] Add peripheral support for imx8mm-nitrogen-r2 board
Date:   Tue, 16 Feb 2021 00:19:35 +0100
Message-Id: <20210215231943.36910-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set is to add several peripheral support for the
imx8mm-nitrogen-r2 board.

Thanks, 

Adrien Grassein (8):
  arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
  arm64: dts: imx8mm-nitrogen-r2: add USB support
  arm64: dts: imx8mm-nitrogen-r2: add espi2 support
  arm64: dts: imx8mm-nitrogen-r2: add uarts
  arm64: dts: imx8mm-nitrogen-r2: add pwms
  arm64: dts: imx8mm-nitrogen-r2: add flexspi
  arm64: dts: imx8mm-nitrogen-r2: add sai
  arm64: defconfig: Enable wm8960 audio driver.

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 308 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 309 insertions(+)

-- 
2.25.1

