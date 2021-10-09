Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FD427BEB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJIQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJIQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F8C061570;
        Sat,  9 Oct 2021 09:27:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 5so14411897iov.9;
        Sat, 09 Oct 2021 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KombIHVlZOMP4XadihU884YzUUN1SHaapvqwBZQ2iuQ=;
        b=ByB5eoTxH/tkVBwz2uDnfVnft/IyHvcvOW/ps4hLSx0o8/8sluexO6eMreCD9JTZqg
         3RBL5FQbpvM4/gQEB8qm63TOhYSjn1whHgig1jklRBbOYh0RMCG+/h2Tih8UuO094IO5
         RSCKy7ZwjhHakDacE5WnLtmdHyfziSSzU2FaQ+crJy2faLUlOvj5TMTSljAbkSl2r+pM
         Y4mQYoumWWcwBTX040k0Xlm6fgUIis7bEcDcVtKGwwN+C5v6zjf9/9qAdGtb4H38X5sx
         yp+EPWuhT6Sfa0WbP4RGLRU05YAqLqLBF5AUgD+N8eGLE1FCiRgESCkLa1G/wy4MRBqZ
         7+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KombIHVlZOMP4XadihU884YzUUN1SHaapvqwBZQ2iuQ=;
        b=GBrxSqJrQHWkpkNp82eWgaMEwMflb7bjXaVvxwjezVRGE+jZdb1tMYBkkUgQJ+inni
         4QGlHsryEk5iBXzC951TYdflYrQdeyC8MUiPAxTW2gBvrUttnkmXWnq+yCaC9YuHh8ll
         jYy9bo1N3JNdKFx31HURawsZxEP8vVOjL3L0v1C1pRxhrE8tkCFiPCbiOwwUPX9JCvuu
         2VgZID+n+QP8VETYySuYLXA/4dPZKgMg8VtoHq+pZJAEq+PW1NSUrcCSwB6O1uQ9MTXF
         6/BVVCU5E9GOe/Zve+DFKM9SAKFhPJ0LhMdIX+wc3EqEmuyrCFipgIPTkByGeZ/Mim1Q
         WKOg==
X-Gm-Message-State: AOAM531dXWL6JSp2hfal8go/zIYUHNHw7/MVf36BGwO9rHPQEI6+SVc1
        zP1ZjCS0NPlce6k9YBWyebM=
X-Google-Smtp-Source: ABdhPJzov8/HyYhOWD1DIHnHRVUJx8QleE10QE88ovOQKWA9xnPgr3c/V1DC6Xr16UOhryMFUqFdog==
X-Received: by 2002:a05:6602:1644:: with SMTP id y4mr11727199iow.82.1633796838296;
        Sat, 09 Oct 2021 09:27:18 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:17 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/9] arm64: imx8mn: Enable additional power domains and peripherals
Date:   Sat,  9 Oct 2021 11:26:50 -0500
Message-Id: <20211009162700.1452857-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blk-ctrl and the GPCv2 in the i.MX8MN is similar but slightly different to that
of the i.MX8MM.  This series is based on work from Lucas Stach for i.MX8MM, but
adapted for i.MX8MN.  With the additional power domains and blk-ctrl enabled,
additional peripherals like gpu and USB can be enabled.

V2:  Add mising patches for expanding GPCv2 which are necessary
       to make the blk-ctl operate.
     Fix clk names
     Fix missing references to structures in blk-ctl driver to link
       them to the device tree.

Adam Ford (9):
  soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
  soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
  dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
  arm64: dts: imx8mn: add GPC node
  arm64: dts: imx8mn: put USB controller into power-domains
  arm64: dts: imx8mn: add DISP blk-ctrl
  arm64: dts: imx8mn: Enable GPU

 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
 drivers/soc/imx/gpcv2.c                       |  26 +++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  75 ++++++++++++-
 include/dt-bindings/power/imx8mn-power.h      |   5 +
 5 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml

-- 
2.25.1

