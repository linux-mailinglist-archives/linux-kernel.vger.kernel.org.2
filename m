Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACAD3256AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBYT2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhBYTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:25:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF35C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id f8so3752478plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZTtKUM3ywIyFpIjcIgukbnF3keZtJpSlDzhBl/MLhA=;
        b=JZvW3UwGJ2b4wGpTvl5DULBTFsVEMTGyBwd4kawjDGipjTGpVn81s5qjcgvhuC/VhF
         EsDuBLvbr2tSiPLOj3O0iP96I+ez1Ji0dAjTaLDDJUr00lOX8k8WWf2Ls2eO4DNhldga
         BvLLrkeVCbAUGq7YDDDa3gHf2AVCEIxxrsDPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZTtKUM3ywIyFpIjcIgukbnF3keZtJpSlDzhBl/MLhA=;
        b=tkwDtQ/7Ppow3ahkTxDTR+psLH94oNisaH1kdKJydBwfFeBxAvNdX7kJis38B0FVku
         IA2z+6mI7uDy9eyGzsPiOxVjkG6J1+tRMehNBeIYAynsN4+1niSgj5+SVfLTeGtsm5tN
         mlTaxD04+KVy7RJh1hId8ehtX+9n/sCVi6GNDZSLLAwpmfYKV5Uy9pl9RiV+fxmH+4i+
         hfrJRtkIZSkvAoqpj8zjwjpiN19BaC61nqhjCF0xxCAMwO1D8Av0V6KXumDE6QjK5ZPZ
         ak+TzO+qk9UBwboZC0JA+m16YjO5XZw545BX/UC5Qqz8sXKf0uIRGXX9R5lNkOE39HjY
         SafA==
X-Gm-Message-State: AOAM533Q2070n0KxDEr1Zfrbut8ehrJQEHYn0irxeh7m3FCG7208dKp7
        ny6kMnZPHBdAnVAwjWeNgogpiQ==
X-Google-Smtp-Source: ABdhPJwVDk5EdFhPslHl1zSJjacq3zIWPjAV0NC0NKJryJoi1FWfSSIfwd3CEKhHrc9CiFKQhEstEg==
X-Received: by 2002:a17:90b:1808:: with SMTP id lw8mr4578361pjb.203.1614281102335;
        Thu, 25 Feb 2021 11:25:02 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id c78sm7025787pfc.212.2021.02.25.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:25:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 0/5] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
Date:   Fri, 26 Feb 2021 00:53:59 +0530
Message-Id: <20210225192404.262453-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series for Engicam i.Core MX8M Mini SOM and it's associated 
carrier board dts(i) support.

Changes for v4:
- rebase on linux-next
- fixed Krzysztof comments
Changes for v3:
- don't maintain common nodes and include it, if no feature diff
- keep min/max regulator hoping
- collect Krzysztof r-b
- fix dt-bindings

Jagan Teki (5):
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
  dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
  arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   8 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  |  97 ++++++++
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts |  97 ++++++++
 .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi

-- 
2.25.1

