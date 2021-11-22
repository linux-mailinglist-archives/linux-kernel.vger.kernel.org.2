Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDE458A22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhKVHzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhKVHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:55:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0194C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:52:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k4so13325838plx.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RIo6b7gmK4IYXUe1DoTdRALWvvAnaEpK12w1IXrlnqU=;
        b=t7FuivjODiqwLuAHZx/KfC5Prl8itJs+ogBRoUAT7v5I1kwWFdROOXl26Po28oYzOm
         62fbNxMIBTPeZt0B9XSOaUnl8eT4KtzQce7q7Du3R24uUC5wrXSDNyexfyeX32yVg65j
         p8FWNBGoJ7vHhdDrCu4fn43qKZZf2KcEGXbEbKvJjeScj3W9akF1+zb+ULEquZV8FD2O
         e+HRBgSZw0qgB0qk4tIVksCQ/bmzbytQZwDR+sCp5hNMNL2+sy9qfEuBmpX3S2K8dpiq
         hBOydc3/f+P3cwAUWlnnUSCd+KA/L4czK79o6LYiwYuBdV9zMzXkG6Cz0h0KVveYb8yH
         K5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RIo6b7gmK4IYXUe1DoTdRALWvvAnaEpK12w1IXrlnqU=;
        b=aSI0cTtk2LDipCU0eeOCzXD2M+jwpW5DKGdBXZg5p8vOyWD8dZ9gInWnUTfPb6nzCl
         GrjH0pixaKk403mEBsAfP6N2980aJHHzCtsR+i4Emb3igWqYkRed1gRaDPssm2T5ToEk
         rm5400Z/L/8/otRG4gUWdaZMkCSVfUm45lc3n9b/odg9kp0XF6ngNVk5Wk1UXoULiKau
         zsOeSUrfJusfNK72jgJ8HThFScAFxsyuZP8Xq68f6B3M57wE+BdjQtJ1DxkAi9fZNWHY
         JsNeQGyi5uHlcooVnH+0hPVaoYrFWQ/a35IcPjsfSMWUDV+8H/Gu3ddlEUWWs9zHaETL
         Kcvw==
X-Gm-Message-State: AOAM532DMdjxvvimVJRx5vrKOp07Jqb8eBC11uQVR29b5c93j1LnJW43
        phFrU50q3bnNMXzEwm5RA0MZQg==
X-Google-Smtp-Source: ABdhPJwlQ7UzBGfzuzYKV5e3PAqN06bY5rs3M2xs8RkmPTUCwYTyT6pkpvg67ZeL8NyaJgMsevYKig==
X-Received: by 2002:a17:903:124a:b0:143:a627:a992 with SMTP id u10-20020a170903124a00b00143a627a992mr102004893plh.32.1637567536553;
        Sun, 21 Nov 2021 23:52:16 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id bf13sm6355961pjb.47.2021.11.21.23.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:52:16 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add Qualcomm MPM irqchip driver support
Date:   Mon, 22 Nov 2021 15:52:05 +0800
Message-Id: <20211122075207.20114-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
interrupt controller.

Shawn Guo (2):
  dt-bindings: interrupt-controller: Add Qualcomm MPM support
  irqchip: Add Qualcomm MPM controller driver

 .../interrupt-controller/qcom,mpm.yaml        |  69 +++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/qcom-mpm.c                    | 542 ++++++++++++++++++
 4 files changed, 620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 drivers/irqchip/qcom-mpm.c

-- 
2.17.1

