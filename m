Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D864441C062
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhI2IPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:15:34 -0400
Received: from egress-ip33b.ess.de.barracuda.com ([18.185.115.237]:42860 "EHLO
        egress-ip33b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244524AbhI2IPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:15:32 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70]) by mx-outbound45-61.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Sep 2021 08:13:44 +0000
Received: by mail-pj1-f70.google.com with SMTP id mi13-20020a17090b4b4d00b0019ea046dd7cso4592521pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyUHhAJLzD6O3a6IUoTM/lbGK/I4j4fcLqNq/50FmGI=;
        b=VhZiptaKBaZiEvbekdn3/OEcfe/szf37n/rzJJJ6nOBS7e08FGHlUxC9MXPoxVaJLp
         HXb3/mSQJEwHSCqlP/Wp0KwCfuK0vnkmr/+gnrcj6Hb8UySl8+Zg/3dZQD5j1w8xmg0U
         SIdFOqyo/u0l2xhQdiOzt9Mr7NPl6meQ+XsLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyUHhAJLzD6O3a6IUoTM/lbGK/I4j4fcLqNq/50FmGI=;
        b=3k/HEsbqLrWseEfZcFXRqu+XD542mfxX5wRNogYp3WOq843AJWG8AyQhztzunLByut
         Nx2OTBfpHoGcJYPMpuj6BH5wM8tkTy8mTP5j1Bfw3NlJ8ZCUTS8OEHp3OY0udTs/0FWz
         7tTpqahRiCIwxJRsv7Bn/m3emuv8xwGdFCdbkj1Ly3AXH6CNr0ltiUvGCAwRG2amHP+e
         nsAexJrYFvuZ362+D5aaeNgAxUggHkub0xtVz8anS8EVI6Fr30CowFcEOipTvTuHI8dE
         +ycGgs2vpLHNftuBVW2n7bu4v74slDwmJAV4r614RoOtIDlxOenLP4PazBrGGx+6gge0
         7t/g==
X-Gm-Message-State: AOAM532jWB04SjFn0/rwyZK3pHbYzHLtNtIwG/+AEGhohJRf+ZJNh8tx
        7QfjZqt8c4VQY83y3V9i5JOzhABFue9C2hfB6UkPiS4tca1RLd+OY2DzO9u5rPTb1Qmyu1BX/rH
        fQll9if38hUMOx0gNjKDK+hMGn3T7sTf2eC333Fo8NJjKmUNqvi/51pWuADdA
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr4954933pjb.233.1632903223450;
        Wed, 29 Sep 2021 01:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybYluRGy2VA5Ncx5orI97NxdCKCUiMFs/73xU4nhlAJ79pcVD1saM0tjYkmPcSvv8IiWqduQ==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr4954909pjb.233.1632903223123;
        Wed, 29 Sep 2021 01:13:43 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id k14sm1152026pji.45.2021.09.29.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:13:42 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/4] arm64: dts: ti: Add support for J721E starter kit
Date:   Wed, 29 Sep 2021 13:43:29 +0530
Message-Id: <20210929081333.26454-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632903223-311581-620-18953-1
X-BESS-VER: 2019.1_20210928.1746
X-BESS-Apparent-Source-IP: 209.85.216.70
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234800 [from 
        cloudscan23-19.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi,
This series of patches add support for J721e Starter kit(SK)[1]. J721e SK
is a low cost, small form factor board designed for TI’s J721E SoC.

Changes in V3:
- Introduced IPC sub mailbox nodes patch.
- Introduced DDR carveout memory nodes patch.
- Updated board name to starter kit
- Fixed DTS binding errors.
- Updated commit message, $subject which includes adding board URL, 

V2: https://lore.kernel.org/all/20210602182237.12632-1-sinthu.raja@ti.com/
V1: https://lore.kernel.org/all/20210602182237.12632-1-sinthu.raja@ti.com/

[1]https://www.ti.com/tool/SK-TDA4VM

Sinthu Raja (4):
  dt-bindings: arm: ti: Add compatible for J721E SK
  arm64: dts: ti: Add support for J721E SK
  arm64: dts: ti: k3-j721e-sk: Add IPC sub-mailbox nodes
  arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes

 .../devicetree/bindings/arm/ti/k3.yaml        |    1 +
 arch/arm64/boot/dts/ti/Makefile               |    1 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 1002 +++++++++++++++++
 3 files changed, 1004 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk.dts

-- 
2.31.1

