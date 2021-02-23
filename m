Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D771132313E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhBWTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhBWTRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:17:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7AC061574;
        Tue, 23 Feb 2021 11:16:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j187so2880wmj.1;
        Tue, 23 Feb 2021 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pG1hrGI3tg5yh8EByPc8OaP+tVeHcBRHYeO2MC7H+Nk=;
        b=KyGq+uAdcglJDkaf/5t9VOPn1yUqgLR57hDD7msXYmsHrFQqLdshT4sFwyNNhm1R73
         szf45gQpjhZbBtoXul2RCljh803iX+6XYX6ZcbGvNewehxBM7BUEeGOiR8VXKXHH/jHI
         beMwb60KLsxeThzgtyLPszd1uVU+Hit8Allj//RlujEzwRsP7ZYSgmiug1xgfAY6cvGl
         2VRT0DHpOsnlOIc7gs63Q+0qTyOlJvNAxiSb6F5G/KPVwl/+Q8K7GEHHzdEo6hIRFd93
         fpbtYo+cP7X7YcUeu///TJhhX4o31zdvKdGXkAFzLOBTqfihv4mPbPH3Iti9MrHFuN/v
         zriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pG1hrGI3tg5yh8EByPc8OaP+tVeHcBRHYeO2MC7H+Nk=;
        b=YH8cgAGJ2g4fZqejlycqoo1rNZS5yotY54zemWwGzj2SBj6npn2kEuZvEbK5S9Pq+N
         rkNFmFqrjvJsaJWMRagZ3t75qGpchp52/X7Qz+vLD80rr/Co5/HGo2gXA+PdteHSNflK
         +2CtpJrF6+D/yxSfZjCZKwKdgUgTq4atp/3rvrV0WBfWPHvPUAm5ZxaSifqO8O7g5U+/
         R1d173nkz4l3FvIpJ0cp/GKJOsFLXgY1JWwgEULStwGX1iA694y1sk/CA1I7XaOcLlp9
         dm56XlOLbLD+Md2q04MFciqzXeUKxVY3nvOYRVL2bcEKltCpqjL57P75uzEMf9I5S1lt
         wkkw==
X-Gm-Message-State: AOAM5321yK+01qbLZ70mdhKYm0n2jj24PYPAn4ukVSY2dFeHQNx7avWe
        wfuR9dsVMdL4Fi+WSA5ti0Q=
X-Google-Smtp-Source: ABdhPJwT0N8KoKbSWN3cOPyYFAaWXUaM1qOle/uZ7cDQs4Vxuo77IsqlHu6pYZrgwnoC4N1lfXnj0w==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr211090wmb.117.1614107816659;
        Tue, 23 Feb 2021 11:16:56 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:56 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 00/10] Add peripheral support for imx8mm-nitrogen-r2 board
Date:   Tue, 23 Feb 2021 20:16:43 +0100
Message-Id: <20210223191652.436397-1-adrien.grassein@gmail.com>
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

Update in v2:
  - Fix some typo found in v1;
  - Fix UART description

Update in v3
  - Fix wlan vqmcc regulator;
  - Remove useless clock node;
  - Split UART patch

Update in v4
  - Fix audio binding;
  - Add a patch to fix eMMC binding.

Thanks,

Adrien Grassein (10):
  arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
  arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
  arm64: dts: imx8mm-nitrogen-r2: add USB support
  arm64: dts: imx8mm-nitrogen-r2: add espi2 support
  arm64: dts: imx8mm-nitrogen-r2: add UARTs
  arm64: dts: imx8mm-nitrogen-r2: rework UART 2
  arm64: dts: imx8mm-nitrogen-r2: add PWMs
  arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
  arm64: dts: imx8mm-nitrogen-r2: add audio
  arm64: defconfig: Enable wm8960 audio driver.

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 314 +++++++++++++++++-
 arch/arm64/configs/defconfig                  |   1 +
 2 files changed, 313 insertions(+), 2 deletions(-)

-- 
2.25.1

