Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD54163D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhIWRJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhIWRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:09:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A3C061574;
        Thu, 23 Sep 2021 10:08:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u15so19169959wru.6;
        Thu, 23 Sep 2021 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEdFUmDtzLwxUKs9gCVZRhN3r25RM9NqfmUoNAophek=;
        b=mB0T9T3Chbva2NHTHcb2gBY4SsV+ItKo/pPSUFq7+l4XVbzSrnmYDVqmJGpK1FTy4D
         SO7hKPn/EnckVX2xXwyoHtOiCEuuSVLO1721J4KscjtOwSNNBpj27NEkG9QO0JLq0vEs
         Z2y0Fs4E4syrXXr4ZK/sSBYIAElgMcaISGs9Eis840LOjsm8AzqoT/8wFsb/99bXhk2Q
         BYDpnz2TTfQVJ4m4BKpq69UYJZDLdaM9G2d4Oa1qOtC/wwk4lV6ofd5K4lbY1lLkpfN7
         D3Ct/T0sr0aTcZAoOFfZKqO/sFeM1y/+5is8a2zbBAmRD7OUVqAFdrcj4kQkNFsgo6UB
         CFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEdFUmDtzLwxUKs9gCVZRhN3r25RM9NqfmUoNAophek=;
        b=abymkYyCDCFIlwmerfwlMPyGCFgdoiZzrnPYi69tPcQABe8Z9ihDBgKeK8yzLA1Rhb
         nz8VSpi8LEX0k2ZtzMsrn/LsBD3CKO9rfznW5XsLeg1D0JvRkBRZ0LVim4dZfHj0tE3X
         IquYPaptSkmRaddsuqTAbdFJnlaZyDDa8Lc4dqCzNageYv73uDauEAe4Pjv8HYQgH9qn
         MRVTnyMB3HFJISCECiy1wn17PVgaIE8tylG8ti1KeTStutCNvVW97zQGBkBvWV8fu4kz
         gHJ4H+714hDrgwj066ibcermX5PV3C576ZGE4+snT7pjqg5MRVL8sFp1DZp2Z9d8BTSm
         VXQA==
X-Gm-Message-State: AOAM531x0QZgyouHeCPEdyywovAQciOyQFdNx2Dg/q7HnCSFVEwKc+nT
        oUJFWZTEAlGCoSazzXT/Ee7OIagZb24=
X-Google-Smtp-Source: ABdhPJy+NMGBRIWFkNwWsjhSK8BJk3ybroGVYmQ/7x6sqC8U5CNrgpapVXxyVyooneOWtu9trr3liA==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr6348688wru.331.1632416880296;
        Thu, 23 Sep 2021 10:08:00 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d3sm7004550wrb.36.2021.09.23.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:07:59 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add support for IDO-SBC2D06-V1B-22W
Date:   Thu, 23 Sep 2021 19:07:44 +0200
Message-Id: <20210923170747.5786-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDO-SOM2D01 is an ultra-small SOM module based on SigmaStar SSD201/SSD202
SoC (ARM Cortex A7 core). The module integrates WIFI, NAND and PM
circuits on a PCB area of 2.95CM x 2.95CM. The SoC integrates 128 MB of
DDR3 on-chip.

IDO-SBC2D06-V1B-22W is an dual-ethernet SBC powered by a IDO-SOM2D01,
that embeds a MicroSD card slot, 4-lane MIPI DSI connector for 4-inch
RGB565 display or 7-inch RGB888 display, Dual 10/100M Ethernet ports,
and more.

This series adds support for this SOM and this boards.

Changes since v2:
- Added Rob's acknowlegment
- Fixed warning with make dtbs_check regarding oneOf and the compatible
  strings of the DTS board.
- Fixed commit short message format for the first commit

Changes since v1:
- Removed the commit that adds me as co-maintainer (merged)
- Fixed alphabetic order in dt-bindings
- Moved the commit that adds vendor prefix before adding the DT for the
  board (re-ordered commits)
- Removed unneeded space

Romain Perier (3):
  ARM: dts: mstar: Mark timer with arm,cpu-registers-not-fw-configured
  dt-bindings: add vendor prefix for Wireless Tag
  ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/mstar-infinity2m-ssd201-som2d01.dtsi  | 20 +++++++++++++
 ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
 ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
 arch/arm/boot/dts/mstar-v7.dtsi               |  1 +
 7 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi

-- 
2.33.0

