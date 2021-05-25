Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAC38F751
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEYBJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEYBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B3C061574;
        Mon, 24 May 2021 18:07:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b81so7928965iof.2;
        Mon, 24 May 2021 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU66pV3thDPdC26eaOb27qnzlLR2FWVox82N0CzJfSg=;
        b=kYlhMd4SJod98c1qttbLSCrqyJFZ/o1Tkm5mzudMOofWsbvmnfTfyfdYskdrsUaPZA
         dP5c6BcPJ8ihIQz0axJO9b/lPjGTGENXycgzVBXUFzHdsK0BehITXV0p2SxukTllW1r3
         dlChkPFQTPF2O4CyGhsN8fdKId66k7mbDnthzIZl/wFBydOvdj9CUSswhk05vs43aPI3
         6MbQMdQm4ph9hi+THSOfqETqD9h5IZMCz4AQysb3PGjS3xHF36TSaTyKPvbCrQA76ipY
         03XNYUfz4XAR4ubXaz1I211b1UZWN7+iC26CxTmp9XvZYsPZxzg9xfLcb/NSr2Ui1qyg
         in4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU66pV3thDPdC26eaOb27qnzlLR2FWVox82N0CzJfSg=;
        b=f3urhGUx7hcdf1q1kgfofIdoFbiNh+2q5hEzszStvQ7RgOJJR1dFn8RL5Nmwmz3A1q
         amuA3YUqBA8l7xjk167b6mp4HYNPfRaAkH2fDJu/FZUmi25CStlw30R3VSZ9RKkQpvOL
         0Mna6cz2V5eW5vpCvF+/3Vb1j2N6B4XnNDKmwdP8LNaU965J8YEmyRI6z7aIJjtnty/u
         I6dalmjzhKvSgkx3pedFH7m2/qaN3eLj6yWsjcHpzCGeh9xKxGOYP3p9oydELV+tAUjg
         4AIOYjP6SWTu81nxu2wZN0ispEd1Xh6H6a1w8t12Qv9q5/pH70Zj+WuqnuqBh7sKZUln
         aG6w==
X-Gm-Message-State: AOAM5319dC0PbLo6PAdY1SjoS93cFcFQ8ymAk/WCiRGNcl5UBwDU+l+b
        q/F/udMxzgr4CY4NeAJhzOo=
X-Google-Smtp-Source: ABdhPJywoHgWUzuR1qqWW24UII9tVtEqcmzNwgWo5GmWuIRbdFmztqayYXi4y/8cKGud3m8hAqcQCQ==
X-Received: by 2002:a5e:a604:: with SMTP id q4mr18771953ioi.178.1621904861481;
        Mon, 24 May 2021 18:07:41 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: imx8mn: Add power domain and more peripherals
Date:   Mon, 24 May 2021 20:07:27 -0500
Message-Id: <20210525010732.115562-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has a similar power domain controller to that of the
i.MX8M Mini, but it's different enough to require some changes to
both the device tree bindings and to the power domain registers.

This series enables the power domains which don't require blk-ctl
and a few peripherals that also do not require blk-ctl.

V2:  Rebase on Shawn Guo's 5.14 for-next repo where the PGC for
     i.MX8M is alreay appled.

Adam Ford (5):
  dt-bindings: add defines for i.MX8MN power domains
  soc: imx: gpcv2: add support for i.MX8MN power domains
  arm64: dts: imx8mn: add GPC node and power domains
  arm64: dts: imx8mn: Add power-domain reference in USB controller
  arm64: dts: imx8mn: Add GPU node

 .../bindings/power/fsl,imx-gpcv2.yaml         |  1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 62 +++++++++++++
 drivers/soc/imx/gpcv2.c                       | 93 +++++++++++++++++++
 include/dt-bindings/power/imx8mn-power.h      | 15 +++
 4 files changed, 171 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8mn-power.h

-- 
2.25.1

